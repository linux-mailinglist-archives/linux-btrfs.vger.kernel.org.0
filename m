Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5751E53F1FB
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 00:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiFFWL4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jun 2022 18:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiFFWLz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jun 2022 18:11:55 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23B866AFC
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 15:11:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 62AAC5C00EF;
        Mon,  6 Jun 2022 18:11:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 06 Jun 2022 18:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1654553514; x=1654639914; bh=toZ01vF7La
        kolc6wkT7ocLm8bzPhxn/REPdDWboLSdA=; b=oo0Mvk4nRv5Qt+pJf362wquL7G
        a0AeHNgAnyQRgvBfRmzt0NorZgRhfKhLnhvQEsVcHqEqVGpwpDIqB7kTIZYyafel
        nVGP9PIwokEr9mm1RTUpXu74UytaYwavMLbQ1D0hPiq6AMQKHFSQFVAH16cSkTNt
        2nIc02Snzncds65ts2oh/4ywXH5iGs5mOEDCVmKb/wHMCzhPoGjU/RTSm6QGiMEQ
        tEE0YSvRioCA9Sw/PYovDDLd2ilftkUk/QlfM5b2FEKvYgRl/3W4VJ+1G/Eh8hM2
        WCEyGf3ApHXIEMuSpo8PibbQg0FRUrciUI9HDDU1CFNRnwq+MFKNaIhmNzJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1654553514; x=1654639914; bh=toZ01vF7Lakolc6wkT7ocLm8bzPh
        xn/REPdDWboLSdA=; b=d0BrK0XYsH/N7Uo6a0f9ewUmTK/4MVdpDd1DV0+fmMWg
        5lsGRiDm4zvD7iA2y06qdkbETg4D2SPQGRkLlJLBx5CspleU4trRfbJz5GIbcsBL
        ZMrA/5l3xoyGHwaV1slYPoX93ue9M/qd2J/EJ+LiNIrv4ZFzrSNBitERnRRLjcbN
        qabQ4qaHh38Sbu+0OvMdvBp4wXybmSzj9IdoSH2Umq1XTPs2ir7qk+mngoYu1QQu
        f+TzqaBt5Wvj8la7PFQ3iBPfwIPdidfdW69RUmD2AaavsWwq7h3MM/iTh3DPjrTB
        8KE2C+o+4kjtfjA87B3VaqhWSJbPIpVWbu/4rPJ8wQ==
X-ME-Sender: <xms:qnueYtw5wRO_apFb-BzBCkrqUvcg4aEhVuQe1HvKINGMwadH3riSLg>
    <xme:qnueYtRmB2q3ERftl93NaTvc9Jl3gqKWGHern1lq3Xyk7hXl6twvV_hoBorRbidAP
    RoHVGo7GMR60X3Jx6s>
X-ME-Received: <xmr:qnueYnWYWWY-zdtOEd-DXose9AETJ7ZJSanGAZbppDeDeTyHWpJ1O89XJu0c_R_TUhMsOp0o8Naz6vfBHR2V6m_QTRn1uQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtgedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvve
    eiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:qnueYvhz3llEa_-zSO-A2YinhW8UxbPb-KIpNm48bI2Swg3c2e6hBA>
    <xmx:qnueYvD0y1S5twaJDSWv8MlVDZ1bkwAQ8YfLdG_4xr0dQkiCv9v2oQ>
    <xmx:qnueYoKGDcc1ktgNVzrbx1AzakEZr47MgrFNFiVO6ZQN86y9382Mcg>
    <xmx:qnueYipvc7N5kjTlChfw0H606DH2dBudykF00q2Hu1Gpm36hglH5mw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jun 2022 18:11:53 -0400 (EDT)
Date:   Mon, 6 Jun 2022 15:11:52 -0700
From:   Boris Burkov <boris@bur.io>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: add missing inode updates on each iteration
 when replacing extents
