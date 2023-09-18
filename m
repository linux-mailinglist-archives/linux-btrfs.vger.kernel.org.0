Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05A87A5383
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 22:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjIRUOG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 16:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRUOF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 16:14:05 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4D28F
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 13:13:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8EF1D3200920;
        Mon, 18 Sep 2023 16:13:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Sep 2023 16:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1695068036; x=1695154436; bh=z8
        LEFwuNjm/y52/7g+KgOrA5jlmplYSq0HWofYt+TOA=; b=qJED2a4ZKec0TN5irT
        SMSaWN0ngN41aBLYfwhKw9VM1xqF0+xdYqo9/MEhzelxj3Za6hhlc86gKWHOMDER
        bILUSMDeslfNDZgivb3DvnEv91Zfs6zrw+HMhfhOGpY4aGohsqR/tRAl3Ucktqkl
        I4BhdHT5diBqz/qRSSBWJkCVu+pmqbKQmEBqlHNFXYLtJdamL2s3zvgD4sTMg3H3
        Pv8RjXGviwJ9lQIuFyJO1qUaqH25qZYp4xGPfvEBANbCJrd0UVaL9Qt2K7ZHwmms
        iMLkRa55W5gXiyCH3zmYnNwd05lDDEdbcHAgvskQCex4E9tNC7h7WPyoap9HNDdP
        TDvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695068036; x=1695154436; bh=z8LEFwuNjm/y5
        2/7g+KgOrA5jlmplYSq0HWofYt+TOA=; b=bMqoR62NE1blpIRx7ypTpfqhxhIml
        2BG4RhV+xJ4kf0X0UcDS+CsF+9JLuo2xF8aWMqcO4ln3ZV3QCI2lo5UNa1yvNRDi
        LisnSkx7YvXCo4GEYFRqktq4snHOug6PmKFct8cC5e2RhimpktBIjB9E9FLdXQys
        cLcin7YPh424sfG1nVVkUv7z/2vIyPlTYpiPQpmaPoOP2T8202oq10lJjU0yQOIu
        l2XlEiVUonr1n8YJFWzNIADfZYas00TmLDiNDQHfLQdwHCF4I1AvucU/IsbZyOGw
        lUA+r9a3UOwaFKyk0+n43+TlYhgMu2WQ8vqmbcRm+3a0aTWvoNKWdjRqg==
X-ME-Sender: <xms:g68IZWw2-8ffXj7td-IqOy8HiEb3e0ufKFhZYu7SbsBrfSVC-KlBMw>
    <xme:g68IZSRQYfQkTZEpIYFl5swvAOER_eX3rDgCL0G99DAc5DyuzEwkmwUkstmW6Rcrw
    8somK7rbhEBb418ysQ>
X-ME-Received: <xmr:g68IZYXP_4u6NNkp2Ht7kEXCPBivi6vmD2kNkZ9_njFLGSHBU5wfTAd24A_j-YAYgVfyKYYP8IQoT6o6t3fO4fP_uJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejkedgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:g68IZchF3FkamcFdlAWBL8oS4FmYv0MSXClGeE5qS4AGtuhXCG98Cg>
    <xmx:g68IZYAqHyrmVQTqdYxf-4GTY0lIJ01T_788H1WqnWOoVFZ8nTCQMA>
    <xmx:g68IZdK0Wp5ONxHWnkYR1u6C-0ZUDvSjuUv7a0JmQP8ST3B0tDDP1A>
    <xmx:hK8IZR5C-83buo1qKyhcTitZkbkP5XBy33XZ67rhO7x0hy9Y5vGViw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Sep 2023 16:13:55 -0400 (EDT)
Date:   Mon, 18 Sep 2023 13:14:41 -0700
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: adjust overcommit logic when very close to full
Message-ID: <20230918201441.GA299788@zen>
References: <b97e47ce0ce1d41d221878de7d6090b90aa7a597.1695065233.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b97e47ce0ce1d41d221878de7d6090b90aa7a597.1695065233.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 18, 2023 at 03:27:47PM -0400, Josef Bacik wrote:
> A user reported some unpleasant behavior with very small file systems.
> The reproducer is this
> 
> mkfs.btrfs -f -m single -b 8g /dev/vdb
> mount /dev/vdb /mnt/test
> dd if=/dev/zero of=/mnt/test/testfile bs=512M count=20
> 
> This will result in usage that looks like this
> 
> Overall:
>     Device size:                   8.00GiB
>     Device allocated:              8.00GiB
>     Device unallocated:            1.00MiB
>     Device missing:                  0.00B
>     Device slack:                  2.00GiB
>     Used:                          5.47GiB
>     Free (estimated):              2.52GiB      (min: 2.52GiB)
>     Free (statfs, df):               0.00B
>     Data ratio:                       1.00
>     Metadata ratio:                   1.00
>     Global reserve:                5.50MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
> Data,single: Size:7.99GiB, Used:5.46GiB (68.41%)
>    /dev/vdb        7.99GiB
> 
> Metadata,single: Size:8.00MiB, Used:5.77MiB (72.07%)
>    /dev/vdb        8.00MiB
> 
> System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
>    /dev/vdb        4.00MiB
> 
> Unallocated:
>    /dev/vdb        1.00MiB
> 
> As you can see we've gotten ourselves quite full with metadata, with all
> of the disk being allocated for data.
> 
> On smaller file systems there's not a lot of time before we get full, so
> our overcommit behavior bites us here.  Generally speaking data
> reservations result in chunk allocations as we assume reservation ==
> actual use for data.  This means at any point we could end up with a
> chunk allocation for data, and if we're very close to full we could do
> this before we have a chance to figure out that we need another metadata
> chunk.
> 
> Address this by adjusting the overcommit logic.  Simply put we need to
> take away 1 chunk from the available chunk space in case of a data
> reservation.  This will allow us to stop overcommitting before we
> potentially lose this space to a data allocation.  With this fix in
> place we properly allocate a metadata chunk before we're completely
> full, allowing for enough slack space in metadata.

LGTM, this should help and I've been kicking around the same idea in my
head for a while.

I do think this is kind of a band-aid, though. It isn't hard to imagine
that you allocate data chunks up to the 1G, then allocate a metadata
chunk, then fragment/under-utilize the data to the point that you
actually fill up the metadata and get right back to this same point.

Long term, I think we still need more/smarter reclaim, but this should
be a good steam valve for the simple cases where we deterministically
gobble up all the unallocated space for data.

> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/space-info.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index d7e8cd4f140c..7aa53058d893 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -365,6 +365,23 @@ static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
>  	factor = btrfs_bg_type_to_factor(profile);
>  	avail = div_u64(avail, factor);
>  
> +	/*
> +	 * Since data allocations immediately use block groups as part of the
> +	 * reservation, because we assume that data reservations will == actual
> +	 * usage, we could potentially overcommit and then immediately have that
> +	 * available space used by a data allocation, which could put us in a
> +	 * bind when we get close to filling the file system.
> +	 *
> +	 * To handle this simply remove 1G (which is our current maximum chunk
> +	 * allocation size) from the available space.  If we are relatively
> +	 * empty this won't affect our ability to overcommit much, and if we're
> +	 * very close to full it'll keep us from getting into a position where
> +	 * we've given ourselves very little metadata wiggle room.
> +	 */
> +	if (avail < SZ_1G)
> +		return 0;
> +	avail -= SZ_1G;
> +
>  	/*
>  	 * If we aren't flushing all things, let us overcommit up to
>  	 * 1/2th of the space. If we can flush, don't let us overcommit
> -- 
> 2.41.0
> 
