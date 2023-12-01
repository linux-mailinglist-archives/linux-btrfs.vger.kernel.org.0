Return-Path: <linux-btrfs+bounces-471-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA49800A02
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 12:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5EAEB21253
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 11:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3DD219F0;
	Fri,  1 Dec 2023 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItenCDZ3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFD11704
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 03:46:23 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b86f3cdca0so236620b6e.3
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 03:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701431183; x=1702035983; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tp1uG2ofkyjUK94csBGy6usay3uRR6fgb0hEMFUPQNA=;
        b=ItenCDZ3TfVslDpoz22QMDr4iKF0KGAsDJYC7Z9dwhQ1naxRT7uSY7CTufzWrJvN6Z
         11/0FElyDliPqkgeVIh5WDMte90nOyw/P7wKTlP7E56QINHZIOgNXgO8Vhuq6x0AuDdb
         +PnypkfNhC9CmwHocz09XNA38V2R03nfP+8WEaYjjywCadRS6pDQ74wQQvAG9/nvldiP
         ffFc9gr9Fi/GCvdSuHqpFDM1LQTVGqJMjLkqHIZjiyCUthN2zth4GvSOF7Oy5hAHZwMm
         M06AhLZaEjd/QcxpANzIW6pJW4OTQlYdA330oPULUKHqLznq+IIKaMSo+GGEw5gZZf6W
         zafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701431183; x=1702035983;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tp1uG2ofkyjUK94csBGy6usay3uRR6fgb0hEMFUPQNA=;
        b=dqHjIvx4oPJJrXB0A62hXoPsMKrky5CnCIFjn7fiQWRkVwV2JHoPX3/tJt659Ulp6G
         mT/1klqVndT33Ds5GYaCD78QfF9OVvlkHTPvoTlMMOy6lDp/28vJMHvoSsp3aFj8WIi1
         a799YP9UXwqtWAk0oGi5KNX3Xc4Tyqm7yXBaR70GFkugLYpoAsmXbjgRXFjf6BOUFK8N
         7MA3eUL+sONRhdNFma9Gtj2CVzXMNmGwYSYyHll+H5SYgyqiPSAtfn9+9aZC59FItgEa
         0icaLbygbZdhVjR3C74qztTYHeXZmmcm011KEbfHL0OQ5yloXDO9rMKNdcKq/5nsnRg9
         9Emw==
X-Gm-Message-State: AOJu0YwXOsHgSgkpuN7kqvZJ9oAvSStWMMfTe4aja9NINyu5UDGQgFLA
	wn9x2ijs6dZDr3o2s0GxjFkFA1KXlF8=
X-Google-Smtp-Source: AGHT+IENGEvJ3tQEplYfOk/zh9JzCD0SNYt7TyYsY+bMaRNxaaoayAm3qtZlgzotN7KjEGQgtXG8yQ==
X-Received: by 2002:a05:6808:1203:b0:3a9:9bcb:8760 with SMTP id a3-20020a056808120300b003a99bcb8760mr2876690oil.39.1701431181396;
        Fri, 01 Dec 2023 03:46:21 -0800 (PST)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id fb2-20020a0568083a8200b003af6eeed9b6sm524282oib.27.2023.12.01.03.46.19
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 03:46:20 -0800 (PST)
Message-ID: <eca4d15e-3ac7-4403-ba5b-a3148eb6b443@gmail.com>
Date: Fri, 1 Dec 2023 05:46:19 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
Subject: BTRFS corruption after conversion to block group tree
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Distro: Fedora 39
kernel: 6.5.12
btrfs-progs: v6.5.1.

To put everyone at ease, the data seems mostly okay. The disk is
mountable with ro,rescue=ingorebadroots:nologreplay, and I'm pulling off
what I can.  Furthermore, there's a good chance this is the result of a
marginally-unstable overclock. However, the symptoms are very similar to
a recent report from Alexander Duscheleit [1], so there may be a deeper
problem. I can provide requested metadata dumps if it would be useful,
and I also have a few questions.

A few days ago I used btrfstune to convert two btrfs filesystems to
block-group-tree, after reading that it would reduce mount time. After
about 10 hours, while I was using Steam, the more heavily-used of the
two disks, which holds (among other things) the Steam game library,
experienced a transaction abort and went read-only.  Attempting to mount
the drive again after a reboot produces this in dmseg:

> [159873.932366] BTRFS info (device dm-1): using crc32c (crc32c-intel) checksum algorithm
> [159873.932372] BTRFS info (device dm-1): using free space tree
> [159877.771165] BTRFS error (device dm-1): level verify failed on logical 2073442516992 mirror 1 wanted 1 found 0
> [159877.777624] BTRFS error (device dm-1): level verify failed on logical 2073442516992 mirror 2 wanted 1 found 0
> [159877.777815] BTRFS error (device dm-1): failed to read block groups: -5
> [159877.783744] BTRFS error (device dm-1): open_ctree failed

An annotated excerpt from the system journal is included at the end of
this mail, and here's everything I've discovered or thought of that
might be relevant:

1. The disk in question is an https://en.wikipedia.org/wiki/ST3000DM001
   and it is LUKS-encrypted.

2. There's something extremely weird with the primary superblock. "btrfs
   inspect-internal dump-super" says that superblock 0 doesn't have the
   BLOCK_GROUP_TREE or NO_HOLES flags set, unlike superblocks 1 and 2,
   which are identical in every field except csum ("[match]", for 0, 1,
   and 2) and bytenr. The disk was supposed to have been converted to
   block-group-tree many hours before.  Furthermore, the generation
   number for SB 0 is 123887, while for 1 and 2 it is 123917. And
   "btrfs-check" fails almost completely when pointed at SB 0, with:

>     > sudo btrfs check  /dev/mapper/3tb_spinner
>     Opening filesystem to check...
>     parent transid verify failed on 2073442516992 wanted 123754 found 123917
>     parent transid verify failed on 2073442516992 wanted 123754 found 123917
>     parent transid verify failed on 2073442516992 wanted 123754 found 123917
>     Ignoring transid failure
>     ERROR: child eb corrupted: parent bytenr=806912000 item=33 parent level=2 child bytenr=2073442516992 child level=0
>     ERROR: failed to read block groups: Input/output error
>     ERROR: cannot open file system
> 
   Checking superblock 1 or 2 spits out 2 GB on stderr, and gets all
