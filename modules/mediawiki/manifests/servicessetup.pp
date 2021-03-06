# MediaWiki services setup
class mediawiki::servicessetup {
    include nodejs

    git::clone { 'mathoid':
        ensure    => present,
        directory => '/srv/mathoid',
        origin    => 'https://github.com/wikimedia/mathoid.git',
        branch    => 'master',
        owner     => 'root',
        group     => 'root',
        mode      => '0755',
    }

    exec { 'mathoid_npm':
        command     => 'sudo -u root npm install',
        creates     => '/srv/mathoid/node_modules',
        cwd         => '/srv/mathoid',
        path        => '/usr/bin',
        environment => 'HOME=/srv/mathoid',
        user        => 'root',
        require     => [Git::Clone['mathoid'], Class['nodejs'], Package['librsvg2-dev']],
    }

    file { '/etc/mathoid':
        ensure  => directory,
    }

    file { '/etc/mathoid/config.yaml':
        ensure  => present,
        source  => 'puppet:///modules/mediawiki/config.yaml',
        require => File['/etc/mathoid'],
    }

    git::clone { '3d2png':
        ensure    => present,
        directory => '/srv/3d2png',
        origin    => 'https://github.com/wikimedia/3d2png.git',
        branch    => 'master',
        owner     => 'root',
        group     => 'root',
        mode      => '0755',
    }

    exec { '3d2png_npm':
        command     => 'sudo -u root npm install',
        creates     => '/srv/3d2png/node_modules',
        cwd         => '/srv/3d2png',
        path        => '/usr/bin',
        environment => 'HOME=/srv/3d2png',
        user        => 'root',
        require     => [Git::Clone['3d2png'], Package['nodejs'], Package['libjpeg-dev']],
    }
}
