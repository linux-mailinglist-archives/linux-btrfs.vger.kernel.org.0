Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588D63CBF66
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jul 2021 00:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhGPWrh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 18:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbhGPWr2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 18:47:28 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41908C06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 15:44:32 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso11434496oty.12
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 15:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BkRBkcUyRq0YVGCsAwwfQZoMhI/uZe16u0w5XOREh3k=;
        b=i3h6dlnNuWrdpwMk7uES72oPdZycjU3vmYiNzD4MLgW1NxXqdFs9DXq4M82WnJJw8X
         vMmoU8uK9+sbPefO+dGsj+e1a8nVtwV3ivVbjW+mOWg50MDHUNGq2rplAJyE5FtNTWn1
         QVHQ4eKrN2u982W6tKBmSCvp6lEsRymCiUlu0DIigdHyrzhuV5D8LPzVCxaKcjdg6Pgu
         zg4mMihKbJGwpZpZwKXU6T82iDwunFb8yKZefu2ZYMk0FKc2PvR8vOeErv9ZDj+Pz+oJ
         JXCx/YfntwqA1wjzrqRZ3cwI4c35aHxTsV5Yc56/rKpYlNzZSsCZ8qayb7ofSmeXb3gJ
         rhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BkRBkcUyRq0YVGCsAwwfQZoMhI/uZe16u0w5XOREh3k=;
        b=QKfi18KijzSPlQz+DMt6N/er0wjI/WVV6/kSOHXAqEai8Cg6wkXA8VK8Q0Dyb/lTkA
         sl3gktFv3w+4K8rikUw39VctBe13e14L+4GUhF6XVEAoaI63avMJEjkBYpnUrtYTziL1
         CxX5Kv/c7LrqjEswSJ33lX4hU3YlR8s0bPHoKV6G2jB6CJRqOqVP1dqHInt9QgdYQmLa
         iSx2zkY+iW3VbRrJSOwuT6m722UpoHNl6DlqauEcG2jUKH/a2Yt1fb2Bx8u8D53cQX0a
         R5t6g0etLHqlWCmB51bNbUODUuiiU0ytlQrAMgXlebwhnC3Nq7mVTBo66/3spcYWCwYB
         ic6A==
X-Gm-Message-State: AOAM532wwaRefXbEnuxtCue7J3Dy5p/TSB+EI7RBEBOxkDL3wOOs0/8r
        aZnAz6RlG7WDi/WOPOJitK/7aXE6vNmmm/SU5U1S4h7C6oA=
X-Google-Smtp-Source: ABdhPJy32reVWTQ8UM+bpgmlZiX4cRO8w+cKB2bChsZqK3tURqBm1RxmDUUjZfjoASuFpYNgXvt716F1pKHrETI2Dd0=
X-Received: by 2002:a9d:2621:: with SMTP id a30mr9859015otb.221.1626475471427;
 Fri, 16 Jul 2021 15:44:31 -0700 (PDT)
MIME-Version: 1.0
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Fri, 16 Jul 2021 23:44:21 +0100
Message-ID: <CAHzMYBT+pMxrnDXrbTJqP-ZrPN5iDHEsW_nSjjD3R_w3wq5ZLg@mail.gmail.com>
Subject: "bad tree block start, want 419774464 have 0" after a clean shutdown,
 could it be a disk firmware issue?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

This was a single disk filesystem, DUP metadata, and this week it stop
mounting out of the blue, the data is not a concern since I have a
full fs snapshot in another server, just curious why this happened, I
remember reading that some WD disks have firmware with write caches
issues, and I believe this disk is affected:

Model family:Western Digital Green
Device model:WDC WD20EZRX-00D8PB0
Firmware version:80.00A80

SMART looks mostly OK, except "Raw read error rate" is high, which in
my experience is never a good sign on these disks, but I didn't get
any read errors so far, also no unclean shutdown, it was working
normally last time I mounted it, and after a clean shutdown, probably
just after deleting some snapshots, I now get this:

Jul 16 23:27:38 TV1 emhttpd: shcmd (129): mount -t btrfs -o
noatime,nodiratime /dev/md20 /mnt/disk20
Jul 16 23:27:38 TV1 kernel: BTRFS info (device md20): using free space tree
Jul 16 23:27:38 TV1 kernel: BTRFS info (device md20): has skinny extents
Jul 16 23:27:38 TV1 kernel: BTRFS error (device md20): bad tree block
start, want 419774464 have 0
Jul 16 23:27:38 TV1 kernel: BTRFS error (device md20): bad tree block
start, want 419774464 have 0
Jul 16 23:27:38 TV1 kernel: BTRFS warning (device md20): failed to
read root (objectid=2): -5

Kernel is kind of old, 4.19.107, but there are 21 more btrfs file
systems on this server, some using identical disks and no issues for a
long time until now, btrfs check output:

~# btrfs check /dev/md20
Opening filesystem to check...
checksum verify failed on 419774464 found 000000B6 wanted 00000000
checksum verify failed on 419774464 found 00000058 wanted 00000000
checksum verify failed on 419774464 found 000000B6 wanted 00000000
bad tree block 419774464, bytenr mismatch, want=419774464, have=0
ERROR: could not setup extent tree
ERROR: cannot open file system

Could this type of error be explained by a bad disk firmware?

Regards,
Jorge
