Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCA4273392
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 22:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgIUUaZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 16:30:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:39292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgIUUaZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 16:30:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC11CACD8;
        Mon, 21 Sep 2020 20:31:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B863EDA6E0; Mon, 21 Sep 2020 22:29:09 +0200 (CEST)
Date:   Mon, 21 Sep 2020 22:29:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/7] btrfs: Don't opencode is_data_inode in
 end_bio_extent_readpage
Message-ID: <20200921202909.GU6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200918133439.23187-1-nborisov@suse.com>
 <20200918133439.23187-5-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918133439.23187-5-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 18, 2020 at 04:34:36PM +0300, Nikolay Borisov wrote:
> Use the is_data_inode helper.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/extent_io.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6e976bd86600..26b002e2f3b3 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2816,8 +2816,7 @@ static void end_bio_extent_readpage(struct bio *bio)
>  		struct page *page = bvec->bv_page;
>  		struct inode *inode = page->mapping->host;
>  		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> -		bool data_inode = btrfs_ino(BTRFS_I(inode))
> -			!= BTRFS_BTREE_INODE_OBJECTID;
> +		bool data_inode = is_data_inode(inode);

I think you can remove the temporary variable and call is_data_inode
directly in the later code, there's only one use.
