Return-Path: <linux-btrfs+bounces-19216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9905EC7447B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 14:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC1184F5367
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 13:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B7C33C1B7;
	Thu, 20 Nov 2025 13:24:20 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38353334C09
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645057; cv=none; b=quPJCW9+gFn4o3HlFyEVSL4LGUeBpyepq7+BFxCD5IUU+TtVPxcnmZaSgI5kapKCFWoLA4pyfXZWDEynmS+Dx1wl7SSx2ONPrnvKkEt+i0ct8Iwt7h+Q2B9u39gj3cmsvBo4ZgSUP6eaTiZRymG1mDtqDBfcyQ84/s9zZfssrTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645057; c=relaxed/simple;
	bh=KK423ztZbJGGHufWFDeuvdojniSvs5sMBQcpmxSUwPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USRzjZo+qfQ6sheneMCrJ/R6cmOyCZfvBi5VqhXCuFoNZ7Yqv8CHH1qmZWOzBVvNL2ceKYY8XtG7Su6Bez8gy7hUxgnGYZzMHRoTi9uY+dHbj/C/yxFr3Th6GsttxI+f3rY1nZYb/KqRxcClEt+oyfIDMc+hgcSfZYqLqt04tDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c6d13986f8so651683a34.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 05:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763645052; x=1764249852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KK423ztZbJGGHufWFDeuvdojniSvs5sMBQcpmxSUwPo=;
        b=cFh0OgkNUwgQDBkIOdOt8rA5yqx4BaYRoVBvY4oKWMsV3xbMnCvbndZL7NvW4FV5sB
         tewkWv/7/JD2FtxftxrA7wDfeo483NKL9fvlQ2YEjQiSA9ywu7x7ixajZ8RPm03nhHkO
         YvsM7fR2cYXgpogxhCVG4lm/lOIAUNgS7otizaywMt6cxIF6/7D4Dr2X0jZoZ7jKNh+O
         ozFkb/Ac8wgMPd7wzzCvShhPYqlT8qT8e1DGUviw7gIDa0y00i5MoJFQjMijr5aQPula
         xFYNd/zWfCw3vhNk12SwL1udDU1ZgByYmcTkBjaqDVg0yzSfe0z3a/AXlDaLLeyUU8mv
         ZTLg==
X-Forwarded-Encrypted: i=1; AJvYcCUoK1DDQk/32BQ7oQWqaUwyfoEoR/7xbzbWfUW+ckK8gabeF4Tq/zFxDWmZBLl4Jn7ksqzmX1CdL62OQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YymxfZq10ERzdUTwn226hZssiD3/nsoksRmWLrObqmRGRz6f6rq
	nRiByqKm7j/Pz30HqGb52MGQK/1Vy6R0PDgWWcgs5IL5ve6mmo7xXVF+GvGi1g==
X-Gm-Gg: ASbGnctcVzUhqg36FCSS5MLgNAiKqvrlWhUebr70zH7uNGxh+tureytOf5MpMYfJksB
	JcrxUOAFgKTON/Mzy3c7cL2NFH6fGJF9c2BLJf4bCxDuXBIQyVBqH0lihTEGUOJtH3IqDIsrY+4
	2ZIjLHvplabHNx5GCJOIhsFma4bCYN0YL5CSIzL+011W4HTIg4fUIQwFtCxnAnH1gxSAF8qSQfR
	0kwyo/51D2yqkNopYQ5P5By8Bc75ln+YEK3Hm9I8zyc13EbrWcp/hWp2uY5+wEz9MAKIKQQa5Iv
	zQZgnFq1RPIcTPYsL7nZjA6ZCfv8dqLnxTQdlkwHH088W9IWtlsgpikDlvUozKwG2ggBtfyTiYg
	sEVkSxMsmnFlWazTxhO4oOJ+s9xhLjVH5OQEyJuuV2zmwP3DjEQhusAg7b3fUiB39mBZ6lY3psh
	/S1TgVXH6xBl4uKom1U9za62t5CUOq+zAvLHY+NBJU/5vnxq60pXoJBHG7SXGieF9E1Ggprvm6
