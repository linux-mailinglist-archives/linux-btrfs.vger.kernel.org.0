Return-Path: <linux-btrfs+bounces-10350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31859F0BF7
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 13:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99A9168291
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 12:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FC11DFD85;
	Fri, 13 Dec 2024 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1qvP1ix"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAD11DF991
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092003; cv=none; b=Fht7mQ6LPgSJN4GzCLimOAo8uD0TVRWSP6fGAO9XtuIThFO3i3pA6QSNM0fV1XpmW9YikXYQJ2y/kV0Z+kwkv6D/tszlFKrogiUBJ3iNu8HXhlFXfzkCmye2uTotgSXpflHQN9LZaL0dC/NnHoAZ4nvCqDkOtuwIfaWSP9bglE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092003; c=relaxed/simple;
	bh=bOYooGV+nvPDk0kXIdZ5pQBjIrdTfMof8YLsT5HCiiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCVRKhfHo/zvzqEWvXEYkWk8UW0Vj6ypeVydAc1sW0lD7/VoSZf8A7ehhFPwsBJ2S9PQL3osUIXcKaUt2QFSN7x/juJVCHWtfflphgA9tfPXwGoNc7E1TqnA2Zp8fP8G5J5fDNzCKJdoGVsA61mOoUxhOZaPaw9Id5EcggBnBm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1qvP1ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EB6C4AF09
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 12:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734092002;
	bh=bOYooGV+nvPDk0kXIdZ5pQBjIrdTfMof8YLsT5HCiiQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o1qvP1ixlNSEzei3+AjXzcJF9zOE3dh8pwrPi6jDoJRCHEQDpw/2Ixp2es3RqKF3k
	 hixn8A1HWRjMHAqKYmJ36pB66o7G4hfINQiOF1AdHURqMKMweZHgExd8aSVbp0ROGz
	 E9l7cIVoz4g84RGX8FfZVDPB3+B2y8BqCQul1ZaNst0vEuXdOes5GSGnghAJArwI6e
	 p1Auz0If1Sj5Lvl4R7OzVkyPHDOSgEyypDhWrN3tfglhOZ4iw0LiVL4UBAD34k2IxG
	 QjSKqJx4BweDFgikM3w/bzCMhRjB1JCvvlGOb308VJBD/x5I5O0+y3qRUe37U7aB4F
	 8+boW+HmGbMaw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa670ffe302so310341766b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 04:13:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzjACZMM5veOIm+o3Sa2hHRUaOzKLgknW5eXhX72R5bZNA1L1N15T8CQ8XRy32AYRnRfei7IJnDVCCVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtB+NX9QbFs+M7U2Zr524KhB0lrLpHyvq6Av2c9YxchRuU3dNU
	sZ5xRsHVDiPxsQSAiSGcGdQki2z8/wZoXYPsQV1L6NHBv8/q6bmoMdvziD18go9LKvpu9aRvFep
	fcMRncXqR2EJDL7e4xBSWRUnrTIs=
X-Google-Smtp-Source: AGHT+IGozVejDrYlK9Fd57pbCoYYiktyzh4kYdRhl7gcpJDt4Yb5TydvNtrINc2m79E2z/8O/DEJXrMiimuPO7C3t2s=
X-Received: by 2002:a17:906:4788:b0:aa6:93c4:c68f with SMTP id
 a640c23a62f3a-aab7792d8bfmr225380266b.21.1734092001301; Fri, 13 Dec 2024
 04:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eeb2f4fd6565f76ddce9e8af725bd613e9b50e19.1734008129.git.jth@kernel.org>
In-Reply-To: <eeb2f4fd6565f76ddce9e8af725bd613e9b50e19.1734008129.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 13 Dec 2024 12:12:44 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4W4WbaCH1c+TdzB6ZZV_JDTug=yQDN4M65NkBDVnE7tQ@mail.gmail.com>
Message-ID: <CAL3q7H4W4WbaCH1c+TdzB6ZZV_JDTug=yQDN4M65NkBDVnE7tQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: removed unused variable length in btrfs_insert_one_raid_extent
To: Johannes Thumshirn <jth@kernel.org>
Cc: David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>, 
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 12:56=E2=80=AFPM Johannes Thumshirn <jth@kernel.org=
> wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Remove the variable length in btrfs_insert_one_raid_extent() as it is
> unused.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/raid-stripe-tree.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 9ffc79f250fb..45b823a0913a 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -199,12 +199,8 @@ int btrfs_insert_one_raid_extent(struct btrfs_trans_=
handle *trans,
>         for (int i =3D 0; i < num_stripes; i++) {
>                 u64 devid =3D bioc->stripes[i].dev->devid;
>                 u64 physical =3D bioc->stripes[i].physical;
> -               u64 length =3D bioc->stripes[i].length;
>                 struct btrfs_raid_stride *raid_stride =3D &stripe_extent-=
>strides[i];
>
> -               if (length =3D=3D 0)
> -                       length =3D bioc->size;
> -
>                 btrfs_set_stack_raid_stride_devid(raid_stride, devid);
>                 btrfs_set_stack_raid_stride_physical(raid_stride, physica=
l);
>         }
> --
> 2.43.0
>
>

