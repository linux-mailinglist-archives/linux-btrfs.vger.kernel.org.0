Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F83582962
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 17:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiG0PPC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 11:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiG0PPB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 11:15:01 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF2C3AB0A
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 08:15:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D26BB580551;
        Wed, 27 Jul 2022 11:14:59 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 27 Jul 2022 11:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1658934899; x=
        1658938499; bh=liE+JNujHIJmmCmWvM00WMBxPIZiGbftD/KMSIZXiys=; b=q
        8Xp0ihINAHCrtmv9DkUqihKHdlZ47qOn4ko0qXfeiHF/rpyIKRM/jm4da0aueO9R
        GPbueh3+C4sT/ZzvmD/TCX2lXySGm43vP5MfWHRvo8/Y8haSRrfQ0JO/TZwzVGcx
        yJYzxKneueavdLIDx31b+9ma0J5hezcpfwzpcxoS9WgB3m2Yro4EKo2N4AILp0aa
        uQf0g/pXDiGWCUI9yRp81W1PRyEgn9kp87J6Z7VoHhG9fyrM62T7jF9bMCRRud/j
        vWD0gobnXnOSbq5TKcrcbllAltGR51QshTvwj8kwFuqA5qVququwlfbAQ41sgcf6
        +ncLlgVbqQYyaq+VslfEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658934899; x=1658938499; bh=liE+JNujHIJmmCmWvM00WMBxPIZi
        GbftD/KMSIZXiys=; b=qdZ1ID6P4tExfrp5afpVRqoZutZu+Sy1015oobflauQV
        M5PvDB8ITxuYOcPky13M2qsFyUHqkHw4Cz5iQY7VUjSi7KjPXRT86ADmu9oSJKPx
        DNKc9zdFPDwkgd3+klZUHCuhBv0TxaTlJYpWWDSi3IDPjNpsABXhfQyNjrlIEbHZ
        LRHACdHI2GmmQxctge7Guo0/yv99eaiEGzKcta44pxs/ioCM9YWKRm5Xht4l+rar
        VeCso23Wdy9UEr9oyjLmic7oEGKX4UVxKCaBJAmhuEUFd1zepJhf/dn5iYFeEYVI
        eJ7oYparcDu+SN04oRd/QknqfZCF0PdS73d51mD/QA==
X-ME-Sender: <xms:c1bhYlKEQxcMdAgJ-tmHftmpeANGkJjuRkDgy5Wi2pa70j7Gf0yNqg>
    <xme:c1bhYhIfL_Acgat-szg-EOx7IqbH09SjYA9zMnV_EzICTyKyAshrSwJ--yABUWwuK
    2qNxQQKufLxRhTl-VQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduvddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefgvdeukedtfefgfefgtdelffdvieeltefgfedutdff
    leeuieevieevkeehtdehueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:c1bhYtu-8tGMTsZBnyN3B437ezePvdB-n74SdkmkU9YhFr2BQSY4FA>
    <xmx:c1bhYmZxm5wPHAQajXwjNK1JqBZLFN1mhMkRlj8qsm45jL87Rgw_1g>
    <xmx:c1bhYsawXJAPdU7gBR2raSXGcqYq8qv3nxFy-Jrp1_JLXF8m02O4Tg>
    <xmx:c1bhYrnQJnFpTHPZWSJuMzlXOHSAfq2sBrAXOA3oJtRC3ZdDm0a6Pbm0EXk>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0C095170007E; Wed, 27 Jul 2022 11:14:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-757-gc3ad9c75d3-fm-20220722.001-gc3ad9c75
Mime-Version: 1.0
Message-Id: <f14ed453-390b-4537-8a8c-0600e08d4278@www.fastmail.com>
In-Reply-To: <20220727145640.GS13489@suse.cz>
References: <CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com>
 <20220725190811.GD13489@twin.jikos.cz>
 <336b3dc2-2ca9-4f14-ad45-1896b36e0e82@www.fastmail.com>
 <20220726213628.GO13489@twin.jikos.cz>
 <fb723544-1c98-4275-a8f0-a250937675d6@www.fastmail.com>
 <68dc27f3-32a8-4a2a-bfcc-0cf26bca8fec@www.fastmail.com>
 <20220727145640.GS13489@suse.cz>
Date:   Wed, 27 Jul 2022 11:14:01 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "David Sterba" <dsterba@suse.cz>
Cc:     "Neal Gompa" <ngompa13@gmail.com>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>,
        "Chris Mason" <clm@fb.com>, "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: Using async discard by default with SSDs?
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Wed, Jul 27, 2022, at 10:56 AM, David Sterba wrote:
> On Wed, Jul 27, 2022 at 10:50:01AM -0400, Chris Murphy wrote:
>> What is a likely target kernel version to make discard=async the
>> default? The merge window for 5.20 closes August 14. Is 5.21 a
>> practical target?
>
> The changes for the next merge window are supposed to be done a week or
> two before it opens, but as this is a simple change I think I can
> squeeze it in.

For 5.20?

I'm not aware of any conflict with fstrim. But I wonder if there's a preference to coordinate the change with util-linux folks? 

Currently, util-linux provides fstrim.timer which runs fstrim.service every Monday at 00:00 local time. The command is:

ExecStart=/usr/sbin/fstrim --listed-in /etc/fstab:/proc/self/mountinfo --verbose --quiet-unsupported

I'm not sure how they'd go about implementing an exception for Btrfs, either entirely or only if a discard mount option is detected. But I can ask?

-- 
Chris Murphy
