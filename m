Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E45597153
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 16:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbiHQOfF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 10:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiHQOfE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 10:35:04 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DC998D2E;
        Wed, 17 Aug 2022 07:35:01 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3ACB7580DD0;
        Wed, 17 Aug 2022 10:34:59 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 17 Aug 2022 10:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660746899; x=
        1660750499; bh=LKAtXnNRZjf7HOL+a5fvbCQjSFrC2arcLqqtzB9D/T0=; b=i
        2Yc0j1JaZ1K6BH0QVUfz9M1QWgDAHVlRzr0RuK8p1b3+bej4viaWHonWBYwWL2mN
        ty6pz8fI/N3mQbhi+CFz1WE7cIjBiFuA/VynPQg0Z6/eTloGNGgV51rRcVXsgYS8
        uX7haAZOKKjqKSu2y6dYH8dJ9a+9KhdBddj8jw9Y7+OwKn5RuS8yjAFwMC7MFN5t
        a69ET65isDGsQ5fc7Ej/5GBYMaf2/7SEJ74KF5NVPNv8I8ArlvZHs42ePE9dXPWr
        9xPNqn64RbFsJms6vgpscWX7yDQHALTJTe6WSSPE6HA38ojezm+6kPzu5GqyHnWH
        P6O6IrO5yR4fMYwJfWoew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660746899; x=1660750499; bh=LKAtXnNRZjf7HOL+a5fvbCQjSFrC
        2arcLqqtzB9D/T0=; b=D4lOcERm5opWkkE9Lp2LyMupzv20uyAOxkeNDukNZBFc
        ZU5IH44+0hiCIaourmL7MwrQeumaS/jJw7qqHM01ajIUoHi+Z6UwqvrrK93nliR4
        FcWGcab2vpl3Q88IaryGfJxly6f81+3Y+NVL2R85e+5u1aROj9rjIsZUjsT1QFbT
        TQQKQNUh+wDBrixUAAzEHxurCkc+s8m6bE1r3vFzMhQsr767KfcCmgayR0OC+F+V
        qxXuiRFsOST2LRdPipxsiFoAx0ag+kwzLNMiYbX2a955noucA2dXEG2nbR4a/OR9
        CRI5CCzYPDCKaWBb7nBkQR6g4sSxA2c78YlgEG8WCA==
X-ME-Sender: <xms:kvz8YgxIEvmNuBrUezdvVQFB9IP-Wo0iatp3tM53RJIPj-nUm2Qv_A>
    <xme:kvz8YkSRiZRMWgJ-siy4T7JR4dii15vpz4ULviBvyxjrsifBHi0VVaHpIgegkwGhZ
    6CMEuqpuyCyKWRiOIs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
    ufgtsehttdertderredtnecuhfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoehlih
    hsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeef
    heeliedugeeuleetffeuheegkeetgfdtveevudffgfejvdegveeljefhvdefhfenucffoh
    hmrghinhepghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:kvz8YiVKJrH397tnj2KjSIhSnk6_QR2yz02WhKQvZ5HfyJU6H7JAmA>
    <xmx:kvz8Yug76ogNh-LvW82VYd-Wlk58i3cmNtszgXIJp7unAxHH48aouA>
    <xmx:kvz8YiC2sWMAOsrhtC1-XJMnKq9-KhD_2PbGfgKiWsFJ8szG1RgSRg>
    <xmx:k_z8YoD0SQ9Z7Kpqx1TjZIBnkaaBLOOaWdlaoswUB2uGaRm8v1snJg>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CE9F21700082; Wed, 17 Aug 2022 10:34:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <b236ca6e-2e69-4faf-9c95-642339d04543@www.fastmail.com>
In-Reply-To: <CAFj5m9+6Vj3NdSg_n3nw1icscY1qr9f9SOvkWYyqpEtFBb_-1g@mail.gmail.com>
References: <e38aa76d-6034-4dde-8624-df1745bb17fc@www.fastmail.com>
 <YvPvghdv6lzVRm/S@localhost.localdomain>
 <2220d403-e443-4e60-b7c3-d149e402c13e@www.fastmail.com>
 <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
 <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
 <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
 <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
 <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <CAFj5m9+6Vj3NdSg_n3nw1icscY1qr9f9SOvkWYyqpEtFBb_-1g@mail.gmail.com>
Date:   Wed, 17 Aug 2022 10:34:38 -0400
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



On Wed, Aug 17, 2022, at 8:06 AM, Ming Lei wrote:

> blk-mq debugfs log is usually helpful for io stall issue, care to post
> the blk-mq debugfs log:
>
> (cd /sys/kernel/debug/block/$disk && find . -type f -exec grep -aH . {} \;)

This is only sda
https://drive.google.com/file/d/1aAld-kXb3RUiv_ShAvD_AGAFDRS03Lr0/view?usp=sharing

This is all the block devices
https://drive.google.com/file/d/1iHqRuoz8ZzvkNcMtkV3Ep7h5Uof7sTKw/view?usp=sharing

-- 
Chris Murphy
