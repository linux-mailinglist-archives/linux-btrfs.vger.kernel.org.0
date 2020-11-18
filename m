Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D602B8294
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 18:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgKRRDL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 12:03:11 -0500
Received: from twin.jikos.cz ([91.219.245.39]:37771 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbgKRRDK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 12:03:10 -0500
Received: from twin.jikos.cz (dave@localhost [127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id 0AIG5Wcb014570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 18 Nov 2020 17:05:33 +0100
Received: (from dave@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) id 0AIG5WYF014569;
        Wed, 18 Nov 2020 17:05:32 +0100
Date:   Wed, 18 Nov 2020 17:05:32 +0100
From:   David Sterba <dave@jikos.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 03/24] btrfs: extent_io: replace
 extent_start/extent_len with better structure for end_bio_extent_readpage()
Message-ID: <20201118160532.74rfxqovyjymzipc@twin.jikos.cz>
Reply-To: dave@jikos.cz
Mail-Followup-To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-4-wqu@suse.com>
User-Agent: NeoMutt/20161028 (1.7.1)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:28PM +0800, Qu Wenruo wrote:
>  }
>  
> +/*
> + * Records previously processed extent range.
> + *
> + * For endio_readpage_release_extent() to handle a full extent range, reducing
> + * the extent io operations.
> + */
> +struct processed_extent {
> +	struct btrfs_inode *inode;
> +	u64 start;	/* file offset in @inode */
> +	u64 end;	/* file offset in @inode */

Please don't use the in-line comments for struct members.

> +	bool uptodate;
> +};
> +
> +/*
> + * Try to release processed extent range.
> + *
> + * May not release the extent range right now if the current range is contig

'contig' means what? If it's for 'contiguous' then please spell it out
in text and use the abbreviated form only for variables.

> + * with processed extent.
> + *
> + * Will release processed extent when any of @inode, @uptodate, the range is
> + * no longer contig with processed range.
> + * Pass @inode == NULL will force processed extent to be released.
> + */
>  static void
> -endio_readpage_release_extent(struct extent_io_tree *tree, u64 start, u64 len,
> -			      int uptodate)
> +endio_readpage_release_extent(struct processed_extent *processed,
> +			      struct btrfs_inode *inode, u64 start, u64 end,
> +			      bool uptodate)
>  {
>  	struct extent_state *cached = NULL;
> -	u64 end = start + len - 1;
> +	struct extent_io_tree *tree;
>  
> -	if (uptodate && tree->track_uptodate)
> -		set_extent_uptodate(tree, start, end, &cached, GFP_ATOMIC);
> -	unlock_extent_cached_atomic(tree, start, end, &cached);
> +	/* We're the first extent, initialize @processed */
> +	if (!processed->inode)
> +		goto update;
> +
> +	/*
> +	 * Contig with processed extent. Just uptodate the end
> +	 *
> +	 * Several things to notice:
> +	 * - Bio can be merged as long as on-disk bytenr is contig
> +	 *   This means we can have page belonging to other inodes, thus need to
> +	 *   check if the inode matches.
> +	 * - Bvec can contain range beyond current page for multi-page bvec
> +	 *   Thus we need to do processed->end + 1 >= start check
> +	 */
> +	if (processed->inode == inode && processed->uptodate == uptodate &&
> +	    processed->end + 1 >= start && end >= processed->end) {
> +		processed->end = end;
> +		return;
> +	}
> +
> +	tree = &processed->inode->io_tree;
> +	/*
> +	 * Now we have a range not contig with processed range, release the
> +	 * processed range now.
> +	 */
> +	if (processed->uptodate && tree->track_uptodate)
> +		set_extent_uptodate(tree, processed->start, processed->end,
> +				    &cached, GFP_ATOMIC);
> +	unlock_extent_cached_atomic(tree, processed->start, processed->end,
> +				    &cached);
> +
> +update:
> +	/* Update @processed to current range */
> +	processed->inode = inode;
> +	processed->start = start;
> +	processed->end = end;
> +	processed->uptodate = uptodate;
>  }
