Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC327C719
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2019 17:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfGaPnx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Jul 2019 11:43:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:48252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727670AbfGaPnw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Jul 2019 11:43:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7C34AC68
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2019 15:43:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 617E8DA7ED; Wed, 31 Jul 2019 17:44:26 +0200 (CEST)
Date:   Wed, 31 Jul 2019 17:44:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: delayed-inode: Kill the BUG_ON() in
 btrfs_delete_delayed_dir_index()
Message-ID: <20190731154426.GO28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190716090034.11641-1-wqu@suse.com>
 <20190716090034.11641-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716090034.11641-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 16, 2019 at 05:00:32PM +0800, Qu Wenruo wrote:
> There is one report of fuzzed image which leads to BUG_ON() in
> btrfs_delete_delayed_dir_index().
> 
> Although that fuzzed image can already be addressed by enhanced
> extent-tree error handler, it's still better to hunt down more BUG_ON().
> 
> This patch will hunt down two BUG_ON()s in
> btrfs_delete_delayed_dir_index():
> - One for error from btrfs_delayed_item_reserve_metadata()
>   Instead of BUG_ON(), we output an error message and free the item.
>   And return the error.
>   All callers of this function handles the error by aborting current
>   trasaction.
> 
> - One for possible EEXIST from __btrfs_add_delayed_deletion_item()
>   That function can return -EEXIST.
>   We already have a good enough error message for that, only need to
>   clean up the reserved metadata space and allocated item.
> 
> To help above cleanup, also modifiy __btrfs_remove_delayed_item() called
> in btrfs_release_delayed_item(), to skip unassociated item.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203253
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/delayed-inode.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 43fdb2992956..c4946d58f49b 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -474,6 +474,9 @@ static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
>  	struct rb_root_cached *root;
>  	struct btrfs_delayed_root *delayed_root;
>  
> +	/* Not associated with any delayed_node */
> +	if (!delayed_item->delayed_node)
> +		return;
>  	delayed_root = delayed_item->delayed_node->root->fs_info->delayed_root;
>  
>  	BUG_ON(!delayed_root);
> @@ -1525,7 +1528,13 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
>  	 * we have reserved enough space when we start a new transaction,
>  	 * so reserving metadata failure is impossible.
>  	 */
> -	BUG_ON(ret);
> +	if (ret < 0) {
> +		btrfs_err(trans->fs_info,
> +"metadata reserve fail at %s, should have already reserved space, ret=%d",

I'd rather avoid using the function name in non-debugging messages,
let's use eg "metadata reservation failed for delayed dir item deltion",
and printing ret here is not necessary as it will be printed in the
transaction abort message.
