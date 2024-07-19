Return-Path: <linux-btrfs+bounces-6591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072609376B9
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 12:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1948282306
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 10:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C785A84A31;
	Fri, 19 Jul 2024 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oPs7BJzM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C7F1B86D0;
	Fri, 19 Jul 2024 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721385691; cv=none; b=VdSr7U1XHPvK/aK6sGAOBiTwGFcfJOumWs1pzbcamlyTRQwRVBPD0hsZufAj3RC10SiYW+K/cbzslsZjbXJ/Zl2q0cQJE1JSbJRAhIID68fr6vAVBZ+8IOiudw5QejI6WfWpXfVGevM5b+Zxy8TA0uuCPlFs4LXrA5cgeTFtHA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721385691; c=relaxed/simple;
	bh=ZgMp5cuDFw3DXewym2g+tiW5b3FZsxoqsVfhwlTi1Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjJM8QFpD3aYTBGnQvEKflmSKb+7IpGHlz4h2N6gbdvwmRtmbQqf5twdUAdKMHoQPIXQE747dCbGZ+bS4xwNeLmi7Co6z9DGKGLvRmcKS2uSSBm6rxXS4j4Tu6Vu/W61/DgaN47bEVp4fkezLwy6mMCH9cjG5OCxVAly9wz479g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oPs7BJzM; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721385655; x=1721990455; i=quwenruo.btrfs@gmx.com;
	bh=iRAnJbABmOvnI0EeTu+SsdoZh7IsuUMi38MT5s2W0PA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oPs7BJzM9G1fAwRcCO11ZZgVMHJ+1WtNz5Beg0/8S45zqnDFs1jPbMIdi55PETJM
	 ZPhm6sNwWYnBKeFSr0dDLEAwojH0/JPzzKFwMH1jazYaa7vPo2BAnyRINhM8xJZt2
	 RS3g+ir39eAfwOPfNWgbWaLpvse+tu4LbmKXKkhVteHObRRDX1qK2u8H3pjhDvQ3i
	 eidpFFIc5v4iBoXr22MSC79HqeAHseEejlBRmbQC3Y6J5Bcx8pyRAOuaq+7p17kfs
	 2CVHWGj/S4fyHDH0HnhCmMuX5ujwm9HAYfxHJTImZMiHD89iEcUz9sycVjA+KR3zJ
	 rkIhUc1bUwikkOek+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3KPq-1sLVcC3W1y-00vKX4; Fri, 19
 Jul 2024 12:40:55 +0200
Message-ID: <c51c0e6d-c1ca-4fc0-a0d7-4a1468b137fd@gmx.com>
Date: Fri, 19 Jul 2024 20:10:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: change mount_opt to u64
To: Arnd Bergmann <arnd@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Qu Wenruo <wqu@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Filipe Manana <fdmanana@suse.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Anand Jain <anand.jain@oracle.com>, Christian Brauner <brauner@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240719103714.1217249-1-arnd@kernel.org>
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
In-Reply-To: <20240719103714.1217249-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xC0xeYGd42CosbZthSxexjOzDUZsGBNE91kikSnpaMi/ubu+3vh
 +JYd7r7IMMsYvmXujR+0t+hLbNlr3ciz/CaaZBvylP63YS9ds+1+cnVG2/17789Q/HMxCby
 S8JI3WTmFZXVBCJ1LFZoSMKQkc4STnRp/i6FN7N8FjOh7TnTSA2+SQyRoM6jlFG0RZV2/HS
 IZebOVr9JVzQj+Lo5fh8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JvTEarlGdps=;WN0QydAJQJiszELovm2RUNRESy/
 SDZFDlFE4oCpI/4MLycjd4PKklWPsRq3xusRaJuoeeRPsXFUbKJS2HvpQsAgK5GQu9GB20gSN
 KHs+uqigDBt7TsbPs6FE5+IQxYIUl1bwOadTUZ0eyDpj0jqawTbFdnPqeElpIjOH6ZnOj/Dws
 jhVM0Mwn1y+uudXABcWyD+XR3Srh4k4iVRNQpm0uuOABTjAAZCoy4uAXSEfkW1/PiJUGhs18/
 LUoMxDHChoa82P9XiyEwI6qmr7CDjAV35KymYmch3ypTqvnFJvWZdTx64EgwIPDUcOJCsV7Fw
 7XdeoR3ZmEex8IEWL93oIR69ttP2jAZ+ixrQcXT5ucfRZWp0rZt7E2CrTJ6dZtBxQcGSMayVI
 4E0rWSuf4OMvn18xqAqd2D6w5C4RwUl37oS4RuvIGnDiWfPigRgguoW0Xc7mwTZWfvdkFRB6v
 VjLuVt34Jc+w9IYFEpw0+Ski3GFaqQyHHoxtSCZk0rTdTjJIbuBX/p+KqwMmzdY3IEGsjQdc5
 weCjGMbcy6eiTs6+JoLD52qhY6i0lSTxo1C4e1/xqyzRtOBLNSct6GHf9swmn7OY3U9djuq1n
 D5ZA1O1/9YNK1G2+XS/Q+tKlK8C3Jhs9bq7WXuotoFHXNhvlUU2b+8AAw21XZFujFt/EhQYBP
 N2Y101iJUB5J1gEPaFh90ud4fuGk84CxtFdUZDPu0L6+i/nnBuPLLCsNHII9yizGZhMYU7/J6
 r0x2bNQqLd0Eoi2zbrD3oDcsWHrxh1KFVbIxKUzloSSBx/lbnV3qpl9eXkGBgfghbA3ZfGYui
 prfv7VbzjfCoY+/u3+nUAO7A==



