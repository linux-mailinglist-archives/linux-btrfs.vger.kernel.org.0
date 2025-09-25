Return-Path: <linux-btrfs+bounces-17192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F94BA0F6C
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 19:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DCA6C165E
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593F7311958;
	Thu, 25 Sep 2025 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxL7yqsX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75DB1DE3DC
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758823056; cv=none; b=dK7UhwNemd4q67rxqDMpa9THvTczMLjtONKHyhKpkXpOyztNubK+s+DsZvT4ZvCkbhHpbSRk0kOv2N7l6YzmwXQkBPIhWlkR2FhaSNoCpJdgFYHqZU81jxisq0jjFIG+akHloSM37Qidd/p6jJF3USeIEFzO6Fwn8bO46IQkg8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758823056; c=relaxed/simple;
	bh=KlzamQCfp/OKtASOaOr12bx6pwi+NuoEl+xWFZjoUj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQgWNFnqqTWSmbKhxPppAOxMcX47/CC8eS76jey1fnBGpwniO5ZJHOWM7hgP3RQQfqIFKscgmEwRmsUOB7Vj2VVqEOw4PiQNdQiSoKDG7x3CUP3cYGbXv4mZ6h2H/kojZzt4tw4ShByErjhNj5hxlUho1udZ3wmSHaxUpZDlH8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxL7yqsX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd630so2103279a12.2
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 10:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758823053; x=1759427853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbImI0rstVeW8pQTFF3C2kK+F8/qNVAGsjH2Uc21lGo=;
        b=KxL7yqsXrZwQfJ7IX7flyybZbUmT9hR36WrX4N7ZF2aE8aROd+JjQCzNmyWTDCzPoj
         CKBOP5kGhB1/f7yemsQpyvN07ChLJbVq8WHtPtydV1XyR3CkTMxlfQW9GOSD1uO2pOJ0
         YETz1N95MckWM6Pr9Yy8ghwcAoj+1ATCS8fE+JiMgq4ine+T9CZbiQLI2lZU7xupyLm/
         GHJoRL+nf/hSDgKnj+47QIKFvTMuweH5qv+uFhSkDk9AmtQxEUnyOyBUtn5aHwGfwEvt
         9Lm2adWomm7cLV1X2L+6iifhKt5Y6X3NA72ObXBe/0uX4RFTXMvF2IjEfRQsPA47K3xa
         FtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758823053; x=1759427853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbImI0rstVeW8pQTFF3C2kK+F8/qNVAGsjH2Uc21lGo=;
        b=gq2MTqcW88zTpqaHm7avDW2a1nle6fGlaPeTn2NSar1+E8pIVQVAY02CZMnfJCkCXp
         94/PXa7AMmVwMJLuM+HVtNGSY8VOAeUvlT+by2k/HoViQqXtq9c2/QDQzI73C8SEb2MA
         vulEXFVwQj/WBOM0Q1dNBZqITMO5o4+CzSKCqx/xgrO3iT0xQ16pv8D0Bgr0pUeSqEKu
         LhL5NWHJnEWsPSbelwyIAQqcrVfs1xO51enjpEm+AutoVAy5/JQqwjShmMAEicVnZEvj
         H0MD7WF5W9PkU3M43IFqJcJW7LSMcXeHYPcDtg5hw2R2SUuG1iohAb1+irwFayuRrKZt
         XEwg==
X-Forwarded-Encrypted: i=1; AJvYcCXQGEn44XBkliHllpZhxSXC02c01avMmhFqzSNPVds7yNtVOom9fvuSlnEb3LuEx8A/UOFkqceswtZ2Tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoGE1g1kgKo7Rj8P3AINZQxvvGOMYKI2fHehdiNGGd8Y2p97gr
	S/ciy3leNFn9kiYUe4nJkg12jvGb3KuhVkxLfcqP9WCskPGGUKb/c0HU7URxt6YD/1M1eVvcyFL
	2KceQs2yxaTD/79E8hW+t6aJ6JoznBI8=
X-Gm-Gg: ASbGncvdUyGICQByBpL63T06gqvggWLs9pypSm8mAtdBTKCO9DTMBotGoQuVX+LsNaF
	39JFjoZVRPB7gpzFex9pDyfdzmLirDYbfaUQdLV/jRgEhq+2HhXPgqKqXEFbs9UwCPTcFsKNpDK
	Vd5eRkn0stgjTv1rXiDq/pLLijp2ZvhFv2ZBWiDC8SPD67yYootCXxjxiC4HlYKykj+v4nwzaga
	ObDH6xeQzIduC+voJGFq4UTwyNDgfuPAUknBwA2hKFjAME=
X-Google-Smtp-Source: AGHT+IHRGojf8RQkGcVVmovOKEpo3ITE/7LbMFnP6znLVAxUAFezqCnw5YBPmPu915rzPs1352xQeusWFuVQUkAKKwY=
X-Received: by 2002:a17:907:3e04:b0:b33:b8bc:d1da with SMTP id
 a640c23a62f3a-b34b79c68dcmr471954166b.1.1758823053036; Thu, 25 Sep 2025
 10:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175865066509.3489281.5792211607743744274.reportbug@ruoska>
 <aNLr-GKpufof8HME@eldamar.lan> <CABaPp_jAFwsobgdk38Qhigqn+Tgb1UQK9RDJF3sCFT1_KH3SQg@mail.gmail.com>
