Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C38401B34
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 14:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242258AbhIFM26 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 08:28:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56720 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242247AbhIFM25 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Sep 2021 08:28:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E5CB41FEEE;
        Mon,  6 Sep 2021 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630931270;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q5Gjv/o2r31Pg5vgSEoAXdlHZThs4FawYEtj69ES0+s=;
        b=Wjec5BuFH/snRU+lj0EWXJqw1F4PdiMVA37DDVriVRPiWzNFBLTMKM+So6qgjp8cBOY/qw
        mLKxW4bglIuDqnshO4dHOIsK58LZE/JEXPlTsU3dQChorU5/ge+QzD9/+bwdt4nGYB2374
        Ttk8f5ucNkvnpjn9swZWaWNBoOv0zCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630931270;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q5Gjv/o2r31Pg5vgSEoAXdlHZThs4FawYEtj69ES0+s=;
        b=y8Fm6tjaBOyin7BFqKGEf25V2DvFHbrdu1O/xm6qRqlDTwZCeG5RsNRnYtAbEYpos5US/D
        R0+7g9L9iR25S/Cw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DB451A3B88;
        Mon,  6 Sep 2021 12:27:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 83674DA781; Mon,  6 Sep 2021 14:27:47 +0200 (CEST)
Date:   Mon, 6 Sep 2021 14:27:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Baptiste Lepers <baptiste.lepers@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: transaction: Fix misplaced barrier in
 btrfs_record_root_in_trans
Message-ID: <20210906122747.GG3379@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Baptiste Lepers <baptiste.lepers@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210906012559.8605-1-baptiste.lepers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906012559.8605-1-baptiste.lepers@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 06, 2021 at 11:25:59AM +1000, Baptiste Lepers wrote:
> Per comment, record_root_in_trans orders the writes of the root->state
> and root->last_trans:
>       set_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state);
>       smp_wmb();
>       root->last_trans = trans->transid;
> 
> But the barrier that enforces the order on the read side is misplaced:
>      smp_rmb(); <-- misplaced
>      if (root->last_trans == trans->transid &&
>     <-- missing barrier here -->
>             !test_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state))
> 
> This patches fixes the ordering and wraps the racy accesses with
> READ_ONCE and WRITE_ONCE calls to avoid load/store tearing.
> 
> Fixes: 7585717f304f5 ("Btrfs: fix relocation races")
> Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
> ---
>  fs/btrfs/transaction.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 14b9fdc8aaa9..a609222e6704 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -437,7 +437,7 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
>  				   (unsigned long)root->root_key.objectid,
>  				   BTRFS_ROOT_TRANS_TAG);
>  		spin_unlock(&fs_info->fs_roots_radix_lock);
> -		root->last_trans = trans->transid;
> +		WRITE_ONCE(root->last_trans, trans->transid);
>  
>  		/* this is pretty tricky.  We don't want to
>  		 * take the relocation lock in btrfs_record_root_in_trans
> @@ -489,7 +489,7 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
>  			       struct btrfs_root *root)
>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
> -	int ret;
> +	int ret, last_trans;
>  
>  	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
>  		return 0;
> @@ -498,8 +498,9 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
>  	 * see record_root_in_trans for comments about IN_TRANS_SETUP usage
>  	 * and barriers
>  	 */
> +	last_trans = READ_ONCE(root->last_trans);
>  	smp_rmb();
> -	if (root->last_trans == trans->transid &&
> +	if (last_trans == trans->transid &&
>  	    !test_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state))

Aren't the smp_rmb barriers supposed to be used before the condition?
