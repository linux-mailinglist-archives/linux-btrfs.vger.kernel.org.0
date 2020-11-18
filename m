Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29772B8519
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 20:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgKRTuG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 14:50:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:59402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgKRTuF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 14:50:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B241FBE34;
        Wed, 18 Nov 2020 19:50:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0A33DDA701; Wed, 18 Nov 2020 20:48:18 +0100 (CET)
Date:   Wed, 18 Nov 2020 20:48:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v2 13/24] btrfs: handle sectorsize < PAGE_SIZE case for
 extent buffer accessors
Message-ID: <20201118194818.GD20563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-14-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-14-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:38PM +0800, Qu Wenruo wrote:
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1686,10 +1686,11 @@ static noinline int generic_bin_search(struct extent_buffer *eb,
>  		oip = offset_in_page(offset);
>  
>  		if (oip + key_size <= PAGE_SIZE) {
> -			const unsigned long idx = offset >> PAGE_SHIFT;
> +			const unsigned long idx = get_eb_page_index(offset);
>  			char *kaddr = page_address(eb->pages[idx]);
>  
> -			tmp = (struct btrfs_disk_key *)(kaddr + oip);
> +			tmp = (struct btrfs_disk_key *)(kaddr +
> +					get_eb_page_offset(eb, offset));

Here offset_in_page(offset) == get_eb_page_offset(eb, offset) and does
not need to be calculated again for both sector/page combinations. As
this is a hot path in search it sould be kept optimizied.
