Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53666B11F8
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Mar 2023 20:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCHT3o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Mar 2023 14:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHT3m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Mar 2023 14:29:42 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5A5BCB9C
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Mar 2023 11:29:41 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 15E8F5C0174;
        Wed,  8 Mar 2023 14:29:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 08 Mar 2023 14:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678303781; x=1678390181; bh=kL
        UYHvJ1lBSXtL762TdjsqRdmmCErxWBM+iq11Y+eDM=; b=DqtTcc9rww50+0wSw9
        Vub4pu8w3xTnCrCwT781vu7R+Ab16XTX+z2HzyuKk7qOOxzv9gMs8GthuALZr56Q
        fhOlLfnjS8vpkKpZVSk7lL+k/ZQzYHYZGMJN19Rk86e0+/9DFfktfN6zPNigxTW7
        7u6mmyyrRzdBdYOWzUTu5ahKUGusxRCbiy7+A4WAj39EbsDhqUdiPrkgiXShU1d/
        s1D+z8Tobav8FoiXVxtJJ3oxCK/U/Kxn/WgqqkFKtOCg3v+7yCQ4Dmn87nQTCZcz
        WnqhyNvTNYVMUtANx7rVlTMg6YXI/Pn9b78VnvUZ3RpTk44Sm4LHp8xybhw50dpW
        J0tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678303781; x=1678390181; bh=kLUYHvJ1lBSXt
        L762TdjsqRdmmCErxWBM+iq11Y+eDM=; b=MUKnFk10PcQwS3o+H2THuKfIODR1f
        Y+u8MMGSMjPUN9WppIGqphUvkyeA8haOEuXWukvP6pXFIueQPsJfRaX84EASSUIw
        /KrwCSXPO9W5kwCiAI7O9i1jsZCfK4wP5XRK9TEALfkAUVdAQXv16H74IbRdvfG0
        tVALLegAn58aXJ8IUEkpJtBNnxm3ibX5W/zx/K2fMv+A1u04toQmDxWar2ES7K0+
        Cep+7QuldkOudjdMuza8e3TZU2jKYY2uDXNl8Mw9GrROelXqOM3ihU2xwonAcLMG
        oXYsozsyxJCNjSCvYKWJnBP+xVcJ+vAOtTX15x2yiDnWbzBL3johjAaVg==
X-ME-Sender: <xms:JOIIZFeDQswa1E--taeArP-iH-mJJNVY_Ez_jX0AFEcm1lkMLlC_oQ>
    <xme:JOIIZDMyfIiswcwwgWmTtGnWexDLNaYzs4PdS-AgtCi6CuVL9Hn2udZlkDUrgGLcj
    hvwrydIMLPHDde8E04>
X-ME-Received: <xmr:JOIIZOiJXyq2PnsXdqwsIerJuud5G9GUO1UgfqlBZxYXEnVUr1b2xFZy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddufedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:JOIIZO-TV3duvkmv967mbV0FoEKt95E75YU35_ydccp5Y08cgck4qQ>
    <xmx:JOIIZBt7yl3vLbCCORtnEwhL1u4e0kEXtFjoM5lfKbT2OR8Xa0juDw>
    <xmx:JOIIZNFIm0FiQ25YTJ_9f9ZDmkdrOoOP7NjOurg5yn1H9WwNsEBgyQ>
    <xmx:JeIIZCWODbW01aFojzWEx2NHIh2owN0ygpeKgVHL4WCi6iG1xV8LuQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Mar 2023 14:29:40 -0500 (EST)
Date:   Wed, 8 Mar 2023 11:29:39 -0800
From:   Boris Burkov <boris@bur.io>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 03/21] btrfs: Add start < end check in
 btrfs_debug_check_extent_io_range()
Message-ID: <20230308192939.GD30177@zen>
References: <cover.1677793433.git.rgoldwyn@suse.com>
 <37fd374e88730196100116cc237f637cd6a8962a.1677793433.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37fd374e88730196100116cc237f637cd6a8962a.1677793433.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 02, 2023 at 04:24:48PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> For issues such as zero size writes, we can get start > end. Check them
> in btrfs_debug_check_extent_io_range() so this may be caught early.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/extent-io-tree.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index 482721dd1eba..d467c614c84e 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -65,7 +65,8 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
>  		return;
>  
>  	isize = i_size_read(&inode->vfs_inode);
> -	if (end >= PAGE_SIZE && (end % 2) == 0 && end != isize - 1) {
> +	if ((start > end) ||
> +	    (end >= PAGE_SIZE && (end % 2) == 0 && end != isize - 1)) {
>  		btrfs_debug_rl(inode->root->fs_info,
>  		    "%s: ino %llu isize %llu odd range [%llu,%llu]",
>  			caller, btrfs_ino(inode), isize, start, end);
> -- 
> 2.39.2
> 
