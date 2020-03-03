Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8897D177D79
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 18:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbgCCRak (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 12:30:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:43482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgCCRak (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 12:30:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 99C33B153;
        Tue,  3 Mar 2020 17:30:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A5279DA7AE; Tue,  3 Mar 2020 18:30:15 +0100 (CET)
Date:   Tue, 3 Mar 2020 18:30:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 06/10] btrfs: relocation: Use wrapper to replace
 open-coded edge linking
Message-ID: <20200303173015.GL2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200302094553.58827-1-wqu@suse.com>
 <20200302094553.58827-7-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302094553.58827-7-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 02, 2020 at 05:45:49PM +0800, Qu Wenruo wrote:
> Since backref_edge is used to connect upper and lower backref nodes, and
> need to access both nodes, some code can look pretty nasty:
> 
> 		list_add_tail(&edge->list[LOWER], &cur->upper);
> 
> The above code will link @cur to the LOWER side of the edge, while both
> "LOWER" and "upper" words show up.
> This can sometimes be very confusing for reader to grasp.
> 
> This patch introduce a new wrapper, link_backref_edge(), to handle the
> linking behavior.
> Which also has extra ASSERT() to ensure caller won't pass wrong nodes
> in.
> 
> Also, this updates the comment of related lists of backref_node and
> backref_edge, to make it more clear that each list points to what.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/relocation.c | 53 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 04416489d87a..c76849409c81 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -91,10 +91,12 @@ struct backref_node {
>  	u64 owner;
>  	/* link to pending, changed or detached list */
>  	struct list_head list;
> -	/* list of upper level blocks reference this block */
> +
> +	/* List of upper level edges, which links this node to its parent(s) */
>  	struct list_head upper;
> -	/* list of child blocks in the cache */
> +	/* List of lower level edges, which links this node to its child(ren) */
>  	struct list_head lower;
> +
>  	/* NULL if this node is not tree root */
>  	struct btrfs_root *root;
>  	/* extent buffer got by COW the block */
> @@ -123,17 +125,26 @@ struct backref_node {
>  	unsigned int detached:1;
>  };
>  
> +#define LOWER	0
> +#define UPPER	1
> +#define RELOCATION_RESERVED_NODES	256
>  /*
> - * present a block pointer in the backref cache
> + * present an edge connecting upper and lower backref nodes.
>   */
>  struct backref_edge {
> +	/*
> +	 * list[LOWER] is linked to backref_node::upper of lower level node,
> +	 * and list[UPPER] is linked to backref_node::lower of upper level node.
> +	 *
> +	 * Also, build_backref_tree() uses list[UPPER] for pending edges, before
> +	 * linking list[UPPER] to its upper level nodes.
> +	 */
>  	struct list_head list[2];
> +
> +	/* Two related nodes */
>  	struct backref_node *node[2];
>  };
>  
> -#define LOWER	0
> -#define UPPER	1
> -#define RELOCATION_RESERVED_NODES	256
>  
>  struct backref_cache {
>  	/* red black tree of all backref nodes in the cache */
> @@ -332,6 +343,22 @@ static struct backref_edge *alloc_backref_edge(struct backref_cache *cache)
>  	return edge;
>  }
>  
> +#define		LINK_LOWER	(1 << 0)
> +#define		LINK_UPPER	(1 << 1)
> +static inline void link_backref_edge(struct backref_edge *edge,
> +				     struct backref_node *lower,
> +				     struct backref_node *upper,
> +				     int link_which)

Again not a static inline, but plain static function.

> +{
> +	ASSERT(upper && lower && upper->level == lower->level + 1);
> +	edge->node[LOWER] = lower;
> +	edge->node[UPPER] = upper;
> +	if (link_which & LINK_LOWER)
> +		list_add_tail(&edge->list[LOWER], &lower->upper);
> +	if (link_which & LINK_UPPER)
> +		list_add_tail(&edge->list[UPPER], &upper->lower);
> +}
