Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06AC583ED3
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jul 2022 14:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiG1M16 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jul 2022 08:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238354AbiG1M15 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jul 2022 08:27:57 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA00691CB
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jul 2022 05:27:54 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 37E062B05E41;
        Thu, 28 Jul 2022 08:27:52 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 28 Jul 2022 08:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1659011271; x=
        1659014871; bh=NqCwTXOfjw/LaR1N0/9YdNzBkR573MWYzgLtmPMsXc0=; b=A
        HeXZaGrnn7vKQuBvaH+jLLjxAa2Lg9uv16oxDawCtSUrPyx+XJ93rUYcJ0pZ6qhL
        ssP2+7Wcld6g81vcxKGuLDjSPBPSN0Sjmsr/BDHSE3k662ToyYKrInPZH+sFXrka
        omOBPDB/Rn3pWQRWsldifEqjBCOWyyUYzkdB98dzWnB7BAX0wq4e42zNFVhxSInc
        7WMhR7DnoJgQzCeT3D8UKugJo1HFMJL62UhssXDeSKHlOAa9/sCxC0Bqb67MiWbA
        2o2YxfbEy0UxKgIxIULuW5BNB/xSzWh7Klmjnb6Dr3v7MZmuEgQ+J7QoyNoMiSeN
        ysCKfkRykztm+YCJlA65A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659011271; x=1659014871; bh=NqCwTXOfjw/LaR1N0/9YdNzBkR57
        3MWYzgLtmPMsXc0=; b=2cVKUrcwGxaLA1eTaTPyLgWohnG7XTWlzzic830WdSLc
        v+HU3V45U3+Khdf1gnhM2GP4eHcxcoBA8peix1kEyu3NYNVvrvhN/7CJdIoAbZiY
        ESarU0cWGUOk4JOAGwhDPHocCT1b8FBB+tNXMy2WPuCBM6r/e/nXVcVeL5IIHBgZ
        sL0WGs5TovmyXVluQ9XLRJrfHhbF0pdRRCUQue8usfWRqsdH4MsUG1e0vRvWDwf3
        xKA8rovvtWiUAAe08k4SUhbDk7MsT+NYS+fQppu/lTD9WUEFCGFPc6VT8EPO6alL
        KqLILSr4SRe6C9vjKZbcpmeiQYlcH2+3zEtKX4JGmA==
X-ME-Sender: <xms:x4DiYrr7xk3hJLuaN8g4lfS6J08nMF2q6rA6Yq9HN9LcQdvlBABneQ>
    <xme:x4DiYlpmUIcQhLI92OqNIj4L15h3ItaHxoUBmjd9KMzQCvatWgdx64yw1pojCnwdM
    7h4Is-jA5zG75pNQzE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddugedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefgvdeukedtfefgfefgtdelffdvieeltefgfedutdff
    leeuieevieevkeehtdehueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:x4DiYoPIiDcw1C57vvwftpcw7-TRbO-S1cqfBEo3D75pprvmO4Cstg>
    <xmx:x4DiYu59CkHEar6rLl65kfy_ElU_rU8I5jQzgJY19dlQBZF6SYRIkw>
    <xmx:x4DiYq42R9bw9_cGLFKAP5mBQI3ITgAJ3BfLxUoRr02PVOAweptzLw>
    <xmx:x4DiYqErFZAM6ixuVVni_HoA4ns76dDD-dkpv00dlcD7xeBbUrx3M3t44fQ3_f0h>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4B0A2170007E; Thu, 28 Jul 2022 08:27:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-757-gc3ad9c75d3-fm-20220722.001-gc3ad9c75
Mime-Version: 1.0
Message-Id: <9b7dd86d-26ee-41a9-b016-163aedcd0609@www.fastmail.com>
In-Reply-To: <20220727174726.GU13489@suse.cz>
References: <CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com>
 <20220725190811.GD13489@twin.jikos.cz>
 <336b3dc2-2ca9-4f14-ad45-1896b36e0e82@www.fastmail.com>
 <20220726213628.GO13489@twin.jikos.cz>
 <fb723544-1c98-4275-a8f0-a250937675d6@www.fastmail.com>
 <68dc27f3-32a8-4a2a-bfcc-0cf26bca8fec@www.fastmail.com>
 <20220727145640.GS13489@suse.cz>
 <f14ed453-390b-4537-8a8c-0600e08d4278@www.fastmail.com>
 <20220727174726.GU13489@suse.cz>
Date:   Thu, 28 Jul 2022 08:27:29 -0400
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



On Wed, Jul 27, 2022, at 1:47 PM, David Sterba wrote:
> On Wed, Jul 27, 2022 at 11:14:01AM -0400, Chris Murphy wrote:
>> 
>> 
>> On Wed, Jul 27, 2022, at 10:56 AM, David Sterba wrote:
>> > On Wed, Jul 27, 2022 at 10:50:01AM -0400, Chris Murphy wrote:
>
>> > The changes for the next merge window are supposed to be done a week or
>> > two before it opens, but as this is a simple change I think I can
>> > squeeze it in.
>> 
>> For 5.20?
>
> Yes, 5.20.

Well I'll let Josef and Chris arm wrestle over who sends you a patch when they can get ahold of some round tuits. Once it's merged in 5.20, sounds easily backported for Fedora to carry a patch for 5.19.

-- 
Chris Murphy
