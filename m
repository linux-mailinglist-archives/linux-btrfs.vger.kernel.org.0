Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2169D2B859B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 21:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgKRU3c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 15:29:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:43908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgKRU3c (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 15:29:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D0CDAC65;
        Wed, 18 Nov 2020 20:29:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A6B72DA701; Wed, 18 Nov 2020 21:27:45 +0100 (CET)
Date:   Wed, 18 Nov 2020 21:27:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 04/24] btrfs: extent_io: introduce helper to handle
 page status update in end_bio_extent_readpage()
Message-ID: <20201118202745.GG20563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-5-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-5-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:29PM +0800, Qu Wenruo wrote:
> Introduce a new helper, endio_readpage_release_extent(), to handle
> update status update in end_bio_extent_readpage().
> 
> The refactor itself is not really nothing interesting, the point here is
> to provide the basis for later subpage support, where the page status
> update can be more complex than current code.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index b5b3700943e0..caafe44542e8 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2849,6 +2849,17 @@ endio_readpage_release_extent(struct processed_extent *processed,
>  	processed->uptodate = uptodate;
>  }
>  
> +static void endio_readpage_update_page_status(struct page *page, bool uptodate)
> +{
> +	if (uptodate) {
> +		SetPageUptodate(page);
> +	} else {
> +		ClearPageUptodate(page);
> +		SetPageError(page);
> +	}
> +	unlock_page(page);

That would be better left in the caller as it's quite important
information but the helper name does not say anything about it.
