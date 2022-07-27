Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A955A5828FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 16:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiG0Ou1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 10:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbiG0OuZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 10:50:25 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AC933A19
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 07:50:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id E5C1A580457;
        Wed, 27 Jul 2022 10:50:21 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 27 Jul 2022 10:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1658933421; x=
        1658937021; bh=r+rbiVADTbAb9ADIG7wtCzU3eu5fVv94D3nnS3Tsz9Y=; b=S
        qaApFKZ3dCB7Fe2i06qFjERkPJ2p1W8ltAOgA/GahkzudHDlflb45fXoa8qiWGx5
        LVPhiJbJ2aEcpA4fLb+Q2ZIT/RhonLTo3dYJ0leeBaLo8VizZZMldFTHAPYhoqRq
        zRHskwhYhYAyVMt+seWNu9fzSDGnU+xg1IJP7dbf5a7LY57X8k0YcFqDWxaNKD+J
        SxouN0uWYU/B9v4F5aVfUWRjDunOS0DSLn0q5xhCNwtH29KrLgiLrgowVSSGOiXc
        3s/2i1+desJmcR2Lbm6jx0ZW1pXXGCS3fYoGwbw5es0dukHZFkD62MNJ97djSzVU
        kz1kNPS5cwHFu5vYSkBAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658933421; x=1658937021; bh=r+rbiVADTbAb9ADIG7wtCzU3eu5f
        Vv94D3nnS3Tsz9Y=; b=F9dACI5Dxo3C69FbtzMkKPGxfOo73j6/0P27OBJ+jkYz
        FIhVZZQ4WkG+8NM6RcJ0okQYRM+pMelwo6eVUTrcVIXpCcI27w3bB3wHq1EIvdIy
        9yK4gpK247yPi9/ixcg9jFnhlDie2+nBXJ89v0jGex7MuDwgUV2ilQOx0pLIIa3l
        B9Wz4ScQ5PUUt1NrGjbbE25xsH3apJ/oAb4twSNav6qJkEzhzMcObdg9+uaX3o5S
        Wseu776GwxARyqJ5mx9xEgVpnADSKybExKPBbeH/YVlZSDjgkhB7OXu3X+JTTHP5
        JFfQ3L4AChg6oMwRvuy92L2ZWBOrf1kUkueyKz+i4Q==
X-ME-Sender: <xms:rVDhYsVh3FczxM6a5SBXvTcEUeFUgArNPecfBhg15i02Be6r-7klew>
    <xme:rVDhYgm7PqgTF8m7YqdmsPjznZ-LK8_rojXgmbMKLNaBOc-SrUKjVi88SysrWDSEy
    O-xjqW3NZlNYp0gT_c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduvddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefgvdeukedtfefgfefgtdelffdvieeltefgfedutdff
    leeuieevieevkeehtdehueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:rVDhYgYRbDA1OM8JH3sps7sMy8kLmz1BJDTNCZQe1xJ9fV6xLTYQMg>
    <xmx:rVDhYrUPut8M9DdVGDPDScAeiccq0iOJC_w5ElPsuWLe5s2kwyHqnA>
    <xmx:rVDhYmkSdRm2XzJ_CsY0V4oU72sj_RhskVfWw3cHacL_CLB9XABUFA>
    <xmx:rVDhYryjfpsS1udpEk4ptGLC_u1HW4jLxIm6c6zfw1tf0ma5d4LhEBPZnFI>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 73DDC1700082; Wed, 27 Jul 2022 10:50:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-757-gc3ad9c75d3-fm-20220722.001-gc3ad9c75
Mime-Version: 1.0
Message-Id: <68dc27f3-32a8-4a2a-bfcc-0cf26bca8fec@www.fastmail.com>
In-Reply-To: <fb723544-1c98-4275-a8f0-a250937675d6@www.fastmail.com>
References: <CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com>
 <20220725190811.GD13489@twin.jikos.cz>
 <336b3dc2-2ca9-4f14-ad45-1896b36e0e82@www.fastmail.com>
 <20220726213628.GO13489@twin.jikos.cz>
 <fb723544-1c98-4275-a8f0-a250937675d6@www.fastmail.com>
Date:   Wed, 27 Jul 2022 10:50:01 -0400
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



On Tue, Jul 26, 2022, at 6:10 PM, Chris Murphy wrote:
> On Tue, Jul 26, 2022, at 5:36 PM, David Sterba wrote:

>> What is quickly here?
>
> Seconds, less than a minute, all the blocks pointed to by backup roots 
> are empty (zeros).
>
>  The default timeout is set to 2 minutes and that's
>> what I've seen when testing that on a fresh filesystem. 
>
> Ok I'll retest with 5.19 series. The last time I tested time to drive 
> gc backup rootswas circa 5.8.

With 5.19, backup roots remain available for a surprisingly long time, definitely more than 2 minutes. It's not an exhaustive test, just a dozen samples over a half hour, but I never once saw zeros returned. Two out of those dozen, I saw the block already overwritten with a leaf of a newer generation and a completely different owner (e.g. csum tree written at the block address for the backup tree root)  - which would make that backup root useless.

What is a likely target kernel version to make discard=async the default? The merge window for 5.20 closes August 14. Is 5.21 a practical target?

-- 
Chris Murphy
