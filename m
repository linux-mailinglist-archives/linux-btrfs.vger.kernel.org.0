Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE1E3CBA03
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 17:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhGPPnJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 11:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbhGPPnI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 11:43:08 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6C1C06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 08:40:12 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id h9so11364253oih.4
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E3cNaxeO2mqOs+YGY6004Ld8GQc0+vSV1j7pGYPMeXo=;
        b=ctJHmXmHG4VOWWOENJ4X7JB2yXWTiM7yWeQbmHBhep0gHPrfbDs6ep7vb1Wcz7eYL/
         B9atg4sXaZQ+C4kbt13y50SW+z/OkK1WwScUckCWsC7dniQ5oThFDFNF43O5Rmxt39vY
         yokoGEuJ2zIAOih5o0Bqlio6TtxcVzkPpDd72hxWSUDYav2M6eEiZQcH7/emuuGUIzJu
         1h3LgZv6ipvvDICaHSmLcd6+dijm7l0GxWCnxV+PEmVQq2e5HR/m83wLRO9n1j6GAZYT
         MPjzIsGKeRVXfYFjUM+u5/q/BDQ0T0R7oScKt7axTWJe8Em0CT2l+HW+E/Z7M/r+1S6F
         I3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E3cNaxeO2mqOs+YGY6004Ld8GQc0+vSV1j7pGYPMeXo=;
        b=BlitIFm7M5VYTLsQp4iflaoxlvLQ/xjSCktZ0QjZG+G5cxnTASMTB7TD6oXyoSGyu4
         kQT+xX6u+Of18qxyjdbY+HyfgSPImMLnFIWf0fYfEShaZaQFtnXgDgBlL3ruIpcOba0f
         fXOiHovvCfGwlkjFv/ssq6SxEyvDOOIW5+dkojeER8tHTaVF/hrtj4z1dkIhPqQr2i9Q
         5aolBQjL/3l3ABLIWMf5wp3/EcZheKkGEOKT7ATPDT0+wbvA8Hq49NprRVHdlGJEi5Xm
         BDI3rwc/V0NLV7zvCMiBba3FKN8bnA5DtpxvevYjAk28AFM8MZK2mkA18DA/hDIb5KY9
         SWhQ==
X-Gm-Message-State: AOAM530TfFtJfMJSDANUnTIIsfJKYS6o8SOJykek9tYx8x5NbwFgLrIj
        WaO8C8Fo15TGiTNUyKQOFcG3x3mzWPVSp8voPoo=
X-Google-Smtp-Source: ABdhPJw+mUEtd+pV4ZMSFu0sR8agNkr6DdMkTQev0hTK8mLO5ZCuBcjMX8nocTobQwnrUETiit2RX631Ph4iUhJ/4kU=
X-Received: by 2002:a54:4e95:: with SMTP id c21mr12922495oiy.137.1626450011592;
 Fri, 16 Jul 2021 08:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB6qxBtVc1XtSF_wOR3NyR9nGpr5_Nc5RCLGT5NK=C4iRA@mail.gmail.com>
 <3be8bba9-60cd-2cce-a05d-6c24b8895f3f@gmx.com> <CAGdWbB44nH7dgdP3qO_bFYZwbkrW37OwFEVTE2Bn+rn4d7zWiQ@mail.gmail.com>
 <43e7dc04-c862-fff1-45af-fd779206d71c@gmx.com> <CAGdWbB7Q98tSbPgHUBF+yjqYRBPZ-a42hd=xLwMZUMO46gfd0A@mail.gmail.com>
 <CAGdWbB47rKnLoSBZ7Ez+inkeKRgE+SbOAp5QEpB=VWfM_5AmRA@mail.gmail.com>
 <520a696d-d747-ef86-4560-0ec25897e0e1@suse.com> <CAGdWbB6CrFc319fwRwmkd=zrVE4jabF0GTpqZd5Jjzx2RcAo9Q@mail.gmail.com>
 <e4cc8998-fc9e-4ef3-3a49-0f6d98960a75@gmx.com> <CAGdWbB6Y0p3dc6+00eTnf1XSS1rUMbPUckQabi6VJQXdjRt2jg@mail.gmail.com>
 <88005f9b-d596-f2f9-21f0-97fc7be4c662@gmx.com>
In-Reply-To: <88005f9b-d596-f2f9-21f0-97fc7be4c662@gmx.com>
From:   Dave T <davestechshop@gmail.com>
Date:   Fri, 16 Jul 2021 11:40:00 -0400
Message-ID: <CAGdWbB59w+5=3AoKU0uRHHkA1zeya0cRhqRn8sDYpea+hZOunA@mail.gmail.com>
Subject: Re: bad file extent, some csum missing - how to check that restored
 volumes are error-free?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 16, 2021 at 9:28 AM Qu Wenruo <quwenruo.btrfs@gmx.com>
