Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36513E7D50
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 18:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhHJQSb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 12:18:31 -0400
Received: from smtp-31.italiaonline.it ([213.209.10.31]:34561 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235499AbhHJQSV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 12:18:21 -0400
Received: from venice.bhome ([78.12.137.210])
        by smtp-31.iol.local with ESMTPA
        id DURumd4VhzHnRDURumeaGB; Tue, 10 Aug 2021 18:17:55 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1628612275; bh=w9HwVwX7clzrwdHFc092REnKIE2DgR3P99jcw3oDSl4=;
        h=From;
        b=SZWbwC+wOsdoTrI0CM17bSgeauZWkwVDCx6l/6yrZpGACcJiiMlo4W0MZwp68K/LK
         lSzHfHw1Es73qtPIJ2JWLSpb3FSwGDKHpfVer5fRsYMN8bJH07kyVRrEAhk1G0I+4B
         VAuRwqjo5eakZIHv5uk6DRN/VFq7/oKln2Q+xM4M95iv08aiNIq3gsD4NBBBX70uCA
         M3uh19iRULe8ZQM6YMPe9Xn+eLs49NArRGflXFgmjn+lYHUvt5X+p5nc9s99oviMQ8
         agzFmjHRNUiAJoDZORXVn1G+n2QcvvGxgX5BNyd+M5Wh4Q/+ggNOaKrRX+7bk9ub0l
         0NeLFgfqDzZtQ==
X-CNFS-Analysis: v=2.4 cv=L6DY/8f8 c=1 sm=1 tr=0 ts=6112a6b3 cx=a_exe
 a=VHyfYjYfg3XpWvNRQl5wtg==:117 a=VHyfYjYfg3XpWvNRQl5wtg==:17
 a=IkcTkHD0fZMA:10 a=HI98MWLLlhtVJJDuk0oA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: why is the same mount point repeatedly mounted in nested manner?
To:     Dave T <davestechshop@gmail.com>
Cc:     devel@roosoft.ltd.uk,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Phillip Susi <phill@thesusis.net>, kilobyte@angband.pl
References: <CAGdWbB59ULVxpNnq5Og0SCri+qyz_cwDLFTLr5N7iVT9gb0w1A@mail.gmail.com>
 <c906060a-9dbc-e5d1-8e85-832408249b4d@casa-di-locascio.net>
 <CAGdWbB5Z=ARmsU66k7O3Hp=RcMTr-wV5Z880FvMdqN=m3c8Epw@mail.gmail.com>
 <6f133a41-dbd6-ce42-b6aa-ae4e621ce816@libero.it>
 <CAGdWbB7KOzsWUEJWtKDfTD-hXOeh+Rhvk1iuXeRMjdqxVhA_uw@mail.gmail.com>
 <2074ef97-dbc2-d588-3000-622ffcf7e062@inwind.it>
 <CAGdWbB46hPUYHj6FTi777DL=SASVyQ9wE4_5oyFtAWBos4xa9g@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <a8ee4ee6-ce11-45d4-f793-a98921cc8405@inwind.it>
Date:   Tue, 10 Aug 2021 18:17:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB46hPUYHj6FTi777DL=SASVyQ9wE4_5oyFtAWBos4xa9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCcCqcjULd0dnhzrQMOpya+C1tGhUVFTSLn+DQdOVgkfN7TyVz1YDXsSBJpDEwxnMrNBA/zHSbvTe2AiFo4wItBcCpPkBoyXW2fBdwriCulXHXCr8lLs
 ZNk81I3PdJ6EfXUws75MMnXBwmXBmFeACyXLfOAIk+W+Z/2TsjTIsdtOOn/UoULNPadl2cgZj+I5dY2OKEkkrMol1tFMGW/NNAe3P05F02fCnI0tA0BgrOz6
 k6Z7pX2u/CHEgcxFK4ARhMO5tF+aw3gpoyMi8cT6pvSpQrFj1N8jJNtFiF+GIlR22Q9kVLerS7blQkDF871eoEJDT4vJRIiopGcU+TPS7t4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/10/21 6:03 PM, Dave T wrote:
> On Tue, Aug 10, 2021 at 11:43 AM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>>
>> On 8/9/21 10:15 PM, Dave T wrote:
>>> On Mon, Aug 9, 2021 at 3:29 PM Goffredo Baroncelli <kreijack@libero.it> wrote:
>>>>
>> [...]
>>
>>>
>>> Also, in recent days I stopped mounting and umounting /mnt/btrtop/root
>>> and just left it mounted all the time. However, when checking today, I
>>> still found a nested mount:
>>>
>>> ├─/srv/nfs/var/cache/pacman
>>> │
>>> │ └─/srv/nfs/var/cache/pacman
>>>
>>>
>>
>> Ok, so it seems that these mounts are triggered not by the mount of /mnt/btrtop/root (see below). What is the output of
>>
>> $ systemctl --reverse list-dependencies -- srv-nfs-var-cache-pacman.mount
>>
> 
> srv-nfs-var-cache-pacman.mount
> ● ├─nfs-server.service
> ● └─local-fs.target
> ●   └─sysinit.target
> ○     ├─btrbk-daily.service
> ●     ├─btrbk-daily.timer
> ○     ├─btrbk.service
> ●     ├─btrbk.timer
> ●     ├─dbus.service
> ●     ├─dbus.socket
> ●     ├─dhcpcd.service
> ●     ├─getty@tty1.service
> ●     ├─gssproxy.service
> ○     ├─keymap_ds.service
> ○     ├─logrotate.service
> ●     ├─logrotate.timer
> ○     ├─man-db.service
> ●     ├─man-db.timer
> ○     ├─nfs-utils.service
> ○     ├─users_permissions.service
> ●     ├─users_permissions.timer
> ○     ├─shadow.service
> ●     ├─shadow.timer
> ○     ├─snapper-cleanup.service
> ●     ├─snapper-cleanup.timer
> ●     ├─sshd.service
> ○     ├─sshdgenkeys.service
> ○     ├─systemd-ask-password-wall.service
> ●     ├─systemd-logind.service
> ●     ├─systemd-tmpfiles-clean.timer
> ●     ├─systemd-user-sessions.service
> ●     ├─user-runtime-dir@1000.service
> ●     ├─user@1000.service
> ●     ├─basic.target
> ○     │ ├─initrd.target
> ●     │ └─multi-user.target
> ●     │   └─graphical.target
> ○     └─rescue.target
> 
> 
> This looks interesting -- some of those dependencies are very
> unexpected to me. I look forward to your take on what this output
> indicates. I don't understand why there is a connection between
> srv-nfs-var-cache-pacman.mount and btrbk.service, for example. (I
> included btrbk.service with source listings you requested below.)

The btrbk.* units are triggered by sysinit.target. And sysinit requires local-fs.target, which in turn requires that all fstab mounts are mounted (then the link to srv-nfs-var-cache-pacman.mount).
There no is any direct connection between btrbk and srv-nfs-var-cache-pacman.mount.

What is more interesting is the dependencies between srv-nfs-var-cache-pacman.mount and nfs-server.service. I suspect (but I don't have any proof) that systemd is confused by the tuple {btrfs subvolume, bind mount, nfs dependecies}.

What happens if you restart the nfs-server ?
> 
>>
>> [...]
>>>
>>> As mentioned, I have (temporarily) stopped unmounting these volumes
>>> and I just leave them mounted all the time. The logs now look like
>>> this:
>>>
>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: mounting btrbk btrtop volumes...
>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/root] (1 of
>>> 3) was already mounted. Nothing to do.
>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/home] (2 of
>>> 3) was already mounted. Nothing to do.
>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: INFO: [/mnt/btrtop/user] (3 of
>>> 3) was already mounted. Nothing to do.
>>
>> This told another story. It seems that "btrbk" itself already try to mount the btrfs subvolume. I understood that it was the systemd unit to do that. Could you share the content of btrbk_run.sh ?
>>
> 
> # systemctl cat btrbk.service
> # /usr/lib/systemd/system/btrbk.service
> [Unit]
> Description=btrbk backup
> Documentation=man:btrbk(1)
> 
> [Service]
> Type=oneshot
> ExecStart=/usr/bin/btrbk run
> 
> # /etc/systemd/system/btrbk.service.d/override.conf
> [Service]
> ExecStart=
> ExecStart=/usr/local/bin/btrbk_run.sh
> 
> 
> # cat /usr/local/bin/btrbk_run.sh
> #!/bin/bash
> 
> /usr/local/bin/btrbk_mount
> 
> /usr/bin/btrbk --config /etc/btrbk/btrbk.conf run
> 
> # 2021-08-05 My first troubleshooting step is to disable unmounting
> these shares.
> # /usr/local/bin/btrbk-umount
> 
> 
> # cat /usr/local/bin/btrbk_mount
> #!/bin/bash
> 
> btrbk_mount() {
> 
> echo "mounting btrbk btrtop volumes..."
> 
> findmnt /mnt/btrtop/root
> if [[ $? -ne 0 ]]; then \
>    mount /mnt/btrtop/root
>    if [[ $? -ne 0 ]]; then \
>      echo "ERROR: failed to mount [/mnt/btrtop/root] (1 of 3)"
>    else
>      echo "OK: mounted [/mnt/btrtop/root] (1 of 3)"
>    fi
> else
>    echo "INFO: [/mnt/btrtop/root] (1 of 3) was already mounted. Nothing to do."
> fi
> findmnt /mnt/btrtop/home
> if [[ $? -ne 0 ]]; then \
>    mount /mnt/btrtop/home
>    if [[ $? -ne 0 ]]; then \
>      echo "ERROR: failed to mount [/mnt/btrtop/home] (2 of 3)"
>    else
>      echo "OK: mounted [/mnt/btrtop/home] (2 of 3)"
>    fi
> else
>    echo "INFO: [/mnt/btrtop/home] (2 of 3) was already mounted. Nothing to do."
> fi
> findmnt /mnt/btrtop/user
> if [[ $? -ne 0 ]]; then \
>    mount /mnt/btrtop/user
>    if [[ $? -ne 0 ]]; then \
>      echo "ERROR: failed to mount [/mnt/btrtop/user] (3 of 3)"
>    else
>      echo "OK: mounted mount [/mnt/btrtop/user] (3 of 3)"
>    fi
> else
>    echo "INFO: [/mnt/btrtop/user] (3 of 3) was already mounted. Nothing to do."
> fi
> 
> echo "Finished mounting btrbk btrtop volumes."
> 
> }
> 
> btrbk_mount
> 
> # end of file /usr/local/bin/btrbk_mount
> 
> 
>>
>>> Aug 06 03:00:14 btrbk_run.sh[3022708]: Finished mounting btrbk btrtop volumes.
>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: mounting btrbk btrtop volumes...
>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/root] (1 of
>>> 3) was already mounted. Nothing to do.
>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/home] (2 of
>>> 3) was already mounted. Nothing to do.
>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: INFO: [/mnt/btrtop/user] (3 of
>>> 3) was already mounted. Nothing to do.
>>> Aug 06 04:00:14 btrbk_run.sh[3033520]: Finished mounting btrbk btrtop volumes.
>>>
>>>>
>>>>>
>>>>> The path /var/cache/pacman is not a subvolume, but it resides on btrfs
>>>>> subvolume @btrtop/snapshot. @btrtop/snapshot is normally mounted at
>>>>> "/" but for btrfs tasks, it is also mounted at /mnt/btrtop/root. This
>>>>> additional mount operation seems to be causing these nested mounts of
>>>>> my bind mount for  /srv/nfs/var/cache/pacman .
>>>>>
>>>>> P.S. I cannot test without using systemd. (I'm not even sure I
>>>>> remember how to use a non-systemd distro anymore!)
>>>>>
>>>>
>>>>
>>>> --
>>>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>>>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>>
>>
>> --
>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
