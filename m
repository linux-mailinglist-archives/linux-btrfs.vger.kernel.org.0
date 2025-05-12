Return-Path: <linux-btrfs+bounces-13949-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC02AB4764
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 00:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E876319E5C2B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 22:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB6229A328;
	Mon, 12 May 2025 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Sf+FAwfp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F76725EFB9;
	Mon, 12 May 2025 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747089670; cv=none; b=CRumFZXGOjHZF31MXSdRBgzrIUYknspHNpLs+EvDYmBGgH76cdAGebL2g3ME9z7MjpOP+eTMx4u97xN8bm+dD7JDKBVyUSb1aqYt8dYRobBsFXZRt95xr9UPJeOSRFgldqZce786YJ48Wx0z67/i1iTY+zgF2G3VRtBmw35i8I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747089670; c=relaxed/simple;
	bh=5QEqTj7EbaC6/gXmWe8xqU5m9NUE9SzcYi8bYnWCAt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ei3ihA2niXWqzzJLvkezujN6sFMzX8Hi6OMe83Ayb3Qklpbx6YpUyFy8hoxASJCMWj/AjITFN5iidyV3HnnW8O+AjFx1kB5RhfireF1ZYFEhbuLYKfz+6Q1bJdw1OAAaZFGVhY75txvW4RCemA3WevpWPSfqJ7Mz08JcrLbct2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Sf+FAwfp; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747089659; x=1747694459; i=quwenruo.btrfs@gmx.com;
	bh=CYioA30qXOB1Al0ztZuVSQTttrgyfOYP7tG+Z4wnbG8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Sf+FAwfpV8AHaUlEbscBrWmg+lOcgck8gQC411BT0gH5a05xml5wuiHPjK2ePjsF
	 mwsWCfiLxAMwg260ctJig6+AoWq1xIBKCmnXuqq3H2nVkTBNDE68eBxdITgHSzsUL
	 Kcr8p5N5M3jh8efwPh8ZSPf7ZQYUQFInEFGfL9AlTnAnkxL+vJGQ43n7bBnjv2XxM
	 zQ4FdWnDguBeJHDV31B29cbu2m4s7JN8ALF1ioBOIX3oOmP03Co38eCOAbQHySc3R
	 UkNUNnuKNe+RulYNESsv6ke8Xb3c1kzbhzp9YwQPzVQ0Ke4bLOWYQv5pvRYj2TX6B
	 3Ro8ob0zrYzrKjBp7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDhlf-1u6bjp1U75-00H3j8; Tue, 13
 May 2025 00:40:58 +0200
Message-ID: <a9ca69ae-fd11-45b1-997b-2186226214e0@gmx.com>
Date: Tue, 13 May 2025 08:10:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: correct the assert for subpage case
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250512132850.2973032-1-neelx@suse.com>
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
In-Reply-To: <20250512132850.2973032-1-neelx@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6ZVEGGzZNMMhIW0XX9JZsSCcjcZouJZQlVt7WbPqAoU5LWJ8oLa
 5cqKxRFdLptYO2d0l6DO3rg7ASUWQJIgeJMkfbxNDEwHIkJB8q9h0j3COYnmoWUOpRguIqL
 XgcYwW3jfbYHYZloeoTVe/dSiY7y3JsSrJdXS9MpB48JjObKOL/aGW7Ym5l3OeBpO+YYnSi
 /LeMaRgDkeyp3bLPeIRig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OKsDY9fekx8=;KgAcw3Mc0Mam3/og9DrN0RGukX0
 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



=E5=9C=A8 2025/5/12 22:58, Daniel Vacek =E5=86=99=E9=81=93:
> The assert is only true in !subpage case. We can either fix it this way
> or completely remove it.
>=20
> This fixes and should be folded into:
> 	btrfs: fix broken drop_caches on extent buffer folios
>=20
> Signed-off-by: Daniel Vacek <neelx@suse.com>

Looks good to me.

Although I agree with Boris, it's better to remove the ASSERT().
Subpage is no longer a corner/minor usage anymore, we shouldn't treat=20
subpage and normal cases differently when possible.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent_io.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 80a8563a25add..3b3f73894ffe2 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3411,7 +3411,7 @@ struct extent_buffer *alloc_extent_buffer(struct b=
trfs_fs_info *fs_info,
>   			continue;
>   		}
>  =20
> -		ASSERT(!folio_test_private(folio));
> +		ASSERT(!btrfs_meta_is_subpage(fs_info) && !folio_test_private(folio))=
;
>   		folio_put(folio);
>   		eb->folios[i] =3D NULL;
>   	}


