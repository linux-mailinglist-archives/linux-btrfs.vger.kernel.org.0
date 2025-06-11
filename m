Return-Path: <linux-btrfs+bounces-14609-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D73AD61A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 23:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7E91BC4581
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 21:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE32245008;
	Wed, 11 Jun 2025 21:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KjMhvunV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3FB23AB94
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677884; cv=none; b=UzaBuFh9TOqkCFO4SxPyuWBxwl65VHo7gyMirLu5V3f1Vn8KW9CESv9v1CFmQlUd7kaFjR6tunf56dMkaEo512lUcOae9qJ5aIfBC3aRmVXPKtv66cBbqRT4o9KjNUcpNcHRxxtwaN6k71Cfo6E79FqcU0h0kvLFnPBL/C8iNR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677884; c=relaxed/simple;
	bh=Wzpejxe0wFSKMwq6zHQA4EX/YhgpbDyfGvj/91MnkQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1jHB+VP3rm13oNfUBVNpTNprNR7THZIpJVnmvWnMSsvLsL95zCEcYM5+vYEnValh1oiwgiVU9E4+UHn301I/pSJxdRevXw6KXMwuf1ZwYGYMV++4brwwK2KoUKfq5/OWj7qLmQrhGJKErtigREvaoS+U4G9zbAfNqtd4gEBRWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KjMhvunV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a5257748e1so244893f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 14:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749677881; x=1750282681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sVTr2qGQ6crKPPGVbxVvbxdCkwGuO8w6ti1rBANX8lQ=;
        b=KjMhvunVHJBrrcdG4kyKa3wTSl41dgAvDfHe2s4pim9+ORxtHrEaC4E/OlFwmLbfK+
         XKNDCHHeDrqNVXxM01SVG6NH8o7qYIr7Q3yOFIaQ4Gj2bVOPSw8DukrMr0Dd4M7VKtr1
         W8NVAxgd93T+/vlUbdZvMyoHM88Ydi91EY/G9Uf2HRMSdT9Pr0veJB42s9BG3cMOac5a
         cCCmAcg7YU+zfRIVogjUmED6ekEZsUzgwP8rEfkZhPSaPOMXya8wpjbAFNDio03Cea7K
         DLUQzAULR0pCV41P3lJKJvjIfeYW6bHPC5UNOmzwOJSMm2hw60Rqq7HF7AuqkZH6g4cA
         8sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749677881; x=1750282681;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVTr2qGQ6crKPPGVbxVvbxdCkwGuO8w6ti1rBANX8lQ=;
        b=GRsO6mljoPq1F9PnUtGGDu6RBajAzMGpieFhZcV8QbgU0C7sAiEAzC9hUOCcxHz6Gj
         wQpvfAqtaN1uJNdGuSBUnG7l5acA4p2fwcMDNXQmGamh1p+HtNteAJ6mFToCDnfVKhBK
         l3frMr7j61t+5O1Az3yBHgxWtafhYhSFV1FB1pZ6YCoQDl99GMi625d1ujnuPCEc0SoW
         ZbfNEXTYJMtlOfHMxB3PY/gUuJHcmxx5NphKPR8fVt+UiyIa1t/ouylbme3vwPKqBosf
         V7IBHhAlgKavGXGyU0JE3xpCAjUaiqC5o+nBqh9H9pIOb38lE9EQ78OsAwYy6ZfkH6Sc
         QFrw==
X-Forwarded-Encrypted: i=1; AJvYcCWDRYRDnfPV5y0uolSGu5sRrZZXf9mS+Si+mYyOV8AZ/PD/orRQayz+GZwg1BZg4Wrmg8mJMkdzp4PEVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGI2hfbZ7pKsHe1YGHGqpe3SzlPUB9drSxeupwNXIjf4DZXdV4
	scDrZ9igiKqWPyW+s5W+OplDCyx65ebUi4oXces3n4Zs43B0egTe3GZGMJbzfWanT/E=
X-Gm-Gg: ASbGncv15IUrHYF4blFKqxU/Xz/zh8x1HgCTJPjgjI5+smLPhMQdJxh5X6blyeUxFJC
	GfEwEbVSZZwDkb7y1G3ujKCm4T3ewiCKxjjyCMkFHvRlOdLU2s9QDgkHTrujk3+mLv0iUREJu2E
	AaipcWAjxbIU3cJxmjQTL6x63TcuSr30OpJfvaGc3UIJ80xUdgyG+xQrBbCK1wFw9B2BzOILRQv
	lzVh9FYkbosE2eg0YwhFRkChAd65t7JwvKhg5ii3AzMeLI1S2fQad0J/frGEB4Fgu9VMelf92F9
	7wQnLKlsweSHGKcU3rRHph3xPkHhs7MHscwanFr9Ncr/zi3bbH9aLBJ15WERsQeM4rRw6wXlYoQ
	Skvo3tiInJGvD9g==
X-Google-Smtp-Source: AGHT+IEKx3/rWKP2k2pdELVmQLpnrBbt70zj8q9xr+rOuS07et1peo7eXDplr/LVokgbBgJg3DnaMg==
X-Received: by 2002:a05:6000:40c7:b0:3a5:25e0:ab53 with SMTP id ffacd0b85a97d-3a561349677mr355452f8f.32.1749677880641;
        Wed, 11 Jun 2025 14:38:00 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748808963f6sm40342b3a.55.2025.06.11.14.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 14:38:00 -0700 (PDT)
