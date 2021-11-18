Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD7C4560D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 17:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhKRQqk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 11:46:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57154 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhKRQqh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 11:46:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 48DA21FD29;
        Thu, 18 Nov 2021 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637253815;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qlYuTiJ0ArdlnNgoFx0zHGrDjc4hOf2fdKQgZ/C13xs=;
        b=qp5r5INRdvLoz/FWi7E6l8Qc89Ok+ycX+XAh3iNETp9H75kHApHyp+ETah/i/l40VVBF73
        USrXYFc6S27q47stloJkU2vQf4lxfBrUUuj/pug28NKiUzjd0qdTd169XTqEX84Oo6AEoF
        B8RhO0d66OUW3eIOPxbFh2f/O8eT1wQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637253815;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qlYuTiJ0ArdlnNgoFx0zHGrDjc4hOf2fdKQgZ/C13xs=;
        b=5sVcG8ya7i0VK2Ig2q+RrexVhAoXs0tQvrzOlpy/fU7F8F9fzyUS0/86C2/T6EpI29xxXB
        2EobjWXiqk5VKNCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 409EFA3B90;
        Thu, 18 Nov 2021 16:43:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C3420DA735; Thu, 18 Nov 2021 17:43:30 +0100 (CET)
Date:   Thu, 18 Nov 2021 17:43:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v4 2/2] btrfs: index free space entries on size
Message-ID: <20211118164330.GI28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
References: <cover.1637248994.git.josef@toxicpanda.com>
 <41d72c6b01a1a1510015902d3a5a5729d3a159c5.1637248994.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41d72c6b01a1a1510015902d3a5a5729d3a159c5.1637248994.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 18, 2021 at 10:26:16AM -0500, Josef Bacik wrote:
> + */
> +static inline u64 get_max_extent_size(struct btrfs_free_space *entry)
> +{
> +	if (entry->bitmap && entry->max_extent_size)
> +		return entry->max_extent_size;
> +	return entry->bytes;
> +}
> +
> +/*
> + * This is indexed in reverse of what we generally do for rb-tree's, the largest
> + * chunks are left most and the smallest are rightmost.  This is so that we can
> + * take advantage of the cached property of the cached rb-tree and simply get
> + * the largest free space chunk right away.
> + */
> +static void tree_insert_bytes(struct btrfs_free_space_ctl *ctl,
> +			      struct btrfs_free_space *info)
> +{
> +	struct rb_root_cached *root = &ctl->free_space_bytes;
> +	struct rb_node **p = &root->rb_root.rb_node;

Please don't use single letter variables, other than 'i' for indexing.
For tree nodes I've been renaming it to 'node' in any new code.

> +	struct rb_node *parent_node = NULL;
> +	struct btrfs_free_space *tmp;
> +	bool leftmost = true;
> +
> +	while (*p) {
> +		parent_node = *p;
> +		tmp = rb_entry(parent_node, struct btrfs_free_space,
> +			       bytes_index);
> +		if (get_max_extent_size(info) < get_max_extent_size(tmp)) {
> +			p = &(*p)->rb_right;
> +			leftmost = false;
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