the way to:
> 
>     [4/7] checking fs roots
>     root 5 root dir 256 not found
>     root 260 root dir 256 not found
>     root 18446744073709551607 root dir 256 not found
>     ERROR: errors found in fs roots
>     using SB copy 1, bytenr 67108864
>     Opening filesystem to check...
>     Checking filesystem on /dev/mapper/3tb_spinner
>     UUID: 8cf4bcd8-76c7-4494-a2c8-2578136c0aa6
>     found 1950654984192 bytes used, error(s) found
>     total csum bytes: 1700177772
>     total tree bytes: 5770002432
>     total fs tree bytes: 3816734720
>     total extent tree bytes: 0
>     btree space waste bytes: 698646748
>     file data blocks allocated: 2145891516416
>      referenced 2495964958720

3. The problem is immediately preceded in the log by a "GpuWatchdog"
   segfault in steamwebhelper. The stack trace points into libcef, and
   users on Arch [2] and Ubuntu [3] report hangs in Chrome/Electron with
   similar log messages. I don't remember a hang, but I could've
   forgotten in all the excitement. Logs show a similar segfault
   happened twice on 2023-09-09, 20 minutes apart, under kernel 6.4.13,
   without affecting anything outside Steam.

4. I don't open Steam that frequently. This was the first and only time
   I've run steam on kernel 6.5.12. Prior to that were kernels 6.5.11
   and 6.5.5.

5. Steam is running on the Intel Haswell integrated graphics, HD 4600.

6. At the time of the failure, I had BIOS options set to overclock the
   iGPU from 1200 MHz to 1600 MHz, with voltage 1.12 V "adaptive". The
   frequency bump was inactive because the GPU doesn't clock higher than
   1200 MHz unless told to do so by writing to gt_boost_freq_mhz under
   /sys/class/drm/card*, and the systemd unit I have to do that is
   disabled. The voltage setting might have been doing something. I
   don't know what the default is, but at least on the CPU core side,
   "adaptive" voltage only affects voltage-frequency pairs in the
   "boost" side of the curve. So I *think* it should've done nothing.
   But I have reset those options to Auto/Auto out of caution.

7. At the time of the failure, and now, the CPU core and memory bus were
   also overclocked. I consider the CPU OC to be more tested, since it's
   been that way for years and was re-stress-tested ~3 months ago,
   before tuning the memory OC after a new RAM installation. That was
   all stress tested for hours at considerably higher
   loads/temperature/current than anything I was doing when this problem
   occurred, with a variety of stressors and CPU quotas to give the CPU
   VRM's transient response a hard time. I'm always wary of memory, so
   out of caution after this incident, I de-rated the memory bus from
   1866 MT/s to 1800 without changing any timings.

I have 2 theories of what might've happened:

1. Somehow, the disk silently failed to accept / flush a bunch of
   writes, but *seemingly* correct data was buffered in the kernel until
   heavy I/O from Steam forced it out and it was read back in again.
   This would explain why the primary superblock seems to be older than
   the block-group-tree conversion.

2. That segfault was associated with something scribbling over something
   important that was going through the memory controller at the same
   time, because Steam was actively applying updates to the games stored
   on the drive. That would explain why the btrfs error manifested 2
   seconds after the segfault, and why it happened when I ran Steam and
   not any time in the preceding 10 hours.

And now... the questions:

First, is the other filesystem that was converted to block group tree in
danger as well?  Any more than it was a week ago?  It passed a scrub,
and doesn't seem to have been affected, but I currently have it mounted
read-only as a precaution.  Should I --convert-from-block-group-tree?
That FS is used almost exclusively as a backup target for my other
drives, and did not get any significant I/O traffic (maybe no writes at
all) between the conversion to block-group-tree and when the corruption
was discovered.

Second, Fedora has updates to kernel and btrfs-progs 6.6.2.  Will
installing these help or hinder further troubleshooting and analysis?
The block group tree conversion was done with btrfs-progs 6.5.1 on
kernel 6.5.12, which was also running when the corruption happened.

Third... before I re-format the affected disk, is there anything I
should collect from it that would help improve btrfs?

Alternately, maybe could I just... btrfs-select-super?  Is that crazy?

Links:

1.
https://lore.kernel.org/linux-btrfs/49144585162c9dc5a403c442154ecf54f5446aca@sweevo.net/

2. https://bbs.archlinux.org/viewtopic.php?id=263124

3. https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1861294

Annotated log:

