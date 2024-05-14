Return-Path: <linux-btrfs+bounces-5000-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910EB8C5DFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 01:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262101F2191F
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 23:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A75182C8F;
	Tue, 14 May 2024 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PPCiEI3j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CB6181D1B
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715727605; cv=none; b=o1esb8keP+YbOnZOnC0rPJJJENtVSdU4OkdQHBSG5l1M/EvsooVUMUQKdKitp2NpSTpAK8xyKrke0c/uLSk8GMrY71+IdXgKvCtBq49eJkThbB+lUgD9bOa8I+rHSwC5SCWDjU9bLEz5bVKIZC9nZiVkFifLKOFO86ZhaHQddys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715727605; c=relaxed/simple;
	bh=f77KHva3R7297jCM6qNX2KBIM75SVbTZt8GcQ1JRTiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bde6yXB3f66ZfM+EllSQbwi5zXsIgvI0t5TrZu7QPTMg6+Sfao9hUmBoaV5ylAPx4qp9zjHWhJnK1SuxTwVFT5qkcsKEdN7xN/AvvmDtyEh5cESrFekLsJWGK0CkCNwAbFUYn12plboUXU++I80u3zoRYW81xM1RfYy8v9LgUxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PPCiEI3j; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715727599; x=1716332399; i=quwenruo.btrfs@gmx.com;
	bh=iTN/RtlHfRVT9i3ccT2d957o2VnE6QRqjFtx5aB13nA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PPCiEI3jXLmvUIbCMvwyB83y0GNAz/CNYD0doaDe4+7fQY4TBIVNuI8nkKsz6wic
	 o+y2BA0UDtsx/47bGa1CfR6aLreYvQpsJ0Z/xtbh8t71AESdxjcE4ECButfU78mD9
	 MimYODZ1sfgH7v/mtCSpjD/Bozc+gPvswuueTE3DjAc7LiQPhhlNfGBp/0YUbPULO
	 HKNMYuxI/lz4/2AI/pXW3WfAPpjY3dgIp6kaAIfJm5byNbvP/WQM/W2NHH125VyNO
	 oKx3+MROXFDZrucCdxGgD+19JssGWuP+Wa2XpTOxChNG3/LMtFePAfB1TFdshrS3p
	 L7t6KxkLUNLnh3tn7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVeMA-1rzD4M2lym-00RZJ1; Wed, 15
 May 2024 00:59:59 +0200
