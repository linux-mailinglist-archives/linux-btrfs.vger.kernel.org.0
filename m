Return-Path: <linux-btrfs+bounces-15827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3988B19ABC
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 06:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EDD67AB05C
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 04:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7646F1F91C5;
	Mon,  4 Aug 2025 04:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sqQ7HeXJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F52C17BA1;
	Mon,  4 Aug 2025 04:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754281696; cv=none; b=oMbiZAQRo92TkPm4izmMxnNYvaSRHHTK+4YAuvr9uPjkvZNR2amqLINhYnjXQMszqiy+lJnA6pAavRPcdUWHUvCQ/JCvklb6j8LN8sEv8LiZ1qmibmVgAz3Nunlk7E+bv0DMuYXykjxb8A8F0blcZqZBjhMhVMrNBqMCrHAzgjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754281696; c=relaxed/simple;
	bh=4fInMS2aC4kMRyfxTTHHy26veYrgh5wiW4zjf0+j/9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amYZgjMt2032hYCQX/mGPDeqoxWqPHu/PY5hgh911fCpSY5gKWi4kF5FmQFdbUujR9NPqxgeol+BSBkn+ACrF93bzo2+vOt8+2SfYKQRSL9+XAj7lUnJ/iVlrjlFs8ZW1hKYz2HwPz539uRi/KfMmrjF52KQLqQgfOtkazZ1fzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sqQ7HeXJ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754281685; x=1754886485; i=quwenruo.btrfs@gmx.com;
	bh=i4W0n453AoeTx1f+sEDwVCW2DYgrWNR2x+S8xYYb/iU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sqQ7HeXJ/J50kCgGr/ld/3P2yM9LnBfcT9wDl8xodAMsl10w/X3sJKRVfmzbVQ5u
	 0MLFpcItDEJNjXP2lvVK4PSSPhWW6WgSZRifXsNUqJVR+trZ6Ht3ey2LuuhfNsbcf
	 WtR+TwoAWj2gaww98Teb05FcvtdYE3Qo24VCKRpjSIP5lpDxyjFDsks1PLMViVD+y
	 ghLaBR4pqPrMtmwYmpCD1FH5OLr+tTh5oNsVNf7loHHN6UqdnV6dlsrxUv/JJA62E
	 6cLmQYXdU5ED2fE4Nxv052oqHW8WuexjZLTYrX4jbYSj1UKa3liaGG0owm7teoBpW
	 8c8Usv1suh9WLWHpCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2f9b-1umujr2dlX-008Rck; Mon, 04
 Aug 2025 06:28:05 +0200
Message-ID: <d1b32c8f-6d9b-441b-85c4-3a4b6b91ce15@gmx.com>
Date: Mon, 4 Aug 2025 13:58:00 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] generic/563: Increase the write tolerance to 6% for
 larger nodesize
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <f48538de3ce4a98a2128f48aa0f005f51eb552ee.1753769382.git.nirjhar.roy.lists@gmail.com>
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
In-Reply-To: <f48538de3ce4a98a2128f48aa0f005f51eb552ee.1753769382.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nryolHMN4Br3g/X6MYQrmxtqoA6v1WKiye+cpFmwONlWmvTNP12
 uFm4/sms1Krv/MpyjdBT04E0t5rq7PoP9sR/rJ0CGd7oQiTm8cgvBCUoZ3p/Y6P7DVJA13z
 4DExZ/t5PIzWm9jp1edcK6an0QKA0YjlAfFDOBccC/A5itSQWIuMswpfh2ln0fash+dxYy+
 durrm4URpcHFZyVyVoVIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xG6uGAOkPQQ=;R+MfA2Y9fuSK1nxoSwpsQwpcz7n
 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



=E5=9C=A8 2025/7/29 15:51, Nirjhar Roy (IBM) =E5=86=99=E9=81=93:
> When tested with blocksize/nodesize 64K on powerpc
> with 64k  pagesize on btrfs, then the test fails
> with the folllowing error:
>       QA output created by 563
>       read/write
>       read is in range
>      -write is in range
>      +write has value of 8855552
>      +write is NOT in range 7969177.6 .. 8808038.4

I can reproduce the failure, although it's not 100% reliable, and indeed=
=20
with one tree block's size removed, it's back into the tolerance range.

>       write -> read/write
>      ...
> The slight increase in the amount of bytes that
> are written is because of the increase in the
> the nodesize(metadata) and hence it exceeds the tolerance limit slightly=
.
> Fix this by increasing the write tolerance limit from 5% from 6%
> for 64k blocksize btrfs.
>=20
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>   tests/generic/563 | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/generic/563 b/tests/generic/563
> index 89a71aa4..efcac1ec 100755
> --- a/tests/generic/563
> +++ b/tests/generic/563
> @@ -119,7 +119,22 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $bl=
ksize 0 $iosize" -c fsync \
>   	$SCRATCH_MNT/file >> $seqres.full 2>&1
>   switch_cg $cgdir
>   $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
> -check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
> +blksz=3D`_get_block_size $SCRATCH_MNT`
> +
> +# On higher node sizes on btrfs, we observed slightly more
> +# writes, due to increased metadata sizes.
> +# Hence have a higher write tolerance for btrfs and when
> +# node size is greater than 4k.
> +if [[ "$FSTYP" =3D=3D "btrfs" ]]; then
> +	nodesz=3D$(_get_btrfs_node_size "$SCRATCH_DEV")
> +	if [[ "$nodesz" -gt 4096 ]]; then
> +		check_cg $cgdir/$seq-cg $iosize $iosize 5% 6%
> +	else
> +		check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
> +	fi
> +else
> +	check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
> +fi

Instead of the btrfs specific hack, I'd recommend to just enlarge iosize.

Double the iosize will easily make it to cover the tolerance of even=20
btrfs, but you still need a proper explanation of the change.

Thanks,
Qu

>  =20
>   # Write from one cgroup then read and write from a second. Writes are =
charged to
>   # the first group and nothing to the second.


