Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77F01CCEA8
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 01:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgEJXV3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 May 2020 19:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbgEJXV3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 May 2020 19:21:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45A7C061A0C
        for <linux-btrfs@vger.kernel.org>; Sun, 10 May 2020 16:21:28 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so2788982wru.0
        for <linux-btrfs@vger.kernel.org>; Sun, 10 May 2020 16:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LiaiVx/sgdhJN7gwFRcqfgYAs5etu+i8EjrbefqVkj8=;
        b=U48G6XVViGwNqx6fzaEAsmPzXCW1W2WpuYAvKF8ERpIZCUIuCYUdjnGnfM6ZB2srm0
         Bi27tVxsXMdp7VgZHrMiEqAL7cvyvv9ycT754Nhb0+Y1rzuoJJQq2dtXw3bmuuxyvsen
         w34+Bcdc3zsq4rvHpPgVRJ/RwuhoqTWhjKHwn3pWkHKtxkfQ2MnpxZWBMvXWjbhPl2jG
         TUfhZqBgKgUa9m/ki6eMSf41saORZzUb21QnHsuizQlfl6l9XTKCzKeBJfw3e47L53j2
         mBVA1VhbzoY+cqkOKznu4OXJmgGNsntFqf2xX/f7IRHBfTwrOCVcvbG4HbNT8TPvh0xd
         XiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LiaiVx/sgdhJN7gwFRcqfgYAs5etu+i8EjrbefqVkj8=;
        b=f3Dp6zFPJwHoqOKqxsZ8GPguVF7uiGvs/fVK3a/e/mQJtTaMB+HTNgxVcHvkCDLk3Q
         o5GD5JJekJqlzVbCqp57tptlNiQANfsv5fdPq7Ezq7eaJoEneptd9yFipiTzVg8vAqox
         Eo90lkRduO7a7RzRe0lK1keF2idWyUOrfcD9qPvnlGMA5Kx02dtcwvU/HRBth65UilS9
         rDUvaFO+9k+YRkqTud0o58UEEbUY1U0I9Nz0R/hXfnAW+zv1dZCzR4nEIahtoFWqAeQB
         U5dSxoFttYAwb1gbdzHIah3eH7Cgs42cKq/BXKDLMQkWVWC2ZZm9wn8vSvu790jlKRST
         OwzQ==
X-Gm-Message-State: AGi0PuZw1z5tyg/30Igl7ocKF8q9YCoajAZ81WuJYP53na0m8wokPsk+
        QyohEvtPeuJ40BMwrzslpoe2gfsueaUAsUXYhRN+cCVJF2tjgQ==
X-Google-Smtp-Source: APiQypKTi+d/tYhLv52n20WbInU7HAfok38f6Fb8jRoOJ3YGYQfpUPo+kaLHbzxePTl2mBpiQpz2VL1GbGlhUZllGmI=
X-Received: by 2002:adf:e688:: with SMTP id r8mr7407866wrm.274.1589152887403;
 Sun, 10 May 2020 16:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <fbf7d9e2-f64c-4598-2ce4-e1a05a6ede33@gmail.com>
In-Reply-To: <fbf7d9e2-f64c-4598-2ce4-e1a05a6ede33@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 10 May 2020 17:21:11 -0600
Message-ID: <CAJCQCtRDOT20meLcHtZuRM+OvCEGrk7nFDJ6Lm1y5-4DOedQNg@mail.gmail.com>
Subject: Re: unmountable filesystem: open_ctree failed
To:     Christoph Heinrich <chheinml@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On Sun, May 10, 2020 at 10:52 AM Christoph Heinrich <chheinml@gmail.com> wrote:
>
> Hello,
>
>
>
> my hard drive can't be mounted anymore.
>
> Two days ago the drive was very slow (<1kb/s read and write, but I didn't find any errors anywhere).
>
> However after unplugging and plugging in again, everything seemed normal again, so I don't know if that's related.

If you were using 5.6.x at the time of this, the tree checker should
stop things on write if there's a problem, before there's corruption.
It's possible there's previously existing corruption.


>
> When trying to mount it today I get that error:
>
>
>
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdb, missing codepage or helper program, or other error.
>
>
>
> Mounting without -o results in dmesg:
>
>
>
> [14479.650956] BTRFS info (device sdb): disk space caching is enabled
>
> [14479.650963] BTRFS info (device sdb): has skinny extents
>
> [14499.742007] BTRFS error (device sdb): parent transid verify failed on 3437913341952 wanted 7041 found 6628
>
> [14499.753076] BTRFS error (device sdb): parent transid verify failed on 3437913341952 wanted 7041 found 6628
>
> [14499.753089] BTRFS error (device sdb): failed to read block groups: -5
>
> [14499.816157] BTRFS error (device sdb): open_ctree failed
>
>
>
> I already tried mounting with usebackuproot,nospace_cache,clear_cache, but that resulted in the same error messages as before.
>
>
>
> When running btrfs check I get the output:
>
> parent transid verify failed on 3437913341952 wanted 7041 found 6628
>
> parent transid verify failed on 3437913341952 wanted 7041 found 6628
>
> parent transid verify failed on 3437913341952 wanted 7041 found 6628
>
> Ignoring transid failure
>
> ERROR: child eb corrupted: parent bytenr=3437941538816 item=123 parent level=2 child level=0
>
> ERROR: failed to read block groups: Input/output error
>
> ERROR: cannot open file system
>
>
>
>  From what I've read so far, running btrfs-zero-log or btrfs check --repair may help,
> but it may also do more damage then good, so I'd rather ask then make the situation worse then it already is.

What do you get for:

# btrfs insp dump-s /dev/
# btrfs insp dump-t -b 3437913341952 /dev/
# btrfs-find-root /dev/

Those are all read only commands and make no changes to the file
system. Also, what are the mount options for this file system in
/etc/fstab?

> kernel 5.6.11
>
> btrfs-progs 5.6

Was this file system ever written to by kernels 5.2.0 - 5.2.14? There
was a pretty nasty bug in that range that might be related, but the
transid want have difference is bigger than I'd expect for that bug.


-- 
Chris Murphy
