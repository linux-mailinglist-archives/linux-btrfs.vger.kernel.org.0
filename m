Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3AF3C8A3E
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 19:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbhGNR5E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 13:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGNR5D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 13:57:03 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF302C06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 10:54:11 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id q16so3213405oiw.6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BsILUWtaegZvI+G0/729Hu6LW/fivb2aoHilfZxLAPo=;
        b=OAL3jB3NyponEVn0UkAbyZn1MLrXQWwcviNxQ9vbIN05O7oSyJ3XJO3CM+u7u2nl/b
         FMwsxiIfYogAvwmlc3cmX2CurP2U7a7tD3Dv9IOur68GS1Tz2tvNCzZvV9HqmQYUfzHz
         /JA7NIN3ggjVFCPNzeufFI5eGf7Db2sjpUkFPQnPfNyIBHgUFVs7o6rQVXHZrvDvHby7
         pus8wSKoAb5ch2lWy/4/EY2H3AQ+R+ilhYFOw1xBVaoRIP0vycJjOIl+m1WZiNvWZuyH
         vduxDZwNN0znBNizX7EZQLEh8yX5eFXQ0aYdQGSBx3nFlbLpgJeqKwDTvvDZxmRKOAUY
         PUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BsILUWtaegZvI+G0/729Hu6LW/fivb2aoHilfZxLAPo=;
        b=fgk4MTTt5fU8qrC722mVUfQ9bLIVAKoFQ6wIG76AkFtCr1ns0uGBrFkwGkq8Moi7tI
         KfNWKDIe8HJgEsNGrJDkmGqwOetVNpFc4hhAT0FdRkHgNgeNiPuKvCc+lo7T1ZypAt/8
         UaKs4xWxTfgg7UtdBmeRQpMi4+GAeWGSRW2kz2DOTc3vM8anNAdEReWix6xJYvtK0owm
         sVlNugcwj1eOLy0IGq//TXBSq+FXs3UFG0D1ixITnRTEGmy1ViRXObdsCcVzrzAv4zxI
         yuqVynwEVroeFZxA14AVdDt7cTtQRJa/ITXHW0EKN+SsppjotRIY3u5Mo2nGek/GNIUA
         +kxA==
X-Gm-Message-State: AOAM533E0NABDIUSlys+Iiq06wCBfb83/dImbRB3L0O9V39hcBSc0CgZ
        vrY5VbHZaB34M7PuT9mmzSufVChLV1YXv1aqoMNk/o59AY4=
X-Google-Smtp-Source: ABdhPJxJWPcDLFP9SCyuhmMuRxvHujMPk6ai1dsvDD02Q1jp7RtEKRiFNtFOQ5/kpJHAKciAA3SsgJyVmhXFtvSeZb0=
X-Received: by 2002:a54:4e95:: with SMTP id c21mr3812748oiy.137.1626285251017;
 Wed, 14 Jul 2021 10:54:11 -0700 (PDT)
MIME-Version: 1.0
From:   Dave T <davestechshop@gmail.com>
Date:   Wed, 14 Jul 2021 13:53:59 -0400
Message-ID: <CAGdWbB6qxBtVc1XtSF_wOR3NyR9nGpr5_Nc5RCLGT5NK=C4iRA@mail.gmail.com>
Subject: bad file extent, some csum missing - how to check that restored
 volumes are error-free?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was running btrfs send | receive to a target host via ssh and the
operation suddenly failed in the middle.

I ran this check:

btrfs check /dev/mapper/${xyz}

This shows lots of these errors:
  root 329 inode 262 errors 1040, bad file extent, some csum missing
  root 329 inode 7070 errors 1040, bad file extent, some csum missing
  root 329 inode 7242 errors 1040, bad file extent, some csum missing
  root 329 inode 7246 errors 1040, bad file extent, some csum missing
  root 329 inode 7252 errors 1040, bad file extent, some csum missing
  root 329 inode 7401 errors 1040, bad file extent, some csum missing
  root 329 inode 7753 errors 1040, bad file extent, some csum missing
  root 330 inode 588 errors 1040, bad file extent, some csum missing
  root 334 inode 258 errors 1040, bad file extent, some csum missing
  root 334 inode 636 errors 1040, bad file extent, some csum missing
  root 334 inode 3151 errors 1040, bad file extent, some csum missing
  ...
  root 334 inode 184871 errors 1040, bad file extent, some csum missing
  root 334 inode 184872 errors 1040, bad file extent, some csum missing
  root 334 inode 184874 errors 1040, bad file extent, some csum missing

I rebooted without any problems, then connected an external USB HDD.
Then I created new snapshots and used btrfs send | receive to send
them to the USB HDD.

Next I installed a new SSD and restored the snapshots. Then I ran
"btrfs check --check-data-csum /dev/mapper/abc" on the new device. It
shows:

Opening filesystem to check...
Checking filesystem on /dev/mapper/abc
UUID: fac54a70-8c27-4cbe-a8d0-325e761ba01d
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking csums against data
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 128390598656 bytes used, no error found
total csum bytes: 124046564
total tree bytes: 1335197696
total fs tree bytes: 1140211712
total extent tree bytes: 50757632
btree space waste bytes: 168388261
file data blocks allocated: 127058169856
 referenced 142833545216

What else can or should I do to be sure my restored snapshots are error-free?
What additional checks would you recommend on the new device?
The new device is a Samsung EVO 970 Plus.
The old device was a Samsung 950 Pro.
