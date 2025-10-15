Return-Path: <linux-btrfs+bounces-17795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B98ABBDC1BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 04:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063CB19A2999
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 02:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C320306497;
	Wed, 15 Oct 2025 02:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QupgjsJG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187822F9D98
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 02:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493932; cv=none; b=qVH30RTewyTy8KvO852+JD9keKl2hvBqFeoGzZsCpvd6yIpNIpMlaBItZ7HV3uvzm/od2iEYqCxz1EtqrEAIiq9Lrv4EarfkmXk4lHd/31t/QvCdgW6C0xxATpHlGHD51vXoHt101VeSYMQmgZK0uPItlE/+Duc5jjq8uClLOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493932; c=relaxed/simple;
	bh=zah8GoMx4t7Y8KzAHYFyhYX3cEmhQaMAQFyjjFl+USQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVzd301BJOYi8ORM9OlUOWQtufhSpjH9mqAnLiy8oQVbCehDK5xkQ+HhZkJTs4Lg71JFQOFZJ/cnzD+X0PVjq4u8D5vy+H8HUBPEw/yiFDNVfH+zhrZ6CC8MVJpk7G4YRG6fxBPlIdOqU1WaKMDIcJ6m2A3+CYzfktQT7s7pSBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QupgjsJG; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6399706fd3cso8909495a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 19:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760493929; x=1761098729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKhCxA1YqqaSwtRMPjxglk98QEUn4l+Ta7agpDqpKxQ=;
        b=QupgjsJGGxdnCcuTdPv2lpnlbcMNSZO8ZJSndZTjbjCWgveJIkV54XCS57Wyarhnfw
         akrVIOJ0vZoZ7SXPPDNAnsR0drZtLtPEyJ5/gaEut9QdC2T3BR/z+4srDQPEHeMMu7ua
         CO7A9ojVvG3wLRRu/4Q8jOtwUQORD45242JxItYqCIwiLhcxvLt5P1PFQu7Jjhd2RJt5
         AncY5MMOjXAZdnXex6HKpo3HgpRk+nGupsH0U1J+5h2E4gg3MFyn8d631d5bcHNuDskj
         ahakWmA0iTXtwIEsXf2OuJ/oYeZmsemDTnBjy17pe81dbuxJk1Z97ES/wGaNQErWBOB4
         Qx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760493929; x=1761098729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKhCxA1YqqaSwtRMPjxglk98QEUn4l+Ta7agpDqpKxQ=;
        b=vcqZAEbwnrOSs3v8/LVGFRq2wunjg+pZpAWyzp7n2xKHG40UfU2xKPCx/JmAF19Kx9
         IXwyqcN9kfPbpAc2Kk2kUYoW0AAtIfolHPIRSed+/yEudIOYYUA1TyF8fOFDH+LvuXNe
         CDLaTZ5loIv+FmIbh2AdEpuECTkwOnBVyF+t9sL2AinR7HDHgPFCWpyN/0xQxie1EtbV
         CQ7Mn21f6Gd8+4ph2fCyFmYQpbAQgeTBzhtoXH16Sw9tnxGo5Ie5Fxb1lTtrlK12h5rf
         OIVZT3vXJhfakoK0JtDIkv9wJZB2GUFZhGZvTnTDyy2z/WNfnc0H2MczZd/NA2McUQc4
         1rHg==
X-Forwarded-Encrypted: i=1; AJvYcCVAXEaTt9fm4oYBwIBWoSCr9LhD1dyaVu4/xfQ78tOLr/vK9Idah9OM3khoDil5qAN2c2lVWcWzmuILiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/8uu1VV4vEC0ucCCoGh4Nk4FXkI/0r3D0zjKe42zI1Z+sP2vr
	7nHKEDEX0xjjDrLA0le97/4vdcJ6bxDVdd6tGjlMUBT9uvcRr+28F8Dv1ngmxP2wyaiV7ohjGKW
	0bkVGbB/J58pbvYHmTdoVRo5UJ0+mjDs=
X-Gm-Gg: ASbGncsZNd1YR9irgq56+izoSVh42JoqZHzdjrqkhiuZl+1wIDHjrwBQKWRRvByWOnG
	EGCFcXGbN4Y2zlGDF7j7zNBXv4hEB9IJ6JYP62rdH6d/ceh+x8fGCR+4NQS5VfBUdyhCa0lPbNU
	nBfrckdvTE2G5ghHseUWz+xe9xM/fvL20dyG5vNthB5qS8M9bVHq6ICjXgdwHfMy+5/nuPFi2QE
	0HvV0tzRLCd3CHEuB77yFuhGOqN73olGw==
X-Google-Smtp-Source: AGHT+IFaiH5dYgbjfXcrrQZUJM14oq0bpNnOs4wwe+O1Jm6Z6woUs0MetIXN80YuNypyfk0WVfKln435nvyh25EK/AY=
X-Received: by 2002:a17:907:7f22:b0:afe:cbee:7660 with SMTP id
 a640c23a62f3a-b50aaa97b23mr2705396166b.21.1760493929093; Tue, 14 Oct 2025
 19:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175865066509.3489281.5792211607743744274.reportbug@ruoska>
 <aNLr-GKpufof8HME@eldamar.lan> <CABaPp_jAFwsobgdk38Qhigqn+Tgb1UQK9RDJF3sCFT1_KH3SQg@mail.gmail.com>
 <CABaPp_j21HxgXFT5JZkKW1QeZmAtxYPAgWKo-nm15mWMvj-7BA@mail.gmail.com>
