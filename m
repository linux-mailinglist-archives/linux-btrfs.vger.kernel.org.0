Return-Path: <linux-btrfs+bounces-15828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C676BB19AC4
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 06:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FF73A8B4A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 04:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875EC1FECB1;
	Mon,  4 Aug 2025 04:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FMtQnn7B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B372113EFE3;
	Mon,  4 Aug 2025 04:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754281971; cv=none; b=gBs3J/zibFLXnp+qIjhuR8994YeG+EUQEREY8yHFfaUpHdIvBbxJf9Yvi9Oo6pezCx8LuJJwPHwq6uzKhd579bLEZuPVE35gLwqGJMPXclisKdm0pDEU2KF5yh5UMrT4BmEiPxzhtaC/DodPlbl4oVj7rHeDHIrpdcDOTVNM5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754281971; c=relaxed/simple;
	bh=9O3YYBFzcEYnANEOWK6u0Zut9o2SRh2RyGECT4DgcPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FeTKQicF+arwk6GbvFZ5zrpcib5K7T77vpoTveg5Ay/eVl4y6+6J6T66LVB1tOpeim73IcWyrOAQ7aqPJ/+12h9HwZ6VDAWQC9m6nBFul7Nv14hV25rJUeLxAlPiNLHSkJRv4D6Rucnwj4C2NiFyJkwk/Fjm9/WKwWOV45OgVy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FMtQnn7B; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754281959; x=1754886759; i=quwenruo.btrfs@gmx.com;
	bh=gE6360aq3IXHIh7m8zAFEIkTPZlHP6LL0ld6qS1VxB0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FMtQnn7BAZAbFXPwC0FSgz0DHDsOU48MUsFSXuigr77kLXI0F+oHiIW7OWUn7mEI
	 QSziavE70Xj5R0RU55BiIe4imrcepCpLyh3QmzB+BmFdrBrxoP4ZvYkHHQXDPTSIj
	 dW3EODf061k1AhyEaT2CIYgTwOkNbZ3OGvqEqDed++KJPOwOMWwZPa39WI8OVAPMV
	 r267Yb4yy+8W7d5TCLrTTWZDZwgNeUbzFoSUAPEeQouypC594k6BCoLJfobKye9la
	 HuEA/AvyIxIgsu2Us+uP6HW3Q8uMHesluAnraF8Q9xOYh6frKYsOOUjnBEKizGU7W
	 VAr6I7HXMHQguf5Kgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N49hB-1uaQtC0bLt-017LQO; Mon, 04
 Aug 2025 06:32:39 +0200
Message-ID: <1b7aa1de-a544-4387-b776-9816a5058f87@gmx.com>
Date: Mon, 4 Aug 2025 14:02:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] btrfs/301: Make this test compatible with all block
 sizes.
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <a8233808db2ee1d7c5fe7ee8710388bb0cb8f787.1753769382.git.nirjhar.roy.lists@gmail.com>
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
In-Reply-To: <a8233808db2ee1d7c5fe7ee8710388bb0cb8f787.1753769382.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:btigVA1+nFAk2I6yTuy5yQjCQ9Uqvn5vlbvHymrGqRg5n4dgA2n
 H9wJBQsVjao0AD0xkb1UIFDGu4wFVhs5RDv1V4QD00bi0sTRUw+wRdY1TSRMO9q195pA7BF
 x4eeu2mpJY4tp5RIwYTAHjKcNTPwojJ/Ma+Kcm+XWl6J9//ZFwy7usxwSm6iuMS0W7SNaF+
 D43IHasdsdAIF/nvST1PA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k3Z+D4aLL5k=;JaGC0jVbGUDPZJGR/1DA0Lz29fM
 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
 08ouUnuO+GjwtQxeB2VUfDY=



=E5=9C=A8 2025/7/29 15:51, Nirjhar Roy (IBM) =E5=86=99=E9=81=93:
> With large block sizes like 64k on powerpc with 64k pagesize
> the test failed with the following logs:
>=20
>       QA output created by 301
>       basic accounting
>      +subvol 256 mismatched usage 33947648 vs 4587520 \
>           (expected data 4194304 expected meta 393216 diff 29360128)
>      +subvol 256 mismatched usage 168165376 vs 138805248 \
> 	(expected data 138412032 expected meta 393216 diff 29360128)
>      +subvol 256 mismatched usage 33947648 vs 4587520 \
> 	(expected data 4194304 expected meta 393216 diff 29360128)
>      +subvol 256 mismatched usage 33947648 vs 4587520 \
> 	(expected data 4194304 expected meta 393216 diff 29360128)
>       fallocate: Disk quota exceeded
> (Please note that the above ouptut had to be modified a bit since
> the number of characters in each line was much greater than the
> 72 characters.)

You don't need to break the line for raw output.

>=20
> The test creates nr_fill files each of size 8k i.e, 2x4k(stored in fill_=
sz).
> Now with 64k blocksize, 8k sized files occupy more than expected
> sizes (i.e, 8k) due to internal fragmentation since 1 file
> will occupy at least 1 block. Fix this by scaling the file size (fill_sz=
)
> with the blocksize.

You can just replace the fill_sz to 64K so that all block sizes will work.

Just tested with 64K fill_sz, it works for both 4K and 64K block size=20
with 64K page size.

Thanks,
Qu

>=20
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>   tests/btrfs/301 | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> index 6b59749d..7547ff0e 100755
> --- a/tests/btrfs/301
> +++ b/tests/btrfs/301
> @@ -23,7 +23,13 @@ subv=3D$SCRATCH_MNT/subv
>   nested=3D$SCRATCH_MNT/subv/nested
>   snap=3D$SCRATCH_MNT/snap
>   nr_fill=3D512
> -fill_sz=3D$((8 * 1024))
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +blksz=3D`_get_block_size $SCRATCH_MNT`
> +_scratch_unmount
> +fill_sz=3D$(( 2 * blksz ))
> +
>   total_fill=3D$(($nr_fill * $fill_sz))
>   nodesize=3D$($BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV=
 | \
>   					grep nodesize | $AWK_PROG '{print $2}')


