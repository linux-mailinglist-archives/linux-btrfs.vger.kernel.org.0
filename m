Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3B1ED47C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 20:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfJKSim (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 14:38:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:35392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728603AbfJKSim (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 14:38:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07E9FAB91;
        Fri, 11 Oct 2019 18:38:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BC3B9DA808; Fri, 11 Oct 2019 20:38:54 +0200 (CEST)
Date:   Fri, 11 Oct 2019 20:38:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix metadata space leak on fixup worker failure
 to set range as delalloc
Message-ID: <20191011183854.GI2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20191009164359.29642-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009164359.29642-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 09, 2019 at 05:43:59PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In the fixup worker, if we fail to mark the range as delalloc in the io
> tree, we must release the previously reserved metadata, as well as update
> the outstanding extents counter for the inode, otherwise we leak metadata
> space.
> 
> In pratice we can't return an error from btrfs_set_extent_delalloc(),
> which is just a wrapper around __set_extent_bit(), as for most errors
> __set_extent_bit() does a BUG_ON() (or panics which hits a BUG_ON() as
> well) and returning an -EEXIST error doesn't happen in this case since
> the exclusive bits parameter always has a value of 0 through this code
> path. Nevertheless, just fix the error handling in the fixup worker,
> in case one day __set_extent_bit() can return an error to this code
> path.
> 
> Fixes: f3038ee3a3f101 ("btrfs: Handle btrfs_set_extent_delalloc failure in fixup worker")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.

> @@ -2201,12 +2201,16 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
>  		mapping_set_error(page->mapping, ret);
>  		end_extent_writepage(page, ret, page_start, page_end);
>  		ClearPageChecked(page);
> -		goto out;
> +		goto out_reserved;
>  	}
>  
>  	ClearPageChecked(page);
>  	set_page_dirty(page);
> -	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE, false);
> +out_reserved:
> +	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE, ret != 0);

This is a shortcut to avoid extra variable to track the status of the
3rd parameter (qgroup_free) but as the goto and label are only a few
lines apart, I guess it's ok.

> +	if (ret)
> +		btrfs_delalloc_release_space(inode, data_reserved, page_start,
> +					     PAGE_SIZE, true);
