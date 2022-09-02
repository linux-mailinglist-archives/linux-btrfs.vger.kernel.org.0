Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DA55AB6E4
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbiIBQxg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 12:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbiIBQxe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 12:53:34 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F0C109520;
        Fri,  2 Sep 2022 09:53:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A4575C0098;
        Fri,  2 Sep 2022 12:53:33 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Fri, 02 Sep 2022 12:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662137613; x=
        1662224013; bh=6qA7lebsNoe0qaVBnLzE2yT/XJd2sQGK0XBPJNKv/Yw=; b=R
        xVZNXHhzt0puvbLyE74kkQojDQ6606NuOmpXNUfDcAuYJXojglnpBsoqvR+EF5JY
        TD8R9hLB54s1Iu0F4tSFJkUPoPwul1TBCN7g2Bvci5K5w2ryMnR+ZXPA7MHnLD1p
        SnSHvY67/nQ7HTEc4jqnbIFb2IZ1AtMJ/CUzWeDJJVFcM0kKwsrSZB6u+tIMI0W+
        WEGvofwCAUMuBEvpix4emT/2Ay3f22iZ4NaMCFXnM7dYmRi4o1AqhTQghdOBodvz
        91YIEDXrU1sHxWFnBYU2PdPnWrMFwiovVz6vlVLfRIC4s4zartQgoWh43OPSB9Vb
        sEYIA49IY2/fVyZP1v9yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1662137613; x=1662224013; bh=6qA7lebsNoe0qaVBnLzE2yT/XJd2
        sQGK0XBPJNKv/Yw=; b=y/v5sBx1o5vTLrrrv61Gjsn2XKPMwdezDpEhws2B3kNh
        WAtiRUOb94sJ+78+igrFGQwEtVnn0bOn+OQ09cucpEikR+xBtE7UHesz3RQgunv3
        QFbfZ6Q7ccpHhON/qwkjyTf6kia3SohZg8y8zaNbpZuyVBomkIvGETnuQiWBxTtf
        DmuFw+LsGfkKNVkwBLAhvzJNLaWTcUSsBVVZo6TPTUvzp2LzIo8FJA4xLpFGxhud
        OSzYr3mCNnfPp4WNl+Rtr6Q+H0rRbv9nwl3WaDr9U/HQhRfm9SXMBKA7h1IvqS4m
        AxlcJme9w2vSaZ62TkoIXpjBKqLoBIMYVgAg5rO14g==
X-ME-Sender: <xms:DDUSY8dA8g3XXog0_9F1_EMugWcFLU-f3b5bV0gta4BS5xrG1STsOg>
    <xme:DDUSY-N6wifJZfplB7aqW1NojTTNKvo4Ht3cFCmSFZUamVP3VMmjkNTawjEyjTDHt
    xFoN_7xz7jPOcXkMRU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeltddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepgfdvueektdefgfefgfdtleffvdeileetgfefuddt
    ffelueeiveeiveekhedtheeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:DDUSY9ic2sLq_d63iiVOJ4ugHQEmX-_2aQ7mcleWR4UdRMUoBa5ILw>
    <xmx:DDUSYx9EAoygpWJ4TIAAnKD9U3VX6rl6INLrJuIEnyUSGnVT7XF1Vg>
    <xmx:DDUSY4ufApFGEpaTRKuh3EJHCUcym536CyCPqZeXawTZUBZ0gQEkZQ>
    <xmx:DTUSY6KqPCwzhdpbGyIkEyprtpSE5WV8E_X6YpLtK7Ec6Ee3m0BGNw>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F3EE41700082; Fri,  2 Sep 2022 12:53:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <a8bf11e4-8d2f-4fe8-9d6d-533c7b19db8d@www.fastmail.com>
In-Reply-To: <297cbb87-87aa-2e1d-1fc3-8e96c241f28f@huaweicloud.com>
References: <Yv0KmT8UYos2/4SX@T590>
 <35f0d608-7448-4276-8922-19a23d8f9049@www.fastmail.com>
 <Yv2P0zyoVvz35w/m@T590>
 <568465de-5c3b-4d94-a74b-5b83ce2f942f@www.fastmail.com>
 <Yv2w+Tuhw1RAoXI5@T590>
 <9f2f608a-cd5f-4736-9e6d-07ccc2eca12c@www.fastmail.com>
 <a817431f-276f-4aab-9ff8-c3e397494339@www.fastmail.com>
 <5426d0f9-6539-477d-8feb-2b49136b960f@www.fastmail.com>
 <Yv3NIQlDL0T3lstU@T590>
 <0f731b0a-fbd5-4e7b-a3df-0ed63360c1e0@www.fastmail.com>
 <YwCGlyDMhWubqKoL@T590>
 <297cbb87-87aa-2e1d-1fc3-8e96c241f28f@huaweicloud.com>
Date:   Fri, 02 Sep 2022 12:53:10 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Yu Kuai" <yukuai1@huaweicloud.com>,
        "Ming Lei" <ming.lei@redhat.com>, "Jan Kara" <jack@suse.cz>
Cc:     "Nikolay Borisov" <nborisov@suse.com>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Paolo Valente" <paolo.valente@linaro.org>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Thu, Sep 1, 2022, at 3:02 AM, Yu Kuai wrote:
> Hi, Chris


>> Also follows another patch merged to v5.18 and it fixes io stall too, feel free to test it:
>> 
>> 8f5fea65b06d blk-mq: avoid extending delays of active hctx from blk_mq_delay_run_hw_queues
>
> Have you tried this patch?

The problem happens on 5.18 series kernels. But takes longer. Once I regain access to this setup, I can try to reproduce on 5.18 and 5.19, and provide block debugfs logs. 


-- 
Chris Murphy
