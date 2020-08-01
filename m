Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F842350D4
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Aug 2020 08:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgHAGvd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Aug 2020 02:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgHAGvb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Aug 2020 02:51:31 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AACC06174A
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jul 2020 23:51:30 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s16so19358506ljc.8
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jul 2020 23:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fandingo-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=X5VLd41NPnZPXbDzpqa6KU0oMMvnzZf0BM0AjoVY5lw=;
        b=joxzQx5MdQejTKro4ZL39X7SE5QDjBUnK7ZLLfQYCaaX580ZddyOMvjZ6oGX4GVCeg
         ZNasDsUuODfzEQpQp5dopESD9y/J7fcTTL47n2dApZuqq+seCsURUO85ZQyXF3OMNRo6
         lZ6BXCgjDrPGdVarRVn+d0ckSZhJfYgJMEi0c6cthc/b9QlHmpxrDUQ8QWKo5Qkq6KFR
         39HpthY/RfjahXDTjxMQ3HaJ0yBEYL4ZOtG+QZWUnjNr8nXSD6HTGMGmP6oq1r8TeDUP
         mYJNHpFrgXUDlfuphw87/K5aAS2imDhqpfYd08vx+GsJJcYFwpP1PW607dtz0Fy+SamW
         QxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=X5VLd41NPnZPXbDzpqa6KU0oMMvnzZf0BM0AjoVY5lw=;
        b=Gl/g//KqJJEiIj8uAJxcb2PtZgXemGowUHuXwENpHq7ViIMmy4074e3366sqNc1teI
         2MDP4V/wwOib2mWyVG0eyz+XcmhyJhlbdPcjE/P6+coHYGwzoRl0jpsaZjLX1IceVzwp
         m6kW+BV4ABuKG+PLBehjZs0VwRZwxEwo7pwycW5oCdghFQZnVLue+gSbA95U4IoTURHk
         6KujSTpxlmZYgxOVk9QpxqyzMAZ5S27Cf3CpDOF34bo+bs0iP+N3Vf+cTqblDQAYiJfo
         kquhhNWXqNLGTHM4z54UT8Jh2ie5N3+sfziCOc28J+zDGHJuNE7JpmhJY8nR9MJzhnL7
         rOkQ==
X-Gm-Message-State: AOAM532Leo5DQvjMAIE67dE7GYBYj9vZIBzhF2yXzoJkGgwoJrM41yAi
        Pk2d1FLW4Gw0dvu4PdqItMbCdD9lkCPQFWLd9Cfna90GprU=
X-Google-Smtp-Source: ABdhPJxreEKuMzLCk+ereSeGrV5qbruFcW/0uSsQhycg3/+JwMq356Ustpf094e+ew8vCMVo720laKshJdR0QJiOPGs=
X-Received: by 2002:a2e:9d4a:: with SMTP id y10mr3305078ljj.104.1596264688449;
 Fri, 31 Jul 2020 23:51:28 -0700 (PDT)
MIME-Version: 1.0
From:   Justin Brown <Justin.Brown@fandingo.org>
Date:   Sat, 1 Aug 2020 01:51:16 -0500
Message-ID: <CAKZK7uwRs_tf6htRtJvw3kNhyNPMJ-juA6_WSJo+PbQA7f40Cg@mail.gmail.com>
Subject: Access Beyond End of Device & Input/Output Errors
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I've run into a strange problem that I haven't seen before, and I need
some help. I started getting generic "input/output" errors on a couple
of files, and when I looked deeper, the kernel logs are full of
messages like:

    sd 5:0:0:0: [sdf] tag#29 access beyond end of device

I've never seen anything like this before with any FS, so I figured it
was worth asking before I consider running the standard btrfs tools.
(I briefly started a scrub, but it was going crazy with uncorrectable
errors, so I cancelled it.)

Here's my system info:

Fedora 32, kernel 5.7.7-200.fc32.x86_64
btrfs-progs v5.7

/etc/fstab entry:
LABEL=media /var/media btrfs subvol=media,discard 0 2

btrfs fi show /var/media/
Label: 'media' uuid: 51eef0c7-2977-4037-b271-3270ea22c7d9
Total devices 6 FS bytes used 4.68TiB
devid 1 size 1.82TiB used 963.00GiB path /dev/sdf1
devid 2 size 1.82TiB used 962.00GiB path /dev/sde1
devid 4 size 1.82TiB used 963.00GiB path /dev/sdg1
devid 6 size 1.82TiB used 962.03GiB path /dev/sda1
devid 7 size 7.28TiB used 967.03GiB path /dev/sdb1
devid 8 size 7.28TiB used 967.03GiB path /dev/sdd1

