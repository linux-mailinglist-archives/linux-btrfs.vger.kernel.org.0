Return-Path: <linux-btrfs+bounces-6253-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A13928F82
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2024 01:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075481F237D3
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 23:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD011482F8;
	Fri,  5 Jul 2024 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cGfvqe4Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D93A8CB;
	Fri,  5 Jul 2024 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720221691; cv=none; b=arGcJGOTNCd57+Q6/hd6+tBCohY4npNbnABfQ5b7Oiju+4ZO6gDYNeuY/l79hdFk+YgnFMICwOx3kOWRiXC5r/XTAZOKGc5GRSbLev+3v/ME/NfC4xwm2ib/imgdXsnxG8xd/4r14PTcRIdkDXvGDBR8ljvRbb03olGk5IRWDd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720221691; c=relaxed/simple;
	bh=LOe2Z72EIm+tOb/pESk4k9MG4DYjxpMhFDahcxMThS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVsFR3YsL/HPsbB5fdeScI0bhwZ5c/LqFYUXNwxXbVu2Khk+3IVxEQMp9KYOhiAcYbT6ljFijcnietYV0ZV5FTtNhFpNzqpxzU3fvt2B6eHxXwjUXSee+WPY5vYxF24/3cJc0jLcJYlL9C7otmG/ABiuo0XrzBHIsBl7UzlYKxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cGfvqe4Y; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720221664; x=1720826464; i=quwenruo.btrfs@gmx.com;
	bh=WftoKQljMh0r3RHPf/O6mEfQD9oqFKHrIKyqr8HjFRI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cGfvqe4YnXoGnDxxSRQ/QATsg85hrO3U+YjeJHgIED+MU2f/eV32ujSe7bVUxc0+
	 p98uV66cvsM7LbQH8hoHI28Mb99Q8YL0ca3FCUGq9/dcjcI0v5BZ/4tVZhRU+m8Wt
	 2mrJX/NfF6pZwioXYaQTpXgPnYmokl9AHIPn+xl3uKeQrfdCbm9fZY+13AOoxPCFY
	 zXLq2MjCu0o8AZOg2NqmFZGWacIJWJbtX6jP5SZbsEZcxZ+N0/FAOqQQFKXp6PiZZ
	 u8KwnhrXUe1TWhUrFWnLAJAzphfKWj17cUa7pMORQNX/iB4k2Q3PHBXZ3QRu36nJx
	 6UvPVN/f3e0zJibPyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1Ycl-1sOUFw2Kux-00EiOF; Sat, 06
 Jul 2024 01:21:04 +0200
Message-ID: <cbeec10c-bdee-4609-b796-db772fe1543c@gmx.com>
Date: Sat, 6 Jul 2024 08:50:59 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] btrfs: rst: don't print tree dump in case lookup
 fails
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
 <20240705-b4-rst-updates-v4-2-f3eed3f2cfad@kernel.org>
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
In-Reply-To: <20240705-b4-rst-updates-v4-2-f3eed3f2cfad@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8beNpm1LCQB/aQkrSTEsV54urb2O+PN7lBffXN/dV8RkVICQB5f
 5/5SqlIUZwFzDpu8v5cp1uU3Znj45y9K8y6n32QSBu20AOMrLA9eh0baNty0XLb37IEaoJi
 BEk8ai98P063bScVBUJGeNfYFTgTQJY31gVm34DbPPZDqa9KtZlnTwQu/7LCIylbyWCc2mG
 a8Q6F+MlPyCYlogMiMFVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IGmYIj+qv+E=;g8ip4M5I+jwGdnHBcu9Y8Iful/u
 tuQS0OX0nsyX5WldXXa5Wlg1okJJ5sLzOEeuy/Tycb2Edz3QXoBoSbKperl/maLV7l6D4FIwn
 IsX+YvZ72j0bkfLxFU+tgHQzAnei4QHhBPEfnIqYTe86GtzpHbxv1/33YUoySyfh/yag+3Sqc
 /ENPE6PfimHcb6A5lPFAiYFp7+bd3iJ+EJKyXLrd7tivGhkK1TxJoq2usQQCk0yXv9wWKFCO9
 8JCPPvt1xb9Z0OVVNTgY7NcY18vktNmLg9HB45J49+wJHUox2NovMMgzxrs7NKFMRBUlzjguY
 NRrp8Xn+N3lYWXuIxEaPMdLByYQCj73ufCqqu/TUT2jC0gb9TOpjVzSnM2EEUYHrOpg48Oy1k
 Om769b/aRhEsM7d/QZlGC/MaI8wDmxXPo1q5pQBl0eW1u4GBAY0dkv36ciuW+6uFmndusTQhx
 KdtLk0vFgYmEizyrAsSZJfIeUPEDLrqFa9VFDTccnHhylG1LlP2G7Xup/zaaW/dJ80jaoUD+B
 13gA0LaeCf6GsslfF6pFekCNRFg0j2L+Kpsc5D/WDXs2PjD2mNArvIcHkeseEzqqFoc52uSVw
 1b77A44zl0YoJWWd+egliih3ZGXyHQCxq0YPNVd+N6KVh120viH9NqpBEEuxgeIlMi5sxut3z
 bxOyl8PeX3Jx99C6LZSGGJeYJNdETU38KHtTI5SYGlRiZFg5/AKfUuqQJWpscTYHEcGBJrgY9
 tFajm5biPE+CM5ApTsz2sfN3zraPxm7aVkV743Wbs79FdnGyq8Z4SvX1KGerNPhiZRrEAzd1n
 gd0Bwa6UkkJzviYoXE9k72WVBUgJhSV3np6RieSZRAA2A=



=E5=9C=A8 2024/7/6 00:43, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Don't print tree dump in case a raid-stripe-tree lookup fails.
>
> Dumping the stripe tree in case of a lookup failure was originally
> intended to be a debug feature, but it turned out to be a problem, in ca=
se
> of i.e. readahead.

But why readahead is going to cause problem?

IIRC the readahead is still based on file, in that case it still needs
to go through the data extents, then rst mapping.

Thus mind you explain more on the readahead problem?

Thanks,
Qu
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/raid-stripe-tree.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 3b32e96c33fc..84746c8886be 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -281,10 +281,8 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_in=
fo *fs_info,
>   out:
>   	if (ret > 0)
>   		ret =3D -ENOENT;
> -	if (ret && ret !=3D -EIO && !stripe->is_scrub) {
> -		if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
> -			btrfs_print_tree(leaf, 1);
> -		btrfs_err(fs_info,
> +	if (ret && ret !=3D -EIO) {
> +		btrfs_debug(fs_info,
>   		"cannot find raid-stripe for logical [%llu, %llu] devid %llu, profil=
e %s",
>   			  logical, logical + *length, stripe->dev->devid,
>   			  btrfs_bg_type_to_raid_name(map_type));
>

