Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B11C1C231C
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 06:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgEBEuA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 00:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726439AbgEBEuA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 00:50:00 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADD9C061A0C
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 21:49:59 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a21so4403559ljb.9
        for <linux-btrfs@vger.kernel.org>; Fri, 01 May 2020 21:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sv6DxC3FNiZxFuNuuUlk6s6AH/L1eW9mPJcCrlTXTu8=;
        b=U1d5wDvXuzdbXhw9AgM+YEkWWVvYSsZsDgJ5BSzxtQqeX+iIgIp2DxR2n9soPxFjTD
         82PTp0keSbv3ZY9v4Pgm+T7YSR/ncR6rF79PLJijsmxHF3V/N5jq2Tdz8uxGFf0cXTzP
         C3gcJpYXfNqpyfxAr3W7T9ZvYF0M6r5e850m6v7qEZpd+ayx8IzmN25A1+Dj6t7LqmU4
         vbHwIy9webpbUoD1vaArKY9jPBLmZwdf2U4jJl9bQM4MOzK4E03ScbTvMCQBN/MKph/M
         C3+WPh+zquzaqfJzCpaa6sfCPOXktv7FRTaImEunewXHAcEXa9x9Ug4TrfV4f1FOyUBh
         7RaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sv6DxC3FNiZxFuNuuUlk6s6AH/L1eW9mPJcCrlTXTu8=;
        b=VgRkY/gWAhikHiEnp62T5sEdLW4egddEEkS3gAm0bPSSirOvPqZvTKl8lIKLTJtQmB
         1YGYbM6miguKAdQzoW+XuDv+2QUA9u151ObQm0XE/bMLDsKvzzObu3uJ17OArgF3lLRX
         2HCkYBZ/Eg89K+8/wQqNp2XVgxElEnvZ9Kw0wKEMTUJ2IE2ekKtjNy7BCpZWRCpSyJ2g
         8q/9Es6P3sE2LCkcJJanerBrXkwZkGEUd0TuaVo9HF3f0glTaTgM1P6a/UGd8AcJXv20
         ukuLVQ/DZQQBx+jIprWUXLfwEf6hAi/zBgPCiZD9qB8F9mf8lxTlRPKLR7K8wIqfiQL0
         S0Ww==
X-Gm-Message-State: AGi0PuaAqcj9BNE/Kef1gGcZECwnXRWmEMZdUedz9z3arMJvVdY7IBbx
        OL1Xkcc2Ziaa50Rcmh3BEj9txhW67bIDsJ+V8DNvjQ==
X-Google-Smtp-Source: APiQypLuvgZfXRU5v2aZrqbnvtt5I71UMwDsP1lpY5/rIV6egACapnnVBTFEGVZqU8aThIfMNopopWsFw9yBBL0i90c=
X-Received: by 2002:a2e:87d3:: with SMTP id v19mr3931965ljj.176.1588394997909;
 Fri, 01 May 2020 21:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net> <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net> <20200502033509.GG10769@hungrycats.org>
In-Reply-To: <20200502033509.GG10769@hungrycats.org>
From:   Phil Karn <karn@ka9q.net>
Date:   Fri, 1 May 2020 21:49:46 -0700
Message-ID: <CAMwB8mgM+KMC=3aLTWXbUX7GzzHPr7s=8Lbt0jv6J66+8gHT6A@mail.gmail.com>
Subject: Re: Extremely slow device removals
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Jean-Denis Girard <jd.girard@sysnux.pf>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My hand was ultimately forced today. The device remove running since
last weekend bombed out with a "no space" message in the kernel log
despite there being plenty of free space on all devices. The file
system had been remounted read-only. When I brought it back up, the
mount system call blocked while it underwent what was apparently a
lengthy file system check. (I got one message about a block group free
space cache being rebuilt). It really doesn't seem like such a good
idea for a really basic system call like "mount" to block indefinitely
during system boot. systemd eventually gives up, but it does take a
while. Lots and lots of stack traces in dmesg about system calls
blocking for more than 120 sec. Usually mount, but also sd-sync when
trying to shut the system down gracefully. Eventually I was forced to
hit hard reset.

These blocking mounts make it kinda painful to get a root shell just
so you can see what's going on. This is why I'll never put a root
filesystem on btrfs. I keep my root filesystems in XFS or ext4 on a
SSD so I can at least pull all the other drives and boot up single
user fairly quickly. I'll manually rsync the root file system onto a
spare disk partition as a backup.

Before rebooting I physically pulled the drive I was trying to replace
and set noauto in /etc/fstab on the btrfs fs. Back in multi-user mode
at last, I did a mount with degraded enabled and got the expected
message about the missing device (confirming I pulled the right one).
It's still madly doing I/O, but since it's not telling me what's going
on (and the mount has not completed) I have to assume from the I/O
patterns that it's continuing the device remove without it being
physically present. I guess if I'm lucky I'll be able to use my
filesystem in a week or so. I do have a backup but I'd rather not
touch it except as a last resort.
(resending)
--Phil
