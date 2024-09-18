Return-Path: <linux-btrfs+bounces-8104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6277097B80E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 08:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B82285C01
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 06:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95783166F33;
	Wed, 18 Sep 2024 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eAKFe372"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CCF4405
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2024 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726641773; cv=none; b=nkgSYcBwXjaqyYSH4BuC0DaEe+G2e4M9hSjp8ye+4VWDO3Z0vzJ52r230jcdsgI5Bmbm/Xf4VXmdY+XG2pwmEe763qa4pdOj1D9wyyOooSJ23NFT0uXE1A3xK41fsCGLRZhhsRnBVDkMD2IPab4dDiGrAJMg00toaKgZgSVOPIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726641773; c=relaxed/simple;
	bh=qzOinn7rODVAmhp/FCQqi1nLZzGzw4HmaaFt87Rsh50=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mScIrA+ZoPTem9rldRsUQVe2hyi4fxMU5h5FbwwyWF0vaG2n9YbgwrpwiocneYDu3pwzSNgDusLRcCtwVe6IsfEet5qDbI8YZUL8O/zuEMWsjRZG2hOIJUmGmNDtX0uTZq89HjEUQ1Lx2x/Jvf/O48EoULYAeCZlki7E8+qZeGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eAKFe372; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f762de00e5so72508771fa.3
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 23:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726641768; x=1727246568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xDDJnuopNkpz6oaIK25IhmZZckqEQcnOSJqszMUK+fo=;
        b=eAKFe372gkDF1/T7FaIKuIrufNnpdAuE3vt1uHJJhfCsIlapeorn5mF2AmSMF9bn/W
         93JPbxZs8d0a58kNPv+Qha+EDcffDh2JWmEtCVq/w/KXHqFy1kNgjTDyukcA2Pc15Liy
         mdwSRU6Ru5LcspKs4gm4QJLz999t2Q21xES44OoP1NfJYjZHXDA6J0XXxh4RbRVj5xj5
         AzqQVgaqpAcP5Txw35JvImZnIi4Da5HnZ/dBfqAHn7kDydiOQaOPdmZ5UnB7wZu+XJAc
         P/wB2V/SmxzdMdCDIi7nvJTIABrt2JkpEsoAOIkuFqmYCkUp+Uw8oqC6xgjQuLaSkAkW
         GU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726641768; x=1727246568;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDDJnuopNkpz6oaIK25IhmZZckqEQcnOSJqszMUK+fo=;
        b=SbhC794XCwdNycQf/vELHnpjEjtNNBlTm6Dvbrei4VH33Yo+exWz2U9P6vobCGvqMc
         g9MrrCQ7rN+zBO1GwQ4kYmbKJTI7hFTWVmtCbkZ+jLC3DW7rZ1ZMuc1MLczXC7RwnBYD
         yBKUqH4nqSBP7Y30i8z+dbtjUGhG+0riKbxmMGxTcSMiV4yAi40ZWxCWyD3rxO/EMKv/
         zTxivKz6rswWhekPWWmcallfFWceFL2E7oZxPd4d/IWwbmRpnpyWzomXvM0ajRQ27PpH
         JWWi7wbTOwcn1wt4Pr2fD6I/CKe1D5T5r31tXsrN+cleL2PvYvkmuRu1wBaNFil8a2Hs
         DCyw==
X-Gm-Message-State: AOJu0YwNaHiCDO3Hwr23TSJj7tvYp9Lpe7kfynNI7v6W98ZeXAzOd2+V
	9LJrEYrdtaSkvfhq5E48TVyZcGJhORoJq4bnSJufikpoRMe6rzr0NmWwGZOpLUVpjz/5w3Kb5vt
	G
X-Google-Smtp-Source: AGHT+IH7Jt75XCANZMN9StCutmHd1qztNYBnSIwt4Sa60Elz8aPzqTaV0pJo4IhzYIEykvpBEjNFbA==
X-Received: by 2002:a2e:80a:0:b0:2f4:1e6:5f57 with SMTP id 38308e7fff4ca-2f787f6a85bmr74157491fa.45.1726641767692;
        Tue, 17 Sep 2024 23:42:47 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a97063sm6105686b3a.33.2024.09.17.23.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 23:42:47 -0700 (PDT)
Message-ID: <ee719767-fb8a-490e-bf4a-465dbdf7e00a@suse.com>
Date: Wed, 18 Sep 2024 16:12:43 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from
 CONFIG_BTRFS_DEBUG
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <97b513c38b3d6357b8e51b64c5e06a2a89015ab3.1726640060.git.wqu@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <97b513c38b3d6357b8e51b64c5e06a2a89015ab3.1726640060.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/18 15:44, Qu Wenruo 写道:
> Currently CONFIG_BTRFS_EXPERIMENTAL is not only for the extra debugging

s/EXPERIMENTAL/DEBUG/

Already done in my local branch.

Thanks,
Qu

