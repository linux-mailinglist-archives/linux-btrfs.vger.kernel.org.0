Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EF059A648
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Aug 2022 21:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351542AbiHSTVe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 15:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351547AbiHSTVJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 15:21:09 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55889115587;
        Fri, 19 Aug 2022 12:20:53 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3D19358036A;
        Fri, 19 Aug 2022 15:20:47 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Fri, 19 Aug 2022 15:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660936847; x=
        1660940447; bh=CvyHEbh2ZUEdzkoT+B+txpRgO4O1L+8cWUke1mfGNqg=; b=j
        +ZEf1oMeiB338QYixL3bIOoDb0NNjvkmt7hQU1i4eIOF50eddqy8v9pAGxh0m46q
        RnRhVW136WStCAel6iih1ILI4Q2k94glo/uEyhZ9TW6Po0yCjQEH3btLar0K72H3
        x7We5MSIn48pNkLR3NdCSx+dIzTjxxEYN7aYzHN7lS0jbx9xU3bfrGBSepJoKQmN
        q9ipu4sZWpY1YP34AGAJQNBN3J2PPpfD+tx3POr+BBYU49oKgl7vrfuGbG2Hp3xo
        Kd3CN2mN1BSPqE5N2xgIdeN1jrLsW8Obv5Vp5ApXCoGkSZ29rvW9y651r18p+yvR
        ktFJbeFJ1PJCMZV73uhqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660936847; x=1660940447; bh=CvyHEbh2ZUEdzkoT+B+txpRgO4O1
        L+8cWUke1mfGNqg=; b=UPZCIu6efQhc7D2iSor4+HmuPDRBdw7/wvPEEw49GPLM
        ns11K54N67th5zKCsCfukPtXGpMw4eYtr/VYBbuuP0iH0X9nobO2uDA5DJBlsAF+
        0vYR8DzLO851e7u2ZGaez4AixR1fFqkGSzqB5FFOyBL2mVNH5pZqeLPhhEd6MxDd
        ODk+A8bXtImj4jNKT3Svkocq/nagtXhCi5X8T3ERQ7JnA9FR327gR/E8LcPSiMoI
        M2F8Tv2I5pWPA+/hfMeLfyE67Z6oS7RvASaG1evpaMNu/mHbQFADy9vWBCTgfOg7
        EN2ABWXldiVMol87q3Ype5MMLuMZ8/Id7gkIdyBriw==
X-ME-Sender: <xms:juL_Yg3OcJJLrKDOOZGUaRBGawGPz72En179-B6wxuwg6ANlVbuiyA>
    <xme:juL_YrGFGTXDdHGZR9vMIuPvnweVCUhUj_6Esoc9OI6SxHO5qkh0opC21RSjO78Z-
    EZSBaU_DWW4Up1UKSo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeiuddgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefofgggkfgjfhffhffv
    vefutgesthdtredtreertdenucfhrhhomhepfdevhhhrihhsucfouhhrphhhhidfuceolh
    hishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqnecuggftrfgrthhtvghrnhep
    feehleeiudegueelteffueehgeektefgtdevvedufffgjedvgeevleejhfdvfefhnecuff
    homhgrihhnpehgohhoghhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hm
X-ME-Proxy: <xmx:juL_Yo5Khz7EQFsOc9QNRbOxGW2Jhj_gFmWWzIHnfhLVdQ6s-WRc1A>
    <xmx:juL_Yp2-YVDJEq6af8iXFwSkcytbw61NzY1m8vshjwOJNcUXZaxhhA>
    <xmx:juL_YjH73iV4Yf-TF3DetbtSJcnztdNAdJKpit10kCT83bppXWixqQ>
    <xmx:j-L_Yi3eI5Ve0w4acMgNG9LwFJ9p6v7mTEVBMaewD_OGDJCtB-lmYA>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3607717003FD; Fri, 19 Aug 2022 15:20:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <0f731b0a-fbd5-4e7b-a3df-0ed63360c1e0@www.fastmail.com>
In-Reply-To: <Yv3NIQlDL0T3lstU@T590>
References: <Yv0A6UhioH3rbi0E@T590>
 <f633c476-bdc9-40e2-a93f-29601979f833@www.fastmail.com>
 <Yv0KmT8UYos2/4SX@T590>
 <35f0d608-7448-4276-8922-19a23d8f9049@www.fastmail.com>
 <Yv2P0zyoVvz35w/m@T590>
 <568465de-5c3b-4d94-a74b-5b83ce2f942f@www.fastmail.com>
 <Yv2w+Tuhw1RAoXI5@T590>
 <9f2f608a-cd5f-4736-9e6d-07ccc2eca12c@www.fastmail.com>
 <a817431f-276f-4aab-9ff8-c3e397494339@www.fastmail.com>
 <5426d0f9-6539-477d-8feb-2b49136b960f@www.fastmail.com>
 <Yv3NIQlDL0T3lstU@T590>
Date:   Fri, 19 Aug 2022 15:20:25 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Ming Lei" <ming.lei@redhat.com>
Cc:     "Nikolay Borisov" <nborisov@suse.com>,
        "Jens Axboe" <axboe@kernel.dk>, "Jan Kara" <jack@suse.cz>,
        "Paolo Valente" <paolo.valente@linaro.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Thu, Aug 18, 2022, at 1:24 AM, Ming Lei wrote:
> On Thu, Aug 18, 2022 at 12:27:04AM -0400, Chris Murphy wrote:
>> 
>> 
>> On Thu, Aug 18, 2022, at 12:18 AM, Chris Murphy wrote:
>> > On Thu, Aug 18, 2022, at 12:12 AM, Chris Murphy wrote:
>> >> On Wed, Aug 17, 2022, at 11:41 PM, Ming Lei wrote:
>> >>
>> >>> OK, can you post the blk-mq debugfs log after you trigger it on v5.17?
>> 
>> Same boot, 3rd log. But the load is above 300 so I kinda need to sysrq+b soon.
>> 
>> https://drive.google.com/file/d/1375H558kqPTdng439rvG6LuXXWPXLToo/view?usp=sharing
>> 
>
> Also please test the following one too:
>
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5ee62b95f3e5..d01c64be08e2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1991,7 +1991,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx 
> *hctx, struct list_head *list,
>  		if (!needs_restart ||
>  		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
>  			blk_mq_run_hw_queue(hctx, true);
> -		else if (needs_restart && needs_resource)
> +		else if (needs_restart && (needs_resource ||
> +					blk_mq_is_shared_tags(hctx->flags)))
>  			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
> 
>  		blk_mq_update_dispatch_busy(hctx, true);
>


With just this patch on top of 5.17.0, it still hangs. I've captured block debugfs log:
https://drive.google.com/file/d/1ic4YHxoL9RrCdy_5FNdGfh_q_J3d_Ft0/view?usp=sharing



-- 
Chris Murphy