Message-ID: <2b1e6373-9621-4c26-8a46-d0ef15c5f5d6@suse.com>
Date: Thu, 12 Jun 2025 07:07:55 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] btrfs: call btrfs_close_devices from ->kill_sb
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>, Christoph Hellwig <hch@lst.de>,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250611100303.110311-1-jth@kernel.org>
 <20250611100303.110311-3-jth@kernel.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20250611100303.110311-3-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/11 19:33, Johannes Thumshirn 写道:
> From: Christoph Hellwig <hch@lst.de>
> 
> blkdev_put must not be called under sb->s_umount

Btrfs doesn't utilize blkdev_put(), it only calls regular fput() which 
do delayed cleanup.

So you may want to apply this patch first:

https://lore.kernel.org/linux-btrfs/eaf6ba3672a82ba940678d269ab16f8a702eaf32.1749446257.git.wqu@suse.com/T/#u

> to avoid a lock order
> reversal with disk->open_mutex once call backs from block devices to
> the file system using the holder ops are supported.  Move the call
> to btrfs_close_devices into btrfs_free_fs_info so that it is closed
> from ->kill_sb (which is also called from the mount failure handling
> path unlike ->put_super) as well as when an fs_info is freed because
> an existing superblock already exists.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/disk-io.c |  4 ++--
>   fs/btrfs/super.c   | 29 ++++++++++++++++-------------
>   2 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0d6ad7512f21..6360d44acaa9 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1247,6 +1247,8 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
>   	struct percpu_counter *em_counter = &fs_info->evictable_extent_maps;
>   
>   	percpu_counter_destroy(&fs_info->stats_read_blocks);
> +	if (fs_info->fs_devices)
> +		btrfs_close_devices(fs_info->fs_devices);
>   	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
>   	percpu_counter_destroy(&fs_info->delalloc_bytes);
>   	percpu_counter_destroy(&fs_info->ordered_bytes);
> @@ -3681,7 +3683,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   
>   	iput(fs_info->btree_inode);
>   fail:
> -	btrfs_close_devices(fs_info->fs_devices);
>   	ASSERT(ret < 0);
>   	return ret;
>   }
> @@ -4428,7 +4429,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
>   	iput(fs_info->btree_inode);
>   
>   	btrfs_mapping_tree_free(fs_info);
> -	btrfs_close_devices(fs_info->fs_devices);
>   }
>   
>   void btrfs_mark_buffer_dirty(struct btrfs_trans_handle *trans,
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index b9e08a59da4e..eaecf1525078 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1869,10 +1869,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>   	if (ret)
>   		return ret;
>   
> -	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
> -		ret = -EACCES;
> -		goto error;
> -	}
> +	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0)
> +		return -EACCES;
>   
>   	bdev = fs_devices->latest_dev->bdev;
>   
> @@ -1886,21 +1884,20 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>   	 * otherwise it's tied to the lifetime of the super_block.
>   	 */
>   	sb = sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
> -	if (IS_ERR(sb)) {
> -		ret = PTR_ERR(sb);
> -		goto error;
> -	}
> +	if (IS_ERR(sb))
> +		return PTR_ERR(sb);
>   
>   	set_device_specific_options(fs_info);
>   
>   	if (sb->s_root) {
> -		btrfs_close_devices(fs_devices);
>   		/*
>   		 * At this stage we may have RO flag mismatch between
>   		 * fc->sb_flags and sb->s_flags.  Caller should detect such
>   		 * mismatch and reconfigure with sb->s_umount rwsem held if
>   		 * needed.
>   		 */
> +		if ((fc->sb_flags ^ sb->s_flags) & SB_RDONLY)
> +			ret = -EBUSY;
>   	} else {
>   		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
>   		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
> @@ -1916,10 +1913,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>   
>   	fc->root = dget(sb->s_root);
>   	return 0;
> -
> -error:
> -	btrfs_close_devices(fs_devices);
> -	return ret;
>   }
>   
>   /*
> @@ -1997,8 +1990,18 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>    */
>   static int btrfs_reconfigure_for_mount(struct fs_context *fc)
>   {
> +	struct btrfs_fs_info *fs_info = fc->s_fs_info;
>   	int ret = 0;
>   
> +	/*
> +	 * We got a reference to our fs_devices, so we need to close it here to
> +	 * make sure we don't leak our reference on the fs_devices.
> +	 */
> +	if (fs_info->fs_devices) {
> +		btrfs_close_devices(fs_info->fs_devices);
> +		fs_info->fs_devices = NULL;
> +	}
> +

This is what I didn't get, there is really nothing special for 
btrfs_reconfigure_for_mount() nowadays, we always go into this function 
and I didn't see any special reason why we always want to close all 
devices here.

Mind to explain it more like where the reference is from, and why it can 
be leaked?

Thanks,
Qu

>   	if (!(fc->sb_flags & SB_RDONLY) && (fc->root->d_sb->s_flags & SB_RDONLY))
>   		ret = btrfs_reconfigure(fc);
>   


