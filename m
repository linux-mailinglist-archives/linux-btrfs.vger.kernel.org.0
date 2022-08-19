Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A9D59A8A8
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Aug 2022 00:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbiHSWiY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 18:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239270AbiHSWiW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 18:38:22 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6CB2CDD8
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 15:38:21 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C3BFF32002F9;
        Fri, 19 Aug 2022 18:38:20 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Fri, 19 Aug 2022 18:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shamm.as; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1660948700; x=1661035100; bh=rq6RrsY01S
        gMUm6XwMnMU6xCgfoJMCwLI6nIYh/O3tI=; b=Z1dya6mnOB0kvu5TUagYyZ8QKd
        qdrP3nGVWE92ckL3XuUvFMnAbO692SO8ubuotJ3HUM6uCt2rscq3nF2aUhsXdAF2
        H+FNWzQANk0xyu5ZAyoRSHwr3nyT1GrXPNoEtAgzbSTtcuRVXrjez4JUAZyhRJjv
        p0cui7KDBBF6IZaNxac9RJlFGJ0Gxv5WD9H3+lCkbL+isi3xKU3NDnAr352maHoY
        vjCzK0dv/We7y35gJCCjgIt2/BpV2HvXKAaa8+Wcdlan/JTZB3Ty0YGOpfasPMO2
        MPJ6qbKgxUA8V1Z/iEgWg04EJ73h69/m8b9yWHvB6bfODY24zibdbu8Nb5Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660948700; x=1661035100; bh=rq6RrsY01SgMUm6XwMnMU6xCgfoJ
        MCwLI6nIYh/O3tI=; b=SJ2R9o6jI/wcXI6XcNbXRKBjheWcVEAPHr7gEGJlVtg4
        JlziQuv0ZZb9xGatNUvgAxxKAEiOzsFqIs8o0SEbF3473soZFZQFHc2HbNqNyGX/
        fKM3PoJQacbPHn4DBxWQofd/ujZV/GlS7iHSXbtjDSyyHi1qJ9bu0PLlkfO7ogme
        BbhnvZ15mZX+k222UFMs0HHrWmsdOA16lRvqcVXOY0eELBqifF79WTnrekLN9Tl1
        7GpKFraEqs9WlMgOaIW85yP5lDfsG92pCr4tkpCxH0EwIGMdzTKUWe++uHeeOPC5
        o51fE0CPNnuVIla92yAh9vkB4bb8JZC/n/XFsLOKcA==
X-ME-Sender: <xms:3BAAY1oBOkINlizVPCmfJpa17GGuU0E2ndAaFUS6f4UdITqJzvNpEA>
    <xme:3BAAY3qL1-JTCsYhlCUKEpjTCnVB7V07j5UtG-8hS5e0ensLTMUM-I-8DP5SFo5s9
    TmeCfjSvwROD2JEa4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeivddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfifgv
    ohhrghgvucfuhhgrmhhmrghsfdcuoegsthhrfhhssehshhgrmhhmrdgrsheqnecuggftrf
    grthhtvghrnhepgedvheeuffeitddvvddvhefhhfeujeehkeeluefgudegvefhkeeukeeu
    geefudeinecuffhomhgrihhnpegsthhrfhhsrdhithenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsthhrfhhssehshhgrmhhmrdgrsh
X-ME-Proxy: <xmx:3BAAYyNX7pTrR1jjmMaUexPD300ov5_jiDlne4kqjrdlGi0xbfR-Pw>
    <xmx:3BAAYw74635jIWcRW78il4_JlAXx1pTyfnwYTATX_41Rd2LcIVjLJg>
    <xmx:3BAAY072gBjPbaLyK7sTRNQw3Ltthj86xzJ_AaEq7WtSnhBHtkr0Ng>
    <xmx:3BAAY-RLXVGvKey2d-B-Z2ftwEucj0gC-19lcgdlyg3KczoUP604aw>
Feedback-ID: i1ac146fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 042ABC6008B; Fri, 19 Aug 2022 18:38:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <6b835970-07c9-4b8c-a686-57776f494db8@www.fastmail.com>
In-Reply-To: <1a102e00-144c-43c8-bb08-7bdb4072d056@www.fastmail.com>
References: <a3fc9d94-4539-429a-b10f-105aa1fd3cf3@www.fastmail.com>
 <87v8qokryt.fsf@vps.thesusis.net>
 <a6b0c534-4f05-4f60-a7fa-f33cfce990d7@www.fastmail.com>
 <1a102e00-144c-43c8-bb08-7bdb4072d056@www.fastmail.com>
Date:   Fri, 19 Aug 2022 18:37:46 -0400
From:   "George Shammas" <btrfs@shamm.as>
To:     "Chris Murphy" <lists@colorremedies.com>,
        "Phillip Susi" <phill@thesusis.net>
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: What exactly is BTRFS Raid 10?
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



On Fri, Aug 19, 2022, at 6:18 PM, Chris Murphy wrote:
> man mkfs.btrfs explains some of this. Minimum devices 2.

My first mail included a link the the man page of mkfs.btrfs. It is devoid of information of raid10 other than it is an option.

> And keep in mind all btrfs raid is at the chunk level. Not block device 
> level. So there's no such thing as a mirrored device, but rather 
> mirrored chunks (two copies of a block group on separate block devices).
>
> And yes, you can only lose one device with btrfs raid10. 

And this is exactly why I am asking this question. Given that 
- both raid1 and raid10 can only tolerate a single disk failure
- chucks are placed evenly across drives, effectively making files striped even if the chucks themselves are not striped. 

It seems that both "raid1" and "raid10" are functionally equivalent in btrfs. Or there is a nuance that I'm missing and is not documented. 

These gotchas are not obvious to me, even after 12 years of working with traditional raid setups. 

Perhaps raid1 does not require that chucks are placed evenly, allowing for hotspots? In which case raid10 is almost always preferable unless you have disks of unequal size?

There needs to be some authoritative text on the differences and pros/cons  btrfs raid1 and btrfs raid10, especially since raid5/6 are not recommended.

--George
