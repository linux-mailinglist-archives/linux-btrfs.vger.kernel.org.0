Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABBB3D4F2B
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jul 2021 19:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhGYQ7i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Jul 2021 12:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhGYQ7h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Jul 2021 12:59:37 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EFEC061757
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Jul 2021 10:40:06 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id y18so8236892oiv.3
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Jul 2021 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=h/E+kJy8+tfycO9ObgK2kgvBxIz9iBIHNdBU2cyFflM=;
        b=E9anlEgpzUQiDNQtzc0iRkttpKQk+Lv0vzOJP2ADs/b8Se6wX1sWxnDRZ48GchVSeJ
         dv9neeSkwi4Pn+tjmDvjR8tH+YYzRHzQsy5dOsDMqUpzuLvZXdZPjaqN/8hnvaPsjMP9
         T2nF2hiZdki+S4KV0OGueIRjyfyz/ZcjKL16w+hlpuFjk7cYF81E30Sscqwhd32/cddV
         wAd0u9zgT+SHw5FmBEBpovqgF58Y1yPCQs4wfX/9mv0P/yW/6TOn9HxM4CO4ic2ZDb5X
         IF87ChcGBSTf3frcUd5RRih30Wys8oJfnycBaysklXEJeQbuCpckSrs0M0j3pP9HzimJ
         yuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=h/E+kJy8+tfycO9ObgK2kgvBxIz9iBIHNdBU2cyFflM=;
        b=dayYYbFi6k4HOV/qWFDGKyWtX8WfjEjkPgfGI56FJIU3fzechEFpRm5O6iuZ6ip9GG
         dsiLPtFy9KvBtwAbp533xucB/EXjOl5/1qMdJCUt4kegBbLmAZtW4UaUfTfB/LQLWMEk
         XKq5lOaWWUmkURm9jLWCnEne6dVXqKSZb7ChIfmCDD6xPpy1EBpcEeaucHNciTVtNRk9
         lm7zyDJyQlnLFHg3G9fIxC3z+WIfKBMMUmIXqhl2ofxZ+nhPL1sg6oj+4St3PSYH2JcF
         ySaXBG7RU4Cap5fjMyv0+IiQMoVnDnOZZz6ksMuWgg91mzfTeu0mYh7wvkRLxjZypQIL
         YxuQ==
X-Gm-Message-State: AOAM532q9NUz/ZO/Re+mnvuN/EkEoQncCEyBfX8587WExQVudyoaVC2C
        1PZJfD5gE3JqXJ2f6FZ1d9B/uPGlPGPlshsNT4dXtb8s+rg=
X-Google-Smtp-Source: ABdhPJyuKRsVRLauP6WAbsxXiLWJnmxSTKgFd1LbMkr/Hm5o1W8WkAHwokwuAo8n29eMbiRGCBl6If5e9DaxIghQ4Ag=
X-Received: by 2002:a05:6808:24d:: with SMTP id m13mr12556809oie.137.1627234806123;
 Sun, 25 Jul 2021 10:40:06 -0700 (PDT)
MIME-Version: 1.0
From:   Dave T <davestechshop@gmail.com>
Date:   Sun, 25 Jul 2021 13:39:55 -0400
Message-ID: <CAGdWbB5YL40HiF9E0RxCdO96MS7tKg1=CRPT2YSe+vR3eGZUgQ@mail.gmail.com>
Subject: BTRFS scrub reports an error but check doesn't find any errors.
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

What does the list recommend I do in this case?

starting btrfs scrub ...
scrub done for 56cea9cf-5374-4a43-b19d-6b0b143dc635
Scrub started:    Sun Jul 25 00:40:43 2021
Status:           finished
Duration:         2:52:45
Total to scrub:   1.26TiB
Rate:             113.72MiB/s
Error summary:    read=1
  Corrected:      0
  Uncorrectable:  1
  Unverified:     0
ERROR: there are uncorrectable errors

dmesg | grep "checksum error at" | tail -n 20
(no output)

# dmesg | grep -i checksum
[  +0.001698] xor: automatically using best checksumming function   avx
(not related to BTRFS, right?)

# btrfs fi us /path/to/xyz
Overall:
    Device size:                   2.73TiB
    Device allocated:              1.26TiB
    Device unallocated:            1.47TiB
    Device missing:                  0.00B
    Used:                          1.12TiB
    Free (estimated):              1.60TiB      (min: 888.70GiB)
    Free (statfs, df):             1.60TiB
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:1.25TiB, Used:1.11TiB (89.38%)
   /dev/mapper/userluks    1.25TiB

Metadata,DUP: Size:6.00GiB, Used:5.26GiB (87.67%)
   /dev/mapper/userluks   12.00GiB

System,DUP: Size:32.00MiB, Used:160.00KiB (0.49%)
   /dev/mapper/userluks   64.00MiB

Unallocated:
   /dev/mapper/userluks    1.47TiB

# btrfs check /dev/mapper/xyz
Opening filesystem to check...
Checking filesystem on /dev/mapper/xyz
UUID: 56cea9cf-5374-4a43-b19d-6b0b143dc635
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 1230187327496 bytes used, no error found
total csum bytes: 1195610680
total tree bytes: 5648285696
total fs tree bytes: 4011016192
total extent tree bytes: 379256832
btree space waste bytes: 827370015
file data blocks allocated: 5497457123328
 referenced 5523039584256

If more info is needed, please let me know. Recommendations and advice
are appreciated.
Thank you.
