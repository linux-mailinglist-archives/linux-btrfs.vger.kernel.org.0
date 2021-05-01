Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC38370918
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 May 2021 23:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhEAVkY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 May 2021 17:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhEAVkX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 May 2021 17:40:23 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711B9C06174A
        for <linux-btrfs@vger.kernel.org>; Sat,  1 May 2021 14:39:33 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id i14so1014380pgk.5
        for <linux-btrfs@vger.kernel.org>; Sat, 01 May 2021 14:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Asqu8kfZmishbP/O9JxAdB1n63+hrza3htwYcGCxU6c=;
        b=AfKto/A3afdBlkNj48GNuoxepA0wmVf1zaZa1QSAe1HM6omnOncrZhYByYA3zc03UK
         W1Zh0zCYTI1DCAd5a8+b7sLf1RCabi/DXO9uw/OCMR9CTqbbfYbI9xxirz8N0H6EouKh
         3bmyN3LHBSf9MZmB2LNkFyZOZwVscuaGkWzjUmBguxzxt44O5FtToZaGXNSaj7S/qJAP
         k70Ld8v4mMWobjqGL7ZOJGauHgsHp9an5f6/Q7HSX2/1FSR1AYmWK557IfrC58r2m3qt
         IoJqHy20yyAxPd/LTE4PPMAm+UuDH5fiW0WPTiTGZ3jPRNeQsvguIj6ANeGEw0l1/iRV
         sHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Asqu8kfZmishbP/O9JxAdB1n63+hrza3htwYcGCxU6c=;
        b=M3PCwmF2PRSLchmTMtJo9J6iTlsSSy8/BI5C+RLP9QlLgDdL6YV10u0/zvfE/LRKUK
         qh2eRFatQ7PUx2zvnzGbcUD+leQGSPUnBMECsnjS7JPCnOBuIYRyN7Nl8sHoiUlc731r
         zU202K7auW6Nn5KzTb6PFVNj4soFe+LnJ0oFXKlk7HXdYJE7tkVZDhIIX8U2FfQKfopr
         fVdA330W2T1BKiWkV74xHsv2PEudUT+7FXb8kguDXXSU5WjBvC/PYpx6ahAMDsBOQKUf
         INKtjBJ6ynkSZqHwnbWBMuf/AJcIV0P2G6iwtZ5mlA+Y2ykUbSEpqfxLrJrTeplMOyYc
         utfw==
X-Gm-Message-State: AOAM533831/4PnGtoqvINZPkV5g1iMQoMHdLNab7AlBdq00akeuJKaef
        S9lhcAjDz1DjmKN6xg2qcGFSFajCon4pKMn4FowBILQ+NaaNxw==
X-Google-Smtp-Source: ABdhPJywCrRA6tuTLo0L6BDI0AyLZLp4jTrQ9hWkOUSCEu3YTwAMq7cNwU+qIsXBKe1pFhlZSUjrAUcFe7B0dPRFBJE=
X-Received: by 2002:a63:5a50:: with SMTP id k16mr10866817pgm.185.1619905172630;
 Sat, 01 May 2021 14:39:32 -0700 (PDT)
MIME-Version: 1.0
From:   Yan Li <elliot.li.tech@gmail.com>
Date:   Sat, 1 May 2021 14:39:21 -0700
Message-ID: <CALc-jWxqFtRDGtdpPLeYw2+bb5rvB6pm=camqyAQ6nOjO5wE3A@mail.gmail.com>
Subject: "btrfs replace" ERROR: checking status of targetdev
To:     linux-btrfs@vger.kernel.org
Cc:     Yan Li <elliot.li.tech@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

I have a raid1 btrfs with one device missing:
$ sudo mount -o compress-force=zstd:9,relatime,space_cache=v2,degraded
/dev/mapper/open_offsite_bak1 /mnt/offsite_bak
$ sudo btrfs fi show /mnt/offsite_bak
Label: none  uuid: 99acc0da-127f-4034-8d53-07851cbbccba
Total devices 4 FS bytes used 8.75TiB
devid    1 size 4.55TiB used 3.53TiB path dm-11
devid    2 size 12.73TiB used 8.76TiB path dm-12
devid    4 size 3.64TiB used 2.62TiB path dm-14
*** Some devices missing

Now I'm trying to replace it with another drive according to the
instructions on the wiki
(https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices#Using_btrfs_replace):

$ sudo btrfs replace start -r 3 /dev/mapper/open_offsite_bak5 /mnt/offsite_bak/
ERROR: checking status of dm-13: No such file or directory

/dev/mapper/open_offsite_bak5 indeed is a link to /dev/dm-13.
$ sudo btrfs replace start -r 3 /dev/dm-13 /mnt/offsite_bak/
shows exactly the same error.

The device is fine if I try:
sudo dd if=/dev/dm-13 of=/dev/null count=1

There's no error message in dmesg.

What could be the problem? I feel like it should be a stupid error on
my part but I just can't figure out. "btrfs replace" doesn't support
using a devicemapper device?

Kernel: 5.11.0-16-generic
btrfs-progs: 5.10.1-1build1
Both from Ubuntu 21.04 with latest updates.

Thanks!

--
Yan
