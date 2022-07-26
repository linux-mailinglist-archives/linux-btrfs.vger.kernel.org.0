Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2521581C5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 01:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbiGZXUW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 19:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiGZXUV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 19:20:21 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F2964C8
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 16:20:20 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B7C535C01BB;
        Tue, 26 Jul 2022 19:20:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 26 Jul 2022 19:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1658877619; x=1658964019; bh=HOp+hLHRWD
        bgW7aU9+dTaVqs8eDLH0PkcrePCGUdv14=; b=ea4hLekqf2T9sfqHBN6XkG53Oi
        Rczex8or5XSWx83UCjXwJKlBqI2eXC3CxZWpkyTDJU4pXwQRynR0j59HIfPeBmL9
        PX+PT307sLVo7NBmUgsSC9PS+M2iIPTC2YJ9DpYMtPLm18KvtHmy8uHnKqPd7650
        ziATJa/WorMQQGw/WamjQJF3LkyCT4G8fgVWM9vVEmzQu/15Gq8joetcIxYF9xhL
        Iavpcjv3EskOslxcYCvcRCKemhQEMKUs6Qn7OAIH5xI8jF+aRSyTJ3GsENqh4Bma
        vSkNCFQbfbobd7RDXF6domyiGG9zlgBgNInwoDgzkAidjqiBBjOGgqOAbxxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658877619; x=1658964019; bh=HOp+hLHRWDbgW7aU9+dTaVqs8eDL
        H0PkcrePCGUdv14=; b=BIlAFZjrJvuRXGcTh6q6jOCp/boqsmia38iUU9QY4CPI
        9Uv+VrjRd6EVtLK2hxspd0C21E8Mv9tUvt2AHsscdaa5LglTGt8jOoi7ThFUqF8f
        Qio9RixihDJtCefxZ8w53NKmVopI3ThxHzfDVhLVqRsq9YQ/h6F9JKAWTjSzdXc6
        hU8WA9SjzNyyoPOd2eQ2DfB4hYugaL5QoazOgWvo3gNHjhCv/76sqCFJE/oS4SJK
        ScxcERHhHuY+ZI5yLS68UuY31mrfmtNngfNSvotYxNTOGYQIqILI6m+ZeJ1tFdfM
        7tWmEFXxZAQdR9tG890optbvvjblmA5BSTcJwA/dhw==
X-ME-Sender: <xms:s3bgYgW1h4SwqItt2sF2qB3Z_K4yNsYjENmv9InKiU5hT2Ssm6mgig>
    <xme:s3bgYkmt_Ng53Q_0tGvoP1y9MDIM5LWLHSI9M8osLu82ETcUc1C9Hg792cTDzHwPQ
    8tYUQZuGQRd3_tx2pQ>
X-ME-Received: <xmr:s3bgYka28WtDCLj_TyAyt85escGea_i0hJzjwR_5c4jEE0GvoxLvVvGequ4TXi8f4VmHxaYER2Nhlq6_d05J8qUAAvxE_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduuddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    duveelkeeiteelveeiuefhudehtdeigfehkeeffeegledvueevgefgudeuveefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:s3bgYvXrGCGlbF13bikd9P734QNbuQq4qEsP_RjY166Rwrqi6ZfYuQ>
    <xmx:s3bgYqlZurMyvfxodAsDdAG3Zv2b7bpDWaSKp7LvQf1mL5U3QPg0NQ>
    <xmx:s3bgYkefmKlkZbnS-CEM-v6DSTpMS8nMlSxtfIzEwX1kQRVI_oYSvQ>
    <xmx:s3bgYrAyrxRhWTDs9KJrxuQsWyGC319TZWHq8MsS4t0zKMAMqAe6MQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Jul 2022 19:20:18 -0400 (EDT)
Date:   Tue, 26 Jul 2022 16:21:03 -0700
From:   Boris Burkov <boris@bur.io>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 2/4] btrfs: make __btrfs_dump_space_info() output
 better formatted
Message-ID: <YuB238MyKE0VTDtq@zen>
References: <cover.1658207325.git.wqu@suse.com>
 <dc40ddc78b7173d757065dcdde910bcf593d3a5c.1658207325.git.wqu@suse.com>
 <a5321725-1667-fd6f-2bfd-8ddb7b78d038@dorminy.me>
 <20220719213804.GT13489@twin.jikos.cz>
 <3cfc9569-ff22-c04d-f7d0-fea1396ba4b5@gmx.com>
 <20220726181353.GJ13489@twin.jikos.cz>
 <YuBUTX1i63o7Uo1O@zen>
 <20220726213928.GP13489@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726213928.GP13489@twin.jikos.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 26, 2022 at 11:39:28PM +0200, David Sterba wrote:
> On Tue, Jul 26, 2022 at 01:53:33PM -0700, Boris Burkov wrote:
> > > Yes we shold care about readability but kernel printk output lines can
> > > be interleaved, single line is much easier to grep for and all the
> > > values are from one event. The format where it's a series of "key=value"
> > > is common and I think we're used to it from tracepoints too. There are
> > > lines that do not put "=" between keys and values we could unify that
> > > eventually.
> > 
> > Agreed that a long line is OK, and preferable to full on splitting.
> > 
> > What about making some btrfs printing macros that use KERN_CONT? I think
> > that would do what Qu wants without splitting the lines or being bad for
> > ratelimiting.
> 
> IIRC I've read some discussions about KERN_CONT suggesting not to use
> it, I'll ask what's the status.

I just saw a comment at its definition that reads:

/*
 * Annotation for a "continued" line of log printout (only done after a
 * line that had no enclosing \n). Only to be used by core/arch code
 * during early bootup (a continued line is not SMP-safe otherwise).
 */
#define KERN_CONT       KERN_SOH "c"

So that's not an encouraging sign. OTOH, I found some code in
ext4/super.c that prints its errors with KERN_CONT here:
'ext4: super.c: Update logging style using KERN_CONT'
