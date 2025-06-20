Return-Path: <linux-btrfs+bounces-14834-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8CDAE25BC
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Jun 2025 00:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6983B9829
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 22:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE0C23C4F9;
	Fri, 20 Jun 2025 22:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ADSLt6eC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479D01E1E06
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750458554; cv=none; b=AfCyvVdhm2u4pglwscUUs1eyjZicC0CZtdcN2VbR/5BdGQCSr9p6nMQPye8g9EC4fLGDcIG/bGwUskttHvs5yuYDWLQAmaVHB29T29lw2HvQuP46jOdYPwtHAkWBFXLzgs6jxh4lij8sO/Kwbm6W+IuIqpTy2tQNhpDsG2o1nxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750458554; c=relaxed/simple;
	bh=HrWx1aLg++h1TyjkSpd1s44MbZzuBlSsJv4FmSdOs50=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e3/BOZBoXqdqjQwl57fXlOcyvqN2olmMzbJDjsrGNrhxzuNchkaTv0NvMEZI9s2MI96bAWjK6yJddEjB9cVBy88lCUSNKlJy4E24MnD0iwK6gl43rpaUDF3wX+N0qB17KI+BT7l7/yF0KSSeIpGbmua0Ajxf9aL93lJ21jrcPt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ADSLt6eC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso664046f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 15:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750458549; x=1751063349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+ovwQWhUGx5OnUn3PeV5RrUWGEUl2YB3J5kUfTcFsM8=;
        b=ADSLt6eCQBp6GExt0HVo7sF9swbVBpsTO0XyYfYO9PVzetH50f87N2r69DDmGzb3k4
         BBBqEd9tpMjMazHmS0q/Ma4B79uG9Fs3/cIgZLWWj3Yeuz+B45JXzlah3ViKUBDAWYap
         ujTgqjRAOezwSBtL40a/U+RLrSws1VHviHb/YF9+hCVB/Yi7FT0U4jJLcg7TE2vOqOWH
         NN15erIscek8vUkzSdnqCazoJiSywuzweVwlH7qnjxMMcIaGL4GI2uxmiD8IT2RfZ+OZ
         ft+bdGq3BccWUs9cmF4y0kE3/v5LbpNKYnZAxRlIEm+S0wlI6l0hV9qZMJhOkXb7SWoa
         JuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750458549; x=1751063349;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ovwQWhUGx5OnUn3PeV5RrUWGEUl2YB3J5kUfTcFsM8=;
        b=UnTQCVlN5MkfcRNACyJxFGUDYTdeRL79GraCrXbSzw2dhiM0t5odjoyGlZp+XBYiMe
         KMXRR3x16sGEVay5QO3u6ATu5bUmFvFQHMhYwW5R9ehCipnLjCuofwnnvZwzGq9I52Td
         AfLCMjIZ0MztbAn4WwFLysqHPhqV9kckGR+4vjT0fr/sDNgKfYHjfX4M/DzQQeDgcGfu
         tgobrYM7kbQfKdtH461sJZ3JpAmlWtLT4Yh8XhIdBUgbuoMH7OgYKUqkuxvKuHKKJ0Dv
         /Eeze3v50KwJfNxByDxKyndx2uyjpBaFWy8wA7o2UJtKhTMDDVSxWVk40GGPBndw9jx/
         xqJg==
X-Forwarded-Encrypted: i=1; AJvYcCVy6x624vUlquonODee6Ga/pHpy//9h2YKF1EqOiZAx8DfG4QK9hqk/cm5VRz2Yb+0LOSVhyWJZ1rdFQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh0iPmNQnrn6H7NqjXOxWvMWYahfJ1opgx0PcldZzDRq6Thzop
	fxDNOgjtBj9vht93+aPD3jvXj5rQ7qWhOMANuv7evsOZ/e8Dq/N9BUUi3LsW6QlR/+8=
