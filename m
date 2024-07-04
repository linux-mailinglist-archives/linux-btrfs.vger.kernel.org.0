Return-Path: <linux-btrfs+bounces-6202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E0B927B43
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 18:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7158F281217
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 16:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06AE1B3746;
	Thu,  4 Jul 2024 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gq4+JFU9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156061B0138;
	Thu,  4 Jul 2024 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111150; cv=none; b=YdoWbSSBBNCjGn9g0FNmqigUEQidO2vuEhXOI4ZJFnWWxa+PVx56wmpC+8UJHBH7SmBcbR/48D2OhHt7hSP/9WKRETI4nBimYz3q2qlPeMufFsdEsOxfrD5W8TVU0Z2akWEY2a5WT+pWWF5Sg42LBu1YyXofN6hGF1lZQ86ap3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111150; c=relaxed/simple;
	bh=gRd4H9HAoXj9VT9zFnuZwGS9i7FBkfx85UHjFSlbhJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+nifBaxhOGEnSuGPQ77vSJFxTHArXJF0d2m2q+9Cs5dWUV9xduIMjwuTgX6tasNmfHpeMBn05DGpLTrQTQTbVnztUSctiHqdaHo1iXqnX0wsoCizIrHJHqkQKpx/rP3u2TG2PFs45vfC6VrRGLQoU6boAGJ6/9Fzp24kZTSfLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gq4+JFU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1EAC32781;
	Thu,  4 Jul 2024 16:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720111149;
	bh=gRd4H9HAoXj9VT9zFnuZwGS9i7FBkfx85UHjFSlbhJg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gq4+JFU9Sr+KM1guFQ2TBMv3IwWpLOiOpkfyTZk1N+J+739UlBedXKjFxrAyVJ8/p
	 /lo5+zZ4u3Af3KHCohdb6PgbWj8iRBW9sorQy/U33rOmehzaIZOYpv/qMmJoloiU5G
	 TixTww2wWiyv030+bQ5tWIb4EHfNB3akgp0MwnaHiYQJ0LXdyyX7o4OEdNZf23Ky2l
	 f3d82KjlZHj/IFmo/qNr8fyDJu2OJChKajBf87rtWGyWnRZBULAgPIlYe+8HD+qhZ1
	 plKqF/2Hh0SeA4n14yAP/0HgML3nsiub1LJXHRkRgoZxXja2PwtwAc2rVjS9Sz+kY4
	 1inAB4kWMIrOw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a728f74c23dso100384166b.1;
        Thu, 04 Jul 2024 09:39:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVldxnWxk9nv4yndLjEW9OjKH+QGnuW0DbVSKLqgG19mlZ7PlxpsvsISBcPLrpT2hAo5R2lzMhXLpeNXdAsNajqlHyeePT+yqPR5mOFi/xmMYPYJmddMf7anZ2u6s+Vx4sZf/Eo05ekyiQ=
X-Gm-Message-State: AOJu0YzeBqH0Eu7C+WhTDxCibxbOuPFOhcqFzTVp4sbA+oJQEJsYcI8C
	+mwlFNpfTap+nYrdfHmJsXm9y7evORIOZOIq9hvKnza8nW3DmfTYmZ5SDGm/lXpxMtEaEeUOgOG
	dEULr69dOuNcqIwILQSXDitx/Eqg=
X-Google-Smtp-Source: AGHT+IFoSHc48vw315GWCxZCeNwg7EaRGveE0Zaf/jsFIyoF0QggQomlhorwuzycIttmq4Bt17saZFGYhQtMdoFfmiA=
X-Received: by 2002:a17:907:684:b0:a77:c3b5:9e5d with SMTP id
 a640c23a62f3a-a77c3b59f8cmr69408066b.47.1720111148322; Thu, 04 Jul 2024
 09:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
 <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
 <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com>
 <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com>
 <CABXGCsP9tSwgR4dN-k97maqHB1KOtykakmHNz78SYbAuHydUTQ@mail.gmail.com>
 <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com>
 <CAL3q7H5RC6dinsA2KLtus07jxDuY1PecPXbhYOWtW+nVyzXwuA@mail.gmail.com>
 <CAL3q7H4MiarsqxSMc0OzY2TNRk8J7Lg+89MaPHY2+NPO-EcDgQ@mail.gmail.com>
 <CAK-xaQYYx6SPQaOVwL+ardB0y5LzYJw9a_hfWWtVEZ=y1rXq5w@mail.gmail.com>
 <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com> <CAK-xaQagqS0kePozkim7sB_Zi+8NrDRnbqFuLVQ3s4F+0WZ+DQ@mail.gmail.com>
In-Reply-To: <CAK-xaQagqS0kePozkim7sB_Zi+8NrDRnbqFuLVQ3s4F+0WZ+DQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 4 Jul 2024 17:38:31 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5AFbSy0JC=u_MAfNR-J_kFQkaG6_pXJimD80tchFXytg@mail.gmail.com>
Message-ID: <CAL3q7H5AFbSy0JC=u_MAfNR-J_kFQkaG6_pXJimD80tchFXytg@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 12:19=E2=80=AFPM Andrea Gelmini <andrea.gelmini@gmai=
l.com> wrote:
>
> Il giorno gio 4 lug 2024 alle ore 11:49 Filipe Manana
> <fdmanana@kernel.org> ha scritto:
> > I'll try that soon and see if I can reproduce.
>
> I'm creating a qcow installation with everything, to replicate this.
> Sorry, it takes time.
>
> By the way, it's just me? (latest git master btrfs-progs)
>  btrfs-image /dev/blah-blah loop.dd
> works perfectly, but
>   btrfs-image -s  /dev/blah-blah loop.dd
> generate an image impossible to mount:
> [gio lug  4 11:20:05 2024] BTRFS info (device loop40): first mount of
> filesystem 496b800d-2f32-46bb-b8d0-03d6f71cf4b2
> [gio lug  4 11:20:05 2024] BTRFS info (device loop40): using crc32c
> (crc32c-intel) checksum algorithm
> [gio lug  4 11:20:05 2024] BTRFS info (device loop40): using free space t=
ree
> [gio lug  4 11:20:05 2024] BTRFS critical (device loop40): corrupt
> leaf: root=3D1 block=3D40297906176 slot=3D6 ino=3D6, name hash mismatch w=
ith
> key,

Sorry I have no idea about that. I don't use btrfs-image myself and I
don't think I even ever looked at its source code.
CC'ing Qu who might be interested in that.

I'll reply very soon to the emails about the performance issues that
correlated to related to the shrinker, there are some interesting
things to look for.

Thanks.


> have 0x00000000365ce506 expect 0x000000008dbfc2d2
> [gio lug  4 11:20:05 2024] BTRFS error (device loop40): read time tree
> block corruption detected on logical 40297906176 mirror 1
> [gio lug  4 11:20:05 2024] BTRFS critical (device loop40): corrupt
> leaf: root=3D1 block=3D40297906176 slot=3D6 ino=3D6, name hash mismatch w=
ith
> key,
> have 0x00000000365ce506 expect 0x000000008dbfc2d2
> [gio lug  4 11:20:05 2024] BTRFS error (device loop40): read time tree
> block corruption detected on logical 40297906176 mirror 2
> [gio lug  4 11:20:05 2024] BTRFS warning (device loop40): couldn't
> read tree root
> [gio lug  4 11:20:05 2024] BTRFS error (device loop40): open_ctree failed
>
> > In the meanwhile, just curious: are you using swapfiles on btrfs?
>
> never used on BTRFS (i have a dedicated nvme partition).
>
> Same effect also disabling the swap, btw, and thp.

