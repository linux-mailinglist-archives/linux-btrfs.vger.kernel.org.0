Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904F82C5C13
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Nov 2020 19:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405017AbgKZSeC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 13:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404973AbgKZSeC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 13:34:02 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D13C0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Nov 2020 10:34:01 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f190so312616wme.1
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Nov 2020 10:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=L0p7LNzDD7oYOzNzGEE8FJt9E9z+njXJRoRwzDYvLfY=;
        b=C/lqaqx6wCxnZ/Vryd/A/v6pL4UA0EzuV35R6NWT3bFCPN6c+Ng4QAfWMzZhdkyVl2
         hXcN4pTX2Hni5vHCK2SjT/E4htNYZ93AXW8zFgPMWKjqSPtfaWzXzZl0EaRNiYSX8YRD
         cp4/3J8ZlcbkM9k70XDW5d0KVtgfUQltqlg5hvmqvtA0Ut9nSsatsSMYTj2kXO/I81jf
         5fPsWTW62neNtvIQBjbfDdAE936OliN1NuTMFdAZwF9vE0HoEaYUHZlqKOVsLTADUgtA
         qlWhw/9/lj43jjWiT5zXTHb4p4YK6L+hF1dyPvS2iNbUorbqq8g4TAEoy7W+R9pF5UNW
         lSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=L0p7LNzDD7oYOzNzGEE8FJt9E9z+njXJRoRwzDYvLfY=;
        b=KAN5SQXyaqcZPVTluHxECF1czZXbYhd0mguMfPZTENV7fqp2YmEqohbqNr9DuZDKMK
         DleAS8lqHFP7F368K81xfHurlWZhZQ8bA+8Uqj2I9VBLT/oQd4XONjOGPVZeU0hVL3PG
         Iw+K0GNur5sJDrrn6VTQNxdxxkhcdHbKlrhaAz+DXj50bCP+IoOvw7UKlJeS9RCnls1Y
         I0xLO5nfBrFzxAKlyA3Z+emfoWOeLC5OoiIPYYoqt+zXzwtao84xDPgA+NHGVyjC0xj1
         +5jdjvgGcvMmmha94lJODkDQQuxEWy9gh424QVuX8y7irj3DPV9LV3lrZ1Y355CcdmZb
         p8Rg==
X-Gm-Message-State: AOAM531yzMQ9MtRybh++g2D3QGdpHMd9RhXu9GbVGgndZ9potuWmlXvT
        +PUJILXawd7zGLuxSVcR9RCZ7qfKRo/4vQ==
X-Google-Smtp-Source: ABdhPJzWXSQXPZGzvFFzMRNd8OOsQ6b/pmgyZv3IFDQJ6/QzuOe9xi6DtYqteme2GZAH+zQ42i3FMg==
X-Received: by 2002:a1c:7719:: with SMTP id t25mr4795500wmi.59.1606415640147;
        Thu, 26 Nov 2020 10:34:00 -0800 (PST)
Received: from ?IPv6:2a02:6d40:2b80:c700:2a13:9ad0:ca7d:5861? ([2a02:6d40:2b80:c700:2a13:9ad0:ca7d:5861])
        by smtp.googlemail.com with ESMTPSA id w186sm10006982wmb.26.2020.11.26.10.33.59
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 10:33:59 -0800 (PST)
To:     linux-btrfs@vger.kernel.org
From:   Oliver Freyermuth <o.freyermuth@googlemail.com>
Subject: Safe unmounting of external btrfs disk
Message-ID: <fef04da3-fb9e-aca6-4bd4-965a1263c45e@googlemail.com>
Date:   Thu, 26 Nov 2020 19:33:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear BTRFS experts,

I've had a rather strange occurence with my external BTRFS backup disk last night,
which makes me question what is the correct way to safely remove a USB drive with BTRFS on it.

Here's the timeline:
- 02:00:00 am: btrbk starts running.
- 02:01:17 am: btrbk deletes the last old subvolume from the disk
                (I have btrfs_commit_delete = no, so the delayed deletion basically starts some time after).
- ~02:18 am: I performn an "umount" of the disk.
- ~02:18:43 am: I unplug the USB drive.
- 02:25:05 am: My kernel tells me this:
[19268.944902] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
[19268.944904] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
[19268.944926] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 3, rd 0, flush 0, corrupt 0, gen 0
[19268.944926] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 4, rd 0, flush 0, corrupt 0, gen 0
[19268.944938] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 5, rd 0, flush 0, corrupt 0, gen 0
[19268.944938] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 6, rd 0, flush 0, corrupt 0, gen 0
[19268.944963] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 7, rd 0, flush 0, corrupt 0, gen 0
[19268.944964] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
[19268.944973] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 9, rd 0, flush 0, corrupt 0, gen 0
[19268.944974] BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 10, rd 0, flush 0, corrupt 0, gen 0
[19268.946460] BTRFS: error (device sdc1) in btrfs_commit_transaction:2327: errno=-5 IO failure (Error while writing out transaction)
[19268.946461] BTRFS info (device sdc1): forced readonly
[19268.946462] BTRFS warning (device sdc1): Skipping commit of aborted transaction.
[19268.946463] BTRFS: error (device sdc1) in cleanup_transaction:1898: errno=-5 IO failure
[19268.946483] BTRFS error (device sdc1): commit super ret -5

What's worrisome is that this happened 7 minutes after the device was unmounted and unpluggied.
I use Kernel 5.9.11 and the following mount options on the backup disk:
  space_cache=v2,noatime,compress-force=zstd:6,commit=120,subvolid=0,noauto

Reconecting the disk, I do not see any subvolumes still pending deletion.

The good news: It seems the filesystem did not suffer at all,
probably since the whole transaction never reached the disk.

Is this behaviour expected?
If yes, how to "unmount" correctly (btrfs filesystem sync only seems to work on mounted filesystems)?
I believe udisks unmounts and then quickly removes power, so this would basically be similar to what I did manually here.

I've never seen this on earlier kernels, but I don't check my kernel logs each time, and don't unmount before shutdown each time,
so I can't state where this is a kernel version dependent issue.

Cheers,
	Oliver