=E5=9C=A8 2024/7/19 20:07, Arnd Bergmann =E5=86=99=E9=81=93:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The newly added BTRFS_MOUNT_IGNORESUPERFLAGS flag does not fit into a 32=
-bit
> flags word, as shown by this warning on 32-bit architectures:
>
> fs/btrfs/super.c: In function 'btrfs_check_options':
> fs/btrfs/super.c:666:48: error: conversion from 'enum <anonymous>' to 'l=
ong unsigned int' changes value from '4294967296' to '0' [-Werror=3Doverfl=
ow]
>    666 |              check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNO=
RESUPERFLAGS, "ignoresuperflags")))
>        |                                                ^~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
>
> Change all interfaces that deal with mount flags to use a 64-bit type
> on all architectures instead.
>
> Fixes: 32e6216512b4 ("btrfs: introduce new "rescue=3Dignoresuperflags" m=
ount option")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

There is already a patch submitted:

https://lore.kernel.org/linux-btrfs/0955d2c5675a7fe3146292aaa766755f22bcd9=
4b.1720865683.git.wqu@suse.com/

Thanks,
Qu
> ----
> Please double-check that I got all the instances. I only looked at where=
 the
> obvious users are, but did not actually try to run this on a 32-bit targ=
et
> ---
>   fs/btrfs/fs.h    | 2 +-
>   fs/btrfs/super.c | 6 +++---
>   fs/btrfs/super.h | 2 +-
>   fs/btrfs/zoned.c | 2 +-
>   fs/btrfs/zoned.h | 4 ++--
>   5 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 1b2a7aa0af36..20900c7cc35d 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -481,7 +481,7 @@ struct btrfs_fs_info {
>   	 * required instead of the faster short fsync log commits
>   	 */
>   	u64 last_trans_log_full_commit;
> -	unsigned long mount_opt;
> +	u64 mount_opt;
>
>   	unsigned long compress_type:4;
>   	unsigned int compress_level;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 43052acd7a48..ea7141330e87 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -82,7 +82,7 @@ struct btrfs_fs_context {
>   	u32 commit_interval;
>   	u32 metadata_ratio;
>   	u32 thread_pool_size;
> -	unsigned long mount_opt;
> +	u64 mount_opt;
>   	unsigned long compress_type:4;
>   	unsigned int compress_level;
>   	refcount_t refs;
> @@ -642,7 +642,7 @@ static void btrfs_clear_oneshot_options(struct btrfs=
_fs_info *fs_info)
>   }
>
>   static bool check_ro_option(const struct btrfs_fs_info *fs_info,
> -			    unsigned long mount_opt, unsigned long opt,
> +			    u64 mount_opt, u64 opt,
>   			    const char *opt_name)
>   {
>   	if (mount_opt & opt) {
> @@ -653,7 +653,7 @@ static bool check_ro_option(const struct btrfs_fs_in=
fo *fs_info,
>   	return false;
>   }
>
> -bool btrfs_check_options(const struct btrfs_fs_info *info, unsigned lon=
g *mount_opt,
> +bool btrfs_check_options(const struct btrfs_fs_info *info, u64 *mount_o=
pt,
>   			 unsigned long flags)
>   {
>   	bool ret =3D true;
> diff --git a/fs/btrfs/super.h b/fs/btrfs/super.h
> index d2b8ebb46bc6..98e2444c0d82 100644
> --- a/fs/btrfs/super.h
> +++ b/fs/btrfs/super.h
> @@ -10,7 +10,7 @@
>   struct super_block;
>   struct btrfs_fs_info;
>
> -bool btrfs_check_options(const struct btrfs_fs_info *info, unsigned lon=
g *mount_opt,
> +bool btrfs_check_options(const struct btrfs_fs_info *info, u64 *mount_o=
pt,
>   			 unsigned long flags);
>   int btrfs_sync_fs(struct super_block *sb, int wait);
>   char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_inf=
o,
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index df7733044f7e..debab1ab9e71 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -767,7 +767,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_=
info)
>   	return 0;
>   }
>
> -int btrfs_check_mountopts_zoned(const struct btrfs_fs_info *info, unsig=
ned long *mount_opt)
> +int btrfs_check_mountopts_zoned(const struct btrfs_fs_info *info, u64 *=
mount_opt)
>   {
>   	if (!btrfs_is_zoned(info))
>   		return 0;
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index d66d00c08001..037697878b2a 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -58,7 +58,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *devic=
e, bool populate_cache);
>   void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
>   struct btrfs_zoned_device_info *btrfs_clone_dev_zone_info(struct btrfs=
_device *orig_dev);
>   int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
> -int btrfs_check_mountopts_zoned(const struct btrfs_fs_info *info, unsig=
ned long *mount_opt);
> +int btrfs_check_mountopts_zoned(const struct btrfs_fs_info *info, u64 *=
mount_opt);
>   int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, =
int rw,
>   			       u64 *bytenr_ret);
>   int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int=
 rw,
> @@ -130,7 +130,7 @@ static inline int btrfs_check_zoned_mode(const struc=
t btrfs_fs_info *fs_info)
>   }
>
>   static inline int btrfs_check_mountopts_zoned(const struct btrfs_fs_in=
fo *info,
> -					      unsigned long *mount_opt)
> +					      u64 *mount_opt)
>   {
>   	return 0;
>   }

