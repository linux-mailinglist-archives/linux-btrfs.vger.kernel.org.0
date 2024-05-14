Return-Path: <linux-btrfs+bounces-4994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADEA8C5D81
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 00:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E321C21400
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 22:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0122C181CFF;
	Tue, 14 May 2024 22:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="odmRRyN7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0715181CF2
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715724722; cv=none; b=bIfp7whIDodPoKOeLKg69f5gwWusyZPud+D8jSW0Kg8XP3E3gafxzTh7mFLZaZIqq6JNt0MaD3Su30Axi2gwuJ96HRvIl1pMmQad5b48K4P/j/5za9bjZXFDg9AwTp6dFNLjyNp9t1U4+Ox8X+ntBRyZsNqbfyZyKKSDMEBsMUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715724722; c=relaxed/simple;
	bh=3fGhdMUS9AyoqiZwQFT/GUbN0IgGfLd5Gsp6AQOGezs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uNSoomzsjJXD+fOCP4SDVC2Lqw6lVMJSksbCa4IEMn55UpSzrGFd5Y03WgMc2EV717C+1O0dLURuqxDEEE1HyrYLNEn863Kj6VLliBaAenpSnbCVTVOY+7EWgJNq3uLG+sm3+Cvy+EGmbLlQDnJhqzWSSsY444ZQbxhsAA0uypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=odmRRyN7; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715724713; x=1716329513; i=quwenruo.btrfs@gmx.com;
	bh=UkJtOmsfuR7JHLKjXBn13s2y9pKThkCLBMsh3gQAD2k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=odmRRyN7/xaVJEDlcJOiNnNc/UUwAarBtTQZtcQpw+KPRoeQ+dEym9NNGRvCriCO
	 h+c4oJVaeX5stkPCWJtaUwt7uK7mnEeMoN109giMgi6YSzSd6gknrkipD9NioFX9E
	 uxBGQXGqZkGkAnvt0AcDbB6MU4iBJnXtYsZpUxLwMzw/EvuxiLPkF1qvPFRA1VA1D
	 aUJOIs57hVZaYdULNjIrikZCETxlhNBChz70s42xwQfY8Y2N3AftyK/HcMbEglU3/
	 6y8wS6tMXX6CeLc1F6RprrYMrgJow5y+2UrPnhzaCk/O/8nZ71b0Rx5GqS+YhWb/O
	 zXukS4rKKw3ocqG6lA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4QwW-1sXico2kTu-011VrL; Wed, 15
 May 2024 00:11:53 +0200
Message-ID: <02516600-8a12-4fca-be4d-80b445646c08@gmx.com>
Date: Wed, 15 May 2024 07:41:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix function name in comment for
 btrfs_remove_ordered_extent()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <4a9fa14f2211dfc080061f65c2b95b718aa608fa.1715689538.git.fdmanana@suse.com>
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
In-Reply-To: <4a9fa14f2211dfc080061f65c2b95b718aa608fa.1715689538.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0H0GLHu2Oz625lIKIUk5Glg43pVeV/cXc5P7nQlDiGgb3QFY/8v
 W1imo4ftD5ju19MbKvgZws1I5ClSgs8zjv2UNusCw1O1kieXt21GAWhSJUwinytXC4RPByM
 ocAKCxKl8buwM1A9xypHbZvKjVNz+oOmUUHWQ0RWTx48rqOkPAk5F+9MoPiR+/YTf0jznTe
 NqCsRBoRHTuHiaR1j2HjA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nio3ngTGQHM=;aS3he1nH69XhfcvkhpvgzpQvPur
 DleytJ+5MBzsiRlO+XpIkzhQc8F4p2+1OShvRtrKH3WQwbq7wvepAtoIeXpk2AuEVYTAu0k41
 hJ2QBVghD96CUb73/GursEYs1azevp0P0PGGVTHZY9rVLmfO+GIBv/jE635GG/BxXuBbnI6K4
 MkACUTRb0wdgxbFsSzgWRSxF24qdRKwEnfSHh7smw9eOTQ29dIDt4+vSTVD72aq+yd3YA6W74
 yoj2QYq24XH3KOsGWWqqvvvyIJOG2yWdzkAQzPV70k5ZyjuoyM9fQjxbTDIR1zP7zOs97QfmZ
 c3cq+EdoaiAAlHRbpZIH5SG8/+wP6rCzMC1tRDKaT8QU1WUoATigkXPhzn7yKoM3CpXKJhG+V
 Q5Pn3XrVqU5QoqvVE259v4GRZ0Lcj6eneUB3BmOLryLH9xUcJz2wo8orF4wKMk8pffgyDQNuS
 /3ITligJzJ1u+kI9F0mpyhi4cGUV75uX0BzegHSHDC+pmsKHnFsdoKUL4Xr+cJxJrn2LmVlE7
 epK8LX0cmt0cuA4lVGjGx119LHNIOG/TAxUMEbwx3lfqM0p7lsuVLnSE5Kd8TqGdPk4GZByPe
 MnbUWwWPUqvFBMLXQGe6mV1iK/4rZ1Q52SLo3NnvQhIvk8tCehraWgI50P38vHVdsBxlTntCG
 fOFwaOXwH/oTE/n0w3TQWPsUY9ElAlJOZMve0iZ0OG847bsz3b+A0EeGhKUMmLf869fToE4wk
 MBRpOjEADQZAddMNynmGKCp4xx4tRDE+V6jwh0gzYOGD4e4PnhmMheBHxoI2i/ZiXtTzeykJm
 y0DEwnzCXmEqdct4nOiDMG4JP9dALqP+P98De1h+e5Ba0=



=E5=9C=A8 2024/5/14 23:56, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Due to a refactoring introduced by commit 53d9981ca20e ("btrfs: split
> btrfs_alloc_ordered_extent to allocation and insertion helpers"), the
> function btrfs_alloc_ordered_extent() was renamed to
> alloc_ordered_extent(), so the comment at btrfs_remove_ordered_extent()
> is no longer very accurate. Update the comment to refer to the new
> name "alloc_ordered_extent()".
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ordered-data.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index a6c2b4e5edf1..d7c59bf924fd 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -595,7 +595,7 @@ void btrfs_remove_ordered_extent(struct btrfs_inode =
*btrfs_inode,
>   	freespace_inode =3D btrfs_is_free_space_inode(btrfs_inode);
>
>   	btrfs_lockdep_acquire(fs_info, btrfs_trans_pending_ordered);
> -	/* This is paired with btrfs_alloc_ordered_extent. */
> +	/* This is paired with alloc_ordered_extent(). */
>   	spin_lock(&btrfs_inode->lock);
>   	btrfs_mod_outstanding_extents(btrfs_inode, -1);
>   	spin_unlock(&btrfs_inode->lock);

