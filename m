Return-Path: <linux-btrfs+bounces-17129-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCC0B974D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 21:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A403BA5EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 19:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828382FFDF2;
	Tue, 23 Sep 2025 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg5S0Ubd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246691DF72C
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654622; cv=none; b=uGnkP1dNAKnFHLs0JLTtAcvl3W4hPg28N2NpyO1bpg5P/cpn2WMrGO1VvlgVEqNGCcO/0virRJo5ZJin2SdXiHWDSffzOfaAenoIx3dyDO+jpmOJHDr8vINEGMcd54U3KgDxD1MBCh+MKu0+LDhHkmv3FkQL2MPzES+69XsEgcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654622; c=relaxed/simple;
	bh=Xr8+bWU+Duas4bitAzb/RBMEuCQT00tqH/Cws2XdN+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2MGtaQp9p+diJZ1YVp832dx1sf036ivpNJZ+SrYr6TsmTFQGdOhD4eTEUydJjczPyzu307H1J55HNm8+piOAaKbRLeHFSr00BU2EVJSz4qtEXbe3f4ZW5A7gtup0TfSLxye9BSVJ6zpymqmQ0fxI8G484a+X0rQM7t6dwD0fsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zg5S0Ubd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b0787fdb137so930644166b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758654619; x=1759259419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dq+dpZNwIXPGXVbCbYMdwwVVhlAWTk+cdrsBeDygXIM=;
        b=Zg5S0UbdYhH5vHg8fgLbigCClFigNjWR8FRxsT5oqfdKDgmGAgGvsTkUSQ1KmebcJQ
         4zl/34loKjEu2S4JI7K8cF3ZOZBUvpln//V6KHkpOzhXTFUEjshCTn2trGY278XgOl1/
         u5hmFddoehfuuOxelZDW6W6vSYHWYlmvp7yxoSUxSbfd8QLtza1d2WyaZxZh67Pd8K+C
         YYLITzfKHGiopouz4ZOrY7so4+JK9ERRO6Rx0/8/PLxO7hQV/v55EqdXznaScA8j06ZF
         v7G+yH4WGBwmNjr9cO61SbLb3YZdDVvm9Dl8CDoGma5tep6eAw6rm0BnQ59y71DeVCEQ
         Rp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758654619; x=1759259419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dq+dpZNwIXPGXVbCbYMdwwVVhlAWTk+cdrsBeDygXIM=;
        b=V1wTZ5uULwVXDc6zZU0tIHCJ66ur/nuJ6S8vIwW0vCiTTb8kgYW95z5qZAGPd7ACX2
         Z316FHCLwACneI3hWCUHPG00B5YUSlkx+SWPKw36vfKA1Bqa/fkOYg3gL0Twoo7TxvPS
         iyhQdbcJ9NwhH9CF4n7XLuYnVnS7jRPzIt39SjksiDWIyeWAoKDcTXPtRTM5+uwScK+S
         5avDWLOw68xqsCHY6i4o9+VsRCLjuJPmiVMAa2um6HqZkRvRHgIG/7l9S6WxTE4b8fQA
         nrBa/Cu6WldX1AMwDITmOvJgtajbBCYLQSs+RmSq0OKt5NAKwtFcJB0eBwrQf5xUtcun
         jApA==
X-Forwarded-Encrypted: i=1; AJvYcCWhepjxbFCGdp051OGIkiw0r/DcGl5F4Zt3qGDA6xnBHwgFtVg57ghW1XJLB7Ay1Ubh93SxzoKPk54IWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsb7jM3obXCMTGZsFwPLo5aIuXKq1IK4uLROZ+pG8iU7fL9QI5
	CwbkuaQVpb5juBwc7L/MgyzskgzhJWPf9mBAlGxIg4TSdtkNhvNQId6a0UJYcLNT7fzB4XQJJI+
	1a8fu878mmHaMzmXKrT873y8p1EZ0qWE=
X-Gm-Gg: ASbGncsd5URbpedsDEFDgqQYDq1aXgEGRtZhVS2fmm9zebexkPcD1bVXJtCneNsD+Og
	5oMSqSrRbBDYBjlWUOasNGgxwLSsTvOwX8/VMapGBr1tDkLvepLYLuSqaJwKM26jxA8s/JTL492
	vZTLAl0KN8knQGkmy+d49eSsVDXDae1B3/XyTz0S2shk1tDRoy5a4C51LeLyAYNxYl2RAvT9eHg
	68+6mGoZtD7rZ1ctN1u60UHKdzyaUuZtfeMs2L2VVGQlVI=
