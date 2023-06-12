Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57B672D377
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 23:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbjFLVoL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 17:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFLVoK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 17:44:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5DCD2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 14:44:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE5E91F45F;
        Mon, 12 Jun 2023 21:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686606247;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RogqoERPpDWXI8SW7ypfF7WoI/YPlGQ046UzyN99TrA=;
        b=g13Vf4Blw2de/B9yzKnyRvaOFGuSAKuffoBBK9OM6qbiS+qiNdzhuXQPTvKM6d4QKkoasm
        QPKHiQVDrAUxi5t4Yb00uLo3I+VM4cTC17Cm01c8yvqSsSbUkYH4t/DWvjebtLaqDJRJCp
        CKn+2DZ75yx0iJ0SX18xTEkrsugvJR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686606247;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RogqoERPpDWXI8SW7ypfF7WoI/YPlGQ046UzyN99TrA=;
        b=EjkWQRTZ/l4oRZn6AoDQpkV2oym4hbD0aozCQqKiWsZVikfQ3MGQsglpSpJMeUQTG8Se7x
        sBBgjvrkD50unfAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 946261357F;
        Mon, 12 Jun 2023 21:44:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dqwvI6eRh2RuTAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 12 Jun 2023 21:44:07 +0000
Date:   Mon, 12 Jun 2023 23:37:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        syzbot+a694851c6ab28cbcfb9c@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: do not ASSERT() on duplicated global roots
Message-ID: <20230612213748.GG13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <89dec0414ce198ef49d3014232bd1b88e3e74260.1686441969.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89dec0414ce198ef49d3014232bd1b88e3e74260.1686441969.git.wqu@suse.com>
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

On Sun, Jun 11, 2023 at 08:09:13AM +0800, Qu Wenruo wrote:
> [BUG]
> Syzbot reports a reproducible ASSERT() when using rescue=usebackuproot
> mount option on a corrupted fs.
> 
> The full report can be found here:
> https://syzkaller.appspot.com/bug?extid=c4614eae20a166c25bf0

I'll copy the stack trace here, the link is good for reference but we
want to record the contents too.

> [CAUSE]
> Since the introduction of global roots, we handle
> csum/extent/free-space-tree roots as global roots, even if no
> extent-tree-v2 feature is enabled.
> 
> So for regular csum/extent/fst roots, we load them into
> fs_info::global_root_tree rb tree.
> 
> And we should not expect any conflicts in that rb tree, thus we have an
> ASSERT() inside btrfs_global_root_insert().
> 
> But rescue=usebackuproot can break the assumption, as we will try to
> load those trees again and again as long as we have bad roots and have
> backup roots slot remaining.
> 
> So in that case we can have conflicting roots in the rb tree, and
> triggering the ASSERT() crash.
> 
> [FIX]
> We can safely remove that ASSERT(), as the caller will properly put the
> offending root.
> 
> To make further debugging easier, also add two explicit error messages:
> 
> - Error message for conflicting global roots
> - Error message when using backup roots slot
> 
> Reported-by: syzbot+a694851c6ab28cbcfb9c@syzkaller.appspotmail.com
> Fixes: abed4aaae4f7 ("btrfs: track the csum, extent, and free space trees in a rb tree")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 1168e5df8bae..7f201975a303 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -748,13 +748,18 @@ int btrfs_global_root_insert(struct btrfs_root *root)
>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  	struct rb_node *tmp;
> +	int ret = 0;
>  
>  	write_lock(&fs_info->global_root_lock);
>  	tmp = rb_find_add(&root->rb_node, &fs_info->global_root_tree, global_root_cmp);
>  	write_unlock(&fs_info->global_root_lock);
> -	ASSERT(!tmp);
>  
> -	return tmp ? -EEXIST : 0;
> +	if (tmp) {
> +		ret = -EEXIST;
> +		btrfs_warn(fs_info, "global root %lld %llu already exists",

%lld is to show the negative numbers, right? Are there any actual global
roots with such numbers?

BTRFS_DATA_RELOC_TREE_OBJECTID		-9
BTRFS_TREE_RELOC_OBJECTID		-8
BTRFS_TREE_LOG_FIXUP_OBJECTID		-7
BTRFS_TREE_LOG_OBJECTID			-6

None of them seems to be among the global roots.

> +				root->root_key.objectid, root->root_key.offset);
> +	}
> +	return ret;
>  }
>  
>  void btrfs_global_root_delete(struct btrfs_root *root)
> @@ -2591,6 +2596,7 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
>  			/* We can't trust the free space cache either */
>  			btrfs_set_opt(fs_info->mount_opt, CLEAR_CACHE);
>  
> +			btrfs_warn(fs_info, "try to load backup roots slot %u", i);

is int, so %d

>  			ret = read_backup_root(fs_info, i);
>  			backup_index = ret;
>  			if (ret < 0)
> -- 
> 2.41.0
