Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64A9250C06
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 01:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgHXXB0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 19:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgHXXBZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 19:01:25 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926F3C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 16:01:23 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id s81so2400083vkb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 16:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=P3XVRYszh+XPOQ/z3nYki1DmdzYh9UCpEm26z7OxMrg=;
        b=gTvFluJqxoK25uTAnnvfxcQRj54gWEVQbtXED6AqrTVbpEjuB/sAU4a/Atwo/cu2wO
         cDKiMzHPA4GjRz3IbRKt5vkXpQ2pObpZt2DsPdoRjlvt/rTan6RLvPpDDNHXd51zJKF/
         gdvdVTxmVrpeBMHSbkdgJICO9kIlXmIO0ZB20ZrCgOZxloNvtciDWGQHPxoOaJvNocvE
         AGC4+WgBQr0AWzpZIpdHb5xGwPn6i3UOPv21u0WE+dN2NFsT/PD9NiE6273Vw1LuxHnb
         s9fLCQQ+ez7tVo1NHLrwqovhqFodBBHxO7Bl1YxPIglwzwSe8RHP7w/ybwyTIwODvToJ
         obqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=P3XVRYszh+XPOQ/z3nYki1DmdzYh9UCpEm26z7OxMrg=;
        b=KwvMFCR47icXFfM84GuixEJtDFADPfHbnrlibcBLxmuI/b9bNg8Bhg8YD2NTGGjth/
         /HqA+421TCCJEdUPH1UThQPrAXHf/pQL59ry7HKMw5m6h8tS6UjVoEzqMXeLeW281eIS
         7R3oCfjgmU80tEON2tuIQsqXvXSxDhN6elxrePWT2y85KNilGgx5INc6hBO2FdwgkNP9
         DugM7p3J5ujngvW+dULjkO1RX6Bt3/IiJttnQpipLbWoMtdJBpJRhTNE+ooDoZvK+DQN
         +4LpgdcMA7lQdwwOZTSWxAbOYapvfpsP05s0VxxSFl3wVpM/9UJu9wljcV7N/EpZ1lZ8
         S/Qw==
X-Gm-Message-State: AOAM5327IzQZjuQSOBKwRRbqQu0TrFOtyuaEOGp1Oh0GiyjhQ/N1LfIS
        qtgDZJiIRT8lh/sQnnroftrvfnPEzwNJyv0HywzH9VBAbKG5Lg==
X-Google-Smtp-Source: ABdhPJy5BHJLHn7Q33x88U/xzM/IVTcJ9IGnxBZiE9zWKCjMl0rbJeLonu1ajnw438SvBMMOH/421HXXMfcxhT1j2SQ=
X-Received: by 2002:a1f:e641:: with SMTP id d62mr4064313vkh.30.1598310082445;
 Mon, 24 Aug 2020 16:01:22 -0700 (PDT)
MIME-Version: 1.0
From:   MegaBrutal <megabrutal@gmail.com>
Date:   Tue, 25 Aug 2020 01:00:00 +0200
Message-ID: <CAE8gLhn15dLELmeRy3TadcVg6UszxkhiB4tVL7NpEA_Q3m5sdg@mail.gmail.com>
Subject: Yet another guy with a "parent transid verify failed" problem
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

My home server computer with BTRFS root file system suffered a power
supply failure recently which caused a sudden power loss.

Now the OS (Ubuntu 18.04) boots properly and it starts a bunch of LXC
containers with the applications the server is supposed to host. After
a certain time of running normally, the root filesystem gets remounted
read-only and the following messages appear in dmesg. Fortunately, the
file systems of the containers are not affected (they are mounted from
separate LVs).

[57038.544637] BTRFS error (device dm-160): parent transid verify
failed on 169222144 wanted 9897860 found 9895362

This happened after multiple reboots.

The file system is located on an LVM volume with raid1 mirroring. I
already did LVM raid1 scrubbing, no mismatches found.

I didn't do much of BTRFS level troubleshooting, but the wiki
suggested that I should try to mount with usebackuproot.

The usebackuproot mount was successful, but I'm not sure how it's
supposed to work... does it correct the file system after one mount
and then I'm supposed to mount the file system normally? Or should I
always use the file system with usebackuproot from now on? (It doesn't
feel right.) Anyway, after one mount with usebackuproot, now I started
the system regularly. But I'm not sure if it solved the problem,
whether usebackuproot did anything, especially that now I rebooted
with regular mount options. Since the problem presents itself after
hours of normal operation, I'm afraid that it might come back anytime.

What to do if the problem reemerges?


Thanks in advance for any insight,
MegaBrutal
