#!/bin/bash
#
# bash completion support for symfony2 console
#
# Copyright (C) 2011 Matthieu Bontemps <matthieu@knplabs.com>
# Distributed under the GNU General Public License, version 2.0.

_complete_sf2_app_console()
{
    local cur prev script
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    script="${COMP_WORDS[0]}"

    if [[ ${cur} == -* ]] ; then
        PHP=$(cat <<'HEREDOC'
array_shift($argv);
$script = array_shift($argv);
$command = '';
foreach ($argv as $v) {
    if (0 !== strpos($v, '-')) {
        $command = $v;
        break;
    }
}

$xmlHelp = shell_exec($script.' help --xml '.$command);
$options = array();
if (!$xml = @simplexml_load_string($xmlHelp)) {
    exit(0);
}
foreach ($xml->xpath('/command/options/option') as $option) {
    $options[] = (string) $option['name'];
}

echo implode(' ', $options);
HEREDOC
)

        args=$(printf "%s " "${COMP_WORDS[@]}")
        options=$($(which php) -r "$PHP" ${args});
        COMPREPLY=($(compgen -W "${options}" -- ${cur}))

        return 0
    fi

    commands=$(${script} list --raw | sed -E 's/(([^ ]+ )).*/\1/')
    COMPREPLY=($(compgen -W "${commands}" -- ${cur}))

    return 0;
}

COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

complete -F _complete_sf2_app_console bin/console
complete -F _complete_sf2_app_console bin/clickout-console
complete -F _complete_sf2_app_console cmp
complete -F _complete_sf2_app_console composer.phar
