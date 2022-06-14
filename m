Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7AD54AD8D
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240121AbiFNJsA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 05:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239637AbiFNJr7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 05:47:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B79E4160A
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 02:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 74F9DCE19D1
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 09:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180A4C3411B;
        Tue, 14 Jun 2022 09:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655200075;
        bh=x5MXaON1HY29ge4oURQdh+NgTlesWDZyQjJdzql0xdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDFcx4n+e/uRLS4+OTgg0kEzP7kxfMv/Z529vxt1CyZxy74FAE1FmegthkRtwo2UI
         yJJ/xDe1eEJf1/z3EX7alltTLjv/Wsb3s0QGB8nH0tUsBD7iNT47ci8yw20gan8G9u
         CpkZpFSHEYs5oeDqPLowtJZQbSJ7rJir7uUIfjNnx3v2lGg5+2m4fiNInmPT8Hvz9o
         DyIRUiQx+i1UdVo5tXNvnvJMGbqW7ils8du4DQMht6D7/vL09K3YkDUuH9JYleb1/G
         hJq1bDgYanoBAGD3Z/+/FilXezOdV1A5zYcTi0PtV04Hn53JywVVDfthc2iuiKNiqd
         mHcLPmBUE25Gg==
Date:   Tue, 14 Jun 2022 10:47:52 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: reset block group chunk force if we have to wait
Message-ID: <20220614094752.GA3886393@falcondesktop>
References: <26ea5e38363115b0a35bf7e56078a552075c9ca7.1655159467.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ea5e38363115b0a35bf7e56078a552075c9ca7.1655159467.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 13, 2022 at 06:31:17PM -0400, Josef Bacik wrote:
> If you try to force a chunk allocation, but you race with another chunk
> allocation, you will end up waiting on the chunk allocation that just
> occurred and then allocate another chunk.  If you have many threads all
> doing this at once you can way over-allocate chunks.
> 
> Fix this by resetting force to NO_FORCE, that way if we think we need to
> allocate we can, otherwise we don't force another chunk allocation if
> one is already happening.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/block-group.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index ede389f2602d..13358fbc1629 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3761,6 +3761,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
>  			 * attempt.
>  			 */
>  			wait_for_alloc = true;
> +			force = CHUNK_ALLOC_NO_FORCE;
>  			spin_unlock(&space_info->lock);
>  			mutex_lock(&fs_info->chunk_mutex);
>  			mutex_unlock(&fs_info->chunk_mutex);
> -- 
> 2.26.3
> 
