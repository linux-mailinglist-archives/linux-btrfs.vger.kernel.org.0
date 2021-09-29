Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3A041C398
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 13:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244681AbhI2Lp3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 07:45:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56178 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhI2Lp3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 07:45:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B15A01FFE8;
        Wed, 29 Sep 2021 11:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632915827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2jBlOP97O62KzPmJvkWSaB8bbBcsnROTzxdpzRodRm0=;
        b=hHExvQTdugZqY6wNh4frTqY8MAqjQdmx+dQSaEIoCluyJOLyeAVTAhpE7KsM1gfVWSzsaC
        jFxuZ8sr53ZFdzJyomvD5iROjOdAtoQN8V6ywes1QmOCK4MyI3X+//SXSnkpNH1AV4OtEi
        Fcy0PikKhcP2iWtfz9Duyfju0LMVF7o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C3C013FBD;
        Wed, 29 Sep 2021 11:43:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CvvkG3NRVGETFQAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 29 Sep 2021 11:43:47 +0000
Subject: Re: [PATCH] btrfs: index free space entries on size
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <449df997c354fb9d074bf5f7d32bffc082386c4f.1632750544.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <ca935b82-0d4b-8bef-e1c2-4b541dcbf3d4@suse.com>
Date:   Wed, 29 Sep 2021 14:43:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <449df997c354fb9d074bf5f7d32bffc082386c4f.1632750544.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 27.09.21 г. 16:56, Josef Bacik wrote:

<snip>

> ---
>  fs/btrfs/free-space-cache.c | 79 +++++++++++++++++++++++++++++++------
>  fs/btrfs/free-space-cache.h |  2 +
>  2 files changed, 69 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 0d26819b1cf6..d6eaf51ee597 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -1576,6 +1576,38 @@ static int tree_insert_offset(struct rb_root *root, u64 offset,
>  	return 0;
>  }
>  
> +static u64 free_space_info_bytes(struct btrfs_free_space *info)
> +{
> +	if (info->bitmap && info->max_extent_size)
> +		return info->max_extent_size;
> +	return info->bytes;
> +}
> +
> +static void tree_insert_bytes(struct btrfs_free_space_ctl *ctl,
> +			      struct btrfs_free_space *info)
> +{
> +	struct rb_root_cached *root = &ctl->free_space_bytes;
> +	struct rb_node **p = &root->rb_root.rb_node;
> +	struct rb_node *parent_node = NULL;
> +	struct btrfs_free_space *tmp;
> +	bool leftmost = true;
> +
> +	while (*p) {
> +		parent_node = *p;
> +		tmp = rb_entry(parent_node, struct btrfs_free_space,
> +			       bytes_index);
> +		if (free_space_info_bytes(info) < free_space_info_bytes(tmp)) {
> +			p = &(*p)->rb_right;
> +			leftmost = false;

According to this the leftmost node is the largest available extent?
This is slightly counter intuitive, as general it's regarded that the
nodes left of the current one are smaller than it, whilst this
completely turns the concept upside down. I assume that's due to the
"cached" version of the rb tree and wanting to utilize the cached node
to hold the largest one. Perhaps a slight comment to sharpen attention
to future readers might be beneficial.

> +		} else {
> +			p = &(*p)->rb_left;
> +		}
> +	}
> +
> +	rb_link_node(&info->bytes_index, parent_node, p);
> +	rb_insert_color_cached(&info->bytes_index, root, leftmost);
> +}
> +
>  /*
>   * searches the tree for the given offset.
>   *
> @@ -1704,6 +1736,7 @@ __unlink_free_space(struct btrfs_free_space_ctl *ctl,
>  		    struct btrfs_free_space *info)
>  {
>  	rb_erase(&info->offset_index, &ctl->free_space_offset);
> +	rb_erase_cached(&info->bytes_index, &ctl->free_space_bytes);
>  	ctl->free_extents--;
>  
>  	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
> @@ -1730,6 +1763,8 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
>  	if (ret)
>  		return ret;
>  
> +	tree_insert_bytes(ctl, info);
> +
>  	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
>  		ctl->discardable_extents[BTRFS_STAT_CURR]++;
>  		ctl->discardable_bytes[BTRFS_STAT_CURR] += info->bytes;
> @@ -1876,7 +1911,7 @@ static inline u64 get_max_extent_size(struct btrfs_free_space *entry)
>  /* Cache the size of the max extent in bytes */
>  static struct btrfs_free_space *
>  find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
> -		unsigned long align, u64 *max_extent_size)
> +		unsigned long align, u64 *max_extent_size, bool use_bytes_index)
>  {
>  	struct btrfs_free_space *entry;
>  	struct rb_node *node;
> @@ -1887,15 +1922,28 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
>  	if (!ctl->free_space_offset.rb_node)
>  		goto out;
>  
> -	entry = tree_search_offset(ctl, offset_to_bitmap(ctl, *offset), 0, 1);
> -	if (!entry)
> -		goto out;
> +	if (use_bytes_index) {
> +		node = rb_first_cached(&ctl->free_space_bytes);
> +	} else {
> +		entry = tree_search_offset(ctl, offset_to_bitmap(ctl, *offset),
> +					   0, 1);
> +		if (!entry)
> +			goto out;
> +		node = &entry->offset_index;
> +	}
>  
> -	for (node = &entry->offset_index; node; node = rb_next(node)) {
> -		entry = rb_entry(node, struct btrfs_free_space, offset_index);
> +	for (; node; node = rb_next(node)) {
> +		if (use_bytes_index)
> +			entry = rb_entry(node, struct btrfs_free_space,
> +					 bytes_index);
> +		else
> +			entry = rb_entry(node, struct btrfs_free_space,
> +					 offset_index);
>  		if (entry->bytes < *bytes) {
>  			*max_extent_size = max(get_max_extent_size(entry),
>  					       *max_extent_size);
> +			if (use_bytes_index)
> +				break;
>  			continue;
>  		}

This hunk is somewhat subtle, because:

1. First you get the largest free space (in case we are using
use_bytes_index). So say we want 5k and the largest index is 5m we are
going to return 5m by doing rb_first_cached.

2. The for() loop then likely terminates on the first iteration because
the largest extent is already too large. However I think this function
should be refactored, because the "indexed by size" case really works in
O(1) complexity. You take the largest available space via
rb_first_cached, then perform all the alignments checks in the body of
the loop and return the chunk if it satisfies them or execute the newly
added break.

This insight is really lost within the surrounding code, majority of
which exists for the "indexed by offset" case.

<snip>
