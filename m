Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DE758F33D
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 21:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiHJTfK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 15:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHJTfI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 15:35:08 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2487823F;
        Wed, 10 Aug 2022 12:35:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id EA10C580A04;
        Wed, 10 Aug 2022 15:35:03 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 10 Aug 2022 15:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660160103; x=
        1660163703; bh=0vmr1fhdy+FAoUqaRAABEWacZoBorR05F3CyKvQXIo4=; b=h
        ooNUhKSJiBC6+3cetzdzZHffKUq2FaeCpRRZvJL9VtexQlDJLokwYyeJXqAelzOQ
        cLxh/TH46z1wy5VssQUWq+EpzINRzz7a3CCz/RugLHTo0zz7+bx8fQUzpQH0/DUe
        ZwJAocZx4Aao76m9SF3dLrs+9y9xoPpOUCSHh/IAl6qvHL5DkWLmvc8266yRgodr
        gb8+Jcuys+202gGXERC4MAAgYK0veWIkDC3ObuOG5qaKQtcpXGnHXFdm1R4isd/1
        n+skRHAZj8wQ7+lbOdmaFvjN8aFP4sB2njEg4p5EHDT8UwoRDwdysMsfZzPDbbwU
        Cbxd6livDaIzE5Me5+MMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660160103; x=1660163703; bh=0vmr1fhdy+FAoUqaRAABEWacZoBo
        rR05F3CyKvQXIo4=; b=0vfyS2DV8VWD8l4pKg81CY0oxBl50sbjJI4r8BkcNDhM
        UaPe3ljK7reseVkcsiT5jpP3/9Ucjx8yyJlVpG/qfAM9iSCHWfE5MGN5vhO9kNlb
        vvPgM2rHw+fPjZEPlrfWtt1iKsRyRtWRj8hjqYUwENu5SLH1a6V2CbVbHo2gESov
        RNxRftpo9DgTx4O3muaIelIEXHwTChaLyGOf/982o7tw90z9yqUHrX+na8e1tKZl
        ejMmNRQg9Qi60SY7qwG920dThqUutoTThuocdzCynxn9gKwVVh0j6Ryf0n1YeGyr
        PbC4dB4DMC8VUGYXfB/JM0QjAYbQC9KGr4dezIHq5Q==
X-ME-Sender: <xms:Zwj0YiYQdoCRSAsbqIH37r9h0FEf2GdA5BGj2Q8Gd6Yo8blfa3YtQA>
    <xme:Zwj0YlYgxeOYjRfYopjXFO1JyjBYYxBFsDUgE1s2UHflpWxZGdpmsaOHBeJB0IvyY
    8JMEmfskG5KTH1kSZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegvddgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepgfdvueektdefgfefgfdtleffvdeileetgfefuddt
    ffelueeiveeiveekhedtheeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:Zwj0Ys9gpHAsqJ7qAMRicerz0059rnEay9pMniPq_e7gjHe8lQJQoA>
    <xmx:Zwj0YkqerqrCDFS6GI5QhqTLDWGU1D2wPwH1toBsIKqM_ahEpOq8Lw>
    <xmx:Zwj0YtqlC-M05bTKfisojXLMnBn7wlalvDn1D067wCCBwq33OXVOEg>
    <xmx:Zwj0Yk3Uz5uM6nnerfKhKNX0LWIMkoNS52MeQBxZI6v6LNGWoL0-wg>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9B7B21700083; Wed, 10 Aug 2022 15:35:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-811-gb808317eab-fm-20220801.001-gb808317e
Mime-Version: 1.0
Message-Id: <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
In-Reply-To: <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
 <YvPvghdv6lzVRm/S@localhost.localdomain>
 <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
 <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
Date:   Wed, 10 Aug 2022 15:34:43 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Josef Bacik" <josef@toxicpanda.com>
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: stalling IO regression in linux 5.12
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



On Wed, Aug 10, 2022, at 2:42 PM, Chris Murphy wrote:
> On Wed, Aug 10, 2022, at 2:33 PM, Chris Murphy wrote:
>> On Wed, Aug 10, 2022, at 1:48 PM, Josef Bacik wrote:
>>
>>> To help narrow this down can you disable any IO controller you've got enabled
>>> and see if you can reproduce?  If you can sysrq+w is super helpful as it'll
>>> point us in the next direction to look.  Thanks,
>>
>> I'm not following, sorry. I can boot with 
>> systemd.unified_cgroup_hierarchy=0 to make sure it's all off, but we're 
>> not using an IO cgroup controllers specifically as far as I'm aware.
>
> OK yeah that won't work because the workload requires cgroup2 or it won't run.


Booted with cgroup_disable=io, and confirmed cat /sys/fs/cgroup/cgroup.controllers does not list io.

I'll rerun the workload now. Sometimes reproduces fast, other times a couple hours.



-- 
Chris Murphy
