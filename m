Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2991532E1
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 15:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgBEOaf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 09:30:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:51080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgBEOaf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 09:30:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 856DCB133;
        Wed,  5 Feb 2020 14:30:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AA232DA7E6; Wed,  5 Feb 2020 15:30:21 +0100 (CET)
Date:   Wed, 5 Feb 2020 15:30:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 17/44] btrfs: hold a ref on the root in
 btrfs_search_path_in_tree
Message-ID: <20200205143020.GL2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20200124143301.2186319-1-josef@toxicpanda.com>
 <20200124143301.2186319-18-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124143301.2186319-18-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 24, 2020 at 09:32:34AM -0500, Josef Bacik wrote:
> We look up an arbitrary fs root, we need to hold a ref on it while we're
> doing our search.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ioctl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 62dd06b65686..c721b4fce1c0 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2328,6 +2328,12 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
>  	root = btrfs_get_fs_root(info, &key, true);
>  	if (IS_ERR(root)) {
>  		ret = PTR_ERR(root);
> +		root = NULL;
> +		goto out;
> +	}
> +	if (!btrfs_grab_fs_root(root)) {
> +		ret = -ENOENT;
> +		root = NULL;
>  		goto out;
>  	}
>  
> @@ -2378,6 +2384,8 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
>  	name[total_len] = '\0';
>  	ret = 0;
>  out:
> +	if (root)
> +		btrfs_put_fs_root(root);

The NULL check is not necessary, you added that into btrfs_put_fs_root
and I think it's readable without it here.

>  	btrfs_free_path(path);
>  	return ret;
>  }
> -- 
> 2.24.1
