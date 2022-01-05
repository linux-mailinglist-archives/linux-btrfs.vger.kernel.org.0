Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D365485A3D
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 21:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244208AbiAEUss (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 15:48:48 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:36917 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244200AbiAEUss (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 15:48:48 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B56983201FCE;
        Wed,  5 Jan 2022 15:48:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 05 Jan 2022 15:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=+/iD6Qkterd60DJO8sOx8flGa+f
        7015Gk4I7A6Dd+IE=; b=AieE7ZlqDpxLli7I81UnV7nb/ajMXgdCuFzY3nrXUE6
        LUF6rV3uVN0Bv7fGQBNMwCJaula3GFf/YGlokhNfpDkFn9pX505NcDJQ0f1HTCv3
        HGjsGSQP8BZUllG5oYZoVxLjBeSsrDvgRA+SrHgIgQ8W4vxtyKeuy/tq+JnmSX92
        7QimZaq58jl/Xzoi4l9oL0LhZLoiiipYm7BrW0Zs03lUlbyeOkE10kb8hA7yCcQ6
        ZF5ZMt4M4tdtj1XHToWuW/ibT0OaBlqDRLxuo83/ltauxR3qzgNx8G8s9feBy6Xj
        grUIfgXzYEr8KKpDSAEuce1/PcwCtueSfhbrMNpVxZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+/iD6Q
        kterd60DJO8sOx8flGa+f7015Gk4I7A6Dd+IE=; b=gSkkWN4ufMJlZnk+/3Kl93
        /igJ70WkF0G7a+eo3HXmw3jwvUrya0kI1z+IOPLogs2lxGeijfSfX2QvvK5/BFMG
        n+u+AdJquK01n9G0kXWQOM3mKn0/9GebsNXT8u5CAaKVnNs6fM4GnkgxZzpe0InI
        gS/Mzs4TdSPbhINf/qnpKwe7JZLGA1uOdvOp212xGwgn2O4HHnwnX/thFP66kXom
        TY/osSaQlQY69zf+5yXiehcAOLQvBcSytt1kh88HTvt8pFiSoEG3w6OYTRnI2HVH
        oBFpiFDN/ToCYQ6/xVDFyVZ+1oYWC3ktkgSJ+cwsOEsdpcSxSg606bAkAdEwzNpQ
        ==
X-ME-Sender: <xms:JgTWYfxhZTc3yxgvRQHfQ0-39p_wIFZL46XqXc0zp1b_mSiULdTPdQ>
    <xme:JgTWYXQ8edCY0ueyp0PXktruUfbUaaJrouzzbHFemBS2lIr2RebjMOMmKH_EpAopI
    ABJ374_fxpIJWWIz3M>
X-ME-Received: <xmr:JgTWYZVNP_qGifHx4cmDcLB73EqcRkrTwPYvjKGlITltafxKH2GFGDx5rmJxY-vqvLLRtD418Qorc5_Y3PjKLuX_fdATug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtro
    dttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeehffdvudfgveefgfejiedvhfekiefghfeujeetje
    egffduffdtheevueeuvedtkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:JgTWYZhS52xfbC3Oo7MMdHy87QQI1ppQXuTX7zCqCpYspiHnQUPtEA>
    <xmx:JgTWYRB_FmN61LSCh30wZqpGT1EbZ9i0pmudXfrMWmijOJ2Rpiea5Q>
    <xmx:JgTWYSIWY-oAM9_RKjk0DFnaA8eygeBQMpPiAC30xK0OhGi76AiS6Q>
    <xmx:JwTWYe4YbSkGCbDsY2d5QRuERET55vsnCe9veJ9P4-cSvy4tdWbbRg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 15:48:38 -0500 (EST)
Date:   Wed, 5 Jan 2022 12:48:36 -0800
From:   Boris Burkov <boris@bur.io>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH][V2] btrfs-progs: allow autodetect_object_types() to
 handle link.
Message-ID: <YdYEJAvLhndfHTIT@zen>
References: <da4a4e0cf18df259e63c19872093bf12635da576.1641415488.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da4a4e0cf18df259e63c19872093bf12635da576.1641415488.git.kreijack@inwind.it>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 05, 2022 at 09:45:52PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> The function autodetect_object_types() tries to detect the type of
> btrfs object passed. If it is an "inode" type (e.g. file) this function
> returns the type as "inode". If it is a block device, it return it as
> "block device".
> However it doesn't handle the case where the object passed is a link
> to a block device (which could be a valid btrfs device). For example
> LVM/DM creates link to block devices. In this case it should return
> the type as "block device".
> 
> This patch replace the lstat() call with a stat().
> 
> Reported-by: Boris Burkov <boris@bur.io>
Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  cmds/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmds/property.c b/cmds/property.c
> index 59ef997c..b3ccc0ff 100644
> --- a/cmds/property.c
> +++ b/cmds/property.c
> @@ -373,7 +373,7 @@ static int autodetect_object_types(const char *object, int *types_out)
>  
>  	is_btrfs_object = check_btrfs_object(object);
>  
> -	ret = lstat(object, &st);
> +	ret = stat(object, &st);
>  	if (ret < 0) {
>  		ret = -errno;
>  		goto out;
> -- 
> 2.34.1
> 
