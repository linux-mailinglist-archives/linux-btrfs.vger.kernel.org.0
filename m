Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CAF75FF17
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 20:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGXScM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 14:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGXScL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 14:32:11 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3CEA6
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 11:32:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 261B35C00ED;
        Mon, 24 Jul 2023 14:32:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 24 Jul 2023 14:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1690223529; x=1690309929; bh=x8
        shmLXbS2DLYeTzA2zYDlpfyZjM8Aea5F/q9NLk+5I=; b=Y2drX7JiUxT1ibUjgA
        JeqD1v2l0kUXY0jeEklNWF2wC5hkq9bK2FepFIpwM8HIJfHfYd8bQEgcRYYdeaxz
        Ppi52QxQLeY1047pTsdK7UjKMP4yvk6lN42bUCngXw7xkeSLPt9UzjD2BpKi81Hg
        SlOYUn2dlHizFsR2rjqIC9YbJ4eGH029xtY2qs0DT3sa0nZ8XGjHgXUjndDxE21c
        cKCzB/bruSnepdUPlmPCkkiOm5OFBK1HngL8g9eV5SMOa7OuIuNbxCQkHK0h4Ajk
        NfngJ5FkjGjrrAQrOFUcPmI44XT2ljIsG/NNYiId85oeiGX+zdl+pq5JmpttyXRR
        snWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690223529; x=1690309929; bh=x8shmLXbS2DLY
        eTzA2zYDlpfyZjM8Aea5F/q9NLk+5I=; b=Dpr1hZABfHsuQxbX6OfLAjmrf7q+O
        vGatfLdzOZajBo6UYrm3qMQJFJqVMToYAWeDgtrHHdEsKJLaiBYp3Z1R2g7TdEo7
        ts/oiC2hDo+awP7aWDreG+SZAJj6b9b4+QS74RNhHIsKOPS21UEAi5dWX31i4pDv
        uvhYAF/vMyifZNFUxDm7E0+84rNFZ+4S3j6Kube4MNdOhJMfvGJCf9kwiHPGy9xM
        SpBPGDWlv7SbCn1m37uKX+K0N3b9OMeTv6hKuiiePdK6278QRRgWn34KkGpb3NU7
        bH10e7UehMZgV16ruF3n6V5T2bMpgOQotkTX5wkFnklvQcMIQA8jV6d3w==
X-ME-Sender: <xms:qMO-ZHsVfJ9P3eiE246WMKIti4mj5Rf4oVC_C12_vy6ptP-shEbv6g>
    <xme:qMO-ZIfDeyKGABBrpC_2GOLwaGByWDjuFGqY34X1FMNt-ORTjA1rP9_bEHI-WiNGC
    v6Ua1GfJn9O71CLum8>
X-ME-Received: <xmr:qMO-ZKziMSqlg_TFyXzEoZEbOTeTO6SWc7xt6xNEGQh9RcH40dPd0us1hEtw1428fFXB2Aycxky_kXPIbdaRQZI3rTE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheekgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdeiiefgffevgeffvedthfeijeegvdfgteehudeghffffeeikeehffefveekjeenucff
    ohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:qMO-ZGN3VyzwL9bcOkHIEl3FgGYFETdI9G0EvQq3prXI_YUsHStuRg>
    <xmx:qMO-ZH-LCJyiEdk4seNUlJjyJWNtQSow3GRH2qms93HHAnggjI2cCQ>
    <xmx:qMO-ZGUb8lgob29khruT_bFNjU1zvKn0faz2MZFR71D8tpusbHvQSg>
    <xmx:qcO-ZKaoemzzf7EsbjK0bsbIJ3vwRpTngZ6PaqycQIdY3KNVtrhyZg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jul 2023 14:32:08 -0400 (EDT)
Date:   Mon, 24 Jul 2023 11:30:33 -0700
From:   Boris Burkov <boris@bur.io>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs NOCOW fix and cleanups
Message-ID: <20230724183033.GB587411@zen>
References: <20230724142243.5742-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724142243.5742-1-hch@lst.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 07:22:37AM -0700, Christoph Hellwig wrote:
> Hi all,
> 
> this series fixes a (found by code inspection) bug in the error handling
> in btrfs_run_delalloc_nocow, and then cleans up a bunch of things in
> btrfs_run_delalloc_nocow to allow me to actually undestand the logic
> there, and in case of the last patch signigicantly simplifies it.
> 
> The series is on top of the for-next branch as that includes previous
> work not in misc-next yet that the series relies on.

This doesn't apply on the latest for-next, but I reviewed it from your
git tree. It all LGTM there, thanks.

You can add:
Reviewed-by: Boris Burkov <boris@bur.io>

> 
> A git tree is also available here:
> 
>     git://git.infradead.org/users/hch/misc.git btrfs-nocow-cleanups
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-nocow-cleanups
> 
> Diffstat:
>  inode.c        |  143 +++++++++++++++++----------------------------------------
>  ordered-data.c |   24 ++++++++-
>  2 files changed, 67 insertions(+), 100 deletions(-)
