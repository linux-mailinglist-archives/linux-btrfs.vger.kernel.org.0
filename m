Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C403DA086
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 11:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbhG2Jri (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 05:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbhG2Jrh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 05:47:37 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B6AC061757
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jul 2021 02:47:34 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id o185so7645372oih.13
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jul 2021 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=o2Qz6Jnn0AIZ5Opzbe+EnCnVh2/aU7Y7xLpEI4FG8hc=;
        b=OOvTrQkbA1aE9nveiXilkrDLvBTW1k7w1PjDkjWt8D6zlQ/Jd0W8avagF0wszYiDHZ
         L4Ycy6/d+wWdJqrFlEUupKAJZNzOxDAaepD6T4YgAiorqmr8ZZ6dyjmMuv3GCC3xjWFB
         QEXMawPDYrKIJTd3d9d4ali4iqS10VRvegYmgcDux0ucyTjvXF9N18JAJf478vppPnzv
         KwHpbR7EL3RB9xVjgTdbnbkKepnLeUfGVTccw2F00vfQQEPKiD5SNA3WCE8bqw7rck7z
         Y7kJtm9Zeu1weC1JLZ9Z8s11LnMHX9W2N2GZOtxrM3y/zG0AI8+Rjlq162ipFGW6/CYI
         ozHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=o2Qz6Jnn0AIZ5Opzbe+EnCnVh2/aU7Y7xLpEI4FG8hc=;
        b=YVgnpII3hYsAiWtQCG6/gMOk5dYrjqZLc7U1blnKdnTCyEQeIY1G6ol8FHjCFQa+h5
         dkmQilNjtFe3+d2zodmkG+2ZukbRcfwv07ih6OKgCZMFId+viPmUUKYKC2rLPb9w8v3b
         FOayqfynEpKbQgkFt3ObjxubyKWcWCEwvX+Qv7r74JrjmbL0J5boXnmFXhxnuk4ZzyO1
         wUWJdWArVjWD25tk0D9afLwjIO+3a7j1qslZZprwTNnr0TiyqjnImALql5gYm5MDj+xm
         KErosi2NyDsjfZaDh5t7ELzhGNAwhJ0loRj4QF5FI1itova/cIWOZoPR4Uee6v4ljqSv
         aGhg==
X-Gm-Message-State: AOAM531lsu6Kp1K+Nj/ZgKS4FK4tXrZ7nBBQoZN4HScQHV3yKwrvzY3B
        El+aW+AgUATQs7MQvVNy3gz2Ii6ozpfVr6imeqvn7i+IRK4=
X-Google-Smtp-Source: ABdhPJweRVy/ytJaGIi+ESfrNvbC8S9YgGsOImtfQGYobsaNgwwlp6/45Kd0YqN0BG8G5npTLEn4n/EWM5PLiBl/Xg0=
X-Received: by 2002:aca:a8cd:: with SMTP id r196mr2446820oie.160.1627552053340;
 Thu, 29 Jul 2021 02:47:33 -0700 (PDT)
MIME-Version: 1.0
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Thu, 29 Jul 2021 10:47:22 +0100
Message-ID: <CAHzMYBSap30NbnPnv4ka+fDA2nYGHfjYvD-NgT04t4vvN4q2sw@mail.gmail.com>
Subject: Why usable space can be so different?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

HI,

This is not a big deal, but mostly out of curiosity, I've noticed
before that sometimes I couldn't fill up a single device btrfs
filesystem as much as I would expect, recently I've been farming some
chia and here is a very good example, both are 8TB disks, filled up
sequentially with 100MiB chia plots, this one looks about what I would
expect:

btrfs fi usage /mnt/disk4
Overall:
    Device size:                   7.28TiB
    Device allocated:              7.28TiB
    Device unallocated:            1.04MiB
    Device missing:                  0.00B
    Used:                          7.24TiB
    Free (estimated):             34.55GiB      (min: 34.55GiB)
    Free (statfs, df):            34.55GiB
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:7.26TiB, Used:7.22TiB (99.54%)
   /dev/md4        7.26TiB

Metadata,DUP: Size:9.50GiB, Used:8.45GiB (88.93%)
   /dev/md4       19.00GiB

System,DUP: Size:32.00MiB, Used:800.00KiB (2.44%)
   /dev/md4       64.00MiB

Unallocated:
   /dev/md4        1.04MiB




In this one, filled exactly the same way, could only fit 2 less plots:

btrfs fi usage /mnt/disk3
Overall:
    Device size:                   7.28TiB
    Device allocated:              7.28TiB
    Device unallocated:            1.04MiB
    Device missing:                  0.00B
    Used:                          7.04TiB
    Free (estimated):            239.04GiB      (min: 239.04GiB)
    Free (statfs, df):           239.04GiB
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:7.26TiB, Used:7.03TiB (96.78%)
   /dev/md3        7.26TiB

Metadata,DUP: Size:8.51GiB, Used:7.96GiB (93.51%)
   /dev/md3       17.02GiB

System,DUP: Size:32.00MiB, Used:864.00KiB (2.64%)
   /dev/md3       64.00MiB

Unallocated:
   /dev/md3        1.04MiB




Maybe a full balance would help, but the disk was filled sequentially
with one plot (100MiB file) at a time, there shouldn't be any
fragmentation, it's as if it can't fully use the data chunks as the
other one, kernel is 5.10.21, balance with -dusage=88 doesn't relocate
any chunks, above that it fails with ENOSPC:

btrfs balance start -dusage=88 /mnt/disk3
Done, had to relocate 0 out of 7446 chunks

btrfs balance start -dusage=89 /mnt/disk3
ERROR: error during balancing '/mnt/disk3': No space left on device


Any idea what could cause this difference, also two more disks (12 and
10TB) that fall somewhere in between:

btrfs fi usage /mnt/disk1
Overall:
    Device size:                  10.91TiB
    Device allocated:             10.91TiB
    Device unallocated:            3.94GiB
    Device missing:                  0.00B
    Used:                         10.71TiB
    Free (estimated):            202.03GiB      (min: 200.06GiB)
    Free (statfs, df):           202.03GiB
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:10.88TiB, Used:10.69TiB (98.22%)
   /dev/md1       10.88TiB

Metadata,DUP: Size:13.00GiB, Used:11.79GiB (90.74%)
   /dev/md1       26.00GiB

System,DUP: Size:32.00MiB, Used:1.25MiB (3.91%)
   /dev/md1       64.00MiB

Unallocated:
   /dev/md1        3.94GiB






btrfs fi usage /mnt/disk2
Overall:
    Device size:                   9.09TiB
    Device allocated:              9.09TiB
    Device unallocated:           13.01MiB
    Device missing:                  0.00B
    Used:                          8.93TiB
    Free (estimated):            169.67GiB      (min: 169.67GiB)
    Free (statfs, df):           169.68GiB
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:9.07TiB, Used:8.91TiB (98.17%)
   /dev/md2        9.07TiB

Metadata,DUP: Size:11.00GiB, Used:9.98GiB (90.76%)
   /dev/md2       22.00GiB

System,DUP: Size:8.00MiB, Used:992.00KiB (12.11%)
   /dev/md2       16.00MiB

Unallocated:
   /dev/md2       13.01MiB







Thanks,
Jorge
