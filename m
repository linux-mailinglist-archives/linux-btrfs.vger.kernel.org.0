Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82044B3117
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 23:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiBKW4R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 17:56:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiBKW4Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 17:56:16 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ADBC63
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 14:56:14 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B9F45C012B;
        Fri, 11 Feb 2022 17:56:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 11 Feb 2022 17:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=5q8aspfP/8BDmZBcwoM/MV+0QorO4sAfH3hHx1
        pwmXM=; b=IAbU5EBNrZ8lIJ/+QLYRBLNiyW2GscLYbHe2bdS9igs3/2zNDEN8Nl
        GQ7hM5Vp2a/6kXVVf3fQpmXTvFrpRK3aD3QN46lHj4WjpEX8g6b7IFu50d4tKhGK
        dXgdy4+WDGdx5PuHJ9TBMIq1cHEegUioHftHX1RrZMs6s+FJC8m2zxwDbpwRmUqe
        KAAWWDPZV2rIterWIh8rHpBn9h41AD7FmPYJmmSXSVcCYmT9s3g4G9MGfKDFNXtG
        liCVjytNBvRwrToeq+MWMkqSLOH4svWc8e/emowSEDzeG8KBY5xDAzOABztQ8Ewe
        9fsr+WQ93eCtuoeu2L/wITnccj2D6FDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5q8aspfP/8BDmZBcw
        oM/MV+0QorO4sAfH3hHx1pwmXM=; b=nqtIAYmSXmPIMYVSMMBqvNXRKMg+NGbqT
        hbk/ZrAMg+yRHwa06kaTxb+GuW5TSsry2/9zvozifUWhpGKrNKJ1MUGJYQTqR5FL
        uIp0SPE+mBqK9wp9C07DBW8XRfoDNQm1RQn05wrfTfInIwo+WUbbkgTifW1BZN2u
        JZRbCKIaauFRFTWE/3HTaSOaN0Lo35tKLxZ3MtRbmrwnKAqSNgpix90RZcmqXbMI
        UdgauEXc9/Yf4PwZ0gUNb7orJgJo6WEYSzCx93oSS+dNBFtHWFZaV0bEuc6ptfI6
        Jq2Rxyn3vAuRcNCe1KxpQNTL2q5g7q8pPYD1YlFeZ+4z8kEIvdSkQ==
X-ME-Sender: <xms:jukGYvE3PFI5iGWidUtimRQ83LrsQ8hW-TvaPoIpL4vGyOihhpbhSw>
    <xme:jukGYsVzCPZXdWaw6632GdlHEuKHLPbUBHlJomEn06QQfNeALws9qBmMOrIzw1kU-
    uZGv23W0dabw1Sh9L0>
X-ME-Received: <xmr:jukGYhKhmOAdTwGS4_vSCUEtnF8HQRDp5R7O7NuXb_BketgdUUWa8hwSVG0p0i9KK6KG5wgfDe2jFF5Q2RuPygoFjxNHeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieeggddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehud
    evleekieetleevieeuhfduhedtiefgheekfeefgeelvdeuveeggfduueevfeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:jukGYtEsLh8NitZ0-gdTYBTOGvTz0vzYeGd_IPzRYwyGtkEShDE83Q>
    <xmx:jukGYlWf3I3dFZTfXgD3CLikhPnjUcMa50jCv26XNwqknkuJ8sPq1A>
    <xmx:jukGYoPRWLeADVmtNUHtVDBUDOYrC-1rnGI1kbIgRshA0JjKnzUbxg>
    <xmx:jukGYkehVRcIUr3VP2cKfaUPIBSFEMeiGF-eby-Xet5qyKzrRhB2nA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 17:56:13 -0500 (EST)
Date:   Fri, 11 Feb 2022 14:56:12 -0800
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 7/8] btrfs: do not try to repair bio that has no mirror
 set
Message-ID: <YgbpjLm1MBTD7lah@zen>
References: <cover.1644532798.git.josef@toxicpanda.com>
 <531eb09d460d686e75e96f0ebafde78c670d84fe.1644532798.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531eb09d460d686e75e96f0ebafde78c670d84fe.1644532798.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 10, 2022 at 05:44:25PM -0500, Josef Bacik wrote:
> If we fail to submit a bio for whatever reason, we may not have setup a
> mirror_num for that bio.  This means we shouldn't try to do the repair
> workflow, if we do we'll hit an BUG_ON(!failrec->this_mirror) in
> clean_io_failure.  Instead simply skip the repair workflow if we have no
> mirror set, and add an assert to btrfs_check_repairable() to make it
> easier to catch what is happening in the future.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/extent_io.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index bda7fa8cf540..29ffb2814e5c 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2610,6 +2610,7 @@ static bool btrfs_check_repairable(struct inode *inode,
>  	 * a good copy of the failed sector and if we succeed, we have setup
>  	 * everything for repair_io_failure to do the rest for us.
>  	 */
> +	ASSERT(failed_mirror);
>  	failrec->failed_mirror = failed_mirror;
>  	failrec->this_mirror++;
>  	if (failrec->this_mirror == failed_mirror)
> @@ -3067,6 +3068,14 @@ static void end_bio_extent_readpage(struct bio *bio)
>  			goto readpage_ok;
>  
>  		if (is_data_inode(inode)) {
> +			/*
> +			 * If we failed to submit the IO at all we'll have a
> +			 * mirror_num == 0, in which case we need to just mark
> +			 * the page with an error and unlock it and carry on.
> +			 */
> +			if (mirror == 0)
> +				goto readpage_ok;
> +
>  			/*
>  			 * btrfs_submit_read_repair() will handle all the good
>  			 * and bad sectors, we just continue to the next bvec.
> -- 
> 2.26.3
> 
