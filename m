Return-Path: <linux-btrfs+bounces-13883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD6DAB35D5
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 13:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D292189B41D
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 11:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2091885B8;
	Mon, 12 May 2025 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="um94yGW4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DCA2918D7;
	Mon, 12 May 2025 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747048887; cv=none; b=ickBrwU0PENpWACX8bZgF3jIhDmP6aGDPU9MyDd39KHX11/szv+DtBzQLNIh9ytYyTwaQ7E17cIyywOAJnl6o+uoDrI4W6v1mO+xoKyLARu22b3XoUf/xo0dvlCUf9rb86Dm5fE2qwvYTuVemZt3LKU7zId4RyhValTgZl8UIas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747048887; c=relaxed/simple;
	bh=avAvinI0DQaQqicJFyhnymJSRtb9fnlFHr9ZG9mLySI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6hBc0SA3A0M1/duL0crM3bozpEUqMXSfZ6Rz4dARWg/dctbDdye5JsYn0/RQ3kOMCUWq6xCE6ya05JJeNAhHAUsYm+SlJCUuIsdtH5U5Mu67A4StTTv7m1RvRIOvJaSUBhWPpSLAGm/7qyBSeg4z7bpinmE0hXdD7OQzfl30VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=um94yGW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F55C4CEF2;
	Mon, 12 May 2025 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747048886;
	bh=avAvinI0DQaQqicJFyhnymJSRtb9fnlFHr9ZG9mLySI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=um94yGW4wRUsrBYiIwXdSD4erNn9moAxrAyhutwUh56AEXH35ESTd+Cb3/S5nSk1X
	 SDvI3X/bVlN9AI4/xKdjLZ8NUgK49ZeSMX/yzYqWXw5cPo3gYypWcanScr4T2TpGOy
	 3ey9vFGFAMV51y5IM42UDjB+Pgp/KsGeeZv93QgSv9njSLUluD/UWGaCLE+gR5HRSP
	 mVDiIlSXUGadbndGuDqddIaQV3528vY63wAM/fu1jMh3g8gEydsBKq6W9oUZ2Nhn7X
	 SCAuUFoaWSIFIDOvuxQyeZEsO+Q/AmcGCxCYvlGyRYry/YQ+5Ad/AuyZjuFCYV0LiY
	 jon9BK3HUuxTg==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso720042266b.3;
        Mon, 12 May 2025 04:21:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWI79aw4NfGp98kPCVhsZ9QoLbR6uIBKcWODIt+BxLWWpEFZaScs6VWZK+1+KIA9cXiFE5GBjpknjDK7wU=@vger.kernel.org, AJvYcCXdfJc5NlNOJwW4IsGLYjv0nJOYJTWnurYUgHwUoDaNGCKG+UYmJOC3Aux044TZ+95/eY1QgFUW@vger.kernel.org
X-Gm-Message-State: AOJu0YyNGeK57lySyBkiL1tdckaosZArBNrwi62qLMGSDVYEfUCUqoj3
	2S/OHuTO6ZE09aHQc2fzoNU+SKRXeSDz1/FEE4msG5KPjs71Kh7xxa5Yv1b1FSDOegfso9UEFw0
	QNHzNEYOHVn1gt6qSzLcUSR7Jgas=
X-Google-Smtp-Source: AGHT+IEofJ4fLDFMmobEo66UZ9GPsHZoxCCzoFKfuHcvI+8I0abmuVmyqF0rxjkfhvM6+64DU6RBB9e0kJuZGp/SikA=
X-Received: by 2002:a17:907:1c8c:b0:ad2:450b:f8da with SMTP id
 a640c23a62f3a-ad2450bfb34mr617469166b.19.1747048885487; Mon, 12 May 2025
 04:21:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7b7c5af880673b1698b17fc183d369457e1a89f9.1747030065.git.jth@kernel.org>
In-Reply-To: <7b7c5af880673b1698b17fc183d369457e1a89f9.1747030065.git.jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 12 May 2025 12:20:49 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6MX0W2AmnnY4eV3rgLgJFyjMS76CiVx2MR9CECCNTYQA@mail.gmail.com>
X-Gm-Features: AX0GCFtuuu44RRCygvu1cdAkVsEmOaRG5VGIFMaqJpWEQ-pwVATUVF7zL9RiGis
Message-ID: <CAL3q7H6MX0W2AmnnY4eV3rgLgJFyjMS76CiVx2MR9CECCNTYQA@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: add git commit ID to btrfs/335
To: Johannes Thumshirn <jth@kernel.org>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org, 
	Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 7:08=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Now that kernel commit 'b0c26f479926 ("btrfs: zoned: return EIO on RAID1 =
block
> group write pointer mismatch")' is merged, add git commit ID to fstests
> btrfs/335 and also add the test to the auto group.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  tests/btrfs/335 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/btrfs/335 b/tests/btrfs/335
> index 82085d4f04ef..eba1c7eac65c 100755
> --- a/tests/btrfs/335
> +++ b/tests/btrfs/335
> @@ -9,11 +9,11 @@
>  # position in the target zone.
>  #
>  . ./common/preamble
> -_begin_fstest zone quick volume
> +_begin_fstest zone quick volume auto
>
>  . ./common/filter
>
> -_fixed_by_kernel_commit XXXXXXXXXXXX \
> +_fixed_by_kernel_commit b0c26f479926 \
>         "btrfs: zoned: return EIO on RAID1 block group write pointer mism=
atch"
>
>  _require_scratch_dev_pool 2
> --
> 2.43.0
>
>

