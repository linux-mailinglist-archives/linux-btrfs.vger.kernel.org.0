Return-Path: <linux-btrfs+bounces-3268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 537DD87B560
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 00:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D74D8B21387
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 23:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CDA5D75A;
	Wed, 13 Mar 2024 23:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPrCYZON"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644235336D;
	Wed, 13 Mar 2024 23:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710373964; cv=none; b=elodZQHYIJha6t/SJM7rPTgw3OQnG3KLYcvNucJt5mkHV3rJNRfrR5jdr5OW0juCL0k5RVfHgdZm1eaTAOpTCQ6hKh/cEzbEdGT147pYQ6wp0MdW1Hzgfg39vHoziODz/a9oD1lnE4iFO6it1lQpTQzzrWPOdHAe7vJ4FQIEyJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710373964; c=relaxed/simple;
	bh=XLUdf/+18fHFF/RZeMw0wb0oJw4ouiemeHvr3Ts9dAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZZHGnjyAevMlYRsEz1klH9P9XUOkGE5BNfUjFIvvtoDX0+pryQrFjiN51dhCfKwVopA8Wf3ndappRfnwFqC//wm1plqNfnxGOgKbheK9awXEDRN4okcc30GDpXx/bdnPv/Lts5IZ/FmHbxHkbpgQR/TtRorEz02ivgI0GC51O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPrCYZON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC52BC433F1;
	Wed, 13 Mar 2024 23:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710373963;
	bh=XLUdf/+18fHFF/RZeMw0wb0oJw4ouiemeHvr3Ts9dAo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YPrCYZONAhCfMahjHearYTE05uFcAd7y52CmXWrvVRajtFcRwblbHRRL259nETDWd
	 3Dnuy7s3fr5Us7VaRLBfCe3zy2xa+G9rUTmLYYK3wrlNZ1KW21QJ5EtxMGd6yiMK5H
	 UH/YR4qd4lnrGV29RhZMTV/njNnOwkhW0MRHTpd3/rlOhj0jB9qLge63QW1kWCm2P8
	 i7wG4YGl/8ZMBvBp+UM7YDc7RVYNGhXjql+Pzf+wj6k0DhnAJJhEo/IZma3HgpbIFG
	 yW8c9AYn6yWS7U7Vd4JXE0ZC42k4A6ZtFIwvV/shRS1cKnmYUG4MifnolYBeN6uxHc
	 WhQX4RzwyP8rA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a446b5a08f0so76757766b.1;
        Wed, 13 Mar 2024 16:52:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWslrcnevu6ueTJ9qglgpu3oQcSc2wGxavhZhK6b02YEsJ6Nl1B62FYLSAjL9YOGPYd7CCfwuVqQu99LPUoVPh1d5NeW0SDaw==
X-Gm-Message-State: AOJu0YxpuPGZp0J0idHwnTqVdxkM1aPGsKdAA6RCtZ6uOhauV7rbceJl
	R2r9HWgRMM90HZG/VQRxOsNpFPP190A56FoF2tC+1tiv2/OgStoGEJ2fKUO16mVDKEKk199y4hW
	HknArJXUKkIj/t+Z4XIijjdRGBBo=
X-Google-Smtp-Source: AGHT+IHag13wxjAuUt1V4cZU4qFMQDFc2AWGIY5NqxCAVIkJ23NjAaE/56Y/twKNZNHYW5cVaqfC09q/rH7fK/gUEhE=
X-Received: by 2002:a17:907:a0cc:b0:a45:73b0:bcc3 with SMTP id
 hw12-20020a170907a0cc00b00a4573b0bcc3mr22838ejc.34.1710373962345; Wed, 13 Mar
 2024 16:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3528774789271f9e46918f8b1d1461dad0e11cc4.1710373423.git.boris@bur.io>
 <5c2dd52fecbc5ac86068a725875882e3000bc969.1710373423.git.boris@bur.io>
In-Reply-To: <5c2dd52fecbc5ac86068a725875882e3000bc969.1710373423.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 13 Mar 2024 23:52:05 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5iohxGGxJp90JM0+d4FwhygRFLb2BbDexpWyWqe+Deog@mail.gmail.com>
Message-ID: <CAL3q7H5iohxGGxJp90JM0+d4FwhygRFLb2BbDexpWyWqe+Deog@mail.gmail.com>
Subject: Re: [PATCH] btrfs/316: use rescan wrapper
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 11:45=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> btrfs/316 is broken on the squota configuration because it uses a raw
> rescan call which fails, instead of using the rescan wrapper. The test
> passes with squota, so run it (instead of requiring rescan) though I
> suspect it isn't the most meaningful test.
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  tests/btrfs/316 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/316 b/tests/btrfs/316
> index 07a94334a..36fcad7f8 100755
> --- a/tests/btrfs/316
> +++ b/tests/btrfs/316
> @@ -24,7 +24,8 @@ _scratch_mkfs >> $seqres.full
>  _scratch_mount
>
>  $BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> -$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> +#$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full

Why the comment and not remove the line? Seems like unintentional.

> +_qgroup_rescan $SCRATCH_MNT >> $seqres.full

With that fixed:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

>
>  $BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT >> $seqres.full
>  $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subv1 >> $seqres.full
> --
> 2.43.0
>
>

