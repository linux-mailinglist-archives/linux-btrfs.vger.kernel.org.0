Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1D175BA9A
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjGTW3s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGTW3s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:29:48 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6658C10A
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:29:47 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D647E5C01BC;
        Thu, 20 Jul 2023 18:29:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 20 Jul 2023 18:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1689892186; x=1689978586; bh=gH
        Lio+QYNmDJk1HoTg0cL5CCfM9uXjMypFkHK7vxMMs=; b=Y4EP4BDUlwr9dv9nZR
        o01CPOXIsdsXJ+JldYmylB1yRWOEDsdPtpkiS3qFqXbgqGT5TnwAS260OCK//h1U
        sWT87Jb5iawS/Fvc+9y6oOgcAdcM6bGxN5xrpcLLedeCmgRL5Hw+K72qimvR1ckS
        ZvxDkWxIxz/LRmpLmarDr8MQLPf5ulc6W6cUCmH0ih4NkNZZ9VIfJ6PAFvaCrrxl
        vgIAfNv0otRZgT0hkWjzEMzYdLfJt87172f56Isnsyq55qMUc4Jtevo6vnlQ+AVP
        ebnKs45d4nwpz2dqGuu2YAR7zqqh0n0B1Nkv7+aH1M+hv+U/UzPD54iRyX16LiW3
        HKkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689892186; x=1689978586; bh=gHLio+QYNmDJk
        1HoTg0cL5CCfM9uXjMypFkHK7vxMMs=; b=HahcUI6K38tvOAO4CcEbjAkqvCuO6
        eQPnticxvYgZG+Dm2cNtAfxDQK5c0zDqbQXOCphhR7fecGyhkDbkadh0KxoXb3Ve
        AO6tZxNlaWltwRwjt8ZSAiECUgd3aPGXb+8uwVhvWZvkih5xob7bvsySLOArwlh9
        GYcto69J0D1YXDaEQu/MhT68rHpimiI7si3UFkCAoNdAkzub5DbLvXSlESQDAemC
        ITShQX0lHUS9u4Wpr4a3mudScacy/wxt845wt9e1PKKSu5EogsZ0F0ME771Ko6Gm
        8USZRdhJRM6d1H7FtuBap29nZnRCQOM2so+GrhMKKI/vEkO5FO9QoMRYQ==
X-ME-Sender: <xms:WrW5ZNkH-XwZU91CVCQ95WYnMWlstFl-i-8SdnYHK3akNvvumbpH4Q>
    <xme:WrW5ZI1pF6Wyu53v6KjgWnTaq8Br0Y-A6uDZk3BA02TbucLyXAkTJPgKNPSxWm1TH
    W2i8aC0E3Df5OXrvIA>
X-ME-Received: <xmr:WrW5ZDr3KN9qhZTcS0sv__WL2irWUVod0Ffq7CGnXZu88BQitPwLrwAUIUDyY1nhqG3VB8ybvrFjQqf5niKhP5tq8R8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:WrW5ZNnL6kzaYbQQWxHz-SotEZ_-dtbdB8gAx6ygdccXU9a9dz4ShQ>
    <xmx:WrW5ZL2FbQmnC1InfaIEBI07yzDHZx-GMs8yT1yuWsVVDOd6zJH4uw>
    <xmx:WrW5ZMtb7BoMRuQMPDcSAcZmuNJvz9OAPAZtzbDwJdotywlcf1wx3g>
    <xmx:WrW5ZE8ZlBcHFl2A4atPsjqI5iydvErZy0vz11YawlCU1kUzzXCZzw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:29:46 -0400 (EDT)
Date:   Thu, 20 Jul 2023 15:28:17 -0700
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/3] btrfs: cycle through the RAID profiles as a last
 resort
Message-ID: <20230720222817.GB545904@zen>
References: <cover.1689883754.git.josef@toxicpanda.com>
 <4beedde9b4f6adf4a7054707617f8784e5ee8b35.1689883754.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4beedde9b4f6adf4a7054707617f8784e5ee8b35.1689883754.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 20, 2023 at 04:12:16PM -0400, Josef Bacik wrote:
> Instead of looping through the RAID indices before advancing the FFE
> loop lets move this until after we've exhausted the entire FFE loop in
> order to give us the highest chance of success in satisfying the
> allocation based on its flags.

Doesn't this get screwed by the find_free_extent_update_loop setting
index to 0?

i.e., let's say we fail on the first pass with the correct raid flag.
then we go into find_free_extent_update_loop and intelligently don't do
the pointless raid loops. But then we set index to 0 and start doing an
even worse meta loop of doing every step (including allocating chunks)
with every raid index, most of which are doomed to fail by definition.

Not setting it to 0, OTOH, breaks the logic for setting "full_search",
but I do think that could be fixed one way or another.

> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent-tree.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 8db2673948c9..ca4277ec1b19 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3953,10 +3953,6 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
>  		return 0;
>  	}
>  
> -	ffe_ctl->index++;
> -	if (ffe_ctl->index < BTRFS_NR_RAID_TYPES)
> -		return 1;
> -
>  	/*
>  	 * See the comment for btrfs_loop_type for an explanation of the phases.
>  	 */
> @@ -4026,6 +4022,11 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
>  		}
>  		return 1;
>  	}
> +
> +	ffe_ctl->index++;
> +	if (ffe_ctl->index < BTRFS_NR_RAID_TYPES)
> +		return 1;
> +
>  	return -ENOSPC;
>  }
>  
> -- 
> 2.41.0
> 
