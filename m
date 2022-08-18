Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2295984B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 15:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245259AbiHRNus (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 09:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245307AbiHRNue (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 09:50:34 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF4FBB9;
        Thu, 18 Aug 2022 06:50:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id B24AB580847;
        Thu, 18 Aug 2022 09:50:28 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 18 Aug 2022 09:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660830628; x=
        1660834228; bh=JrWFwbCtn41niA34uNUTGzKOa60xVpzU+xS6F63mBuk=; b=x
        genQHvVViPsfshnTiNUWobTMSLkmLCImNPOcT3Dc0xK9xoQ1J8XQC1W8fFIIS4lK
        P/4wWrOchGCVlf0ogXih7crYxV3pTvaoilztu7Z7UlcucO9w01lqWkvdKntYT3qu
        VMgUiV6A0hPIJ4A76qkxEw6HDo6ZUl//Wfnym/evbQcxAweJFVuMB44sSxbUcjVf
        gYx3iuQq9ZhkenTdonmjrbct87c9jyuZlhM9kY+PUiorhZnjNwJ+4P4WQjMyzVQx
        YlX/n1T4s91l9/CThxc4cYVPRd/2Iwf1pJwWPzljxAEOrOp0PcvI955jVT/wO+es
        Dgb6ZBQv9OG2MiC1cDJxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660830628; x=1660834228; bh=JrWFwbCtn41niA34uNUTGzKOa60x
        VpzU+xS6F63mBuk=; b=yStHHx4uC/vnnp1i9wGZk94xvh/jiSULPJjeC1e5NG0a
        s0aQ1HkP2kis1v5o7RPvQxLlRih3YuGsLVp2KMvnKvboPpHFGK1aaHQwKFrX9wBy
        k2/kYlydGRXI522YI0wFhw/PnbR5nl4djeiF3KNipeVGOivqzdilsON2iekuGWNT
        WkV14IvAXKZ/2Hq+yeg2m9KOtIp5IVXqSCTSHIBauIymtCN/6Gq9sipqYcsqqJCk
        S4647BZkNZkRzYcO/n3mZuAmIXSfT2n91pLHNsYDOWrbNUHxnoLLN3ZH5TUg83mK
        bxIkNIxKjPdDSL6lyM1pqbJgSWhNhlc4VJiPX6xyYQ==
X-ME-Sender: <xms:pEP-YnHDxWKDkyDnHD5gon8nELjEuDVuJMguC8NzulIcaBfxSjyPjg>
    <xme:pEP-YkXZ7S1B9xfXvPdClTnnIWc7-VwldtsQzmbPk8S_apn2iuEN222hoJWk9Qz4E
    Uy6yl5sifj-eYBzOmE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehledggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefgvdeukedtfefgfefgtdelffdvieeltefgfedutdff
    leeuieevieevkeehtdehueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:pEP-YpLYdVibr6u3RS0w-JWWfItk_DsFPLdRd__CKfGE_zmIBk1fqw>
    <xmx:pEP-YlHOOxKf9tpuXSfAYp7feNTi3iC4O0I-ryfuD6u1hQHRKbpmUg>
    <xmx:pEP-YtViwys_vKarLCXa1KxAlkiwOHTDPxvUhLP8U5pPh3gHA-SNfQ>
    <xmx:pEP-YsE-xMoxK7S8p6ZNGeFf6A3phPeIGofE2plBDgH1_zqz05s4fQ>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 28CF11700082; Thu, 18 Aug 2022 09:50:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <aadeb600-4e3a-4b69-bc17-fd2918c5b061@www.fastmail.com>
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
Date:   Thu, 18 Aug 2022 09:50:07 -0400
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Thu, Aug 18, 2022, at 1:24 AM, Ming Lei wrote:

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

Should I test both patches at the same time, or separately? On top of v5.17 clean, or with b6e68ee82585 still reverted?

-- 
Chris Murphy
