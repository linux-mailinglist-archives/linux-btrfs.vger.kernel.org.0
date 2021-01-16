Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02F72F8F61
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jan 2021 22:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbhAPVIy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jan 2021 16:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbhAPVIw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 16:08:52 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E56C061573
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 13:08:12 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id h4so15324889qkk.4
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 13:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7WiDZMhT+FuOYgC043yx/Oo9rkdXp2l+H1SUNl257pI=;
        b=LQAwXaOWDxbRO2h8FNJQqtuJpB1XHwX7k+GyOyowDzOOxZ0NewmLHNJD6NyPOp5bgh
         6AB1zNPatfzIweqJ71sA+KsKPPV9QWGX+rM3iO1Sr8Mog2S3b3ohrr/qk2j9H2Akuyc0
         4Yzre9QihPjJQLtBX55lHHUwqN4i+2rcl7VYrjYZ0nrxFQ73XFverZqaNkYf9rO3HlW8
         fw5AGExJ0mVs9q2G+qwxf6DOHjdFmupXEj6hVcQCuMHfYJlzrJZiZPNn+MA19jFna3iD
         GyVkEy6fOyJuF6MKRjKN8+trUabNZK2g280wuj+5zxj8mOUgIMls1LA1WsXsW4+ThQWu
         4TdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7WiDZMhT+FuOYgC043yx/Oo9rkdXp2l+H1SUNl257pI=;
        b=rnjO2SxtA6qhEIElkuq6PEDRWlebXwxzCW3nWwwrDNpHPGdaRSjGW3Y+wphroL/Xnx
         Bm+GHgMvmkWb4GiQhDpStAQ/K48x9xB4tysHx6QZGzv6DCWhRjvtYXyMgILMo0oEqzFY
         CLKlqGriqGRxM1zeEXULF2ytbQSNcqhLm6/K2qO0sE0F/lXCpJStkZJ6WK8rke15OCcF
         5Vr9VReHnPCH1UOKcZHw4Z5V6oSRQcVaZ6+88DzsnvZcaAPbwZvF6y0zVHbHkqfifnjX
         CXnINO6C4bZlXZrWUB2B7iKm20bCgDTZTHQsb+YLknKtwYYLCAZh8qbL8Ix4JilR+goO
         icgQ==
X-Gm-Message-State: AOAM530Y+QexQqy2+XGMDiRg+QWBY3ADv3LKlqpDH+lOCf2+SNjywgLP
        vC+MyRcgZIPQOEU92n+33A5xsOeDXrZLhQWqqyP7SrTlLRg=
X-Google-Smtp-Source: ABdhPJyvCJk4B4IXIgbaEIWLePmhvzI2z5jHaCzKmcKXx15TCmFkn/x4vIUk8x5mTjcv1ctVtILt6zWUwVZnozaw+CU=
X-Received: by 2002:a05:620a:62b:: with SMTP id 11mr18099154qkv.229.1610831291228;
 Sat, 16 Jan 2021 13:08:11 -0800 (PST)
MIME-Version: 1.0
From:   Tim Cuthbertson <ratcheer@gmail.com>
Date:   Sat, 16 Jan 2021 15:08:00 -0600
Message-ID: <CAAKzf7kPv_CmzrMDD8SupbfFGyABvcDqWXg4yZBzBx-QBY6yMw@mail.gmail.com>
Subject: raid0 confusion question
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I thought raid0 "striped" the data across two or more devices to
increase total capacity, for example when adding a new device to an
existing filesystem. But that is not apparently what I ended up with.

Before:
btrfs device usage /mnt/backup/
/dev/sdc1, ID: 1
   Device size:           300.00GiB
   Device slack:              0.00B
   Data,single:           226.01GiB
   Metadata,DUP:            8.00GiB
   System,DUP:             64.00MiB
   Unallocated:            65.93GiB

/dev/sdc2, ID: 2
   Device size:           300.00GiB
   Device slack:              0.00B
   Data,single:             1.00GiB
   Unallocated:           299.00GiB

Then, I ran command:
btrfs balance start -dconvert=raid0 -mconvert=raid1 /mnt/backup

And what I ended up with seems to be double the amount of data used,
like what I think would happen with raid1, not raid0:

btrfs device usage /mnt/backup/
/dev/sdc1, ID: 1
   Device size:           300.00GiB
   Device slack:              0.00B
   Data,RAID0:            228.00GiB
   Metadata,RAID1:          5.00GiB
   System,RAID1:           64.00MiB
   Unallocated:            66.94GiB

/dev/sdc2, ID: 2
   Device size:           300.00GiB
   Device slack:              0.00B
   Data,RAID0:            228.00GiB
   Metadata,RAID1:          5.00GiB
   System,RAID1:           64.00MiB
   Unallocated:            66.94GiB

Or, am I misinterpreting what I am seeing? Thank you.

# uname -a
Linux tux 5.10.7-arch1-1 #1 SMP PREEMPT Wed, 13 Jan 2021 12:02:01
+0000 x86_64 GNU/Linux
# btrfs --version
btrfs-progs v5.9
# btrfs fi show
Label: none  uuid: c0f4c8e2-b580-4c0d-9562-abdb933b9625
        Total devices 1 FS bytes used 13.11GiB
        devid    1 size 449.51GiB used 14.01GiB path /dev/sda3

Label: none  uuid: 4fe39403-7ba1-4f22-972f-5041e3b6ff6f
        Total devices 1 FS bytes used 37.36GiB
        devid    1 size 600.00GiB used 40.02GiB path /dev/sdb1

Label: none  uuid: 1751eeca-c1a2-47bb-906b-c7199b09eb6d
        Total devices 2 FS bytes used 229.57GiB
        devid    1 size 300.00GiB used 233.06GiB path /dev/sdc1
        devid    2 size 300.00GiB used 233.06GiB path /dev/sdc2

# btrfs fi df /mnt/backup
Data, RAID0: total=456.00GiB, used=226.65GiB
System, RAID1: total=64.00MiB, used=64.00KiB
Metadata, RAID1: total=5.00GiB, used=2.92GiB
GlobalReserve, single: total=401.84MiB, used=0.00B
