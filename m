Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90707264BE5
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 19:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgIJRwd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 13:52:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:54836 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgIJQQ1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 12:16:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1EE74B207;
        Thu, 10 Sep 2020 16:16:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6847BDA730; Thu, 10 Sep 2020 18:14:57 +0200 (CEST)
Date:   Thu, 10 Sep 2020 18:14:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: improve error message in
 setup_items_for_insert
Message-ID: <20200910161457.GL18399@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200901144001.4265-1-nborisov@suse.com>
 <20200901144001.4265-6-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901144001.4265-6-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 01, 2020 at 05:40:01PM +0300, Nikolay Borisov wrote:
> While at it also print the leaf content after the error.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/ctree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index bb89c0954ca1..2c3f78cc6aa2 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -4799,9 +4799,9 @@ void setup_items_for_insert(struct btrfs_root *root, struct btrfs_path *path,
>  		unsigned int old_data = btrfs_item_end_nr(leaf, slot);
>  
>  		if (old_data < data_end) {
> -			btrfs_print_leaf(leaf);
> -			btrfs_crit(fs_info, "slot %d old_data %d data_end %d",
> +			btrfs_crit(fs_info, "item's (slot %d) data offset (%d) beyond data end of leaf (%d)",
>  				   slot, old_data, data_end);
> +			btrfs_print_leaf(leaf);

This is a question if the order is right or vice versa. When something
goes wrong, the leaf dump fills a few pages or screens and it's not
always possible to scroll back.

The idea of 1) dump leaf 2) print the error message, is to keep the
specific error last hoping that it's still visible when somebody takes a
screenshot for a bugreport.

I've checked instances where we call print_leaf and this is the most
common ordering, so I'd rather keep it like that as it has some practial
impacts.
