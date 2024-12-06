Return-Path: <linux-btrfs+bounces-10096-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADD99E76D3
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 18:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6692C162E0C
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 17:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575A21FFC41;
	Fri,  6 Dec 2024 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cFM3VnFe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+pcs8zkZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cFM3VnFe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+pcs8zkZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244111F63F0
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505205; cv=none; b=Crhlbzrt6LkS2I+6nuNqlgbp69jBZ0OjLZPyTYVBNpQxJuCrzD2jiiKNEbrLNSzo1GoJji8gPx0O9KsLj2DmZJTe/8Lj0KccqwwXKBk8E32DLbMst+Wxr8e7A2nwCD0HUs3u+3+heTkU04+PihOC1jB02CrtzDq14MouA55+Z0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505205; c=relaxed/simple;
	bh=QjICtYSi2JB+QKHPkFiJq2FzFtUTmjC8f7s8MS+IOBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGrAwQr9gapwun+r9DazOJEXVKN/SeG8686C8941CacQgM9y8f1QHHdeotoQZiC7ZAHNFZedmZ1vGov7KRUzZQxrPEAZc9/L4c+d0d4ZWuV5a02Drl4l1KV2NaYY7FP6oJrkbjCsVm6B7Qqx2MTAixSTdJuByEZCQphPJrS3BrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cFM3VnFe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+pcs8zkZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cFM3VnFe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+pcs8zkZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DFCB21108;
	Fri,  6 Dec 2024 17:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733505201;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9TcXnK+BsUnc/ifN4SgnRTsTimaO1eSpfLLQkR1XyY=;
	b=cFM3VnFevp30hJlcNSX7edIFbzmpH5+gpmc6TDbZC5k6C1UqYkvDHOaIS0HnrodPxYS8Oz
	pyAcuW7064fTjnGAL/eCrvCKO3SjXD+OVqgr5Z8EO5GDcmPlAAhb5zpfMdwMC+BCnMOZUr
	DUpRcJFxyTynO2sfE4ZhuNQROCeD+S0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733505201;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9TcXnK+BsUnc/ifN4SgnRTsTimaO1eSpfLLQkR1XyY=;
	b=+pcs8zkZqP8lVR9VlZbeOgkRqgZMvr94eINOJayjJaKEn4yP4ij2mhaSl9XATtzjTOz/wQ
	UzJXef4Ubhpm37AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733505201;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9TcXnK+BsUnc/ifN4SgnRTsTimaO1eSpfLLQkR1XyY=;
	b=cFM3VnFevp30hJlcNSX7edIFbzmpH5+gpmc6TDbZC5k6C1UqYkvDHOaIS0HnrodPxYS8Oz
	pyAcuW7064fTjnGAL/eCrvCKO3SjXD+OVqgr5Z8EO5GDcmPlAAhb5zpfMdwMC+BCnMOZUr
	DUpRcJFxyTynO2sfE4ZhuNQROCeD+S0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733505201;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9TcXnK+BsUnc/ifN4SgnRTsTimaO1eSpfLLQkR1XyY=;
	b=+pcs8zkZqP8lVR9VlZbeOgkRqgZMvr94eINOJayjJaKEn4yP4ij2mhaSl9XATtzjTOz/wQ
	UzJXef4Ubhpm37AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA73C13647;
	Fri,  6 Dec 2024 17:13:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sMUuMbAwU2eVGgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 06 Dec 2024 17:13:20 +0000
Date: Fri, 6 Dec 2024 18:13:19 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, wqu@suse.com,
	hrx@bupt.moe, waxhead@dirtcellar.net
Subject: Re: [PATCH v3 05/10] btrfs: introduce RAID1 round-robin read
 balancing
Message-ID: <20241206171319.GH31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1731076425.git.anand.jain@oracle.com>
 <995d4a9dd9f553825805efdac24dec4a9de20ef3.1731076425.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <995d4a9dd9f553825805efdac24dec4a9de20ef3.1731076425.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email];
	URIBL_BLOCKED(0.00)[suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,oracle.com:email];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Nov 15, 2024 at 10:54:05PM +0800, Anand Jain wrote:
