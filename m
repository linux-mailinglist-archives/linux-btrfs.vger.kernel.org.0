Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3765806FB
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 23:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbiGYVxr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 17:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiGYVxq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 17:53:46 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F0AD84
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 14:53:44 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8846E5C01B3;
        Mon, 25 Jul 2022 17:53:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 25 Jul 2022 17:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1658786022; x=1658872422; bh=pw0gEa/fsI
        DwRYzcGozWR7nTpEw5RObcc2QdqIb0U3k=; b=SJlap3fSi6ov2NMANV0I6vVZhL
        96jm5+IARhfcn0Nio/ZaRS3wnyx4za3Fd0N06C2meTS2OjHnLkaFBSuNo9vTK7FG
        kLNvycLjZZrzQZeUf8b4gZ3dL28iCvm2svb5+peqZ+c0UJ0Ntpj3BbcdxikpuCCB
        KMtWFThGEQhFLua/20N1ccEmgXAeQYoVuvLbF/R3qwxQAM4eNcqBvK7C168Og+yb
        KVM1VaRBda28RyPhEOkGu7lRny4agkKeU2dTe/nJRh8ii7qiuFPrzVVd75BQEf9b
        cLFrc/8YET3iJ5Cs43TB7q2cBkdqRD17VtFgxxZSLPAy7BDKWoSrIbpWWEBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658786022; x=1658872422; bh=pw0gEa/fsIDwRYzcGozWR7nTpEw5
        RObcc2QdqIb0U3k=; b=cWBwQwiAkH1+9hs4jjt9oyof/ohOipJ4/f7m+iqN1VsU
        PHMC/dCRSCtPEW0lyzFl1FnOCAiVx4wGvliEo70Jqw+DWLAE+JCvm24efwcWfIAB
        iyf/O0xqNvuRCEAKk39NKjAWwPVylgretvmnfJV7Z1rw3vUJm266JAc8fGWMEOqn
        VtgHwHa+H7v9DnjZ9Iks83mDhyjNefWGYs4glOV1GyG3jOdsIglNNqo9y2gOKd9B
        nAa/Qd8EZzg1Y+Do1UGn4kgX1dVSUUMzkzZiDMPgMwRhprLnW8hzcrkQdbJM8+34
        LLTUgEKcstIzcgwm2JCyrg4GT4PIE7/aqYCIrbqTWw==
X-ME-Sender: <xms:5hDfYnqdj0pVbiHKqtjCJ82bYz4wtqsv2cwHF-4Utp5CVh3F8qc9UQ>
    <xme:5hDfYhrFDwcl2vq-CrAvn8FxWlZpAL0EtaqSb3A0FpsawAgtNHRQd5bdyPmEzDahc
    EuurIo26U17f0SgUYQ>
X-ME-Received: <xmr:5hDfYkOgJGTRmXyqTsTDQNs-HklsHQTJ1MIcYEotuuKrlUPJCGXFqxubYle_Gd0EhG4KPa-LcQCOnTiR6yZtTm8r2i7Qvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtledgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:5hDfYq7aO6g8t0LXp4ZommKhAUpkow5zWDyH-HTlFvLWGSE3WkfLmg>
    <xmx:5hDfYm40oCB5KoMQRQLGiBlVZ4gBz5nDMzxkmEHP2XJpvuP8tlMzVQ>
    <xmx:5hDfYijDnw2hAK90NFojmsVIxDxARHLgR7m38isIpuJdvXhOaQMA2w>
    <xmx:5hDfYsRNBqUrWhIJ9ZKTHBStu2BfKUXiC5H95e67Jwugcq_SXB0VTQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Jul 2022 17:53:42 -0400 (EDT)
Date:   Mon, 25 Jul 2022 14:55:00 -0700
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: reset RO counter on block group if we fail to
 relocate
Message-ID: <Yt8RNCQ8o7f2IQt7@zen>
References: <ca31fa4152849cee02f16c49f7ef818b89995a25.1658768686.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca31fa4152849cee02f16c49f7ef818b89995a25.1658768686.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 25, 2022 at 01:05:05PM -0400, Josef Bacik wrote:
> With the automatic block group reclaim code we will preemptively try to
> mark the block group RO before we start the relocation.  We do this to
> make sure we should actually try to relocate the block group.
> 
> However if we hit an error during the actual relocation we won't clean
> up our RO counter and the block group will remain RO.  This was observed
> internally with file systems reporting less space available from df when
> we had failed background relocations.
> 
> Fix this by doing the dec_ro in the error case.
> 
> Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/block-group.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c3aecfb0a71d..993aca2f1e18 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1640,9 +1640,11 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  				div64_u64(zone_unusable * 100, bg->length));
>  		trace_btrfs_reclaim_block_group(bg);
>  		ret = btrfs_relocate_chunk(fs_info, bg->start);
> -		if (ret)
> +		if (ret) {
> +			btrfs_dec_block_group_ro(bg);
>  			btrfs_err(fs_info, "error relocating chunk %llu",
>  				  bg->start);
> +		}
>  
>  next:
>  		btrfs_put_block_group(bg);
> -- 
> 2.26.3
> 