In-Reply-To: <CABaPp_jAFwsobgdk38Qhigqn+Tgb1UQK9RDJF3sCFT1_KH3SQg@mail.gmail.com>
From: james young <pronoiac@gmail.com>
Date: Thu, 25 Sep 2025 12:57:20 -0500
X-Gm-Features: AS18NWD-t3rBhBgfJmP_juwd3yEnMnsoZsqE__iw48r77CJtGPTZW0UmiLVdVSg
Message-ID: <CABaPp_j21HxgXFT5JZkKW1QeZmAtxYPAgWKo-nm15mWMvj-7BA@mail.gmail.com>
Subject: Re: Bug#1116067: linux-image-6.1.0-32-amd64: btrfs compression
 quietly stopped around 60TB in
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: 1116067@bugs.debian.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm not sure what timeline to expect for a response.
Would a tarball of the outer image preserve everything needed for diagnosti=
cs?

-James

On Tue, Sep 23, 2025 at 2:10=E2=80=AFPM james young <pronoiac@gmail.com> wr=
ote:
>
> I hit an issue with btrfs compression; I reported it to Debian, which
> I was using, and they suggested that I take it upstream.
>
> Thanks, Salvatore. My apologies to everyone if I misunderstood.
>
> -James
>
> On Tue, Sep 23, 2025 at 1:50=E2=80=AFPM Salvatore Bonaccorso <carnil@debi=
an.org> wrote:
> >
> > Control: tags -1 + moreinfo
> >
> > Hi James,
> >
> > On Tue, Sep 23, 2025 at 08:04:25PM +0200, James Young wrote:
> > > Package: src:linux
> > > Version: 6.1.129-1
> > > Severity: normal
> > > X-Debbugs-Cc: pronoiac@gmail.com
> > >
> > > Dear Maintainer,
> > >
> > >
> > > * What led up to the situation?
> > > We made empty files in a loop, in parallel, under CPU and I/O load.
> > > We had an outer Btrfs image file with compression, which contained a =
Btrfs image file, which contained billions of empty files.
> > > We wrote around 100TB to the inner image file.
> > > Around 60TB in, compression quietly shut off.
> > > We ran out of space; both mounts presented i/o errors.
> > >
> > > * What exactly did you do (or not do) that was effective (or ineffect=
ive)?
> > >   * I unmounted the inner and outer images.
> > >   I didn't take note of memory usage before this point.
> > >   * dump debug info for the outer image - `btrfs inspect-internal dum=
p-tree --dfs ...`
> > >   * We started a btrfsck. (twice, actually; breadth-first hit memory =
limits, I think)
> > > After that, I learned about `btrfs check`, but didn't interrupt the b=
trfsck, due to Sunk Cost Fallacy.
> > > The btrfsck is still running. It's of extremely dubious value now.
> > > * check the kernel logs
> > >   * I grepped for btrfs, the mount points, compress, and zstd. I didn=
=E2=80=99t find a smoking gun in the right timeframe.
> > >
> > > not done yet:
> > > * mount the outer image
> > > * rebooted
> > > * tried a newer kernel. we're currently on kernel 6.1.129; we could g=
o to newer 6.1 or 6.12 kernels
> > > * redo live file system compression, with e.g. `btrfs filesystem defr=
ag -czstd`
> > > * fstrim the outer image
> > >
> > > goals:
> > > * work out what happened.
> > > How can we help?
> > > * help avoid it happening again, to others
> > > * salvage what we can
> > >
> > > I've run `bugreport` as a non-privileged user. Let me know if root ac=
cess would give a fuller picture.
> >
> > I believe the best thing you could do here is to contact actually
> > upstream people directly. get_maintainers and the MAINTAINERS file
> > has:
> >
> > BTRFS FILE SYSTEM
> > M:      Chris Mason <clm@fb.com>
> > M:      Josef Bacik <josef@toxicpanda.com>
> > M:      David Sterba <dsterba@suse.com>
> > L:      linux-btrfs@vger.kernel.org
> > S:      Maintained
> > W:      https://btrfs.readthedocs.io
> > Q:      https://patchwork.kernel.org/project/linux-btrfs/list/
> > C:      irc://irc.libera.chat/btrfs
> > T:      git git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.g=
it
> > F:      Documentation/filesystems/btrfs.rst
> > F:      fs/btrfs/
> > F:      include/linux/btrfs*
> > F:      include/trace/events/btrfs.h
> > F:      include/uapi/linux/btrfs*
> >
> > So I would suggest you to contact above maintainers including the
> > list.
> >
> > Please keep this downstream bugreport as well in the recipients list.
> >
> > Regards,
> > Salvatore