X-Google-Smtp-Source: AGHT+IHPPpup4V/mLQq4Qqdp6P3+7XVPglvKEYYqrFstcsb6l5CDUqni/FbbpGQZyx7f63KPXdoOtY1nJqVz3scmqRU=
X-Received: by 2002:a17:907:72cb:b0:b07:c5b1:b129 with SMTP id
 a640c23a62f3a-b30263b9618mr314935266b.1.1758654619261; Tue, 23 Sep 2025
 12:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175865066509.3489281.5792211607743744274.reportbug@ruoska> <aNLr-GKpufof8HME@eldamar.lan>
In-Reply-To: <aNLr-GKpufof8HME@eldamar.lan>
From: james young <pronoiac@gmail.com>
Date: Tue, 23 Sep 2025 14:10:06 -0500
X-Gm-Features: AS18NWCdvJnuW2Ht6BCK71x7n6qRIzTnmHAlHDT6VdiEXdVFz9w43nfVE-xVQM0
Message-ID: <CABaPp_jAFwsobgdk38Qhigqn+Tgb1UQK9RDJF3sCFT1_KH3SQg@mail.gmail.com>
Subject: Re: Bug#1116067: linux-image-6.1.0-32-amd64: btrfs compression
 quietly stopped around 60TB in
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: 1116067@bugs.debian.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I hit an issue with btrfs compression; I reported it to Debian, which
I was using, and they suggested that I take it upstream.

Thanks, Salvatore. My apologies to everyone if I misunderstood.

-James

On Tue, Sep 23, 2025 at 1:50=E2=80=AFPM Salvatore Bonaccorso <carnil@debian=
.org> wrote:
>
> Control: tags -1 + moreinfo
>
> Hi James,
>
> On Tue, Sep 23, 2025 at 08:04:25PM +0200, James Young wrote:
> > Package: src:linux
> > Version: 6.1.129-1
> > Severity: normal
> > X-Debbugs-Cc: pronoiac@gmail.com
> >
> > Dear Maintainer,
> >
> >
> > * What led up to the situation?
> > We made empty files in a loop, in parallel, under CPU and I/O load.
> > We had an outer Btrfs image file with compression, which contained a Bt=
rfs image file, which contained billions of empty files.
> > We wrote around 100TB to the inner image file.
> > Around 60TB in, compression quietly shut off.
> > We ran out of space; both mounts presented i/o errors.
> >
> > * What exactly did you do (or not do) that was effective (or ineffectiv=
e)?
> >   * I unmounted the inner and outer images.
> >   I didn't take note of memory usage before this point.
> >   * dump debug info for the outer image - `btrfs inspect-internal dump-=
tree --dfs ...`
> >   * We started a btrfsck. (twice, actually; breadth-first hit memory li=
mits, I think)
> > After that, I learned about `btrfs check`, but didn't interrupt the btr=
fsck, due to Sunk Cost Fallacy.
> > The btrfsck is still running. It's of extremely dubious value now.
> > * check the kernel logs
> >   * I grepped for btrfs, the mount points, compress, and zstd. I didn=
=E2=80=99t find a smoking gun in the right timeframe.
> >
> > not done yet:
> > * mount the outer image
> > * rebooted
> > * tried a newer kernel. we're currently on kernel 6.1.129; we could go =
to newer 6.1 or 6.12 kernels
> > * redo live file system compression, with e.g. `btrfs filesystem defrag=
 -czstd`
> > * fstrim the outer image
> >
> > goals:
> > * work out what happened.
> > How can we help?
> > * help avoid it happening again, to others
> > * salvage what we can
> >
> > I've run `bugreport` as a non-privileged user. Let me know if root acce=
ss would give a fuller picture.
>
> I believe the best thing you could do here is to contact actually
> upstream people directly. get_maintainers and the MAINTAINERS file
> has:
>
> BTRFS FILE SYSTEM
> M:      Chris Mason <clm@fb.com>
> M:      Josef Bacik <josef@toxicpanda.com>
> M:      David Sterba <dsterba@suse.com>
> L:      linux-btrfs@vger.kernel.org
> S:      Maintained
> W:      https://btrfs.readthedocs.io
> Q:      https://patchwork.kernel.org/project/linux-btrfs/list/
> C:      irc://irc.libera.chat/btrfs
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
> F:      Documentation/filesystems/btrfs.rst
> F:      fs/btrfs/
> F:      include/linux/btrfs*
> F:      include/trace/events/btrfs.h
> F:      include/uapi/linux/btrfs*
>
> So I would suggest you to contact above maintainers including the
> list.
>
> Please keep this downstream bugreport as well in the recipients list.
>
> Regards,
> Salvatore

