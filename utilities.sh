function is_raspbian
{
    if [[ "$(uname)" != "Linux" ]] || [[ ! -x /usr/bin/lsb_release ]]
    then
        return 1
    fi

    lsb_release -a 2>/dev/null | grep 'Raspbian' >/dev/null 2>&1
    ec=$?
    if [[ $ec -ne 0 ]]
    then
        return 2
    fi

    return 0
}

function is_osx
{
    if [[ "$(uname)" != 'Darwin' ]]
    then
        return 1
    fi

    return 0
}

function os_type
{
    if is_raspbian
    then
        echo 'raspbian'
    elif is_osx
    then
        echo 'osx'
    else
        echo 'other'
    fi
}

function script_dir
{
    echo "$( cd "$( dirname "${BASH_SOURCE[1]}" )" && pwd )"
}
