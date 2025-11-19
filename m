Return-Path: <linux-btrfs+bounces-19118-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ABBC6CA23
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 04:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22CC14EEAF4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 03:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295F62F2605;
	Wed, 19 Nov 2025 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="WHniEbyW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2032ECE9C;
	Wed, 19 Nov 2025 03:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523366; cv=none; b=CshLIrazRvjQPHQZ+iGHHViFaRD9xKWdZepU79yD9x56e8O0ZVLSbeJlvypg37TpF4qTcKsfqEL3t7DoxJVjyDb+YnvoYrICrWkywFNfYkIH/6g8rz2TADV780M3mpN7jLwFCQ616TyFesnz42vNBPRWxo/zJQc2Oy9INLoyuOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523366; c=relaxed/simple;
	bh=lTbPEcciA5uVqzsyVVgICdZCqSxEW8QNXj+P8G++cZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hl/bjRbOVpN/yTVTeceBDzznuydz8tGcOJ5YQmsdP9J/syIVbeDWa1FRsHZczthl9sTL/jCU89fJqGD7SY2CnAz5NhHEe1VdFOIFaMP858TMkkgzTBfjX1VrbSEpyVibFVmLNXkAVTi6DBbGyEx+SQguvEyc/MhzDD4HaXrmPyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=WHniEbyW; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763523360; x=1764128160; i=quwenruo.btrfs@gmx.com;
	bh=tcbpNb2/va2YkalPrlqyOP8fRVKrw2DWvB1q12v8b1M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WHniEbyW3Y2vYyqrgUEbOXBhlUvt43LB7cUfZRCMJucAdjxOCga6VKDaWnvd6eGv
	 mT+CZGngFOWfCPfZ71ygJ9C2xnZs2RysevueAk1H1mKLRUtl0Qn/cAKLvBGXl9NoS
	 PuV9P9oxTGMdwalNMKvOZWEnTwts3Ce1vJs4ysUMRXJyEf4OFj3AoQUZ03v5YnLOP
	 KFotFy56KNcEJqPf3ScrDjZk8Wqxvu1rbWm628QXM0Gmrn4/zYmFbI96SJuNLZQjy
	 uloFqfu9R9CXU+ZmH8wmp+H9K6E3Fm1A4HFnKLR8ssMxhrXVqRZOvFFn/OG6o5zEV
	 qD/uhStBOVKYgwN8xg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQkK-1w89MN3SQi-0150pS; Wed, 19
 Nov 2025 04:36:00 +0100
Message-ID: <c2e01ca2-6f1b-446f-a72b-1c1626c1e5ca@gmx.com>
Date: Wed, 19 Nov 2025 14:05:57 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] btrfs/339: test receive dump stream for different
 user
To: Sidong Yang <realwakka@gmail.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <20251119024034.23861-1-realwakka@gmail.com>
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
In-Reply-To: <20251119024034.23861-1-realwakka@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZepjwZh1ifUKa/D4kc7tFdM+ujEigRFOLd/8rZXO0ElHxc6rX5j
 6DKxJDbZ3ptTRi3Nz+UtGfs8LcenVhygn1fgGTmySDj9Nw4R2f9ZeytgR1CAo8cLbSFdUjL
 3mJgn85cZ4FmTutidH0s9BFupEaBw03cBCMV9QHPCgEP6l7Aeu7HHrZLr5lqkLR5NOAUWml
 rR1WqOaum4jHu1Up7Ey0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RKpaZ3KtWY4=;720TREHBq966bkh7FeqlYBtqVsS
 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
 7OhWQVLGyUSDDDwetLT3vRhuVAqW0BvLFetGPT



=E5=9C=A8 2025/11/19 13:10, Sidong Yang =E5=86=99=E9=81=93:
> Test receive to dump stream file from different user.
>=20
> This is a regression test for the btrfs-progs commit cd933616d485
> ("btrfs-progs: receive: don't use O_NOATIME to open stream for
> dumping").
>=20
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>   tests/btrfs/339     | 32 ++++++++++++++++++++++++++++++++
>   tests/btrfs/339.out |  2 ++
>   2 files changed, 34 insertions(+)
>   create mode 100755 tests/btrfs/339
>   create mode 100644 tests/btrfs/339.out
>=20
> diff --git a/tests/btrfs/339 b/tests/btrfs/339
> new file mode 100755
> index 00000000..728f3d9d
> --- /dev/null
> +++ b/tests/btrfs/339
> @@ -0,0 +1,32 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Sidong Yang.  All Rights Reserved.
> +#
> +# FS QA Test 339
> +#
> +# Test btrfs receive dump stream from different user
> +#
> +. ./common/preamble
> +_begin_fstest auto quick send snapshot
> +
> +. ./common/filter
> +. ./common/quota
> +
> +_require_scratch
> +_require_user
> +
> +_fixed_by_git_commit btrfs-progs cd933616d485 \
> +	"btrfs-progs: receive: don't use O_NOATIME to open stream for dumping"
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG -q subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/sna=
p | _filter_scratch

If you are using "-q" to suppress non-critical messages, you don't need=20
to do the _filter_scratch call.

It's better just to redirect all output to seqres.full without "-q".

> +$BTRFS_UTIL_PROG -q send -f stream $SCRATCH_MNT/snap

Furthermore, the stream file is at the current working directory, and if=
=20
the test case is interrupted before "rm stream" call, the file will be=20
left uncleaned.

Please use $tmp or some location inside $TEST_DIR to store the send=20
stream, and have a proper cleanup function.

Thanks,
Qu

> +chmod a+r stream
> +_su $qa_user -c "$BTRFS_UTIL_PROG receive --dump -f stream" >> $seqres.=
full
> +rm stream
> +
> +# success, all done
> +echo "Silence is golden"
> +_exit 0
> diff --git a/tests/btrfs/339.out b/tests/btrfs/339.out
> new file mode 100644
> index 00000000..293ea808
> --- /dev/null
> +++ b/tests/btrfs/339.out
> @@ -0,0 +1,2 @@
> +QA output created by 339
> +Silence is golden


