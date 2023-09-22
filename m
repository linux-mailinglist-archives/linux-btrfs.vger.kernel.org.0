Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389367AB36D
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 16:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjIVOUj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 10:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjIVOUi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 10:20:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EB0100
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 07:20:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6245B21C99;
        Fri, 22 Sep 2023 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695392431;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tsrbYpKJ0QP24VyjWl5ISe/WfmMRCPUak4L6CdEwYiE=;
        b=TgosxgFJcSo6qTq2ln1ZbGytLNwBFJNxWKZiiOxwmkH2OzlO1KVZtrsgX4xefFkJg8Y1ro
        x3aPZRfT2AW3+VR9pGZ4u4kG0a1o1mPzg9WxVwFqbnMeiHyGbjCp9nnd/SCXNJzvaPsipM
        rSJKqUGQTO34qZL5a04VWWWeEZKI128=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695392431;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tsrbYpKJ0QP24VyjWl5ISe/WfmMRCPUak4L6CdEwYiE=;
        b=G0l2YDbEEDjvxhgpIcAetfIt25Ml27c+vz5sm5KZsBmGAv7C5XkhMT4LN/GDzF+N/YHxJM
        VfAxEJfVh9qH3zBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BF6413478;
        Fri, 22 Sep 2023 14:20:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O+SWDa+iDWXveQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 22 Sep 2023 14:20:31 +0000
Date:   Fri, 22 Sep 2023 16:13:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: move btrfs_defrag_root() to defrag.{c,h}
Message-ID: <20230922141356.GE13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9474fc4f5eca4a1e7bb38dd1cd2bd01537c4315a.1695335503.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9474fc4f5eca4a1e7bb38dd1cd2bd01537c4315a.1695335503.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 22, 2023 at 11:37:56AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The btrfs_defrag_root() function does not really belong in the
> transaction.{c,h} module and as we have a defrag.{c,h} nowadays,
> move it to there instead. This also allows to stop exporting
> btrfs_defrag_leaves(), so we can make it static.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.

> ---
>  fs/btrfs/defrag.c      | 44 ++++++++++++++++++++++++++++++++++++++++--
>  fs/btrfs/defrag.h      |  2 +-
>  fs/btrfs/transaction.c | 39 -------------------------------------
>  fs/btrfs/transaction.h |  1 -
>  4 files changed, 43 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index f2ff4cbe8656..53544787c348 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -343,8 +343,8 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
>   * better reflect disk order
>   */
>  
> -int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
> -			struct btrfs_root *root)
> +static int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
> +			       struct btrfs_root *root)
>  {
>  	struct btrfs_path *path = NULL;
>  	struct btrfs_key key;
> @@ -460,6 +460,46 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> +/*
> + * Defrag a given btree.
> + * Every leaf in the btree is read and defragged.
> + */
> +int btrfs_defrag_root(struct btrfs_root *root)
> +{
> +	struct btrfs_fs_info *info = root->fs_info;

Thi is a good opportunity, I've renamed it to fs_info as this is the
most commonly used name.
