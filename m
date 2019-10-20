Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80D8EDE0C3
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Oct 2019 23:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfJTVmO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Oct 2019 17:42:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54608 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfJTVmO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Oct 2019 17:42:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so11104402wmp.4
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Oct 2019 14:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCKwdC6forXflCR0yb5jfqws9kfA367B0MxLgwQnDWY=;
        b=ZChEwc90/+bEv6pMvTXbM27t5X1K2ALJM7Q3P9FSJqgX/5b6QoQ8PLWRbEa836hcfL
         fxlHIIMUIZVs4mlxIKTsFBpZjA318PKMwN8bbOcYVuIoBfsAmRfQXWmW/fs+5s18O8yB
         ZKu8KFKaS0hAkXShUdY1SASxFt1EwyDrCCyDBgcFlgev7ZDZVfR+BCMXpH6vvuVMfCc2
         NfC+9Ad+PZVA5C1DzYpsilRRJa7JauVdKlQwPzRHWcmCT6DHpEEZ6Mcm/59jjOLvtsva
         51l7aHxIdcfYHXZuILxLFA4gE5kMX2hR/ld8N5D7dngKeayet8aMbtBXcdIvMgA8OgnE
         zmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCKwdC6forXflCR0yb5jfqws9kfA367B0MxLgwQnDWY=;
        b=VSVkBUD8wbptiM5+UfrOKlywyPhLkpg2yfstDCbUuYbopuD7XaIFVuXakoSDPcbx3O
         hN1SoxBICOeNqtKzAOGuRqek/P+olwYg6WUuOdTrbZl/9TrnNJv9foMxb+EinD5xNU70
         oeeBXufctvssrJgaMiFA7g/O5PYQSopjwIVYUeVRu6T98LC1H3VF2XYkDpPG4TElR1SU
         pGKeyyALIz+XzZ6lcIJ0YrDkimuCKlQZ56BlBEGYP96lZPU21/AxQtxyRx+rCjNaI3ZX
         k8j9JJI4ByV9kRqNGFsMD5YtBU1JHfultpM/FZ4Nm+NYifGi9KeKdDh4E0jXXDhESooP
         IBWg==
X-Gm-Message-State: APjAAAUEjquuO7fC8mnwaVgMNl/KgsklTOH/ezhEYDUdSmdRKiJT4caG
        rz7e4Nxhv65UciGOoWjTPYo58C7otWJSNnhzdppQpkEIklXqkg==
X-Google-Smtp-Source: APXvYqztkhnt7pOwBfRkvi9CzWFPlKXFkmbUdMWBJvg7s0kw9dn0lviZY2xZzEojXJM7SGw+QOnMqYkh4Cf2mOTkQ2s=
X-Received: by 2002:a7b:cbc5:: with SMTP id n5mr195043wmi.65.1571607732360;
 Sun, 20 Oct 2019 14:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <b665710c-5171-487b-ce38-5ea7075492e4@liland.com>
 <CACa3q1wUmgY9uTygYFVBer=QgZjtwX2NOvVT68kAYKAgoLpXRg@mail.gmail.com>
 <CAJCQCtR=NQd6uovvAhuTdxRNJtnMFDtkTma9u8-Ep9Nq+YQY=A@mail.gmail.com> <be2aa15e-0539-219f-c2d6-fdb01297351e@cobb.uk.net>
In-Reply-To: <be2aa15e-0539-219f-c2d6-fdb01297351e@cobb.uk.net>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 20 Oct 2019 23:41:54 +0200
Message-ID: <CAJCQCtSKTJKj5xTk2aUyXCrSZ2LOCfjyB400He3Be79Vz0OUug@mail.gmail.com>
Subject: Re: MD RAID 5/6 vs BTRFS RAID 5/6
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 17, 2019 at 8:23 PM Graham Cobb <g.btrfs@cobb.uk.net> wrote:
>
> On 17/10/2019 16:57, Chris Murphy wrote:
> > On Wed, Oct 16, 2019 at 10:07 PM Jon Ander MB <jonandermonleon@gmail.com> wrote:
> >>
> >> It would be interesting to know the pros and cons of this setup that
> >> you are suggesting vs zfs.
> >> +zfs detects and corrects bitrot (
> >> http://www.zfsnas.com/2015/05/24/testing-bit-rot/ )
> >> +zfs has working raid56
> >> -modules out of kernel for license incompatibilities (a big minus)
> >>
> >> BTRFS can detect bitrot but... are we sure it can fix it? (can't seem
> >> to find any conclusive doc about it right now)
> >
> > Yes. Active fixups with scrub since 3.19. Passive fixups since 4.12.
>
> Presumably this is dependent on checksums? So neither detection nor
> fixup happen for NOCOW files? Even a scrub won't notice because scrub
> doesn't attempt to compare both copies unless the first copy has a bad
> checksum -- is that correct?

Normal read (passive) it can't be detected if nocow, since nocow means
nodatasum. If the problem happens in metadata, it's detected because
metadata is always cow and always has csum.

I'm not sure what the scrub behavior is for nocow. There's enough
information to detect a mismatch if in normal (not degraded)
operation. But I don't know if Btrfs scrub warns on this case.


> If I understand correctly, metadata always has checksums so that is true
> for filesystem structure. But for no-checksum files (such as nocow
> files) the corruption will be silent, won't it?

Corruption is always silent for nocow data. Same as any other
filesystem, it's up to the application layer to detect it.


-- 
Chris Murphy
