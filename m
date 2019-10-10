Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55976D2E49
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfJJQFc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 12:05:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:41766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbfJJQFb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 12:05:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64F6BAD9C;
        Thu, 10 Oct 2019 16:05:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B925EDA7E3; Thu, 10 Oct 2019 18:05:42 +0200 (CEST)
Date:   Thu, 10 Oct 2019 18:05:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: Don't use objectid_mutex during mount
Message-ID: <20191010160540.GU2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191010150647.20940-1-nborisov@suse.com>
 <20191010150647.20940-3-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010150647.20940-3-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 10, 2019 at 06:06:46PM +0300, Nikolay Borisov wrote:
> Since the filesystem is not well formed and no trees are loaded it's
> pointless holding the objectid_mutex. Just remove its usage.

Yes.

There's a case when the lock should be kept even in that phase, so we
could add a lockdep assertion, but I found btrfs_recover_log_trees with
a comment why the lock is not needed. Given that
btrfs_find_highest_objectid is used only in a hadnful places, I think
we're fine with just the comments.

> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/disk-io.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b850988023aa..72580eb6b706 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2603,17 +2603,14 @@ int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
>  		tree_root->commit_root = btrfs_root_node(tree_root);
>  		btrfs_set_root_refs(&tree_root->root_item, 1);
>  
> -		mutex_lock(&tree_root->objectid_mutex);

		/*
		 * We don't need to hold objectid_mutex because ...
		 */

>  		ret = btrfs_find_highest_objectid(tree_root,
>  						&tree_root->highest_objectid);
>  		if (ret) {
> -			mutex_unlock(&tree_root->objectid_mutex);
>  			handle_error = true;
>  			continue;
>  		}
