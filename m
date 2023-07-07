Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6F674B7D4
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 22:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGGU1a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 16:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGGU13 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 16:27:29 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920EE128
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 13:27:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3D28B5C0003;
        Fri,  7 Jul 2023 16:27:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 07 Jul 2023 16:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1688761645; x=1688848045; bh=f5
        YoF7CwVDx6FisEgW7gJfA32bLLwlbHdN3VqGMaEjI=; b=bLzVmnZszyZwdaRchA
        1S5auzzPaFvV6jo4oNN65MBNmDZPPiWFMyAFHedaFhi4GMsSIYV45EWVYwIuiUE/
        5t8FwExzBQ5BT6W9xzaZOW0bjnIW/l33zWtSqzkxvr0369YikjzY/p4vI5EJYD5t
        YR+YLUA3uq+6cGNQu7O42+1TX+epxWFS1nW32PR7GKg/X0DD5viH8/LQKsGDbyzS
        6rNij8ql/jC4UjAVCQForytqGhdTmkkMAUwJtoHvTQoLTbSwwvk/NQCkCJDK81ou
        LPDYNV16301ts1AFdRMTI/aNWQm9J0oB0C19EvV+KFIwBbItZvUo7nVWIprp6IIy
        Ef6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688761645; x=1688848045; bh=f5YoF7CwVDx6F
        isEgW7gJfA32bLLwlbHdN3VqGMaEjI=; b=LJs1SGTeIMijxOQVy3UZ7Koac2QJW
        3JRIXNqLBYzXRttnqANgEFRY+sA1+i2GUi3KjGapp3WpOmGhOxpdzVimLEwPc5hM
        3yov4DPmlZjVRYTFRvSfQDX2+GJNO5w2+J06WwpCgxVRTB036DkS0q7C8unBCRRY
        c/IH0iBzIJvvOFFYTbG0QcuuVQy9cza0AdEZf9/0UwhCYe8rfsHPvgo25NqZOiqP
        7ocryv2Gs+yaEufNBi68YRnUn5i+dPZmahJHJRpK3j8GLSqPjwta7Vl2nJ64bE+s
        t15cr9y8A/qFZb+FRosKb1zbpL8/IJmJBrDpJRgTKBQQKtUhDJR4OYeNA==
X-ME-Sender: <xms:LHWoZBl-OUqin8g9RSjfD0fQHf4D1vAkeo0sWpGSTIivTaJVtzOtWA>
    <xme:LHWoZM1Cx3Zd_ltjczXSjB4t_WM5dYIzXeYn4mk5iCFLdHnCKHMMRf33IHIvNDiID
    8lMwY5g35_O_8E-ZBg>
X-ME-Received: <xmr:LHWoZHr3N-tCn19Ks0YJEaXVG3kL9jxESa_8qHOJIJjvYlh2SvTc5uT2arUTwjnROiM4W2VTgCsArn_IgOWDzX_YXmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvddugddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvve
    eiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:LXWoZBlnh6RsUV53viSteqV7bTviRI_tx5dUCZVM_pC49IT6FFfEaA>
    <xmx:LXWoZP0fl6maQMWCmWVLIAwBdKAs6KX9FWEnMma4x9yI6iAPCvTziA>
    <xmx:LXWoZAuJOGADN3rddFmkp0sxVM7fC1FaLzL3qy6zJXj_hmszVZrdxA>
    <xmx:LXWoZM_J2seDbOY21vj-YgSTpbe4yCn06h2fmGQVrXX8p48VENzdmA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jul 2023 16:27:24 -0400 (EDT)
Date:   Fri, 7 Jul 2023 13:26:15 -0700
From:   Boris Burkov <boris@bur.io>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: fix double iput() on inode after an error
 during orphan cleanup
Message-ID: <20230707202615.GA2547493@zen>
References: <cover.1688403622.git.fdmanana@suse.com>
 <e20676cb8b120f12892f1e6ed80d91ec551ed533.1688403622.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e20676cb8b120f12892f1e6ed80d91ec551ed533.1688403622.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 03, 2023 at 06:15:30PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At btrfs_orphan_cleanup(), if we were able to find the inode, we do an
> iput() on the inode, then if btrfs_drop_verity_items() succeeds and then
> either btrfs_start_transaction() or btrfs_del_orphan_item() fail, we do
> another iput() in the respective error paths, resulting in an extra iput()
> on the inode.
> 
> Fix this by setting inode to NULL after the first iput(), as iput()
> ignores a NULL inode pointer argument.
> 
> Fixes: a13bb2c03848 ("btrfs: add missing iputs on orphan cleanup failure")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index dbbb67293e34..d919318d2498 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3728,6 +3728,7 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
>  			if (!ret) {
>  				ret = btrfs_drop_verity_items(BTRFS_I(inode));
>  				iput(inode);
> +				inode = NULL;
>  				if (ret)
>  					goto out;
>  			}
> -- 
> 2.34.1
> 
