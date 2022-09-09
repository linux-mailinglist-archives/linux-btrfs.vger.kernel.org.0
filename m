Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FE75B3CAF
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 18:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiIIQJS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 12:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiIIQJL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 12:09:11 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F5312F71E
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 09:09:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id EF206320096D;
        Fri,  9 Sep 2022 12:09:07 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Fri, 09 Sep 2022 12:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662739747; x=
        1662826147; bh=05Kn5n+qCRCVjdN0oQeeSMnrXImbnmeoGKRIi3Bhv8I=; b=F
        FT5khj5mYuRtSt+NQyoU3SteLQEz7AQ1qr60Fl/hgk+0EYvLzdQ9vmU9I6Oqlnwk
        vhW2PRDi1GyMjqkEM6QUulvT64acE5E8VvHedCvtx5X+bsRpdLRzypbOe+aclvRt
        FyUWspEVS1qaChwXOrhpdIBBbx9rUitijjSxy0h2+wUdkR6ho29MDB2r42xkYyhy
        WzBeHyMnyefIS9Ys3qKBaxgMgIkrG3Tyz4sGzQ28WLYtbznLuJG+9QvlWM/GPeRR
        jY4IQJycAI7cPh12EGNJUZR74CmLQa+i464XC+ZrHo+c8pBEsu/P/8ZQZoPVRHVV
        6M9HwQiPzyhiiAsNOBZvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662739747; x=1662826147; bh=05Kn5n+qCRCVjdN0oQeeSMnrXImb
        nmeoGKRIi3Bhv8I=; b=TZbVy7FRxHbCNdw5fHTBZ2XgCeqydqLw7yMcMsblfWbG
        AgXNIR16CFDAmWXG5Pzmqh+0hIQz//mciimMbFdCVEt4Rn/xFDwvt2FMY5OneTYA
        sxpHUJ+M6mrsPvskoi90LerfSLCX7GlOQ/JvblSBTK/ZzmYtD7hWLmTKBAeOoqUB
        jqtQTkjSgOc/3H/31ax8JZc+Al0QAnx0DjWPU5d9+Q7yHTNRPqQ7eTHRTWfje4Vu
        EXqfO06YAAIM1fOBSSj1shBjLQGsdsMnfcXk2CGpiyfQt7xGa0Hbnfu51k0b+IxW
        9XrnDWe2J1VVBxSwRZiDnYoy2rj7V7+Gj2k9pbRLMw==
X-ME-Sender: <xms:I2UbY8UlL3UtzgwV4AjnQ3PCtq0hVR3QdsUpaWKyLM5VdXgsrglT1w>
    <xme:I2UbYwkvlDCBKOkKE-SPp0wcjBXnULRn-qzqedQHjHmENcH_5Q-F0xim9Eg3kNjpq
    N49ihyUiVBIwIVQtlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedthedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdevhhhr
    ihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
    eqnecuggftrfgrthhtvghrnhepudehieevueetgffhkeetkeelveffueeltdejvdejveev
    vdeggfefhfegvddugeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:I2UbYwZ1BvPe56bXgFPuN6WOv-YJq6w_JuPFf_nKxstbRsVEl3ZpzA>
    <xmx:I2UbY7WjTqE3FLutiBae8J660EghBpiJWfD_P5f-TYpVwhMVn-8I6w>
    <xmx:I2UbY2kWsHLVszuG4yUrbGSCFit1TbNX2BsGsmYZ833ESa482wkf7g>
    <xmx:I2UbYwTaYR-dJLyMDitF6vW2CfyILBBRUpvdhGTOWUxEVM3Futk77A>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 25DDF1700083; Fri,  9 Sep 2022 12:09:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <fb1a03d1-0552-4ab4-a31b-958059c5e416@www.fastmail.com>
In-Reply-To: <c8fc0db5-dd3f-49f0-bf15-1c0232835078@www.fastmail.com>
References: <20220909000446.zzsniu7rc6tl6sz7@regina>
 <c8fc0db5-dd3f-49f0-bf15-1c0232835078@www.fastmail.com>
Date:   Fri, 09 Sep 2022 12:08:46 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "development.rex" <development.rex@posteo.net>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: Read only because of enospc
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



On Fri, Sep 9, 2022, at 8:30 AM, Chris Murphy wrote:
> On Thu, Sep 8, 2022, at 8:07 PM, development.rex@posteo.net wrote:
>> Linux my-pc 5.17.3-arch1-1 #1 SMP
>
> It's a recent kernel, but you might try 5.19 series. Although offhand 
> I'm not thinking of any fixes in 5.19, the main idea is to demonstrate 
> is still a bug. 
>
> Once the problem happens, could you collect these and post to the list? 
> It may give a developer some insight what's going wrong.
>
> btrfs fi us
> grep -r . /sys/fs/$fsuuid/allocation

Oops
/sys/fs/btrfs/$fsuuid/allocation

where $fsuuid is the UUID of the file system giving you trouble

-- 
Chris Murphy
