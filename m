Return-Path: <linux-btrfs+bounces-16606-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0442DB40F94
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 23:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 976977A1AE1
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 21:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DDA35AAB9;
	Tue,  2 Sep 2025 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="C+UFtOFx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D205222156D;
	Tue,  2 Sep 2025 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756849412; cv=none; b=WPaB7VdWKRj3i9EADhKbdfLPpxmFRB3cfTxdlZ0sDeFeW82OPsBlSJ0oVgE+AJNSIj66RBhBJ9h4JbPN3JiuMWso0auYBiHUTQMTMmUvm9+pljTmcgOYjSsQQdYg1GdLUAA6pYmTCOD23UA9WGNJ12XiOBDt8UjX0d7Lnln/aq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756849412; c=relaxed/simple;
	bh=69dUvqYSiwJcPRDNT2qSp2YM11FUwJXaEQL6oejmNlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kugLFSael3LIhcZ4VfmWEUYnxeAtdPlg7PNay1UVWU6lVQATZtI/bPhV0DBy+oa49yvQxQVHykkZosazmxdq1gqJzWEnuUZ1fLpPNmyYCa4xXDtYrEwgYBdjmdbI8qasL1JN9pLjai4jDJ9DGMjx6yV47eZpKh5tO6LgebnTuBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=C+UFtOFx; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1756849409; x=1757454209; i=quwenruo.btrfs@gmx.com;
	bh=S5gmAyv2rbrezRomUU5kduVL6s8FbaAzfFqbMKvPP40=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C+UFtOFxzJY/KylPKcD+4HnkP2OT5mboL/vWG31MENnfBPTKQvpN2i1i2+Y7YnUt
	 WTY68wYqJ17i5WpAtOAJudpcETjwWxQBp7JICcDtdn2Dj7XnO5RxaAUgPGFNhPKCr
	 GJDBXXwn3HclOguHzCYJ2q2Umie8jqxlNYpTpu8wxMHR+EeS/tg/1EBaIJg7gI26e
	 CreD7DtZseuuJgGw8aG1Cb/+ZgniQCf3ar64NBfdlnSVqmV4baoTz81PWfn7OtAHk
	 xO5qMR9Sw/3iWGJGWrzoj+VNYceoBkmmO/RnI0tO/8605D9DdK71qxtbPWclCQ0jT
	 CEiCLHndKnif2CD9nw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3lcJ-1usjhr0Tpr-0031jK; Tue, 02
 Sep 2025 23:43:28 +0200
Message-ID: <98de454b-54ea-49da-92f1-95591fbf69d1@gmx.com>
Date: Wed, 3 Sep 2025 07:13:24 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/363: mention btrfs kernel fix for block size <
 page size scenario
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <1d3740e7564f94ed51d18c4d53103624fb51e735.1756813886.git.fdmanana@suse.com>
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
In-Reply-To: <1d3740e7564f94ed51d18c4d53103624fb51e735.1756813886.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L4Jtxz8OGMtKH/pMv9+yoKGXNJKRfFHc4aMFs+CbCOy/io4WkJ+
 3H8FUn8cq46hmZx14YA4uClPl3SrOj1/uquYJSwjdyOMOWY9N2SelTJSnXmxEyyFXS5iNfm
 SGuzzxr06WvfJ5JFmAV/pl2xtsu7scbk1BMTDHuUAx/0l3J6JDaj9nNiug49Omi2052Y7xf
 ghp+X+jlf1+upw4MPolRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hpWlXdAoRXs=;QAIAwJCbcka9Q2YVtWgQBRkcPpu
 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
 OHPc5SHNnO6VV3C13ehK3ZpOb5k0bKqQ==



=E5=9C=A8 2025/9/2 23:57, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> There's another btrfs kernel commit that landed in v6.16-rc1 and fixes
> another EOF truncation bug exposed by this test case, so add the commit
> in a _fixed_by_kernel_commit call.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   tests/generic/363 | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/generic/363 b/tests/generic/363
> index 79b1ff89..f361878a 100755
> --- a/tests/generic/363
> +++ b/tests/generic/363
> @@ -13,8 +13,12 @@ _begin_fstest rw auto
>  =20
>   _require_test
>  =20
> -[ $FSTYP =3D=3D "btrfs" ] && _fixed_by_kernel_commit da2dccd7451d \
> -	"btrfs: fix hole expansion when writing at an offset beyond EOF"
> +if [ $FSTYP =3D=3D "btrfs" ]; then
> +	_fixed_by_kernel_commit da2dccd7451d \
> +		"btrfs: fix hole expansion when writing at an offset beyond EOF"
> +	_fixed_by_kernel_commit 8e4f21f2b13d \
> +		"btrfs: handle unaligned EOF truncation correctly for subpage cases"
> +fi
>  =20
>   # on failure, replace -q with -d to see post-eof writes in the dump ou=
tput
>   run_fsx "-q -S 0 -e 1 -N 100000"


