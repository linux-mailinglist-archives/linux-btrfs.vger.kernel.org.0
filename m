Return-Path: <linux-btrfs+bounces-4999-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E868C5DF5
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 00:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8298D1C20B6C
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 22:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D85D182CB6;
	Tue, 14 May 2024 22:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YsaNwMWi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81A182C84
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715727426; cv=none; b=Nhi3Lxd+SDc8WE/Tv1HfEx3fKR5GWXfSkhx79b7lKDFBBF0EiQnGM3SFQFUseoNjL2O23rl+sRMsAQ/bj3ui5olcC8uEIGZz2Qhfap7CzmKMrhPGJodOxDjOenrr2WT15H8DjmZt70g0Vkusu7NANpnnC0OADv7snYHZIArXDXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715727426; c=relaxed/simple;
	bh=hphEyhyVwAYK+K11tEnwwTJo9VWY0DGTXtBXlpAUA3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pLdcq7ovMye1cqXiH1gqNPf4W8Vowy+iKPrmwT0xVEwuIKDq/BVbWXlLV/15y9Emx0HySt6gMmowpax6Ij5DluWLnpXgXizIlMqBJ8jG+N/Nvk8Mzxw9/7lV+FWNXRHcJz383EJg8YDiek6WoBl8+1dgSJuSk9L4XiHGIFN9WS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=YsaNwMWi; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715727420; x=1716332220; i=quwenruo.btrfs@gmx.com;
	bh=dgZ/Nh8CB1SlBlvkE2zlipVsFshfx2W7UcGqoBpr5Qw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YsaNwMWittiXHSFlkdKRbbtIvkTfwot/WrzGWaKI+b2hSkj1xKSsoXkyEv/vglrk
	 2frSFo7NacPGULJcn2NtxCi1axrPbBb8f4m/uS6O/8DZSSzyEzsYTRW6KEZFs4NTz
	 CViXSDcW2fBc7FLr/w0R3sL5lQAxblbNKh5m9vtcbZkhgMikXUIeZEpE7yq6hMmli
	 EW+xapqF9wjoaHkQvJKXcfhUtKRddWbJ8s8nQes4rd79mq+AdgN/P/iwmG47XOvq6
	 4gZSke4yJDVbc5gHipryEa4dYumU2JqLxnVtbdaTWJsxzIKmliawDVUTWdqtdmwFg
	 DVbYDFxxyaIeAgpS4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M89Kr-1sAbyS2EnD-008e7a; Wed, 15
 May 2024 00:57:00 +0200
Message-ID: <da0c6bd4-b3bf-4d85-a9ff-5548f01734d0@gmx.com>
Date: Wed, 15 May 2024 08:26:56 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] btrfs-progs: mkfs: check if byte_count is zone
 size aligned
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20240514182227.1197664-1-naohiro.aota@wdc.com>
 <20240514182227.1197664-6-naohiro.aota@wdc.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20240514182227.1197664-6-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:saz2k7AmluAoNfd0lX8L4DfHbe0D0mCrYtSZC29WviTbHOzIFSP
 ZM42T5WvtrgmYvpfed4zsCQ5rXrcA+9zfh0oJYwIMOQleE1V3C/+7wU5o8jHVctap0smNEH
 hTU+1BvvcTAhBbLJKLzEGgMEsclv+zeSPShr9zXkdcNyHmajqkKLQUF8VBfdiefuNi5WbOC
 M76x2TmiQVB/oLSg5FiXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RJ7Nldt+Tr0=;nYLFUrPyrt3viRz9FBt2HgdrxNQ
 83S6Bjk6KRamrweROYmdvAb3T/gCG7cA1EmzE02Ivxc2IV1mimOeSYWGi5Oe192kTMxq6xn6Q
 GYIOyqJTa8uQUXLv5INrF2FIBbjwhCcgUndmZI+iswXPg6iD/4ViSdMQYEX37WY664umqeD7E
 qqgmR1KbKnnOg3fWVxe86jkbLa6d9CvtNZBkM/Hczk9igfwPeZcFxED4PG7gzw0sKORpStCiB
 RNyp5CorNpBmvxLpHYsTbmHFqJXqLeO0kYP6zDnR9Y7GQ3UEuofCwOkaN4lXzf77Yy8aPUFWC
 yuTKrkcEXuSaVsGXDVsso+fw6xaGLPQBVNL++zS6VQDF1e0Jkulc0TWwN+oid+MKa1+DztBzm
 XSsr2LzZ4brNow2KXvPxCyHjLBsF7brY/CsfU93bDnqPONVtMNDlqg8jjfnZP7TsfIm4TU86F
 yPLApI4rKGfaw56zimbtmnyfwnRn4zlB7qfWnESGozGY/S2/w1bP0W75R2bUf5q8rf3xaINCp
 Tj5TsOOfeaaRT35l//cBWWV6eWF1ZvICIAO7LbeIYCoM+C6PvWJHUK7fyksDwYhw7/5PAxXoS
 Spsy3nEw4+UCqDGj0ySoQInv+W8Q/i3xNzSlMfaIL3fUlHbTHjyqnfS37wGHlGs+CHbZrZVy6
 LkRC/n0MfGDVtF+rxJL/lFa4wDpynyyyEyXvf1408nOvzWafXLam+PZ33Bx2mG8CYz6X3lr40
 5rn3+/Kg2hHgG6t3Q2qOYV9DF7hi+1inMKZTvp4J9pnoHRQXXgZ8XZ0k/xIc3tUgxWasMAnEj
 /OjTw6D3ZWG07jDItGVbMF/kfuH/UmymtCSFkPZjXrVlU=



=E5=9C=A8 2024/5/15 03:52, Naohiro Aota =E5=86=99=E9=81=93:
> Creating a btrfs whose size is not aligned to the zone boundary is
> meaningless and allowing it can confuse users. Disallow creating it.

Can we just round it down and gives a warning?

I'm pretty sure some users are used to just passing some numbers like
1000000 to "-b" option.

And it may also be a good idea to do the same rounddown for non-zoned fs.

Thanks,
Qu
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   mkfs/main.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/mkfs/main.c b/mkfs/main.c
> index a437ecc40c7f..faf397848cc4 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1655,6 +1655,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		      opt_zoned ? "zoned mode " : "", min_dev_size);
>   		goto error;
>   	}
> +	if (byte_count && opt_zoned && !IS_ALIGNED(byte_count, zone_size(file)=
)) {
> +		error("size %llu is not aligned to zone size %llu", byte_count,
> +		      zone_size(file));
> +		goto error;
> +	}
>
>   	for (i =3D saved_optind; i < saved_optind + device_count; i++) {
>   		char *path;

