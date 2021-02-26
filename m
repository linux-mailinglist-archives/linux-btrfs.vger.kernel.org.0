Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8613266F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Feb 2021 19:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhBZSdp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 13:33:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:52806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230367AbhBZSdf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 13:33:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A9B2AB8C;
        Fri, 26 Feb 2021 18:32:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D6DE4DA7FF; Fri, 26 Feb 2021 19:30:59 +0100 (CET)
Date:   Fri, 26 Feb 2021 19:30:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7 03/38] btrfs: handle errors from select_reloc_root()
Message-ID: <20210226183059.GP7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1608135849.git.josef@toxicpanda.com>
 <aa44497f5c2b8c96ca1229daa4dfdb6503971f31.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa44497f5c2b8c96ca1229daa4dfdb6503971f31.1608135849.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 11:26:19AM -0500, Josef Bacik wrote:
> Currently select_reloc_root() doesn't return an error, but followup
> patches will make it possible for it to return an error.  We do have
> proper error recovery in do_relocation however, so handle the
> possibility of select_reloc_root() having an error properly instead of
> BUG_ON(!root).  I've also adjusted select_reloc_root() to return
> ERR_PTR(-ENOENT) if we don't find a root, instead of NULL, to make the
> error case easier to deal with.  I've replaced the BUG_ON(!root) with an
> ASSERT(0) for this case as it indicates we messed up the backref walking
> code, but it could also indicate corruption.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 08ffaa93b78f..741068580455 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2024,8 +2024,14 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
>  		if (!next || next->level <= node->level)
>  			break;
>  	}
> -	if (!root)
> -		return NULL;
> +	if (!root) {
> +		/*
> +		 * This can happen if there's fs corruption or if there's a bug
> +		 * in the backref lookup code.
> +		 */
> +		ASSERT(0);

You've added these assert(0) to several patches and I think it's wrong.
The asserts are supposed to verify invariants, you can hardly say that
we're expecting 0 to be true, so the construct serves as "please crash
here", which is no better than BUG().  It's been spreading, there are
like 25 now.

> +		return ERR_PTR(-ENOENT);

The caller that does expect ENOENT because that would be a logical error
should do the assert.

> +	}
>  
>  	next = node;
>  	/* setup backref node path for btrfs_reloc_cow_block */
> @@ -2196,7 +2202,10 @@ static int do_relocation(struct btrfs_trans_handle *trans,
>  
>  		upper = edge->node[UPPER];
>  		root = select_reloc_root(trans, rc, upper, edges);
> -		BUG_ON(!root);
> +		if (IS_ERR(root)) {
> +			ret = PTR_ERR(root);
> +			goto next;
> +		}
>  
>  		if (upper->eb && !upper->locked) {
>  			if (!lowest) {
> -- 
> 2.26.2
