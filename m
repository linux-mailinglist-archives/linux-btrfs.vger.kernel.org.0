Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837BD597CEF
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 06:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbiHREMr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 00:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiHREMq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 00:12:46 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D738E0F3;
        Wed, 17 Aug 2022 21:12:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id A39A1580EA6;
        Thu, 18 Aug 2022 00:12:43 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 18 Aug 2022 00:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660795963; x=
        1660799563; bh=p5RQmR6ERx2tDB2QJRfxZE9rzRDcq3welkce5QeUbYs=; b=O
        oKnylvE/AVYyogIvJltr/srgIDHK8Sanss7o+l3SKKyBopX/mtCW5wbCyZy/V2rq
        +nb3s71owFWYOhZcNRBlnjE+Nuu1GAJeTobApxWPn8z0E9Uh9u7KraqyC3RK9Q5X
        bn5cYfofLRhsymLUDfpY20Ja8IK1tJdYVD+q/IO8mxDB0ajDIq6ukB+NXvvupsq4
        jv+xz/gWuGS3G4E7GUjGgdtWUzgxJxE8Crhm4OcbGCXyYEfGNvN5vtXvMhfZtvpW
        ng1ZAksd3ska/qruZqOl4f0Ey0pW0Nl4MxslmsCesKMj9PzLzZg+JSQ4cyliPfvv
        5dM2lnG2WN2fhfAeB5Sxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660795963; x=1660799563; bh=p5RQmR6ERx2tDB2QJRfxZE9rzRDc
        q3welkce5QeUbYs=; b=yLEoXdwl1f+R2Klw8SFe3faAxLUwIZaDdvGtjh1oY3sa
        AXMTbC0erEKcBMfzElMoBVTxXjW7f2HWL+fltGSdAZHjwXPlU6C2AVM+1jByfueu
        5GfnRLCNK2l3Bd6GGpkMZGjc4KXGEIxhhOmeW7+R4U/65b7ZMARKOuxIkUdyflAv
        8jbX6oeSGZ1aoFwAG+AcffCo19xGA7NVcnMlXY8IWC34uhrVX+I1kwrj+ul1nNjo
        SZ48mQqu17oyX8O6hLvsrUoWxqyicSuxdQe+WzMh8gNeMOhA5m4lcKlQMGujD5Os
        rsEIFuPoc/W1vUxK/QGq3VHZ2+DNSwEu4q/uHbJRTQ==
X-ME-Sender: <xms:O7z9YouZUCIdNefgZKrAji9Yrrg89_Zga4ZgABfjOBgNTqzK9YpDBA>
    <xme:O7z9YldeXmRkigaEtd2j_sER2o9lCavrwBhjXFPnnpJaTssbCMgSmI7Hoa87XzvUS
    WfNk0twRXEE9y5FxqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehjedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
    ufgtsehttdertderredtnecuhfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoehlih
    hsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeef
    heeliedugeeuleetffeuheegkeetgfdtveevudffgfejvdegveeljefhvdefhfenucffoh
    hmrghinhepghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:O7z9YjythObrJkGGDGalvsYnnQfaqfHCMVwaTqt6IZ7Fs1z9W-8yiw>
    <xmx:O7z9YrMWVVr9mJSHxNiluU5-QE9WKXBGOXIDrOKiDPc6iecTsex5MQ>
    <xmx:O7z9Yo9A50sqhrivp7MzhNrklWt1nXXH58fI2HA8D7tDpZUj0pEKZw>
    <xmx:O7z9YlMsiIqdQxl7YP1Mdb-HEOIKjPleDumdMgmKjklpQOEkRM9CGg>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0C4551700082; Thu, 18 Aug 2022 00:12:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <9f2f608a-cd5f-4736-9e6d-07ccc2eca12c@www.fastmail.com>
In-Reply-To: <Yv2w+Tuhw1RAoXI5@T590>
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
Date:   Thu, 18 Aug 2022 00:12:21 -0400
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



On Wed, Aug 17, 2022, at 11:41 PM, Ming Lei wrote:

> OK, can you post the blk-mq debugfs log after you trigger it on v5.17?

https://drive.google.com/file/d/1n8f66pVLCwQTJ0PMd71EiUZoeTWQk3dB/view?usp=sharing

This time it happened pretty quickly. This log is soon after triple digit load and no IO, but not as fully developed as before. The system has become entirely unresponsive to new commands, so I have to issue sysrq+b - if I let it go too long even that won't work.

-- 
Chris Murphy
