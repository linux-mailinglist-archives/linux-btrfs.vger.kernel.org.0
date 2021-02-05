Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2CA3101B7
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 01:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhBEAkL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 19:40:11 -0500
Received: from mout.gmx.net ([212.227.17.22]:60709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231897AbhBEAkK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Feb 2021 19:40:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612485518;
        bh=MG6Gj6Ykf36l5VAU97lnfq5obmc4sjD458r5gCS3mrA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SsW9GGb+IC6Qtzk+9RjtKjmlZyxw4NgKLwB0Amhzqu+AuiaxIwNVAOOj2Q1Q0maWz
         AvzTlh6DKZBlNQ7iXnDEkSRWabOXZKjdfYlg6J//D+z3RRjmM6FHRdFJrvNCED0qdt
         jRiKfyyJGfQ5we4nH1dnMGP+2ebwDg75n/UOzh3M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MN5eX-1lOfbU2bBN-00J6D1; Fri, 05
 Feb 2021 01:38:38 +0100
Subject: Re: btrfs becomes read only on removal of folders
To:     "miguel@rozsas.eng.br" <miguel@rozsas.eng.br>,
        linux-btrfs@vger.kernel.org
References: <CAP5D+waHS3rMdcYdv_++X8n8wgLjm3cC2=Tv34ZPzi=Ku4Ozog@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6c497f0c-dd37-8982-4648-91100d3a443f@gmx.com>
Date:   Fri, 5 Feb 2021 08:38:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAP5D+waHS3rMdcYdv_++X8n8wgLjm3cC2=Tv34ZPzi=Ku4Ozog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lictH6N0WTQukQBFhx66/3OPAy00Xu0UV0LTui0oJRFi4Od6UVp
 Vxc29SKjKDlFgViO/5d1rEfRiI1wjzCk6S9PI2airN9TNiGhoHOW2MMtlWwPwIi7GBHNXSn
 quNrPM38uBZomjprGY6AFko6kyp6iOnaA9qUiurcTWMtFz1kM0SxLvgTdpy+gmnOrFy9l+d
 ljwvZa1MAMSiMHe8ly3GA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4spAaJGG7Qs=:pd5yKaPwLap/ecaAjxvCSo
 2Bgm/oapiSR+KcI6gnzndroeuITwiwrrNJ5gtf5rae6u0CGB+6Hjont5iwkhtc1fa3zhjQW6q
 P3X1H6X89TZJ/NNOf3ujEeBM+T61eIkMJvNhky2Mpky6NJp+DlFJrGE/FGRqgGSkWtrSki92j
 IM5P3cdA0pjU7sfiYWlJD8rPULgi3jiNvmJWSwFOd3YvkO809VkKNilM4H5s9V8eawdmtUmU6
 gPDAnzLzpRx41M+7JzHDPtAIU2gofmtABEh0eBQRHMNOsDvK45iruNzvqNXLnZTnNqmybLi3T
 kN0tfT0uqCwIkTSO75RbU3A2PRdd+zeszxgcc74629EoMGriaNMV0E63mGWGo52bdxqakOoCc
 ACI1IRhRvS5C8/X83wOpbJKbLKfBMnnSf8KFFbllc0F4coMTf1/jmQajUtwiYXuwjfS3hq8S+
 2qavphuDrT97rSbzALJSV7k5Iu5cIwTXAx/hnFu7W1Uckc0wfk4tzj+YE4DdPOOeg8itje0rz
 MAA1E1wGoaV6K5evtsf49WNf4jAbSfGQLJTDiyBZPOSi9xZ4zK7schSIInmWSFeEfF2MgYeE6
 0ylJyApbHv6/R1rg2don/x76peW7nFeqXbBA2jDejb1BQB4oWNicOLBlfKcoq+OwXRmKMs9CT
 6mi8uQWueCzN1yASvK1JXfAIDIXQdJPJkJepesBc8ENNKEPuLEq3cHVdcQsQxSRFCL8eLpMBR
 /dOEeyLEv41PMZx79PYdbjntLhvjCeiPzoWOzAt3H95X/6h2lXxA0perfKJ1OdhNpfDjokrkU
 ZF+j0nWSp7XsmAcWuCHgIQtRADrkEfDJrY6ON0f+hr2zFGuqvVyApWKzG/Wxn12TBEpsj3hse
 DYrmM51mu0IFjDGfABmA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/4 =E4=B8=8B=E5=8D=887:02, miguel@rozsas.eng.br wrote:
> Hi there,
>
> I am using opensuse tumbleweed on a desktop.
> More than 1 year ago, I setup a rotating disk to use btrfs and things
> went nice until yesterday.
> I was done with Civ VI on steam, and decided to remove the associated fi=
les.
> I've started to remove files and I got the message the file system is re=
ad-only.
>
> kimera:~ # findmnt --real -l | grep /mnt/btrfs
> /mnt/btrfs                /dev/sdc2                           btrfs
> rw,relatime,space_cache,subvolid=3D5,subvol=3D/
>
> kimera:~ # cd /mnt/btrfs/miguel/Steam/
> kimera:/mnt/btrfs/miguel/Steam # \ls
> GameOverlayRenderer64.dll    bin_steamdeps.py
> fossilize_engine_filters.json  linux64   servers
> steam_subscriber_agreement.txt  tenfoot
> ThirdPartyLegalNotices.css   bootstrap.tar.xz  friends
>         logs      skins                    steamapps
>     ubuntu12_32
> ThirdPartyLegalNotices.doc   clientui          graphics
>         music     ssfn9115004176610272489  steamchina
>     ubuntu12_64
> ThirdPartyLegalNotices.html  config
> installscriptevalutor_log.txt  package   steam
> steamclient.dll                 update_hosts_cached.vdf
> appcache                     controller_base   legacycompat
>         public    steam.sh                 steamclient64.dll
>     userdata
> bin                          depotcache        linux32
>         resource  steam_msg.sh             steamui
> kimera:/mnt/btrfs/miguel/Steam #
>
> kimera:/mnt/btrfs/miguel/Steam # rm -rf appcache bin clientui controller=
_base
> rm: cannot remove
> 'appcache/httpcache/00/00d317630ee7d0825dc6a4cd5ce9f91f50e6993c_da39a3ee=
5e6b4b0d3255bfef95601890afd80709':
> Read-only file system
> rm: cannot remove
> 'appcache/httpcache/01/01edefade28afe779bad14a9d5ff954b0f4c4e60_da39a3ee=
5e6b4b0d3255bfef95601890afd80709':
> Read-only file system
> rm: cannot remove
> 'appcache/httpcache/01/0116c6a41aee246e028415352052bd79d323fc1f_da39a3ee=
5e6b4b0d3255bfef95601890afd80709':
> Read-only file system
> ...
> rm: cannot remove 'controller_base/bigpicture_mouseon.vdf': Read-only
> file system
> rm: cannot remove 'controller_base/gamepad_generic.vdf': Read-only file =
system
> rm: cannot remove 'controller_base/basicui_gamepad.vdf': Read-only file =
system
> rm: cannot remove 'controller_base/basicui_neptune.vdf': Read-only file =
system
> rm: cannot remove 'controller_base/basicui.vdf': Read-only file system
> kimera:/mnt/btrfs/miguel/Steam #
>
> The associated kernel messages can be read here:  https://susepaste.org/=
80272017

Nothing useful here from that dmesg. It's just booting and no btrfs
specific thing.

>
> The current usage is:
> kimera:~ # btrfs filesystem usage -T /mnt/btrfs
> Overall:
>      Device size:                   2.37TiB
>      Device allocated:            348.06GiB
>      Device unallocated:            2.03TiB
>      Device missing:                  0.00B
>      Used:                        287.07GiB
>      Free (estimated):              2.09TiB      (min: 1.08TiB)
>      Data ratio:                       1.00
>      Metadata ratio:                   2.00
>      Global reserve:              349.28MiB      (used: 0.00B)
>      Multiple profiles:                  no
>
>               Data      Metadata  System
> Id Path      single    RAID1     RAID1    Unallocated
> -- --------- --------- --------- -------- -----------
>   1 /dev/sdc2 346.00GiB   1.00GiB 32.00MiB     1.16TiB
>   2 /dev/sdc1         -   1.00GiB 32.00MiB   898.97GiB
> -- --------- --------- --------- -------- -----------
>     Total     346.00GiB   1.00GiB 32.00MiB     2.03TiB
>     Used      286.15GiB 470.45MiB 64.00KiB
> kimera:~ #
>
> Then I ran btrfs scrub (btrfs scrub start /mnt/btrfs) and got the
> following kernel messages during the scrub:
> https://susepaste.org/51166386

This is the real thing. You have a lot of metadata corrupted:

Feb 02 13:43:51 kimera.rozsas.eng.br kernel: BTRFS warning (device
sdc2): checksum/header error at logical 557849608192 on dev /dev/sdc1,
physical 514686976: metadata leaf (level 0) in tree 7

This means your csum tree is corrupted.


Feb 02 13:46:11 kimera.rozsas.eng.br kernel: BTRFS error (device sdc2):
parent transid verify failed on 557851131904 wanted 86067 found 76934

This means some of your metadata write didn't reach disk, and metadata
COW is broken, causing metadata corruption.

I'd recommend to just mount RO and copy as many data as you can.

Thanks,
Qu

>
> And scrub ended with the status:
> kimera:/mnt/btrfs/miguel/Steam # btrfs scrub status /mnt/btrfs
> UUID:             af3bd7fe-5796-4248-9917-3e71a5a56ec6
> Scrub started:    Tue Feb  2 13:43:34 2021
> Status:           aborted
> Duration:         0:02:37
> Total to scrub:   287.07GiB
> Rate:             106.22MiB/s
> Error summary:    verify=3D79 csum=3D5
>   Corrected:      7
>   Uncorrectable:  77
>   Unverified:     0
>
> So, what is going here ?
> How can I fix this FS ?
>
> Sorry to not know so much about how to fix a btrfs, it is my first
> experience with btrfs since I migrated from Ubuntu to openSuSE more
> than 1 year ago.
>
> my system:
> Operating System: openSUSE Tumbleweed 20210121
> KDE Plasma Version: 5.20.5
> KDE Frameworks Version: 5.78.0
> Qt Version: 5.15.2
> Kernel Version: 5.10.7-1-default
> OS Type: 64-bit
> Processors: 8 =C3=97 Intel=C2=AE Core=E2=84=A2 i7-3770 CPU @ 3.40GHz
> Memory: 14.6 GiB of RAM
> Graphics Processor: GeForce GTX 970/PCIe/SSE2
>
