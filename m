Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7779F27DDF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgI3Bot (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgI3Bot (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:44:49 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5C1C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Sep 2020 18:44:48 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id b17so18336ilr.12
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Sep 2020 18:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=O7sVte+xRxqWOGprSEH8qE4lhcpkImhUuchpVQ9+5VI=;
        b=SJJOiTIWvq1tC8VowAdRfVfOaBZECBHptYzm8GqHmz9vXsncWj2UjUDOv/3c/ffMaE
         n/cOBdoVJx0Qb1oxNWQWutw6gDBuInJEAUChuNXfOk00mPEBxliWi4fZYljz2X/a7uAw
         znJar7rht9wTORUx1KLloS0EQtgTX/sNulJcXH6SE0KauLeh8DMjax1FK4hprHLoV3Um
         u0J76fDwiJyjmNzN3b1tiLbS66Ztq46JCAapuRl/Ip9bDjqV0ol09CNkVRbICY8N3KGG
         opmQ5WrRjC9n/CbcabkJQOFlEm4D5QTKlNfKsmMi0rJv96QNFnVDxJHQm57dTRZOsvZl
         h2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=O7sVte+xRxqWOGprSEH8qE4lhcpkImhUuchpVQ9+5VI=;
        b=gRNcQ28OvL1e5/4xfeFTsuAPOswc4OzMiySRvKJOqFk3796zV/lBX3YO702nub67rs
         U2GhcPwpf3jgrIAEGFd7xjyACKcGhLgkAHDjOgiRZbcUfgdVhICSGwVT+9rJ7cWYZpXX
         tTbd5zIDhMcnh0Vu90cGrAgoG2Vyh3ZRe5rg0m3TZOy8bm2VdegOZXb/4IOVquLfp49A
         lT/uiRy/l3JuJXGXGeNx1sFg9QRSMBh3/z7/OFHGtwe6oYEqO5KCKqPW/0TRhOWuvf8r
         Delb83ervIPuMggle2vvMQ24junCSJNbaI8zNZfLK/Ov2/RWfLlZPL7Y9JkY3Oe+p9Kj
         6CVg==
X-Gm-Message-State: AOAM530DlETFtTw7y++VW5/5+SQEn1Wkzpm9QrxsDWadSyDKdBMU/la7
        l8Bdrp0UAKxTrSQSbYXJJnnDxHv+wKXC3kWcur7Zy1LvbXcjRot5
X-Google-Smtp-Source: ABdhPJwjl4au/tZw+pnw7RgWZn1BIlVpwAhNMsbwYowx6oX29KzwtBcU82gK3cGssF+EtZk3mnfj58K+yQoI9sJW4VM=
X-Received: by 2002:a92:d08f:: with SMTP id h15mr115547ilh.27.1601430287392;
 Tue, 29 Sep 2020 18:44:47 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Levy <ericlevy@gmail.com>
Date:   Tue, 29 Sep 2020 21:44:36 -0400
Message-ID: <CA++hEgx2x=HjjUR=o2=PFHdQSFSqquNffePTVUqMNs19sj_wcQ@mail.gmail.com>
Subject: ERROR... please contact btrfs developers
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I recently upgraded a Linux system running on btrfs from a 5.3.x
kernel to a 5.4.x version. The system failed to run for more than a
few minutes after the upgrade, because the root mount degraded to a
read-only state. I continued to use the system by booting using the
5.3.x kernel.

Some time later, I attempted to migrate the root subvolume using a
send-receive command pairing, and noticed that the operation would
invariably abort before completion. I also noticed that a full file
walk of the mounted volume was impossible, because operations on some
files generated errors from the file-system level.

Upon investigating using a check command, I learned that the file
system had errors.

Examining the error report (not saved), I noticed that overall my
situation had rather clear similarities to one described in an earlier
discussion [1].

Unfortunately, it appears that the differences in the kernels may have
corrupted the file system.

Based on eagerness for a resolution, and on an optimistic comment
toward the end of the discussion, I chose to run a check operation on
the partition with the --repair flag included.

Perhaps not surprisingly to some, the result of a read-only check
operation after the attempted repair gave a much more discouraging
report, suggesting that the damage to the file system was made worse
not better by the operation. I realize that this possibility is
explained in the documentation.

At the moment, the full report appears as below.

Presently, the file system mounts, but the ability to successfully
read files degrades the longer the system is mounted and the more
files are read during a continuous mount. Experiments involving
unmounting and then mounting again give some indication that this
degradation is not entirely permanent.

What possibility is open to recover all or part of the file system?
After such a rescue attempt, would I have any way to know what is lost
versus saved? Might I expect corruption within the file contents that
would not be detected by the rescue effort?

I would be thankful for any guidance that might lead to restoring the data


[1] https://www.spinics.net/lists/linux-btrfs/msg96735.html
---

Opening filesystem to check...
Checking filesystem on /dev/sda5
UUID: 9a4da0b6-7e39-4a5f-85eb-74acd11f5b94
[1/7] checking root items
[2/7] checking extents
ERROR: invalid generation for extent 4064026624, have 94810718697136
expect (0, 33469925]
ERROR: invalid generation for extent 16323178496, have 94811372174048
expect (0, 33469925]
ERROR: invalid generation for extent 79980945408, have 94811372219744
expect (0, 33469925]
ERROR: invalid generation for extent 318963990528, have 94810111593504
expect (0, 33469925]
ERROR: invalid generation for extent 319650189312, have 14758526976
expect (0, 33469925]
ERROR: invalid generation for extent 319677259776, have 414943019007
expect (0, 33469925]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
block group 71962722304 has wrong amount of free space, free space
cache has 266420224 block group has 266354688
ERROR: free space cache has more free space than block group item,
this could leads to serious corruption, please contact btrfs
developers
failed to load free space cache for block group 71962722304
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups
found 399845548032 bytes used, error(s) found
total csum bytes: 349626220
total tree bytes: 5908873216
total fs tree bytes: 4414324736
total extent tree bytes: 879493120
btree space waste bytes: 1122882578
file data blocks allocated: 550505705472
 referenced 512080416768
