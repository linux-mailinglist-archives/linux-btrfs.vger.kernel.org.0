Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAD034A819
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 14:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCZNaG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 09:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhCZNaF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 09:30:05 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD7FC0613AA;
        Fri, 26 Mar 2021 06:30:04 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id r8so1605554ual.9;
        Fri, 26 Mar 2021 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1B9iiuEL14+V+seCuzJcUxzxikKeptLUgQQ92sa7DbM=;
        b=h4b7CR6RLVfK4urWhj1WMg0gYrVD7YacFffvAUBzpfyCrYKsW4aI5hbWCL27Sdthpl
         fexeVDvdmQpE8Ha1AbFpvUmaC5pt6nY0RNXZHUG9fcrTUuQJAuWbZG80dFyiSwYzlmT/
         wKXV4N5iEvIbCW7CteDyvXb2pGEvFsxBFWktZXnxQg1cP/nDrXzKjebmjynT/gJIhpIv
         Nt1PgQHitDWIrKbXCgiCHiq4QCIwGIhVuakVOTQfAAL+e9JjLmBFvNHtqSPkVT0p64nx
         /uAaj6cpJN5JLZ93ZeYe40co1oRc7RDp1ze6Svg8/ZiLV2ImBeVqUJx7BCt1qeXbmZ3I
         xEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1B9iiuEL14+V+seCuzJcUxzxikKeptLUgQQ92sa7DbM=;
        b=QF0Y5+qYcLq0WGY1fMyUkwKsQCDI3p0NC8U+ye4Bx1WZ/p639Kd2gen3h6+uyKu3X/
         1BvqIki33A3TRMr2pIDT+9ykhsNMyoptho/W6Dlpp2uslnIwGR59yU+ROsRMA9XiA9h0
         PChXQVWP6z8lywRObiMH78NnrG54NW+4Bojb7wIYWva6DGp0+wpXbg6vB4zk4DuEVtQ0
         XDNFj+4eIMeARM7SkuoZElHkMr2NjYFbSlzU7IlYGOJn3DH6DjiObfXrVf0n3Fc7DpOx
         NLRLpW9L48bmWP2CZE0uVrcjKqP0AGU9m59sV0KA9+WRmn72pIfEffljXZKYnpxJ1UxG
         YSdg==
X-Gm-Message-State: AOAM533vC3NuF65GMjPkR8NGZQ32n4eH2crjdx/UiB7BsIApNPoTfkmk
        DMkRYM32uFBMPyATHaJOcsR3E1rNGRRmUMCvALg=
X-Google-Smtp-Source: ABdhPJypjAwurav85+0zhqHXdftOcrsLOKaL8E/LzxxVLIbph6IB7ph2wdPmeYXRU3VOheeqfofXr8Zj/JmKRtPkYsc=
X-Received: by 2002:a9f:3b28:: with SMTP id i40mr7974918uah.37.1616765403769;
 Fri, 26 Mar 2021 06:30:03 -0700 (PDT)
MIME-Version: 1.0
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Fri, 26 Mar 2021 08:29:52 -0500
Message-ID: <CALaQ_hrZZmAi2AKtmCm2QUXeg9VWuyeWmmk__OFEG1ycHMiX8A@mail.gmail.com>
Subject: BTRFS Balance Hard System Crash (Blinking LEDs)
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

