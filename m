Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB3F3584F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 10:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfFEIE2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 04:04:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:46780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726543AbfFEIE2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 04:04:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AFE99B006
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jun 2019 08:04:27 +0000 (UTC)
Date:   Wed, 5 Jun 2019 10:04:27 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: Document __etree_search
Message-ID: <20190605080427.GC27972@x250>
References: <20190603100602.19362-1-nborisov@suse.com>
 <20190603100602.19362-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190603100602.19362-2-nborisov@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 03, 2019 at 01:05:59PM +0300, Nikolay Borisov wrote:
> The function has a lot of return values and specific conventions making
> it cumbersome to understand what's returned. Have a go at documenting
> its parameters and return values.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/extent_io.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index e56afb826517..d5979558c96f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -359,6 +359,22 @@ static struct rb_node *tree_insert(struct rb_root *root,
>  	return NULL;
>  }
>  
> +/**
> + * __etree_search - searches @tree for an entry that contains @offset. Such
> + * entry would have entry->start <= offset && entry->end >= offset.
> + *

This is missing @tree, make W=1 should warn about this.

> + * @offset - offset that should fall within an entry in @tree
> + * @next_ret - pointer to the first entry whose range ends after @offset
> + * @prev - pointer to the first entry whose range begins before @offset
> + * @p_ret - pointer where new node should be anchored (used when inserting an
> + *	    entry in the tree)
> + * @parent_ret - points to entry which would have been the parent of the entry,
> + * containing @offset
> + *
> + * This function returns a pointer to the entry that contains @offset byte
> + * address. If no such entry exists, then NULL is returned and the other
> + * pointer arguments to the function are filled.
> + */
>  static struct rb_node *__etree_search(struct extent_io_tree *tree, u64 offset,
>  				      struct rb_node **next_ret,
>  				      struct rb_node **prev_ret,
> -- 
> 2.17.1
> 

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
