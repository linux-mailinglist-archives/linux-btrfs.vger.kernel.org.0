Return-Path: <linux-btrfs+bounces-16265-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC269B30A6D
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 02:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBDFA07D4F
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 00:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F936DCE1;
	Fri, 22 Aug 2025 00:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GdyI0fnd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CA028F4;
	Fri, 22 Aug 2025 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755822775; cv=none; b=NL1XI3OvnBANCNM6sYbQdZcZuSuVpQ3GpPQG27Ct4esS0lX6mFVqIKHNM6Zez+ybvM+LrTWZemElh4jQ5qXI8vqDtB0TrOEHfSWqrrqKIm+Blx9udS+gXdm34/M27avkjeTbUEz6CTAw5STc+TFIB4P9LVaWvXSKbtaZl21O/LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755822775; c=relaxed/simple;
	bh=sFiM0SbUSCE/c0BYix2JiUJiEVX8mAMWD3rDjPvxvJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lSeUJKqqgjuRNLsTj8KWO5XPoKCVJr21wNIGapeks/Q2+rn05k5mK9krmJOFH1z12XupHdHLrEmJ/tAJvAR5E+G9h0wvIhZQfSkcWJMSRwsTxIdOkXrCZFjnSK4copsCMGYLXxagU70x2k6Lxo/5Mye7SZJ5WUtre4xvnxtEQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GdyI0fnd; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1755822766; x=1756427566; i=quwenruo.btrfs@gmx.com;
	bh=3lpoY4fou6E9O6ga0GKO6kv0rhaYDEQMkzQq9GSIMz0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GdyI0fndRjXs0E46MXbr8D9DOt0Zso31dOE9o/wy9hfexXxMGLbQXIEKkeYS8qRK
	 BjBII3p+ksSXKeSe/0YBjcSAaiO9JdAB5Q5SxF9SokbnsD2ufDbMsA/iqJbBHPFvW
	 HYKxjvOFUDszgAt9y7D7/7ukmzqhg74pqSj8VxTzt+B64TbucsjZuQU5rlrLYLBdT
	 si+gC4B/F63foJ8icJQ+xHiAuRwffJ+/xFZd+GyHlUiP2c1A5C2LT0+5ievSxpIlF
	 LbSaJknVpRfZenwZkdUc0vTYFrohSCqE61ItUrFLlZ22no9zb6zdUlWJwB3KVUPXT
	 Hkv8+HKU390JYM9yQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKKUp-1v7Bpa2YJz-00XOdW; Fri, 22
 Aug 2025 02:32:46 +0200
Message-ID: <dd02704d-61d2-4ffa-8785-7c8d4fc6457a@gmx.com>
Date: Fri, 22 Aug 2025 10:02:42 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs/301: test nested squota teardown
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org, kernel-team@fb.com
References: <af8736b1-e85a-4867-a884-194fe8f9abb5@gmx.com>
 <49ed1733eaa2fcc3a9ec3f6cd8544016253d6914.1755819214.git.boris@bur.io>
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
In-Reply-To: <49ed1733eaa2fcc3a9ec3f6cd8544016253d6914.1755819214.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LqwHZQeAmTSH5qxmFt0tu8YaCJT0yrmUrE6aDl1QXWZz+WF2kle
 fc9XFQrO8B8ReiOAHQBVHvmFeWX8rFIJVncj2P/v2w5PhuBhjSRp3GbQJdH2NnYjm7A7Ikp
 OHHmZf4nNT+WTyT3CHvC/mS8w78qmlJ3vUH23Yr7URMmERDgUqeXGxIVWoZmY/4W/4sPSo0
 wxWtWyoxpi7CArUWvgjmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zIdsfufYINM=;Pyqp2RVxU6Kj0EVCP/s0nI9Q365
 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
 yym/JjNclkhwfor6KNF9jz7zswyD



=E5=9C=A8 2025/8/22 09:05, Boris Burkov =E5=86=99=E9=81=93:
> Nested squotas with snapshots is the most complicated case, so add some
> extra checks to it. Specifically, ensure that full tear down of the
> subvols and parent qgroups works properly.
>=20
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/301 | 9 +++++++++
>   1 file changed, 9 insertions(+)
>=20
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> index 7f676001..4c0ba119 100755
> --- a/tests/btrfs/301
> +++ b/tests/btrfs/301
> @@ -21,6 +21,8 @@ _require_no_compress
>  =20
>   _fixed_by_kernel_commit XXXXXXXXXXXX \
>   	"btrfs: fix iteration bug in __qgroup_excl_accounting()"
> +_fixed_by_kernel_commit XXXXXXXXXXXX \
> +	"btrfs: fix squota _cmpr stats leak"
>  =20
>   subv=3D$SCRATCH_MNT/subv
>   nested=3D$SCRATCH_MNT/subv/nested
> @@ -393,6 +395,13 @@ nested_accounting()
>   	check_qgroup_usage 2/100 $(($subv_usage + $nested_usage))
>   	do_enospc_falloc $nested/large_falloc 2G
>   	do_enospc_write $nested/large 2G
> +	# ensure we can tear everything down in the nested scenario
> +	$BTRFS_UTIL_PROG qgroup limit none 1/100 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG subvolume delete $nested >> $seqres.full
> +	$BTRFS_UTIL_PROG subvolume delete $subv >> $seqres.full
> +	trigger_cleaner
> +	$BTRFS_UTIL_PROG qgroup destroy 1/100 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG qgroup destroy 2/100 $SCRATCH_MNT
>   	_scratch_unmount
>   }
>  =20


