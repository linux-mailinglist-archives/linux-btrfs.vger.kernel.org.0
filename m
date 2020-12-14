Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0710D2DA0F6
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 21:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502779AbgLNT6z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 14:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502875AbgLNT6k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 14:58:40 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4300AC0613D3
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 11:58:00 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id b9so12807568qtr.2
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 11:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ptFxjqL/WXovjqSFX8GQQF5yqpG/xvXmNl1jQUgol2E=;
        b=EytdfhiqNt3nrZYBwoEce4ZZsXczewh59ANCXLNb/UCm/l4ZmwNd/p0Jw3XNxe+Gdq
         W3DVxtbDx/L7PJ8pnwCIw6PZPhGLf4KwwhUgLyByW11+gsHmoggZNBnZctQ4MUgSv6J9
         JD6X4/X1XTmh0DKZMwL82QHsp7H+H4atoIVWzH2Vge0GfPZXJ+4Ha3qrcFeST/NYgdo0
         9Pgbr+xGIf5LpcABW3ohawR/rc/DoVTXt0HlNyswd3aWLzjZnzcmtLe//Gi7eG6ar02N
         xTh6Er4sllDAoiCnAIf851FO25bvvtCyrCYgAaLcM+nwTkwOeCvnSmeCnJzdRrDsNWXv
         Tlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ptFxjqL/WXovjqSFX8GQQF5yqpG/xvXmNl1jQUgol2E=;
        b=P1/bWG3dmfsJBkW1aCuzZbe8OAGB6C12t2UObS8LdjrkjDYjgU3fgIRdSOwLT7T8HI
         KYRKhswNCBiLKK7R9gse1BLV6IzcbqoaGGKuBaVW1pkYvjy5ev4Ei4rWTimEYSCdqjv1
         FMjbPQhTsI0T92ifcQSRb3RUwor0C36fxyhgidn7BUdCXq7MI1Cqy0GBmWCfWYEJaL4Q
         IysirD/C3XcwTr/xv2pgxODPcD5x6DwOAxGEKVpMskbE8Dn8+tupyinRkZX6G5qhXrrU
         7O7hr1fHvpiPe3hTuVhJlQObb+ebHIb1We/ykK83fZHmuUgVVSVnAUlzvVYEDONqs6Xb
         3ETw==
X-Gm-Message-State: AOAM531LD9VJRIgdYgPolbdTbVFxxEGAgY2zRXMWnCSjNm2HndVQS6Xe
        fnAH9GwaXL9Pf6UIT0pOMRneLy8tysL2Cu3Hi1Vga27tjLk8jQ==
X-Google-Smtp-Source: ABdhPJxQ5t+GiSvSOsUkXMP8WxIO4QHwjHSd3WIUeZz99IBoh4wlhdu8//IlRnEDMEa9mt6wC+WmTMPeW07NPId7AyA=
X-Received: by 2002:ac8:4615:: with SMTP id p21mr31076771qtn.45.1607975879326;
 Mon, 14 Dec 2020 11:57:59 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZtU1dAYMSUR4fXbcuS4i=gU=ukC-9Y7io3pUMUt3S+Bjw@mail.gmail.com>
 <ccb8c05e-fa56-c88b-c211-f250fe85d815@applied-asynchrony.com>
In-Reply-To: <ccb8c05e-fa56-c88b-c211-f250fe85d815@applied-asynchrony.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 14 Dec 2020 20:57:48 +0100
Message-ID: <CAA85sZvFBMad6N8hHR5YM56X9DxKE_3CyOT3xEnp9KsWX=fuHQ@mail.gmail.com>
Subject: Re: Odd filesystem issue, reading beyond device
To:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 14, 2020 at 5:50 PM Holger Hoffst=C3=A4tte
<holger@applied-asynchrony.com> wrote:
>
> On 2020-12-14 17:28, Ian Kumlien wrote:
> > Hi,
> >
> > Upgraded from 5.9.6 to 5.10 and now I get this:
> > [  581.665506] BTRFS: device fsid 3c16de2d-33b6-436a-ba17-38b917ae3e33
> > devid 1 transid 258057 /dev/dm-0 scanned by systemd-udevd (1043)
> > [  589.602444] BTRFS info (device dm-0): use lzo compression, level 0
> > [  589.602459] BTRFS info (device dm-0): enabling auto defrag
> > [  589.602465] BTRFS info (device dm-0): using free space tree
> > [  589.602470] BTRFS info (device dm-0): has skinny extents
> > [  589.603082] attempt to access beyond end of device
> >                 dm-0: rw=3D4096, want=3D36461289632, limit=3D1097154329=
6
> > [  589.603108] attempt to access beyond end of device
> >                 dm-0: rw=3D4096, want=3D36461355168, limit=3D1097154329=
6
> > [  589.603125] BTRFS error (device dm-0): failed to read chunk root
> > [  589.603412] BTRFS error (device dm-0): open_ctree failed
> > [  834.619193] BTRFS info (device dm-0): use lzo compression, level 0
> > [  834.619209] BTRFS info (device dm-0): enabling auto defrag
> > [  834.619214] BTRFS info (device dm-0): using free space tree
> > [  834.619219] BTRFS info (device dm-0): has skinny extents
> > [  834.619825] attempt to access beyond end of device
> >                 dm-0: rw=3D4096, want=3D36461289632, limit=3D1097154329=
6
> > [  834.619844] attempt to access beyond end of device
> >                 dm-0: rw=3D4096, want=3D36461355168, limit=3D1097154329=
6
> > [  834.619858] BTRFS error (device dm-0): failed to read chunk root
> > [  834.620205] BTRFS error (device dm-0): open_ctree failed
> >
> > Any ideas?
> >
>
> See https://lore.kernel.org/lkml/20201214053147.GA24093@codemonkey.org.uk=
/
> + followups. Nothing to do with btrfs.

Thank you! and 5.0.1 has been released with the patches reverted, FYI =3D)

> -h
