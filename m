Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633ED540405
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 18:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345161AbiFGQpM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 12:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345171AbiFGQo6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 12:44:58 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFDFF504E
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 09:44:57 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5E6745C018F;
        Tue,  7 Jun 2022 12:44:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 07 Jun 2022 12:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1654620297; x=1654706697; bh=s7sH4zFQnY
        Mhk5Us0+HZH0IdCkwjWHvAA+B4cUyZiHI=; b=aAnttz7C5T6UBjyJi0Nk0Y9Rfx
        r9RKVPowg8Kab4xEYqeUGz8NlVkpSoWgTsT+gUEDmsweSKOcGw8X0NHstwkVDj30
        XrWlrakD6A+Rsw05aLQaR7yMOqX/eRuByecxHHdGaqmpi7m24Qb+20NTa6sib2z2
        voHiMqbEruJNmeMVG2GD1YMU/xV4yJHtmP9RHbOOGCBQiNVZdePAkjK4n46GZUOm
        UCFHZjFfSd9OyvrDcY0y4+sgaGzY65QezCSyCAH2jFpzZ3c/Erty+JIJY9WF4ixN
        ubKgmHN9qMqt5lbYTNLXlvthyJEONUURi4Y/eAWfhGxEo0vnRWpT1C/tp6CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1654620297; x=1654706697; bh=s7sH4zFQnYMhk5Us0+HZH0IdCkwj
        WHvAA+B4cUyZiHI=; b=V2O3+ayZ2X54dNs7ppctuZqjUW2EP4/sv6Lknf2P5m2T
        YWubYorxv4ktDwL1/N9Q+vsjo/ps/rMwB7qiKFc8BPZL5ZcZR3Yc+La58TZ73AI8
        7YdQCCYA6DIEsvtP+z+fyp7a4at+aJWfPfQZrLgpdtYpgE4cxPZCw2nTbIqm/HnH
        QRutkxZnw5l5ue3gPL8ULeLXilFkpNAf8qhivkntdQg9EWZzXw+SCMSmmMQKVF4R
        9Pev15mBiCu19Qv5tJDOMdoJNIfh74kD8HFmDMH5Il6dE+lFhpdlMTQR7p8QP7z7
        qxFAyxfDDwmTNluA9UWpM4NfvNlPs6GWkdaaDE6bAQ==
X-ME-Sender: <xms:iYCfYsqTHK65LhbYmue1qybn72vQLDYe9u3pvGHr7-_DB1lVF3aj8w>
    <xme:iYCfYiqFIIEBim0Ixi1CP_WvkGZamCdNbV__rBGLibvfaFZDa3BvE2UNEj9pLmhk5
    pBchJlCSZyo7bvUc-o>
X-ME-Received: <xmr:iYCfYhPHlFhiXLx2pfLwvHEEg_9N5Nbp3mzTdYmqtZhho5AEuusSQ3WxDkBIjPLiBzyQuz4k8ltQH4iLdZ3_Huvmti3tbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghu
    rhdrihhoqeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvd
    evieeiiedugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:iYCfYj5Bm6YKJo7OcrWzUL79RYtx2ygM-KFQCX_WrgH6FVQuLh0I5w>
    <xmx:iYCfYr4_JJIWlFaUr4Y-AXZa8nZLe1i27WLySuh3hqwQ4slMX98d1A>
    <xmx:iYCfYjh0wtKltwqeQdmlRX2ERC_sZHjb26ZInlSPPzIAZqea4YhQJg>
    <xmx:iYCfYoiT3o1TjXA8CPOHxIzp6Hg2oPqm6_Vd4dRUgdq5HgIIoRUQHQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jun 2022 12:44:56 -0400 (EDT)
Date:   Tue, 7 Jun 2022 09:44:55 -0700
From:   Boris Burkov <boris@bur.io>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: do not BUG_ON() on failure to migrate space
 when replacing extents
Message-ID: <Yp+Ah1N6CkRPdCM/@zen>
References: <cover.1654508104.git.fdmanana@suse.com>
 <dc02b21c1afa5b0c7af14dc1d0b46a3855d5cd9a.1654508104.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc02b21c1afa5b0c7af14dc1d0b46a3855d5cd9a.1654508104.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 06, 2022 at 10:41:19AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At btrfs_replace_file_extents(), if we fail to migrate reserved metadata
> space from the transaction block reserve into the local block reserve,
> we trigger a BUG_ON(). This is because it should not be possible to have
> a failure here, as we reserved more space when we started the transaction
> than the space we want to migrate. However having a BUG_ON() is way too
> drastic, we can perfectly handle the failure and return the error to the
> caller. So just do that instead, and add a WARN_ON() to make it easier
> to notice the failure if it evers happens (which is particularly useful
> for fstests, and the warning will trigger a failure of a test case).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/file.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 29de433b7804..da41a0c371bc 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2719,7 +2719,8 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
>  
>  	ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv, rsv,
>  				      min_size, false);
> -	BUG_ON(ret);
> +	if (WARN_ON(ret))
> +		goto out_trans;
>  	trans->block_rsv = rsv;
>  
>  	cur_offset = start;
> @@ -2838,7 +2839,8 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
>  
>  		ret = btrfs_block_rsv_migrate(&fs_info->trans_block_rsv,
>  					      rsv, min_size, false);
> -		BUG_ON(ret);	/* shouldn't happen */
> +		if (WARN_ON(ret))
> +			break;
>  		trans->block_rsv = rsv;
>  
>  		cur_offset = drop_args.drop_end;
> -- 
> 2.35.1
> 
