Return-Path: <linux-btrfs+bounces-15363-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE7AAFDEE4
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 06:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F751C24FF1
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 04:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE0A21421D;
	Wed,  9 Jul 2025 04:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NwRxChgA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419951DFFC;
	Wed,  9 Jul 2025 04:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752036365; cv=none; b=e7HrbfKrZ13Q5NRlROFqW8G7WTEoTgkPe6YRKiB8ujEwYclBG5kc7iaDZlv6q7q6coY1jM9+jGeBdURAAnHSfUm8WvQZDPBZVn3wkOtwlPr3Jky5nheYlvgSvqOpL1EddA3m9+Jz/T9GMi7pz59xcHXdYYeydCKE6AZAyDTH33Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752036365; c=relaxed/simple;
	bh=kVgC/OimL0raqLg8MqRU4Il+s7K1s5yG80o3vVuZ4aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdbAQP1N/JX22YO1PauGGPvl5ivgUmqsuDjfE4VZHSHZ+232byzcWeNs3QI8NfVL2T8458rXk2+m4oclvpfDEkC0+S6iNn3Tj/EEk95fclbvlOp3c68nOr1EAjhjSg9vhgy3gTWLAHo86Ai/hbCmjs17/sDjY+RiUGv6Sq2PBrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NwRxChgA; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752036361; x=1752641161; i=quwenruo.btrfs@gmx.com;
	bh=ck38GN2Wls3qiQ4UwcGXNRshRkrsfurgc4TnkBhwO7Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NwRxChgAPLpiS69T6bcaveARL8i8NHeK72Eih9Moc2pE9oLRU4NxDxYzz1UWsRjk
	 NPuuwLddPMzRkhAUSTK8tGhNd7Ic3yP7pqc+mPi/txpCETIQGYpRdn7dp9yRWLld2
	 LFgsaM1YfKLLMxQYQ2/f9rnnflBpnzRaZwfuq6BjN8Msp3Y8+fyX24vyIZtm7qiQe
	 0xcUBUWZu7xMxwy3wnw2g1E+1utwCHAOlxDQV1HZPnwgJ7n5RRpgi4TiBQcnSg2r4
	 KcG+Q6mog36c4PRrdhpXBjaZBcOND/w4kBgKxRjvUJeyqQpO37mNx/xd78s3PfkqK
	 bSAeRTrQt3oyqMv/qg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHG8m-1uUuj2398q-005fQw; Wed, 09
 Jul 2025 06:46:01 +0200
Message-ID: <1ab3b61e-bbca-42e0-bb97-9bdd5de068f3@gmx.com>
Date: Wed, 9 Jul 2025 14:15:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: generic/042: increase filesystem image size
To: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <05033925fe12eccf80c07396edb9acc8e1cb6778.1752035731.git.anand.jain@oracle.com>
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
In-Reply-To: <05033925fe12eccf80c07396edb9acc8e1cb6778.1752035731.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IwRwmYsKxsXG3m9cHCaV30Gh3U7rUugHVXvLvPb8/LSeSfmUMZB
 PTNGA0F/STdS+KJuhURQpIhXFX6o3lXRcU8OCftUqpZSmwdVitQspqqaM5rzjyX96sxUG85
 i+IYxx3J8m2HUDXxBsKQlYZd0ZcY1VrI8/0zgfb0fT/JG+bv0jyH+UDL15iyaQonP6+az2u
 iOpMBd0gUy+R7+9BWR2BA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iqpdmikyR1M=;sQ/N9YLgdtjbhTZCBehPGZ+cN2D
 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
 EVYcSJXYgAg==



=E5=9C=A8 2025/7/9 14:10, Anand Jain =E5=86=99=E9=81=93:
> During testing for shutdown, I found that generic/042 sets a size of
> 25M, which is too small for btrfs. Setting it to 128M.
>=20
> wrote 26214400/26214400 bytes at offset 0
> 25 MiB, 6400 ops; 0.0468 sec (533.618 MiB/sec and 136606.1900 ops/sec)
> ERROR: '/mnt/scratch/042.img' is too small to make a usable filesystem
> ERROR: minimum size for each btrfs device is 114294784
>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Already submitted:

https://lore.kernel.org/linux-btrfs/20250625232021.69787-1-wqu@suse.com/

Thanks,
Qu

> ---
>   tests/generic/042 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/generic/042 b/tests/generic/042
> index ced145dde753..6cd2e7a3703a 100755
> --- a/tests/generic/042
> +++ b/tests/generic/042
> @@ -26,7 +26,7 @@ _crashtest()
>   	img=3D$SCRATCH_MNT/$seq.img
>   	mnt=3D$SCRATCH_MNT/$seq.mnt
>   	file=3D$mnt/file
> -	size=3D$(_small_fs_size_mb 25)M
> +	size=3D$(_small_fs_size_mb 128)M
>  =20
>   	# Create an fs on a small, initialized image. The pattern is written =
to
>   	# the image to detect stale data exposure.


