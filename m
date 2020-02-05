Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F21BB15334F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 15:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgBEOqm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 09:46:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:34986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgBEOqm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Feb 2020 09:46:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AA770AD5D;
        Wed,  5 Feb 2020 14:46:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CEEF9DA7E6; Wed,  5 Feb 2020 15:46:27 +0100 (CET)
Date:   Wed, 5 Feb 2020 15:46:26 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 21/44] btrfs: hold a ref on the root in build_backref_tree
Message-ID: <20200205144626.GN2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20200124143301.2186319-1-josef@toxicpanda.com>
 <20200124143301.2186319-22-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124143301.2186319-22-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 24, 2020 at 09:32:38AM -0500, Josef Bacik wrote:
> This is trickier than the previous conversions.  We have backref_node's
> that need to hold onto their root for their lifetime.  Do the read of
> the root and grab the ref.  If at any point we don't use the root we
> discard it, however if we use it in our backref node we don't free it
> until we free the backref node.  Any time we switch the root's for the
> backref node we need to drop our ref on the old root and grab the ref on
> the new root, and if we dupe a node we need to get a ref on the root
> there as well.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 39 ++++++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index aa3aa8e0c0ea..990595a27a15 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -256,6 +256,8 @@ static void free_backref_node(struct backref_cache *cache,
>  {
>  	if (node) {
>  		cache->nr_nodes--;
> +		if (node->root)
> +			btrfs_put_fs_root(node->root);

And here the check can be dropped too, to be consistent with the rest.

>  		kfree(node);
>  	}
>  }
