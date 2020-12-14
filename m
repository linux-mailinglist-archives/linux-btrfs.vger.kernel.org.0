Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B072A2DA1A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 21:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503352AbgLNUes (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 15:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503388AbgLNUel (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 15:34:41 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E704C0613D3
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 12:34:01 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id q7so8434465qvt.12
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 12:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WhgkOAK/vr2Dt9FZMdPta6PIWPIlNAZJJmY2u9ty0T8=;
        b=rAkOcrVM+6z5Dp7oETypGoZJyzF/bqW97i6O7Rxa44gdiUoXKWi/+MfPwmj0KvtQpB
         TCzqIp+JcoD2u65RswpBOh+nCCohCBPuNO9KX3+1hn2/qtPDBYs5t1keuLz3k2qWE1NA
         Iu0/rUxEIbYRfu7PpSpkg48BihUWbz+luaSmp+o3sMczS3P6pD2ygLY9/CNxE6VLgNN8
         fQCcuYLDca6eWFOlfLxnSrCemH1Q7wl5PGPYd3w61tTA7DTEsygs37KXA34hy/xqL79P
         Z/DnswTRhgopET8LrHENWT9Z5OPz1qMqgJNyQwPaMUJH0Wdtv+YHrh8OE/GnZLNKZKFm
         mAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WhgkOAK/vr2Dt9FZMdPta6PIWPIlNAZJJmY2u9ty0T8=;
        b=M1OmrsGruqcRKTAdRQg1EZkWAYfXpO8t+5nvEpOt447NuKzwan6t4ye0Ka7xm1zoj8
         I8JKE8cgu4zooljF2Tqb4CLZyN00xxPieODayqA0KaaHS4Xfx4Crx1NgXiTSpbUDjkev
         QPhOh6rY9clhjB+xofTN877rSe2Hj+idTTR/QLh//bpaHXgtyqrVLMmpbQdsQKA+RiLi
         beiBiVfEqWq0PxS8bES7xW0lqvhRpLkehxK13Idcgf86KpaZ5VMwhrT8umjEmP3Be2qX
         elW6H34tYBVXHHWlM9z3o2nF/JztfCGw6T0gNvC6JfglHcuq9cOiJkTL5en0SAos4u/U
         jMFA==
X-Gm-Message-State: AOAM531PSe7xQiLvC/lwe2iXMz62AVCPjKuGMocKe9pB2pSlghsTlebL
        NI4iqvCQ6Awmtk+Qw6QFp4MFef4ApliV9pQfwFyqnG4LXzZXliHF
X-Google-Smtp-Source: ABdhPJzdMV1pHWFxO5mys7UI94pNoYVYQiqAHiOYA68jlk2qxXKkNgzI0JxzzvKCx6YkMTB2vAX1TNm1tWUh0etdZfY=
X-Received: by 2002:a05:6214:1887:: with SMTP id cx7mr8483866qvb.39.1607978040707;
 Mon, 14 Dec 2020 12:34:00 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZtU1dAYMSUR4fXbcuS4i=gU=ukC-9Y7io3pUMUt3S+Bjw@mail.gmail.com>
 <ccb8c05e-fa56-c88b-c211-f250fe85d815@applied-asynchrony.com> <CAA85sZvFBMad6N8hHR5YM56X9DxKE_3CyOT3xEnp9KsWX=fuHQ@mail.gmail.com>
In-Reply-To: <CAA85sZvFBMad6N8hHR5YM56X9DxKE_3CyOT3xEnp9KsWX=fuHQ@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 14 Dec 2020 21:33:49 +0100
Message-ID: <CAA85sZt_deCX-jwtwfT_izf_6nsQXbroe=ksKfNErCwjFXWu_g@mail.gmail.com>
Subject: Re: Odd filesystem issue, reading beyond device
To:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 14, 2020 at 8:57 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> On Mon, Dec 14, 2020 at 5:50 PM Holger Hoffst=C3=A4tte
> <holger@applied-asynchrony.com> wrote:
> >
> > On 2020-12-14 17:28, Ian Kumlien wrote:
> > > Hi,
> > >
> > > Upgraded from 5.9.6 to 5.10 and now I get this:
> > > [  581.665506] BTRFS: device fsid 3c16de2d-33b6-436a-ba17-38b917ae3e3=
3
> > > devid 1 transid 258057 /dev/dm-0 scanned by systemd-udevd (1043)
> > > [  589.602444] BTRFS info (device dm-0): use lzo compression, level 0
> > > [  589.602459] BTRFS info (device dm-0): enabling auto defrag
> > > [  589.602465] BTRFS info (device dm-0): using free space tree
> > > [  589.602470] BTRFS info (device dm-0): has skinny extents
> > > [  589.603082] attempt to access beyond end of device
> > >                 dm-0: rw=3D4096, want=3D36461289632, limit=3D10971543=
296
> > > [  589.603108] attempt to access beyond end of device
> > >                 dm-0: rw=3D4096, want=3D36461355168, limit=3D10971543=
296
> > > [  589.603125] BTRFS error (device dm-0): failed to read chunk root
> > > [  589.603412] BTRFS error (device dm-0): open_ctree failed
> > > [  834.619193] BTRFS info (device dm-0): use lzo compression, level 0
> > > [  834.619209] BTRFS info (device dm-0): enabling auto defrag
> > > [  834.619214] BTRFS info (device dm-0): using free space tree
> > > [  834.619219] BTRFS info (device dm-0): has skinny extents
> > > [  834.619825] attempt to access beyond end of device
> > >                 dm-0: rw=3D4096, want=3D36461289632, limit=3D10971543=
296
> > > [  834.619844] attempt to access beyond end of device
> > >                 dm-0: rw=3D4096, want=3D36461355168, limit=3D10971543=
296
> > > [  834.619858] BTRFS error (device dm-0): failed to read chunk root
> > > [  834.620205] BTRFS error (device dm-0): open_ctree failed
> > >
> > > Any ideas?
> > >
> >
> > See https://lore.kernel.org/lkml/20201214053147.GA24093@codemonkey.org.=
uk/
> > + followups. Nothing to do with btrfs.
>
> Thank you! and 5.0.1 has been released with the patches reverted, FYI =3D=
)

No, I'm sad to report that that's not it... or there are other deeper
raid issues...

[  108.688424] BTRFS info (device dm-0): use lzo compression, level 0
[  108.688439] BTRFS info (device dm-0): enabling auto defrag
[  108.688444] BTRFS info (device dm-0): using free space tree
[  108.688449] BTRFS info (device dm-0): has skinny extents
[  108.688955] attempt to access beyond end of device
               dm-0: rw=3D4096, want=3D36461289632, limit=3D10971543296
[  108.688978] attempt to access beyond end of device
               dm-0: rw=3D4096, want=3D36461355168, limit=3D10971543296
[  108.688994] BTRFS error (device dm-0): failed to read chunk root
[  108.689310] BTRFS error (device dm-0): open_ctree failed

This is with 5.0.1

> > -h
