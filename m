Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157053CBF90
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jul 2021 01:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhGPXJf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 19:09:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:55821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231630AbhGPXJf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 19:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626476797;
        bh=zBbGJxfIwj6V2HUWdindowr92NOFqJ9AzDwsnhyfNI0=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=hC3+6zWyNjNI3JasNVJRRgd//Gh22ZfIbn9bWjfo+TjmQvX1D1gtvsQLXa6myZWL2
         oVPtF9cTep4lklfxkwJyP3xtIw61b7UNmzkE7V3bDW1eag4xH9sB6SaKazgE1rHuZ/
         EJezeXBdQKJkXsbHEQaMwDFeMul3ZJcZaH5C4JrE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwQXN-1lFJpx1QxR-00sKGT; Sat, 17
 Jul 2021 01:06:36 +0200
To:     Dave T <davestechshop@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGdWbB6qxBtVc1XtSF_wOR3NyR9nGpr5_Nc5RCLGT5NK=C4iRA@mail.gmail.com>
 <3be8bba9-60cd-2cce-a05d-6c24b8895f3f@gmx.com>
 <CAGdWbB44nH7dgdP3qO_bFYZwbkrW37OwFEVTE2Bn+rn4d7zWiQ@mail.gmail.com>
 <43e7dc04-c862-fff1-45af-fd779206d71c@gmx.com>
 <CAGdWbB7Q98tSbPgHUBF+yjqYRBPZ-a42hd=xLwMZUMO46gfd0A@mail.gmail.com>
 <CAGdWbB47rKnLoSBZ7Ez+inkeKRgE+SbOAp5QEpB=VWfM_5AmRA@mail.gmail.com>
 <520a696d-d747-ef86-4560-0ec25897e0e1@suse.com>
 <CAGdWbB6CrFc319fwRwmkd=zrVE4jabF0GTpqZd5Jjzx2RcAo9Q@mail.gmail.com>
 <e4cc8998-fc9e-4ef3-3a49-0f6d98960a75@gmx.com>
 <CAGdWbB6Y0p3dc6+00eTnf1XSS1rUMbPUckQabi6VJQXdjRt2jg@mail.gmail.com>
 <88005f9b-d596-f2f9-21f0-97fc7be4c662@gmx.com>
 <CAGdWbB59w+5=3AoKU0uRHHkA1zeya0cRhqRn8sDYpea+hZOunA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: bad file extent, some csum missing - how to check that restored
 volumes are error-free?
Message-ID: <e42fcd8e-23d4-ee98-aab6-2210e408ad3f@gmx.com>
Date:   Sat, 17 Jul 2021 07:06:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAGdWbB59w+5=3AoKU0uRHHkA1zeya0cRhqRn8sDYpea+hZOunA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Kpl8ehJCVgceEr0/FlZ7K5TPXR7wq1WXWBQ88goQiCGF/j6erp
 8tc2HsVTTkbWixf1ALvwbFAk+cOXjR+yaBWzfjx0fk8WZo5wSvmQwLVAtxvgf99d5Dret+a
 SOeJfIa66/czD0w0MLkIopWpQAJCaGCyovLhCvXGjINLIlmGHvjhOkZJWXGVjdGK0nGqFmP
 fLHTIJmWx4CVWhOxfOylg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T1Ru5g8yQ6A=:7fq/BFyQ0QoPzw2/FT58t1
 /YpCyJnncERyo6eq468vaZqB2/QQf4fPEbuw7ujNUGlI6zFzQy5NnpW90c/qcY2oqAorRcu72
 Y1weGlHOmf6QwQZ9Fx9IwSrg462ailnZuqciqdFWwhdpCedTY/paNNEe0NUHC6TwOsY9BiTC2
 r9fRfQ6tBQKZ6dgU5rUN6V4kTm8yFl8qjPte9BM/mLMPv9yE1NdsJf8fSbZqOtXIvUQ3+BylR
 ITHLPTdM0LZVAdFVWHFMjQAbbZdMdTa7rKon1eKTbLzd1nt02dXWYiuEWjc3c/gRKzUWoifIi
 EHTeL1fyGr45Jp217EznzuFfnWb0ykaiq+oXi7wXXgA68ln/ycXfosUhC/B8meJvdbaHuSeTX
 JR+6sy6TaT2K6Li5oGa75P6C0ZJtaqj7eHBTHuHdLo1lKiYjUZD8gQrLSPubKGb4v9LOXfme2
 TXm+VBeKOWl/gdP9+LuvMf1drhvAbGfDyui72fMTybuNTH3bQlEpn2NGQjFaHnaUwycPjFO8B
 WKgomRok0mGXwNbQ9jFJqlEMHhlUihog1QwiwKhCJcRzcz2tewHkhSxOoB5WP1uS34WKbsf/+
 SJuu0e99M0iVtA+v3TIv4RdrO7Aq0TiGqw8X5qkBjBLh9AvA17fDMn06l9PkvmmxDTpx2VdAb
 qVOIc0SqJ16ZTCTdNi5fVXock4l/ppbAy47i8Qo1YcCbKdmm+CSTUD7OU6kdql9R2o744xR+s
 ysYsYu35tYI849L3zU0dQXPd0qCX18xhQZL03MnwPcuq/k9Bybi0MnQu5ep/dEHdXxncc61sg
 Cv/t+ixIw/2s7BO7lEGc2LO+XtYOOMZ+I7o+XTMnDBFoICq5HvWSQ335jhD/QPBuQxDsWWXWj
 GIQooczs9UJFU8Z0N3NMjEyQsqq/3C98hbI92Q6HzAO7XX4MhV0BctvRpnuyghiUHuoR2AiBw
 MvPmmy7AF+vHa1UAb1InncJt5FK4CqKlx3j2leJ3HoMb8ADwa/fhlRFOvKVtEX2Gg5x9b+FCm
 nBtHLIi3mgo4tDwcrJh7rnYD+tzYV0J8ZK7hqQcSeTFi1yjIPO1W09fSPlLO4qk7LaO8YiEF7
 PNdqmMKSE8xxCtDyyCrRkpAofCv5A1BoD0wZ5B7FdA5TMOzsAznM3TPsQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/16 =E4=B8=8B=E5=8D=8811:40, Dave T wrote:
> On Fri, Jul 16, 2021 at 9:28 AM Qu Wenruo <quwenruo.btrfs@gmx.com>
>>> I can do more testing and let you know. Can you suggest any tests you
>>> would like me to try?
>>
>> 1. Try to read the affected file:
>>
>> - Mount the btrfs
>>
>> - Read inode 262 in root 329 (just one example)
>>     You can use "find -inum 262" inside root 329 to locate the file.
>>
>
> I have reconnected and mounted the affected SSD.
> Most of the csum errors reported are for root 334 like this:
>
> root 334 inode 184115 errors 1040, bad file extent, some csum missing
> root 334 inode 184116 errors 1040, bad file extent, some csum missing
> There are hundreds of similar error lines.
>
> There were only a few for root 329 and one for 330.
>
> What is the method to map root 334, for example, to a file system
> path? Is it like this?
>
> # btrfs su li /
> ID 257 gen 1106448 top level 5 path @root
> ...
> ID 329 gen 1105905 top level 326 path @home/live/snapshot/user1/.cache
> ID 330 gen 1105905 top level 326 path @home/live/snapshot/user2/.cache
> ID 331 gen 1105905 top level 326 path @home/live/snapshot/user3/.cache
> ID 332 gen 1105905 top level 326 path @home/live/snapshot/user4.cache
> ID 333 gen 1105905 top level 326 path @home/live/snapshot/user5/.cache
> ID 334 gen 1105905 top level 326 path @home/live/snapshot/user6/.cache
>
> # cd /home/user6/.cache
> # find . -inum 184116
> ./mozilla/firefox/profile1/cache2/entries/3E5DF2A295E7D36F537DFDC221EBD6=
153F46DC30
>
> Did I do that correctly?

Yes, you're doing it correctly.

>
> # less ./mozilla/firefox/profile1/cache2/entries/3E5DF2A295E7D36F537DFDC=
221EBD6153F46DC30
> "./mozilla/firefox/profile1/cache2/entries/3E5DF2A295E7D36F537DFDC221EBD=
6153F46DC30"
> may be a binary file.  See it anyway?
>
> I viewed it and there are no errors in terminal or systemd journal
> when reading it.
>
> Next I tested every reported inode in root 334 (assuming I identified
> the root correctly) using this method:
>
> find /home/user6/.cache/ -inum 184874 -exec bash -c 'cp "{}" /tmp ;
> out=3D$(basename "{}"); rm /tmp/$out' \;
>
> I got a list of every inode number (e.g., 184874) from the output of
> my prior checks and looped through them all. No errors were reported.
>
> I do not see any related errors in dmesg either.