X-Gm-Gg: ASbGnctGeHD0TRkiCUlypjIU03GX60JnvKQOPglVVZRMFpdlFUJYGGzniQf1a3igreF
	ZAdEMtyTvW3Ys6+iRT8WeyFZo75Ai5l2SWagoOwZT4n9Km9nM6deYI1eciGRlqpSX42RfwSAhrD
	r+2kS6fAtjPW1vGpGKxTZZIcORtCyexepCKOOvI9h7EGL76BgYphy9ER+7B9q9YPm1ovVv4v9a9
	XcBXQ7IdhzkByPG5iGc+w81GlVa36sEM3/C/Af9EPc/CeN9zgy9bhPfR7iNgJ8sYkqeRSNlbctt
	er9Wwi5oBvMyTZ1u4dlXF2ov895sFSNZLWaLhp5A9DXFwzAGYOP80VBpgl5zZ8ogbF4mDpRxxry
	iiVYPKUJPLer3JkqHwZ/jyvvM
X-Google-Smtp-Source: AGHT+IHyPZ3Lq0gBBzUoxabIgntOXaSzM8n5trwuIatP9URfnK3aBQQIt//hDqu6FTJNB9Jvr99CLw==
X-Received: by 2002:a05:6000:188c:b0:3a5:39a0:2309 with SMTP id ffacd0b85a97d-3a6d12ec198mr3819588f8f.55.1750458549278;
        Fri, 20 Jun 2025 15:29:09 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a334211sm5000541a91.48.2025.06.20.15.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 15:29:08 -0700 (PDT)
