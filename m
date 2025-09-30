Return-Path: <linux-btrfs+bounces-17287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2D7BAC409
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 11:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAAF31927360
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 09:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1DE2F656F;
	Tue, 30 Sep 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="l7d6pGZp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADC52F60A6;
	Tue, 30 Sep 2025 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759224007; cv=none; b=gosz39eZW1KQsvWadmfnDRwLAbbvrNHo6snS0T0XfTvADRQ9ae38avIrnBrH/a9p94xrMJm4eki8UboDSChpBaueTKgY9yQKQLxVaMefgNbpSctKXNsCfUT/PEiLkZjqGZ9azV1hENTxecbBdI40Mdq/0G8GJSz+30Tt+F4daFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759224007; c=relaxed/simple;
	bh=TcYO3IK/wC/TJqxN7ktz4ZcLQtXphU1qke10cmGSDbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d3/IUedWdXP0uiRJh5U1EEkelFiqw5QmYiW5LrY+/v6R1OCGU0ZMxbdWd62T/hnvugAxrlEhbKe7IgnEOTPZnpAUBixFTrq0l1jDHzTECgMArskg8cwN2stRoKikg8qAa9KOmn7iL5BZOX8u7AS4lC8gj8kP2VBvEK1a9SiRwYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=l7d6pGZp; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759224000; x=1759828800; i=quwenruo.btrfs@gmx.com;
	bh=xQbt2TkBRs+6mtzvctUXs/lWGc6GKpkrQFnf1KAG1fQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=l7d6pGZpb1Izldf++GAPCFR1+/4HD4SaYzoIh4febyJ0wlGzuj+JQmEqAIhUb0CV
	 NrcnaXUrbZnubs3Iz90hNmDk9zQKkgDS1vc8Mw4wXZWs5GtwWV2HtxZ7HhEAj/2q7
	 yiPYx0cAwPbZcJfz5LKvKxV4UZ+rU603lBEQnUFogZ5iYdSfdQdWdH7RWTkVp/OBa
	 Qu5gYv6+n5C06MspOHKIWQQaFHt/NhfKWu3T/IBF4IBC2eRZeOdyaVvcdps59DyRu
	 9bV77fAZY3P2IQr6wuBtEV0RTHtQj7aLBJ+t4z0raL7fuWDOa4afYeowJR/36Qc9P
	 r0XKSz57tztDl1UsrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1Obb-1uIPTQ3xjn-00vbLW; Tue, 30
 Sep 2025 11:20:00 +0200
Message-ID: <76fa5e79-c7e8-4637-bf51-c0e6f4e04f51@gmx.com>
Date: Tue, 30 Sep 2025 18:49:55 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Refactor allocation size calculation in kzalloc()
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>, clm@fb.com,
 dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20250930091440.25078-1-mehdi.benhadjkhelifa@gmail.com>
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
In-Reply-To: <20250930091440.25078-1-mehdi.benhadjkhelifa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8vCNASodUDSflGQyBKXnxF1U1ZhBNgWPJ15/1nhk0jZ/M3LE7+U
 7Pdr2G9D3EIlBIRgEbGiH8uyMeZeM/9zi/8cW9OwV8px9NyTjNYaWCg7nnthiIcOIGqvYym
 FjECDUNdDGZQHoifL9Fq4vo4fwiYHGdgfWicDIslv+fc+H+xFhL3sqp4uCoId/5EtfWzpux
 TIqsUjj0Powkb5KzhfEwg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3a/QgmGfMmM=;PQ1TesLDk5piadrrvOKyX4bI5jZ
 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
 wCJIFNZZrWuyWcpcN1EO2ruCKW0HKJ1aaCM=



=E5=9C=A8 2025/9/30 18:44, Mehdi Ben Hadj Khelifa =E5=86=99=E9=81=93:
> Wrap allocation size calculation in size_add() and size_mul() to avoid
> any potential overflow.
>=20
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
>   fs/btrfs/volumes.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c6e3efd6f602..3f1f19b28aac 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6076,12 +6076,11 @@ struct btrfs_io_context *alloc_btrfs_io_context(=
struct btrfs_fs_info *fs_info,
>   {
>   	struct btrfs_io_context *bioc;
>  =20
> -	bioc =3D kzalloc(
> -		 /* The size of btrfs_io_context */
> -		sizeof(struct btrfs_io_context) +
> -		/* Plus the variable array for the stripes */
> -		sizeof(struct btrfs_io_stripe) * (total_stripes),
> -		GFP_NOFS);
> +	/* The size of btrfs_io_context */
> +	/* Plus the variable array for the stripes */
> +	bioc =3D kzalloc(size_add(sizeof(struct btrfs_io_context),

Please use struct_size() instead.

And if you're using struct_size() there iwll be no need for any comments.
> +				size_mul(sizeof(struct btrfs_io_stripe),
> +						total_stripes)), GFP_NOFS);
>  =20
>   	if (!bioc)
>   		return NULL;