> output, but also for experimental features.
> 
> This is not ideal to distinguish planned but not yet stable features
> from those purely designed for debug.
> 
> This patch will split the following features into
> CONFIG_BTRFS_EXPERIMENTAL:
> 
> - Extent map shrinker
>    This seems to be the first one to exit experimental.
> 
> - Extent tree v2
>    This seems to be the last one to graduate from experimental.
> 
> - Raid stripe tree
> - Csum offload mode
> - Send stream v3
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix the "string" -> "stream" error in the commit message
> - Move extent_tree_v2 and raid_stripe_tree sysfs interfaces to
>    CONFIG_BTRFS_EXPERIMENTAL
> - Add experimental string to mod info
> ---
>   fs/btrfs/Kconfig   | 9 +++++++++
>   fs/btrfs/bio.c     | 2 +-
>   fs/btrfs/fs.h      | 4 ++--
>   fs/btrfs/send.h    | 2 +-
>   fs/btrfs/super.c   | 9 ++++++---
>   fs/btrfs/sysfs.c   | 8 ++++----
>   fs/btrfs/volumes.h | 4 ++--
>   7 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> index 4fb925e8c981..ead317f1eeb8 100644
> --- a/fs/btrfs/Kconfig
> +++ b/fs/btrfs/Kconfig
> @@ -78,6 +78,15 @@ config BTRFS_ASSERT
>   
>   	  If unsure, say N.
>   
> +config BTRFS_EXPERIMENTAL
> +	bool "Btrfs experimental features"
> +	depends on BTRFS_FS
> +	help
> +	  Enable experimental features.  These features may not be stable enough
> +	  for end users.  This is meant for btrfs developers only.
> +
> +	  If unsure, say N.
> +
>   config BTRFS_FS_REF_VERIFY
>   	bool "Btrfs with the ref verify tool compiled in"
>   	depends on BTRFS_FS
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index ce13416bc10f..056f8a171bba 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -605,7 +605,7 @@ static bool should_async_write(struct btrfs_bio *bbio)
>   {
>   	bool auto_csum_mode = true;
>   
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>   	struct btrfs_fs_devices *fs_devices = bbio->fs_info->fs_devices;
>   	enum btrfs_offload_csum_mode csum_mode = READ_ONCE(fs_devices->offload_csum_mode);
>   
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index cbfb225858a5..785ec15c1b84 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -263,10 +263,10 @@ enum {
>   	 BTRFS_FEATURE_INCOMPAT_ZONED		|	\
>   	 BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA)
>   
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>   	/*
>   	 * Features under developmen like Extent tree v2 support is enabled
> -	 * only under CONFIG_BTRFS_DEBUG.
> +	 * only under CONFIG_BTRFS_EXPERIMENTAL
>   	 */
>   #define BTRFS_FEATURE_INCOMPAT_SUPP		\
>   	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE |	\
> diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
> index b07f4aa66878..9309886c5ea1 100644
> --- a/fs/btrfs/send.h
> +++ b/fs/btrfs/send.h
> @@ -16,7 +16,7 @@ struct btrfs_ioctl_send_args;
>   
>   #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
>   /* Conditional support for the upcoming protocol version. */
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>   #define BTRFS_SEND_STREAM_VERSION 3
>   #else
>   #define BTRFS_SEND_STREAM_VERSION 2
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 98fa0f382480..7f86fb54981f 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2403,10 +2403,10 @@ static long btrfs_nr_cached_objects(struct super_block *sb, struct shrink_contro
>   	trace_btrfs_extent_map_shrinker_count(fs_info, nr);
>   
>   	/*
> -	 * Only report the real number for DEBUG builds, as there are reports of
> -	 * serious performance degradation caused by too frequent shrinks.
> +	 * Only report the real number for EXPERIMENTAL builds, as there are
> +	 * reports of serious performance degradation caused by too frequent shrinks.
>   	 */
> -	if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
> +	if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL))
>   		return nr;
>   	return 0;
>   }
> @@ -2478,6 +2478,9 @@ static int __init btrfs_print_mod_info(void)
>   #ifdef CONFIG_BTRFS_DEBUG
>   			", debug=on"
>   #endif
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +			", experimental=on"
> +#endif
>   #ifdef CONFIG_BTRFS_ASSERT
>   			", assert=on"
>   #endif
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 03926ad467c9..fdcbf650ac31 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -295,7 +295,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
>   #ifdef CONFIG_BLK_DEV_ZONED
>   BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
>   #endif
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>   /* Remove once support for extent tree v2 is feature complete */
>   BTRFS_FEAT_ATTR_INCOMPAT(extent_tree_v2, EXTENT_TREE_V2);
>   /* Remove once support for raid stripe tree is feature complete. */
> @@ -329,7 +329,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
>   #ifdef CONFIG_BLK_DEV_ZONED
>   	BTRFS_FEAT_ATTR_PTR(zoned),
>   #endif
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>   	BTRFS_FEAT_ATTR_PTR(extent_tree_v2),
>   	BTRFS_FEAT_ATTR_PTR(raid_stripe_tree),
>   #endif
> @@ -1390,7 +1390,7 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
>   BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
>   	      btrfs_bg_reclaim_threshold_store);
>   
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>   static ssize_t btrfs_offload_csum_show(struct kobject *kobj,
>   				       struct kobj_attribute *a, char *buf)
>   {
> @@ -1450,7 +1450,7 @@ static const struct attribute *btrfs_attrs[] = {
>   	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
>   	BTRFS_ATTR_PTR(, commit_stats),
>   	BTRFS_ATTR_PTR(, temp_fsid),
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>   	BTRFS_ATTR_PTR(, offload_csum),
>   #endif
>   	NULL,
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 03d2d60afe0c..c207c94a4a5e 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -300,7 +300,7 @@ enum btrfs_read_policy {
>   	BTRFS_NR_READ_POLICY,
>   };
>   
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>   /*
>    * Checksum mode - offload it to workqueues or do it synchronously in
>    * btrfs_submit_chunk().
> @@ -424,7 +424,7 @@ struct btrfs_fs_devices {
>   	/* Policy used to read the mirrored stripes. */
>   	enum btrfs_read_policy read_policy;
>   
> -#ifdef CONFIG_BTRFS_DEBUG
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>   	/* Checksum mode - offload it or do it synchronously. */
>   	enum btrfs_offload_csum_mode offload_csum_mode;
>   #endif