That's the expected behavior.

So the original problem of failed to read is another problem.
>
> # dmesg | grep -i btrfs
> [  +0.032192] Btrfs loaded, crc32c=3Dcrc32c-intel, zoned=3Dyes
> [  +0.000546] BTRFS: device label top_level devid 1 transid 1106559
> /dev/dm-0 scanned by systemd-udevd (120)
> [  +0.029879] BTRFS info (device dm-0): disk space caching is enabled
> [  +0.000003] BTRFS info (device dm-0): has skinny extents
> [  +0.096620] BTRFS info (device dm-0): enabling ssd optimizations
> [  +0.002567] BTRFS info (device dm-0): enabling auto defrag
> [  +0.000005] BTRFS info (device dm-0): use lzo compression, level 0
> [  +0.000005] BTRFS info (device dm-0): disk space caching is enabled
> [  +0.044004] BTRFS info (device dm-0): devid 1 device path
> /dev/mapper/root changed to /dev/dm-0 scanned by systemd-udevd (275)
> [  +0.000829] BTRFS info (device dm-0): devid 1 device path /dev/dm-0
> changed to /dev/mapper/root scanned by system
>
> The only other FS-related messages in dmesg are:
>
> [  +0.142425] FS-Cache: Netfs 'nfs' registered for caching
> [  +0.018228] Key type dns_resolver registered
> [  +0.194893] NFS: Registering the id_resolver key type
> [  +0.000016] Key type id_resolver registered
> [  +0.000001] Key type id_legacy registered
> [  +0.022450] FS-Cache: Duplicate cookie detected
>
> If I have done that correctly, it raises some interesting questions.
> First, I started using a btrfs subvolume for user .cache directories
> in late 2018. I do this:
>
> users_list=3D"user1 user2 user3 ... userN"
> for uu in $users_list; do \
>    btrfs su cr $destination/@home/live/snapshot/${uu}/.cache
>      chattr +C $destination/@home/live/snapshot/${uu}/.cache
>      chown ${uu}:${uu} $destination/@home/live/snapshot/${uu}/.cache
> done
>
> The reason is to not include the cache contents in snapshots & backups.
>
> The user6 user has apparently not logged into this particular device
> since May 15, 2019. (It is now used primarily by someone else.) The
> files in /home/user6/.cache appear to all have dates equal or prior to
> May 15, 2019, but no older than Feb 3, 2019. The vast majority of the
> reported errors were in these files. However, I do not see errors when
> accessing those files now.

So far so good, every thing is working as expected.

Just the btrfs-check is a little paranoid.

BTW, despite the bad file extent and csum missing error, is there any
other error reported from btrfs check?

