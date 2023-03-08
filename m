Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F406B11F7
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Mar 2023 20:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjCHT2u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Mar 2023 14:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHT2s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Mar 2023 14:28:48 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D6FA8EB9
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Mar 2023 11:28:47 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C05A5C00E6;
        Wed,  8 Mar 2023 14:28:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 08 Mar 2023 14:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678303727; x=1678390127; bh=0e
        txoEvNlBYGLazJTBES3oNgWPF+uTCD43qy70syBAU=; b=IVWVRMCTZElUpIZqyH
        4F0yKntRcv7NjJBna9d+iKHc6EQOdd9Bjd70dIgakiBrJy/yaiiulSmmhU766qJC
        ukBQMtn/35F8pDS5NAwTogAARF6gfBzz9706H141UsnLW3KpPPiVhFiJAl0zn624
        SQRHIHUXo9RnquEpRywL26o96ELOefZXVCkLz+nqw0tcbB/lYvfFDhil9vOlMPK6
        /s3kF/fFVJa8gs/sJN2SOqcb1Fzh48hhjswXdWu81c5mtOk69dvRyiHng+Cb5S9l
        L0vW9vDw2TV//7/wj7t3MDhxCN4R7aP7eYcG0vXYPe6SVs3DylvL+jlNlZ40rZna
        TvtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678303727; x=1678390127; bh=0etxoEvNlBYGL
        azJTBES3oNgWPF+uTCD43qy70syBAU=; b=YANW+yo8EFiOFkV42KxHhyXtAu40w
        Ns1MTbu9nPZ1KR+m+vsGN+qoUqGUJDIWScixLGPzvk2h4n2A/8p9bvdlWUNg0qaV
        JOUHUUboEFp4tuT6mShZwP4HDHCnx4h6RBpnvKU8pWBZLm5DNQbyx0r63NaytD3c
        uq1pjIaODz9B70ITNshCMgiW8Yt/XEZWNsW4kL8qkPYqPzfHD27EucjVN7YWWH+a
        kkveurMWWtDp+nwhvPXiG9ao/g8oYZ6uHuGOzTDGV7HToZ9zTQmEZe2nREOXb9pf
        5Pp9BejT6+2Noywkl4lJyOnOFnuQSNVPexJ1NJL7JRbMlIDKyiM2rBEYg==
X-ME-Sender: <xms:7-EIZKPypuR-5D41ThRzjylgAkM3SiP1LQfObeT_IHZeH3_SpkLi6g>
    <xme:7-EIZI_dTalKJo3WH_9XOMgZXwBKnhJ63QpUQ_SWi_aotl-9G4xwcNND8gRgp8rzu
    FA39EyfMEHwaxEGYO0>
X-ME-Received: <xmr:7-EIZBQoakTWMYYc21kdvZfA9f6jEtfD7c1DLazORxDwDFfVWaKqBe7z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddufedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:7-EIZKt0iBC-gW9RhWPKhHeN4NHFTUWuDc13x6OCe6m5pjHQ1Yc5lA>
    <xmx:7-EIZCcT07YSY-coao7rqoO6mX0Vx9C_ya0jvTNkdbPRVjKXQrBubQ>
    <xmx:7-EIZO3N7nUP-EQEhvNNBY9jviFJ0ve0_bMl2FNPA1co_P_d5J0oGQ>
    <xmx:7-EIZGFKGw8rRfJXVxsMvHrz1facp84_IsZ0S2m8ULWjpJrfi54-Kw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Mar 2023 14:28:46 -0500 (EST)
Date:   Wed, 8 Mar 2023 11:28:45 -0800
From:   Boris Burkov <boris@bur.io>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 02/21] btrfs: add WARN_ON() on incorrect lock range
Message-ID: <20230308192845.GC30177@zen>
References: <cover.1677793433.git.rgoldwyn@suse.com>
 <e12de38182a185ffc0540190a90d97124232103f.1677793433.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e12de38182a185ffc0540190a90d97124232103f.1677793433.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 02, 2023 at 04:24:47PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Add a WARN_ON(start > end) to make sure that the locking happens on the
> correct range and no incorrect nodes (with state->start > state->end)
> are added to the tree.

Looks good, naturally. Quick question about it: do you think that
checking this invariant applies to other extent bit setting operations?

Perhaps it could also make sense to refactor
btrfs_debug_check_extent_io_range s.t. it compiles regardless of
CONFIG_BTRFS_DEBUG, and that it's possible for a caller to opt in to
checking even when the debug setting isn't set. (Perhaps with a
_checked() variant of the set_extent_bit function or something)

> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/extent-io-tree.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index 29a225836e28..482721dd1eba 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -1710,6 +1710,7 @@ int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
>  	int err;
>  	u64 failed_start;
>  
> +	WARN_ON(start > end);
>  	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
>  			       NULL, cached, NULL, GFP_NOFS);
>  	if (err == -EEXIST) {
> @@ -1732,6 +1733,7 @@ int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
>  	int err;
>  	u64 failed_start;
>  
> +	WARN_ON(start > end);
>  	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
>  			       &failed_state, cached_state, NULL, GFP_NOFS);
>  	while (err == -EEXIST) {
> -- 
> 2.39.2
> 
