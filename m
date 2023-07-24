Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E93775FF0F
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 20:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGXS3R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 14:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjGXS3Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 14:29:16 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E5510D9
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 11:29:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 17B6A5C01BB;
        Mon, 24 Jul 2023 14:29:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Jul 2023 14:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1690223354; x=1690309754; bh=SE
        qft7f75ZVWmPwsG17Hdjxnf2jYnyWoHpz+3BvXAiY=; b=UDs+8bQu5gDs2emGm+
        Plue4C67dxu7zwysQ+6uQcdEB1+f8x4lUpkHC2auR6DtB+08tBoFejr8cI/ddwmG
        O8CfFqeX+wLXe/Tk7w7bmcYdrtjRupJDzXtw/obIlnUNplGZ/jTfc2gphIuhgGtb
        JVrYRiXv2tng29YnRVh1d6lvy6gi2LYe/dVuleAiaWEbekMJnh6k0ZkSSYOy1fYk
        I5E2a6tXutI68IF7iH5Cu99+ZAEKd9nngtub7gg1UMo33MCrh/y7NUX3im+aV1dQ
        /guu7pGqZR+WG4d4Yd87FYoscNeqAR7u8b/d5cxFKl1mvU6+SiTYoasbkEEPTqKd
        CwRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690223354; x=1690309754; bh=SEqft7f75ZVWm
        PwsG17Hdjxnf2jYnyWoHpz+3BvXAiY=; b=KD1IUXqzsoxwC0OyV9r9WDdwmfHJf
        0sPIow1Ddu794pkJpCIkcb4GynolGz8Ds+LWp8uHFMn5r351li/kg+Q7nKwPO5z4
        EC1hsrfIVWEWfXOmLCFjA+08t9cg0F5c7WOLzwaWc+fsbYecRimvSlH3liy0l7b3
        AMISlkTuniqUDJQ19peLFOLrNDAIu6u15SNlNz6lo+6jPp4QeYUZFTXVyxxvQkOn
        hufU6L5FEla5DEOGzpumvTCh2WrezsBwp3VBNdcAV9cWtO2znAhxLXJANeTZR+Z9
        RHdnpubx8J1lf6tDRANRoZL+nUaXamwoU0Re4Sh0HDZ+IBocOrqj3jtCw==
X-ME-Sender: <xms:-cK-ZPG4QOiqtedzDbTrec2Pp0ft7QVm5hbZoN3-RSj1GXXd7PQ3FQ>
    <xme:-cK-ZMVg2c1ztChUOvQFqEs0SzcuUOkrU6RClmEaB0fVzrdjQomnUdlcZViNzJv-P
    PP9qkhZDBguXtY65I8>
X-ME-Received: <xmr:-cK-ZBKKe_WDbK6oC-5RaSwjqT7l2MSZZ_RymADsU2ZKO9WsuT_R181wXr7eU-UJB2ZWpNlO9wshHebyWGN83YPh8lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheekgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:-cK-ZNFhIa2UB77iJA5dLuTwmhQUZSR7ZAukYhoLM1lndDis5fu1iQ>
    <xmx:-cK-ZFUwCFz8_7OgEFsc6u1fl0Ukf0RxWoP2upDz90calkGTFao03g>
    <xmx:-cK-ZIOOK1DW_-Moc_Mt_PTaK1P5JuEzPmuEV53idir7aahOCpB6vQ>
    <xmx:-sK-ZIQhuD5ycaFiONJ-y7okCTR9vVQsTZQki2tUi2WqUvMWR6MNbw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jul 2023 14:29:13 -0400 (EDT)
Date:   Mon, 24 Jul 2023 11:27:37 -0700
From:   Boris Burkov <boris@bur.io>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/6] btrfs: consolidate the error handling in
 run_delalloc_nocow
Message-ID: <20230724182737.GA587411@zen>
References: <20230724142243.5742-1-hch@lst.de>
 <20230724142243.5742-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724142243.5742-4-hch@lst.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 07:22:40AM -0700, Christoph Hellwig wrote:
> Share the calls to extent_clear_unlock_delalloc for btrfs_path allocation
> failure handling and the normal exit path.
> 
> This relies on btrfs_free_path ignoring a NULL pointer, and the
> initialization of cur_offset to start at the beginning of the function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/inode.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 212aca4eea442b..2d465b50c228ed 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1973,21 +1973,14 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
>  	struct btrfs_path *path;
>  	u64 cow_start = (u64)-1;
>  	u64 cur_offset = start;
> -	int ret;
> +	int ret = -ENOMEM;
>  	bool check_prev = true;
>  	u64 ino = btrfs_ino(inode);
>  	struct can_nocow_file_extent_args nocow_args = { 0 };
>  
>  	path = btrfs_alloc_path();
> -	if (!path) {
> -		extent_clear_unlock_delalloc(inode, start, end, locked_page,
> -					     EXTENT_LOCKED | EXTENT_DELALLOC |
> -					     EXTENT_DO_ACCOUNTING |
> -					     EXTENT_DEFRAG, PAGE_UNLOCK |
> -					     PAGE_START_WRITEBACK |
> -					     PAGE_END_WRITEBACK);
> -		return -ENOMEM;
> -	}
> +	if (!path)
> +		goto error;

nit: I think it's nicer to do ret = -ENOMEM here rather than relying on
initializion. It makes it less likely for a different change to
accidentally disrupt the implicit assumption that ret == -ENOMEM.

>  
>  	nocow_args.end = end;
>  	nocow_args.writeback_path = true;
> -- 
> 2.39.2
> 
