Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED6F788660
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 13:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242211AbjHYLwi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 07:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244232AbjHYLw0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 07:52:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40EF10FF
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 04:52:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 624D9653FF
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 11:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746C2C433C8;
        Fri, 25 Aug 2023 11:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692964343;
        bh=Cw+RgJBIbI14PDReeLRlheEacvr6y7G9HRsspEtFwrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QcsQWvEpIJV8gu97n62hVAqk6Cy442zivQWqcAJEN6Cnh9I22bfRarp9SK593JLs0
         apcXJ6tUyD+ggnpBpBC/Gl31Z8IeVw1x2kO4g7WSckw4lKagf7ZCN8y+5kK/oObl0y
         fKX8/Ti3jUrUQ6oAxXoJTwqqbUmqQw7hHSfdhvka/Rc/jBl8JtUxPaEWa7YyVPzefA
         dnkrghAV5RDgM1HzMtciYxpnWJjis6qwnOHbwfuNSXSdnGt+x76QZlMf8rPUEKemCj
         hRTMm3e0PwzTvi+juL1Z933Ndl/eo/Ai7j1tT/zuC75LM3c1vzhNK7iDu/5vnB0gSL
         aV/9ZV2IbDDHw==
Date:   Fri, 25 Aug 2023 12:52:20 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: check for BTRFS_FS_ERROR in pending ordered assert
Message-ID: <ZOiV9NakKKVGssWk@debian0.Home>
References: <c640ee0669c4454488d2ddacbc3a93884c905b38.1692910732.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c640ee0669c4454488d2ddacbc3a93884c905b38.1692910732.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 24, 2023 at 04:59:04PM -0400, Josef Bacik wrote:
> If we do fast tree logging we increment a counter on the current
> transaction for every ordered extent we need to wait for.  This means we
> expect the transaction to still be there when we clear pending on the
> ordered extent.  However if we happen to abort the transaction and clean
> it up, there could be no running transaction, and thus we'll trip the
> 
> ASSERT(trans)
> 
> check.  This is obviously incorrect, and the code properly deals with
> the case that the trans doesn't exist.  Fix this ASSERT() to only fire
> if there's no trans and we don't have BTRFS_FS_ERROR() set on the file
> system.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/ordered-data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 09b274d9ba18..69a2cb50c197 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -659,7 +659,7 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
>  			refcount_inc(&trans->use_count);
>  		spin_unlock(&fs_info->trans_lock);
>  
> -		ASSERT(trans);
> +		ASSERT(trans || BTRFS_FS_ERROR(fs_info));
>  		if (trans) {
>  			if (atomic_dec_and_test(&trans->pending_ordered))
>  				wake_up(&trans->pending_wait);
> -- 
> 2.26.3
> 
