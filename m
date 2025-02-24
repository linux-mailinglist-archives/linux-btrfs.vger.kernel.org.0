Return-Path: <linux-btrfs+bounces-11731-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CF7A416B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 08:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB7317009E
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 07:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B87524166E;
	Mon, 24 Feb 2025 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="i43eTKD2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC311898ED;
	Mon, 24 Feb 2025 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740383808; cv=none; b=bjNzOLh4OgLiHHiNOeE+A0H3ioHM7xiddVMPbUJ+Edez+5OOFldd5RrdDac7pSNGRLzn1uKy50ftjutFARgICFtMGHlGk2ID5+r+rnjFDcEy9VjvBU2273AvurTif7B95ZgDvW223jd4zMCD+JU+5RdOshKx9CSH+lv3G4VoDIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740383808; c=relaxed/simple;
	bh=hKdBOJbxvt7VJtTUJ3m4q02Ajt73HEcUMnlh4lI1uWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbKrnScQwWUUaXE1d8cHLUJ+DFcqUCL34+3Ode7f9DNc8Nv9dzE68tlpA8R0LGAfmIEN/RKxCejVNVR6UK9oSg0lMqxF8uZD7DieQE0iU7O6kuLuEiJ8wQeMYEJLTwnGJ49qrlYP6xKj61DqWRxUQJckCl2gxQrHBV1vV2CHhe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=i43eTKD2; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740383799; x=1740988599; i=quwenruo.btrfs@gmx.com;
	bh=nqmVyRReVjeJ6BDJSeumOoabKAEAeB/XZCTujfcuHrI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=i43eTKD2ng/bc+vfc3eevlhNLWQk8e709deP/Y8KK2ex5Tg7kuQf+dmcgguxIQMl
	 I4b++UwPCLAETw98SD9zcktEETOdsneyFBm8GlU2u7bYwQfG1sx4oxbFESkcPzEAE
	 75i4J5Otr7FMU2mKlQovH1QSL93gPzLR6UcY8u0C9Tcgr6hPGnWbXpStvCkb7DKCX
	 YODqkFawQSQBMSwp3xiTnd4gL0z+ubXobMhmQOHmAM9zdllewSJEO46MaUKSaIujK
	 7ontFpwdJRL1UskSn2ffD2gRRKSshe+AS8hk5mjLDHcDcMeB16qHsKCiiE9Ql3xGp
	 JMxtbOHszMai6rX7hA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MG9g4-1tVxaF1MOS-007BXl; Mon, 24
 Feb 2025 08:56:39 +0100
Message-ID: <cac35c18-0389-4012-97b3-4b8243f8752d@gmx.com>
Date: Mon, 24 Feb 2025 18:26:34 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add a sanity check for btrfs root in
 btrfs_search_old_slot()