Message-ID: <d971380b-1867-4e8f-b9c8-aeda8aec2c79@gmx.com>
Date: Wed, 15 May 2024 08:29:55 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] btrfs-progs: support byte length for zone
 resetting
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20240514182227.1197664-1-naohiro.aota@wdc.com>
 <20240514182227.1197664-7-naohiro.aota@wdc.com>
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
In-Reply-To: <20240514182227.1197664-7-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0JNTQqxmyp0rBKGum/A6DitLYS48W/0N4yxWLA+pMKV28POJ8c6
 Kcz1+54nIxpvsHOi0MdnSmOik1ADQ7g4DeuEsZSRJCDk9/aXZlh6XD/QPP/8WVZ1zmAjj69
 KfEseN2hq/xSBuojauu7cH++MZH4SDyYvRJPQLFuogBNS+JPgZxabtMBh+UInPtnlCgb9OY
 FSiRxHGFFKyGxt4MfRSRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zsoKZXYFMuM=;/KP3CNCyXmPGSY4+qLVeqpLS1QW
 ybNxNfpdVkUGKQGE8Xnx7+eRgy5Rrxqi8gyP29yJ8gJs5e79B1IPnQHfg2lcRCrGfnDVNioEs
 iSCfOY3NiH6PCUw8z6KYbFlvI8TIOTypniY1E72GF93mT71kXqwiYEaYE1IXC4e6frX2dAAkQ
 zcA7unWnJCHC07sDVuB0uwKbosS8d4G50m17HryvGcvsIn7R7BWCmOSUw2S6rUTNadPZIuaW6
 oRuVaTStIKtJ/G4O3L4kKPrfwy75qgP73Oz4zvEcdtv+N5qsBf8eiztwP4s1O3OGSgEjZyRwK
 ZhhUbNyJieCr6rrm1D+cc6caMUq+sblh4IOWS+LwQSDj+G0CYiojyK3fWw3CRBNHoArhkgUhh
 +AcsyChEawg3IWyTBhqroJNy9RTkY45FRPG9aU++kyerHRirBA8uQRLSib0Yv7uYLmVVLdak1
 aZPX2llzC0Hx6WofTWH3HgGxG9v8y4jeLhKsk1KFR9DBM8NIm/whAqpVCFLDV4GvOrSVBt2le
 PrV5PavUTLUBnv7i/D9d6lZJ5zHrYXrVBiAWSFMqvY+ZMJuMUiANkyhvqqCzxXjz39M8LdYPJ
 SVeTqNr+ERwV3fNyglhpxR0v9s7bBmjR9fESiu0fVvloif+mz8Azm7IMJ7MksE6BApjIZD+zL
 xQfwaMwj+p29Da2RfzXupm3ju3ib6cttVYhH/8Gk7dhktjlf7DzStrP+BfkdorqDOn7R6Q2Mp
 3EuVwRK5eyLXiM2leEOFuy7NqSqQ6OXhgBAKayxzWtfv+jegQXOldGh8bKSdSVRZsJlr8OEzs
 vfUGa5Q1YRiti1dJptSFBBmgGIKULDGMocvSF/RJmiER0=



=E5=9C=A8 2024/5/15 03:52, Naohiro Aota =E5=86=99=E9=81=93:
> Even with "mkfs.btrfs -b", mkfs.btrfs resets all the zones on the device=
.
> Limit the reset target within the specified length.
>
> Also, we need to check that there is no active zone outside of the FS
> range. If there is one, btrfs fails to meet the active zone limit proper=
ly.

Mind to explain more on why an active zone *outside* of the fs range is
a problem?

It's pretty instinctive to consider such active zones out of the fs
range as non-exist, thus should not cause much problem (until we want to
expand the fs etc).

This should just acts like the data beyond fs range in traditional
devices, and we never really bothered them.

Thanks,
Qu

