Return-Path: <linux-btrfs+bounces-20357-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D62BD0C779
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 23:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E65683030914
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 22:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E0A30CD87;
	Fri,  9 Jan 2026 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="f+4Af32y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E92FCBF5
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767998276; cv=none; b=ng4QGlO99aUi/pba81hGWQjTQ3KanxAWsj/28S28ZoQZB2BVhXjC71wrMe2H0kIMHZVvMG0gCWRG06fsPXMv8wghC01s7ZkwjwduURfNa9cLqdFxk+yst5KDvvLrwaxQFyi3KaRKeYMEFT6ZRnOyAt3cNs8q6afK0km9/+Z2GW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767998276; c=relaxed/simple;
	bh=V1lZbQaEILHEyD1o1YIQey8xSo9JzlGRjfkngNlhp8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J5qSGBq0YA6ugVCHjuJ3EyGyGdNwggC0nLoCkNksT5ilkeMXwcbfkRLNGjtEqBlOzsI12irHbhSTS9uG0A78946x0d5esTv+aa45t7Rc2c6WBTMi56tarer0ir/FQ8NLMMBNEibCqfEdHO/2A00JgA/EVzUOJ8sDaCrkilTZIZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=f+4Af32y; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1767998269; x=1768603069; i=quwenruo.btrfs@gmx.com;
	bh=xokl0lGl7AcOYVkPsDrdynG2PdJX8uIxsl2wOfATAUM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f+4Af32yTTabOwhb/kJ3lhtU0/iNePLulyXAxgq4vk7fgYuWw7sPWTdG741pqnyu
	 gS4s8bMPfhkMKR3LzKYouWYfZS1LppyZ5FtvhFQWOEQmGI0Q/WoJgHZoLA3nDmCMm
	 tFBvbVStz3AQrrWFdmgRWHKdOJJZm3aZPWxTfh6X/iYTxeu9fLPBbJRHiLPZkxv9A
	 HS+oF8/xl6Odc0dZlrUP5vwieXs9RfqdmAGyxYF8DbTVKH/+NZqkTfzTYC0cIlmM1
	 LCovCxd3YSeqoyZ8daG1W0OtTURPWKOD31IElq7CoFIykMYDR4QuG+nf1XIh3CU9v
	 SisQ7CnxJq6eh6V81A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxUrx-1w2DgI44nB-00xHHO; Fri, 09
 Jan 2026 23:37:48 +0100
Message-ID: <5d5e6e17-ed66-417d-9ebb-772f9bbeec3d@gmx.com>
Date: Sat, 10 Jan 2026 09:07:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: update comment for delalloc flush and oe
 wait in btrfs_clone_files()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1767960735.git.fdmanana@suse.com>
 <12c71c470eb0c53d0431ce7ddb1bfd58443fd872.1767960735.git.fdmanana@suse.com>
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
In-Reply-To: <12c71c470eb0c53d0431ce7ddb1bfd58443fd872.1767960735.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h+K+YSRwWRzdclgmzhyV/V2klVZfPqa1YB3B6s9CwISGKsL08Vp
 5185sPHZ4ozUAux4CftkNyCRgbHtalJWStRj2Yuv3FxRD5m66bf13hJP0AKEn7jS58i79lN
 Po2AptiqrfMMtmReDWUWdTffLf4vyitvBistvAsGoPLFJXAn2CQDwn6oJNpZNaXgB0Srs75
 REGripKouAXvNlIgypDmA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U08795IriCM=;lvduYwC4k/KO46ngLcybU+d2O0f
 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



=E5=9C=A8 2026/1/9 22:59, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> Make the comment more detailed about why we need to flush delalloc and
> wait for ordered extent completion before attempting to invalidate the
> page cache.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/reflink.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index ab4ce56d69ee..314cb95ba846 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -754,8 +754,13 @@ static noinline int btrfs_clone_files(struct file *=
file, struct file *file_src,
>  =20
>   	/*
>   	 * We may have copied an inline extent into a page of the destination
> -	 * range, so wait for writeback to complete before invalidating pages
> -	 * from the page cache. This is a rare case.
> +	 * range. So flush delalloc and wait for ordered extent completion.
> +	 * This is to ensure the invalidation below does not fail, as if for
> +	 * example it finds a dirty folio, our folio release callback
> +	 * (btrfs_release_folio()) returns false, which makes the invalidation
> +	 * return an -EBUSY error. We can't ignore such failures since they
> +	 * could come from some range other than the copied inline extent's
> +	 * destination range and we have no way to know that.
>   	 */
>   	ret =3D btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
>   	if (ret < 0)