Message-ID: <Yp57qB5gjZ1wpnja@zen>
References: <cover.1654508104.git.fdmanana@suse.com>
 <980e6be197825045a08ad6d463456bc73521e4d4.1654508104.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <980e6be197825045a08ad6d463456bc73521e4d4.1654508104.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 06, 2022 at 10:41:18AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When replacing file extents, called during fallocate, hole punching,
> clone and deduplication, we may not be able to replace/drop all the
> target file extent items with a single transaction handle. We may get
> -ENOSPC while doing it, in which case we release the transaction handle,
> balance the dirty pages of the btree inode, flush delayed items and get
> a new transaction handle to operate on what's left of the target range.
> 
> By dropping and replacing file extent items we have effectively modified

How can you be sure that you definitely modified it? Is it possible for
btrfs_drop_extents to return ENOSPC without dropping extents?

> the inode, so we should bump its iversion and update its mtime/ctime
> before we update the inode item. This is because if the transaction
> we used for partially modifying the inode gets committed by someone after
> we release it and before we finish the rest of the range, a power failure
> happens, then after mounting the filesystem our inode has an outdated
> iversion and mtime/ctime, corresponding to the values it had before we
> changed it.
> 
> So add the missing iversion and mtime/ctime updates.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/ctree.h   |  2 ++
>  fs/btrfs/file.c    | 19 +++++++++++++++++++
>  fs/btrfs/inode.c   |  1 +
>  fs/btrfs/reflink.c |  1 +
>  4 files changed, 23 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 55dee1564e90..737cd59d16b6 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1330,6 +1330,8 @@ struct btrfs_replace_extent_info {
>  	 * existing extent into a file range.
>  	 */
>  	bool is_new_extent;
> +	/* Indicate if we should update the inode's mtime and ctime. */
> +	bool update_times;
>  	/* Meaningful only if is_new_extent is true. */
>  	int qgroup_reserved;
>  	/*
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 1fd827b99c1b..29de433b7804 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2803,6 +2803,25 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
>  			extent_info->file_offset += replace_len;
>  		}
>  
> +		/*
> +		 * We are releasing our handle on the transaction, balance the
> +		 * dirty pages of the btree inode and flush delayed items, and
> +		 * then get a new transaction handle, which may now point to a
> +		 * new transaction in case someone else may have committed the
> +		 * transaction we used to replace/drop file extent items. So
> +		 * bump the inode's iversion and update mtime and ctime except
> +		 * if we are called from a dedupe context. This is because a
> +		 * power failure/crash may happen after the transaction is
> +		 * committed and before we finish replacing/dropping all the
> +		 * file extent items we need.
> +		 */
> +		inode_inc_iversion(&inode->vfs_inode);
> +
> +		if (!extent_info || extent_info->update_times) {
> +			inode->vfs_inode.i_mtime = current_time(&inode->vfs_inode);
> +			inode->vfs_inode.i_ctime = inode->vfs_inode.i_mtime;
> +		}
> +
>  		ret = btrfs_update_inode(trans, root, inode);
>  		if (ret)
>  			break;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3ede3e873c2a..ab4ebcb7878c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9907,6 +9907,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
>  	extent_info.file_offset = file_offset;
>  	extent_info.extent_buf = (char *)&stack_fi;
>  	extent_info.is_new_extent = true;
> +	extent_info.update_times = true;
>  	extent_info.qgroup_reserved = qgroup_released;
>  	extent_info.insertions = 0;
>  
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index 7e3b0aa318c1..977e0d218d79 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -497,6 +497,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
>  			clone_info.file_offset = new_key.offset;
>  			clone_info.extent_buf = buf;
>  			clone_info.is_new_extent = false;
> +			clone_info.update_times = !no_time_update;
>  			ret = btrfs_replace_file_extents(BTRFS_I(inode), path,
>  					drop_start, new_key.offset + datal - 1,
>  					&clone_info, &trans);
> -- 
> 2.35.1
> 
