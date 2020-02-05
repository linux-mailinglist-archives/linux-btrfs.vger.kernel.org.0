Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1BEE1533A1
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 16:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgBEPGp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 10:06:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:47598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgBEPGp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 10:06:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 20697AC52;
        Wed,  5 Feb 2020 15:06:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5430FDA7E6; Wed,  5 Feb 2020 16:06:31 +0100 (CET)
Date:   Wed, 5 Feb 2020 16:06:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 29/44] btrfs: hold a ref for the root in
 btrfs_find_orphan_roots
Message-ID: <20200205150630.GQ2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20200124143301.2186319-1-josef@toxicpanda.com>
 <20200124143301.2186319-30-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124143301.2186319-30-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 24, 2020 at 09:32:46AM -0500, Josef Bacik wrote:
> We lookup roots for every orphan item we have, we need to hold a ref on
> the root while we're doing this work.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/root-tree.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index 094a71c54fa1..25842527fd42 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -257,6 +257,8 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>  
>  		root = btrfs_get_fs_root(fs_info, &root_key, false);
>  		err = PTR_ERR_OR_ZERO(root);
> +		if (!err && !btrfs_grab_fs_root(root))
> +			err = -ENOENT;
>  		if (err && err != -ENOENT) {
>  			break;
>  		} else if (err == -ENOENT) {

It's hard to read and reason about where's the reference and where it's
not due to the combined options. There are some breaks and continues and
I think some refs might leak. I'll have another thought how it could be
restructured.

> @@ -288,6 +290,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
>  			set_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
>  			btrfs_add_dead_root(root);
>  		}
> +		btrfs_put_fs_root(root);
>  	}
>  
>  	btrfs_free_path(path);
> -- 
> 2.24.1
