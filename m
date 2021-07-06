Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643433BC51D
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jul 2021 05:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhGFD7N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jul 2021 23:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhGFD7N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jul 2021 23:59:13 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C916C061574
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jul 2021 20:56:34 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a127so18292310pfa.10
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jul 2021 20:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fYPK6a4EtX8FYjjPEFA0NaHb+Aww4dGDqW98j0jX8WY=;
        b=CJf7bE2qmN+mf79f5GcNbGJHTwZaGDGTrFIetcvG+Jp1Sb0F9b1WaQK+W4UesSP406
         TO0ehrPLJjGO5MuU5sHZMlmiWwr9pQyOpR2Df4vIed2gj/fEwWkVWHuwTwPNYSdrQSD+
         OpxJt8JNQiFT/7NhgpHlq1liawPtY2W2LfiETgVeFGdr9kxXjzGie4MfJTU7v5x2keCM
         95Wl5Q9uUx8cnE1sdkiI07t+yolCoLCRfQ6JbTSLNoKbWJcgaRUs37eLXCdwHvMkfDT0
         kKeVxMC/J7mll7Vb53tYf8ubhnmJn2SAUUWh66/kIblwkI0fW4KFfPMFKTQ8W9JqgyoG
         gy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fYPK6a4EtX8FYjjPEFA0NaHb+Aww4dGDqW98j0jX8WY=;
        b=XrwQR8qgkon6oExDyD6Ynz1GscK3D4Ag5ptJelitEcKGvYq++SL0xcNzW1uvKndg6U
         sJFxNGYN/od1F0YN9fz6wtgs2TadNtpJWkXEsWbiZew9JtN7WHV6Ye5G3z+tT2Ho1uqh
         VbHiLnZ9VfiNnu7D97su4UoG/9/m5e4Vb1APi1OpAQlniJ51WOYmKbEI1w4maAWClWQi
         /xVRYWKGGJ3UC8EfUZB10njFG0Bt3ZeVfPYyoao+jE5nMaKL7KRYAWCACyNpc2Oc+0sN
         wyKXf96GxGKJC8rC1xsnYMDn/1EbEiXarVhzBb6BhPr63hf6XnD71mjYq6CUzngFwydF
         gSkw==
X-Gm-Message-State: AOAM533XtPT1NG+isDJMmP1HntorPhkhMUJaPVOCL613j0xKjFtZlVNb
        pwFMvET/fcvjd4/62X8e5iFV6faDUg6ZT05TkUSD8NYp55ghIg==
X-Google-Smtp-Source: ABdhPJyW/PGMlF0m6MKi89i17T1qJ3/sT6QfUfMKsTjW5tgC2IRzLPRooQxU1BLHcg0HpS/uUN4hGSgl+2rTOr+bcz4=
X-Received: by 2002:a62:dd83:0:b029:2e8:e511:c32f with SMTP id
 w125-20020a62dd830000b02902e8e511c32fmr18232423pff.49.1625543793775; Mon, 05
 Jul 2021 20:56:33 -0700 (PDT)
MIME-Version: 1.0
From:   Yan Li <elliot.li.tech@gmail.com>
Date:   Mon, 5 Jul 2021 20:56:23 -0700
Message-ID: <CALc-jWwheBvcKKM79AD7BA5ZZQs7D407acgwOiwyo9R=U98Nwg@mail.gmail.com>
Subject: autodefrag causing freezes under heavy writes?
To:     linux-btrfs@vger.kernel.org
Cc:     Yan Li <elliot.li.tech@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

I'm using 5.11.0-22-generic from Ubuntu 21.04. My btrfs is running in
raid1 mode with two SATA SSDs. Mount options
"defaults,ssd,noatime,compress=zstd". Motherboard is ASUS Pro WS
X570-ACE with 32GB ECC RAM and AMD Ryzen 5 5600X. The system has no
other known problems.

I found that when I added the autodefrag mount option, the system
would freeze under heavy write workload for a long time before the
write finished and the system recovered itself, and would occasionally
freeze with a simple sync. During heavy write workloads, dmesg showed:

INFO: task journal-offline:514885 blocked for more than 120 seconds.
      Tainted: P           OE     5.11.0-22-generic #23-Ubuntu
task:journal-offline state:D stack:    0 pid:514885 ppid:     1 flags:0x00000220
Call Trace:
 __schedule+0x23d/0x670
 schedule+0x4f/0xc0
 btrfs_start_ordered_extent+0xdd/0x110 [btrfs]
 ? wait_woken+0x80/0x80
 btrfs_wait_ordered_range+0x120/0x210 [btrfs]
 btrfs_sync_file+0x2d1/0x480 [btrfs]
 vfs_fsync_range+0x49/0x80
 ? __fget_light+0x32/0x80
 __x64_sys_fsync+0x39/0x60
 do_syscall_64+0x38/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f49c9178d4b
RSP: 002b:00007f49c5150c50 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
RAX: ffffffffffffffda RBX: 00005589e7e26140 RCX: 00007f49c9178d4b
RDX: 0000000000000002 RSI: 00007f49c94bf497 RDI: 000000000000002c
RBP: 00007f49c94c1db0 R08: 0000000000000000 R09: 00007f49c5151640
R10: 0000000000000017 R11: 0000000000000293 R12: 0000000000000002
R13: 00007ffee4c5c8bf R14: 0000000000000000 R15: 00007f49c5151640

And many similar messages. The heavy write workload was just a dd from
urandom to a file.

The system behaves fine when I remove the autodefrag mount option.

Is this a known problem? If you need any more information, please
kindly let me know.

Thanks!

-- 
Yan