btrfs fi df /var/media/
Data, RAID5: total=4.69TiB, used=4.68TiB
System, RAID1C3: total=32.00MiB, used=304.00KiB
Metadata, RAID1C3: total=6.00GiB, used=4.94GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

I can only mount -o degraded now. Here are the logs when mounting:

Aug 01 01:15:26 spaceman.fandingo.org sudo[275572]: justin : TTY=pts/0
; PWD=/home/justin ; USER=root ; COMMAND=/usr/bin/mount -t btrfs -o
degraded /dev/sda1 /var/media/
Aug 01 01:15:26 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#30
access beyond end of device
Aug 01 01:15:26 spaceman.fandingo.org kernel: blk_update_request: I/O
error, dev sdf, sector 2176 op 0x0:(READ) flags 0x0 phys_seg 1 prio
class 0
Aug 01 01:15:26 spaceman.fandingo.org kernel: Buffer I/O error on dev
sdf1, logical block 16, async page read
Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
sde1): allowing degraded mounts
Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
sde1): disk space caching is enabled
Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS warning (device
sde1): devid 1 uuid cb05aae6-6c03-49d3-b46d-bf51a0eb8cd0 is missing
Aug 01 01:15:26 spaceman.fandingo.org kernel: BTRFS info (device
sde1): bdev /dev/sdf1 errs: wr 4458026, rd 14571, flush 0, corrupt 0,
gen 0

It seems like only relatively recently written files are encountering
I/O errors. If I `cat` one of the problematic files when the FS is
mounted normally, I see a ton of this:

Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#26
access beyond end of device
Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#27
access beyond end of device
Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#28
access beyond end of device
Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#29
access beyond end of device
Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#30
access beyond end of device
Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#0
access beyond end of device
Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#1
access beyond end of device
Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#13
access beyond end of device
Aug 01 01:13:49 spaceman.fandingo.org kernel: sd 5:0:0:0: [sdf] tag#2
access beyond end of device

Now that I'm remounted in -o degraded, I'm getting more comprehensible
warnings, but it still results in I/O read failures:

Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
sde1): csum failed root 2820 ino 747435 off 99942400 csum 0x8941f998
expected csum 0xbe3f80a4 mirror 2
Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
sde1): csum failed root 2820 ino 747435 off 99946496 csum 0x8941f998
expected csum 0x9c36a6b4 mirror 2
Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
sde1): csum failed root 2820 ino 747435 off 99950592 csum 0x8941f998
expected csum 0x44d30ca2 mirror 2
Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
sde1): csum failed root 2820 ino 747435 off 99958784 csum 0x8941f998
expected csum 0xc0f08acc mirror 2
Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
sde1): csum failed root 2820 ino 747435 off 99954688 csum 0x8941f998
expected csum 0xcb11db59 mirror 2
Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
sde1): csum failed root 2820 ino 747435 off 99962880 csum 0x8941f998
expected csum 0x8a4ee0aa mirror 2
Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
sde1): csum failed root 2820 ino 747435 off 99971072 csum 0x8941f998
expected csum 0xdfb79e85 mirror 2
Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
sde1): csum failed root 2820 ino 747435 off 99966976 csum 0x8941f998
expected csum 0xc14921a0 mirror 2
Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
sde1): csum failed root 2820 ino 747435 off 99975168 csum 0x8941f998
expected csum 0xf2fe8774 mirror 2
Aug 01 01:31:53 spaceman.fandingo.org kernel: BTRFS warning (device
sde1): csum failed root 2820 ino 747435 off 99979264 csum 0x8941f998
expected csum 0xae1cafd6 mirror 2

Why trying to research this problem, I came across a Github issue
https://github.com/kdave/btrfs-progs/issues/282 and a patch from Qu
from yesterday ([PATCH] btrfs: trim: fix underflow in trim length to
prevent access beyond device boundary). I do use the discard mount
option, and I have a weekly fstrim.timer enabled. I did replace 2x2TB
drives with the 2x8TB drives about 1 month ago, which involved a
conversion to -d raid5 -m raid1c3, which I suppose could hit the same
code paths that resize2fs would?

Any advice on how to proceed would be greatly appreciated.

Thanks,
Justin
