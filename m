Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF43D1627E0
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 15:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgBROPu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 09:15:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44717 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgBROPt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 09:15:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id m16so24092101wrx.11
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2020 06:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zvii3gCmTQrJe3pCpaePM/qXXxpVM1N6ONh16q15oXo=;
        b=l2a794euLnXA4kbVULsCIjcvUDuKyYHuKAqo7Uxulh4bJrE2i5oeG18By7/zfpXGdW
         lcD/lyaiXALOKIU+qnAeqHGQuSe3zq2CJ5r7fMFVctVu6QIJSYjGQTyXD2Q2CAUdfZYM
         ThdiSUc0Jgbs6mMugQ2zuG75UFXL0g9vlS5JfrxWW9tfSrTjMGZHYI3LuiwAFBbEwa9+
         TKQi5ur6v2epqESY4rGJUR+h/X3w02k9hDtb+WAuM6ZE7BGpotFtzG66EM5QHUV0wWKt
         jnuGg3fZ/1iyWPVDI6xJisMJTbPB8y70yKTu34+HBlzqyta9WO4iakuI96Bl4DNq8FdM
         DUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zvii3gCmTQrJe3pCpaePM/qXXxpVM1N6ONh16q15oXo=;
        b=GV4B7mPRdhHyq3TPzdgyPaR5lZw+19dxQXtt31+xF0YuqOiRRr9GqpZmQi+XF28Mya
         4VI4YgoykauiVTe0FPxgCsCQLLIo5XzpDOZTUjdctj8s61ZNKRG9AqLNdCZWt/kyUv8Z
         aiMy3PT6fb6kJ9HB+esC5mzj2nV5+r9pJs4C3sCsgm3F/VRfTLn96pNgIUKBzf+Htb63
         dq6pEsFmsfh3jSIWJIBM7HJ1w9fslj8s2knFmO3kJCpwoYVXbpjRvY2Q3YcSAhI4Q3Ba
         NVuZr1nZ594TWwVfrrMf5HkBgKNyNtvQ7HnTLOgmjilu+LFFSpESQ+dV/AiSJtVykpA4
         PgEw==
X-Gm-Message-State: APjAAAUZCAifIjTIX2haX+QWGP2iuSB9tngpR7DKVuZDnbOkZ8LxuU5j
        QRz/yqrSfMa1XS2y/nBJyQKHj/WNJYM/QRuHT2mDiXbN
X-Google-Smtp-Source: APXvYqzAxfF6gI9+hLUa2IolFPytER8T+0VQZm65Gxowp5aIpzvNV+Y7pb9VXDCOJ1uwZYDFlqOang8vBQ6431DE2vk=
X-Received: by 2002:a5d:4a48:: with SMTP id v8mr29122448wrs.42.1582035346457;
 Tue, 18 Feb 2020 06:15:46 -0800 (PST)
MIME-Version: 1.0
References: <8fb8442b-dbf9-4d4b-42bb-ce460048f891@sfelis.de> <CAPmG0ja40xPPcXxM+uv_v339v+8Jc5TLP_kONbkw1vWHFUer-Q@mail.gmail.com>
In-Reply-To: <CAPmG0ja40xPPcXxM+uv_v339v+8Jc5TLP_kONbkw1vWHFUer-Q@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 18 Feb 2020 07:15:30 -0700
Message-ID: <CAJCQCtQjRMctPYtPM-v2=ZGBMJ5T88eyVcvdgR9SfpTVWBgSOQ@mail.gmail.com>
Subject: Re: kernel incompatibility?
To:     Henk Slager <eye1tm@gmail.com>
Cc:     Simeon Felis <simeon_btrfs@sfelis.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 18, 2020 at 4:54 AM Henk Slager <eye1tm@gmail.com> wrote:
>
> On Sun, Feb 16, 2020 at 10:29 AM Simeon Felis <simeon_btrfs@sfelis.de> wrote:
> > [1] https://lists.archlinux.org/pipermail/arch-general/2020-February/047463.html
> The partition size calculations done in the reference are not correct,
> they are 1 512-byte-sized sector too smal (compare: if start_sector=0,
> end_sector=9, size is 10).

The btrfs device size is smaller than the partition size in both
cases. Using an identically sized sparse file (same number of 512 byte
sectors), both fdisk and gdisk produce a single partition that fails
to end on a 4KiB boundary. But in any case Btrfs doesn't seem to care,
it sets the total number of bytes for the partition to the nearest
4KiB.

> Then still, there are some other errors somewhere, that might be
> triggered by having unequeal sized partitions sdb1 and sdc1\

I'm not sure how it'll matter, since Btrfs allocates a chunk, with
same stripe sizes, and any difference between partition sizes is
overcome by chunk allocation. Within the allocated chunks, they're the
same. Unallocated space isn't used for anything. Quite a lot of people
are using Btrfs raid1 with dissimilar sized devices.

> You could look at backports w.r.t. 32-bit vs. 64-bit, maybe related to
> changes 512 sector sizes and 4k page sizes.

I wasn't aware Btrfs ever had an internal sector size less than 4KiB.


> And better use gdisk
> instead of fdisk I think. And maybe check first 1MiB and last 2MiB of
> both disks.

Yeah we did that, they're fine. The backup GPT is in the correct
location and intact according to both fdisk and gdisk.

> There are also Ubuntu 32-bit and 64-bit images available for
> RaspberryPi's with kernel 5.3.x, maybe that gives hints where the
> root-cause is.

Maybe. There is a bug here, even accounting for 32-bit. If either the
device or volume become too large to reliably support on 32-bit OS,
there needs to be a clear INFO or WARNING, and perhaps even only mount
ro.

-- 
Chris Murphy
