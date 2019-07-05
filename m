Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B5F60D3C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 23:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfGEVn1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 17:43:27 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:35282 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfGEVn1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jul 2019 17:43:27 -0400
Received: by mail-wm1-f54.google.com with SMTP id l2so3672762wmg.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2019 14:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyYF1PqVgVNp0UDqaXZk4DXCGbYDF9FLZ6S8gwiprSo=;
        b=q4gRvOIidhkTDqIfQ55uI7iXCvjrB8bNUT8ozQ6J3NBCD0h34jT5kZhwVL46//59bH
         borL4tQMFDValt7erfZP4sNwS463BjOY8A7uq5dFFR66jsm6B/j8Zl/zeDZITpYSfmoS
         /inqlgpS6si5GWMJML8tgtfTchbtqyl85Uay15O5TI8mIY7UOdb2y4wtnF2QDrD2oUgC
         LD5y+biDsOgy7WczYa4RQBytx63oEKBxYRQAmfx4x/Sstu58126yTXbVnZWBYHApDbVO
         atU5WZEC3n9MDQI1FVVmRVZU276+9Ah+1/omT05fGAoXuedCGvhNqwoz37wY8QC5u0T/
         pcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyYF1PqVgVNp0UDqaXZk4DXCGbYDF9FLZ6S8gwiprSo=;
        b=MS9VONfV/Srimszd2dLKFOHgX6vgrBu6WOYiAAIzJY/kbE/kIPeQXzhKEf3RBD1Ppc
         HY7GRMzpeQ/wnbUbIiP06t01oa691jLZJlVIEJ5PZrBcTtrE+2GDHo38R6IxEFpvsNqe
         /oUonP+s7YmUL0y93L6sQMymSBW/vMeW0R1YzJMiW5l1S2plxu+EuUe7aJmZwjqR2yRr
         bdU4h28lHWCWNLnhvlUQz0wTZ90Yjvj0qRNorY23Lj5p0E0rVEcwwKUQ0NGGVCDc1aeq
         uth2go7uYYDV+OGwZ2FiuLy/YMb0YW1JHa2dM0WwcH5Ku2NGjWJPjjixd/bWvy9KxNyG
         OBqQ==
X-Gm-Message-State: APjAAAXXD+t040tL60vVMrFGu+8+uBM8WmMNLHro1DYVgtgFSnauxO7Z
        kYNARtAq/Uas3x/yY6qouEV0HZETt6kVgELJkZ4Pcw==
X-Google-Smtp-Source: APXvYqxlWUPAmv4NpgcFAzK3FUY9/PltXITta2uyQ/XLUdPHjAZv/VuBnySCMJySBG/g6KD+cQr2e3dGX8Qq2NmbNEk=
X-Received: by 2002:a1c:f018:: with SMTP id a24mr4593048wmb.66.1562363004482;
 Fri, 05 Jul 2019 14:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
In-Reply-To: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 5 Jul 2019 15:43:13 -0600
Message-ID: <CAJCQCtRhXukLGrWTK1D5TLRhxwF6e31oewOSNDg2TAxSanavMA@mail.gmail.com>
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
To:     Vladimir Panteleev <thecybershadow@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 4, 2019 at 10:39 PM Vladimir Panteleev
<thecybershadow@gmail.com> wrote:
>
> Hi,
>
> I'm trying to convert a data=RAID10,metadata=RAID1 (4 disks) array to
> RAID1 (2 disks). The array was less than half full, and I disconnected
> two parity drives, leaving two that contained one copy of all data.

There's no parity on either raid10 or raid1. But I can't tell from the
above exactly when each drive was disconnected. In this scenario you
need to convert to raid1 first, wait for that to complete successfully
before you can do a device remove. That's clear.  Also clear is you
must use 'btrfs device remove' and it must complete before that device
is disconnected.

What I've never tried, but the man page implies, is you can specify
two devices at one time for 'btrfs device remove' if the profile and
the number of devices permits it. So exactly the order and commands
you've used is really important to understand the problem and solution
including whether there might be a bug.


>
> After stubbing out btrfs_check_rw_degradable (because btrfs currently
> can't realize when it has all drives needed for RAID10),

Uhh? This implies it was still raid10 when you disconnected two drives
of a four drive raid10. That's definitely data loss territory.
However, your 'btrfs fi us' command suggests only raid1 chunks. What
I'm suspicious of is this:

>>Data,RAID1: Size:2.66TiB, Used:2.66TiB
>>  /dev/sdd1   2.66TiB
>>  /dev/sdf1   2.66TiB

All data block groups are only on sdf1 and sdd1.

>>Metadata,RAID1: Size:57.00GiB, Used:52.58GiB
>>   /dev/sdd1  57.00GiB
>>  /dev/sdf1  37.00GiB
>>   missing  20.00GiB

There's metadata still on one of the missing devices. You need to
physically reconnect this device. The device removal did not complete
before this device was physically disconnected.

>> System,RAID1: Size:8.00MiB, Used:416.00KiB
>>   /dev/sdd1   8.00MiB
>>   missing   8.00MiB

This is actually worse, potentially because it means there's only one
copy of the system chunk on sdd1. It has not been replicated to sdf1,
but is on the missing device. So it definitely sounds like the missing
device was physicall removed before 'device remove' command finished.

Depending on degraded operation for this task is the wrong strategy.
You needed to 'btrfs device delete/remove' before physically
disconnecting these drives.


>I've
> successfully mounted rw+degraded, balance-converted all RAID10 data to
> RAID1, and then btrfs-device-delete-d one of the missing drives. It
> fails at deleting the second.

OK you definitely did this incorrectly if you're expecting to
disconnect two devices at the same time, and then "btrfs device delete
missing" instead of explicitly deleting drives by ID before you
physically disconnect them.

It sounds to me like you had a successful conversion from 4 disk
raid10 to a 4 disk raid1. But then you're assuming there are
sufficient copies of all data and metadata on each drive. That is not
the case with Btrfs. The drives are not mirrored. The block groups are
mirrored. Btrfs raid1 tolerates exactly 1 device loss. Not two.


-- 
Chris Murphy
