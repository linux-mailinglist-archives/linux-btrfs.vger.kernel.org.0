Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C4A6D8637
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 20:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjDESqf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 14:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjDESqe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 14:46:34 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A613A4ECD
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 11:46:32 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id DF00E3200936;
        Wed,  5 Apr 2023 14:46:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 05 Apr 2023 14:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680720390; x=1680806790; bh=DT
        bKnVTRef9ieNPKS+nh7s1VThV0+QzR7VrB3LTft3Y=; b=nQcnYjJ+ubBMZY6z0h
        ABGAbH+KsJGAWarD9/ul4AOwuSKx9yBUvcXXUr8Qo+eYXJFUFE691VRv/7A9mxhl
        p+YL3CpmGY8zHsEDroNSJWAgFmjkX2s2+4XACx4+YcDxJrUqhe2tT5tmh730bOvD
        Up905PD2X1wCvw+zk0fZTHBZmRJHidC/VsTNqammexUURnzYiG68JxG0vYQhpAPa
        B0MTtJbQ7XEtMaIeLIQ9kjZ8eH6OIt2lnnRTAG6Q/+0FjZ977/w5YIjwB27XWk9V
        dfGFXCLKRHxT6O01grkzCvD246mbdPLrjVw87bh/aj3m/8JZx9CnCM355vH32H3R
        1auQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680720390; x=1680806790; bh=DTbKnVTRef9ie
        NPKS+nh7s1VThV0+QzR7VrB3LTft3Y=; b=oG8rsmpSrLIljh23hsfZHHjF9QjRG
        kG4ThErwP8RcZCnemmYyuJr/rxktuKnvfA7I22VXflYxQqDuPBMa+6enpYILt9vj
        ovvTZOp63tZomT+zI6i2Klo7TNA8O4kv+9PFu2qeFzBgra8qZ7CatZQfDS7AYTqh
        EGti7zyncjJN0H6BDS3Lim2ikcs/GgYpCVvj/Gg/ImjCBH0S5qrRgZdwc+4RKIOH
        MF07HsEdHdi/M1pDNqbhXkTf3RCzouT5/Y5C0oemSSJuGBttI6ICYKbqsOD8ME0w
        CsMsZU5tlGxCS5JqS9iuLBzhy5Ku6XdF7eDwfN0dvIKTV5R7qAn/ijG4Q==
X-ME-Sender: <xms:BsItZNFtJwpx5gXDcvgynBGBVUMxtLsZ3Jgbrbj7gBqoYroQP_nZ3g>
    <xme:BsItZCWkFYK1d0I8pONIRx_FA0pE6mcnxVrdnDPpv3TJux-8xOE5-oM9nA_OJ3XQW
    d7cAy-t5R1dC0oi3UM>
X-ME-Received: <xmr:BsItZPJ5LDQhych0QaeaoRtA92RGfSC4NERS1yMLIFv0fWW4Lxc9DB0J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    ephedthfevgffhtdevgffhlefhgfeuueegtdevudeiheeiheetleeghedvfeegfeegnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:BsItZDHEerjxufucPJzbYgnk1cFrPI2hqCiPtnOMxoPx_k6g_AoyzQ>
    <xmx:BsItZDVT-W_aY7UHZYU9PbDuOcVofWEj667r2lKo50L2EW2VGyWgDw>
    <xmx:BsItZOOnrNn4WiScKScEOzICVQV9T1YoDpb5C7XqPIL8dLyVWVxzOw>
    <xmx:BsItZKfEGe2cqYeUrSVjYf64Xxdv5Z4yWoUNZtLQnLIroQoJYinWBw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 14:46:29 -0400 (EDT)
Date:   Wed, 5 Apr 2023 11:46:21 -0700
From:   Boris Burkov <boris@bur.io>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: set default discard iops_limit to 1000
Message-ID: <20230405184621.GA1865461@zen>
References: <cover.1680711209.git.boris@bur.io>
 <45f813c5fabdb32df67ba661c396c592b863ff25.1680711209.git.boris@bur.io>
 <20230405223449.1904fcad@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405223449.1904fcad@nvm>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 05, 2023 at 10:34:49PM +0500, Roman Mamedov wrote:
> On Wed,  5 Apr 2023 09:20:32 -0700
> Boris Burkov <boris@bur.io> wrote:
> 
> > Previously, the default was a relatively conservative 10. This results
> > in a 100ms delay, so with ~300 discards in a commit, it takes the full
> > 30s till the next commit to finish the discards. On a workstation, this
> > results in the disk never going idle, wasting power/battery, etc.
> > 
> > Set the default to 1000, which results in using the smallest possible
> > delay, currently, which is 1ms. This has shown to not pathologically
> > keep the disk busy by the original reporter.
> > 
> > Link: https://lore.kernel.org/linux-btrfs/ZCxKc5ZzP3Np71IC@infradead.org/T/#m6ebdeb475809ed7714b21b8143103fb7e5a966da
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/discard.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> > index 317aeff6c1da..aef789bcff8f 100644
> > --- a/fs/btrfs/discard.c
> > +++ b/fs/btrfs/discard.c
> > @@ -60,7 +60,7 @@
> >  #define BTRFS_DISCARD_TARGET_MSEC	(6 * 60 * 60UL * MSEC_PER_SEC)
> >  #define BTRFS_DISCARD_MIN_DELAY_MSEC	(1UL)
> >  #define BTRFS_DISCARD_MAX_DELAY_MSEC	(1000UL)
> > -#define BTRFS_DISCARD_MAX_IOPS		(10U)
> > +#define BTRFS_DISCARD_MAX_IOPS		(10000U)
> 
> But the patch sets 10000?

Oops. Thanks!

... Just testing the clamping? I did run the code and observe 100ms
delays between workfn runs, for what it's worth, so it "should be fine"
but I'll resend setting it to 1k properly.

> 
> >  
> >  /* Monotonically decreasing minimum length filters after index 0 */
> >  static int discard_minlen[BTRFS_NR_DISCARD_LISTS] = {
> 
> 
> -- 
> With respect,
> Roman