*****
...I "think" this is where the "emergency" drop out of boot occurred,
and I just did a "systemctl reboot" which had the next boot succeed.
Nope, I'm wrong. For whatever reason, this appears to be the boot that
ended up working (searching for the first "microcode" reference
indicating the start of a boot).
Mar 25 21:44:17 computerName kernel: BTRFS critical (device dm-3):
unable to add free space :-17
...v 13 times
Mar 25 21:42:59 computerName kernel: BTRFS critical (device dm-3):
unable to add free space :-17
Mar 25 21:42:59 computerName kernel: BTRFS critical (device dm-3):
unable to add free space :-17
...v 36 times
Mar 25 21:40:45 computerName kernel: BTRFS critical (device dm-3):
unable to add free space :-17
Mar 25 21:40:44 computerName kernel: BTRFS critical (device dm-3):
unable to add free space :-17
Mar 25 21:40:44 computerName kernel: ---[ end trace 880e498e00cd6fcd ]---
Mar 25 21:40:44 computerName kernel:  ret_from_fork+0x22/0x30
Mar 25 21:40:44 computerName kernel:  ? __kthread_bind_mask+0x70/0x70
Mar 25 21:40:44 computerName kernel:  kthread+0x144/0x170
Mar 25 21:40:44 computerName kernel:  balance_kthread+0x35/0x50 [btrfs]
Mar 25 21:40:44 computerName kernel:  ? btrfs_balance+0xee0/0xee0 [btrfs]
Mar 25 21:40:44 computerName kernel:  btrfs_balance+0x765/0xee0 [btrfs]
Mar 25 21:40:44 computerName kernel:  btrfs_relocate_chunk+0x2a/0xc0 [btrfs]
Mar 25 21:40:44 computerName kernel:
btrfs_relocate_block_group+0x164/0x310 [btrfs]
Mar 25 21:40:44 computerName kernel:  relocate_block_group+0x2e9/0x5f0 [btrfs]
Mar 25 21:40:44 computerName kernel:  prepare_to_merge+0x246/0x280 [btrfs]
Mar 25 21:40:44 computerName kernel:
btrfs_commit_transaction+0x79b/0xa70 [btrfs]
Mar 25 21:40:44 computerName kernel:
btrfs_finish_extent_commit+0xb6/0x2c0 [btrfs]
Mar 25 21:40:44 computerName kernel:  ? clear_extent_bit+0x43/0x60 [btrfs]
Mar 25 21:40:44 computerName kernel:  unpin_extent_range+0x299/0x4d0 [btrfs]
Mar 25 21:40:44 computerName kernel:  ? kmem_cache_free+0xad/0x1e0
Mar 25 21:40:44 computerName kernel:  __btrfs_add_free_space+0xaf/0x4d0 [btrfs]
Mar 25 21:40:44 computerName kernel:  link_free_space+0x27/0x60 [btrfs]
Mar 25 21:40:44 computerName kernel: Call Trace:
Mar 25 21:40:44 computerName kernel: CR2: 00003e4fc2c21000 CR3:
000000012f60a003 CR4: 00000000001606f0
Mar 25 21:40:44 computerName kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Mar 25 21:40:44 computerName kernel: FS:  0000000000000000(0000)
GS:ffff95cad8200000(0000) knlGS:0000000000000000
Mar 25 21:40:44 computerName kernel: R13: ffff95ca79eeac08 R14:
ffff95ca79eeac00 R15: 000000000000c000
Mar 25 21:40:44 computerName kernel: R10: ffff95ca181731e0 R11:
0000000000000000 R12: ffff95c9d6b57c30
Mar 25 21:40:44 computerName kernel: RBP: 0000000000000000 R08:
ffffffffffffffff R09: ffff95c9d6b57c30
Mar 25 21:40:44 computerName kernel: RDX: 0000000000000000 RSI:
0000026e55e90000 RDI: ffff95ca79eeac08
Mar 25 21:40:44 computerName kernel: RAX: ffff95ca4f5389b0 RBX:
0000026e55e90000 RCX: ffff95ca4f538328
Mar 25 21:40:44 computerName kernel: RSP: 0018:ffffb171c067ba60 EFLAGS: 00010246
Mar 25 21:40:44 computerName kernel: Code: 89 e7 49 c7 44 24 08 00 00
00 00 49 c7 44 24 10 00 00 00 00 4c 89 21 e8 16 93 28 fa 31 c0 5b 5d
41 5c 41 5d c3 48 85 d2 75 c1 <0f> 0b b8 ef ff ff ff eb eb 0f 0b b8 ef
ff ff ff eb e2 66 0f 1f 44
Mar 25 21:40:44 computerName kernel: RIP:
0010:tree_insert_offset+0x88/0xa0 [btrfs]
Mar 25 21:40:44 computerName kernel: Hardware name: To Be Filled By
O.E.M. To Be Filled By O.E.M./H97M-ITX/ac, BIOS P1.80 07/27/2015
Mar 25 21:40:44 computerName kernel: CPU: 0 PID: 998 Comm:
btrfs-balance Tainted: G           OE     5.8.7-dirty #1
Mar 25 21:40:44 computerName kernel:  intel_gtt syscopyarea
sysfillrect sysimgblt snd fb_sys_fops soundcore mei lpc_ich evdev
mac_hid nct6775 hwmon_vid v4l2loopback_dc(OE) videodev drm mc agpgart
fuse ip_tables x_tables f2fs dm_crypt cbc enc>
Mar 25 21:40:44 computerName kernel: Modules linked in: ccm cmac
algif_hash bnep btrfs blake2b_generic xor raid6_pq libcrc32c
crc32c_generic nls_iso8859_1 nls_cp437 vfat fat snd_usb_audio
snd_usbmidi_lib snd_rawmidi snd_seq_device tda18271 a>
Mar 25 21:40:44 computerName kernel: WARNING: CPU: 0 PID: 998 at
fs/btrfs/free-space-cache.c:1499 tree_insert_offset+0x88/0xa0 [btrfs]
...boot crash AFTER balance
Mar 25 21:40:39 computerName kernel: BTRFS info (device dm-3): found 8
extents, stage: move data extents
Mar 25 21:40:37 computerName kernel: BTRFS info (device dm-3):
relocating block group 3875364929536 flags data
Mar 25 21:40:37 computerName kernel: BTRFS info (device dm-3):
balance: resume -dusage=90 -musage=90 -susage=90
Mar 25 21:40:37 computerName kernel: BTRFS error (device dm-3):
incorrect extent count for 2672774086656; counted 7070, expected 7073
Mar 25 21:40:37 computerName systemd[1]: Mounted <btrfsPath>
Mar 25 21:40:33 computerName kernel: BTRFS info (device dm-3): bdev
/dev/mapper/<btrfsPath> errs: wr 0, rd 56, flush 0, corrupt 0, gen 0
Mar 25 21:40:32 computerName kernel: BTRFS info (device dm-3): has
skinny extents
Mar 25 21:40:32 computerName kernel: BTRFS info (device dm-3): using
free space tree
Mar 25 21:40:32 computerName kernel: BTRFS info (device dm-3):
enabling auto defrag
...
Mar 25 21:39:54 computerName systemd-shutdown[1]: Syncing filesystems
and block devices.
...Hmm, based on the timing here, maybe the above wasn't the first
"emergency" reboot, and it was this one instead. No idea why the crash
happened on the next reboot.
Mar 25 21:28:52 computerName kernel: BTRFS error (device dm-3):
open_ctree failed
...
Mar 25 21:28:52 computerName systemd[1]: Failed to mount <btrfsPath>.
Mar 25 21:28:52 computerName systemd[1]: <btrfsPath>.mount: Failed
with result 'timeout'.
Mar 25 21:28:52 computerName systemd[1]: <btrfsPath>.mount: Mount
process exited, code=killed, status=15/TERM
Mar 25 21:28:52 computerName kernel: BTRFS warning (device dm-3):
failed to resume balance: -4
Mar 25 21:28:35 computerName kernel: BTRFS info (device dm-3): setting
compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
Mar 25 21:28:35 computerName kernel: BTRFS info (device dm-3): setting
compat-ro feature flag for FREE_SPACE_TREE (0x1)
Mar 25 21:28:08 computerName kernel: BTRFS info (device dm-3):
creating free space tree
Mar 25 21:27:25 computerName systemd[1]: <btrfsPath>.mount: Killing
process 983 (mount) with signal SIGKILL.
Mar 25 21:27:25 computerName systemd[1]: <btrfsPath>.mount: Mount
process timed out. Killing.
Mar 25 21:25:55 computerName systemd[1]: <btrfsPath>.mount: Mounting
timed out. Terminating.
Mar 25 21:24:35 computerName kernel: BTRFS info (device dm-3): start
tree-log replay
Mar 25 21:24:25 computerName kernel: BTRFS info (device dm-3): bdev
/dev/mapper/<btrfsPath> errs: wr 0, rd 56, flush 0, corrupt 0, gen 0
Mar 25 21:24:25 computerName kernel: BTRFS info (device dm-3): has
skinny extents
Mar 25 21:24:25 computerName kernel: BTRFS info (device dm-3): using
free space tree
Mar 25 21:24:25 computerName kernel: BTRFS info (device dm-3):
enabling auto defrag
Mar 25 21:24:25 computerName kernel: BTRFS info (device dm-3):
enabling free space tree
Mar 25 21:24:25 computerName systemd[1]: Mounting <btrfsPath>...
...This is where I found my system had crashed hard with the numlock
and capslock LEDs blinking. Estimating the time, this should be about
where balancing should have completed. There was 5% left when I last
checked it ~3 hours earlier (takes ~30 minutes for a 1% change to
occur). Interesting that the journal didn't catch the cause. I have my
system/root (containing journal log) on a separate sd-card using F2FS,
while /home (and old/unused system/root) is on the BTRFS mechanical
drive.
Mar 25 21:03:59 computerName kernel: BTRFS info (device dm-3): found
81683 extents, stage: move data extents
Mar 25 21:02:46 computerName kernel: BTRFS info (device dm-3):
relocating block group 3250585600 flags data
Mar 25 21:02:14 computerName kernel: BTRFS info (device dm-3): found
71735 extents, stage: update data pointers
...
Mar 25 20:52:56 computerName kernel: BTRFS info (device dm-3): found
71746 extents, stage: move data extents
...
Mar 25 20:51:46 computerName kernel: BTRFS info (device dm-3):
relocating block group 4324327424 flags data
...
Mar 25 20:51:00 computerName kernel: BTRFS info (device dm-3): found
53063 extents, stage: update data pointers
...
*****
Kernel 5.8.7
Drive: 1.5 TB (mechanical)
btrfs-progs: 5.10.1
*****
$ sudo btrfs filesystem usage /<btrfsPath>
Overall:
    Device size:                   1.29TiB
    Device allocated:              1.14TiB
    Device unallocated:          147.68GiB
    Device missing:                  0.00B
    Used:                          1.14TiB
    Free (estimated):            150.08GiB      (min: 76.24GiB)
    Free (statfs, df):           150.08GiB
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:1.13TiB, Used:1.13TiB (99.79%)
   /dev/mapper/<btrfsPath>    1.13TiB