> > I can do more testing and let you know. Can you suggest any tests you
> > would like me to try?
>
> 1. Try to read the affected file:
>
> - Mount the btrfs
>
> - Read inode 262 in root 329 (just one example)
>    You can use "find -inum 262" inside root 329 to locate the file.
>

I have reconnected and mounted the affected SSD.
Most of the csum errors reported are for root 334 like this:

root 334 inode 184115 errors 1040, bad file extent, some csum missing
root 334 inode 184116 errors 1040, bad file extent, some csum missing
There are hundreds of similar error lines.

There were only a few for root 329 and one for 330.

What is the method to map root 334, for example, to a file system
path? Is it like this?

# btrfs su li /
ID 257 gen 1106448 top level 5 path @root
...
ID 329 gen 1105905 top level 326 path @home/live/snapshot/user1/.cache
ID 330 gen 1105905 top level 326 path @home/live/snapshot/user2/.cache
ID 331 gen 1105905 top level 326 path @home/live/snapshot/user3/.cache
ID 332 gen 1105905 top level 326 path @home/live/snapshot/user4.cache
ID 333 gen 1105905 top level 326 path @home/live/snapshot/user5/.cache
ID 334 gen 1105905 top level 326 path @home/live/snapshot/user6/.cache

# cd /home/user6/.cache
# find . -inum 184116
./mozilla/firefox/profile1/cache2/entries/3E5DF2A295E7D36F537DFDC221EBD6153=
F46DC30

Did I do that correctly?

# less ./mozilla/firefox/profile1/cache2/entries/3E5DF2A295E7D36F537DFDC221=
EBD6153F46DC30
"./mozilla/firefox/profile1/cache2/entries/3E5DF2A295E7D36F537DFDC221EBD615=
3F46DC30"
may be a binary file.  See it anyway?

I viewed it and there are no errors in terminal or systemd journal
when reading it.

Next I tested every reported inode in root 334 (assuming I identified
the root correctly) using this method:

find /home/user6/.cache/ -inum 184874 -exec bash -c 'cp "{}" /tmp ;
out=3D$(basename "{}"); rm /tmp/$out' \;

I got a list of every inode number (e.g., 184874) from the output of
my prior checks and looped through them all. No errors were reported.

I do not see any related errors in dmesg either.

# dmesg | grep -i btrfs
[  +0.032192] Btrfs loaded, crc32c=3Dcrc32c-intel, zoned=3Dyes
[  +0.000546] BTRFS: device label top_level devid 1 transid 1106559
/dev/dm-0 scanned by systemd-udevd (120)
[  +0.029879] BTRFS info (device dm-0): disk space caching is enabled
[  +0.000003] BTRFS info (device dm-0): has skinny extents
[  +0.096620] BTRFS info (device dm-0): enabling ssd optimizations
[  +0.002567] BTRFS info (device dm-0): enabling auto defrag
[  +0.000005] BTRFS info (device dm-0): use lzo compression, level 0
[  +0.000005] BTRFS info (device dm-0): disk space caching is enabled
[  +0.044004] BTRFS info (device dm-0): devid 1 device path
/dev/mapper/root changed to /dev/dm-0 scanned by systemd-udevd (275)
[  +0.000829] BTRFS info (device dm-0): devid 1 device path /dev/dm-0
changed to /dev/mapper/root scanned by system

The only other FS-related messages in dmesg are:

[  +0.142425] FS-Cache: Netfs 'nfs' registered for caching
[  +0.018228] Key type dns_resolver registered
[  +0.194893] NFS: Registering the id_resolver key type
[  +0.000016] Key type id_resolver registered
[  +0.000001] Key type id_legacy registered
[  +0.022450] FS-Cache: Duplicate cookie detected

If I have done that correctly, it raises some interesting questions.
First, I started using a btrfs subvolume for user .cache directories
in late 2018. I do this:

users_list=3D"user1 user2 user3 ... userN"
for uu in $users_list; do \
  btrfs su cr $destination/@home/live/snapshot/${uu}/.cache
    chattr +C $destination/@home/live/snapshot/${uu}/.cache
    chown ${uu}:${uu} $destination/@home/live/snapshot/${uu}/.cache
done

The reason is to not include the cache contents in snapshots & backups.

The user6 user has apparently not logged into this particular device
since May 15, 2019. (It is now used primarily by someone else.) The
files in /home/user6/.cache appear to all have dates equal or prior to
May 15, 2019, but no older than Feb 3, 2019. The vast majority of the
reported errors were in these files. However, I do not see errors when
accessing those files now.

> - Find a way to reproduce the read-only fs problem

This happened when I was using btrbk to send|receive snapshots to a
target via ssh. I do not think it is a coincidence that I was doing a
btrfs operation at the time this happened.

I did the same btrbk operation on another device (a ThinkPad T450
laptop) that has been running Arch Linux and BTRFS since many years
ago (probably around 2015). However, the btrbk operation succeeded
with no errors.

Here is exactly what I did when the read-only problem first happened:

