Return-Path: <linux-btrfs+bounces-17290-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29553BAC6A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 12:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01C1B7A6800
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F982F6581;
	Tue, 30 Sep 2025 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="O0JvYXKL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98DD212554;
	Tue, 30 Sep 2025 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226999; cv=none; b=czB9mkDIA43FAXp4FrALJ/UINtVU0d4bT/ycsQr1VwDwZURlNfnXgAVKKKMJ4/XVIut09W9rlAdg9afEhkINdP7XTIbfZQ0V/5YSQ5OuwwacEzXEEbZHbZ4sW+FWJbjcDAFAnyH4tC8xMDWlXUAB9ZcgKjtXF4qBuauHE6XfxwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226999; c=relaxed/simple;
	bh=8lD6pDtxYmt50mk/QmwTdSy6OOnLGlYbh+Njk+h1+u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLegBwpphRKaiWaDRSbdmmJQJOQwaPA4PRziIyJB1PTN+XzwDIX0RgMTSWCMsVz1g8TfCwTwv2X7lPhhWrTAmnCiyl/5qEO3AtI1WimWJAX5vTPBPneXgcM8nu8lvkzMviOUul7dRZcgxyA3NsBzhkf/NZgw85NRgGlzItaN1zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=O0JvYXKL; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759226995; x=1759831795; i=quwenruo.btrfs@gmx.com;
	bh=xAlSJAqz7B75+0z+tcwRCeT89jL6ufsQdHDrs0HJROQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=O0JvYXKLOSu2mdh3UjDdZ/FgJNEnyV8ryz4+aK25jeSLtDl+TI8afrdMSi3P3oHq
	 lLVqI5WGhbalNrCbZYESwOhg7nj8vzXgNfN2M3p7U29FoUIEUAqCMI/bNjFdwgDRr
	 e3kylfV+lBq2wzk17EAf5HNgp6U7DqQdGvUvXvMchBlkEubeW8qhs7H+bpj3S4ZKn
	 heTnJmpl8dU4dH3UIkYn3wWGWPShpbo9huog9AQRnG4C1MT7rcHYlRO7vUCz+fNAh
	 W1bjopdCIC3aqsjKG/OtiP8fE7ca0uFdOi4F45i7G403IvpIhdNK2k09G8Sloc7fE
	 1rkBST7soXQQSXC7eQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYeMj-1upZB31xR5-00QnLT; Tue, 30
 Sep 2025 12:09:54 +0200
Message-ID: <7d0f9cd6-77a5-41e1-82fd-4641d149bfda@gmx.com>
Date: Tue, 30 Sep 2025 19:39:49 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: Refactor allocation size calculation in
 kzalloc()
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>, clm@fb.com,
 dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
References: <20250930100508.120194-1-mehdi.benhadjkhelifa@gmail.com>
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
In-Reply-To: <20250930100508.120194-1-mehdi.benhadjkhelifa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SNjPcdNYY8ARF61SR9NttGgRvCgU/3HZHTRtUR8vT7zKlxcWWZs
 PvEgRvB24eC0YwnYa3kgWKb7Z9xtp/kRUmdK0OHuyNOrKLFgZrYXmqc4flfaCoI00tZHku/
 HxVmqTbF7BI5rOP1ybxR0kYHiF9gcqo8X+lmqmXx3T7ieVsmLq0Ym2iKR4q1MiejMSVorEJ
 z/XFwj9tubpOtS5Md78Nw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VOzxx7kVYwo=;ZM6SMPf/1qc7MlF04aRovT9aaB2
 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
 eVfIQ==



=E5=9C=A8 2025/9/30 19:33, Mehdi Ben Hadj Khelifa =E5=86=99=E9=81=93:
> Wrap allocation size calculation in struct_size() to
> avoid potential overflows.

I don't think it's really about overflow or whatever, just pure code=20
refactor to make it more structured/easier to read.

You don't need to send out a v3, we can handle it at merge time.

>=20
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>

Otherwise it looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> Changelog:
>=20
> Changes since v1:
>=20
> -Use of struct_size() instead of size_add() and size_mul()
> Link:https://lore.kernel.org/linux-btrfs/342929a3-ac5f-4953-a763-b81c60e=
66554@gmail.com/T/#mbe2932fec1a56e7db21bc8a3d1f1271a2c1422d7
>=20
>   fs/btrfs/volumes.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c6e3efd6f602..d349d0b180ac 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6076,12 +6076,7 @@ struct btrfs_io_context *alloc_btrfs_io_context(s=
truct btrfs_fs_info *fs_info,
>   {
>   	struct btrfs_io_context *bioc;
>  =20
> -	bioc =3D kzalloc(
> -		 /* The size of btrfs_io_context */
> -		sizeof(struct btrfs_io_context) +
> -		/* Plus the variable array for the stripes */
> -		sizeof(struct btrfs_io_stripe) * (total_stripes),
> -		GFP_NOFS);
> +	bioc =3D kzalloc(struct_size(bioc, stripes, total_stripes), GFP_NOFS);
>  =20
>   	if (!bioc)
>   		return NULL;


