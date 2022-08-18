Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5068C597B7E
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 04:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242798AbiHRCbG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 22:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbiHRCbE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 22:31:04 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2BB1019;
        Wed, 17 Aug 2022 19:31:03 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id CC5F75812BA;
        Wed, 17 Aug 2022 22:31:00 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 17 Aug 2022 22:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660789860; x=
        1660793460; bh=lO/JKX725MxkaV2mB43UwzOt6HEFIjiXCMp5dmQPbbQ=; b=f
        rC09OacJ36xtRXw3Og6jfy4pD0h9dzuyZQ/Q+sb9t7XQCTfRpIzeB5a1wVgt87TH
        oIvDFjHQv/4EK/R1kpRTbS/NinshF6E5M5ZpS+TVn6JN+bgxZGe3VOro1YPKsi5q
        ien4DuwAZwhaBI3QZjEX4jwPHnMILcwUhtU8HXvAHNHPVcKVkO6tKhLH8VRtla6G
        YQ289oJWkiV6SlrY5goV80i0uMQoYJUywuv4iO2ooJZqrOPoMBdoedcI8VcGTJFJ
        pJWZpaulj4B1GH1b8PpCE4EXMKG+D4WK/by5KCemFsG6kOrCXrO5t7bdVPXrMWAW
        P8GMqdo+mpWyT3PuObU4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660789860; x=1660793460; bh=lO/JKX725MxkaV2mB43UwzOt6HEF
        IjiXCMp5dmQPbbQ=; b=MDssPZFWLeCbfkYiSecfWW++fc0xPwXpOawEH5sA7gif
        iFlRMcNrXMs+keVMJrmm/i7CRPreS4SVNdTEulHRy4tledhSD2ck0GIFJ5/A3Zz9
        kcCKLjvtBjIPFaDxfVUIwTmQp89/945LlAfN0FqK8Vkejoq3niavc/GsYThQwM9j
        FUz5Aw1YImYh/McBwNZjrSxFKAsdf5055p3E9bCWoPQxWSh3TYcXRFXnOyMIrwDA
        Eivs3unx4CetA0JdCO0jRPL1toE9qrbcyHA368Apbr7byt2QDgzeR8knw7l+L88t
        gy+0DxqwwoEqbBRzroElE4p6/R/KJJuNyHxPTV+xrA==
X-ME-Sender: <xms:ZKT9YpKoDce_WSshZZJMb65UFlxNKNGX1ybNTiSIEoKhgJeQUx_KxQ>
    <xme:ZKT9YlIO0lCOc5i4l5NcRPqBzqcC_bWHk_32R0cTIgv291VL1vhLfIbtEDMJvWLl9
    a1U2c5ZAbyVeya5LPE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehjedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
    ufgtsehttdertderredtnecuhfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoehlih
    hsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpeef
    heeliedugeeuleetffeuheegkeetgfdtveevudffgfejvdegveeljefhvdefhfenucffoh
    hmrghinhepghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:ZKT9YhsdRmmKHbwdWVW41fHo1YRsF3j0PcTOcrYK_7yVX5oT4NMgDg>
    <xmx:ZKT9YqYSyFR9kAGxqE3aoUB0fEEduwyOSuXVDUX-hOTRa_Kc0Y4D-w>
    <xmx:ZKT9YgbZPDtPPLSxT813cUhoR-BUOfEvWXpvEuAlDSN-HFsGh_Nihw>
    <xmx:ZKT9Yg7RA1k74RxvLAV1miJerXvznOwy6_EVd2GKBLuOU_5RgxxZNA>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1EE441700082; Wed, 17 Aug 2022 22:31:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <568465de-5c3b-4d94-a74b-5b83ce2f942f@www.fastmail.com>
In-Reply-To: <Yv2P0zyoVvz35w/m@T590>
References: <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <CAFj5m9+6Vj3NdSg_n3nw1icscY1qr9f9SOvkWYyqpEtFBb_-1g@mail.gmail.com>
 <b236ca6e-2e69-4faf-9c95-642339d04543@www.fastmail.com>
 <Yv0A6UhioH3rbi0E@T590>
 <f633c476-bdc9-40e2-a93f-29601979f833@www.fastmail.com>
 <Yv0KmT8UYos2/4SX@T590>
 <35f0d608-7448-4276-8922-19a23d8f9049@www.fastmail.com>
 <Yv2P0zyoVvz35w/m@T590>
Date:   Wed, 17 Aug 2022 22:30:39 -0400
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



On Wed, Aug 17, 2022, at 9:03 PM, Ming Lei wrote:
> On Wed, Aug 17, 2022 at 12:34:42PM -0400, Chris Murphy wrote:
>> 
>> 
>> On Wed, Aug 17, 2022, at 11:34 AM, Ming Lei wrote:
>> 
>> > From the 2nd log of blockdebugfs-all.txt, still not see any in-flight IO on
>> > request based block devices, but sda is _not_ included in this log, and
>> > only sdi, sdg and sdf are collected, is that expected?
>> 
>> While the problem was happening I did
>> 
>> cd /sys/kernel/debug/block
>> find . -type f -exec grep -aH . {} \;
>> 
>> The file has the nodes out of order, but I don't know enough about the interface to see if there are things that are missing, or what it means.
>> 
>> 
>> > BTW, all request based block devices should be observed in blk-mq debugfs.
>> 
>> /sys/kernel/debug/block contains
>> 
>> drwxr-xr-x.  2 root root 0 Aug 17 15:20 md0
>> drwxr-xr-x. 51 root root 0 Aug 17 15:20 sda
>> drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdb
>> drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdc
>> drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdd
>> drwxr-xr-x. 51 root root 0 Aug 17 15:20 sde
>> drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdf
>> drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdg
>> drwxr-xr-x. 51 root root 0 Aug 17 15:20 sdh
>> drwxr-xr-x.  4 root root 0 Aug 17 15:20 sdi
>> drwxr-xr-x.  2 root root 0 Aug 17 15:20 zram0
>
> OK, so lots of devices are missed in your log, and the following command
> is supposed to work for collecting log from all block device's debugfs:
>
> (cd /sys/kernel/debug/block/ && find . -type f -exec grep -aH . {} \;)

OK here it is:

https://drive.google.com/file/d/18nEOx2Ghsqx8uII6nzWpCFuYENHuQd-f/view?usp=sharing


-- 
Chris Murphy
