Return-Path: <linux-btrfs+bounces-10406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F899F2F0C
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 12:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F781167264
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 11:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B1F20457E;
	Mon, 16 Dec 2024 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="optb0I5c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F04204570;
	Mon, 16 Dec 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348245; cv=none; b=DI9+lpok0O6Hg2Eo+uv7Ot/Vvoof+XWGsfhjJYzw6GzvMQmR56H2NSdK9ym7egzcnUPC1jIW6/ypSdv4Mo8vLHTj87ofa0+5E8F+8pcddyzpD5ZVCcFbzdEgKiHn0Nkd3MqAGx/IRSOjM2PBW3+PzgFxlyeNhO70rs2x4Nc9wvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348245; c=relaxed/simple;
	bh=FHDzRf9XplQIVKV5ZROwjyH68Lcb6hQK4EdGbC6roFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdxa5Ot8D0AdEcAFmN10NJGc1idARza2GDZlwOcFBPUwHuXGON8QRqoYDVJysOj7UWlGmkGVflyv0L3qV7jlx2BOzM0FUPyHT0DGxuIexx33+WeJYXcc63uEqVQrIDFg3BEakgM+J6tiwkrgWUCX+5cUe/XSDqh9cKJuh6tR8iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=optb0I5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D17C4CEE1;
	Mon, 16 Dec 2024 11:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734348245;
	bh=FHDzRf9XplQIVKV5ZROwjyH68Lcb6hQK4EdGbC6roFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=optb0I5cJBzbAkDyaGFC3k3SqUFYWu96CozIYWuMXcv702+OZSM6jZS2sMI5Nn6gz
	 8EEU2RGh9JX7EONnxhYll4VH1KMw369DeLYRYgdmqKeTAP4lRoYn2VthABeTAbCtS4
	 n4VtHx9lPoHzdlXOwxX0BeAKYF6BofQ4+mgXUKHSyORV+Djx4VjtxDVxNaLAZcUd8+
	 bJAT/ms12lwIBa+hAEw2esLWxIHO6hfu2xTwRr2Hf5p3GrlqSUkv4npbjcOKhVnDVc
	 vONpPzmMa/3Wl3o5pjpeHxoTn6DFp3I+5zj4zqCXJWFm6Iow9LDIHVVE2eDjOAXRJG
	 I3L/CbRSY7iBw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa692211331so764318166b.1;
        Mon, 16 Dec 2024 03:24:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVoUz1FhCBaepGhu1dMJIXfL36qSiWVlHEKttkaITM21g8EtsBfmd3MavkfceIf4lyKNDcGEr0p5u6resID@vger.kernel.org, AJvYcCWgldeozGl3ANWyPombVlpSnlWrg0JBp+6AIUq/sMpG/Q5EZXUdPMttNLwINoEvuPCA1Ic9WGtLK8aNaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1vsVWTv7TRdSRkuf42ws/FKusWPoUyNZEsit6pA8M2mlpc07y
	A8bSiRlnRvLH/UGursdxclRtxp56LiCgAtpU/OCx/3cYF/ATlmoEMfqf/59vcvU6U4O1vltNRIT
	m7kFbpg6mo+0NMkd/AEty09XZH5Q=
X-Google-Smtp-Source: AGHT+IENINiS+xOG/vwpVS/Z2cnq/8d8ukc2aBTZA1Jpqg5Mq+e+pXbqSjSQlgakgIL9FZ3VOqL7ZvYA/IYVm3z1Roo=
X-Received: by 2002:a17:907:3eaa:b0:aa6:abe7:ff49 with SMTP id
 a640c23a62f3a-aab7b7607camr1039010266b.16.1734348243870; Mon, 16 Dec 2024
 03:24:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216-btrfs_need_stripe_tree_update-cleanups-v2-0-42b6d0274da7@kernel.org>
 <20241216-btrfs_need_stripe_tree_update-cleanups-v2-2-42b6d0274da7@kernel.org>
In-Reply-To: <20241216-btrfs_need_stripe_tree_update-cleanups-v2-2-42b6d0274da7@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 16 Dec 2024 11:23:26 +0000
X-Gmail-Original-Message-ID: <CAL3q7H77_ZVMKhDX-hKc6FuA4XRxG6y1N15H2ukeg9434vEecQ@mail.gmail.com>
Message-ID: <CAL3q7H77_ZVMKhDX-hKc6FuA4XRxG6y1N15H2ukeg9434vEecQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] btrfs: cache RAID stripe tree decision in btrfs_io_context
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, Johannes Thumshirn <johannes.thjumshirn@wdc.com>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 8:11=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Cache the decision if a particular I/O needs to update RAID stripe tree
> entries in struct btrfs_io_context.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.


> ---
>  fs/btrfs/bio.c     | 3 +--
>  fs/btrfs/volumes.c | 1 +
>  fs/btrfs/volumes.h | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 7ea6f0b43b95072b380172dc16e3c0de208a952b..bc80ee4f95a5a8de05f2664f6=
8ac4fcb62864d7b 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -725,8 +725,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio=
, int mirror_num)
>                         bio->bi_opf |=3D REQ_OP_ZONE_APPEND;
>                 }
>
> -               if (is_data_bbio(bbio) && bioc &&
> -                   btrfs_need_stripe_tree_update(bioc->fs_info, bioc->ma=
p_type)) {
> +               if (is_data_bbio(bbio) && bioc && bioc->use_rst) {
>                         /*
>                          * No locking for the list update, as we only add=
 to
>                          * the list in the I/O submission path, and list
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fa190f7108545eacf82ef2b5f1f3838d56ca683e..088ba0499e184c93a402a3f92=
167cccfa33eec58 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6663,6 +6663,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>                 goto out;
>         }
>         bioc->map_type =3D map->type;
> +       bioc->use_rst =3D io_geom.use_rst;
>
>         /*
>          * For RAID56 full map, we need to make sure the stripes[] follow=
s the
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 3a416b1bc24cb0735c783de90fb7490d795d7d96..10bdd731e3fcc889237b4e1b0=
5cc9389bc937659 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -485,6 +485,7 @@ struct btrfs_io_context {
>         struct bio *orig_bio;
>         atomic_t error;
>         u16 max_errors;
> +       bool use_rst;
>
>         u64 logical;
>         u64 size;
>
> --
> 2.43.0
>
>