Metadata,DUP: Size:5.00GiB, Used:3.91GiB (78.14%)
   /dev/mapper/<btrfsPath>   10.00GiB

System,DUP: Size:32.00MiB, Used:160.00KiB (0.49%)
   /dev/mapper/<btrfsPath>   64.00MiB

Unallocated:
   /dev/mapper/<btrfsPath>  147.68GiB
*****

The approximate steps I took was:
1) Run filefrag to find the worst offenders.
2) Run btrfs defrag on those with the highest extents
3) Cut out commercials on recorded television programs
4) Run btrfs defrag on the TV directory
5) Run filefrag on /var
6) Pick on "/var/lib/sddm/.cache/mesa_shader_cache/index" as a test
and run btrfs defrag
7) Ponder why I can't get a small (1MB) file down to 1 extent instead of 83.
8) Run btrfs balance (--full-balance) on
"/var/lib/sddm/.cache/mesa_shader_cache/" (assuming it's actually
balancing the entire drive rather than only that dir)
9) Change the mount options in fstab to
"rw,relatime,space_cache=v2,autodefrag" where
"space_cache=v2,autodefrag" was added and "subvolid=5,subvol=/" was
removed. Maybe "v2" explains the temporary "free space" messages, but
not the gnarly crash.
10) Freak out when I see my system crashed hard after 1+ day(s) of
balancing. (Unrelated to the fstab change since I hadn't
rebooted/remounted the drive yet)
11) Scrub the drive and be happy it came back with "Error summary:
no errors found".

My next step after hearing I should be safe now (or what action you
want me to take) will be to:
*****
$ OLDIFS=$IFS
$ IFS=$'\n'
$ find /<btrfsPath> -xdev -type f -print0 | xargs -0 filefrag
2>/dev/null | sed 's/^\(.*\): \([0-9]\+\) extent.*/\1/' | awk -F ' '
'$1' | sort -n | for eachFile in $(cat); do btrfs filesystem
defragment -v $eachFile ; done
$ IFS=$OLDIFS
$ btrfs balance -v start /<btrfsPath>
*****
... with the intent of defragmenting (aligning) files from
smallest->largest to hopefully get them all down as close to 1 extent
as possible. I'm open to hearing why my hope isn't going to happen.
I'd think with ~150 GB remaining, it should be doable.
Ideally, what I'd look to do is perform those defragment steps in such
a way that the oldest files with the oldest modifications would all be
moved to the slowest access region of the disk, and the opposite would
be true (newest created/modification -> fastest). I'm sure that level
of control doesn't exist though.
I liked that visual representation that Windows gave so many years ago
when defragmenting, giving me hope that file runs were being
minimized. Of course that "minimizing" means more (is practical) than
the visual.