> This feature balances I/O across the striped devices when reading from
> RAID1 blocks.
> 
>    echo round-robin:[min_contiguous_read] > /sys/fs/btrfs/<uuid>/read_policy

The ":" is part of the optional value, so the example should be
"round-robin[:min]"

> The min_contiguous_read parameter defines the minimum read size before
> switching to the next mirrored device. This setting is optional, with a
> default value of 256 KiB.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/sysfs.c   | 38 +++++++++++++++++++++++++++++
>  fs/btrfs/volumes.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.h |  9 +++++++
>  3 files changed, 107 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 7907507b8ced..092a78298d1a 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1305,7 +1305,11 @@ static ssize_t btrfs_temp_fsid_show(struct kobject *kobj,
>  }
>  BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
>  
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +static const char * const btrfs_read_policy_name[] = { "pid", "round-robin" };
> +#else
>  static const char * const btrfs_read_policy_name[] = { "pid" };
> +#endif

Instead of the duplication of the definition please put the #ifdef
around the experimental strings.

>  
>  static enum btrfs_read_policy btrfs_read_policy_to_enum(const char *str, s64 *value)
>  {
> @@ -1367,6 +1371,12 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>  
>  		ret += sysfs_emit_at(buf, ret, "%s", btrfs_read_policy_name[i]);
>  
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +		if (i == BTRFS_READ_POLICY_RR)
> +			ret += sysfs_emit_at(buf, ret, ":%d",
> +					     fs_devices->min_contiguous_read);

Maybe this should be printed with the suffix, "rr:256k".

> +#endif
> +
>  		if (i == policy)
>  			ret += sysfs_emit_at(buf, ret, "]");
>  	}
> @@ -1388,6 +1398,34 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
>  	if (index == -EINVAL)
>  		return -EINVAL;
>  
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +	if (index == BTRFS_READ_POLICY_RR) {
> +		if (value != -1) {
> +			if ((value % fs_devices->fs_info->sectorsize) != 0) {

I think 64bit types and % could lead to the division which fails on
32bit platforms. As it's the s64 type for no apparent reason a u32 would
be a better fit.

> +				btrfs_err(fs_devices->fs_info,
> +"read_policy: min_contiguous_read %lld should be multiples of the sectorsize %u",
> +					  value, fs_devices->fs_info->sectorsize);
> +				return -EINVAL;

This does not need to fail hard, we can simply round it up to the next
sector size multiple.

Also this does not validate the upper bound of value.

> +			}
> +		} else {
> +			/* value is not provided, set it to the default 256k */
> +			value = 256 * 1024;

Please use a named constant, then the comment is not necessary.

> +		}
> +
> +		if (index != READ_ONCE(fs_devices->read_policy) ||
> +		    value != READ_ONCE(fs_devices->min_contiguous_read)) {
> +			WRITE_ONCE(fs_devices->read_policy, index);
> +			WRITE_ONCE(fs_devices->min_contiguous_read, value);
> +			atomic_set(&fs_devices->total_reads, 0);
> +
> +			btrfs_info(fs_devices->fs_info, "read policy set to '%s:%lld'",
> +				   btrfs_read_policy_name[index], value);
> +
> +		}
> +
> +		return len;
> +	}
> +#endif
>  	if (index != READ_ONCE(fs_devices->read_policy)) {
>  		WRITE_ONCE(fs_devices->read_policy, index);
>  		btrfs_info(fs_devices->fs_info, "read policy set to '%s'",
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fe5ceea2ba0b..97576a715191 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1328,6 +1328,10 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>  	fs_devices->total_rw_bytes = 0;
>  	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
>  	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +	/* Set min_contiguous_read to a default 256kib */
> +	fs_devices->min_contiguous_read = 256 * 1024;

Named constant.

> +#endif
>  
>  	return 0;
>  }
> @@ -5959,6 +5963,57 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
>  	return len;
>  }
>  
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +struct stripe_mirror {
> +	u64 devid;
> +	int num;
> +};
> +
> +static int btrfs_cmp_devid(const void *a, const void *b)
> +{
> +	struct stripe_mirror *s1 = (struct stripe_mirror *)a;
> +	struct stripe_mirror *s2 = (struct stripe_mirror *)b;

Please keep the const qualifier.

> +
> +	if (s1->devid < s2->devid)
> +		return -1;
> +	if (s1->devid > s2->devid)
> +		return 1;
> +	return 0;
> +}
> +
> +static int btrfs_read_rr(struct btrfs_chunk_map *map, int first, int num_stripe)

