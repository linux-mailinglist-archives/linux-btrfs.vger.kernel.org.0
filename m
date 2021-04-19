Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE96364705
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 17:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbhDSPYE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 11:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbhDSPYD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 11:24:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D52C06174A
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Apr 2021 08:23:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s7so34384552wru.6
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Apr 2021 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse.io; s=google;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=zMUXBk6Ipc0YjIWEo2ircseaNtNJ4hE3Lrtv5CCHfs0=;
        b=jzjY4FuTSZrYyx7XeMyWjK1pVI8pRXXJlCAkK6xAwdd2lxlUHNhXgPOZ3MnTyji66o
         LQUS9JQFwfCyuW4Rgl1gBY22dzjlIQ+iVXsb+PfRRk4R7b7VwhqNbX0CJkYBSaHSNAjl
         7rXgRFe1+yIgS/+R4YzwBXnvZcGYNxnSU734HhCe2s3gvrf7mZeeViVNf2W8Js7KVfQ8
         rc5NW8P+owUkKdbZHYt717gKKtZ8Cgp5KBgnj6QQoWU+82aWn/9Npa0WlmvMJjq6IVvd
         4W9I+45PFkqXSbxHIT0fQeWMZLYPLug4d2/oJvsT8VQlflNk4tW1X86prZ+tflb1LfCv
         6NeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=zMUXBk6Ipc0YjIWEo2ircseaNtNJ4hE3Lrtv5CCHfs0=;
        b=aEumcf+GK45iGBVULSCO5Vfx7wn5lMvUu7UAwmP9f3hTh2YglxVLl0F8aQcGavyOlJ
         bT1oE6A0kBOwqNCB24c5NtH0F99R7m+gOaTLVeN/0pE765QF7W2AUbHIgFOL9d8IeN8W
         YcCalTVpT5E4SBFe1pmO5HH2EQVXw08vDTlc+ImT/uI1d5alj6FsdHvRTxJb2AMA9nTO
         1l4l3NRWjWXg1/f8SJ/6uJjpNWMQ8/ewh6SeLEcR7eE+oTVe+35PZTcouZSmIwEkOswP
         PsW6cMGEeHFR2M92qtZih62AMc1Mj+6Ug/9AWqWuXoP7Si0+dilxcQXsl9Rm72tFfogj
         C4Mw==
X-Gm-Message-State: AOAM531D9KCtiuwzKjZc66CRTrtFfkWYX89ymp/bwOCcMoZpkSQGXwgO
        spdIbYYVCqLPv6QKDL5MR1+2OhWEnRiwgnf5yne+2aVfNVqHYwWu
X-Google-Smtp-Source: ABdhPJyvFlFO5nTsKQ+jeSJIjWDthqAzMbSJKxs++9BGB3ywsZO6cmjdYe1KwnknsPuX/0msLntPECP/ltiE+KMCbQE=
X-Received: by 2002:adf:a40c:: with SMTP id d12mr14869838wra.91.1618845812131;
 Mon, 19 Apr 2021 08:23:32 -0700 (PDT)
MIME-Version: 1.0
Reply-To: me@jse.io
From:   Jonah Sabean <me@jse.io>
Date:   Mon, 19 Apr 2021 12:22:55 -0300
Message-ID: <CAFMvigdvAjY60Tc0_bMB-QMQhrSJFxdv2iJ6jXbju+b5_kPKrA@mail.gmail.com>
Subject: Replacing disk strange (buggy?) behaviour - RAID1
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm running Ubuntu 21.04 (technically not a stable "release" yet, but
it will be in a few days, so if this is an ubuntu specific issue I'd
like to report it before it is!).

The btrfs volume in question is two 8TB hard disks that were in RAID1
at the time the filesystem was created. Kernel version is Ubuntu's
5.11.0-14-generic with btrfs-progs version 5.10.1-1build1 in the
hirsute repos currently. This array is mostly non-changing archived
data, if that even matters.

I replaced a missing disk (sda is the replacement disk) last night
while in a degraded mount (left it all night to complete) with `btrfs
replace start 1 /dev/sda1 /mnt/btrfs` (1 was the missing disk in btrfs
fi show) and it appears to have worked fine. However, when I ran
`btrfs fi usage` it returned:

Overall:
    Device size:                  14.55TiB
    Device allocated:              2.41TiB
    Device unallocated:           12.14TiB
    Device missing:                  0.00B
    Used:                          1.60TiB
    Free (estimated):              8.63TiB      (min: 6.61TiB)
    Free (statfs, df):            12.14TiB
    Data ratio:                       1.50
    Metadata ratio:                   1.43
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                 yes      (data, metadata, system)

