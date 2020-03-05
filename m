Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B14317AD82
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 18:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgCERrI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 12:47:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:40320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgCERrI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 12:47:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6B094AE79;
        Thu,  5 Mar 2020 17:47:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46DAEDA733; Thu,  5 Mar 2020 18:46:43 +0100 (CET)
Date:   Thu, 5 Mar 2020 18:46:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 5/8] btrfs: run clean_dirty_subvols if we fail to start a
 trans
Message-ID: <20200305174642.GF2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200304161830.2360-1-josef@toxicpanda.com>
 <20200304161830.2360-6-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304161830.2360-6-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 04, 2020 at 11:18:27AM -0500, Josef Bacik wrote:
> If we do merge_reloc_roots() we could insert a few roots onto the dirty
> subvol roots list, where we hold a ref on them.  If we fail to start the
> transaction we need to run clean_dirty_subvols() in order to cleanup the
> refs.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index f6237d885fe0..53509c367eff 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4279,10 +4279,10 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
>  		goto out_free;
>  	}
>  	btrfs_commit_transaction(trans);
> +out_free:
>  	ret = clean_dirty_subvols(rc);
>  	if (ret < 0 && !err)
>  		err = ret;
> -out_free:
>  	btrfs_free_block_rsv(fs_info, rc->block_rsv);
>  	btrfs_free_path(path);
>  	return err;
> @@ -4711,6 +4711,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
>  
>  	trans = btrfs_join_transaction(rc->extent_root);
>  	if (IS_ERR(trans)) {
> +		clean_dirty_subvols(rc);
>  		err = PTR_ERR(trans);
>  		goto out_free;
>  	}

The update to btrfs_recover_relocation should follow the same pattern,
like

@@ -4682,12 +4682,12 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
        trans = btrfs_join_transaction(rc->extent_root);
        if (IS_ERR(trans)) {
-               clean_dirty_subvols(rc);
                err = PTR_ERR(trans);
-               goto out_free;
+               goto out_clean;
        }
        err = btrfs_commit_transaction(trans);
 
+out_clean:
        ret = clean_dirty_subvols(rc);
        if (ret < 0 && !err)
                err = ret;
