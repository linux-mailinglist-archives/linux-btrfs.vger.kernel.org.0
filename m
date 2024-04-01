Return-Path: <linux-btrfs+bounces-3809-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF74C89396F
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 11:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D476281F6F
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 09:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434A5107B6;
	Mon,  1 Apr 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Cl5MEPgz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE134D52B
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Apr 2024 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964035; cv=none; b=ZN1L86fYeuo2m9R+XUVgGu0elrhC7OZviPw+b5+LEBF89YCTD93UDk+lS1rt82LUUb7lnxj7a+F4qtamDBlbJeehIO7SWXW96erkrWggFuHtCiI6GufQ7tDO5sQt8UcMAda5n+XIcB4893pQ9f//aW3D9t5ZCAhWWkcBVAM2oQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964035; c=relaxed/simple;
	bh=YWbuAWEsyK4VVOMTG2E+dBhut3Yd1Zoubs3ePQEEFw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVchr/hA2vPycBSPZe2gdB43RXtJvhsv/yT0vokBTXd2Z0aY2mxz1ekCwhcV2HQwsCGht1iG51Mw7r1V0lBTEDqTijzV9p7zP6MzKqPuKuKrPAhUI8KUhuEEF0UMGGMA9YhT0xdFwFZ/s1GuMB0VFkcde2UbFMUfzxNNapi3b0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Cl5MEPgz; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1711964029; x=1712568829; i=quwenruo.btrfs@gmx.com;
	bh=KxSgWj9Ep5oU7G6wSp6AX+12R4/97yeh4JyKJ2FzdCQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Cl5MEPgzo/PflH6bxIetRSqZj7chli1FanjMtu3yZGW4GENOdNbBlCsDI9TxZAV+
	 ZJcW4bD/7VxVgV8/13iP7854AxiUdLyxbx5SWkT2+tCUzY4zci7nzkk688lP8Rhey
	 hlPW9RDSMUUFM+Jz7x3RjV6xV9ueSM03V3ZfcI/OdPxfLC2X0EgQR9uUnNdTTw8tL
	 KxHQ1dRruDCD/yJLFybdCflAICUxEvCQMh+Ig9RXAFp/etpxbAGta0Hz93T9qP1WE
	 G7Kn+qAS2BZVootmw9G6YX6e1xHursWCCGt45gA82zzU/FOsNMwp94aAXtNIDq2Bq
	 +9GPwMJmsFlJFd3M9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpUYu-1scb0S2VLw-00py1O; Mon, 01
 Apr 2024 11:33:49 +0200
Message-ID: <fe43cdf8-69ba-48c7-9b84-b5464828747d@gmx.com>
Date: Mon, 1 Apr 2024 20:03:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] btrfs: Remove the experimental warning for sectorsize <
 pagesize
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linux-btrfs@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.cz>
References: <cc79c6ab354931b61a2dbd3900e253877b78913f.1711959592.git.ritesh.list@gmail.com>
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
In-Reply-To: <cc79c6ab354931b61a2dbd3900e253877b78913f.1711959592.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nGfxrqLT7S/3iYhPHJI8oUo37e2j/A8kspgetwTFCassH9xN+h1
 VdPBzcZAPIHFUbb9go2JKuQtgsKRFbYrG9RNs9g/pTjOgXS7jrM9Sjkb4T24Tm8u1v2j/ai
 GwzIIWxvfXDERDVDKGTQk3KnMAvpoPVVdB2KlJxDxeNP8KHZa1RwCwSXFXCW2hisiQo7R9r
 h7N+kxV4QTQQR4a/X9+UQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oiDXnRznpts=;FnqU6V1CcU/nsF3z4LbTOrcJ5TG
 nOuSqzfivEZyIJWB7Bn+QaZX9l8XHp//diU9KK/Q89lsFlwQsJD/Kdhj3+kgXETTGs2W89Pfj
 YlboJPJStUYa4Sf05AN/x8wubqWc9x9EYpFI7/pD/B5Nsqwvrz4W9Ovu2Tg4hKTaAhBSuAW/v
 8Hihqc1Sk++AXhU5LZ2YEirxy0/O+PAbMQkaVer6SjJ9JPevmuS/mljcxYUo1h/FVSoBEUR7u
 /oxUDT/j4av/BTIHHNrnaRgYaCfDowQ4HUMu5c8rzXeCZLpWy610SFfJyuIEKmY0Y6EP1zrJk
 vMNj3cI3MDb/KRBJO8n7U6soZ/25R+/URB0O96H9xQ40geYnYOPc80qo49p27GgnL5P1Whvox
 iUQx3ABY669SjpeewEKUmgDvuD5sGvkd3ciVCAWsqwTZuwUi0o7LzbR0JTJWsugiPtuDRslCC
 v6wE7HcdAHuqpnSH9XqVcp6BX+tJIFsyH6vYBVo/h9Ve+73qNLRqll1W5RWD/Pwg4LkM2thHi
 2KRI4JcrTYE9G3Q1urxZws/sI0FX7CUcbNiZ2v7ZNVhLbEkkDfmy3jQz8V4T84Qkh8q/KxjZz
 DfLmFwPJQYuBBIHw6anYNGDZqFmTAoAtEsUCliAIy7Oa9aEHykgoOps/iXR+LPKPdhP1mjPcp
 rdZhQW+Z5yZqPsv8hq2NxHl++MqXppoI9IQMUekrLEP9I5S1CywIVN8SiSLA+nE4W8S/EpuZo
 85Xm7KoXllAtGzn9fydNtfTJ2N1p5p+wjxMgQSFVMdoy8y0CvFKnS/LQi0d1WeyTCWO0gGWbE
 4r/hMTU2fuVC20MxUEcxuspQXdCMjsNTVrKRKP7208u/c=



