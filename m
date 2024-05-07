Return-Path: <linux-btrfs+bounces-4819-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508968BEE34
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 22:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF14B1F26E9D
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AF9171AF;
	Tue,  7 May 2024 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AfTqvCiv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6A043AAD
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715114405; cv=none; b=VLthB7UtuU4Zg0xEcAHpTscg/oH2vmGNVFZvoI8gwVrkU9wV260DXtsffhpzwB1DhJ38YaySpjf5LT9/nRlkOIIHKiap1GJeiaHaO8/VyAUIYtD1x2dKce+vkDbSE6S8IzpmFTlcQOUPQyUEbXbiLbKza+cpTGF4uxXkpNIQAqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715114405; c=relaxed/simple;
	bh=khS6b4nB6psz8Vc6BXdoxz1QgSEZzlwq8hWGlwH8LeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jGGmgE8oCIQrnGIENlDQtr9wrXCTfFXujhwGBXQip+hD3ZULr6TOO4IakTjVGtOzpJxvKWiBQFh+Um9EVJKvUT1P0/IUyL6UcCiGmpfGId64onV7WMuSrJBNK+2cahNDsa1vzuQ8OeenAoFOgRxWjCpId/FqHjRJuUFM9hWTR+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AfTqvCiv; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715114398; x=1715719198; i=quwenruo.btrfs@gmx.com;
	bh=JosG1vsOpy1BowssHngZgucCFdgcxr91GU8okSM/ZlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AfTqvCivc2rgrsLBRKCYGL0mJ9Y4Pk059jJXJ9T0cHBwTnRb4W9VEkqMpCsbqmSm
	 KHIEjf/KpZBdEDOk/Y1cIj9iAAcRedvItWJozmrBy7hBLnvgK/c6W+Jav1HumCoXl
	 oU7o0R7ofUmj1H95imHl3LfC+YydbFixy4o+4H/9j4e+ZLzBINBPfvlk4rqF9xW80
	 lS8UUp62uSy/jyGEMm+v2vB9bQDBAI3VF9WKI6KwR0Wn5OC78clXgEq5olD3dGcoE
	 EZCwXGLiu3ISaVHtU+Lu6Xat00Ko6qcL4J8USZuH/g29H8XiswHFA6W/LUQ0RBaA9
	 6/MUNIC6iUx967T1zw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNswE-1sFVIb07wm-00QHQt; Tue, 07
 May 2024 22:39:57 +0200
Message-ID: <5a582841-94c6-4f20-b942-5e27dd45a0c5@gmx.com>
Date: Wed, 8 May 2024 06:09:52 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/15] btrfs: remove all extra btrfs_check_eb_owner()
 calls
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1715105406.git.josef@toxicpanda.com>
 <343d19395e2cfe7b15cde8e618f80cae17e9b0e7.1715105406.git.josef@toxicpanda.com>
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
In-Reply-To: <343d19395e2cfe7b15cde8e618f80cae17e9b0e7.1715105406.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZgA62JNACTDpW0Gu2ld2ILQVtpdUFFWqTKjvjGnx6AvXcBMfXs3
 ROzxdgG6xrq6KloPrp+ENAaxLh9Sa1Q52e69KKjSYoOZ2/aQTdZWrrpX7tD8MOVEXkPJeX6
 hYaQv63MM+Cma3o4Nl6/ZB3EFLhmeMOYasHIfyynfHzgzxH55RZPkrFw8J7exLqruEZQDO+
 VHooq2J8/K9UERiUIaq8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8eZ6WygfNGw=;dBdEObpI/uKNoJg2AMuQoZX1GDt
 Bgts4IR3P6GuRJfDnPIVxqAzi6kFpfSjdmQYPsuQXIRU+kjZCo6nQzXmsOEHAd/IuFDl6gMlD
 gMBjfYbSre7DA3WVyeEARuUQXgFxKtTG+FMeEk1uyjJz5rVfYGjJ8o8ivXPky1dXPTfQ1m2cG
 XZjmjuaqJBNRBDJ7wPvHcWIYiolPuEe4lACdBttTw6wqVz6MNfkNQjCIaTJEVW17nJIQNA+dY
 u0ReyUdvF2VUIU9DjFqmBSZ4EQON1UpU0xgYG5XVvab7P4ZPvU5vI+tfEDRLaqB0gIREY2yLE
 mbYNsBpE1nyqa1/Q2AvuzfMXkgfMRBjhftzFXpTkyFodnyplzecPJLvsII5usS0tULWH5DjMn
 QOgrKsttINY1wuVpS4kOUpFDwWZa/MHop68uQAOHp/NAfj6m+brNhjb+A9DbGXUWDZk+GCrXt
 fpCHg8nfuBSeghNmqiLzcJmazvN6rmWZMe6gK+qQ89CtrFDVLgBOxmRwM/hEuKziuiKmAQTnR
 rT+Nf0YuIxN49qou5bznj6GRWXLYCEcSpcm7G+LGCjR9awblHEFXtQYqbUU8jsQ28zOmmZSy4
 Hqaj7WO/qpde4nnEDhF11thZVbCsoVEkhMM9NJ4tq4pD02F5G7uX1vIiE6uRimWJ9NFL/VpDs
 mejnDXLjIv7ELoMqV32Z3GIMJeyopSojy7PEQW+q3WifE88GxPxjo3Ge+4sPHk1OdTF7U3igR
 uWUdFHndwcCwU8GE4c+yR7F+Cv1uP+9fdyni6PAhLmu5fr5FD2aSZbnWjcQ76GDvX+D+j39yd
 t+93ajAGdLeqlydZJxcsrxJm0agB5cW/H07Uu1QQ2/J9M=



=E5=9C=A8 2024/5/8 03:42, Josef Bacik =E5=86=99=E9=81=93:
> Currently we have a handful of btrfs_check_eb_owner() calls in various
> places and helpers that read extent buffers.  However we call this in
> the endio handler for every metadata block, so these extra checks are
> unnecessary, simply remove them from everywhere except the endio
> handler.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.c   | 7 +------
>   fs/btrfs/disk-io.c | 4 ----
>   2 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 1a49b9232990..48aa14046343 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1551,12 +1551,7 @@ read_block_for_search(struct btrfs_root *root, st=
ruct btrfs_path *p,
>   		if (ret) {
>   			free_extent_buffer(tmp);
>   			btrfs_release_path(p);
> -			return -EIO;
> -		}
> -		if (btrfs_check_eb_owner(tmp, btrfs_root_id(root))) {
> -			free_extent_buffer(tmp);
> -			btrfs_release_path(p);
> -			return -EUCLEAN;
> +			return ret;
>   		}
>
>   		if (unlock_up)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a91a8056758a..92ada19ccd10 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -635,10 +635,6 @@ struct extent_buffer *read_tree_block(struct btrfs_=
fs_info *fs_info, u64 bytenr,
>   		free_extent_buffer_stale(buf);
>   		return ERR_PTR(ret);
>   	}
> -	if (btrfs_check_eb_owner(buf, check->owner_root)) {
> -		free_extent_buffer_stale(buf);
> -		return ERR_PTR(-EUCLEAN);
> -	}
>   	return buf;
>
>   }