>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   common/device-utils.c | 17 ++++++++++++-----
>   kernel-shared/zoned.c | 23 ++++++++++++++++++++++-
>   kernel-shared/zoned.h |  7 ++++---
>   3 files changed, 38 insertions(+), 9 deletions(-)
>
> diff --git a/common/device-utils.c b/common/device-utils.c
> index 86942e0c7041..7df7d9ce39d8 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -254,16 +254,23 @@ int btrfs_prepare_device(int fd, const char *file,=
 u64 *byte_count_ret,
>
>   		if (!zinfo->emulated) {
>   			if (opflags & PREP_DEVICE_VERBOSE)
> -				printf("Resetting device zones %s (%u zones) ...\n",
> -				       file, zinfo->nr_zones);
> +				printf("Resetting device zones %s (%llu zones) ...\n",
> +				       file, byte_count / zinfo->zone_size);
>   			/*
>   			 * We cannot ignore zone reset errors for a zoned block
>   			 * device as this could result in the inability to write
>   			 * to non-empty sequential zones of the device.
>   			 */
> -			if (btrfs_reset_all_zones(fd, zinfo)) {
> -				error("zoned: failed to reset device '%s' zones: %m",
> -				      file);
> +			ret =3D btrfs_reset_zones(fd, zinfo, byte_count);
> +			if (ret) {
> +				if (ret =3D=3D EBUSY) {
> +					error("zoned: device '%s' contains an active zone outside of the F=
S range",
> +					      file);
> +					error("zoned: btrfs needs full control of active zones");
> +				} else {
> +					error("zoned: failed to reset device '%s' zones: %m",
> +					      file);
> +				}
>   				goto err;
>   			}
>   		}
> diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
> index fb1e1388804e..b4244966ca36 100644
> --- a/kernel-shared/zoned.c
> +++ b/kernel-shared/zoned.c
> @@ -395,16 +395,24 @@ static int report_zones(int fd, const char *file,
>    * Discard blocks in the zones of a zoned block device. Process this w=
ith zone
>    * size granularity so that blocks in conventional zones are discarded=
 using
>    * discard_range and blocks in sequential zones are reset though a zon=
e reset.
> + *
> + * We need to ensure that zones outside of the FS is not active, so tha=
t
> + * the FS can use all the active zones. Return EBUSY if there is an act=
ive
> + * zone.
>    */
> -int btrfs_reset_all_zones(int fd, struct btrfs_zoned_device_info *zinfo=
)
> +int btrfs_reset_zones(int fd, struct btrfs_zoned_device_info *zinfo, u6=
4 byte_count)
>   {
>   	unsigned int i;
>   	int ret =3D 0;
>
>   	ASSERT(zinfo);
> +	ASSERT(IS_ALIGNED(byte_count, zinfo->zone_size));
>
>   	/* Zone size granularity */
>   	for (i =3D 0; i < zinfo->nr_zones; i++) {
> +		if (byte_count =3D=3D 0)
> +			break;
> +
>   		if (zinfo->zones[i].type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL) {
>   			ret =3D device_discard_blocks(fd,
>   					     zinfo->zones[i].start << SECTOR_SHIFT,
> @@ -419,7 +427,20 @@ int btrfs_reset_all_zones(int fd, struct btrfs_zone=
d_device_info *zinfo)
>
>   		if (ret)
>   			return ret;
> +
> +		byte_count -=3D zinfo->zone_size;
>   	}
> +	for (; i < zinfo->nr_zones; i++) {
> +		const enum blk_zone_cond cond =3D zinfo->zones[i].cond;
> +
> +		if (zinfo->zones[i].type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)
> +			continue;
> +		if (cond =3D=3D BLK_ZONE_COND_IMP_OPEN ||
> +		    cond =3D=3D BLK_ZONE_COND_EXP_OPEN ||
> +		    cond =3D=3D BLK_ZONE_COND_CLOSED)
> +			return EBUSY;
> +	}
> +
>   	return fsync(fd);
>   }
>
> diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
> index 6eba86d266bf..2bf24cbba62a 100644
> --- a/kernel-shared/zoned.h
> +++ b/kernel-shared/zoned.h
> @@ -149,7 +149,7 @@ bool btrfs_redirty_extent_buffer_for_zoned(struct bt=
rfs_fs_info *fs_info,
>   					   u64 start, u64 end);
>   int btrfs_reset_chunk_zones(struct btrfs_fs_info *fs_info, u64 devid,
>   			    u64 offset, u64 length);
> -int btrfs_reset_all_zones(int fd, struct btrfs_zoned_device_info *zinfo=
);
> +int btrfs_reset_zones(int fd, struct btrfs_zoned_device_info *zinfo, u6=
4 byte_count);
>   int zero_zone_blocks(int fd, struct btrfs_zoned_device_info *zinfo, of=
f_t start,
>   		     size_t len);
>   int btrfs_wipe_temporary_sb(struct btrfs_fs_devices *fs_devices);
> @@ -203,8 +203,9 @@ static inline int btrfs_reset_chunk_zones(struct btr=
fs_fs_info *fs_info,
>   	return 0;
>   }
>
> -static inline int btrfs_reset_all_zones(int fd,
> -					struct btrfs_zoned_device_info *zinfo)
> +static inline int btrfs_reset_zones(int fd,
> +				    struct btrfs_zoned_device_info *zinfo,
> +				    u64 byte_count)
>   {
>   	return -EOPNOTSUPP;
>   }

