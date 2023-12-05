Return-Path: <linux-btrfs+bounces-656-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E14A2805B10
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 18:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF851C210D8
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7DB65ECD;
	Tue,  5 Dec 2023 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNGRQ1ct"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79BA692AA;
	Tue,  5 Dec 2023 17:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47784C433C8;
	Tue,  5 Dec 2023 17:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701796969;
	bh=NMzTQRuPiGxyO0LEiONQEibZ4TNumjQFzz1t3DoNINo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aNGRQ1ctogncQcAEosSNgFS1gcDf7E5PXYZPq1ZDqs3GqReBwHfuYx/OtQ0rWj4st
	 FNikbOfEoYDk09jx7e1BRDBHs5OTh2A+pH5o3zHoBbdAyV4I437RBSQmLpvy4TS0I1
	 6HrrMQZR/KNEO8La+AuRT3Bg0+7bvdkRfAx59kfgjOQ40u3bghges503hsD80sb43S
	 TTtPyLO21VQBLg32jwvsJ5kOYzMygNCxk9BpHy3HJGd6wxq7I2HITJlNxj+lO7SZEo
	 wAjp6aOpqtdqRr/Ye1zOdPw9bhJSIb34sbn3xSiEX4ErbHcdy6dy5r43jPxSt9Q0CC
	 +nvCN53ICdE/w==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a00f67f120aso778199166b.2;
        Tue, 05 Dec 2023 09:22:49 -0800 (PST)
X-Gm-Message-State: AOJu0YwnsIU1G9VhKal8egGLVszl9q6cRz/thHBJycSNma9+aR+5IoCG
	hQBkKaWyhVjOoGURyiPBBXT1d6FjkZvD7LcZwX0=
X-Google-Smtp-Source: AGHT+IF31aQpSsxh1N3xQWdQJW6huIxwTBjk9DAYEd4uV1jFLbYpVckAcb/VxvABcL4EQuVHXVHOlOnoUbNI5ZhxOX8=
X-Received: by 2002:a17:906:116:b0:a1d:5c1:db6b with SMTP id
 22-20020a170906011600b00a1d05c1db6bmr421500eje.8.1701796967724; Tue, 05 Dec
 2023 09:22:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205-btrfs-raid-v2-0-25f80eea345b@wdc.com>
 <20231205-btrfs-raid-v2-3-25f80eea345b@wdc.com> <CAL3q7H62=-Y9KZeLQeVAAy8Q2STDdTsUEJLC9BrEFsVyTJON6A@mail.gmail.com>
 <dc1aeaf6-ec9d-4035-b61d-7b1d38189830@wdc.com>
In-Reply-To: <dc1aeaf6-ec9d-4035-b61d-7b1d38189830@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 5 Dec 2023 17:22:11 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4TqofDBfe+KUE_FRH55D5A3ra-b-3d4aQm5r2B=aFA4Q@mail.gmail.com>
Message-ID: <CAL3q7H4TqofDBfe+KUE_FRH55D5A3ra-b-3d4aQm5r2B=aFA4Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] btrfs: add fstest for stripe-tree metadata with 4k write
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>, 
	Filipe Manana <fdmanana@suse.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 5:19=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 05.12.23 18:12, Filipe Manana wrote:
> > On Tue, Dec 5, 2023 at 12:45=E2=80=AFPM Johannes Thumshirn
> > <johannes.thumshirn@wdc.com> wrote:
> >>
> >> Test a simple 4k write on all RAID profiles currently supported with t=
he
> >> raid-stripe-tree.
> >>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
>
> [...]
>
> >
> >
> > Any ideias?
> >
>
> Oh for non-zoned drives, you do actually need "-O raid-stripe-tree"
> added to mkfs. Will fix this ASAP, so it can be run on non-zoned as well.

Ok, that's it, running as:   MKFS_OPTIONS=3D"-O raid-stripe-tree"
./check btrfs/304
The test passes.

Thanks.

>

