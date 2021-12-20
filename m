Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A590B47A7C4
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Dec 2021 11:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhLTK3m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Dec 2021 05:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhLTK3m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Dec 2021 05:29:42 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05091C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Dec 2021 02:29:42 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id v203so27255515ybe.6
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Dec 2021 02:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=inzY7Unf2NtfmoEQClc1hAAMboi9DpKCu/R6jtHNWnM=;
        b=fCHxriIKJE+dzQ5wwIApJo+YsuGLTzc4682fMMGdcSNITDRZhhxCdayhYqVElIweGh
         XTbsvofnRVwlYbT2x7KYKgEHErzZtZNitHtUBDs3A051HuIvnByhkn8EkSlPFcUX+LJG
         yKLvS4AIC6spbgodrVvu/WdicNtNaqX67s5wh3iUakivg0VKwe6yJvQRcoJfX57WdzqR
         kBJY5H0pddxHZ0HmDlOpXR3gZ+mlTG4ynZKw11UuysyM3S8Rhmk4BhSXvG2gOOnbMBlK
         mp1oHfwReNIrMT/T2SvP1pFMVwjtXRZoRqEbZqgrhLwZI6PbOV37BgIndnXIpH/sRvWw
         WMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=inzY7Unf2NtfmoEQClc1hAAMboi9DpKCu/R6jtHNWnM=;
        b=H8VoHj+WeNjReUK/5b/Fu4A61n7p0uZkT0gV+SfCxcFsl5OiVPWXd0hjA78G3GcU82
         DLVFdbXQroxO0SztdzVZiMQ6Rfjsbf2ZyAw0Iss5dGWwwHQFG4dufc9K+ZspuK97S2Hs
         Tpp24zOO+x2x0UjapYJ+qwiCgMoKNEfNc+xQ0qICbcWAw1epD9CzECI1V5qbYmQxL9cd
         ieO2RQl5vRuMg4lDMN+0+6R4GFi0gPTKKg1RdrGdHQ+0LcyFRqwBSiYDFBPjm7+eOKTr
         PQOQTRHl9kuqvv7qbv5iYS8FUkTj50FD7xaD6pSMMEHQ+02wNwhZFLMHMlCi1AYygJJV
         Xw6A==
X-Gm-Message-State: AOAM530TlkCYrTnb0y69/WqYrl4iHJm1GZlZhmuFuEmXD1VaWbI9fX5G
        hJ1tOa/oy6+Rjkc8zi5AEKlApHwmSgwnKuHOPXoP3ACo
X-Google-Smtp-Source: ABdhPJytNSfHUJV9uquHirm0SLlxBWJwdqyRRJinfFBgldM6ZY+dLQFlkKG7PMhWvkqp3M5n/zMQNucvUNdmX62F/HA=
X-Received: by 2002:a25:fc24:: with SMTP id v36mr22614011ybd.588.1639996181280;
 Mon, 20 Dec 2021 02:29:41 -0800 (PST)
MIME-Version: 1.0
References: <b4d71024788f64c0012b8bb601bdba6603445219.camel@stj.jus.br>
In-Reply-To: <b4d71024788f64c0012b8bb601bdba6603445219.camel@stj.jus.br>
From:   Vadim Akimov <lvd.mhm@gmail.com>
Date:   Mon, 20 Dec 2021 13:29:24 +0300
Message-ID: <CAMnT83t1WXvX210_UEfNy7Q4dfKkgJn2j=AMNB9zbVAPU3MEfg@mail.gmail.com>
Subject: Re: Recommendation: laptop with SATA HDD, NVMe SSD; compression; fragmentation
To:     Jorge Peixoto de Morais Neto <jpeixoto@stj.jus.br>
Cc:     "linux-btrfs@VGER.KERNEL.ORG" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

On Mon, 20 Dec 2021 at 12:11, Jorge Peixoto de Morais Neto
<jpeixoto@stj.jus.br> wrote:

> For lifetime and space saving, I intend to install Debian to the SSD
> with compress-force=3Dzstd:12, but after installation adopt compress-
> force=3Dzstd.  Installation will be slow---I'll do something else while
> the installer works---but the installed system will be efficient, right?

From my limited experience, it would be better installing at some
(extra) HDD in "normal" mode and then copying everything to newly
formatted btrfs volume with all options as you like. After that, you
do usual 'chroot, grub-install' thing et voila.

> I also have a QEMU-KVM VM with a qcow2 disk image currently weighting 24
> GB.  Should I convert the qcow2 image to raw format?  Or should I
> convert it to a new qcow2 image with the nocow option?  I do not use
> disk encryption and I rarely snapshot the VM disk.

Also from my experience, it's better not to use btrfs for qemu images
at all. If you have to, use raw file format AND prepare image file
like this:
1. touch filename.img
2. chattr +C filename.img
3. dd if=3Dold_img_file.img of=3Dfilename.img
That ensures the file will be in 'nodatacow' mode, i.e. data in it
will always be inplace without CoW updates.
Even with such file you'll get synchronous writes in the VM 3-4 times
slower than you'd have with image on ext4.
Not doing 'nodatacow' exercise makes them even slower than that and
degrading over time.

By speaking 'synchronous writes' I mean even the simple things as
doing 'apt upgrade' inside VM. It really becomes slower with image on
btrfs.

> The SSD will have 50 GB extra over provisioning and a 200 GB partition,
> besides the special UEFI partition.  The SATA HDD will start with 16 GiB
> swap partition then a big partition.  I'll put system and /home on the
> SSD but all XDG user dirs=C2=B2 on the HDD, and tmpfs on /tmp.  All three
> drives will have Btrfs with space_cache=3Dv2, noatime, zstd compression
> and reasonable free breathing space.

I'd keep swap on HDD for all times except when swap is extensively
used due to real memory shortage. In all other times swap could nicely
sit on HDD dumping some really not used memory pages in the
background. And anyway, you still can have swap in a file over btrfs,
no need for separate partition.
