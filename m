Return-Path: <linux-btrfs+bounces-1578-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E78583328A
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jan 2024 03:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4BA1C213AF
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jan 2024 02:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A312C10E8;
	Sat, 20 Jan 2024 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TwM942Xo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B77EBC
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Jan 2024 02:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705719482; cv=none; b=Sa/jguz0RYgLylf8cDbNmIziAW8OoZgeb3wBbZDyxbDdHPlZ5V4iZSORtnAik7N/bYYSIPGDjNoLposUrZ/UcWne4TgNaMnolKDxAsuadm3jqfjNmJCtY7W304AdZdGmplPSFEhLyZuEF/M002t3/SFUaMS6rgnDoirN3DWa5Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705719482; c=relaxed/simple;
	bh=mDAv9JjHqiFzZpLp/gJ1YG9clzfIqm9voCZUNv0Suew=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iPqdI7xjMLV5op68VlJS0JBBcnCiBQPNLfN7y301A2uhodMD2TcP+RwYj5KpWitNlmgzpv7WP2tHWoDRKYVDBQSc6xNtSpGaHTiDpVpYZH7CLmywvD4j72p+xT/62IP+gT4JAruhzmG7bC8SUresXP1PR2kI/OCObszsw5YvcOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TwM942Xo; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705719471; x=1706324271; i=quwenruo.btrfs@gmx.com;
	bh=mDAv9JjHqiFzZpLp/gJ1YG9clzfIqm9voCZUNv0Suew=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=TwM942XoAVESENq2f8ILhIQJiJ6H8BhN9R3Ry6ATBh5j98S8kh5BqRg99/koz1tz
	 KcfxFbI7BsPFIq4vhqCLRC+FbtMQA09Kel1zl6PY9471jJpFVxQhWkGzEF9CmkpMY
	 5beB7HegGrrkPfAZtk0akGwgUlml/wtMtXIigryz25TGw0qjzL0D4YzmaVQGl1UKZ
	 Vf+FbBrXCzcVpjWEjIPTf6AmaeBVKMSMiM9s4Y/0z36SiYwfggkzRq0KDDcpOAW9Z
	 EiUMu3M4qN85X+PkJvdgeSSlSgdzNXVTOCd13VgOj23QNi4npIfBJcV5dBwZHP9uv
	 JYFNempCTu3Y5RlLLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4QsY-1r1LBY24ak-011PCg; Sat, 20
 Jan 2024 03:57:51 +0100
Message-ID: <34a8f0b0-8235-40ea-bf11-8d29d987d9c6@gmx.com>
Date: Sat, 20 Jan 2024 13:27:47 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: forbid creating subvol qgroups
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1705711967.git.boris@bur.io>
 <eb79dcbe0cbfa7459b249f76818a5e5a08a42ea4.1705711967.git.boris@bur.io>
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
In-Reply-To: <eb79dcbe0cbfa7459b249f76818a5e5a08a42ea4.1705711967.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2KCrtuHc0mdm+B4q9agtJ4KiyFgnTju18waLCj7Wj49e5GDIoWz
 tTrhxTiezmpnrR6BOlHrGVgeK4gwUdQAmvJJoLkSd58SEpA2dQxB7o106gjkoIIdQ5XSKpS
 oyBhpSTa5mA7tXqqI9+p+GBhR3XC7vcd0QEDgyp3s2dm8Dce+Y9t06pRV6AVuBV4n+3EuTd
 a6k+C3vSlZOjqpAkmZHSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9JVVa+AlyBY=;DQawZjj0sfluQzgcoT/Co3xX794
 DRvekR97edOvVD1lB5gZWrafzdn1tY4ud+k8vOGkPKvsEq+GD2uH4p0UL0UC0eW9FHwsm8qkT
 INRVm9p8RAKfbOHLko2sXb/k9MzsqMTIe6MZTrsK2rFw8Es8amV/fMZL8r8B/vZ0X5IbCxjH1
 bX6pAc003nhlnuvH24txVixke9h7xwGdQjZYTa+88CBSnGrVR/RJ18rIbu3pajdeemdzDmqD1
 uXdGIpDI+o2Ncvc39t8suC1j+DVwdQfVAVvymloqzh01gHN3FyrDz0/t1AjyRNmTLcXCTCatU
 sNbTxl281+o6T5khwbzAtA0g5OeguP0gvg3KJtYkJgi9p94i3b+UonFYopp6W+KFhgYIMUYaL
 Cbz7o7A4Gh7GH+s3l0ct1CB0kMrGtdaO9PB9042HAWmk0xSV7/SESkVCXbQ98PRFYpGgzaMiU
 Vjl4soFe4x3MUaYWXdZ9YkiiRemXbUrLXDBEdPPFORbB49xu2QjgdWQgt211ItYeYtrAqzZ0i
 2LOupu2w11eyyLK7jfvVlYeeacoAYinNoZ4oh8VeP9RlfaM8g1j8lFLuaIAP13duILAY2rEUP
 +83K7m323oAP/NHi59DswKO8p+GWRp+WzmFLAKRPp3bWj2490HRss8XvfdxVvG5O4Dj7U1p5Z
 m2mt8jPbS8z3K3tjAdjz52lSgI8qX8c9KQglNoA0neCcDiI4T5NJ/4fOywL/Jscz0U5eKwLws
 NN4sqMbDfhRiWAlM0N2dA376Aq1cv4/O+8rE60UVy4WntwmlX/nr3AIOVgotKil7w/fr7/mhB
 hb/z5wpDVu5+GAyKPkoxjlo6u/Lqf0TMJfQa+H0FtfbaB781EIapk39T/wOFt0LZVE9T8rr7G
 p4ORjC8w6KD8CD3gu2v4kyS799GNONywyPkOL42q43KSziN20CanjEYCyaS9VqDj4kkPqyqfF
 zel9wCuNjS69wT680Q46Be3+UH8=



On 2024/1/20 11:25, Boris Burkov wrote:
> This leads to various races and it isn't helpful, because you can't
> specify a subvol id when creating a subvol, so you can't be sure it
> will be the right one. Any requirements on the automatic subvol can
> be gratified by using a higher level qgroup and the inheritance
> parameters of subvol creation.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ioctl.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 58e0c59bc4cd..3d476decde52 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3815,6 +3815,11 @@ static long btrfs_ioctl_qgroup_create(struct file=
 *file, void __user *arg)
>   		goto out;
>   	}
>
> +	if (sa->create && is_fstree(sa->qgroupid)) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
>   	trans =3D btrfs_join_transaction(root);
>   	if (IS_ERR(trans)) {
>   		ret =3D PTR_ERR(trans);

