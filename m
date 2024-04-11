Return-Path: <linux-btrfs+bounces-4173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2188A2244
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 01:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C19F28AB0C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 23:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A06481B4;
	Thu, 11 Apr 2024 23:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vve3ZuZ3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE0224FA
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 23:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877945; cv=none; b=Zw0DA8rhdf98AoC9NlYSK5szn2i6U4Em6A8Avz7HMQrQco3eaKRWGr8OHwc+3/9p3oipf8ZU5+MWQG2qsm+X81Rmmv2HB9gWB/4ntcjllIAGvP89FtpiQvBmBvn1GxSxcN9xyodzdi+R44ouGKZsPWSgnoZfTMF+JSQ1nJuiG0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877945; c=relaxed/simple;
	bh=UlUnvnSwITRMQc52jg36+o9eFx0e+yae6bPZiGGZ4FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QIv3P+mhk0Ke8QlpEwITBESu5Xsmys4JiFGLnVuCRhduf3c4xAmAEEmjaf2u/tQxweUzrhpqMOS8veDj/Nmnau2MvYKIoSHdSXBDutodnLXXBi8cSU1ZMv6NWAhMPI8EDOs7+M+qLWeVcyPCrI39eyD0Z6eIALqgzn8DTlmFBFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vve3ZuZ3; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d87450361fso3256121fa.2
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712877942; x=1713482742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LQuKZ7CELWymEhhJTFInhFtB5lftRgE0gH15VpgPrBM=;
        b=Vve3ZuZ3bqvFaiFeY61DglvW/fJ6QpwppOmaujNCw76xK/1v376BTerVsJRL0FTFzp
         Jy3l4HKU4Y4jH0di0RK1p54+20KLQq7O4RdNbddQPfg0bRRbP1S/8NJi/NWLH9XTJD1G
         WpTp9bUHpnZXbLrp5qUYgLvV4FuHz5I32lAs/eQtepUL0T1QgYHwtqlkml5AKec3ojST
         50xw+x6xICuMHXtv+9DcZzXKo7dHoQnqBT6M3yvD/Vkaq31yzlH37HxHGyMCc9qN1C1o
         y+hrXniwKYmR+nf5/pg/wniQN5WHvhdFnh3G0/JxxjP0KcqKRA8T8OBzTsMgaiEAi2a6
         sx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712877942; x=1713482742;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQuKZ7CELWymEhhJTFInhFtB5lftRgE0gH15VpgPrBM=;
        b=rJyKOA3WfH1ipjCpAuqVemg1icpD3AZS3iVO2xusdQ1IDtnNxMKXKh+oO7mhTgDkqD
         CtPNZ2/uTsFaOCsD+xzdMQl4An5AHXrUHFy6qwWFu7hJCyDEwpjgEC5RJI/FU0I8dvTr
         +VMbqt/a+xXRjkpT4S7FkQlYgtBTLeX/QNimCDrrJsipKM//LX5ZMo/mIvAW1ImTfUTp
         QHtu/aM9gRkdLxS3eqLZCnl/jgAI5f4KEL5e/bKEhkGCH91iq2Rwk82qWM3cvAC2B2t8
         KyK1Mx9q5uqemLRrGGkFrcxxWZOa8Q8bloFR4LVZ+NPC0TXEUKNo5CuJM3KQmQQikmTO
         g+PA==
X-Forwarded-Encrypted: i=1; AJvYcCUTpyzC70HvzvCGn0S1maMJ8i8n+8czOs9wisl36kK7Mq+UQtKCZeQwTH5uxqizY1Dc6eQOkczzoOkGOFqBvo3T2XmUjhHwb9o+uuo=
X-Gm-Message-State: AOJu0YzcgJIx/BbfskZejAJY4ps8XLaCZ8vs4/mBDDZuvZjHtiD75A2Z
	H15LsQvZuV9yiDK8LW0m673Zjv83OM33azDgNC2JzqK8GaI/lrDfAhDiytfGkj0=
X-Google-Smtp-Source: AGHT+IFBkNP1/3PrsbDcEQ3mS2eCBl93Iq7V63LpQQITKXVrVR+VKZLcc70UbvfylShk7En1OTDOKQ==
X-Received: by 2002:a2e:a370:0:b0:2d7:7bb2:7afc with SMTP id i16-20020a2ea370000000b002d77bb27afcmr685278ljn.3.1712877941923;
        Thu, 11 Apr 2024 16:25:41 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id u26-20020a63a91a000000b005f073cd2bc6sm1405342pge.82.2024.04.11.16.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 16:25:41 -0700 (PDT)
Message-ID: <c6ed3d85-b506-4e6a-9ac7-8890b3a5fc8b@suse.com>
Date: Fri, 12 Apr 2024 08:55:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] btrfs: pass the extent map tree's inode to
 try_merge_map()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1712837044.git.fdmanana@suse.com>
 <81628b9abb3ece8fd7e35a521068cfa958aca112.1712837044.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <81628b9abb3ece8fd7e35a521068cfa958aca112.1712837044.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/12 01:49, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Extent maps are always associated to an inode's extent map tree, so
> there's no need to pass the extent map tree explicitly to try_merge_map().
> 
> In order to facilitate an upcoming change that adds a shrinker for extent
> maps, change try_merge_map() to receive the inode instead of its extent
> map tree.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_map.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 2753bf2964cb..97a8e0484415 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -223,8 +223,9 @@ static bool mergeable_maps(const struct extent_map *prev, const struct extent_ma
>   	return next->block_start == prev->block_start;
>   }
>   
> -static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
> +static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
>   {
> +	struct extent_map_tree *tree = &inode->extent_tree;
>   	struct extent_map *merge = NULL;
>   	struct rb_node *rb;
>   
> @@ -322,7 +323,7 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
>   	em->generation = gen;
>   	em->flags &= ~EXTENT_FLAG_PINNED;
>   
> -	try_merge_map(tree, em);
> +	try_merge_map(inode, em);
>   
>   out:
>   	write_unlock(&tree->lock);
> @@ -333,13 +334,11 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
>   
>   void clear_em_logging(struct btrfs_inode *inode, struct extent_map *em)
>   {
> -	struct extent_map_tree *tree = &inode->extent_tree;
> -
> -	lockdep_assert_held_write(&tree->lock);
> +	lockdep_assert_held_write(&inode->extent_tree.lock);
>   
>   	em->flags &= ~EXTENT_FLAG_LOGGING;
>   	if (extent_map_in_tree(em))
> -		try_merge_map(tree, em);
> +		try_merge_map(inode, em);
>   }
>   
>   static inline void setup_extent_mapping(struct btrfs_inode *inode,
> @@ -353,7 +352,7 @@ static inline void setup_extent_mapping(struct btrfs_inode *inode,
>   	if (modified)
>   		list_add(&em->list, &inode->extent_tree.modified_extents);
>   	else
> -		try_merge_map(&inode->extent_tree, em);
> +		try_merge_map(inode, em);
>   }
>   
>   /*

