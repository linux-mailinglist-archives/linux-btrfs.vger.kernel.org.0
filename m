Return-Path: <linux-btrfs+bounces-610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1710804B79
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 08:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9F01F214C4
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 07:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC94430D1F;
	Tue,  5 Dec 2023 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZW9MXqJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8CECB
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 23:51:56 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6d87a8228e0so1220748a34.1
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Dec 2023 23:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701762715; x=1702367515; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ffn/rS6LjWuEm7b+6Ws5nNlAjr3VStp6Mz0ExGHnNQc=;
        b=IZW9MXqJvm1cFZNZCZgqJLrJfIp3yWl/UoCL6fDcApi2WOOyfbi/ezbSd4r4/xxyiT
         y184wiMgXDm9TWGBEPGt07ySQDkWvxy5fuqNIOyY1ER6KARSmeGKDBkCJrGaEFNB92se
         AVS8a4uhIsKIdd4oE1ozvrF2AWF0GX/amCBTfuIcy/sZdJTwKhqN9Ob1iX+puoSHRWNT
         tgEPQK6Y6qj0qhlTcuAKfrz+OjtlLCrWe5oThzedcoaS6bKLKWNQU5Bfl9N4vDFgk2vD
         uh7scaZJ1izx1fXJ8lBqIViVtBf/TXY5gE4MtDjJrSwIOsVSzMCkGDa/NTQwTvMb6+Hl
         v0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701762715; x=1702367515;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffn/rS6LjWuEm7b+6Ws5nNlAjr3VStp6Mz0ExGHnNQc=;
        b=TY584fz157xWgyTKe7jOhtS5LPAZUXEXQ5awvp2rj/d2TtKMnOH9zz9b0qobSh2OJa
         pwbg3GztdK5JVmcDMws5cJQddRD/ujYRe7H+T5F6ad6BC5Gm27S9icgSV+/9C4tMzCND
         6rGjBJHiKkykeoY6Vssd/drnys3tC2G8LvtTR5NNb6Zj8XmI/N8F8qrd6+Ekt2t90G3J
         0TN4FU4wZpivGMJG8b9C+WzYoIKbWGso8O+tWV3Et5C9Rd2sgxT+udwe7jK+AW1axiXA
         BX7PKJ4pKKB+4dHbinLJVdCteLbwiLeB4FRckI8GuXhhfG3a5Iw9Og4MFtyc+CCgF7xS
         Mi3A==
X-Gm-Message-State: AOJu0YyC8eLvPEfi0OiMgvATF04Z2EdkwOTnKPcv2ekIMS0f83mJsec3
	QAWCWcqGLqdy+NJxStqs1Rp3LTqyqTMvQsstjnRr9oAbC9U=
X-Google-Smtp-Source: AGHT+IE7lP+nHlw9iR7XH4JIemchDu3hnib7O2oPFMvuiqqwkHB6fU/dlVcz+DifCYiUGhb78Ae1/pja+IWAZvDkMmQ=
X-Received: by 2002:a05:6870:a546:b0:1fa:e0df:600d with SMTP id
 p6-20020a056870a54600b001fae0df600dmr3227617oal.9.1701762715530; Mon, 04 Dec
 2023 23:51:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stefan N <stefannnau@gmail.com>
Date: Tue, 5 Dec 2023 18:21:44 +1030
Message-ID: <CA+W5K0r4Jkhwm2ztJYwKQ1w91Cb0tObcd4PA6bLDOH18xbmYAg@mail.gmail.com>
Subject: scrub: unrepaired sectors detected
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'm having trouble getting an array to perform a scrub or replace, and
would appreciate any assistance. I have two empty disks I can use to
move things around, but the intended outcome is to use them to replace
two of the smaller disks.

$ uname -a ; btrfs --version ; btrfs fi show
Linux $hostname 6.5.0-13-generic #13-Ubuntu SMP PREEMPT_DYNAMIC Fri
Nov  3 12:16:05 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
btrfs-progs v6.3.2
Label: none  uuid: 3cde0d85-f53e-4db6-ac2c-a0e6528c5ced
        Total devices 8 FS bytes used 71.32TiB
        devid    1 size 16.37TiB used 16.37TiB path /dev/sdg
        devid    2 size 10.91TiB used 10.91TiB path /dev/sdf
        devid    3 size 16.37TiB used 16.36TiB path /dev/sdd
        devid    4 size 16.37TiB used 12.54TiB path /dev/sda
        devid    5 size 10.91TiB used 10.91TiB path /dev/sde
        devid    6 size 10.91TiB used 10.91TiB path /dev/sdc
        devid    7 size 16.37TiB used 16.37TiB path /dev/sdh
        devid    8 size 10.91TiB used 10.91TiB path /dev/sdb

$ btrfs fi df /mnt/point/
Data, RAID6: total=71.97TiB, used=71.23TiB
System, RAID1C3: total=36.00MiB, used=6.62MiB
Metadata, RAID1C3: total=91.00GiB, used=85.09GiB
GlobalReserve, single: total=512.00MiB, used=0.00B
$

Attempting to scrub
BTRFS error (device sdg): unrepaired sectors detected, full stripe
145926853230592 data stripe 2 errors 5-13
BTRFS info (device sdg): scrub: not finished on devid 2 with status: -5

Scrub device /dev/sdf (id 2) canceled
Scrub started:    Thu Nov 30 08:01:03 2023
Status:           aborted
Duration:         32:17:10
        data_extents_scrubbed: 89766644
        tree_extents_scrubbed: 0
        data_bytes_scrubbed: 5856020676608
        tree_bytes_scrubbed: 0
        read_errors: 0
        csum_errors: 0
        verify_errors: 0
        no_csum: 0
        csum_discards: 0
        super_errors: 0
        malloc_errors: 0
        uncorrectable_errors: 0
        unverified_errors: 0
        corrected_errors: 0
        last_physical: 7984173809664

Attempting to do replace using brand new disks, failed at ~50%, ran
twice with two different pairs of disks
Disk /dev/sdi: 16.37 TiB, 18000207937536 bytes, 35156656128 sectors
Disk /dev/sdl: 16.37 TiB, 18000207937536 bytes, 35156656128 sectors

BTRFS error (device sdg): unrepaired sectors detected, full stripe
145926853230592 data stripe 2 errors 5-13
BTRFS error (device sdg): btrfs_scrub_dev(/dev/sdf, 2, /dev/sdl) failed -5

The data is fairly replaceable so typically have been previously been
deleting files that fail checks and performing roughly 3-monthly
scrubs and weekly balances (musage/dusage=50).

Any help would be appreciated!

Cheers,

Stefan

