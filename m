Return-Path: <linux-btrfs+bounces-6063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E65E091DBA0
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 11:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EFA31F2286E
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 09:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04A884E1E;
	Mon,  1 Jul 2024 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="s3BeXUtL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A084A27;
	Mon,  1 Jul 2024 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826769; cv=none; b=caz3YTHj7KzTAyjGrFVhXpD0636aBBoUv+8hIihAKaGgztr69meNmZ+8JlWf44rc3sSlhe0acVVC5n3cXqJKwsOWjyldOe0Y3Lu+fkh+9ruJqhxTeXn5YDRyxJ2bE5QW50mp3PznfJPNOqmLapL5OCt6bcVk/JzQuQviocrFcX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826769; c=relaxed/simple;
	bh=QsYc8n2IxjOLB0t0HAzLzyWLYsk4k//+7wy2gJMPejM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWQtDHExZWjRuf5yCT9GlBXw8xjkdRXLAqPU3mKmdSdADU7hrxEMUnFO4oHgV5b40IrGUtC5JmgiRUG9T6FFkWwKsGsWTZNZozgEtDaG1fLep4ACB/w/j6p+Ea5HpSwY+2RuHU5Xt3uSmYwin5Kbz1LTHL3J8RVTk1OQmWPHx90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=s3BeXUtL; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719826750; x=1720431550; i=quwenruo.btrfs@gmx.com;
	bh=CTASRdpITXu00IwouRg6+blAjOOZ/mTB1UHTxDkP5AQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=s3BeXUtLeB7MnnqWXeHPhUC5t22zpbFOQKJBglAMz+uc8Ruoi8qE6SObhGPzD++a
	 wmzJzTA0rdZurIVfdqComgjh8BFW3vl63kYTksTEIM6491Rfpp7mWO7ZATC9tDSYL
	 P5X6DspSnPgYwbEfMSnZB6+PkiyhvExidUK+8StEGxmrClR05VD2mU1zJO+irdEC3
	 KBugObXIcFLGn5Uf7F/HF8fuGKmFwN836HZeJEBi4w6a7gRT+V+d2l1lN3VpWfE7t
	 CWU+2BTXR5yWRcNGQy+XkMciCxOVubkhqyxZ7iMcRcpTsUQeeq/BZor1iuDtX4wWV
	 3nLpBU++aExupoNdSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mwwdl-1sCzGo46ix-00ypyX; Mon, 01
 Jul 2024 11:39:10 +0200
Message-ID: <6e1e07e1-e885-4afa-b88f-1213fdcd621a@gmx.com>
Date: Mon, 1 Jul 2024 19:09:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: update golden output of RST test cases
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>,
 fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240701080109.20673-1-jth@kernel.org>
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
In-Reply-To: <20240701080109.20673-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Abs/sxOAJV5xvjoMF4MsFAXmeFSvNMqj++GWOkNAP3BkVYojdzE
 hpCsCUVxcdzBvU9KOyMaL7tmWwKQ1YGLZl1SyuoHyU514uByAdc5ek66lRzyLP45vVkKbIj
 VtnYAeiANfYTzCggcElei/yyezNATB+l2Hw2fNqUL65ZYfPKu3IRcgsWrP9EBWB96e88KVH
 FV9s5Uxk/LGGurF+xPlNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BuEc5fVobAY=;IQAD4zcEEpr8wBb67+innKalYCE
 9sYcjgeimfhbCDt6IIkBR/GiBqGBcAt6S6wJAwd2I1rZhLBpUqXrDXOrbOh+DsBXyqlqdTcA0
 dGfHZ2XnR3w9f7zGWv0TREkTmc5ackNVrKcUVvCjcio9KhEYsaBerIRr2vI5DJtMFnrAnQKID
 95IXAAzvpnTLpgdnp9+uMH0raudPXAPSev4orao4ebkByBkkKYu+kO5pSs/UKrWoM/P7g185a
 MLAYIns5uUduNsqL6j+/DJtYMGvdNPHQFh+/eqUnlWxEVvEY3489A4RXAq+lqozUllf4sfTR8
 nPv/DveWzE6EWo48Ta7bakaW/Sya7Qm0XakewWQt7/5d2GHx9wW1aNf3vtk6I/s+u1KCqexDh
 pEn7LZmGhFBfLA7Pa+CEoxmkBUG1sLqiCfBAfh54BAoychyrxnRipM8VXMqAAR5SIMQdHX7S6
 r4Fl3V87a20W7tFcoTY7j+DIE4YB7eTX64lv7Yf5W9cnI5+FhgebcjZZKzuT/Oayt1wsli5hy
 +OVBFULNgb4VsEBmjpRDpGSTfx082RDeJBMeDwi6WsFJ1KBv/9iJgns094d9kon15QNoYS25P
 ajVFLA4st/QSHWfEF3JbHDUUMVWBPhpTNHUg8HolJ2yUi7tkNwlKZTZK2rDYV0066OFAGnzpX
 EzP1eipJm8LgG31SumMYhe/xOvLalBSW2nfsi2GGQ6fyVL54cZYZpwBfjjjU0vDEQUnnNjHP1
 vRFcEvHhw8Bp02KhKiXTjxhzSvXslHB4d9U7tI+6kjZq/rU+DBeZSkvdsHwaCHogHEAd5zGr5
 fNgMwyLPtD35Dm1SDDZ78tEojNTYr4kq0lONX2T1Wh5wo=



