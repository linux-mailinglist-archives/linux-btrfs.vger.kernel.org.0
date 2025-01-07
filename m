Return-Path: <linux-btrfs+bounces-10784-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4DAA04B76
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 22:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1E31886C68
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 21:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579661F3D57;
	Tue,  7 Jan 2025 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="b1wo7qVj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A0618C031;
	Tue,  7 Jan 2025 21:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284661; cv=none; b=d415+Damj3YxgXXnDu42kLMv68TgXrK7u7X3Lep8wfn59n/IQMo5B9nhwFBKfgUaIUarOBW1mcQ79UK7L72ztU8ajoDaYA0rmpJyvuAOC7kpD4XIOd0JlIk6M1yInU4WNIA610o1WIC4wIsxTDlpfULlK3SjYa0WZHz61rTar+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284661; c=relaxed/simple;
	bh=J1s8oB4jAPwwWjBxpiY0zAKRe9HC1T+V0xR7trDumUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2l4HiWaqR6biDAGvYS7dKxnkQs2NzXRSE3VgpdEIwwJS6M+OY0NMGFmWzkZeRkYzlaNGxRKJQoE7RxvP6u/FT2Z0nWPvi58WHIXMJX/aIPSHp1vOjfQzEBe95BaTEjNaDU0iAd05EM1h/RtOe8PktCW0snpyD58VikE2dX6XlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=b1wo7qVj; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1736284652; x=1736889452; i=quwenruo.btrfs@gmx.com;
	bh=Z4yMo2D9qQsiH7ph6lxdlJWkOX3hwMzKEkRoEvKjvWc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b1wo7qVj1Ofb7ZjvrrlR/NrZ4iEBkwwE+w0+I64DJVjbPu0gHMObCC8v1MIOGyK9
	 Hlu/HEpL2ff0tIR3epPKUrUSwNurRLIZzhkuDjlitfvTX3Ur24jDt1UG007PNOOLY
	 d1KZV3d6vxJEUpW/IckGxI64m7zwjm2SiSzsX70uUX+Wg8/MtHGSfkIA0NntUtcmW
	 BJDR0AVza/Hx8Avnityin5Ffct5bj0490jDUIxAGfjX1IIJIV4Mzcn6TkGSzWfYtH
	 64LsjVegi8I2YFbNKJ/jofLuQI74x7RdBpQKm8cIOAgWjgJlD69JwXYPV7yBWjfne
	 ZmhaWowgLwRILw4fKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MplXp-1tnZOo2yK5-00ojxV; Tue, 07
 Jan 2025 22:17:32 +0100
