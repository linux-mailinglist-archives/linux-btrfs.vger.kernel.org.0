Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B20627310D
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 19:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgIURqZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 13:46:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:59124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgIURqZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 13:46:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C03BCAC23;
        Mon, 21 Sep 2020 17:47:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AD197DA6E0; Mon, 21 Sep 2020 19:45:09 +0200 (CEST)
Date:   Mon, 21 Sep 2020 19:45:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/7] btrfs: Don't call readpage_end_io_hook for the btree
 inode
Message-ID: <20200921174509.GN6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200918133439.23187-1-nborisov@suse.com>
 <20200918133439.23187-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918133439.23187-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 18, 2020 at 04:34:33PM +0300, Nikolay Borisov wrote:
> Instead of relying on indirect calls to implement metadata buffer
> validation simply check if the inode whose page we are processing equals
> the btree inode. If it does call the necessary function.
> 
> This is an improvement in 2 directions:
> 1. We aren't paying the penalty of indirect calls in a post-speculation
>    attacks world.
> 
> 2. The function is now named more explicitly so it's obvious what's
>    going on

The new naming is not making things clear, btrfs_check_csum sounds very
generic while it does a very specific thing just by the number and type
of the parameters. Similar for btrfs_validate_metadata_buffer.

> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2851,9 +2851,12 @@ static void end_bio_extent_readpage(struct bio *bio)
>  
>  		mirror = io_bio->mirror_num;
>  		if (likely(uptodate)) {
> -			ret = tree->ops->readpage_end_io_hook(io_bio, offset,
> -							      page, start, end,
> -							      mirror);
> +			if (data_inode)
> +				ret = btrfs_check_csum(io_bio, offset, page,
> +						       start, end, mirror);
> +			else
> +				ret = btrfs_validate_metadata_buffer(io_bio,
> +					offset, page, start, end, mirror);

In the context where the functions are used I'd expect some symmetry,
data/metadata. Something like btrfs_validate_data_bio.