>
>> - Find a way to reproduce the read-only fs problem
>
> This happened when I was using btrbk to send|receive snapshots to a
> target via ssh. I do not think it is a coincidence that I was doing a
> btrfs operation at the time this happened.
>
> I did the same btrbk operation on another device (a ThinkPad T450
> laptop) that has been running Arch Linux and BTRFS since many years
> ago (probably around 2015). However, the btrbk operation succeeded
> with no errors.
>
> Here is exactly what I did when the read-only problem first happened:
>
> # btrbk dryrun
> ------------------------------------------------------------------------=
--------
> Backup Summary (btrbk command line client, version 0.31.2)
>
>      Date:   Tue Jul 13 23:11:32 2021
>      Config: /etc/btrbk/btrbk.conf
>      Dryrun: YES
>
> Legend:
>      =3D=3D=3D  up-to-date subvolume (source snapshot)
>      +++  created subvolume (source snapshot)
>      ---  deleted subvolume
>      ***  received subvolume (non-incremental)
>      >>>  received subvolume (incremental)
> ------------------------------------------------------------------------=
--------
> /mnt/top_level/@root/live/snapshot
> +++ /mnt/top_level/@root/_btrbk_snap/root.20210713T231132-0400
> *** backupsrv:/backup/clnt/laptop2/@root/root.20210713T231132-0400
>
> /mnt/top_level/@home/live/snapshot
> +++ /mnt/top_level/@home/_btrbk_snap/home.20210713T231132-0400
> *** backupsrv:/backup/clnt/laptop2/@home/home.20210713T231132-0400
>
> /mnt/top_level/@logs/live/snapshot
> +++ /mnt/top_level/@logs/_btrbk_snap/vlog.20210713T231132-0400
> *** backupsrv:/backup/clnt/laptop2/@log/vlog.20210713T231132-0400
>
> NOTE: Dryrun was active, none of the operations above were actually exec=
uted!
>
> # systemctl disable --now snapper-timeline.timer
>
> # systemctl enable --now btrbk.timer
> Created symlink /etc/systemd/system/timers.target.wants/btrbk.timer =E2=
=86=92
> /usr/lib/systemd/system/btrbk.timer.
>
> # systemctl list-timers --all
> NEXT                        LEFT        LAST
> PASSED        UNIT                         ACTIVATES
> Wed 2021-07-14 00:00:00 EDT 47min left  n/a
> n/a           btrbk.timer                  btrbk.service
> Wed 2021-07-14 00:00:00 EDT 47min left  Tue 2021-07-13 09:05:48 EDT
> 14h ago       logrotate.timer              logrotate.service
> Wed 2021-07-14 00:00:00 EDT 47min left  Tue 2021-07-13 09:05:48 EDT
> 14h ago       man-db.timer                 man-db.service
> Wed 2021-07-14 00:00:00 EDT 47min left  Tue 2021-07-13 09:05:48 EDT
> 14h ago       shadow.timer                 shadow.service
> Wed 2021-07-14 17:31:57 EDT 18h left    Tue 2021-07-13 17:31:57 EDT 5h
> 40min ago  snapper-cleanup.timer        snapper-cleanup.service
> Wed 2021-07-14 17:36:17 EDT 18h left    Tue 2021-07-13 17:36:17 EDT 5h
> 36min ago  systemd-tmpfiles-clean.timer systemd-tmpfiles-clean.service
> Mon 2021-07-19 01:11:06 EDT 5 days left Mon 2021-07-12 01:24:15 EDT 1
> day 21h ago fstrim.timer                 fstrim.service
>
> 7 timers listed.
>
> # systemctl start btrbk.service
>
> # systemctl status btrbk
> =E2=97=8B btrbk.service - btrbk backup
>       Loaded: loaded (/usr/lib/systemd/system/btrbk.service; static)
>      Drop-In: /etc/systemd/system/btrbk.service.d
>               =E2=94=94=E2=94=80override.conf
>       Active: inactive (dead) since Tue 2021-07-13 23:17:54 EDT; 20s ago
> TriggeredBy: =E2=97=8F btrbk.timer
>         Docs: man:btrbk(1)
>      Process: 6827 ExecStart=3D/usr/local/bin/btrbk_run.sh (code=3Dexite=
d,
> status=3D0/SUCCESS)
>     Main PID: 6827 (code=3Dexited, status=3D0/SUCCESS)
>          CPU: 2min 40.794s
>
> # mount /mnt/top_level/
> mount: /mnt/top_level: wrong fs type, bad option, bad superblock on
> /dev/mapper/root, missing codepage or helper program, or other error.
>
> # ls /mnt/top_level/
> total 0
> drwxr-x--x 1 root root   0 Nov  1  2017 .
> drwxr-xr-x 1 root root 116 Apr 10  2020 ..
>
> My prompt includes a timestamp like this:
>
>   !2813 [13-Jul 23:19:18] root@laptop2
> # journalctl -r
> An error was encountered while opening journal file or directory
> /var/log/journal/7db5321aaf884af786868ec2f2e9c7b0/system.journal,
> ignoring file: Input/output error
> -- Journal begins at Thu 2021-06-17 15:14:31 EDT, ends at Tue
> 2021-07-13 16:19:12 EDT. --
> Jul 13 16:19:12 laptop2 sudo[674]: pam_unix(sudo:session): session
> opened for user root(uid=3D0) by user0(uid=3D1000)
>
> As far as I can tell, the last 7 hours of the journal are missing at tha=
t point.
>
> That's exactly how the read-only problem happened. I did a btrbk
> dryrun to validate the configuration. Then I started the backup. Near
> (or at) the end of the backup for the root subvolume, the backup
> process exited, but I could not see the journal entries for it because
> they were missing and the filesystem was read-only.

It's a pity that we didn't get the dmesg of that RO event, it should
contain the most valuable info.

But at least so far your old fs is pretty fine, you can continue using it.

Thanks,
Qu

>
