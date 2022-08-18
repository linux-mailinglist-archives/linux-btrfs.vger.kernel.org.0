Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977E8597D80
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 06:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243376AbiHREcx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 00:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241247AbiHREcw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 00:32:52 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2F6A3D47;
        Wed, 17 Aug 2022 21:32:50 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id B7756580B04;
        Thu, 18 Aug 2022 00:32:49 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 18 Aug 2022 00:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660797169; x=
        1660800769; bh=W2eJw7KGKlXQRQPp791lExmWC5wtIiq7rEevTDXit7U=; b=q
        KPsDELaFWEZhbn1wGk1MlUp7ZAtpFeOVxzTL+flv1958SBLjYwRgSSDNSmm8tP1v
        0qbhkXsJu//yksy3uRLzTZcgh0stFcleU++a1ctX8bWfU5yMgMvo27kY265V4ZgJ
        GfKDSClkR39dTL9TDS5WdTTx4BhB/F7sCZQ0N6LyU0Ip6xRrq6cF22R20HbFiZo0
        eiEyD0D+iBAxjZqMSiWg787QD7AjfZpIqVuptuJJ9LrwnTTOWHd98oU6Wxhq6jNb
        Nz/syUmKvqja+sagCQpGWRN5rXpJXel6Tp3hN6JOHsHtvGPiaMevckRhxk92y668
        x4BrPVAaFYTbmRoJ4gp9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660797169; x=1660800769; bh=W2eJw7KGKlXQRQPp791lExmWC5wt
        Iiq7rEevTDXit7U=; b=acl3ROum7Kf0ueXUdDeMApAC4WoAT6qkp4P4pmeKZYP5
        CU4AJkpuPapFYFG4ZzCJpHc6TrbUcNmCBNM/ebWov9eaWaTJTKXv+7mude1G6Wz5
        DCthDdml92AizUlnrnhaIt+wz6PvkaxpZaiYuvrvpSZ35azyyKzVgwDlxh/wJsYc
        YJ5B1WkfgQ5iZcpBgmJJ7cWSxFUA4DF/1I4OL2+6mLI697hOb+eMH4lx7BgF/4zl
        u/Dohd/E/ApSfssUn8v/+Ca+IrwG62jBOnF0cJc/3PEei7m7zGUlcSovUS+Ipz7v
        5VeUQELYyesDqAIz4tF7tt1TSFHYYL/MbP6J0RdgxQ==
X-ME-Sender: <xms:8cD9Yj3Wt3EMUeBgi6ugycuhgPmhFS_DO3nVTeQ_IrreRY9aj6EAfA>
    <xme:8cD9YiEi80OkdTP-iKcPouDxB-3c2TURsfPvuIK0P6Sgxkb-9ZNGjaXRAqbbg_R0h
    O4Emdr12DZ1SZJsM7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehjedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
    ufgtsehttdertderredtnecuhfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoehlih
    hsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeef
    heeliedugeeuleetffeuheegkeetgfdtveevudffgfejvdegveeljefhvdefhfenucffoh
    hmrghinhepghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:8cD9Yj6G-2poML8ZfB-tNtMbwwimq7PyzUV5L5a73Vo4l6AVkt3Chw>
    <xmx:8cD9Yo1Iv1E9uY9gnjzlNG0fa7VKI0oYy8W82uLARnUVtQsTIpZF-Q>
    <xmx:8cD9YmFW4A2JpKl5h-b4HTxpujH57GWZ3NLvNL_-x-rQ_9irz6ymWw>
    <xmx:8cD9Yp12XfAg2KmeZp9bGb7QFEguYNQsYT4sumTAiQTDHzR9Xx2OKg>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3B2BE1700082; Thu, 18 Aug 2022 00:32:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <f74b484c-4258-41db-b3d4-a585197f73b7@www.fastmail.com>
In-Reply-To: <5426d0f9-6539-477d-8feb-2b49136b960f@www.fastmail.com>
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
 <5426d0f9-6539-477d-8feb-2b49136b960f@www.fastmail.com>
Date:   Thu, 18 Aug 2022 00:32:28 -0400
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



On Thu, Aug 18, 2022, at 12:27 AM, Chris Murphy wrote:
> On Thu, Aug 18, 2022, at 12:18 AM, Chris Murphy wrote:
>> On Thu, Aug 18, 2022, at 12:12 AM, Chris Murphy wrote:
>>> On Wed, Aug 17, 2022, at 11:41 PM, Ming Lei wrote:
>>>
>>>> OK, can you post the blk-mq debugfs log after you trigger it on v5.17?
>
> Same boot, 3rd log. But the load is above 300 so I kinda need to sysrq+b soon.
>
> https://drive.google.com/file/d/1375H558kqPTdng439rvG6LuXXWPXLToo/view?usp=sharing

sysfs sdc

https://drive.google.com/file/d/1DLZHX8Mg_d5w-XSsAYYK1NDzn1pA_QPm/view?usp=sharing

-- 
Chris Murphy
