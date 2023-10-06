Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DD07BBA97
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 16:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjJFOnF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 10:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjJFOnA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 10:43:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C074FF2
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Oct 2023 07:42:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E7F21F895;
        Fri,  6 Oct 2023 14:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696603378;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GiUDM7DCoQx8URk4+1kkgczNVXL9StWlpt+4zrAgoMA=;
        b=ptTksd6nrLRa6lIcQYst926a3cbdEhjBd3QG6RVC4fQQgFm476cb5Hb5GI23boUg5ghSnE
        eI8dds5fsOElnd09UNSr6HZhPWRDXBhHTwH2gL/cV/zs0/Mu78CnYuzt35JhNmwJ6Eq+FX
        TJ5WAa9h9xV4OAeqh87z0Vg4VivJfC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696603378;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GiUDM7DCoQx8URk4+1kkgczNVXL9StWlpt+4zrAgoMA=;
        b=AqK1pY8jcEAYhKMxztFYW6fX1XhGbE4mEMdvusZ2mdFQ1n70LzSfjaqEuh/wDr0hwqrG6P
        FoDeavHz2ex5gcCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 595CC13586;
        Fri,  6 Oct 2023 14:42:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jdPqFPIcIGUAZgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 06 Oct 2023 14:42:58 +0000
Date:   Fri, 6 Oct 2023 16:36:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: output extra info when delayed inode update failed
Message-ID: <20231006143614.GF28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <aee666e094ffa89d5d4f6bc733230ae60ee3e6d8.1696573282.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aee666e094ffa89d5d4f6bc733230ae60ee3e6d8.1696573282.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 06, 2023 at 04:52:09PM +1030, Qu Wenruo wrote:
> There are at least 2 bug reports internally showing transaction abort

Please add links to the reports

> due to -ENOENT, from the btrfs_abort_transaction() call inside
> __btrfs_run_delayed_items().
> 
> For now I don't have a concrete idea on why, but strongly it's the
> following call chain causing the problem:
> 
> __btrfs_commit_inode_delayed_items()
> `- btrfs_update_delayed_inode()
>    `- __btrfs_update_delayed_inode()
>       `- btrfs_lookup_inode()
> 
> This patch would add extra debug for the involved call chain, with
> possible leaf dump if needed.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> I strongly assume it's the the case described above, in that case the
> fix would just follow btrfs_delete_delayed_inode() to exit early if no
> inode item can be found, and not return -ENOENT.
> 
> In that case, some debug here can also be removed as they would be too
> noisy for regular operations.

This is under the -- marker but somehow feels like it should be in the
changelog to as it adds more context, you can add it as a Note: to make
it separate from the regular changelog.

> ---
>  fs/btrfs/delayed-inode.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 35d7616615c1..1b05c7a818ec 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -19,6 +19,7 @@
>  #include "space-info.h"
>  #include "accessors.h"
>  #include "file-item.h"
> +#include "print-tree.h"
>  
>  #define BTRFS_DELAYED_WRITEBACK		512
>  #define BTRFS_DELAYED_BACKGROUND	128
> @@ -1021,10 +1022,16 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
>  		mod = 1;
>  
>  	ret = btrfs_lookup_inode(trans, root, path, &key, mod);
> -	if (ret > 0)
> +	if (ret > 0) {
> +		btrfs_print_leaf(path->nodes[0]);
>  		ret = -ENOENT;
> -	if (ret < 0)
> +	}
> +	if (ret < 0) {
> +		btrfs_err(fs_info,
> +			"failed to locate inode item for root %lld ino %lld: %d",
> +			root->root_key.objectid, node->inode_id, ret);
>  		goto out;
> +	}
>  
>  	leaf = path->nodes[0];
>  	inode_item = btrfs_item_ptr(leaf, path->slots[0],
> @@ -1054,6 +1061,12 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
>  	 * in the same item doesn't exist.
>  	 */
>  	ret = btrfs_del_item(trans, root, path);
> +	if (ret < 0) {
> +		btrfs_print_leaf(path->nodes[0]);
> +		btrfs_err(fs_info,
> +		"failed to delete inode ref item, key (%llu %u %llu): %d",
> +			  key.objectid, key.type, key.offset, ret);

It looks like a return or goto error is missing here, if this is
supposed to continue without that then please add a comment like
/* Fallthrough */.

> +	}
>  out:
>  	btrfs_release_delayed_iref(node);
>  	btrfs_release_path(path);
> @@ -1114,14 +1127,23 @@ __btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
>  	int ret;
>  
>  	ret = btrfs_insert_delayed_items(trans, path, node->root, node);
> -	if (ret)
> +	if (ret) {
> +		btrfs_err(trans->fs_info, "failedd to insert delayed items: %d",
                                           ^^^^^^^

> +			  ret);
>  		return ret;
> +	}
>  
>  	ret = btrfs_delete_delayed_items(trans, path, node->root, node);
> -	if (ret)
> +	if (ret) {
> +		btrfs_err(trans->fs_info, "failedd to delete delayed items: %d",
                                           ^^^^^^^
> +			  ret);
>  		return ret;
> +	}
>  
>  	ret = btrfs_update_delayed_inode(trans, node->root, path, node);
> +	if (ret)
> +		btrfs_err(trans->fs_info, "failedd to update delayed items: %d",
                                           ^^^^^^^

typos

> +			  ret);
>  	return ret;
>  }
>  
> -- 
> 2.42.0
