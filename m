Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EE31BA7F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 17:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgD0PaV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 11:30:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:56222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgD0PaU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 11:30:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3C97BAD81;
        Mon, 27 Apr 2020 15:30:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 429D2DA781; Mon, 27 Apr 2020 17:29:35 +0200 (CEST)
Date:   Mon, 27 Apr 2020 17:29:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: transaction: Avoid deadlock due to bad
 initialization timing of fs_info::journal_info
Message-ID: <20200427152934.GD18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200427065014.46502-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427065014.46502-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 27, 2020 at 02:50:14PM +0800, Qu Wenruo wrote:
> index 8cede6eb9843..132bf2f1aa0d 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -662,10 +662,19 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
>  	}
>  
>  got_it:
> -	btrfs_record_root_in_trans(h, root);
> -
>  	if (!current->journal_info)
>  		current->journal_info = h;
> +
> +	/*
> +	 * btrfs_record_root_in_trans() need to alloc new extents, and may
> +	 * call btrfs_join_transaction() while we're also starting a
> +	 * transaction.
> +	 *
> +	 * Thus it need to be called after current->journal_info initialized,
> +	 * or we can deadlock.
> +	 */
> +	btrfs_record_root_in_trans(h, root);

This applies cleanly on master, so that's fine as it'll go as a fix in
this dev cycle, but there's a conflict with misc-next patch "btrfs:
force chunk allocation if our global rsv is larger than metadata".

There's a chunk allocation added:

	btrfs_record_root_in_trans(...)
	if (!current->journal_info)
		...
	if (do_chunk_alloc ...)
		btrfs_chunk_alloc(...)

so the call btrfs_record_root_in_trans() should be moved after the chunk
allocation, to potentially use the newly added chunk. The merged order
is:

	if (!current->journal_info)
		...
	if (do_chunk_alloc ...)
		btrfs_chunk_alloc(...)
	btrfs_record_root_in_trans(...)

Please check if this is correct. Once this fix bubbles through master,
the conflicting patch in misc-next will have to be updated, but the end
result should remain. Thanks.