Message-ID: <203ead44-d0b4-4edb-907d-5134ac95e1ce@suse.com>
Date: Sat, 21 Jun 2025 07:59:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use our message helpers instead of
 pr_err/pr_warn/pr_info
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20250620160645.3744830-1-dsterba@suse.com>
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
In-Reply-To: <20250620160645.3744830-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/21 01:36, David Sterba 写道:
> Our message helpers accept NULL for the fs_info in the context that does
> not provide and print the common header of the message. The use of pr_*
> helpers is only for special reasons, like module loading, device
> scanning or multi-line output (print-tree).
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/compression.c    | 10 +++++-----
>   fs/btrfs/disk-io.c        |  2 +-
>   fs/btrfs/extent-io-tree.c |  3 ++-
>   fs/btrfs/extent_io.c      |  4 ++--
>   fs/btrfs/print-tree.c     |  2 +-
>   fs/btrfs/sysfs.c          |  5 ++---
>   fs/btrfs/volumes.c        |  8 ++++----
>   fs/btrfs/zstd.c           |  3 +--
>   8 files changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 48d07939fee4a0..a4934eb1ecdc99 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -789,8 +789,8 @@ static void btrfs_init_workspace_manager(int type)
>   	 */
>   	workspace = alloc_workspace(type, 0);
>   	if (IS_ERR(workspace)) {
> -		pr_warn(
> -	"BTRFS: cannot preallocate compression workspace, will try later\n");
> +		btrfs_warn(NULL,
> +			   "cannot preallocate compression workspace, will try later");
>   	} else {
>   		atomic_set(&wsm->total_ws, 1);
>   		wsm->free_ws = 1;
> @@ -888,9 +888,9 @@ struct list_head *btrfs_get_workspace(int type, int level)
>   					/* once per minute */ 60 * HZ,
>   					/* no burst */ 1);
>   
> -			if (__ratelimit(&_rs)) {
> -				pr_warn("BTRFS: no compression workspaces, low memory, retrying\n");
> -			}
> +			if (__ratelimit(&_rs))
> +				btrfs_warn(NULL,
> +				"no compression workspaces, low memory, retrying");
>   		}
>   		goto again;
>   	}
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0cd22952286358..1f8abc3f4f8bf7 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3995,7 +3995,7 @@ int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags)
>   	}
>   
>   	if (min_tolerated == INT_MAX) {
> -		pr_warn("BTRFS: unknown raid flag: %llu", flags);
> +		btrfs_warn(NULL, "unknown raid flag: %llu", flags);
>   		min_tolerated = 0;
>   	}
>   
> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index 84da01996336c1..66361325f6dcea 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -43,7 +43,8 @@ static inline void btrfs_extent_state_leak_debug_check(void)
>   
>   	while (!list_empty(&states)) {
>   		state = list_first_entry(&states, struct extent_state, leak_list);
> -		pr_err("BTRFS: state leak: start %llu end %llu state %u in tree %d refs %d\n",
> +		btrfs_err(NULL,
> +		       "state leak: start %llu end %llu state %u in tree %d refs %d",
>   		       state->start, state->end, state->state,
>   		       extent_state_in_tree(state),
>   		       refcount_read(&state->refs));
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c8c53a008c5315..aec2a7390b5c1c 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -75,8 +75,8 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
>   	while (!list_empty(&fs_info->allocated_ebs)) {
>   		eb = list_first_entry(&fs_info->allocated_ebs,
>   				      struct extent_buffer, leak_list);
> -		pr_err(
> -	"BTRFS: buffer leak start %llu len %u refs %d bflags %lu owner %llu\n",
> +		btrfs_err(fs_info,
> +		       "buffer leak start %llu len %u refs %d bflags %lu owner %llu",
>   		       eb->start, eb->len, refcount_read(&eb->refs), eb->bflags,
>   		       btrfs_header_owner(eb));
>   		list_del(&eb->leak_list);
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index 21605b03f51188..74e38da9bd39cd 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -190,7 +190,7 @@ static void print_uuid_item(const struct extent_buffer *l, unsigned long offset,
>   			    u32 item_size)
>   {
>   	if (!IS_ALIGNED(item_size, sizeof(u64))) {
> -		pr_warn("BTRFS: uuid item with illegal size %lu!\n",
> +		btrfs_warn(l->fs_info, "uuid item with illegal size %lu",
>   			(unsigned long)item_size);
>   		return;
>   	}
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index b860470cffc4c8..9e7a812651e826 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -160,8 +160,7 @@ static int can_modify_feature(struct btrfs_feature_attr *fa)
>   		clear = BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR;
>   		break;
>   	default:
> -		pr_warn("btrfs: sysfs: unknown feature set %d\n",
> -				fa->feature_set);
> +		btrfs_warn(NULL, "sysfs: unknown feature set %d", fa->feature_set);
>   		return 0;
>   	}
>   
> @@ -2247,7 +2246,7 @@ void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action)
>   
>   	ret = kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, action);
>   	if (ret)
> -		pr_warn("BTRFS: Sending event '%d' to kobject: '%s' (%p): failed\n",
> +		btrfs_warn(NULL, "sending event %d to kobject: '%s' (%p): failed",
>   			action, kobject_name(&disk_to_dev(bdev->bd_disk)->kobj),
>   			&disk_to_dev(bdev->bd_disk)->kobj);
>   }
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0fbda06162594b..1b623bae927cff 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -675,8 +675,8 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>   	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING) {
>   		if (btrfs_super_incompat_flags(disk_super) &
>   		    BTRFS_FEATURE_INCOMPAT_METADATA_UUID) {
> -			pr_err(
> -		"BTRFS: Invalid seeding and uuid-changed device detected\n");
> +			btrfs_err(NULL,
> +				  "invalid seeding and uuid-changed device detected");
>   			goto error_free_page;
>   		}
>   
> @@ -820,7 +820,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   		if (same_fsid_diff_dev) {
>   			generate_random_uuid(fs_devices->fsid);
>   			fs_devices->temp_fsid = true;
> -		pr_info("BTRFS: device %s (%d:%d) using temp-fsid %pU\n",
> +			btrfs_info(NULL, "device %s (%d:%d) using temp-fsid %pU",
>   				path, MAJOR(path_devt), MINOR(path_devt),
>   				fs_devices->fsid);
>   		}
> @@ -1474,7 +1474,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>   
>   	devt = file_bdev(bdev_file)->bd_dev;
>   	if (btrfs_skip_registration(disk_super, path, devt, mount_arg_dev)) {
> -		pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
> +		btrfs_debug(NULL, "skip registering single non-seed device %s (%d:%d)",
>   			  path, MAJOR(devt), MINOR(devt));
>   
>   		btrfs_free_stale_devices(devt, NULL);
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index 4a796a049b5a24..ff0292615e1f37 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -200,8 +200,7 @@ void zstd_init_workspace_manager(void)
>   
>   	ws = zstd_alloc_workspace(ZSTD_BTRFS_MAX_LEVEL);
>   	if (IS_ERR(ws)) {
> -		pr_warn(
> -		"BTRFS: cannot preallocate zstd compression workspace\n");
> +		btrfs_warn(NULL, "cannot preallocate zstd compression workspace");
>   	} else {
>   		set_bit(ZSTD_BTRFS_MAX_LEVEL - 1, &wsm.active_map);
>   		list_add(ws, &wsm.idle_ws[ZSTD_BTRFS_MAX_LEVEL - 1]);


