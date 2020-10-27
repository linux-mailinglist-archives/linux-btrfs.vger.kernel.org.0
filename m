Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DB5299EBF
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Oct 2020 01:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409089AbgJ0APs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 20:15:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:33572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439632AbgJ0AOk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 20:14:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26DBAACD8;
        Tue, 27 Oct 2020 00:14:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8841CDA6E2; Tue, 27 Oct 2020 01:13:05 +0100 (CET)
Date:   Tue, 27 Oct 2020 01:13:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 08/68] btrfs: inode: sink parameter @start and @len
 for check_data_csum()
Message-ID: <20201027001305.GW6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-9-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021062554.68132-9-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 21, 2020 at 02:24:54PM +0800, Qu Wenruo wrote:
> For check_data_csum(), the page we're using is directly from inode
> mapping, thus it has valid page_offset().
> 
> We can use (page_offset() + pg_off) to replace @start parameter
> completely, while the @len should always be sectorsize.
> 
> Since we're here, also add some comment, as there are quite some
> confusion in words like start/offset, without explaining whether it's
> file_offset or logical bytenr.
> 
> This should not affect the existing behavior, as for current sectorsize
> == PAGE_SIZE case, @pgoff should always be 0, and len is always
> PAGE_SIZE (or sectorsize from the dio read path).
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2a56d3b8eff4..24fbf2c46e56 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2791,17 +2791,30 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
>  	btrfs_queue_work(wq, &ordered_extent->work);
>  }
>  
> +/*
> + * Verify the checksum of one sector of uncompressed data.
> + *
> + * @inode:	The inode.
> + * @io_bio:	The btrfs_io_bio which contains the csum.
> + * @icsum:	The csum offset (by number of sectors).

This is not true, it's the index to the checksum array, where size of
the element is fs_info::csum_size. The offset can be calculated but it's
not the thing that's passed as argument.
