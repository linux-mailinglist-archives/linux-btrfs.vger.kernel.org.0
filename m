Return-Path: <linux-btrfs+bounces-11949-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6F1A49ED7
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 17:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB4B3A6580
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 16:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D80326A0DB;
	Fri, 28 Feb 2025 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDWsjS3J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCE433E7
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760322; cv=none; b=JXskhtXkcUQZol+sPUTEO+b1yWzvPvP6pD1U0OHnKv9QPPs/Nw4n+1ckoQCYv1L/FaihgtzHOJrV1ZX4OSGCDKM+GZSkPvfxztOYpMaXei61aOQfWpDNr3F0mHsTUzPX677e/JSZhn2JukFmcLQPMC0o1VIxwHv7MQM3OTt1gaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760322; c=relaxed/simple;
	bh=83psnPfK7QK+IeUITFjEyOjxlpHZwWnZFncXU+/AzfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2vJAPj7+b2RFFJv0yWRMSpQVqN3/zAYZ94PPu8p1sTsWlnH0/WaxljrSpVA6TZBaV5dekBebk+2kV3LophKEaPWZVnH+vFDCa3ZQC9mOBEoDKQ0QgmBhouLFhpDuGQmbmF63WRceLNsdDE6kPRDQMvpr9VPacyeipTq/iUs0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDWsjS3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E45C4CED6
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 16:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740760322;
	bh=83psnPfK7QK+IeUITFjEyOjxlpHZwWnZFncXU+/AzfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gDWsjS3JN9z9P72z3lEKDHtF2+92hutD6D0+gJ0GEF5fGgZkl2BVPes9q2Bsm/ZN6
	 UrJu04a5HYRPN70jcYbshbt5ckbJbVUlFNRljtbFPbvAt8/WpPcDGoqniHcQrTgpkc
	 PvvKV8kyGQGGJOB/dXmCt5EdxvvYsjkSrkRGsX1fTB0s6MVCeoW1k+6Je/ZfomnP/I
	 vpq3o3JJZyKz9r4+Y9lstx4sHYOzOZe+2txgb39OHgz2kDaZLO22h8EPh2Pkw7+5fq
	 XvnpJdvKOaEGFPjfQdvLTfiBZ3bLUww7tGqzWEGUC7E4zBkwNOKHOMt4qdDUoZjaEX
	 TaGsXFulBGamw==
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso24877185e9.2
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 08:32:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpC3egz6D/E8jaJPCUxfmKqKIEBbMgMYP1Ml/RhV2/muuT91ZhXeHuhXgVT4TdU4eT8VXscSKm52oYtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6MxOxoicua1hPQ0kIbW5emBNLhT2I4ryn2mHqZJEolXYUbx6k
	Z02/yoma7Rf8E1CJ6ThwqmaGIl1KSngqwL0ceRHN5qn7v/4evFNLWljcg6LxQjJpKUsd7gh1ANN
	DHbllXjIoalJ3dR4cYVlo0huvMTo=
X-Google-Smtp-Source: AGHT+IGsAMNgV9rvlf/8ftN4UuiW0eaVE/zQM/wiO7dd8N/O0ob3wsZaV9le2WIZuexRCDYKeIBLer1zMeoy+qwYjJY=
X-Received: by 2002:a5d:60c2:0:b0:38f:3245:21fc with SMTP id
 ffacd0b85a97d-390eca257e4mr3603430f8f.50.1740760320774; Fri, 28 Feb 2025
 08:32:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <30FD234D-58FC-4F3C-A947-47A5B6972C01@suse.com> <db20af73-0b5d-4327-9393-929173d4f91d@gmx.com>
In-Reply-To: <db20af73-0b5d-4327-9393-929173d4f91d@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 28 Feb 2025 16:31:23 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6hRoFn=Cg7qggTY_-p4JBG=+AGfX8azd8Vu+gsVQJD-A@mail.gmail.com>
X-Gm-Features: AQ5f1JoPk5ag0oj8DdB5S2lwWwIlmI2GGq8hL0gYBfrBu0wePHYq5um781kTh1I
Message-ID: <CAL3q7H6hRoFn=Cg7qggTY_-p4JBG=+AGfX8azd8Vu+gsVQJD-A@mail.gmail.com>
Subject: Re: [BUG report] fstests/btrfs/080 fails
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Glass Su <glass.su@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 5:27=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/2/14 15:41, Glass Su =E5=86=99=E9=81=93:
> >
> > Hi
> >
> > Recently I found btrfs/080 fails like:
> >
> > btrfs/080 124s ... [failed, exit status 1]- output mismatch (see /root/=
xfstests-dev/results//btrfs/080.out.bad)
> >      --- tests/btrfs/080.out     2024-08-29 09:10:14.933333334 +0800
> >      +++ /root/xfstests-dev/results//btrfs/080.out.bad   2025-02-14 12:=
53:24.667572260 +0800
> >      @@ -1,2 +1,3 @@
> >       QA output created by 080
> >      -Silence is golden
> >      +Unexpected digest for file /mnt/scratch/12_52_59_984815662_snap/f=
oobar_39
> >      +(see /root/xfstests-dev/results//btrfs/080.full for details)
> >      ...
> >      (Run 'diff -u /root/xfstests-dev/tests/btrfs/080.out /root/xfstest=
s-dev/results//btrfs/080.out.bad'  to see the entire diff)
> > Ran: btrfs/080
> > Failures: btrfs/080
> > Failed 1 of 1 tests
> >
> > It can be reproduced once in about 20 times on v6.13, misc-next(HEAD: 1=
c08f86eeadab89e8f6ad8559df54633afb7a3ba)
> > in my VM with 32 cores.
> >
> > Configs and log are attached.
>
> I checked your kernel config, it looks like it has a config that is
> known to cause problems:
>
> - CONFIG_PT_RECLAIM=3Dy
>
> I'm unable to reproduce the bug locally, with 64 runs.
> But that's with CONFIG_PT_RECLAIM=3Dn, as I use that config to workaround
> the bug.
>
> Mind to test with either that config disabled, or apply this hotfix and
> retry?
>
> https://lore.kernel.org/linux-mm/20250211072625.89188-1-zhengqi.arch@byte=
dance.com/

Nop, that's totally unrelated.

I've been getting the failure too, very sporadically, even before
for-next was based on 6.14-rc1/2.
The problem is due to a behaviour that changed in the buffered write
path (you did that change).

I've just sent an update to the test to make it work on 6.13+:

https://lore.kernel.org/linux-btrfs/d48dd538e99048e73973c6b32a75a6ff340e8c4=
7.1740759907.git.fdmanana@suse.com/

Thanks.

>
> Thanks,
> Qu
> >
> >
> > =E2=80=94
> > Su
> >
> >
> >
> >
>
>