# btrbk dryrun
---------------------------------------------------------------------------=
-----
Backup Summary (btrbk command line client, version 0.31.2)

    Date:   Tue Jul 13 23:11:32 2021
    Config: /etc/btrbk/btrbk.conf
    Dryrun: YES

Legend:
    =3D=3D=3D  up-to-date subvolume (source snapshot)
    +++  created subvolume (source snapshot)
    ---  deleted subvolume
    ***  received subvolume (non-incremental)
    >>>  received subvolume (incremental)
---------------------------------------------------------------------------=
-----
/mnt/top_level/@root/live/snapshot
+++ /mnt/top_level/@root/_btrbk_snap/root.20210713T231132-0400
*** backupsrv:/backup/clnt/laptop2/@root/root.20210713T231132-0400

/mnt/top_level/@home/live/snapshot
+++ /mnt/top_level/@home/_btrbk_snap/home.20210713T231132-0400
*** backupsrv:/backup/clnt/laptop2/@home/home.20210713T231132-0400

/mnt/top_level/@logs/live/snapshot
+++ /mnt/top_level/@logs/_btrbk_snap/vlog.20210713T231132-0400
*** backupsrv:/backup/clnt/laptop2/@log/vlog.20210713T231132-0400

NOTE: Dryrun was active, none of the operations above were actually execute=
d!

# systemctl disable --now snapper-timeline.timer

# systemctl enable --now btrbk.timer
Created symlink /etc/systemd/system/timers.target.wants/btrbk.timer =E2=86=
=92
/usr/lib/systemd/system/btrbk.timer.

# systemctl list-timers --all
NEXT                        LEFT        LAST
PASSED        UNIT                         ACTIVATES
Wed 2021-07-14 00:00:00 EDT 47min left  n/a
n/a           btrbk.timer                  btrbk.service
Wed 2021-07-14 00:00:00 EDT 47min left  Tue 2021-07-13 09:05:48 EDT
14h ago       logrotate.timer              logrotate.service
Wed 2021-07-14 00:00:00 EDT 47min left  Tue 2021-07-13 09:05:48 EDT
14h ago       man-db.timer                 man-db.service
Wed 2021-07-14 00:00:00 EDT 47min left  Tue 2021-07-13 09:05:48 EDT
14h ago       shadow.timer                 shadow.service
Wed 2021-07-14 17:31:57 EDT 18h left    Tue 2021-07-13 17:31:57 EDT 5h
40min ago  snapper-cleanup.timer        snapper-cleanup.service
Wed 2021-07-14 17:36:17 EDT 18h left    Tue 2021-07-13 17:36:17 EDT 5h
36min ago  systemd-tmpfiles-clean.timer systemd-tmpfiles-clean.service
Mon 2021-07-19 01:11:06 EDT 5 days left Mon 2021-07-12 01:24:15 EDT 1
day 21h ago fstrim.timer                 fstrim.service

7 timers listed.

# systemctl start btrbk.service

# systemctl status btrbk
=E2=97=8B btrbk.service - btrbk backup
     Loaded: loaded (/usr/lib/systemd/system/btrbk.service; static)
    Drop-In: /etc/systemd/system/btrbk.service.d
             =E2=94=94=E2=94=80override.conf
     Active: inactive (dead) since Tue 2021-07-13 23:17:54 EDT; 20s ago
TriggeredBy: =E2=97=8F btrbk.timer
       Docs: man:btrbk(1)
    Process: 6827 ExecStart=3D/usr/local/bin/btrbk_run.sh (code=3Dexited,
status=3D0/SUCCESS)
   Main PID: 6827 (code=3Dexited, status=3D0/SUCCESS)
        CPU: 2min 40.794s

# mount /mnt/top_level/
mount: /mnt/top_level: wrong fs type, bad option, bad superblock on
/dev/mapper/root, missing codepage or helper program, or other error.

# ls /mnt/top_level/
total 0
drwxr-x--x 1 root root   0 Nov  1  2017 .
drwxr-xr-x 1 root root 116 Apr 10  2020 ..

My prompt includes a timestamp like this:

 !2813 [13-Jul 23:19:18] root@laptop2
# journalctl -r
An error was encountered while opening journal file or directory
/var/log/journal/7db5321aaf884af786868ec2f2e9c7b0/system.journal,
ignoring file: Input/output error
-- Journal begins at Thu 2021-06-17 15:14:31 EDT, ends at Tue
2021-07-13 16:19:12 EDT. --
Jul 13 16:19:12 laptop2 sudo[674]: pam_unix(sudo:session): session
opened for user root(uid=3D0) by user0(uid=3D1000)

As far as I can tell, the last 7 hours of the journal are missing at that p=
oint.

That's exactly how the read-only problem happened. I did a btrbk
dryrun to validate the configuration. Then I started the backup. Near
(or at) the end of the backup for the root subvolume, the backup
process exited, but I could not see the journal entries for it because
they were missing and the filesystem was read-only.
