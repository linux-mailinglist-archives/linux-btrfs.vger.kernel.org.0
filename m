Return-Path: <linux-btrfs+bounces-20494-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5297DD1D712
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 10:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47A443088DDC
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 09:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE533815E1;
	Wed, 14 Jan 2026 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="roD4WXX3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DAC37BE98
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381535; cv=none; b=spVTofND9kOZLri8u8aV8tkSxSp/4f+HS9A1trZYCHlKjudoelhYceTk0MDZPxK6JhrbfQR1Hrna5fE1S8dVPY+rYuz3OEuOsixm0/Qmp2xC/2a1hPXPye6Jl7nl4HVjfexiszm/7/RB4dXL5b2Ti2V9DZ1IaZ6Pg7rSJRIH/c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381535; c=relaxed/simple;
	bh=gnsfI3PAkuzsTBwQDD1Kyw5papivJCsajaFwyHEh3dI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q02GB2vusqJ3AIOYcmoTsFl4/IynJMkAURTSyR3mYfvqJbosqT2x8ekanPFrubknb7XcCEul0G9E/gts9xCoU24kiyIh8wYCW28jMguznbqLHCWnoYIPB52T8thrwGpo6OdX+4jY5qQBXfhASuJH3eCfhc9o3lnRJ2w3MrFpc1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=roD4WXX3; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1768381530; x=1768986330; i=quwenruo.btrfs@gmx.com;
	bh=7Ski+i2f3MJJ88wTcRni8LXi5cj3HbYjIEnk5Hut6tk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=roD4WXX3zc51dbxcdr5jaJHdO8PMnlQH6fmQByjcRUjpaus4kH5PhswpX28aVGhC
	 Ozs1NNBAGGhbiFcMUvXvOHF2k6CX3kKhELbCK7BNNHSZnKclX8eZ5D+/LyRKheSKo
	 fXlupS8vkbMCRjpa993zZhtDQ68lF2jNG6pYaqq+Ypav36m6FSquA8ZP7iFKdYWiB
	 3HKOsSIrOHKfLsr4BveL1uscRNAqkKibKt6iXjIdYsTDbOZHAaHonSnGl+MK9QDD6
	 6mr9H+uQ+d2WgIxGVc075sDkaRcubtVg+bkTEobDi43wiJmmnbpA7ESAfQuEthuzI
	 Kdn3uyBstSwT/F3tLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYNJg-1vJLjM17I2-00SvDW; Wed, 14
 Jan 2026 10:05:30 +0100
Message-ID: <5f0be70a-6c52-441f-8226-16007c72bbe2@gmx.com>
Date: Wed, 14 Jan 2026 19:35:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use READA_FORWARD_ALWAYS for device extent
 verification
To: jinbaohong <jinbaohong@synology.com>, linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, robbieko <robbieko@synology.com>
References: <20260114011815.327601-1-jinbaohong@synology.com>
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
In-Reply-To: <20260114011815.327601-1-jinbaohong@synology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SuMg9V1sC8Kila2LRki/ftHIHQySgp9bve7hoOmrei/WUTPvz23
 pCQU2LQ2IVOrhpgloeBAZjEsCE7Ut2n44JLFSi09Ks9EGM9N8crKJKGnJer3h+4nEbKkDBw
 +MsJHP7upQvBkxV0vIessYmAS3a6zxuZsvlaghM+1gyZ1UDbTF1hwMQXI9yXG3VW+0//4qp
 c2RIFkqiPuEOsMwKjJl1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v7raknWQE9Q=;m95Ig36OzTQ/Py2OsZx7XsNHCZT
 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
 IQ2cV3Fk=



=E5=9C=A8 2026/1/14 11:48, jinbaohong =E5=86=99=E9=81=93:
> btrfs_verify_dev_extents() iterates through the entire device tree
> during mount to verify dev extents against chunks. Since this function
> scans the whole tree, READA_FORWARD_ALWAYS is more appropriate than
> READA_FORWARD.
>=20
> While the device tree is typically small (a few hundred KB even for
> multi-TB filesystems), using the correct readahead mode for full-tree
> iteration is more consistent with the intended usage.
>=20
> Signed-off-by: robbieko <robbieko@synology.com>
> Signed-off-by: jinbaohong <jinbaohong@synology.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

And pushed to for-next branch.

Thanks,
Qu
> ---
>   fs/btrfs/volumes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 908a89eaeabf..6bde24292aeb 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -8025,7 +8025,7 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info =
*fs_info)
>   	if (!path)
>   		return -ENOMEM;
>  =20
> -	path->reada =3D READA_FORWARD;
> +	path->reada =3D READA_FORWARD_ALWAYS;
>   	ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
>   	if (ret < 0)
>   		return ret;