Data,single: Size:820.00GiB, Used:3.25MiB (0.00%)
   /dev/sdb1     820.00GiB

Data,RAID1: Size:819.00GiB, Used:818.64GiB (99.96%)
   /dev/sda1     819.00GiB
   /dev/sdb1     819.00GiB

Metadata,single: Size:4.00GiB, Used:864.00KiB (0.02%)
   /dev/sdb1       4.00GiB

Metadata,RAID1: Size:3.00GiB, Used:1.69GiB (56.23%)
   /dev/sda1       3.00GiB
   /dev/sdb1       3.00GiB

System,single: Size:32.00MiB, Used:144.00KiB (0.44%)
   /dev/sdb1      32.00MiB

System,RAID1: Size:8.00MiB, Used:80.00KiB (0.98%)
   /dev/sda1       8.00MiB
   /dev/sdb1       8.00MiB

Unallocated:
   /dev/sda1       6.47TiB
   /dev/sdb1       5.67TiB

So a small amount of actual data and metadata was still single on the
disk I was rebuilding from (sdb), but it had massively allocated
"single" chunks in the process (relatively equal to what I had in
actual data), and to a lesser extent, metadata too. Why didn't it free
those up as it replaced the missing disk and duplicated the data in
RAID1? Shouldn't it all be RAID1 once it's complete, why even have
such small amounts remain single? Easy fix I thought, as at first
glance I didn't realize 800GiB was allocated single, only paying
attention to the small amounts used, so I did a soft convert to fix
this.
sudo btrfs balance start -dconvert=raid1,soft -mconvert=raid1,soft /mnt/btrfs

Convert was pretty quick... took just a few minutes, but of course now
it's all allocated just as raid1 now (with presumably 0 actual data in
most of them):
sudo btrfs fi usage /mnt/btrfs/
Overall:
    Device size:                  14.55TiB
    Device allocated:              3.21TiB
    Device unallocated:           11.34TiB
    Device missing:                  0.00B
    Used:                          1.60TiB
    Free (estimated):              6.47TiB      (min: 6.47TiB)
    Free (statfs, df):             6.47TiB
    Data ratio:                       2.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,RAID1: Size:1.60TiB, Used:818.64GiB (49.95%)
   /dev/sda1       1.60TiB
   /dev/sdb1       1.60TiB

Metadata,RAID1: Size:7.00GiB, Used:1.69GiB (24.11%)
   /dev/sda1       7.00GiB
   /dev/sdb1       7.00GiB

System,RAID1: Size:40.00MiB, Used:240.00KiB (0.59%)
   /dev/sda1      40.00MiB
   /dev/sdb1      40.00MiB

Unallocated:
   /dev/sda1       5.67TiB
   /dev/sdb1       5.67TiB

Ratios are 2 now, which is exactly what I wanted, and how it was
beforehand. However I obviously didn't want all those chunks allocated
with nothing in them for no reason, even if they are relatively
harmless.

My questions are:
1. Why did it have so much 'single' allocated chunks to begin with?
Everything was RAID1 all up until the disk replacement, so it clearly
did this during the `btrfs replace` process.  Did I do this wrong, or
is there a bug?
2. Would the btrfs replace have failed if the filesystem was more full
and those chunks were not possible to allocate (it basically allocated
double the amount of data I have after all, so if the fs was 50%+
full...)?
3. How do I prevent this from happening in the future, should I need
to replace a disk? Is this possibly an Ubuntu related issue (perhaps
how the btrfs progs is older relative to the kernel?).

The 7GiB metadata isn't so bad, however I did proceed to run
btrfs balance start -dusage=0 /mnt/btrfs

Is it possible to run balance with `-dusage=0` along with the convert
to do that all in one balance? Obviously, that doesn't solve the
actual issue to begin with, I'm just curious as I did it in two steps.

FWIW: The `dusage=0` filter freed up pretty much everything as I
expected it to, and it looks pretty much identical to how it did
before the disk replacement:
Data,RAID1: Size:819.00GiB, Used:818.64GiB (99.96%)
  /dev/sda1     819.00GiB
  /dev/sdb1     819.00GiB

I'm willing to do the process all over again as all this data is on
another system, I just would like assurance I don't run into this same
issue twice.

Thanks,
-Jonah
