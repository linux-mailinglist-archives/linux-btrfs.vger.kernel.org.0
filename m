Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF80549EF7
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 22:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344499AbiFMUYF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 16:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346255AbiFMUXv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 16:23:51 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE9A26C2
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 12:05:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id ADF12320092A;
        Mon, 13 Jun 2022 15:05:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 Jun 2022 15:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1655147113; x=1655233513; bh=1i5+gVMkKi
        QadfDr57ivVBB9620vp2cZ2+jY7nC9GvU=; b=ALXzo7Ifaa2ASTs90Y2o+ktmbt
        GIbO8CPPyrG+MRBVKQ+XA5aYHg3eZK/AMdyVWpGsnU+tW6rCmF3oOUnMzw70Nv5M
        GIvgWlLZVK//c/jGu5BOjY7M68nHpvUapz/PHsHs1g3VY41cDdtxI7nGtUHXGXGK
        nOLGPvHVivZ9eQmgOsS8/NUPW9XDRCKTyFhesfQSfloDn8vehehoA/QLDW0FMBXH
        Stgw1BbfkIJN7HswLdP+6wLsHOjcGsQAWfOjZsF+zrr2xjOyLisuKYHUJ315NvtG
        TSGphYJtNbsWlfTR9t4hA2930npgSGVXU8YuDl7qu39Fiz3AGxn9/x44icjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655147113; x=1655233513; bh=1i5+gVMkKiQadfDr57ivVBB9620v
        p2cZ2+jY7nC9GvU=; b=lzvUPc5JP92VjT/kjATm5h7zbAL6pbhjr+Zbe9ew8oJ7
        T5fyPauGtpxNb/N/4CO01qSM29PyJnwVWuEt854RpkBjxSy9AoqI5D5De//rP8b1
        Ypr5O3rvEcZoRSUkL4bk12fCJgWlMRn/gngw7tyEgLiT9OfVauwWYbhQA1Fg8n0C
        TROzaMZSip1dgR+sSPH8wZOeKSI3q7uZjqCOQrp/nYR/G+C/naB6BslE5+ESxh1k
        8BaR+GBtpZiVN3gQoWFM6h4Gi4o7LqwDNZ1wzhqKvo1yxqF2bv/a3Jva/44IU0AY
        RWlStUVlCRZNm0ZC3mICCllr0oGwci4MCOpnFrNHAQ==
X-ME-Sender: <xms:aIqnYldCvxSOqhB_IJfPkOevSbBKthBnsDabbiPJTp2BUgdqwhYnlQ>
    <xme:aIqnYjOFM43HUioP48Co-nouASVhQstJ9iM5ggtbvKyQCgN2IQsEIE8ohP3IsM0Tg
    HvbGWdwvge0VSaWPN0>
X-ME-Received: <xmr:aIqnYujg_2SLva-uvah3kfK6M8NhSmLFWjtWGVRuKsYXplAD_FoLD15gd0ucp1OleUwDPCl--DTG6z_ZB3OxUFZ1MhhxHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddujedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:aYqnYu-exq_ucg9uBc0CNvrJt1NiXjptIJLRf2cl41arazXr6edA_w>
    <xmx:aYqnYhsq9EwRjD-pPGSHgIb1S14YF8QJAbeb1Mg-UKpyrub6dkhmGg>
    <xmx:aYqnYtHLlN1WDzh-SCBJVygrYS3Uiycq8U6Fa22h_B-OR3fsMpNEAQ>
    <xmx:aYqnYv0ygbM6qNj2GElpxdlPtwBwKE4i6sxgBaCCminPeqYRjSPoug>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jun 2022 15:05:12 -0400 (EDT)
Date:   Mon, 13 Jun 2022 12:05:10 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: warn about dev extents that are inside the
 reserved range
Message-ID: <YqeKZuET4MDe0D5w@zen>
References: <cover.1655103954.git.wqu@suse.com>
 <c4b02ac7bf6e4171d8cfb13dcd11b3bad8d2e4df.1655103954.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4b02ac7bf6e4171d8cfb13dcd11b3bad8d2e4df.1655103954.git.wqu@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 13, 2022 at 03:06:35PM +0800, Qu Wenruo wrote:
> Btrfs has reserved the first 1MiB for the primary super block (at 64KiB
> offset) and legacy programs like older bootloaders.
> 
> This behavior is only introduced since v4.1 btrfs-progs release,
> although kernel can ensure we never touch the reserved range of super
> blocks, it's better to inform the end users, and a balance will resolve
> the problem.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/volumes.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 051d124679d1..b39f4030d2ba 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7989,6 +7989,16 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
>  		goto out;
>  	}
>  
> +	/*
> +	 * Very old mkfs.btrfs (before v4.1) will not respect the reserved
> +	 * space. Although kernel can handle it without problem, better to
> +	 * warn the users.
> +	 */
> +	if (physical_offset < BTRFS_DEFAULT_RESERVED)
> +		btrfs_warn(fs_info,
> +"devid %llu physical %llu len %llu is inside the reserved space, balance is needed to solve this problem.",

If I saw this warning, I wouldn't know what balance to run, and it's
not obvious what to search for online either (if it's even documented).
I think a more explicit instruction like "btrfs balance start XXXX"
would be helpful.

If it's something we're ok with in general, then maybe a URL for a wiki
page that explains the issue and the workaround would be the most
useful.

> +			   devid, physical_offset, physical_len);
> +
>  	for (i = 0; i < map->num_stripes; i++) {
>  		if (map->stripes[i].dev->devid == devid &&
>  		    map->stripes[i].physical == physical_offset) {
> -- 
> 2.36.1
> 
