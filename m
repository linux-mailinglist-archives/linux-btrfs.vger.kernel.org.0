Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB8547C96F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Dec 2021 23:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhLUW4y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Dec 2021 17:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbhLUW4y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Dec 2021 17:56:54 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4B2C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Dec 2021 14:56:53 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso182907wmc.3
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Dec 2021 14:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/HL/Mn/ZJWJAVTEF9x6GFUpX/XP6twAxhquHtQ1wz8=;
        b=djLie2+esI0ZpHXpvoIcDGR0tVlz58PUh3AN9CegJjGgoVkv9V9iMAiwJKA1ZbCZ6E
         zLHXDXEaiA0tfK7STD9+b8n5ApGHLfJrgtdowMj/ZE3e52fOLAVnLIlKluGSy2ezZGXv
         d+wqKgtdDCo5wuz4X/+XxJp6HBRTtCt46RFSiRpke9038Mwm+6Wf0EyYU3ih4+nqSBGr
         wpuusSWLgbm7KyJ+R1Vt/2kETgD0USDxjDnCQijO7gVrvun8bzwfrGjsj0xExuX1nG93
         2fPNggTohHvdhW+gMJOUHV3Lss01VfQrwP2zVQGfD7X/8MWYKp0ETK3E5bV39x48QCmP
         J3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/HL/Mn/ZJWJAVTEF9x6GFUpX/XP6twAxhquHtQ1wz8=;
        b=D084EsJAOoiLs+EAmtrchoh14OGWkhuq/CvOM8AQ0F+dxQZglZHhUoptW4PwqcwcbW
         xs5D8iI/Tq47ZEqY99O28gM2WTRghOjzgZie1u2PBV1xFIZHq2MQF087wsCrz4eJKRnd
         WEcQNKr1/PPjGFulE4VToc+N+bzLkPQpAKNwHemfebBXcTz4luoqKemTRHCku5v3ApG8
         NKADa9eMC/QVOh9BqtQF/x17P/qvuIWSIFelb5ZpGnti+/fxvP5zZYnVRnkhfnONBfKt
         t74d9BpVxmxrK9Szp3rUwLlLCwITFMzpVSmtkvfi/8YLAXqxzWMt+60AHOYqhAZsYgnF
         rh2Q==
X-Gm-Message-State: AOAM533eqh+snNffZDX/qtElKTKtcukrqj0O6XmG2iWiug88iBtN6WB1
        P9bDwCQYgUHppFH349cS4jSczRUME2xepd2PNQeSywuYkiU=
X-Google-Smtp-Source: ABdhPJznfv0X/ISpm/sSThdbB/KDEMo7vGtdYtVl4g7yhOMc+dXElUeCu+pMNfLGD+ELdWQG0xnoCmLHOy/25vXI9sU=
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr282811wmh.104.1640127412279;
 Tue, 21 Dec 2021 14:56:52 -0800 (PST)
MIME-Version: 1.0
References: <b4d71024788f64c0012b8bb601bdba6603445219.camel@stj.jus.br>
 <CAMnT83t1WXvX210_UEfNy7Q4dfKkgJn2j=AMNB9zbVAPU3MEfg@mail.gmail.com> <68123ebff72088e42ae1840210161ffee6622087.camel@stj.jus.br>
In-Reply-To: <68123ebff72088e42ae1840210161ffee6622087.camel@stj.jus.br>
From:   Matthew Warren <matthewwarren101010@gmail.com>
Date:   Tue, 21 Dec 2021 16:56:41 -0600
Message-ID: <CA+H1V9x7zR+nRME+-Em5YF8c6aWnNrRu8nyn13BJFAPBNfKDxg@mail.gmail.com>
Subject: Re: Recommendation: laptop with SATA HDD, NVMe SSD; compression; fragmentation
To:     Jorge Peixoto de Morais Neto <jpeixoto@stj.jus.br>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Does Btrfs unsuitability to QEMU VM images relate exclusively to
> synchronous write *performance*, or does it also harm SSD lifetime
> (assuming nodatacow and raw format)?  I intend to give my VM a second
> disk image.  One image will be on the SSD (holding system files) and the
> other on the SATA HDD (holding user files).  The NVMe SSD is probably
> fast enough that the VM will have overall good performance even with the
> synchronous write slowness you mentioned; but would it excessively wear
> the SSD?  Do I have to create an ext4 partition on the SSD just for the
> QEMU VM disk image?

I was running with VM images on an SSD formatted with btrfs with COW
and didn't see much in the way of performance issues, but they weren't
disk-heavy VMs in the first place. I did have an issue with
fragmentation though, so I'd recommend storing them on a separate
partition formatted as either xfs or ext4.

Matthew Warren

On Mon, Dec 20, 2021 at 7:48 AM Jorge Peixoto de Morais Neto
<jpeixoto@stj.jus.br> wrote:
>
> Hello,
> On Mon, 2021-12-20 at 13:29 +0300, Vadim Akimov wrote:
> > From my limited experience, it would be better installing at some
> > (extra) HDD in "normal" mode and then copying everything to newly
> > formatted btrfs volume with all options as you like. After that, you
> > do usual 'chroot, grub-install' thing et voila.
>
> Is that experience from before Bullseye?  I heard that the Bullseye
> installer has better Btrfs support.
>
> > Also from my experience, it's better not to use btrfs for qemu
> > images at all.
> > [...]
> > Even with such file you'll get synchronous writes in the VM 3-4 times
> > slower than you'd have with image on ext4.
>
> Does Btrfs unsuitability to QEMU VM images relate exclusively to
> synchronous write *performance*, or does it also harm SSD lifetime
> (assuming nodatacow and raw format)?  I intend to give my VM a second
> disk image.  One image will be on the SSD (holding system files) and the
> other on the SATA HDD (holding user files).  The NVMe SSD is probably
> fast enough that the VM will have overall good performance even with the
> synchronous write slowness you mentioned; but would it excessively wear
> the SSD?  Do I have to create an ext4 partition on the SSD just for the
> QEMU VM disk image?
>
> > you still can have swap in a file over btrfs, no need for separate
> > partition.
>
> I am aware Btrfs has official support for swap files (with some
> restrictions), but is it reliable, efficient and light on the SSD
> lifetime?  The Debian wiki recommends against swap file on Btrfs
> (although some parts of Debian wiki are visibly outdated).
>
> Thank you for your help!
>
> Kindest regards,
>   Jorge
>