Please add a comment explaining what the function does or how it selects
the device.

> +{
> +	struct stripe_mirror stripes[4] = {0}; //4: max possible mirrors

Another magic constant. We probably won't have more than 4 but it still
needs to be defined elsewhre. Also the comment format is wrong.

> +	struct btrfs_fs_devices *fs_devices;
> +	struct btrfs_device *device;
> +	int j;

This is used in the for loop only, so you can declare it as
for (int j = ...)

> +	int read_cycle;
> +	int index;
> +	int ret_stripe;
> +	int total_reads;
> +	int reads_per_dev = 0;
> +
> +	device = map->stripes[first].dev;
> +
> +	fs_devices = device->fs_devices;
> +	reads_per_dev = fs_devices->min_contiguous_read/fs_devices->fs_info->sectorsize;

Missing space around '/' and we have the sectorsize_bits so division can
be replaced by >>

> +	index = 0;
> +	for (j = first; j < first + num_stripe; j++) {

Actually you can use 'i' for iteration.

> +		stripes[index].devid = map->stripes[j].dev->devid;
> +		stripes[index].num = j;
> +		index++;
> +	}
> +	sort(stripes, num_stripe, sizeof(struct stripe_mirror),
> +	     btrfs_cmp_devid, NULL);
> +
> +	total_reads = atomic_inc_return(&fs_devices->total_reads);
> +	read_cycle = total_reads/reads_per_dev;

Missing spaces around "/"

> +	ret_stripe = stripes[read_cycle % num_stripe].num;
> +
> +	return ret_stripe;
> +}
> +#endif
> +
>  static int find_live_mirror(struct btrfs_fs_info *fs_info,
>  			    struct btrfs_chunk_map *map, int first,
>  			    int dev_replace_is_ongoing)
> @@ -5988,6 +6043,11 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
>  	case BTRFS_READ_POLICY_PID:
>  		preferred_mirror = first + (current->pid % num_stripes);
>  		break;
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +	case BTRFS_READ_POLICY_RR:
> +		preferred_mirror = btrfs_read_rr(map, first, num_stripes);
> +		break;
> +#endif
>  	}
>  
>  	if (dev_replace_is_ongoing &&
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 3a416b1bc24c..05778361c270 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -303,6 +303,10 @@ enum btrfs_chunk_allocation_policy {
>  enum btrfs_read_policy {
>  	/* Use process PID to choose the stripe */
>  	BTRFS_READ_POLICY_PID,
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +	/* Balancing raid1 reads across all striped devices (round-robin) */
> +	BTRFS_READ_POLICY_RR,
> +#endif
>  	BTRFS_NR_READ_POLICY,
>  };
>  
> @@ -431,6 +435,11 @@ struct btrfs_fs_devices {
>  	enum btrfs_read_policy read_policy;
>  
>  #ifdef CONFIG_BTRFS_EXPERIMENTAL
> +	/* IO stat, read counter. */
> +	atomic_t total_reads;
> +	/* Min contiguous reads before switching to next device. */
> +	int min_contiguous_read;

As this is in the fs_devices, there should be some prefix that it's
related to the read policy or round robin.

> +
>  	/* Checksum mode - offload it or do it synchronously. */
>  	enum btrfs_offload_csum_mode offload_csum_mode;
>  #endif
> -- 
> 2.46.1
> 

