Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FBE4DCE42
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 19:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbiCQS6f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 14:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbiCQS6d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 14:58:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07198224764
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 11:57:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A7804210EA;
        Thu, 17 Mar 2022 18:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647543435;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=//Kkd9OJjnYTQW9Twakgbo5KC7Wo7rbTNzqqoWNLIuQ=;
        b=wGZqOnmU52FH4yI8WcMEy7knwYAy+W8ezleKVedD0FM56VYRMjprOqDIayJzOwuWXQ/xlp
        2t5puCwr3u2MA43xYc8h20aChFjM85BQJoPVYjsPkKLs/cOm+uCSShh+SazXAmCFnw1LKP
        odEuhkog5i5oYcrvkzTHVUlN/MBn1rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647543435;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=//Kkd9OJjnYTQW9Twakgbo5KC7Wo7rbTNzqqoWNLIuQ=;
        b=IduRr25KWSbLWGMz0uJmJ743znHu43i5E9gPZfWVU0qXCrCWvya9uYdkwlZ/iu/ync+Sf/
        u0IzQRQWPTiwycCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9F8ABA3B92;
        Thu, 17 Mar 2022 18:57:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5F1E9DA7E1; Thu, 17 Mar 2022 19:53:15 +0100 (CET)
Date:   Thu, 17 Mar 2022 19:53:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: check extent buffer owner against the owner
 rootid
Message-ID: <20220317185315.GC12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <38ac33583d7eb954d6428b21582b16bee56b3761.1647388920.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38ac33583d7eb954d6428b21582b16bee56b3761.1647388920.git.wqu@suse.com>
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

On Wed, Mar 16, 2022 at 08:05:58AM +0800, Qu Wenruo wrote:
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
> 
> v3:
> - Resolve a conflict with "btrfs: release upper nodes when reading stale
>   btree node from disk"
>   Just check the eb owner before checking @unlock_up

Added to misc-next, thanks.

> @@ -1855,3 +1855,60 @@ int btrfs_check_node(struct extent_buffer *node)
>  	return ret;
>  }
>  ALLOW_ERROR_INJECTION(btrfs_check_node, ERRNO);
> +
> +int btrfs_check_eb_owner(struct extent_buffer *eb, u64 root_owner)

			    const ...
> +{
> +	const bool is_subvol = is_fstree(root_owner);
> +	const u64 eb_owner = btrfs_header_owner(eb);
> +
> +	/*
> +	 * Skip dummy fs, as selftest doesn't bother to create unique ebs for
> +	 * each dummy root.
> +	 */
> +	if (test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &eb->fs_info->fs_state))
> +		return 0;
> +	/*
> +	 * There are several call sites (backref walking, qgroup, and data
> +	 * reloc) passing 0 as @root_owner, as they are not holding the
> +	 * tree root.
> +	 * In that case, we can not do a reliable ownership check, so just
> +	 * exit.
> +	 */
> +	if (root_owner == 0)
> +		return 0;
> +	/*
> +	 * Those trees uses key.offset as their owner, our callers don't
> +	 * have the extra capacity to pass key.offset here.
> +	 * So we just skip those trees.
> +	 */
> +	if (root_owner == BTRFS_TREE_LOG_OBJECTID ||
> +	    root_owner == BTRFS_TREE_RELOC_OBJECTID)
> +		return 0;
> +
> +	if (!is_subvol) {
> +		/* For non-subvolume trees, the eb owner should match root owner */
> +		if (root_owner != eb_owner) {

		    unlikely(...)
> +			btrfs_crit(eb->fs_info,
> +"corrupted %s, root=%llu block=%llu owner mismatch, have %llu expect %llu",
> +				btrfs_header_level(eb) == 0 ? "leaf" : "node",
> +				root_owner, btrfs_header_bytenr(eb), eb_owner,
> +				root_owner);
> +			return -EUCLEAN;
> +		}
> +		return 0;
> +	}
> +
> +	/*
> +	 * For subvolume trees, owner can mismatch, but they should all belong
> +	 * to subvolume trees.
> +	 */
> +	if (is_subvol != is_fstree(eb_owner)) {

		    unlikely(...)

> +		btrfs_crit(eb->fs_info,
> +"corrupted %s, root=%llu block=%llu owner mismatch, have %llu expect [%llu, %llu]",
> +			btrfs_header_level(eb) == 0 ? "leaf" : "node",
> +			root_owner, btrfs_header_bytenr(eb), eb_owner,
> +			BTRFS_FIRST_FREE_OBJECTID, BTRFS_LAST_FREE_OBJECTID);
> +		return -EUCLEAN;
> +	}
> +	return 0;
> +}
