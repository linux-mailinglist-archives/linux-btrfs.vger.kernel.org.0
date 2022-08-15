Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB12B594E1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 03:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241398AbiHPBoB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Aug 2022 21:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbiHPBnb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Aug 2022 21:43:31 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F745FF63;
        Mon, 15 Aug 2022 14:35:04 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 2933C320090F;
        Mon, 15 Aug 2022 17:35:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 Aug 2022 17:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660599302; x=1660685702; bh=q1GHOVR2HG
        8hGzbylQv89Zpmm6U7IK8HwWlEMQHeE0Q=; b=p3DcQwx3UhVFNJ4Ne5ggFH8HYU
        ATT7E9nfCS8FTf9zCUoIhljDt29iiTJWrtOK/Ab/CQvN7XGl7piu6A2EeQ9S8l7s
        colERk4NTdmTr9hj9AELhEw8ZBYpt58zkcKkafj5nH/SFcndpasyMgICCdu/4/JS
        KUNXKHMAUmP3wKXX0FHxUz7wPNMKCw591YgYwOXQT5TS3oJpn2Lze0pkBn401VLK
        x7ul9uVCoYdKajgrlyHmaijX1IDUCEHhA7dotI0NV3BT2uxlVxmx08mle76kmGON
        JMgl2tzeKi0LR9MLXE0v/VwrPa9WBFlTXPGsHtRiLsvNAE93BPeCmZjG94ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660599302; x=1660685702; bh=q1GHOVR2HG8hGzbylQv89Zpmm6U7
        IK8HwWlEMQHeE0Q=; b=Vxg/pwxQbhtAkJ0Q2vd4ulSLVjnVhVTflw2nXiy58SeF
        acjKBnkJ5NTuQoSVt7cOzyknL7BdAIyo2R3Tz9dmJSUUDBNVPur2Zz5UTDrqMoxs
        xfG5x5ZbjdE3a3CrLlo8o+u3kUbmQPIC/U4RIvpvgVI/UahZMEDJgoYu1oWwDtd+
        wpKH6OMydaDaSOd2CrvvU125bE8YgfCZGJWkxoM5oDdKotZiF0GC9dXDQF4gx3fK
        3HeHTmmBF/cTvpbg6WxxPObLA3Su+iq+sN8J6udrbMp+ZfHHbScW/uGgOLuzBRe6
        yXlCaKHZ0Wj0GCw6I2f6RyKMV33i7tZmsFgLFosMJg==
X-ME-Sender: <xms:Brz6YpDtXH1F8rzGvUVQIZVNV2vktbAnDBSHYQ-Cw9IuZH7H8f1svg>
    <xme:Brz6YniitgapBWPd7WpR2qmqIrZ7Veo3vXcW4kQv4BREew4T4MlKGuvjKa_X5Oc_h
    imFrTlLMbZilR8FaWE>
X-ME-Received: <xmr:Brz6YklVu7-0Ia1kTzxS2V2ncdVINpS8qyFKR-xtY1hw7GMwhAVfRZEt-kEVcHlt05qMKgWVvftJtu1VmHIxxSh6dQgV0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehfedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:Brz6YjxSkiM2fJQeWQcvFurVIBMAfSK17pzY6KKUASqtqrZiPylTsA>
    <xmx:Brz6YuSvwq6P4R72--bl5Z3EA90W7kbjOsu8Y6F1i2l6RXgQ7aez4w>
    <xmx:Brz6YmZYArL9TJxZI4eON9okZLZ5xqgUa1TWQPEC1zTNsQhA5WSyVQ>
    <xmx:Brz6YkMSIWAARV3P_73MYpqn3Io3sVc0ezOaelra0qlsvNEPxAWtdA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 17:35:02 -0400 (EDT)
Date:   Mon, 15 Aug 2022 14:36:25 -0700
From:   Boris Burkov <boris@bur.io>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] fs/btrfs: Use atomic_try_cmpxchg in free_extent_buffer
Message-ID: <Yvq8WaTZzWWusB25@zen>
References: <20220809163633.8255-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809163633.8255-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 09, 2022 at 06:36:33PM +0200, Uros Bizjak wrote:
> Use `atomic_try_cmpxchg(ptr, &old, new)` instead of
> `atomic_cmpxchg(ptr, old, new) == old` in free_extent_buffer. This
> has two benefits:
> 
> - The x86 cmpxchg instruction returns success in the ZF flag, so this
>   change saves a compare after cmpxchg, as well as a related move
>   instruction in the front of cmpxchg.
> 
> - atomic_try_cmpxchg implicitly assigns the *ptr value to &old when
>   cmpxchg fails, enabling further code simplifications.
> 
> This patch has no functional change.
> 
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/extent_io.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index bfae67c593c5..15ff196cbd6d 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -6328,18 +6328,16 @@ static int release_extent_buffer(struct extent_buffer *eb)
>  void free_extent_buffer(struct extent_buffer *eb)
>  {
>  	int refs;
> -	int old;
>  	if (!eb)
>  		return;
>  
> +	refs = atomic_read(&eb->refs);
>  	while (1) {
> -		refs = atomic_read(&eb->refs);
>  		if ((!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) && refs <= 3)
>  		    || (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) &&
>  			refs == 1))
>  			break;
> -		old = atomic_cmpxchg(&eb->refs, refs, refs - 1);
> -		if (old == refs)
> +		if (atomic_try_cmpxchg(&eb->refs, &refs, refs - 1))
>  			return;
>  	}
>  
> -- 
> 2.37.1
> 