> # Faffing around trying to      Nov 25 20:23:21 hogwarts sudo[106477]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/sbin/btrfs inspect-internal /dev/sda
>   find the command to show      Nov 25 20:23:21 hogwarts sudo[106477]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>   whether block-group-tree      Nov 25 20:23:21 hogwarts sudo[106477]: pam_unix(sudo:session): session closed for user root
>   is enabled                    Nov 25 20:23:33 hogwarts sudo[106544]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/sbin/btrfs inspect-internal tree-stats /dev/sda
>                                 Nov 25 20:23:33 hogwarts sudo[106544]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>                                 Nov 25 20:23:33 hogwarts sudo[106544]: pam_unix(sudo:session): session closed for user root
>                                 Nov 25 20:23:48 hogwarts systemd[1]: fprintd.service: Deactivated successfully.
>                                 Nov 25 20:23:49 hogwarts sudo[106597]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/sbin/btrfs inspect-internal tree-stats /dev/mapper/3tb_spinner
>                                 Nov 25 20:23:49 hogwarts sudo[106597]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>                                 Nov 25 20:25:50 hogwarts smartd[1925]: Device: /dev/disk/by-id/ata-ST3000DM001-1CH166_Z1F42Z96 [SAT], SMART Prefailure Attribute: 1 Raw_Read_Error_Rate changed from 106 to 111
>                                 Nov 25 20:28:04 hogwarts sudo[106597]: pam_unix(sudo:session): session closed for user root
>                                 Nov 25 20:28:56 hogwarts systemd[1]: Starting fprintd.service - Fingerprint Authentication Daemon...
>                                 Nov 25 20:28:56 hogwarts systemd[1]: Started fprintd.service - Fingerprint Authentication Daemon.
>                                 Nov 25 20:28:59 hogwarts sudo[107352]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/sbin/btrfs inspect-internal dump-tree /mnt/3tb_spinner/
>                                 Nov 25 20:28:59 hogwarts sudo[107352]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>                                 Nov 25 20:28:59 hogwarts sudo[107352]: pam_unix(sudo:session): session closed for user root
>                                 Nov 25 20:29:14 hogwarts sudo[107441]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/sbin/btrfs inspect-internal dump-tree /dev/mapper/3tb_spinner
>                                 Nov 25 20:29:14 hogwarts sudo[107441]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>                                 Nov 25 20:29:25 hogwarts sudo[107441]: pam_unix(sudo:session): session closed for user root
>                                 Nov 25 20:29:26 hogwarts systemd[1]: fprintd.service: Deactivated successfully.
>                                 Nov 25 20:29:30 hogwarts sudo[107520]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/sbin/btrfs inspect-internal dump-tree /dev/mapper/3tb_spinner
>                                 Nov 25 20:29:30 hogwarts sudo[107520]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>                                 Nov 25 20:29:50 hogwarts sudo[107520]: pam_unix(sudo:session): session closed for user root
> # Aha, that's it.               Nov 25 20:29:58 hogwarts sudo[107592]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/sbin/btrfs inspect-internal dump-super /dev/mapper/3tb_spinner
>                                 Nov 25 20:29:58 hogwarts sudo[107592]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>                                 Nov 25 20:29:58 hogwarts sudo[107592]: pam_unix(sudo:session): session closed for user root
>                                 Nov 25 20:30:16 hogwarts systemd[1]: Starting sysstat-collect.service - system activity accounting tool...
>                                 Nov 25 20:30:16 hogwarts systemd[1]: sysstat-collect.service: Deactivated successfully.
>                                 Nov 25 20:30:16 hogwarts systemd[1]: Finished sysstat-collect.service - system activity accounting tool.
> # Check the other disk          Nov 25 20:30:38 hogwarts sudo[107679]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/sbin/btrfs inspect-internal dump-super /dev/mapper/8tb_spinner
>                                 Nov 25 20:30:38 hogwarts sudo[107679]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>                                 Nov 25 20:30:49 hogwarts sudo[107679]: pam_unix(sudo:session): session closed for user root
> *snip*
> # Unmount 8tb_spinner           Nov 25 20:54:49 hogwarts sudo[111798]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/bin/umount /mnt/8tb_spinner
>                                 Nov 25 20:54:49 hogwarts sudo[111798]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
> # umount succeeds               Nov 25 20:54:49 hogwarts systemd[1]: mnt-8tb_spinner.mount: Deactivated successfully.
>                                 Nov 25 20:54:49 hogwarts dolphin[5493]: kf.kio.core: Invalid URL: QUrl("")
>                                 Nov 25 20:55:01 hogwarts sudo[111798]: pam_unix(sudo:session): session closed for user root
>                                 Nov 25 20:55:07 hogwarts systemd[2626]: Started run-rf6aa7b05f8534a5f89991cfba6deb72a.scope - /usr/bin/fish.
>                                 Nov 25 20:55:16 hogwarts systemd[1]: fprintd.service: Deactivated successfully.
> # Try to convert 8tb_spinner,   Nov 25 20:55:41 hogwarts sudo[111967]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/sbin/btrfstune --convert-to-block-group-tree /mnt/8tb_spinner/
>   but accidentally using the    Nov 25 20:55:41 hogwarts sudo[111967]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>   mount point.                  Nov 25 20:55:41 hogwarts sudo[111967]: pam_unix(sudo:session): session closed for user root
> # Do it right this time.        Nov 25 20:55:49 hogwarts sudo[112011]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/sbin/btrfstune --convert-to-block-group-tree /dev/mapper/8tb_spinner
>                                 Nov 25 20:55:49 hogwarts sudo[112011]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
> # It just does that sometimes.  Nov 25 20:55:50 hogwarts smartd[1925]: Device: /dev/disk/by-id/ata-ST3000DM001-1CH166_Z1F42Z96 [SAT], SMART Prefailure Attribute: 1 Raw_Read_Error_Rate changed from 111 to 114
>                                 Nov 25 20:56:50 hogwarts sudo[112011]: pam_unix(sudo:session): session closed for user root
>                                 Nov 25 20:56:51 hogwarts kernel: BTRFS: device fsid 4ddb9d32-698c-477e-9177-302ae1528e31 devid 1 transid 12769 /dev/dm-6 scanned by (udev-worker) (112218)
> # See the effect of the change, Nov 25 20:57:03 hogwarts sudo[112253]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/sbin/btrfs inspect-internal dump-super /dev/mapper/8tb_spinner
>                                 Nov 25 20:57:03 hogwarts sudo[112253]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>                                 Nov 25 20:57:03 hogwarts sudo[112253]: pam_unix(sudo:session): session closed for user root
> # And compare to 3tb_spinner.   Nov 25 20:57:12 hogwarts sudo[112284]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/sbin/btrfs inspect-internal dump-super /dev/mapper/3tb_spinner
>                                 Nov 25 20:57:12 hogwarts sudo[112284]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>                                 Nov 25 20:57:12 hogwarts sudo[112284]: pam_unix(sudo:session): session closed for user root
> # Finally, re-mount.            Nov 25 20:57:18 hogwarts sudo[112338]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/bin/mount /mnt/8tb_spinner/
>                                 Nov 25 20:57:18 hogwarts sudo[112338]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>                                 Nov 25 20:57:18 hogwarts kernel: BTRFS info (device dm-6): using crc32c (crc32c-intel) checksum algorithm
>                                 Nov 25 20:57:18 hogwarts kernel: BTRFS info (device dm-6): turning on flush-on-commit
>                                 Nov 25 20:57:18 hogwarts kernel: BTRFS info (device dm-6): force zstd compression, level 3
>                                 Nov 25 20:57:18 hogwarts kernel: BTRFS info (device dm-6): using free space tree
>                                 Nov 25 20:57:19 hogwarts kernel: BTRFS info (device dm-6): checking UUID tree
>                                 Nov 25 20:57:19 hogwarts sudo[112338]: pam_unix(sudo:session): session closed for user root
> # Try to umount 3tb_spinner,    Nov 25 20:57:32 hogwarts sudo[112401]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/bin/umount /mnt/3tb_spinner
>   but fail because I had a      Nov 25 20:57:32 hogwarts sudo[112401]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>   file open.                    Nov 25 20:57:32 hogwarts sudo[112401]: pam_unix(sudo:session): session closed for user root
> # Try again to umount,          Nov 25 20:58:18 hogwarts sudo[112541]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/bin/umount /mnt/3tb_spinner
>                                 Nov 25 20:58:18 hogwarts sudo[112541]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
> # and succeed.                  Nov 25 20:58:18 hogwarts systemd[1]: mnt-3tb_spinner.mount: Deactivated successfully.
>                                 Nov 25 20:58:18 hogwarts sudo[112541]: pam_unix(sudo:session): session closed for user root
> # this was 'time sudo mount'    Nov 25 20:58:24 hogwarts sudo[112592]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/bin/mount /mnt/3tb_spinner/
>                                 Nov 25 20:58:24 hogwarts sudo[112592]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>                                 Nov 25 20:58:24 hogwarts sudo[112592]: pam_unix(sudo:session): session closed for user root
> # umount                        Nov 25 20:58:27 hogwarts sudo[112602]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/bin/umount /mnt/3tb_spinner
>                                 Nov 25 20:58:27 hogwarts sudo[112602]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
> # succeed                       Nov 25 20:58:27 hogwarts systemd[1]: mnt-3tb_spinner.mount: Deactivated successfully.
>                                 Nov 25 20:58:27 hogwarts sudo[112602]: pam_unix(sudo:session): session closed for user root
> # Drop the cache to better      Nov 25 20:58:40 hogwarts sudo[112649]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/sbin/sysctl vm.drop_caches=3
>   measure mount time.           Nov 25 20:58:40 hogwarts sudo[112649]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>                                 Nov 25 20:58:41 hogwarts kernel: sysctl (112651): drop_caches: 3
>                                 Nov 25 20:58:41 hogwarts sudo[112649]: pam_unix(sudo:session): session closed for user root
> # time sudo mount               Nov 25 20:58:44 hogwarts sudo[112669]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/bin/mount /mnt/3tb_spinner/
>   No noticeable difference.     Nov 25 20:58:44 hogwarts sudo[112669]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>   Block cache or something?     Nov 25 20:58:45 hogwarts sudo[112669]: pam_unix(sudo:session): session closed for user root
> # Umount 3tb_spinner in order   Nov 25 20:58:49 hogwarts sudo[112687]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/bin/umount /mnt/3tb_spinner
>   to convert to block group     Nov 25 20:58:49 hogwarts sudo[112687]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>   tree.                         Nov 25 20:58:49 hogwarts sudo[112687]: pam_unix(sudo:session): session closed for user root
>                                 Nov 25 20:58:49 hogwarts systemd[1]: mnt-3tb_spinner.mount: Deactivated successfully.
> # Convert 3tb_spinner to block  Nov 25 20:59:02 hogwarts sudo[112737]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/sbin/btrfstune --convert-to-block-group-tree /dev/mapper/3tb_spinner
>   group tree. This one will     Nov 25 20:59:02 hogwarts sudo[112737]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>   become a problem.             Nov 25 21:00:02 hogwarts sudo[112737]: pam_unix(sudo:session): session closed for user root
>                                 Nov 25 21:00:02 hogwarts kernel: BTRFS info: devid 1 device path /dev/mapper/3tb_spinner changed to /dev/dm-1 scanned by (udev-worker) (112908)
>                                 Nov 25 21:00:02 hogwarts kernel: BTRFS info: devid 1 device path /dev/dm-1 changed to /dev/mapper/3tb_spinner scanned by (udev-worker) (112908)
>                                 Nov 25 21:00:02 hogwarts systemd[1]: Starting sysstat-collect.service - system activity accounting tool...
>                                 Nov 25 21:00:02 hogwarts systemd[1]: sysstat-collect.service: Deactivated successfully.
>                                 Nov 25 21:00:02 hogwarts systemd[1]: Finished sysstat-collect.service - system activity accounting tool.
>                                 Nov 25 21:01:01 hogwarts CROND[113070]: (root) CMD (run-parts /etc/cron.hourly)
>                                 Nov 25 21:01:01 hogwarts run-parts[113073]: (/etc/cron.hourly) starting 0anacron
>                                 Nov 25 21:01:01 hogwarts run-parts[113079]: (/etc/cron.hourly) finished 0anacron
>                                 Nov 25 21:01:01 hogwarts CROND[113069]: (root) CMDEND (run-parts /etc/cron.hourly)
> # Re-mount 3tb_spinner.         Nov 25 21:01:53 hogwarts sudo[113218]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/bin/mount /mnt/3tb_spinner/
>   For some reason there are no  Nov 25 21:01:53 hogwarts sudo[113218]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>   kernel messages about mount   Nov 25 21:01:53 hogwarts sudo[113218]: pam_unix(sudo:session): session closed for user root
>   options like there were for   Nov 25 21:06:03 hogwarts sudo[114038]:   rhaley : TTY=pts/16 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/sbin/btrfs fi usage /mnt/3tb_spinner/
>   FS A. They're the same in     Nov 25 21:06:03 hogwarts sudo[114038]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>   /etc/fstab...                 Nov 25 21:06:03 hogwarts sudo[114038]: pam_unix(sudo:session): session closed for user root
>   Fish shell history shows I    Nov 25 21:10:16 hogwarts systemd[1]: Starting sysstat-collect.service - system activity accounting tool...
>   edited a file on there, so it Nov 25 21:10:16 hogwarts systemd[1]: sysstat-collect.service: Deactivated successfully.
>   must've mounted okay, right?  Nov 25 21:10:16 hogwarts systemd[1]: Finished sysstat-collect.service - system activity accounting tool.
>                                 Nov 25 21:12:18 hogwarts systemd[1]: Starting dnf-makecache.service - dnf makecache...
> *snip* 10 hours later
>                                 Nov 26 07:13:24 hogwarts plasmashell[3112]: qt.qpa.wayland: Wayland does not support QWindow::requestActivate()
>                                 Nov 26 07:13:25 hogwarts plasmashell[3112]: QString::arg: 2 argument(s) missing in com.valvesoftware.Steam
> # Launch Steam flatpak.         Nov 26 07:13:26 hogwarts systemd[2626]: Started app-com.valvesoftware.Steam-7ac4bbfd2b544794b72f01851b78ce4a.scope - Steam.
>                                 Nov 26 07:13:26 hogwarts systemd[2626]: Started app-flatpak-com.valvesoftware.Steam-201383.scope.
>                                 Nov 26 07:13:26 hogwarts plasmashell[201397]: INFO:root:https://github.com/flathub/com.valvesoftware.Steam/wiki
>                                 Nov 26 07:13:26 hogwarts plasmashell[201397]: INFO:root:Will set XDG dirs prefix to /home/rhaley/.var/app/com.valvesoftware.Steam
>                                 Nov 26 07:13:26 hogwarts plasmashell[201397]: DEBUG:root:Checking input devices permissions
>                                 Nov 26 07:13:26 hogwarts plasmashell[201397]: INFO:root:Overriding TZ to America/Chicago
>                                 Nov 26 07:13:26 hogwarts plasmashell[201397]: steam.sh[2]: Running Steam on org.freedesktop.platform 23.08 64-bit
>                                 Nov 26 07:13:26 hogwarts plasmashell[201397]: steam.sh[2]: STEAM_RUNTIME is enabled automatically
>                                 Nov 26 07:13:26 hogwarts plasmashell[201469]: setup.sh[74]: Steam runtime environment up-to-date!
>                                 Nov 26 07:13:27 hogwarts plasmashell[201397]: steam.sh[2]: Steam client's requirements are satisfied
>                                 Nov 26 07:13:27 hogwarts plasmashell[201509]: 11/26 07:13:27 Init: Installing breakpad exception handler for appid(steam)/version(1700160213)/tid(108)
>                                 Nov 26 07:13:30 hogwarts xdg-desktop-portal-kde[3153]: xdp-kde-settings: Namespace  "org.gnome.desktop.interface"  is not supported
>                                 Nov 26 07:13:30 hogwarts plasmashell[201552]: steamwebhelper.sh[121]: Runtime for steamwebhelper: defaulting to /home/rhaley/.var/app/com.valvesoftware.Steam/.local/share/Steam/ubuntu12_64/steam-runtime-heavy
>                                 Nov 26 07:13:30 hogwarts plasmashell[201552]: steamwebhelper.sh[121]: Running under Flatpak, disabling sandbox
>                                 Nov 26 07:13:30 hogwarts plasmashell[201552]: steamwebhelper.sh[121]: CEF sandbox already disabled
>                                 Nov 26 07:13:30 hogwarts plasmashell[201509]: CAppInfoCacheReadFromDiskThread took 52 milliseconds to initialize
>                                 Nov 26 07:13:30 hogwarts rtkit-daemon[1918]: Successfully made thread 201588 of process 201509 (/home/rhaley/.var/app/com.valvesoftware.Steam/.local/share/Steam/ubuntu12_32/steam) owned by '1000' high priority at nice level -10.
>                                 Nov 26 07:13:30 hogwarts rtkit-daemon[1918]: Successfully made thread 201589 of process 201509 (/home/rhaley/.var/app/com.valvesoftware.Steam/.local/share/Steam/ubuntu12_32/steam) owned by '1000' high priority at nice level -10.
>                                 Nov 26 07:13:30 hogwarts rtkit-daemon[1918]: Successfully made thread 201607 of process 201509 (/home/rhaley/.var/app/com.valvesoftware.Steam/.local/share/Steam/ubuntu12_32/steam) owned by '1000' high priority at nice level -10.
>                                 Nov 26 07:13:31 hogwarts plasmashell[201509]: Steam Runtime Launch Service: starting steam-runtime-launcher-service
>                                 Nov 26 07:13:31 hogwarts plasmashell[201509]: Steam Runtime Launch Service: steam-runtime-launcher-service is running pid 175
>                                 Nov 26 07:13:31 hogwarts steam-runtime-launcher-service[201617]: E: Unable to acquire bus name "com.steampowered.PressureVessel.LaunchAlongsideSteam"
>                                 Nov 26 07:13:31 hogwarts xdg-desktop-portal-kde[3153]: xdp-kde-settings: Namespace  "org.gnome.desktop.interface"  is not supported
> # Note that Steam is running    Nov 26 07:13:32 hogwarts plasmashell[201676]: MESA-INTEL: warning: Haswell Vulkan support is incomplete
>   on the Intel integrated GPU.  Nov 26 07:13:32 hogwarts plasmashell[201509]: Steam Runtime Launch Service: steam-runtime-launcher-service pid 175 exited
>   This could be related to the  Nov 26 07:13:32 hogwarts plasmashell[201683]: MESA-INTEL: warning: Haswell Vulkan support is incomplete
>   problem, because this machine Nov 26 07:13:33 hogwarts plasmashell[201509]: Steam Runtime Launch Service: starting steam-runtime-launcher-service
>   has overclocked memory, and   Nov 26 07:13:33 hogwarts plasmashell[201509]: Steam Runtime Launch Service: steam-runtime-launcher-service is running pid 245
>   the IGP could possibly use    Nov 26 07:13:33 hogwarts steam-runtime-launcher-service[201693]: E: Unable to acquire bus name "com.steampowered.PressureVessel.LaunchAlongsideSteam"
>   the memory subsystem in ways  Nov 26 07:13:34 hogwarts plasmashell[201509]: Steam Runtime Launch Service: steam-runtime-launcher-service pid 245 exited
>   CPU-based stress tests don't. Nov 26 07:13:35 hogwarts plasmashell[201509]: Steam Runtime Launch Service: starting steam-runtime-launcher-service
>                                 Nov 26 07:13:35 hogwarts plasmashell[201509]: Steam Runtime Launch Service: steam-runtime-launcher-service is running pid 249
>                                 Nov 26 07:13:35 hogwarts steam-runtime-launcher-service[201708]: E: Unable to acquire bus name "com.steampowered.PressureVessel.LaunchAlongsideSteam"
>                                 Nov 26 07:13:36 hogwarts plasmashell[201509]: Steam Runtime Launch Service: steam-runtime-launcher-service pid 249 exited
>                                 Nov 26 07:13:36 hogwarts plasmashell[201509]: Steam Runtime Launch Service: steam-runtime-launcher-service keeps crashing on startup, disabling
>                                 Nov 26 07:13:40 hogwarts python3[1899]: INFO [fancontrol_ng.py:amdgpu_power_gen:276] State.WARM GPU turned OFF
>                                 Nov 26 07:13:43 hogwarts plasmashell[201509]: BRefreshApplicationsInLibrary 1: 16ms
>                                 Nov 26 07:13:44 hogwarts plasmashell[3112]: libpng warning: iCCP: known incorrect sRGB profile
>                                 Nov 26 07:13:44 hogwarts plasmashell[3112]: libpng warning: known incorrect sRGB profile
>                                 Nov 26 07:13:44 hogwarts plasmashell[3112]: libpng warning: profile matches sRGB but writing iCCP instead
> # *HORK*                        Nov 26 07:14:01 hogwarts kernel: GpuWatchdog[201636]: segfault at 0 ip 00007ff3cb592bc6 sp 00007ff3c2350960 error 6 in libcef.so[7ff3c70ef000+7770000] likely on CPU 2 (core 2, socket 0)
>                                 Nov 26 07:14:01 hogwarts kernel: Code: 89 de e8 5d ee 6e ff 80 7d cf 00 79 09 48 8b 7d b8 e8 2e 66 2c 03 41 8b 84 24 e0 00 00 00 89 45 b8 48 8d 7d b8 e8 3a d1 b5 fb <c7> 04 25 00 00 00 00 37 13 00 00 48 83 c4 38 5b 41 5c 41 5d 41 5e
>                                 Nov 26 07:14:01 hogwarts systemd[1]: Created slice system-systemd\x2dcoredump.slice - Slice /system/systemd-coredump.
>                                 Nov 26 07:14:01 hogwarts systemd[1]: Started systemd-coredump@0-201803-0.service - Process Core Dump (PID 201803/UID 0).
>                                 Nov 26 07:14:01 hogwarts systemd-coredump[201807]: Process 201629 (steamwebhelper) of user 1000 dumped core.
>                                                                                    
>                                                                                    Stack trace of thread 192:
>                                                                                    #0  0x00007ff3cb592bc6 n/a (/home/rhaley/.var/app/com.valvesoftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x5f92bc6)
>                                                                                    #1  0x00007ff3cb592453 n/a (/home/rhaley/.var/app/com.valvesoftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x5f92453)
>                                                                                    #2  0x00007ff3c9a16176 n/a (/home/rhaley/.var/app/com.valvesoftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x4416176)
>                                                                                    #3  0x00007ff3c9a26bbc n/a (/home/rhaley/.var/app/com.valvesoftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x4426bbc)
>                                                                                    #4  0x00007ff3c99df72a n/a (/home/rhaley/.var/app/com.valvesoftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x43df72a)
>                                                                                    #5  0x00007ff3c9a27284 n/a (/home/rhaley/.var/app/com.valvesoftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x4427284)
>                                                                                    #6  0x00007ff3c99fee3e n/a (/home/rhaley/.var/app/com.valvesoftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x43fee3e)
>                                                                                    #7  0x00007ff3c9a40f47 n/a (/home/rhaley/.var/app/com.valvesoftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x4440f47)
>                                                                                    #8  0x00007ff3c9a62a45 n/a (/home/rhaley/.var/app/com.valvesoftware.Steam/.local/share/Steam/ubuntu12_64/libcef.so + 0x4462a45)
>                                                                                    #9  0x00007ff3c4aa1e39 n/a (/usr/lib/x86_64-linux-gnu/libc.so.6 + 0x8ee39)
>                                                                                    #10 0x00007ff3c4b298c4 n/a (/usr/lib/x86_64-linux-gnu/libc.so.6 + 0x1168c4)
>                                                                                    ELF object binary architecture: AMD x86-64
>                                 Nov 26 07:14:01 hogwarts systemd[1]: systemd-coredump@0-201803-0.service: Deactivated successfully.
>                                 Nov 26 07:14:02 hogwarts abrt-server[201827]: Unsupported container technology
>                                 Nov 26 07:14:02 hogwarts abrt-server[201827]: Lock file '.lock' was locked by process 201830, but it crashed?
>                                 Nov 26 07:14:03 hogwarts abrt-notification[201866]: Process 201629 (steamwebhelper) crashed in ??()
> # Problem manifests on dm-1,    Nov 26 07:14:03 hogwarts kernel: BTRFS error (device dm-1): parent transid verify failed on logical 31850496 mirror 1 wanted 123883 found 123907
>   which is 3tb_spinner.         Nov 26 07:14:03 hogwarts abrt-applet[3475]: g_app_info_should_show: assertion 'G_IS_APP_INFO (appinfo)' failed
>                                 Nov 26 07:14:03 hogwarts plasmashell[3112]: Could not find the Plasmoid for Plasma::FrameSvgItem(0x7f76b403aac0) QQmlContext(0x558dda81e8f0) QUrl("file:///usr/share/plasma/plasmoids/org.kde.plasma.notifications/contents/ui/global/Globals.qml")
>                                 Nov 26 07:14:03 hogwarts plasmashell[3112]: Could not find the Plasmoid for Plasma::FrameSvgItem(0x7f76b403aac0) QQmlContext(0x558dda81e8f0) QUrl("file:///usr/share/plasma/plasmoids/org.kde.plasma.notifications/contents/ui/global/Globals.qml")
>                                 Nov 26 07:14:03 hogwarts kernel: BTRFS error (device dm-1): parent transid verify failed on logical 31850496 mirror 2 wanted 123883 found 123907
>                                 Nov 26 07:14:03 hogwarts kernel: BTRFS error (device dm-1): failed to run delayed ref for logical 916815872 num_bytes 16384 type 176 action 1 ref_mod 1: -5
>                                 Nov 26 07:14:03 hogwarts kernel: BTRFS error (device dm-1: state A): Transaction aborted (error -5)
>                                 Nov 26 07:14:03 hogwarts kernel: BTRFS: error (device dm-1: state A) in btrfs_run_delayed_refs:2182: errno=-5 IO failure
> # Goes read-only.               Nov 26 07:14:03 hogwarts kernel: BTRFS info (device dm-1: state EA): forced readonly
>                                 Nov 26 07:14:03 hogwarts plasmashell[201509]: BuildCompleteAppOverviewChange: 285 apps
>                                 Nov 26 07:14:03 hogwarts plasmashell[201509]: RegisterForAppOverview 1: 15ms
>                                 Nov 26 07:14:03 hogwarts plasmashell[201509]: RegisterForAppOverview 2: 15ms
>                                 Nov 26 07:14:22 hogwarts plasmashell[3112]: file:///usr/share/plasma/plasmoids/org.kde.plasma.notifications/contents/ui/NotificationItem.qml:256:9: QML QQuickItem: Binding loop detected for property "height"
>                                 Nov 26 07:14:22 hogwarts plasmashell[3112]: file:///usr/share/plasma/plasmoids/org.kde.plasma.notifications/contents/ui/NotificationItem.qml:256:9: QML QQuickItem: Binding loop detected for property "height"
>                                 Nov 26 07:15:25 hogwarts NetworkManager[2069]: <info>  [1701004525.2209] dhcp4 (enp0s25): state changed new lease, address=192.168.94.10
>                                 Nov 26 07:15:25 hogwarts systemd[1]: Starting NetworkManager-dispatcher.service - Network Manager Script Dispatcher Service...
>                                 Nov 26 07:15:25 hogwarts systemd[1]: Started NetworkManager-dispatcher.service - Network Manager Script Dispatcher Service.
>                                 Nov 26 07:15:27 hogwarts jellyfin[2280]: [07:15:27] [INF] [85] Jellyfin.Networking.Manager.NetworkManager: Defined LAN addresses : [10.0.0.0/8,172.16.0.0/12,192.168.0.0/16]
>                                 Nov 26 07:15:27 hogwarts jellyfin[2280]: [07:15:27] [INF] [85] Jellyfin.Networking.Manager.NetworkManager: Defined LAN exclusions : []
>                                 Nov 26 07:15:27 hogwarts jellyfin[2280]: [07:15:27] [INF] [85] Jellyfin.Networking.Manager.NetworkManager: Using LAN addresses: [10.0.0.0/8,172.16.0.0/12,192.168.0.0/16]
>                                 Nov 26 07:15:35 hogwarts systemd[1]: NetworkManager-dispatcher.service: Deactivated successfully.
>                                 Nov 26 07:17:35 hogwarts cupsd[2133]: REQUEST localhost - - "POST / HTTP/1.1" 200 185 Renew-Subscription successful-ok
>                                 Nov 26 07:20:16 hogwarts systemd[1]: Starting sysstat-collect.service - system activity accounting tool...
>                                 Nov 26 07:20:16 hogwarts systemd[1]: sysstat-collect.service: Deactivated successfully.
>                                 Nov 26 07:20:16 hogwarts systemd[1]: Finished sysstat-collect.service - system activity accounting tool.
>                                 Nov 26 07:25:33 hogwarts systemd[2626]: Started run-r95b9b8d1554342d2922acba57a0a2b60.scope - /usr/bin/fish.
>                                 Nov 26 07:28:26 hogwarts kwin_wayland[2959]: kf.service.services: The desktop entry file "/usr/share/applications/org.freedesktop.Xwayland.desktop" has Type= "Application" but has no Exec field.
>                                 Nov 26 07:28:26 hogwarts kwin_wayland[2959]: kf.service.services: The desktop entry file "/usr/share/applications/qemu.desktop" has Type= "Application" but has no Exec field.
>                                 Nov 26 07:30:16 hogwarts systemd[1]: Starting sysstat-collect.service - system activity accounting tool...
>                                 Nov 26 07:30:16 hogwarts systemd[1]: sysstat-collect.service: Deactivated successfully.
>                                 Nov 26 07:30:16 hogwarts systemd[1]: Finished sysstat-collect.service - system activity accounting tool.
>                                 Nov 26 07:30:17 hogwarts plasmashell[3112]: kpipewire_logging: Window not available PipeWireSourceItem_QML_1041(0x558ddef735f0, parent=0x558dddabb090, geometry=0,0 226x105)
>                                 Nov 26 07:30:17 hogwarts pipewire[2957]: mod.client-node: 0x55807c733170: unknown peer 0x55807cb82f50 fd:90
>                                 Nov 26 07:30:17 hogwarts plasmashell[3112]: kpipewire_logging: Window not available PipeWireSourceItem_QML_1041(0x558ddd0f7420, parent=0x558ddc1abed0, geometry=0,0 226x105)
>                                 Nov 26 07:30:17 hogwarts plasmashell[3112]: kpipewire_logging: Window not available PipeWireSourceItem_QML_1041(0x558ddd0f7420, parent=0x558ddc1abed0, geometry=0,0 226x105)
>                                 Nov 26 07:30:17 hogwarts plasmashell[3112]: kpipewire_logging: Window not available PipeWireSourceItem_QML_1041(0x558ddd0f7420, parent=0x558ddc1abed0, geometry=0,0 226x105)
>                                 Nov 26 07:30:17 hogwarts plasmashell[3112]: kpipewire_logging: Window not available PipeWireSourceItem_QML_1041(0x558ddd0f7420, parent=0x558ddc1abed0, geometry=0,0 226x105)
>                                 Nov 26 07:30:34 hogwarts pipewire[2957]: mod.client-node: 0x55807c73e700: unknown peer 0x55807c5892e0 fd:58
>                                 Nov 26 07:30:34 hogwarts plasmashell[3112]: kpipewire_logging: Window not available PipeWireSourceItem_QML_1041(0x558ddd1c3de0, parent=0x558ddb4bdcf0, geometry=0,0 226x105)
>                                 Nov 26 07:30:44 hogwarts kwin_wayland[2959]: This plugin does not support raise()
>                                 Nov 26 07:35:32 hogwarts plasmashell[3112]: Could not find the Plasmoid for Plasma::FrameSvgItem(0x558dde240460) QQmlContext(0x558dda81e8f0) QUrl("file:///usr/share/plasma/plasmoids/org.kde.plasma.notifications/contents/ui/global/Globals.qml")
>                                 Nov 26 07:35:32 hogwarts plasmashell[3112]: Could not find the Plasmoid for Plasma::FrameSvgItem(0x558dde240460) QQmlContext(0x558dda81e8f0) QUrl("file:///usr/share/plasma/plasmoids/org.kde.plasma.notifications/contents/ui/global/Globals.qml")
>                                 Nov 26 07:36:28 hogwarts kwin_wayland[2959]: kf.service.services: The desktop entry file "/usr/share/applications/org.freedesktop.Xwayland.desktop" has Type= "Application" but has no Exec field.
>                                 Nov 26 07:36:28 hogwarts kwin_wayland[2959]: kf.service.services: The desktop entry file "/usr/share/applications/qemu.desktop" has Type= "Application" but has no Exec field.
>                                 Nov 26 07:36:28 hogwarts kstart5[205139]: Omitting both --window and --windowclass arguments is not recommended
>                                 Nov 26 07:36:28 hogwarts systemd[2626]: Started app-konsole-99f85861097e4dd5a8484ba52cf1a120.scope - konsole.
>                                 Nov 26 07:36:28 hogwarts kwin_wayland[2959]: kf.service.services: The desktop entry file "/usr/share/applications/org.freedesktop.Xwayland.desktop" has Type= "Application" but has no Exec field.
>                                 Nov 26 07:36:28 hogwarts kwin_wayland[2959]: kf.service.services: The desktop entry file "/usr/share/applications/qemu.desktop" has Type= "Application" but has no Exec field.
>                                 Nov 26 07:36:28 hogwarts kded5[3090]: org.kde.plasma.appmenu: Got an error
>                                 Nov 26 07:36:28 hogwarts kded5[3090]: org.kde.plasma.appmenu: Got an error
>                                 Nov 26 07:36:29 hogwarts systemd[2626]: Started run-r5601954a28844b309ba7ae35844778d6.scope - /usr/bin/fish.
>                                 Nov 26 07:36:36 hogwarts kernel: [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
>                                 Nov 26 07:36:37 hogwarts kernel: [drm] UVD and UVD ENC initialized successfully.
>                                 Nov 26 07:36:37 hogwarts kernel: [drm] VCE initialized successfully.
>                                 Nov 26 07:36:37 hogwarts kernel: amdgpu 0000:01:00.0: [drm] Cannot find any crtc or sizes
>                                 Nov 26 07:36:52 hogwarts python3[1899]: INFO [fancontrol_ng.py:amdgpu_power_gen:276] State.WARM GPU turned OFF
>                                 Nov 26 07:40:16 hogwarts systemd[1]: Starting sysstat-collect.service - system activity accounting tool...
>                                 Nov 26 07:40:16 hogwarts systemd[1]: sysstat-collect.service: Deactivated successfully.
>                                 Nov 26 07:40:16 hogwarts systemd[1]: Finished sysstat-collect.service - system activity accounting tool.
>                                 Nov 26 07:46:18 hogwarts systemd[1]: Starting dnf-makecache.service - dnf makecache...
>                                 Nov 26 07:46:18 hogwarts dnf[206741]: Metadata cache refreshed recently.
>                                 Nov 26 07:46:19 hogwarts systemd[1]: dnf-makecache.service: Deactivated successfully.
>                                 Nov 26 07:46:19 hogwarts systemd[1]: Finished dnf-makecache.service - dnf makecache.
>                                 Nov 26 07:50:16 hogwarts systemd[1]: Starting sysstat-collect.service - system activity accounting tool...
>                                 Nov 26 07:50:16 hogwarts systemd[1]: sysstat-collect.service: Deactivated successfully.
>                                 Nov 26 07:50:17 hogwarts systemd[1]: Finished sysstat-collect.service - system activity accounting tool.
>                                 Nov 26 08:00:16 hogwarts systemd[1]: Starting sysstat-collect.service - system activity accounting tool...
>                                 Nov 26 08:00:16 hogwarts systemd[1]: sysstat-collect.service: Deactivated successfully.
>                                 Nov 26 08:00:16 hogwarts systemd[1]: Finished sysstat-collect.service - system activity accounting tool.
>                                 Nov 26 08:00:57 hogwarts systemd[2626]: Started run-r5341136056a24fa79656d83c089e028e.scope - /usr/bin/fish.
>                                 Nov 26 08:00:59 hogwarts kernel: [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
>                                 Nov 26 08:00:59 hogwarts kernel: [drm] UVD and UVD ENC initialized successfully.
>                                 Nov 26 08:00:59 hogwarts kernel: [drm] VCE initialized successfully.
>                                 Nov 26 08:00:59 hogwarts kernel: amdgpu 0000:01:00.0: [drm] Cannot find any crtc or sizes
>                                 Nov 26 08:01:01 hogwarts CROND[208772]: (root) CMD (run-parts /etc/cron.hourly)
>                                 Nov 26 08:01:01 hogwarts run-parts[208775]: (/etc/cron.hourly) starting 0anacron
>                                 Nov 26 08:01:01 hogwarts run-parts[208781]: (/etc/cron.hourly) finished 0anacron
>                                 Nov 26 08:01:01 hogwarts CROND[208771]: (root) CMDEND (run-parts /etc/cron.hourly)
>                                 Nov 26 08:01:30 hogwarts python3[1899]: INFO [fancontrol_ng.py:amdgpu_power_gen:276] State.WARM GPU turned OFF
>                                 Nov 26 08:02:01 hogwarts systemd[2626]: Started run-r8b14da3ce30c4eb29b6a5c9275766925.scope - /usr/bin/fish.
>                                 Nov 26 08:02:05 hogwarts systemd[1]: Starting fprintd.service - Fingerprint Authentication Daemon...
>                                 Nov 26 08:02:05 hogwarts systemd[1]: Started fprintd.service - Fingerprint Authentication Daemon.
> # Unrelated curiousity. I       Nov 26 08:02:07 hogwarts sudo[209070]:   rhaley : TTY=pts/19 ; PWD=/home/rhaley ; USER=root ; COMMAND=/usr/bin/intel_gpu_top
>   hadn't noticed the problem    Nov 26 08:02:07 hogwarts sudo[209070]: pam_unix(sudo:session): session opened for user root(uid=0) by rhaley(uid=1000)
>   yet.                          Nov 26 08:02:07 hogwarts kernel: [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
>                                 Nov 26 08:02:07 hogwarts kernel: [drm] UVD and UVD ENC initialized successfully.
>                                 Nov 26 08:02:08 hogwarts kernel: [drm] VCE initialized successfully.
>                                 Nov 26 08:02:08 hogwarts kernel: amdgpu 0000:01:00.0: [drm] Cannot find any crtc or sizes
>                                 Nov 26 08:02:11 hogwarts sudo[209070]: pam_unix(sudo:session): session closed for user root
> *snip* 57 minutes, 418 lines of mostly plasmashell logspam
> # This pair of messages is      Nov 26 08:59:48 hogwarts kernel: BTRFS error (device dm-1: state EA): level verify failed on logical 875102208 mirror 1 wanted 2 found 0
>   spammed up to the journal     Nov 26 08:59:48 hogwarts kernel: BTRFS error (device dm-1: state EA): level verify failed on logical 875102208 mirror 2 wanted 2 found 0
>   rate limit, ~76,000 times,    Nov 26 08:59:48 hogwarts kernel: BTRFS error (device dm-1: state EA): level verify failed on logical 875102208 mirror 1 wanted 2 found 0
>   until reboot.                 Nov 26 08:59:48 hogwarts kernel: BTRFS error (device dm-1: state EA): level verify failed on logical 875102208 mirror 2 wanted 2 found 0
> 
> # I notice the problem and check SMART (finding nothing unusual) at 11:48:01
> # reboot happens at 11:53:02


