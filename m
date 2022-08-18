Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E15597D7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 06:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbiHRE1b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 00:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243211AbiHRE12 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 00:27:28 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB777F27A;
        Wed, 17 Aug 2022 21:27:27 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id B9D405811C4;
        Thu, 18 Aug 2022 00:27:24 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 18 Aug 2022 00:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660796844; x=
        1660800444; bh=4pbiKsyRQ61fUjmTNiJpgamw6NaShSpRkJBam04RwbI=; b=N
        kd0Wso2VhvA9cD5xteo+L9ofCF3ynw6BnMwaqKyA9/t7zSkUO0FMlf5GW6/WNgi7
        932eMu707dDNW9X6haCNXuo4msPUidLGlgy/AIJZdhz8TBUA+5z0mOwVOxou5PFb
        WSFW4XDXTGgt7gFGBFIGF2wrmnEmhzO7T3b3aGRdR9juUa0BdDl8kVqdhE/mAfJH
        yHVndG+MDyKQQp/QB9ZfoWvKzo3lgJLmPZWtN4LosILkS6nyiD4dpTDfdF/oVNVm
        hi+5NtJrds4Zq2o/maFFFy2cdRTor0x003NxFn4ts9p0JlZr7eqmWQ8QS3IQI9Iz
        cH9VQnnY9pYBa1xsqL++A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660796844; x=1660800444; bh=4pbiKsyRQ61fUjmTNiJpgamw6NaS
        hSpRkJBam04RwbI=; b=zB+oitSuNjgrzZT+pbU2ddgVDQrAqNOWPw6iYRPHN5Y1
        N+SL67M287m5M0+XuUGIK/KNuBPwI/CRoDTtJ7CjsXTZJ7ozEFd/4HAbXwfl5/r5
        yXFp08MvHMkSxVQuVEzaqTeMMdbwG5hi7hV4hIwoww7TJXxm+gBFhIZS83UY2vDj
        2faQJ1FJvIN2OxZ5lZ3BRh78ED59l5bXbjnsWkI19Ir7IE1ba+L7QvCAVOk2YIpQ
        O/HIw5LdpAQgaBvbPIDkoAcxZFHLqEFDJC5Iioj6dV0vDAxMT4/GhdvhydAIG6s9
        S7mUb3RjTiKuqY3wrB3woDT9WS6UY+DExwjSz5vdfw==
X-ME-Sender: <xms:rL_9Yj1Sh96-cXxx1QdhgAtwx-Ntx8pjMMIGBcGCq0-B1U8TgNUabQ>
    <xme:rL_9YiHuslGGIx4AOYuzxwLAUqWHXRwXMDkJf02LVmOeDmybtytpJgEg1aY82wfoK
    IGUBtz6tkcAhxP1vQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehjedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
    ufgtsehttdertderredtnecuhfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoehlih
    hsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeef
    heeliedugeeuleetffeuheegkeetgfdtveevudffgfejvdegveeljefhvdefhfenucffoh
    hmrghinhepghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:rL_9Yj5i7aYYoFbTbSdWcN8ekyOLxln0kD5Tso366eEk-jN0dZW5bQ>
    <xmx:rL_9Yo30YfMsJEuL5-4cvt27A88FXDPEiBi9n-Ei_Uwy6WSW2KXjLg>
    <xmx:rL_9YmGSq5bwKZt14LZcwyh-F4-rC1lceQvrexBoWyMrRsDNZBxz_g>
    <xmx:rL_9Yp1CqF139Q3UBMu9okePSA_8vaWidKd6aN3dawXi9jmNGUAS0w>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6780B1700082; Thu, 18 Aug 2022 00:27:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <5426d0f9-6539-477d-8feb-2b49136b960f@www.fastmail.com>
In-Reply-To: <a817431f-276f-4aab-9ff8-c3e397494339@www.fastmail.com>
References: <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <CAFj5m9+6Vj3NdSg_n3nw1icscY1qr9f9SOvkWYyqpEtFBb_-1g@mail.gmail.com>
 <b236ca6e-2e69-4faf-9c95-642339d04543@www.fastmail.com>
 <Yv0A6UhioH3rbi0E@T590>
 <f633c476-bdc9-40e2-a93f-29601979f833@www.fastmail.com>
 <Yv0KmT8UYos2/4SX@T590>
 <35f0d608-7448-4276-8922-19a23d8f9049@www.fastmail.com>
 <Yv2P0zyoVvz35w/m@T590>
 <568465de-5c3b-4d94-a74b-5b83ce2f942f@www.fastmail.com>
 <Yv2w+Tuhw1RAoXI5@T590>
 <9f2f608a-cd5f-4736-9e6d-07ccc2eca12c@www.fastmail.com>
 <a817431f-276f-4aab-9ff8-c3e397494339@www.fastmail.com>
Date:   Thu, 18 Aug 2022 00:27:04 -0400
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



On Thu, Aug 18, 2022, at 12:18 AM, Chris Murphy wrote:
> On Thu, Aug 18, 2022, at 12:12 AM, Chris Murphy wrote:
>> On Wed, Aug 17, 2022, at 11:41 PM, Ming Lei wrote:
>>
>>> OK, can you post the blk-mq debugfs log after you trigger it on v5.17?

Same boot, 3rd log. But the load is above 300 so I kinda need to sysrq+b soon.

https://drive.google.com/file/d/1375H558kqPTdng439rvG6LuXXWPXLToo/view?usp=sharing



-- 
Chris Murphy