In-Reply-To: <CABaPp_j21HxgXFT5JZkKW1QeZmAtxYPAgWKo-nm15mWMvj-7BA@mail.gmail.com>
From: james young <pronoiac@gmail.com>
Date: Tue, 14 Oct 2025 21:05:17 -0500
X-Gm-Features: AS18NWCjauatWogMh4LzcgUp2y_9rZiR668-9dtIBFE2EVFyDCCbWLt6wonpqos
Message-ID: <CABaPp_j8VZyLUtiKjnTksKqEzpaYj6vw=TEM_=CkMUvA+O3sfw@mail.gmail.com>
Subject: Re: Bug#1116067: linux-image-6.1.0-32-amd64: btrfs compression
 quietly stopped around 60TB in
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: 1116067@bugs.debian.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Whoops, I hadn't intended to top-post... I'll do it correctly this time.

On Thu, Sep 25, 2025 at 12:57=E2=80=AFPM james young <pronoiac@gmail.com> w=
rote:
>
> I'm not sure what timeline to expect for a response.
> Would a tarball of the outer image preserve everything needed for diagnos=
tics?
>
> -James
>
> On Tue, Sep 23, 2025 at 2:10=E2=80=AFPM james young <pronoiac@gmail.com> =
wrote:
> >
> > I hit an issue with btrfs compression; I reported it to Debian, which
> > I was using, and they suggested that I take it upstream.
> >
> > Thanks, Salvatore. My apologies to everyone if I misunderstood.
> >
> > -James
> >
> > On Tue, Sep 23, 2025 at 1:50=E2=80=AFPM Salvatore Bonaccorso <carnil@de=
bian.org> wrote:
> > >
> > > Control: tags -1 + moreinfo
> > >
> > > Hi James,
> > >
> > > On Tue, Sep 23, 2025 at 08:04:25PM +0200, James Young wrote:
> > > > Package: src:linux
> > > > Version: 6.1.129-1
> > > > Severity: normal
> > > > X-Debbugs-Cc: pronoiac@gmail.com
> > > >
> > > > Dear Maintainer,
> > > >
> > > >
> > > > * What led up to the situation?
> > > > We made empty files in a loop, in parallel, under CPU and I/O load.
> > > > We had an outer Btrfs image file with compression, which contained =
a Btrfs image file, which contained billions of empty files.
> > > > We wrote around 100TB to the inner image file.
> > > > Around 60TB in, compression quietly shut off.
> > > > We ran out of space; both mounts presented i/o errors.
> > > >
> > > > * What exactly did you do (or not do) that was effective (or ineffe=
ctive)?
> > > >   * I unmounted the inner and outer images.
> > > >   I didn't take note of memory usage before this point.
> > > >   * dump debug info for the outer image - `btrfs inspect-internal d=
ump-tree --dfs ...`
> > > >   * We started a btrfsck. (twice, actually; breadth-first hit memor=
y limits, I think)
> > > > After that, I learned about `btrfs check`, but didn't interrupt the=
 btrfsck, due to Sunk Cost Fallacy.
> > > > The btrfsck is still running. It's of extremely dubious value now.
> > > > * check the kernel logs
> > > >   * I grepped for btrfs, the mount points, compress, and zstd. I di=
dn=E2=80=99t find a smoking gun in the right timeframe.
> > > >
> > > > not done yet:
> > > > * mount the outer image
> > > > * rebooted
> > > > * tried a newer kernel. we're currently on kernel 6.1.129; we could=
 go to newer 6.1 or 6.12 kernels
> > > > * redo live file system compression, with e.g. `btrfs filesystem de=
frag -czstd`
> > > > * fstrim the outer image
> > > >
> > > > goals:
> > > > * work out what happened.
> > > > How can we help?
> > > > * help avoid it happening again, to others
> > > > * salvage what we can
> > > >
> > > > I've run `bugreport` as a non-privileged user. Let me know if root =
access would give a fuller picture.
> > >
> > > I believe the best thing you could do here is to contact actually
> > > upstream people directly. get_maintainers and the MAINTAINERS file
> > > has:
> > >
> > > BTRFS FILE SYSTEM
> > > M:      Chris Mason <clm@fb.com>
> > > M:      Josef Bacik <josef@toxicpanda.com>
> > > M:      David Sterba <dsterba@suse.com>
> > > L:      linux-btrfs@vger.kernel.org
> > > S:      Maintained
> > > W:      https://btrfs.readthedocs.io
> > > Q:      https://patchwork.kernel.org/project/linux-btrfs/list/
> > > C:      irc://irc.libera.chat/btrfs
> > > T:      git git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux=
.git
> > > F:      Documentation/filesystems/btrfs.rst
> > > F:      fs/btrfs/
> > > F:      include/linux/btrfs*
> > > F:      include/trace/events/btrfs.h
> > > F:      include/uapi/linux/btrfs*
> > >
> > > So I would suggest you to contact above maintainers including the
> > > list.
> > >
> > > Please keep this downstream bugreport as well in the recipients list.
> > >
> > > Regards,
> > > Salvatore

I made a tarball of the file system, then mounted and looked at the
file systems.
I attempted to recompress (with btrfs defrag) and fstrim, with little
success in freeing up space.

I started btrfs check with the progress option; within two hours, it
had gotten to =E2=80=9C[2/7] checking extents, 82 items checked=E2=80=9D.
I confused the extents with the compressed chunk length - 128KiB - so
that seemed woefully low on progress.
Over a week later, it=E2=80=99s still "82 items checked".
It=E2=80=99s still taking CPU (3% right now) and gigs of memory; it=E2=80=
=99s doing
something, though slowly.

So, a question:
* is this business as usual for a btrfs check?
* is this a clue about what happened?
* is this a symptom?

If this is a useful metric for file system robustness, is this
something I could / should experiment with to shorten?
* run `sync`
* periodically pause writes, to let the buffers empty

Any thoughts or suggestions?

-James

