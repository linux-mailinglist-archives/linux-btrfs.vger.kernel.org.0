Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93694DA3F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 21:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351683AbiCOU0k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiCOU0i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 16:26:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860CD3A71D
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 13:25:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 430BA21123;
        Tue, 15 Mar 2022 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647375925;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y/mxGXtp8sZQlIVshKm+rR3J0t3KOf4mdxlrN904044=;
        b=nMh3CFcXkjjXYJNk5GNIs1WheUtvIKp1TpkE/5IFnwqDt5uuh3PutnSKGU9NFuMF8+oi18
        PDWKO+xY/jY0q6UTjIvi8gKRIywGRdWHtDhhlKxziGm2lO2KjZCMxysIN0DUifR0quQsj/
        9BaSAcn2bTASWKLyFqHhgWzJEMglkPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647375925;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y/mxGXtp8sZQlIVshKm+rR3J0t3KOf4mdxlrN904044=;
        b=jdDZdPdZ37o56gFyaWnB2Brm2CK3v9vnC36oY1/5eKOoozCs6SMyhirdDmIw9JwzdHfctS
        hu98wIsNPf6HLUBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 392F7A3B87;
        Tue, 15 Mar 2022 20:25:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 652A6DA7E1; Tue, 15 Mar 2022 21:21:26 +0100 (CET)
Date:   Tue, 15 Mar 2022 21:21:26 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: check extent buffer owner against the owner
 rootid
Message-ID: <20220315202126.GZ12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <1dac293a7ab561bbbca404b484c763e47e883a86.1646636770.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dac293a7ab561bbbca404b484c763e47e883a86.1646636770.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 07, 2022 at 03:06:47PM +0800, Qu Wenruo wrote:
> Btrfs doesn't really check whether the tree block really respects the
> root owner.
> 
> This means, if a tree block referred by a parent in extent tree, but has
> owner of 5, btrfs can still continue reading the tree block, as long as
> it doesn't trigger other sanity checks.
> 
> Normally this is fine, but combined with the empty tree check in
> check_leaf(), if we hit an empty extent tree, but the root node has
> csum tree owner, we can let such extent buffer to sneak in.
> 
> Shrink the hole by:
> 
> - Do extra eb owner check at tree read time
> 
> - Make sure the root owner extent buffer exactly match the root id.
> 
> Unfortunately we can't yet completely patch the hole, there are several
> call sites can't pass all info we need:
> 
> - For reloc/log trees
>   Their owner is key::offset, not key::objectid.
>   We need the full root key to do that accurate check.
> 
>   For now, we just skip the ownership check for those trees.
> 
> - For add_data_references() of relocation
>   That call site doesn't have any parent/ownership info, as all the
>   bytenrs are all from btrfs_find_all_leafs().
> 
> - For direct backref items walk
>   Direct backref items records the parent bytenr directly, thus unlike
>   indirect backref item, we don't do a full tree search.
> 
>   Thus in that case, we don't have full parent owner to check.
> 
> For the later two cases, they all pass 0 as @owner_root, thus we can
> skip those cases if @owner_root is 0.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Skip @owner_root == 0 cases completely to remove a false alert
> 
>   For add_data_references() we pass 0 as @owner_root for data extents.
>   However v1 space cache uses data extents but belongs to root tree.
> 
>   Thus previous handling (marking all owner_root == 0 case as is_subvol)
>   will reject the read.
> ---
>  fs/btrfs/ctree.c        |  6 +++++
>  fs/btrfs/disk-io.c      | 21 +++++++++++++++
>  fs/btrfs/tree-checker.c | 57 +++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/tree-checker.h |  1 +
>  4 files changed, 85 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 0eecf98d0abb..d904fe0973bd 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -16,6 +16,7 @@
>  #include "volumes.h"
>  #include "qgroup.h"
>  #include "tree-mod-log.h"
> +#include "tree-checker.h"
>  
>  static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
>  		      *root, struct btrfs_path *path, int level);
> @@ -1443,6 +1444,11 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
>  			btrfs_release_path(p);
>  			return -EIO;
>  		}
> +		if (btrfs_check_eb_owner(tmp, root->root_key.objectid)) {
> +			free_extent_buffer(tmp);
> +			btrfs_release_path(p);
> +			return -EUCLEAN;
> +		}

This hunk does not apply to current misc-next, can you please refresh
the patch? Thanks.