=E5=9C=A8 2024/7/1 17:31, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Starting with kernel patch "btrfs: remove raid-stripe-tree
> encoding field from stripe_extent" and btrfs-progs commit
> 7c549b5f7cc0 ("btrfs-progs: remove raid stripe encoding"), the on-disk
> format of the raid stripe tree got changed.
>
> As the feature is still experimental and not to be used in production, i=
t
> is OK to do a on-disk format change.
>
> Update the golden output of the RAID stripe tree test cases after the
> on-disk format and print format changes.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>
> Changes to v1:
> - Mention the kernel and btrfs-progs changes mandating this change.
>
>
>   tests/btrfs/304.out |  9 +++------
>   tests/btrfs/305.out | 24 ++++++++----------------
>   tests/btrfs/306.out | 18 ++++++------------
>   tests/btrfs/307.out | 15 +++++----------
>   tests/btrfs/308.out | 39 +++++++++++++--------------------------
>   5 files changed, 35 insertions(+), 70 deletions(-)
>
> diff --git a/tests/btrfs/304.out b/tests/btrfs/304.out
> index 39f56f32274d..97ec27455b01 100644
> --- a/tests/btrfs/304.out
> +++ b/tests/btrfs/304.out
> @@ -12,8 +12,7 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
>   total bytes XXXXXXXX
>   bytes used XXXXXX
> @@ -30,8 +29,7 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
> @@ -49,8 +47,7 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
> diff --git a/tests/btrfs/305.out b/tests/btrfs/305.out
> index 7090626c3036..02642c904b1e 100644
> --- a/tests/btrfs/305.out
> +++ b/tests/btrfs/305.out
> @@ -14,14 +14,11 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
> -	item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>   			stripe 0 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
>   bytes used XXXXXX
> @@ -40,12 +37,10 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
> @@ -65,16 +60,13 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>   			stripe 0 devid 3 physical XXXXXXXXX
>   			stripe 1 devid 4 physical XXXXXXXXX
>   total bytes XXXXXXXX
> diff --git a/tests/btrfs/306.out b/tests/btrfs/306.out
> index 25065674c77b..954567db7623 100644
> --- a/tests/btrfs/306.out
> +++ b/tests/btrfs/306.out
> @@ -14,11 +14,9 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>   			stripe 0 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
>   bytes used XXXXXX
> @@ -37,12 +35,10 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
> @@ -62,12 +58,10 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>   			stripe 0 devid 3 physical XXXXXXXXX
>   			stripe 1 devid 4 physical XXXXXXXXX
>   total bytes XXXXXXXX
> diff --git a/tests/btrfs/307.out b/tests/btrfs/307.out
> index 2815d17d7f03..e2f1d3d84a68 100644
> --- a/tests/btrfs/307.out
> +++ b/tests/btrfs/307.out
> @@ -12,11 +12,9 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>   			stripe 0 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
>   bytes used XXXXXX
> @@ -33,8 +31,7 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
> @@ -52,12 +49,10 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>   			stripe 0 devid 3 physical XXXXXXXXX
>   			stripe 1 devid 4 physical XXXXXXXXX
>   total bytes XXXXXXXX
> diff --git a/tests/btrfs/308.out b/tests/btrfs/308.out
> index 23b31dd32959..75e010d54252 100644
> --- a/tests/btrfs/308.out
> +++ b/tests/btrfs/308.out
> @@ -16,20 +16,15 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
> -	item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>   			stripe 0 devid 2 physical XXXXXXXXX
> -	item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
> -	item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 24
> -			encoding: RAID0
> +	item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 16
>   			stripe 0 devid 1 physical XXXXXXXXX
>   total bytes XXXXXXXX
>   bytes used XXXXXX
> @@ -50,16 +45,13 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 1 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 2 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
> -			encoding: RAID1
> +	item 2 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX
> @@ -81,24 +73,19 @@ checksum stored <CHECKSUM>
>   checksum calced <CHECKSUM>
>   fs uuid <UUID>
>   chunk uuid <UUID>
> -	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>   			stripe 0 devid 3 physical XXXXXXXXX
>   			stripe 1 devid 4 physical XXXXXXXXX
> -	item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
> -	item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
> -			encoding: RAID10
> +	item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>   			stripe 0 devid 1 physical XXXXXXXXX
>   			stripe 1 devid 2 physical XXXXXXXXX
>   total bytes XXXXXXXX