=E5=9C=A8 2024/4/1 19:53, Ritesh Harjani (IBM) =E5=86=99=E9=81=93:
> Support for sector size < pagesize in btrfs was added a while back
> and btrfsprogs has been defaulted to 4k sector size by default.
> This also means that btrfs has stabilized sectorsize < pagesize path,
> so let's remove the experimental warning and make it a info message.
>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>
> So, I see portability was one of the main reason for the switching defau=
lt
> sectorsize to 4k [1] and also sectorsize < pagesize is considered to be =
stable
> enough for the switch.
>
> Given, that btrfsprogs v6.7 has already defaulted to 4k sectorsize, can =
we get
> rid of this "experimental" warning msg causing confusion among people of
> whether their data is at risk?
>
> Or do we still consider this experimental and in what way?
> Also do we have any unsupported btrfs features remaining with,
> sectorsize < pagesize ?

The remaining missing features for subpage support are:

- Zoned devices support
   For zoned + subpage, it's going to crash very easily if we have
   multiple separated dirty ranges inside a page.

   The fix is already submitted, waiting for review:
   https://lore.kernel.org/linux-btrfs/cover.1709781158.git.wqu@suse.com/
   https://lore.kernel.org/linux-btrfs/cover.1708322044.git.wqu@suse.com/

- No sector perfect compression support
   Aka, compression would only happen for PAGE aligned ranges (both
   start and length must be PAGE aligned).

   This is going to be improved by patchset:
   https://lore.kernel.org/linux-btrfs/cover.1708322044.git.wqu@suse.com/

   And based on that, I see a chance to support sector perfect
   compression.

- No inline support
   This is also related to above patchset, but it's a less obvious
   behavior.

IIRC that's the reason we still consider subpage btrfs support
experimental, even if we have quite a lot of subpage btrfs users from
Asahi Linux.

Thanks,
Qu

>
> [1]: https://lore.kernel.org/linux-btrfs/20231116160235.2708131-1-neal@g=
ompa.dev/
>
>   fs/btrfs/disk-io.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index bececdd63b4d..e4eff84e1d83 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3350,8 +3350,8 @@ int __cold open_ctree(struct super_block *sb, stru=
ct btrfs_fs_devices *fs_device
>   	if (sectorsize < PAGE_SIZE) {
>   		struct btrfs_subpage_info *subpage_info;
>
> -		btrfs_warn(fs_info,
> -		"read-write for sector size %u with page size %lu is experimental",
> +		btrfs_info(fs_info,
> +		"read-write for sector size %u with page size %lu is being utilized",
>   			   sectorsize, PAGE_SIZE);
>   		subpage_info =3D kzalloc(sizeof(*subpage_info), GFP_KERNEL);
>   		if (!subpage_info) {
> --
> 2.39.2
>
>

