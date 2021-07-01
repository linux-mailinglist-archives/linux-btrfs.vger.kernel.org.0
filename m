Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4E53B94E2
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 18:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhGAQya (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 12:54:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33652 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhGAQya (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 12:54:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CBCB2228F9;
        Thu,  1 Jul 2021 16:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625158318;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p9oHoPTIXFCe+WjTip4lXsElY93J9xJTz/tpKoV6MEc=;
        b=DPe32tqoS9ErHnT4GdGueA/P6/Fv2RbOBpDAZ1GNKmDUHPWeAr65KnLvCWhg1BcdaWf/2d
        qGmuduCJKVFsps1fpS9DZsKm6dv3U8o1Agqj6uP2xg5GrK51/NEOkIyiBHrcJAqcy8KokP
        8Y3yGCNcsC+UyLPpACs9BCBwVssGUac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625158318;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p9oHoPTIXFCe+WjTip4lXsElY93J9xJTz/tpKoV6MEc=;
        b=tt1ooKiUjep/MXIqoLBFIFDrxbgX5EjD0Y3Ci7VA388kTmhnYeLLZzvfdpzFddeojf9XzQ
        bXdjpxC34tOdamBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C4810A3B87;
        Thu,  1 Jul 2021 16:51:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 321E3DA6FD; Thu,  1 Jul 2021 18:49:28 +0200 (CEST)
Date:   Thu, 1 Jul 2021 18:49:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 02/10] btrfs: defrag: extract the page preparation
 code into one helper
Message-ID: <20210701164928.GX2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210610050917.105458-1-wqu@suse.com>
 <20210610050917.105458-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610050917.105458-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 10, 2021 at 01:09:09PM +0800, Qu Wenruo wrote:
> In cluster_pages_for_defrag(), we have complex code block inside one
> for() loop.
> 
> The code block is to prepare one page for defrag, this will ensure:
> - The page is locked and set up properly
> - No ordered extent exists in the page range
> - The page is uptodate
> - The writeback has finished
> 
> This behavior is pretty common and will be reused by later defrag
> rework.
> 
> So extract the code into its own helper, defrag_prepare_one_page(), for
> later usage, and cleanup the code by a little.
> 
> Since we're here, also make the page check to be subpage compatible,
> which means we will also check page::private, not only page->mapping.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ioctl.c | 151 +++++++++++++++++++++++++++--------------------
>  1 file changed, 86 insertions(+), 65 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 05af6f5ff3ff..a06ceb8fdf28 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1143,6 +1143,89 @@ static int should_defrag_range(struct inode *inode, u64 start, u32 thresh,
>  	return ret;
>  }
>  
> +/*
> + * Prepare one page to be defragged.
> + *
> + * This will ensure:
> + * - Returned page is locked and has been set up properly
> + * - No ordered extent exists in the page
> + * - The page is uptodate
> + * - The writeback has finished
> + */
> +static struct page *defrag_prepare_one_page(struct btrfs_inode *inode,
> +					    unsigned long index)
> +{
> +	struct address_space *mapping = inode->vfs_inode.i_mapping;
> +	gfp_t mask = btrfs_alloc_write_mask(mapping);
> +	u64 page_start = index << PAGE_SHIFT;

page index must be either pgoff_t or u64