X-Google-Smtp-Source: AGHT+IG9iOtdo8pSuMRLYavof3uEbDWdKZGixFrp4vHK2UAjMTdy4JRaZhN69rzATb3ZnkQ/Oo7i/g==
X-Received: by 2002:a05:6830:82c9:b0:7c7:e3b:4860 with SMTP id 46e09a7af769-7c78eab4c91mr1286736a34.10.1763645052003;
        Thu, 20 Nov 2025 05:24:12 -0800 (PST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d32c580sm977708a34.8.2025.11.20.05.24.11
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 05:24:11 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c77fc7c11bso634406a34.1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 05:24:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVb4Ybrr1VWicaWE7w3UXgb8/PD/XFl6ytk0z0ia6bu99Tf2A1weEehY6FSYFZ/Kpl4ydC/tM/QVO/f5w==@vger.kernel.org
X-Received: by 2002:a05:6830:10d4:b0:7c7:6ae0:5565 with SMTP id
 46e09a7af769-7c78ea78decmr1165731a34.1.1763645051528; Thu, 20 Nov 2025
 05:24:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763361991.git.wqu@suse.com> <20251118151533.GX13846@twin.jikos.cz>
 <d381f2e2-ee08-4055-b91e-e1e0362d18d6@gmx.com> <20251119081336.GB13846@twin.jikos.cz>
In-Reply-To: <20251119081336.GB13846@twin.jikos.cz>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 20 Nov 2025 08:23:34 -0500
X-Gmail-Original-Message-ID: <CAEg-Je82LZjjW1CdiEoXtrB9mCdDtxEB9Bd9fhM5J0xCazJ7hQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmdn-xOqfotwc52B5rvzoq-eammw4c8DtAZD30SclqV-XYXWjSPL1dSWcQ
Message-ID: <CAEg-Je82LZjjW1CdiEoXtrB9mCdDtxEB9Bd9fhM5J0xCazJ7hQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] btrfs: add raid56 support for bs > ps cases
To: dsterba@suse.cz
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	"Justin M. Forbes" <jforbes@fedoraproject.org>, Michel Lind <michel@michel-slm.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 3:13=E2=80=AFAM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Wed, Nov 19, 2025 at 07:40:50AM +1030, Qu Wenruo wrote:
> > =E5=9C=A8 2025/11/19 01:45, David Sterba =E5=86=99=E9=81=93:
> > [...]
> > >>
> > >> The long term plan is to test bs=3D4k ps=3D4k, bs=3D4k ps=3D64k, bs=
=3D8k ps=3D4k
> > >> cases only.
> > >
> > > Yes the number of combinations increases, I'd recommend to test those
> > > that make sense. The idea is to match what could on one side exist as=
 a
> > > native combination and could be used on another host where it would h=
ave
> > > to be emulated by the bs>ps code. E.g. 16K page and sectorsize on ARM
> > > and then used on x86_64. The other size to consider is 64K, e.g. on
> > > powerpc.
> > >
> > > In your list the bs=3D8K and ps=3D4K exercises the code but the only =
harware
> > > taht may still be in use (I know of) and has 8K pages is SPARC. I'd
> > > rather pick numbers that still have some contemporary hardware releva=
nce.
> >
> > The bs > ps support has a hidden problem, a much higher chance of memor=
y
> > allocation failure for page cache, thus can lead to false alerts.
> >
> > E.g. ps =3D 4k bs =3D 64k, the order is 4, beyond the costly order 3, t=
hus
> > it can fail without retry.
> >
> > Maybe that can help us exposing more bugs, but for now I'm sticking to
> > the safest tests without extra -ENOMEM possibilities.
>
> I see, this could make the testing pointless.
>
> > It can be expanded to 16K (order 2) and be more realistic though.
>
> Yes 16K sounds as a good compromise.
>

Yes, and it can be immediately useful with Fedora systems since there
have been historical 16k btrfs volumes created on Fedora Asahi Remix
by users before the 4k bs default was implemented.

> > Although bs > ps support will be utilized for possible RAIDZ like
> > profiles to solve RAID56 write-holes problems, in that case bs > ps
> > support may see more widely usage, and we may get more adventurous user=
s
> > to help testing.
>
> In such case we'd have to increase the reliability of allocations by
> some sort of caching or emergency pool for the requests. The memory
> management people maybe have some generic solution as the large folios
> usage is on the rise and I don't think the allocation problems are left
> to everybody as a problem to solve.
>

If we need some testing for RAID modes, it might be possible to
organize something on the Fedora side through the Fedora Btrfs SIG[1].

[1]: https://fedoraproject.org/wiki/SIGs/Btrfs


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

