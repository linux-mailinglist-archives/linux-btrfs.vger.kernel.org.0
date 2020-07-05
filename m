Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45FD214CB8
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jul 2020 15:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgGENZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jul 2020 09:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgGENZD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jul 2020 09:25:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA66C061794
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Jul 2020 06:25:02 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id b25so38577232ljp.6
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jul 2020 06:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ginkel.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YiGHOCXADgveS1+H0XNi+PrqEu382LGh9fCeZJPkVcM=;
        b=rqJoIqJNJnKXW8BLyggxaVwNpaZNqraktzQbaPWo0DnJ8ICNql1Yc8jQqt+b0SJlAr
         YltuRcHZEsmMkVg5CPz2v3jj6qZA06iPiy2uiSTVpVzwSfxqCZ5/SIpG0tb+8Yr+85jm
         0nuRk6tL6OIi8JUZ3v+qdcp0rb8pC+CvFiztI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YiGHOCXADgveS1+H0XNi+PrqEu382LGh9fCeZJPkVcM=;
        b=s9pJBznHEuwc/gDsEffnsfpObvrVd5rDxRrLO33IB46ZJofdXYnjG0135Z984otKrl
         I5TKvL4+0cFTSjAwYZDYpjSM5WGue0vRbRo00lnbgGPniJmy8cyzcAc/LJCXLM6kE0Yv
         DmNua0KvKoNw5vvypIewpVPw06hlnWTcRDJ7ua0dij9JB0SJ0gXP8eWAk+GJR4fv6YKa
         EOqnPUTC/3u9LaiWFJj2iOsnk3ld8swmYyjb6fKZGdvqmYpztu6oyAcdsviaArM5QAzQ
         Iofbh5rwgbpiIKX4wLoQWhl6vW6yZOnT9mHedyEbwf1RkR6xpu49MIlVRqWgGe2zui7V
         7dFA==
X-Gm-Message-State: AOAM531IwYG6zhpziSN2nDN8o5l/SAg1OUU94i5/A+WloYJ9zuw2ohPv
        u4mLclBVdIeMmbSdDoqRVxM9APncD1CRRzl322/gCw==
X-Google-Smtp-Source: ABdhPJw0ezM1KBqRwrTKGV4AWafeVzDTx5O6TXj+kct/kBy7A73+CVV/ODtnGJiljrnoVyMHhbLVx9XaUOpfYd2tNO4=
X-Received: by 2002:a05:651c:156:: with SMTP id c22mr16867548ljd.453.1593955501045;
 Sun, 05 Jul 2020 06:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <CANvSZQ_5p4JD4v79gFkSRBBvehCDh_Q5bBKeyNi912tr0biNLg@mail.gmail.com>
 <90c7edc7-9b1d-294f-5996-9353698cedbe@gmx.com> <CANvSZQ_HDZ=54MW+dSAP1A_zUiaGR_PLkV7anQj5K+qNds0QsQ@mail.gmail.com>
 <2483ed80-90ae-765d-e3d3-15042503841c@gmx.com>
In-Reply-To: <2483ed80-90ae-765d-e3d3-15042503841c@gmx.com>
From:   Thilo-Alexander Ginkel <thilo@ginkel.com>
Date:   Sun, 5 Jul 2020 15:24:45 +0200
Message-ID: <CANvSZQ_NCb_RZyd0Z5v1W8ggrDuBRs4Gw1Q_wT62DC1e+8fjTA@mail.gmail.com>
Subject: Re: Growing number of "invalid tree nritems" errors
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 5, 2020 at 2:10 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > I did some log analysis: The problem started showing up on two of
> > three servers starting July 3rd, 2020. This coincides with an applied
> > Ubuntu Linux kernel update to 4.15.0-109-generic whose changelog shows
> > plenty of btrfs changes:
> > https://launchpad.net/ubuntu/+source/linux/4.15.0-109.110
>
> So it backported all these restrict self check of recent kernels.
>
> That's great to expose any unexpected metadata.
> Although sometimes backport itself may introduce new bugs (very rare),
> especially for heavy backported kernels.
>
> So if it's possible, try upstream kernel can also be an alternative to
> test if it's really something wrong.

I took Patrik Lundquist's advice and upgraded to the latest HWE
kernel, which is based on 5.3.0. I'll follow your suggestions if the
problem manifests again.

> > Server #2 (still online) shows 16 error messages in its log since
> > 2020-07-03 whereas server #3 shows 310 error messages.
>
> Then it shouldn't be a hardware problem unless all servers have the same
> problem.

ACK. Memory test also came back negative.

> > On thing special about server #3 is that its btrfs file system has a
> > huge metadata section (probably due to it hosting many [~ 50 Mio]
> > small files), which doesn't seem too healthy:
> >
> > # btrfs filesystem usage /mnt
> > Overall:
> >     Device size:                 476.30GiB
> >     Device allocated:            372.02GiB
> >     Device unallocated:          104.28GiB
> >     Device missing:                  0.00B
> >     Used:                        272.16GiB
> >     Free (estimated):            194.49GiB      (min: 194.49GiB)
> >     Data ratio:                       1.00
> >     Metadata ratio:                   1.00
> >     Global reserve:              512.00MiB      (used: 0.00B)
> >
> > Data,single: Size:284.01GiB, Used:193.80GiB
> >    /dev/mapper/luks      284.01GiB
> >
> > Metadata,single: Size:88.01GiB, Used:78.36GiB
> >    /dev/mapper/luks       88.01GiB
>
> In fact, your metadata is not that unhealthy.

Allright, thanks for pointing this out. The other servers have ~ 1.5
GB allocated for metadata, so this seemed way off (but can probably be
explained by the vastly different file system usage on #3).

Thanks,
Thilo