Message-ID: <69234185-59bf-41ab-a941-aa0f3aff4c81@gmx.com>
Date: Wed, 8 Jan 2025 07:47:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: test cycle mounting a filesystem right after
 enabling simple quotas
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <c4991049b54536bb7073f3c2118d12dae604d73d.1736265642.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <c4991049b54536bb7073f3c2118d12dae604d73d.1736265642.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9OEq+eF+cyUbjhLEmbiFZq99y4dlQPO1KYRXTdagfvsK/Qh4DlE
 R8uzkCtECgQY94TljYEI46YI15qAoJ1xu0enUBR42qP19gOocALQJx/l/h6D2hQuLA71FBw
 6h91OSMtUsZ89ifoXwOeTpPteLYO8CMZ4RIUqTQjYEmJU3ngusF1ZOYLxquStjFk1qOsLV5
 SU93Izakj1nDDe0Jt/oBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p4ZxMwRmNv4=;KHlYNcBaZIfw5zvzMmyGk6+2TMS
 D4BBgoPoo4716YBGRhQddU1lZcwe3ter4z5HoYIR4emkpb/Ny2bS4ZIQOpecRjdNbysI2X1d6
 AUcua1WZ64vO6X8UvFhkaFudJu437T/QdpggGOb/k18wSzIGoP0cjFW+B6kMN85kaeV/nsGHj
 F9BgTiania7a/tGtQXvO9wmcebnm4qnGdaKODpxnwlsEY30y3FaYWefL714QDOFiz4md/FONr
 3spurLBHNadsSvxYEDkSRgi8T3wsE+hfmVV1jwsXWAiBWATTQ1sYZqHBSaf+6LGGvq80/TYVR
 FwYbF36HJBPMBwVSjSq2BrpbS07BrJldsU2eFnl5bT2aVq7j2KTLDt48eY9QAcKM1Bwgtch1h
 ySrexUPB6pefKzF+oQMemvOAw1NvWxgZoeBF6f3q599GgZk44L4y506uyRYaiBZbaBHLbqd7m
 i/LWdrxO2YzPiydwcHbA106HW6cbYhcKsCmZ2iWWz8n1IY8GEqUbOjcT2QxmvJUtxF8ZW4Vzu
 9Q1K3XVVQpP+tSXjw0JECWspmnJlXhZiE1DwqfuNNdz3harlJOy1Vb7MP9Mts1HdmcXTvmKXn
 /qpcUhgGevt6lM7siIr+4NG/QWAUkSZTZlAZ4vlVFpbp1eJ+2zSEgtwRzIQQk3O1+5gzXG0HC
 HHVnGd7A5xjW8xuhMewxiyWRGu7yfO9gMUht7Esg0/+/gtjSxGNeMSuyjTWpwzBkLsClY2lFF
 zEQHjjI6uFC3ClsKprZejj50+VQxjHWhzNRZ5zNaZQ0RAiclqXct5iDsC4XhU993jFHQJpw3m
 F4C4KFON4h7qbEtKHuIb6aI6OgGG9N+NTh1KqUy+sNYIIOcw+iK9cPG58p2nS/2Y9IB5xp2Yh
 1x6z/zbIHDDAgOMyQrktBvtxvAAwReqdHfxeNAIfPEyTbXDMIcsR52if2ZT4DumN8Cz+Fy2Zi
 GNtKETHt9MFhfe+9/57KCTwEZbp4H/XF48PeCCSQ/fCJtatTC++n6nOuzDTP+8OcMFey0ybVc
 BJQgdoIpCXCl5tgOiNBGQyuUXKchIyDP7KEYwkA0YN4GNsfUtJLaHRQeuRHLDaiITh8bTPzfK
 Dftb1d8bz9oWvQ/glPkBCWgLLD7z7T



=E5=9C=A8 2025/1/8 02:32, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Test that if we enable simple quotas on a filesystem and unmount it righ=
t
> after without doing any other changes to the filesystem, we are able to
> mount again the filesystem.
>
> This is a regression test for the following kernel commit:
>
>    f2363e6fcc79 ("btrfs: fix transaction atomicity bug when enabling sim=
ple quotas")
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   tests/btrfs/328     | 31 +++++++++++++++++++++++++++++++
>   tests/btrfs/328.out |  2 ++
>   2 files changed, 33 insertions(+)
>   create mode 100755 tests/btrfs/328
>   create mode 100644 tests/btrfs/328.out
>
> diff --git a/tests/btrfs/328 b/tests/btrfs/328
> new file mode 100755
> index 00000000..8e56c4d6
> --- /dev/null
> +++ b/tests/btrfs/328
> @@ -0,0 +1,31 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2025 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 328
> +#
> +# Test that if we enable simple quotas on a filesystem and unmount it r=
ight
> +# after without doing any other changes to the filesystem, we are able =
to mount
> +# again the filesystem.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup
> +
> +_fixed_by_kernel_commit f2363e6fcc79 \
> +	"btrfs: fix transaction atomicity bug when enabling simple quotas"
> +
> +_require_scratch_enable_simple_quota
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG quota enable --simple $SCRATCH_MNT
> +
> +# Without doing any other change to the filesystem, unmount it and moun=
t it
> +# again. This should work - we had a bug where it crashed due to an ass=
ertion
> +# failure (when kernel config has CONFIG_BTRFS_ASSERT=3Dy).
> +_scratch_cycle_mount
> +
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/btrfs/328.out b/tests/btrfs/328.out
> new file mode 100644
> index 00000000..67faba8f
> --- /dev/null
> +++ b/tests/btrfs/328.out
> @@ -0,0 +1,2 @@
> +QA output created by 328
> +Silence is golden


