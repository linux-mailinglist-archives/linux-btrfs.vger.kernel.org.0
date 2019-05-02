Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B50111B78
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2019 16:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfEBOb0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 May 2019 10:31:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:54950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbfEBOb0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 May 2019 10:31:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0085DAE47;
        Thu,  2 May 2019 14:31:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9AB56DA871; Thu,  2 May 2019 16:32:24 +0200 (CEST)
Date:   Thu, 2 May 2019 16:32:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V2] btrfs: drop inode reference count on error path
Message-ID: <20190502143222.GC20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pan Bian <bianpan2016@163.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1555585576-31045-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555585576-31045-1-git-send-email-bianpan2016@163.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 18, 2019 at 07:06:16PM +0800, Pan Bian wrote:
> The reference count of inode is incremented by ihold. It should be
> dropped if not used. However, the reference count is not dropped if
> error occurs during updating the inode or deleting orphan items. This
> patch fixes the bug.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
> V2: move ihold just before device_initialize to make code clearer

There's nothing like device_initialize, what does this refer to?

> ---
>  fs/btrfs/inode.c | 54 +++++++++++++++++++++++++-----------------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 82fdda8..d6630df 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6579,7 +6579,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	u64 index;
>  	int err;
> -	int drop_inode = 0;
> +	int log_mode;
>  
>  	/* do not allow sys_link's with other subvols of the same device */
>  	if (root->root_key.objectid != BTRFS_I(inode)->root->root_key.objectid)
> @@ -6616,41 +6616,37 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
>  	err = btrfs_add_nondir(trans, BTRFS_I(dir), dentry, BTRFS_I(inode),
>  			1, index);
>  
> -	if (err) {
> -		drop_inode = 1;
> -	} else {
> -		struct dentry *parent = dentry->d_parent;
> -		int ret;
> +	if (err)
> +		goto err_link;
>  
> -		err = btrfs_update_inode(trans, root, inode);
> +	err = btrfs_update_inode(trans, root, inode);
> +	if (err)
> +		goto err_link;
> +	if (inode->i_nlink == 1) {
> +		/*
> +		 * If new hard link count is 1, it's a file created
> +		 * with open(2) O_TMPFILE flag.
> +		 */
> +		err = btrfs_orphan_del(trans, BTRFS_I(inode));
>  		if (err)
> -			goto fail;
> -		if (inode->i_nlink == 1) {
> -			/*
> -			 * If new hard link count is 1, it's a file created
> -			 * with open(2) O_TMPFILE flag.
> -			 */
> -			err = btrfs_orphan_del(trans, BTRFS_I(inode));
> -			if (err)
> -				goto fail;
> -		}
> -		BTRFS_I(inode)->last_link_trans = trans->transid;
> -		d_instantiate(dentry, inode);
> -		ret = btrfs_log_new_name(trans, BTRFS_I(inode), NULL, parent,
> -					 true, NULL);
> -		if (ret == BTRFS_NEED_TRANS_COMMIT) {
> -			err = btrfs_commit_transaction(trans);
> -			trans = NULL;
> -		}
> +			goto err_link;
> +	}
> +	BTRFS_I(inode)->last_link_trans = trans->transid;
> +	ihold(inode);
> +	d_instantiate(dentry, inode);

So this ihold pairs with d_instantiate, and there's another ihold in the
function, before call to btrfs_add_nondir. Isn't this leaking the
references? In normal case it's 2x ihold, in error case 1x.

6645         /* There are several dir indexes for this inode, clear the cache. */                                                                                                                                               
6646         BTRFS_I(inode)->dir_index = 0ULL;                                                                                                                                                                                  
6647         inc_nlink(inode);                                                                                                                                                                                                  
6648         inode_inc_iversion(inode);                                                                                                                                                                                         
6649         inode->i_ctime = current_time(inode);                                                                                                                                                                              
6650         ihold(inode);                                                                                                                                                                                                      
6651         set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);

> +	log_mode = btrfs_log_new_name(trans, BTRFS_I(inode), NULL,
> +			dentry->d_parent, true, NULL);
> +	if (log_mode == BTRFS_NEED_TRANS_COMMIT) {
> +		err = btrfs_commit_transaction(trans);
> +		trans = NULL;
>  	}
>  
> +err_link:
> +	if (err)
> +		inode_dec_link_count(inode);
>  fail:
>  	if (trans)
>  		btrfs_end_transaction(trans);
> -	if (drop_inode) {
> -		inode_dec_link_count(inode);
> -		iput(inode);

Ie. this iput does not have any replacement in the new code.

> -	}
>  	btrfs_btree_balance_dirty(fs_info);
>  	return err;
>  }
> -- 
> 2.7.4
> 
