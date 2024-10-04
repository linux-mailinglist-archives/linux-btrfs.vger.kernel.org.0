Return-Path: <linux-btrfs+bounces-8544-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1701B98FFC9
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 11:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2941A1C21B96
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 09:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC77148FE6;
	Fri,  4 Oct 2024 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="WCFIQQWY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A814659A;
	Fri,  4 Oct 2024 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034305; cv=none; b=n49JPK//A4FNhiiAnZu/VnkrEYf5oEk3iBs5gMnYMl3fsxvADkh+lQyf2aLkpi5+kYjCep5MkQrvvTC5Vf9MnekXnsASarQzwa+dNVIgWokgubwJrEqba/D58dZxDQ6OVDA0XjCaCMsn04zhbKxPZ2nTOks3cvDhvdg3MWena74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034305; c=relaxed/simple;
	bh=QcPfL8VlPw1/3JPPl86kHToXIZaFpsrmxa6kEyNSvWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIqmzETmYeIi/Z1DonmgBmQo0Pydfq6blMWqKIe7rigz+mtKDGSQreI0biXysVOs3l+/uacD9+/Msy0yXs9emPdruMXfoPf1b04fNKW3Q0OXJJBO3KuuDAjst4V3nQkMRsUtUVOiF6J8oM3KsPju8jO83H2q8mnv8A15HaRpN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=WCFIQQWY; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728034287; x=1728639087; i=quwenruo.btrfs@gmx.com;
	bh=CO4EzApxDb9XxFzq2gigjIa+SUyXhHbhvqEJdAHBQb8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WCFIQQWYN2YduMoPz26cjucwadc5e2k6eJFHiucxzEIpBsoe2oKvIrg0zQw6CWYd
	 0esr7nrdjyrA4+FIvpfmk0oUVIQyQWkKdUpjL/AJNX04hFVwn2gcipbZTJmTG0CO8
	 88DfSwgv4yoXVGGeoC7HVMM8fgs3mgFZyAkenWNK4PotyDgVCrDhh63HNDNX2HHU8
	 sIByYA+hEZ8E32vd390tpBfL31WMUc8MAd03ZwctcTgofpwr0SonPj2JDPtO6i52W
	 5VZem09Nm8fy+z+ExsJIgz9UhTMl4/fIbvxlspQKFTZxURHsQiX7VEhYW2LjjGETF
	 yDfLY41F6ELZhpJgyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mkpf3-1sAMjJ2Np9-00iEhI; Fri, 04
 Oct 2024 11:31:27 +0200
Message-ID: <2343fbbb-30f0-4802-8039-8b9e9de72aaa@gmx.com>
Date: Fri, 4 Oct 2024 19:01:22 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: don't BUG_ON() NOCOW ordered-extents with checksum
 list
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Filipe Manana <fdmanana@suse.com>
References: <20241004092337.21486-1-jth@kernel.org>
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
In-Reply-To: <20241004092337.21486-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vgqKnDNL8JBq4wRwcBQ7EGb+XSXYsJoKoStasfgk80gKCS5frOB
 C1OVIAroe0Gvq39+NoQL2q7l0J95zxnWqppwsN0p+2bPSMce88RkvAjQx52qNB6HYYgeWc5
 QV/8V8sAdF3GgfS2uQTO+w4w1i9BOaAfeStInlFTXY701J1PpYC5WYRDec7dObkM9va7ulZ
 SrElmzxd5YKvzqVzUWDMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XgGBv+iPE84=;5+e7tsPwQMvS2PjD2l5ZdQxDUiR
 iF524F6m2Yqq2iXV1ENnMUtEYFepsKCUUZdC6FYtN6xOsFNiEec56JyYxaav8nKQwIVU8dtk0
 qzIgP0oMSACc8Caus6ZLpVK4TI3aiYdXpx8PNTbUJxPvG2yG+MH7A25ot0KiejwKM/ssuyEr4
 /z0NYzpsLRGmfL+t5H3J2m8Le5GgNjRvBk2oMCih7ZgrbKsY9TqZNYeN5Qkop9HcxrwFUXkfF
 /iVBr/sstkfRo1jaI1OK0m1K3uwfthwBWYxqe0AkpBkDO9Kf7Ni7Skoz2LUJ71JheFsbwuDKB
 YkjMsHG+zuuLE8WXl5ZCFzprTYtk8rr74RYWfA1uJMd0oVzopBwqThBEEpEs9Dc3fmgp+HpKu
 XN2DGwcwqUNrj81Sdg8vL1XX4uHXeneahqB5RtHqjchqtj9tBw24rpMmo0xiMp4/cL1XfPE9L
 lYeRnC5Fcr3rx5xRE0CXAGu4lPQL20d+rpxMbJkKdNabv+lAxSKaJf32fom6ruTw1N60yyqd/
 etYZm7D8pbAKpiq2cpltRDzQbpi6kIOISsi18eNY8fywF3AtkROZXD8lz36Q8iv6CPgmhaVv3
 BkiW74EC+ZqA33gr9jEWzzGUU9CvpJI+nR7YPAkQ1EdZP7EmdB3XC2hdDETBDQyfHPjYk3hu3
 EB2iB2vHq3S3ZGXXtLUIXaK0LDuwuFCQnMbvl4W1usPcHVNzDl6IbTdmPUfQROsmusn/6H9VQ
 94LOuZzfjoe6IwQUrRHRcQ1xzLT3zGDhUEIs8qHVj9SK3L6jX5ee9vCvUtVo/MWifO58F3RHk
 vKwP9Lfk7MDkdICS14c2hpZQ==



=E5=9C=A8 2024/10/4 18:53, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Curretnly we BUG_ON() in btrfs_finish_one_ordered() if we finishing an
> ordered-extent that is flagged as NOCOW, but it's checsum list is non-em=
pty.
>
> This is clearly a logic error which we can recover from by aborting the
> transaction.
>
> For developer builds which enable CONFIG_BTRFS_ASSERT, also ASSERT() tha=
t the
> list is empty.
>
> Suggested-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/inode.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 103ec917ca9d..19ba101dc09c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3088,7 +3088,10 @@ int btrfs_finish_one_ordered(struct btrfs_ordered=
_extent *ordered_extent)
>
>   	if (test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags)) {
>   		/* Logic error */
> -		BUG_ON(!list_empty(&ordered_extent->list));
> +		if (list_empty(&ordered_extent->list)) {
> +			ASSERT(list_empty(&ordered_extent->list));

Will the ASSERT() really get triggered? We just checked the same
list_empty() one line before.

I guess you mean ASSERT(!list_empty()) instead?

Otherwise changing it to ASSERT() and btrfs_abort_transaction() looks
good to me.

Thanks,
Qu

> +			btrfs_abort_transaction(trans, -EINVAL);
> +		}
>
>   		btrfs_inode_safe_disk_i_size_write(inode, 0);
>   		ret =3D btrfs_update_inode_fallback(trans, inode);


