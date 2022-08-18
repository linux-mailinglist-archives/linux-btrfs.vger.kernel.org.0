Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7344F598C0A
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 20:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345429AbiHRSxG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 14:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345235AbiHRSw6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 14:52:58 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585E9C2E84;
        Thu, 18 Aug 2022 11:52:57 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 842235801B4;
        Thu, 18 Aug 2022 14:52:56 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 18 Aug 2022 14:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660848776; x=
        1660852376; bh=Ts6SgEwcKB+gnnxX0Mg89SPTORlM9/ZfOczJIVc1pgY=; b=s
        jHZfKEnrAWU7KnQmcdIQeoJaQKZ9a7y4Lzssq43mdkqlnmN38vMUWHeAVGl/92p9
        EF5j2pfU/3ibfgMCIu+DPLxxLbhqlPCxe1krQs+xeoO/U/nB3NdR5hE3TXYXM7wX
        ybnhDKA4MwlnPQ84ekJb8uD0ladMlnMxQol4eKsdHhZVXH76m85+kDT72CanzoOl
        vURpyj2wIbWOaocr7PxF6u9BiusjRxYGHmGWqCNEWBrTZOWWRnfPL+xCcrDtyPv1
        Q//iIxRkuneguH1OZX+KoE2msbjl33EIuqay+K6L10+1t5KqPqog/sYFMVzgWL0t
        q/jvnk0S2Ww9xE8N98+kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660848776; x=1660852376; bh=Ts6SgEwcKB+gnnxX0Mg89SPTORlM
        9/ZfOczJIVc1pgY=; b=LHrMOXycIBvofkcqKnNkKZGsoW75RVE5rbIm62q68gef
        hgNUfn66xH9tYrXJJj7hT4Uz+n0RSsuo5wHwjPeBycW6myH75JFXzd3HC9BhnxkJ
        G3xRsIyQz+jRXb1BIcs07qYtffwjbR90MtF/mHBoTaxBYJiYJdR961qAAUmp8l/0
        kpF+wQxfMIt9d0cgf0Wrji8rME8JBarxujmwI42L8PZw6IgLG//U1rMKt1HuqjII
        G0mAqPR0Pc9/hIBt6try1mTR2JEq2D8Cjxxf3Jdo/0pyiZ/EhjkrYRzoJY0UVlot
        yFNDPxRp4+VFE/QA3s6Jj9R3naFTKbpXxFfEUAbSag==
X-ME-Sender: <xms:h4r-YmQ9WP2krC5G1entLJ7EUPya8p4CoU9562V313IWfSqAGQ7wYg>
    <xme:h4r-YrwX4L2Xo8eZA1rkNZxVfMbkgQlG9SM6_7s3duRx0u5ilrUsIe3iOkVsHMd9u
    N6Mf7i-Y_2T13YQCUk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefofgggkfgjfhffhffv
    vefutgesthdtredtreertdenucfhrhhomhepfdevhhhrihhsucfouhhrphhhhidfuceolh
    hishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqnecuggftrfgrthhtvghrnhep
    feehleeiudegueelteffueehgeektefgtdevvedufffgjedvgeevleejhfdvfefhnecuff
    homhgrihhnpehgohhoghhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hm
X-ME-Proxy: <xmx:h4r-Yj1bbQ4madkVb0dx8BXBTl3dA1aeP0_Bg0NB73CzngWa6DM_yw>
    <xmx:h4r-YiATqKs_aiFBNkKsfRUT_YaG9Bi6INsyAP09-vwxXEIwIEVMLg>
    <xmx:h4r-YviogrXyWGUyIkP0dcrda1UG_9Xbc3abPNgOXpXgvjR3mRT6Rw>
    <xmx:iIr-YvgIryn7QxtJm1dMEBop9bbI4FM64_OAQUUsWm2E0QVeCs0UWQ>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DD34E1700082; Thu, 18 Aug 2022 14:52:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <bfaa8b43-519f-4e4c-b04b-a37b0ee9babf@www.fastmail.com>
In-Reply-To: <Yv3K4G/Sv2KDEqif@T590>
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
 <Yv3K4G/Sv2KDEqif@T590>
Date:   Thu, 18 Aug 2022 14:52:34 -0400
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Thu, Aug 18, 2022, at 1:15 AM, Ming Lei wrote:
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
> Please test the following patch and see if it makes a difference:
>
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index a4f7c101b53b..8e8d77e79dd6 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -44,7 +44,10 @@ void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
>  	 */
>  	smp_mb();
> 
> -	blk_mq_run_hw_queue(hctx, true);
> +	if (blk_mq_is_shared_tags(hctx->flags))
> +		blk_mq_run_hw_queues(hctx->queue, true);
> +	else
> +		blk_mq_run_hw_queue(hctx, true);
>  }
> 
>  static int sched_rq_cmp(void *priv, const struct list_head *a,


I still get a stall. By the time I noticed it, I can't run any new commands (they just hang) so I had to sysrq+b. Let me know if I should rerun the test in order to capture block debug log.


-- 
Chris Murphy