To: Ma Ke <make24@iscas.ac.cn>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, jeffm@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250224075142.2959155-1-make24@iscas.ac.cn>
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
In-Reply-To: <20250224075142.2959155-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8NmEbpoU9pig/+op+iD4lkKBBhSwV8ZptO6Todoz+/MzOP53Ks8
 CzE2wH8KmDY0FP5+ZNOlu03RzoNxxUhi9mWFsMqliCtWIJnpei8EwegIz46gN1eqxwz1V0t
 S3rAccqQjgxo4YcRvp8PqGa9oUbmZQx/o2+Rg9EVt35/xQ2YbgIA9avZEfXh2WF/VCW4XeM
 34LjYecbkXhmpYPcOr5VQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NVQYyFINjTg=;GeqLE6GIjZ2CIDr93i825/JrWdD
 EC5eIcAPRUmVUkC5wDCY80QsDo1OlU271ArnTd7yRmzrcLxreHsKY4lBDZEsSh0AzCnLqSP2u
 yaRro4XrESxgtZm1UkpElxma75rQ3489s5hKwWu5d5V4R15vTLHIDXCHH8uxlWhd00mBeNFho
 nVqYe6efye099xIjFTCKuLgOKU5klBTCITQChXjn8eqqV46LJQ5DyOI9vE97lruxrgDfLBZ1t
 m3W1AsKgI9GYL33xhyJegpZ7JM1vES02PCdrxg44r2a12j+9roRrmRkrHf9YUJhz+OJ/smc1J
 9vJGFVsyWqfeQfVAToFcvri9vk9M+klExrOWqoM0oryvRPfZFkobeLeHIKEqQ2W2arTO4Kkzs
 pdUv9ekpGvh9j+CWCRn5DKsH46fwMUrjRlxOZ4ZhNSVQciLicgc49mUyvypw7E6iexy+3MScc
 YQzQAAF6gjPSRPO7W7c9NtG1gkspJXh3VLpTXzmG6PNg+qYNWTRFhAoF00w70yEpROD6/gAw9
 F2VPqjRnpDSzJFn5AU+5D3kdKPBrbGwgmNt2dSe+MhK4J2msRVLh2u0ogTu1bsM2xncfMP4H9
 pRuRJTD+Fd9iBXblF5A0iGilDO/ENSS6hIhQ0QlJBI7PyMVAPPSGNDVBPrgNG7iDT45mOgzqb
 hDJbtgu2i8kxb44OIeCXiFOb6lojqA4ddr9jCH2VXJxhvPQ6lg6+7fULsxhO/pSh8Fbt3xyh2
 o+MuoBd461rDUVCY/3+jXgpDvN/dCFKi36D0mYMx9wGnnrq+suAZzlW1VzqgFX9bQpgb0y0Pe
 BNttPRdAhjPqssWmzJMea6Rayq0BaSUQ3ICs+CVKwa5MyD5+BrRvTBJDmn5ZP9EXEPMZeL7GI
 rlttFdx7Ilvwmq5Nd7Qejiwc2FzzZv5gO+t6lIP2nyCwidwPFnTdb9E0Wo1bWhu1idea9BItk
 YlgSGVExTnMgqocAUDFRXVtNC/vMj+kNJ5VVfia5fy5JMDTelcOlAd9NdQXPW8dfwVYifjfQR
 gK6MNxTZCXdWSPD3bbRNQFw+5BPKHNMPtbuzVdMHeMM7dOpMX8YyKjNgAwNAHr5xCBddZpWpI
 swcCYG7AO2Cj9rRXVUG3NBnhDrqN31NwGQEwETDaH4tUOlxDiXn/GqK7TIwfrZTx7GHwJNk2N
 kqRkThG2/+BZQPD85fumWzADLM8RDTpT1hD2SSuFMfSX06aSCZcr4dos2/NAR6NbCrt4kHWD7
 oNqmyiUiSPSDQv5lixgxFamxiG5ZLYKnO6eiw89LKizrzGxFpuzhgMZ+/Freb5wpUOY1XQizL
 Jrxc882U4TWiU1NrzIBTXsV6bL72RZsbvQpke9Lz6eFF6fGf21fyHwAw7TmUc4WaeDwtvVicP
 72iWR8XT5dzn8U71Xg4XBbQBDyHykqXQLaWzQCnU7ZNLX/yGKiuDpX38V9



=E5=9C=A8 2025/2/24 18:21, Ma Ke =E5=86=99=E9=81=93:
> When searching the extent tree to gather the needed extent info,
> btrfs_search_old_slot() doesn't check if the target root is NULL or
> not, resulting the null-ptr-deref. Add sanity check for btrfs root
> before using it in btrfs_search_old_slot().

I do not think it's the case anymore.

Commit 6aecd91a5c5b ("btrfs: avoid NULL pointer dereference if no valid
extent tree") has introduced a check for the extent root, at the very
beginning of scrub_find_fill_first_stripe().

Thus it will never call find_first_extent_item() to search the NULL
extent tree.

Or do you have another case where we need to search extent tree
meanwhile the fs is mounted with rescue=3Dibadroots?

Thanks,
Qu

>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: 0b246afa62b0 ("btrfs: root->fs_info cleanup, add fs_info convenie=
nce variables")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>   fs/btrfs/ctree.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 3dc5a35dd19b..4e2e1c38d33a 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2232,7 +2232,7 @@ ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
>   int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_=
key *key,
>   			  struct btrfs_path *p, u64 time_seq)
>   {
> -	struct btrfs_fs_info *fs_info =3D root->fs_info;
> +	struct btrfs_fs_info *fs_info;
>   	struct extent_buffer *b;
>   	int slot;
>   	int ret;
> @@ -2241,6 +2241,10 @@ int btrfs_search_old_slot(struct btrfs_root *root=
, const struct btrfs_key *key,
>   	int lowest_unlock =3D 1;
>   	u8 lowest_level =3D 0;
>
> +	if (!root)
> +		return -EINVAL;
> +
> +	fs_info =3D root->fs_info;
>   	lowest_level =3D p->lowest_level;
>   	WARN_ON(p->nodes[0] !=3D NULL);
>   	ASSERT(!p->nowait);


