Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17212A4FD6
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 20:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgKCTRs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 14:17:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:40584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbgKCTRs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 14:17:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69297ABA2;
        Tue,  3 Nov 2020 19:17:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9F625DA7D2; Tue,  3 Nov 2020 20:16:09 +0100 (CET)
Date:   Tue, 3 Nov 2020 20:16:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: ordered-data: rename parameter @len to
 @nr_sectors
Message-ID: <20201103191609.GC6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201028072432.86907-1-wqu@suse.com>
 <20201028072432.86907-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028072432.86907-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 28, 2020 at 03:24:31PM +0800, Qu Wenruo wrote:
> The parameter is the number of sectors of the range to search.
> While most "len" we used in other locations are in byte size, this can
> lead to confusion.
> 
> Rename @len to @nr_sectors to make it more clear and avoid confusion.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ordered-data.c | 9 ++++++---
>  fs/btrfs/ordered-data.h | 2 +-
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index ebac13389e7e..10c13f8a1603 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -802,9 +802,11 @@ btrfs_lookup_first_ordered_extent(struct inode *inode, u64 file_offset)
>   * search the ordered extents for one corresponding to 'offset' and
>   * try to find a checksum.  This is used because we allow pages to
>   * be reclaimed before their checksum is actually put into the btree
> + *
> + * @nr_sectors:	The length of the search range, in sectors.

Please add all parameters

>   */
>  int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
> -			   u8 *sum, int len)
> +			   u8 *sum, int nr_sectors)
