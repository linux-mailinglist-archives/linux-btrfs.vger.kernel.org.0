Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 660E01A4881
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 18:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDJQaZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Apr 2020 12:30:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:52686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgDJQaZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Apr 2020 12:30:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3D6DAABD6;
        Fri, 10 Apr 2020 16:30:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3F351DA72D; Fri, 10 Apr 2020 18:29:46 +0200 (CEST)
Date:   Fri, 10 Apr 2020 18:29:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs:  Remove superflous lock acquisition in
 __del_reloc_root
Message-ID: <20200410162946.GN5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200221131124.24105-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221131124.24105-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 21, 2020 at 03:11:23PM +0200, Nikolay Borisov wrote:
> __del_reloc_root is called from:
> 
> a) Transaction commit via:
> btrfs_transaction_commit
>  commit_fs_roots
>   btrfs_update_reloc_root
>    __del_reloc_root
> 
> b) From the relocation thread with the following call chains:
> 
> relocate_block_group
>  merge_reloc_roots
>   insert_dirty_subvol
>    btrfs_update_reloc_root
>     __del_reloc_root
> 
> c) merge_reloc_roots
>     free_reloc_roots
>      __del_reloc_roots
> 
> (The above call chain can called from btrfs_recover_relocation as well
> but for the purpose of this fix this is irrelevant).
> 
> The commont data structure that needs protecting is
> fs_info->reloc_ctl->reloc_list as reloc roots are anchored at this list.
> Turns out it's no needed to hold the trans_lock in __del_reloc_root
> since consistency is already guaranteed by call chain b) above holding
> a transaction while calling insert_dirty_subvol, meaning we cannot have
> a concurrent transaction commit. For call chain c) above a snapshot of
> the fs_info->reloc_ctl->reloc_list is taken with reloc_mutex held and
> free_reloc_roots is called on this local snapshot.
> 
> Those invariants are sufficient to prevent racing calls to
> __del_reloc_root alongside other users of the list, as such it's fine
> to drop the lock acquisition.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/relocation.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 8076c340749f..e5cb64409f7c 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1381,9 +1381,7 @@ static void __del_reloc_root(struct btrfs_root *root)
>  		BUG_ON((struct btrfs_root *)node->data != root);
>  	}
>  
> -	spin_lock(&fs_info->trans_lock);
>  	list_del_init(&root->root_list);
> -	spin_unlock(&fs_info->trans_lock);

This has been obsoleted by patch f44deb7442edf42abee6 ("btrfs: hold a
ref on the root->reloc_root"), I think the locks are still needed but
you may want take a look.
