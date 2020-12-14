Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C06F2DA278
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 22:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388560AbgLNVTy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 16:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503389AbgLNVTs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 16:19:48 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6833AC0613D3
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 13:19:08 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id 7so13049845qtp.1
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 13:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NGX4Hj1BCjD7dVGSWLrN3KnJwZTiV13tjHzrbjGQLKE=;
        b=tohvXNGbq6G7lekFccrfYE+/mGIWopiOjdWKghtgsxRsGrBhchRZViBhCBFezzvRMM
         bhzGgw/CwvIz+gBYCjxTk+KuzLcPMoTTJFhjgbbZc9YgMpIjbQmPyY0EudHAMvkQxWr+
         BDL+y4vzKl/8KbjVEC/ST6VNEx+dsjANilOavl5YA07mszS2CQLe1ETIVfjiJ8QZ70Po
         qU4Wgugxyk6QOaFJE5SKD2Yx7jBKreHcULM13XzcVUgk6M2scHpPuaU294iTidquxbF6
         kEhBzCijfJT7Uzb0io7gyv3NLwN3WxvQLQbv2cz5Y6BqCWLR/zzh7T0kRW795UK+b6+b
         cAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NGX4Hj1BCjD7dVGSWLrN3KnJwZTiV13tjHzrbjGQLKE=;
        b=bTASgzOWsKeUBjhQR9oqIG6Bf+IeMCfZ+jd1m/+TQS5bR2grZyyx9JUKIgQfUN/FRH
         awIjXTr6ZdMIsDf7lVvrpMEbqPCoF/W+Rgt1GX4ueFJWhBizk+/nLmnG4GwWN4G9TyFD
         GgNVWQAvKBmn+mkPHhnugThIByj18GxPomQaUaiJoFqK/wRXVAuDGwiEwNQgcwjXJ8Gm
         pCK8stNtQ1jWLRqIWO9nyBd9zbsS+DQJ8ia7+b2yJmCeVU1R4Y/YDhJLj4dbFFiUNnD6
         KS0rn2Qzv8TwkgzZB6J2+LCN2bB1q2hXByX4kHbyn63I1LLThZqkN1p9XLA+hikTJibc
         q1Rg==
X-Gm-Message-State: AOAM531b0PhqimsffSagl3QQydf7X3HHwf/O1Whmq/SkcienaO15j2b8
        m/StlzdrkGLKmoWmAkJbXQ1sCiYOIEbvPl1Jy0HPBfIwDmBAjQ==
X-Google-Smtp-Source: ABdhPJzI1J+iAS2dbt0QTqowWmLHa/Y2JaZcSmr+i12KxrM2GnyDIYveXEwmAuCuxttQuKl7mRBGlH+Ia1iI5n0qok8=
X-Received: by 2002:ac8:4615:: with SMTP id p21mr31483819qtn.45.1607980747543;
 Mon, 14 Dec 2020 13:19:07 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZtU1dAYMSUR4fXbcuS4i=gU=ukC-9Y7io3pUMUt3S+Bjw@mail.gmail.com>
 <ccb8c05e-fa56-c88b-c211-f250fe85d815@applied-asynchrony.com>
 <CAA85sZvFBMad6N8hHR5YM56X9DxKE_3CyOT3xEnp9KsWX=fuHQ@mail.gmail.com> <CAA85sZt_deCX-jwtwfT_izf_6nsQXbroe=ksKfNErCwjFXWu_g@mail.gmail.com>
In-Reply-To: <CAA85sZt_deCX-jwtwfT_izf_6nsQXbroe=ksKfNErCwjFXWu_g@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 14 Dec 2020 22:18:56 +0100
Message-ID: <CAA85sZseX5FLT-RBFRHjZ0_F0V3X9fFEG4faU02KLaXwgaV=PA@mail.gmail.com>
Subject: Re: Odd filesystem issue, reading beyond device
To:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 14, 2020 at 9:33 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> On Mon, Dec 14, 2020 at 8:57 PM Ian Kumlien <ian.kumlien@gmail.com> wrote=
:
> >
> > On Mon, Dec 14, 2020 at 5:50 PM Holger Hoffst=C3=A4tte
> > <holger@applied-asynchrony.com> wrote:
> > >
> > > On 2020-12-14 17:28, Ian Kumlien wrote:
> > > > Hi,
> > > >
> > > > Upgraded from 5.9.6 to 5.10 and now I get this:
> > > > [  581.665506] BTRFS: device fsid 3c16de2d-33b6-436a-ba17-38b917ae3=
e33
> > > > devid 1 transid 258057 /dev/dm-0 scanned by systemd-udevd (1043)
> > > > [  589.602444] BTRFS info (device dm-0): use lzo compression, level=
 0
> > > > [  589.602459] BTRFS info (device dm-0): enabling auto defrag
> > > > [  589.602465] BTRFS info (device dm-0): using free space tree
> > > > [  589.602470] BTRFS info (device dm-0): has skinny extents
> > > > [  589.603082] attempt to access beyond end of device
> > > >                 dm-0: rw=3D4096, want=3D36461289632, limit=3D109715=
43296
> > > > [  589.603108] attempt to access beyond end of device
> > > >                 dm-0: rw=3D4096, want=3D36461355168, limit=3D109715=
43296
> > > > [  589.603125] BTRFS error (device dm-0): failed to read chunk root
> > > > [  589.603412] BTRFS error (device dm-0): open_ctree failed
> > > > [  834.619193] BTRFS info (device dm-0): use lzo compression, level=
 0
> > > > [  834.619209] BTRFS info (device dm-0): enabling auto defrag
> > > > [  834.619214] BTRFS info (device dm-0): using free space tree
> > > > [  834.619219] BTRFS info (device dm-0): has skinny extents
> > > > [  834.619825] attempt to access beyond end of device
> > > >                 dm-0: rw=3D4096, want=3D36461289632, limit=3D109715=
43296
> > > > [  834.619844] attempt to access beyond end of device
> > > >                 dm-0: rw=3D4096, want=3D36461355168, limit=3D109715=
43296
> > > > [  834.619858] BTRFS error (device dm-0): failed to read chunk root
> > > > [  834.620205] BTRFS error (device dm-0): open_ctree failed
> > > >
> > > > Any ideas?
> > > >
> > >
> > > See https://lore.kernel.org/lkml/20201214053147.GA24093@codemonkey.or=
g.uk/
> > > + followups. Nothing to do with btrfs.
> >
> > Thank you! and 5.0.1 has been released with the patches reverted, FYI =
=3D)
>
> No, I'm sad to report that that's not it... or there are other deeper
> raid issues...
>
> [  108.688424] BTRFS info (device dm-0): use lzo compression, level 0
> [  108.688439] BTRFS info (device dm-0): enabling auto defrag
> [  108.688444] BTRFS info (device dm-0): using free space tree
> [  108.688449] BTRFS info (device dm-0): has skinny extents
> [  108.688955] attempt to access beyond end of device
>                dm-0: rw=3D4096, want=3D36461289632, limit=3D10971543296
> [  108.688978] attempt to access beyond end of device
>                dm-0: rw=3D4096, want=3D36461355168, limit=3D10971543296
> [  108.688994] BTRFS error (device dm-0): failed to read chunk root
> [  108.689310] BTRFS error (device dm-0): open_ctree failed
>
> This is with 5.0.1

As an update, 5.9.6 can't mount it either

> > > -h
