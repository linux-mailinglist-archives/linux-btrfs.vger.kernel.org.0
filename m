Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D0B7B5836
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 18:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbjJBQSF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 12:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbjJBQSD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 12:18:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC53E9E
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 09:17:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ADB7B1F747;
        Mon,  2 Oct 2023 16:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696263478;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QfygI3wRbYoYsXqWV1iR3DNuJXqlhgKkq4GhWMsPu9U=;
        b=WRUA2zmJK0XyGJZZC7oeixwKGyDlvyae6iDDuVWHQR9zSfIV+na+UAR0vaAwxNSiD0Bfit
        6d+Ns+MVip6In1uiNHbN4WFmIv9GyL9fEKPodRrs26cMwUDwlgOL7//KN+qiaqnvdBHRRQ
        L2LVQdY7VdONXy4tee70JqdlrIR7C7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696263478;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QfygI3wRbYoYsXqWV1iR3DNuJXqlhgKkq4GhWMsPu9U=;
        b=UzxoPvFKUASzcSw4cEEcGjYONT4GuKheo1v7q9YTvSxkxZTIL02W16xu/WyFB8X+zVOHLO
        rHhNVyHp4TyJcyAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E5EF13456;
        Mon,  2 Oct 2023 16:17:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7Zr5HTbtGmVwHQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Oct 2023 16:17:58 +0000
Date:   Mon, 2 Oct 2023 18:11:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 5/8] btrfs-progs: simple quotas mkfs
Message-ID: <20231002161117.GT13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695836680.git.boris@bur.io>
 <3b69a29059b051962e556f4ce3aa53e4d00466a2.1695836680.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b69a29059b051962e556f4ce3aa53e4d00466a2.1695836680.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 27, 2023 at 10:46:46AM -0700, Boris Burkov wrote:
> Add the ability to enable simple quotas from mkfs with '-O squota'
> 
> There is some complication around handling enable gen while still
> counting the root node of an fs. To handle this, employ a hack of doing
> a no-op write on the root node to bump its generation up above that of
> the qgroup enable generation, which results in counting it properly.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  check/qgroup-verify.c |  7 +++--
>  common/fsfeatures.c   |  9 ++++++
>  mkfs/main.c           | 64 +++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 72 insertions(+), 8 deletions(-)
> 
> diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
> index c95e6f806..1cf01d2d0 100644
> --- a/check/qgroup-verify.c
> +++ b/check/qgroup-verify.c
> @@ -1695,6 +1695,8 @@ static int repair_qgroup_status(struct btrfs_fs_info *info, bool silent)
>  	struct btrfs_path path;
>  	struct btrfs_key key;
>  	struct btrfs_qgroup_status_item *status_item;
> +	bool simple = btrfs_fs_incompat(info, SIMPLE_QUOTA);
> +	int flags = BTRFS_QGROUP_STATUS_FLAG_ON;
>  
>  	if (!silent)
>  		printf("Repair qgroup status item\n");
> @@ -1717,8 +1719,9 @@ static int repair_qgroup_status(struct btrfs_fs_info *info, bool silent)
>  
>  	status_item = btrfs_item_ptr(path.nodes[0], path.slots[0],
>  				     struct btrfs_qgroup_status_item);
> -	btrfs_set_qgroup_status_flags(path.nodes[0], status_item,
> -				      BTRFS_QGROUP_STATUS_FLAG_ON);
> +	if (simple)
> +		flags |= BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE;
> +	btrfs_set_qgroup_status_flags(path.nodes[0], status_item, flags);
>  	btrfs_set_qgroup_status_rescan(path.nodes[0], status_item, 0);
>  	btrfs_set_qgroup_status_generation(path.nodes[0], status_item,
>  					   trans->transid);
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 1c993b594..6bf87937b 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -109,6 +109,15 @@ static const struct btrfs_feature mkfs_features[] = {
>  		VERSION_NULL(default),
>  		.desc		= "quota support (qgroups)"
>  	},
> +	{
> +		.name		= "squota",
> +		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA,
> +		.sysfs_name	= "squota",
> +		VERSION_TO_STRING2(compat, 6,5),
> +		VERSION_NULL(safe),
> +		VERSION_NULL(default),
> +		.desc		= "squota support (simple qgroups)"
> +	},
>  	{
>  		.name		= "extref",
>  		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF,
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 1c5d668e1..5bb4d1a21 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -59,6 +59,8 @@
>  #include "mkfs/common.h"
>  #include "mkfs/rootdir.h"
>  
> +#include "libbtrfs/ctree.h"
> +
>  struct mkfs_allocation {
>  	u64 data;
>  	u64 metadata;
> @@ -882,6 +884,37 @@ static int insert_qgroup_items(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> +static int touch_root_subvol(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_trans_handle *trans;
> +	struct btrfs_key key = {
> +		.objectid = BTRFS_FIRST_FREE_OBJECTID,
> +		.type = BTRFS_INODE_ITEM_KEY,
> +		.offset = 0,
> +	};
> +	struct extent_buffer *leaf;
> +	int slot;
> +	struct btrfs_path path;
> +	int ret;
> +
> +	trans = btrfs_start_transaction(fs_info->fs_root, 1);
> +	btrfs_init_path(&path);
> +	ret = btrfs_search_slot(trans, fs_info->fs_root, &key, &path, 0, 1);
> +	if (ret)
> +		goto fail;
> +	leaf = path.nodes[0];
> +	slot = path.slots[0];
> +	btrfs_item_key_to_cpu(leaf, &key, slot);
> +	btrfs_mark_buffer_dirty(leaf);
> +	btrfs_commit_transaction(trans, fs_info->fs_root);
> +	btrfs_release_path(&path);

Why there is no error handling for transaction start and commit?

> +	return 0;
> +fail:
> +	btrfs_abort_transaction(trans, ret);
> +	btrfs_release_path(&path);
> +	return ret;
> +}
> +
>  static int setup_quota_root(struct btrfs_fs_info *fs_info)
>  {
>  	struct btrfs_trans_handle *trans;
> @@ -890,8 +923,11 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
>  	struct btrfs_path path;
>  	struct btrfs_key key;
>  	int qgroup_repaired = 0;
> +	bool simple = btrfs_fs_incompat(fs_info, SIMPLE_QUOTA);
> +	int flags;

Please use matching type for the structures, this is u64.

>  	int ret;
>  
> +
>  	/* One to modify tree root, one for quota root */
>  	trans = btrfs_start_transaction(fs_info->tree_root, 2);
>  	if (IS_ERR(trans)) {
> @@ -921,13 +957,19 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
>  
>  	qsi = btrfs_item_ptr(path.nodes[0], path.slots[0],
>  			     struct btrfs_qgroup_status_item);
> -	btrfs_set_qgroup_status_generation(path.nodes[0], qsi, 0);
> +	btrfs_set_qgroup_status_generation(path.nodes[0], qsi, trans->transid);
>  	btrfs_set_qgroup_status_rescan(path.nodes[0], qsi, 0);
> +	flags = BTRFS_QGROUP_STATUS_FLAG_ON;
> +	if (simple) {
> +		btrfs_set_qgroup_status_enable_gen(path.nodes[0], qsi, trans->transid);
> +		flags |= BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE;
> +	}
> +	else {
> +		flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
> +	}
>  
> -	/* Mark current status info inconsistent, and fix it later */
> -	btrfs_set_qgroup_status_flags(path.nodes[0], qsi,
> -			BTRFS_QGROUP_STATUS_FLAG_ON |
> -			BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT);
> +	btrfs_set_qgroup_status_version(path.nodes[0], qsi, 1);
> +	btrfs_set_qgroup_status_flags(path.nodes[0], qsi, flags);
>  	btrfs_release_path(&path);
>  
>  	/* Currently mkfs will only create one subvolume */
> @@ -944,6 +986,15 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
>  		return ret;
>  	}
>  
> +	/* Hack to count the default subvol metadata by dirtying it */

This should try to explain how it works, not just that it's a hack. One
day we may want to remove it so it should be possible if there is a need
for it or not.

> +	if (simple) {
> +		ret = touch_root_subvol(fs_info);
> +		if (ret) {
> +			error("failed to touch root dir for simple quota accounting %d (%m)", ret);
> +			goto fail;
> +		}
> +	}
> +
>  	/*
>  	 * Qgroup is setup but with wrong info, use qgroup-verify
>  	 * infrastructure to repair them.  (Just acts as offline rescan)
> @@ -1743,7 +1794,8 @@ raid_groups:
>  		}
>  	}
>  
> -	if (features.runtime_flags & BTRFS_FEATURE_RUNTIME_QUOTA) {
> +	if (features.runtime_flags & BTRFS_FEATURE_RUNTIME_QUOTA ||
> +	    features.incompat_flags & BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA) {
>  		ret = setup_quota_root(fs_info);
>  		if (ret < 0) {
>  			error("failed to initialize quota: %d (%m)", ret);
> -- 
> 2.42.0
