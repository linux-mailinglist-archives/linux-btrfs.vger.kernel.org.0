Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501B8594D3E
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 03:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiHPBVB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Aug 2022 21:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiHPBU1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Aug 2022 21:20:27 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643021C1865;
        Mon, 15 Aug 2022 14:12:09 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4480232004AE;
        Mon, 15 Aug 2022 17:12:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 15 Aug 2022 17:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660597926; x=1660684326; bh=duedlCLDEu
        9t8HnT+Y8HmDQ++Q7DMuHbP3sR5+RPBD8=; b=ncmQW4mdway+eYunr02KKcLLnB
        qeoRtm4heWV5bPDmXKCULOeCVxp5QfxYU0zRWVG25Bt9CTRduQaQyi2jQg/bSI9x
        6UqH8JzoV47QuYxZvE7ccJCgudeCUjejz5HXfPudr0jVaK9qJcQr+D0vdMpao+Hr
        sWpK4DZS8L5SL5IYs1laqKojYbOeQGfKRVmp5iUdwZCT3MXriwqeLY0w6QOdVhKQ
        mhFZ98ngEMEkpfeyeD9DtuiR46txJtj0iwYxltZw4bdc8MGqvbsvuiiVGuXN5+1p
        rOcHElfAIAFp37RVpVYJddz/PiO5NOz3PWOA4Vxsl0JGklAhBQyKpciOy4wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660597926; x=1660684326; bh=duedlCLDEu9t8HnT+Y8HmDQ++Q7D
        MuHbP3sR5+RPBD8=; b=UhY1MFd0BSHNck9qz+wHrdZjIu0VqjwBtM6eCdIM3+Pb
        cTl1rqreTSh/XuQXip5V06QM6eD40t5yHnh//biLvoXoZE694dUn35EpbgrFUX54
        In5lSMBtiNAaLY8LqDF9+EMet/6Um9Ok5MPNoOBbI7CVnRhCWRbbL4q7TH3LvCwM
        c+vZ+aPBeWHIXooGtXegKlI9ymLZB5toK7H+gEjXxNsGrhJXkjL+fKkDuFGNbAwR
        BY+RUJYoEWLcgi1+wjFdQ0jKANvcbc9t4H/Etp8YT7GKkgOWaSmHsY92Zu3kyNx8
        EIY7RmcSjBupFEC//bQ7x1aw2IiArIRR7s1uJk/guw==
X-ME-Sender: <xms:pbb6YqYdHobCAelZ7xNWnF5o0CwhRvUzh8W3KlRqsKaQ9lp8Sp2kZg>
    <xme:pbb6Ytbfc7qcHL2O2PJyxXwqJujRiPRZuKNxYiamCFFaHOudoMGjRerj8i9_XG20i
    HRyaBqyXZhQEQaM8Fw>
X-ME-Received: <xmr:pbb6Yk_qGGPBERhlmIMHWnFnaL7j5w7XNX69dNUzxe9B9TefWhv9K79eT4oLzKqIOLl7E17Uk9UgeIlirpAFiRol0EuOcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghu
    rhdrihhoqeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvd
    evieeiiedugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:pbb6Ysop1lsXOOFMHT1RA1DY5xfzrzTKFdekNZBcpZuS4MOm4FtzBw>
    <xmx:pbb6YloLN3K-WvhF3UbI_yxBChNdwVW2Tv6JVCYVA1pGrnDqYCSurQ>
    <xmx:pbb6YqRNgRn4GduhrhdTsxeWUA-h48zui3BBOKN7I70BIxQ9WaqGkQ>
    <xmx:prb6Ymc4hqTqn1QZ7_5AC3aIOhL8qDEhmX0AifcitlFY_9TYjI5WWQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 17:12:05 -0400 (EDT)
Date:   Mon, 15 Aug 2022 14:13:28 -0700
From:   Boris Burkov <boris@bur.io>
To:     Zixuan Fu <r33s3n6@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH] fs: btrfs: fix possible memory leaks in
 btrfs_get_dev_args_from_path()
Message-ID: <Yvq2+EWVBc5L1LZH@zen>
References: <20220815151606.3479183-1-r33s3n6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815151606.3479183-1-r33s3n6@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 15, 2022 at 11:16:06PM +0800, Zixuan Fu wrote:
> In btrfs_get_dev_args_from_path(), btrfs_get_bdev_and_sb() can fail if the
> path is invalid. In this case, btrfs_get_dev_args_from_path() returns
> directly without freeing args->uuid and args->fsid allocated before, which
> causes memory leaks.
> 
> To fix these possible leaks, when btrfs_get_bdev_and_sb() fails, 
> btrfs_put_dev_args_from_path() is called to clean up the memory.
> 
> Fixes: faa775c41d655 ("btrfs: add a btrfs_get_dev_args_from_path helper")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/volumes.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 272901514b0c..064ab2a79c80 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2345,8 +2345,11 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
>  
>  	ret = btrfs_get_bdev_and_sb(path, FMODE_READ, fs_info->bdev_holder, 0,
>  				    &bdev, &disk_super);
> -	if (ret)
> +	if (ret) {
> +		btrfs_put_dev_args_from_path(args);
>  		return ret;
> +	}
> +
>  	args->devid = btrfs_stack_device_id(&disk_super->dev_item);
>  	memcpy(args->uuid, disk_super->dev_item.uuid, BTRFS_UUID_SIZE);
>  	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
> -- 
> 2.25.1
> 
