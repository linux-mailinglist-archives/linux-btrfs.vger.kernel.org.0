Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623324B311E
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Feb 2022 00:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbiBKXAk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 18:00:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiBKXAj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 18:00:39 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E725CC63
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 15:00:37 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 533525C0180;
        Fri, 11 Feb 2022 18:00:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 11 Feb 2022 18:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=9M5Ncs89S9Yc+zjcWUc7s519s6sh3EVD1wy0fY
        yDlOU=; b=JAQT6gFoDw+Y1ZYH1n6LcWIS6v5/+HklUuE93w+WB87ZYM7TVp9Vp+
        H3ifkvnx57cd6OtyXufsHh3EBOk0XjhrxuwCHLw62MkHr6AX3OjXiBLm2gsq6k/9
        5Ct9xEMq4OGu0fAM05QzkqmBWDwWaZtmiUSehV+bY8J/7A7vDvM99/0DzTAHa8Dg
        tZsKrADemxlFDie94tMcQ87yFjQI4ZIPJqv6MScfCBZrwyUa4tqyifRzxA0R4Aco
        xw1LctazrK1D/LzZaJDhMoQ8E7c4ccN7XM8RkKtdZXACz1MIEYFOBjBuP236+FKx
        GfgqNReFfXICSzRrGkzlYJlxlF22xQew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=9M5Ncs89S9Yc+zjcW
        Uc7s519s6sh3EVD1wy0fYyDlOU=; b=GR2UMhcZLYKHRGfp7YuKrwsRdwZmn28GY
        A0QgiMCsaPcWLpCodfRYw4DicnT96b6Rrkduniv3tXMZ0/2Dgyza2XUQTNUEHzuc
        z9KPAgviR0wEDilCL9TK7fqtrpA5iyVoVkHK6SwK+4qpiGAbgUBHmtkTiV3UFjbI
        8JM1SKXa1So8b3TfIFDvZlHQ4ZTUK6Tx82hiK1nE4uStFh4fixzXtxkAQT+JY4do
        jTfAjRj4IoWIbrSS55e9EZWHueJhsU5o5xAolp5IB7SiCZ6eredJdVG82Wxi9UCH
        Fa5RW/XdVjSRuclOddWHKFrGumLpBOB/GyNtkJp7Qou7aQT4S91Zw==
X-ME-Sender: <xms:lOoGYjg8UI9_gUsHWXNXyLxrQVJSE06pDtsfoFEnV5v-fdham7PXug>
    <xme:lOoGYgAQ2nZsxljPqZ2xcZ6PoGnMnZ1hzrDdVfs-AyEwCxMHwqw1cThtEYd8S5qNy
    3xMY0uWtkbZ9MyGVCQ>
X-ME-Received: <xmr:lOoGYjEomTzf6fgqR8BK22uUdfhMpC5npq9g785W2YbDbWaTtpkP0y2A1NuzJHuiYqD8GsgQCRsXkjLa2ufDb2m449GpDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieeggddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehud
    evleekieetleevieeuhfduhedtiefgheekfeefgeelvdeuveeggfduueevfeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:lOoGYgSPYTdfdebjr6Ew72ks2nB9aqg4T3jd9ha3_CYBmfoXH1dbbg>
    <xmx:lOoGYgxB-8aTAdYGciquAKu2FiuB2r7sbGWAD86kjI5QoIRTsio5pw>
    <xmx:lOoGYm4WYlUd6FR_1cuwr5aPpYWrolAaRQflaxXu12zNyT5U0BVQAQ>
    <xmx:leoGYtr2Uf5bGYnYFnb0Dk4waC2elTWOtAv3kZEKq7flCtgN7QHv3w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 18:00:36 -0500 (EST)
Date:   Fri, 11 Feb 2022 15:00:35 -0800
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 8/8] btrfs: do not clean up repair bio if submit fails
Message-ID: <YgbqkwsuB4FP01Z1@zen>
References: <cover.1644532798.git.josef@toxicpanda.com>
 <ff852e85926bfa2949283bce0d8f3a91d5126bd5.1644532798.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff852e85926bfa2949283bce0d8f3a91d5126bd5.1644532798.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 10, 2022 at 05:44:26PM -0500, Josef Bacik wrote:
> The submit helper will always run bio_endio() on the bio if it fails to
> submit, so cleaning up the bio just leads to a variety of UAF and NULL
> pointer deref bugs because we race with the endio function that is
> cleaning up the bio.  Instead just return STS_OK as the repair function
> has to continue to process the rest of the pages, and the endio for the
> repair bio will do the appropriate cleanup for the page that it was
> given.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/extent_io.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 29ffb2814e5c..16b6820c913d 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2640,7 +2640,6 @@ int btrfs_repair_one_sector(struct inode *inode,
>  	const int icsum = bio_offset >> fs_info->sectorsize_bits;
>  	struct bio *repair_bio;
>  	struct btrfs_bio *repair_bbio;
> -	blk_status_t status;
>  
>  	btrfs_debug(fs_info,
>  		   "repair read error: read error at %llu", start);
> @@ -2679,13 +2678,14 @@ int btrfs_repair_one_sector(struct inode *inode,
>  		    "repair read error: submitting new read to mirror %d",
>  		    failrec->this_mirror);
>  
> -	status = submit_bio_hook(inode, repair_bio, failrec->this_mirror,
> -				 failrec->bio_flags);
> -	if (status) {
> -		free_io_failure(failure_tree, tree, failrec);
> -		bio_put(repair_bio);
> -	}
> -	return blk_status_to_errno(status);
> +	/*
> +	 * At this point we have a bio, so any errors from submit_bio_hook()
> +	 * will be handled by the endio on the repair_bio, so we can't return an
> +	 * error here.
> +	 */
> +	submit_bio_hook(inode, repair_bio, failrec->this_mirror,
> +			failrec->bio_flags);
> +	return BLK_STS_OK;
>  }
>  
>  static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
> -- 
> 2.26.3
> 
