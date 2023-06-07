Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927CA72692A
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 20:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjFGStE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 14:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjFGStD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 14:49:03 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2CB1BEB
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 11:49:00 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 65BBF5C010C;
        Wed,  7 Jun 2023 14:48:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 07 Jun 2023 14:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686163739; x=1686250139; bh=sf
        BXYANrGyyJpoWrdM9i4gvfgYq3snCnTO/vkKB956U=; b=HbKZD1l8pLmlRDCQsl
        04TCAN1JvtgkPHaCErhiH1h0XpkjwzCZ8H+DPfHZlQU+zwEJVmb/TGuwjg01N1+s
        sPehYYsZRERHhCp4MO0o0tRgkQw+2GcigudkbACewlOFl1PsL/TuJG7LimKReyvr
        3rH39h5r86ACqxDx3gIKbvS5DqKyh3Hphv2tS+F3gvCcQM04Bb9Nc3HjiFzc7wV3
        SoAxUKjs0zeTElXLcQBOerDP1K39UhJ1EZegtyKowYrNoDxFyQWjTr4OzUtiSdHJ
        4+LecdWSobIeVrv2M/Bvz0piDAoP7xlBmWi6FNvcJQgOwfM0bXGq9f8E/ckAfIt+
        fwmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686163739; x=1686250139; bh=sfBXYANrGyyJp
        oWrdM9i4gvfgYq3snCnTO/vkKB956U=; b=AjYk7qpRAMvZXdP75lS8/nkBhduhH
        s7VxVv404uZeDMj5Ez8tBZQVZJEF/NUm7EvZOv7AAEZunhf+l1/hafDrVIRttgRd
        moi33M1dlg8A6smQn81M1gDfekuglbEZGIRqcivwFssYc1hDqflRjl9kTE0Q4WXa
        6utxQ3XctfoD9Fu7cZ4idKwKA132wktOf61+HqpZa/m/qbvjU/KpInD+o3K4V8nG
        lUtqh4TJ2x8EO59kZzR/MP6YIrje72I1BeLFr0r1CkT7qNcXogbgZAdYzD7vGOqp
        x7OfDB8DpM2l+8XfD8/Ubv1RsG/qwXSW7622hNRsdTgVIRwjwYZaI5fcQ==
X-ME-Sender: <xms:G9GAZG7zmgk5KFLq2aphOL3b2SiwfQeNLk5j3HM98b2lRjTjDKiGSg>
    <xme:G9GAZP6VDGOn3xxTKDeco_67W-upObHYnudkR9p-n-sZTIFN-pNwo_oTcmgPLY-kU
    HDA3_3vK_e7y5LO2gE>
X-ME-Received: <xmr:G9GAZFdppvxkSSOAMBMvwX6RO1E5JUeHgMbiNChj5dIqHt0j5SS__rpJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtgedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:G9GAZDJwlugmtEZRpQO3ZNc1YN-UyPe2k1QSRtCXbE5MMcHK9Z1ZaA>
    <xmx:G9GAZKJ1NjfxUbvTUkJcuHx4UIL6NMJin1vXxT_Sybu1D3Gk94_-zQ>
    <xmx:G9GAZEw-Ht7Oo__utyzN6Sx0sQrpPigLYG4V7MibByOP_6b1muOW-Q>
    <xmx:G9GAZMiPpMvIT9zBWaujnIWiKVq8RkUYjIt2bdvA-A7utiXPGPTWxQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jun 2023 14:48:58 -0400 (EDT)
Date:   Wed, 7 Jun 2023 11:48:37 -0700
From:   Boris Burkov <boris@bur.io>
To:     Naohiro Aota <naota@elisp.net>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 1/4] btrfs: delete unused BGs while reclaiming BGs
Message-ID: <20230607184837.GA3191631@zen>
References: <cover.1686028197.git.naohiro.aota@wdc.com>
 <06288ff9c090a5bfe76e0a2080eb1fbd640cdd62.1686028197.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06288ff9c090a5bfe76e0a2080eb1fbd640cdd62.1686028197.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 06, 2023 at 02:36:33PM +0900, Naohiro Aota wrote:
> The reclaiming process only starts after the FS volumes are allocated to a
> certain level (75% by default). Thus, the list of reclaiming target block
> groups can build up so huge at the time the reclaim process kicks in. On a
> test run, there were over 1000 BGs in the reclaim list.
> 
> As the reclaim involves rewriting the data, it takes really long time to
> reclaim the BGs. While the reclaim is running, btrfs_delete_unused_bgs()
> won't proceed because the reclaim side is holding
> fs_info->reclaim_bgs_lock. As a result, we will have a large number of unused
> BGs kept in the unused list. On my test run, I got 1057 unused BGs.
> 
> Since deleting a block group is relatively easy and fast work, we can call
> btrfs_delete_unused_bgs() while it reclaims BGs, to avoid building up
> unused BGs.
> 
> Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/block-group.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 618ba7670e66..c5547da0f6eb 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1824,10 +1824,24 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  
>  next:
>  		btrfs_put_block_group(bg);
> +
> +		mutex_unlock(&fs_info->reclaim_bgs_lock);
> +		/*
> +		 * Reclaiming all the BGs in the list can take really long.
> +		 * Prioritize cleanning up unused BGs.
> +		 */
> +		btrfs_delete_unused_bgs(fs_info);
> +		/*
> +		 * If we are interrupted by a balance, we can just bail out. The
> +		 * cleaner thread call me again if necessary.
> +		 */
> +		if (!mutex_trylock(&fs_info->reclaim_bgs_lock))
> +			goto end;

I agree that this fix makes sense and a lot of reclaim should not block
deleting unused bgs.

However, it feels quite hacky to me, because by the current design, we
are explicitly calling btrfs_delete_unused_bgs as a first class cleanup
action from the cleaner thread, before calling reclaim. I think a little
more cleanup to integrate the two together would reduce the "throw
things at the wall" feel here.

I would propose either:
1. Run them in parallel and make sure they release locks appropriately
   so that everyone makes good forward progress. I think it's a good
   model, but kind of a departure from the single cleaner thread so
   maybe risky/a pain to code.
2. Just get rid of the explicit delete unused from cleaner and
   integrate it as a first class component of this reclaim loop. This
   loop becomes *the* delete unused work except shutdown type cases.

FWIW, not a NAK, just my 2c.

Thanks,
Boris

>  		spin_lock(&fs_info->unused_bgs_lock);
>  	}
>  	spin_unlock(&fs_info->unused_bgs_lock);
>  	mutex_unlock(&fs_info->reclaim_bgs_lock);
> +end:
>  	btrfs_exclop_finish(fs_info);
>  	sb_end_write(fs_info->sb);
>  }
> -- 
> 2.40.1
> 
