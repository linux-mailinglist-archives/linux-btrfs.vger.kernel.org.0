Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE63581BFC
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 00:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbiGZWLJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 18:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGZWLI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 18:11:08 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEEA63FA
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 15:11:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 197042B059CF;
        Tue, 26 Jul 2022 18:11:03 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Tue, 26 Jul 2022 18:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1658873462; x=
        1658877062; bh=Au/Kt9y05S7wczAYuEY0C0GCF7BjjFJGJ7VRB/aBw4s=; b=X
        slUpzR7bhtSkJWCtPHVOEzKoag16DYxtSjHk/AK/HS/KEvQuCDlmHv0it4UuD0D1
        Af6ehePqo6rIR2oR9VqDy8CbMmiDfWWZTymE/FTi+X+t3ZiewFxX0EOH0n45Zzyp
        thaUcLsM3wHHOrPl1rHbcNVydlEfdL1B4t2Lc9IN8ykY4wbMubF+yUCga2Yl8m7G
        YRg7FlLMowAmwFCGFIvWr516r6BucCBvvgKar4KXP/Gu6MfyhJwBZmAkSMwL6FUx
        myUhvXMlbLosY7Rjui4yzW9SCbp/AGkJmf8j+MyLxh9qGNMdQ6wx3WzqEyWLjjgt
        Iic7jgOjAf2+oQqcJy9bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i06494636.fm3; t=1658873462; x=1658877062; bh=Au/Kt9y05S7wczAYuE
        Y0C0GCF7BjjFJGJ7VRB/aBw4s=; b=Zgl3RFgYQbFwKc+nPNJcdPMhDj3IOGPkJu
        t3QikTuInAAcTDicAQHyOHkRV9N0l/3msKSbDKhQ5EsqN7xcXAJsmO/Ty80HekSP
        u5w37PaamMqeOkastn5MsCaThASMBJm/a3uD/fZKNdVVhpzKWkRT9hyfZscNW53M
        WXCknndgBLXwkvV9YH/uJefJQY+rQdf8TFbLpoG32oOY9Smfx7sE93smC3yk351M
        n7Lu5ct9noWMqoy7OqyeenSRqmUY2Gkrh9U+xknX22sQWh55VviNt34mYpA6/XOw
        EumX8zZak0CL44eIl5MSNgJtWXGXHGKy/UljXYAGayyvPiVfHvOA==
X-ME-Sender: <xms:dmbgYkxo1d5DfJeop1KC6xLW-JEALKeh0gWBoV4TZaR6jj-Fj3T5Eg>
    <xme:dmbgYoTMl_J1DSYrkfW0-zD7hBiUI6mWS6a5FLuNMyLevzL7Y0i2eNS4N6NAsLaZz
    m3Q5d_Cebr796yBKrI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduuddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefgvdeukedtfefgfefgtdelffdvieeltefgfedutdff
    leeuieevieevkeehtdehueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:dmbgYmUEcaVAWsYoX31qYHgldg-DAHgSHKAia09ogUq6xTLu4BRjTQ>
    <xmx:dmbgYigJEePrFwC9tvSGD2iMPl-jGL7VlpbkMOlL9V4lSpE6O6PRzg>
    <xmx:dmbgYmCanllMWP9U40sqEkGmcWIlZHCYpEghSQKHdS-OemAluWFzYg>
    <xmx:dmbgYpOT_rvFHGIq4HAEvqL0prGLGOj-idr1wjI8NuDCrJn6qwSyYRG8xQDKKHNn>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1B1F6170007E; Tue, 26 Jul 2022 18:11:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-757-gc3ad9c75d3-fm-20220722.001-gc3ad9c75
Mime-Version: 1.0
Message-Id: <fb723544-1c98-4275-a8f0-a250937675d6@www.fastmail.com>
In-Reply-To: <20220726213628.GO13489@twin.jikos.cz>
References: <CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com>
 <20220725190811.GD13489@twin.jikos.cz>
 <336b3dc2-2ca9-4f14-ad45-1896b36e0e82@www.fastmail.com>
 <20220726213628.GO13489@twin.jikos.cz>
Date:   Tue, 26 Jul 2022 18:10:40 -0400
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



On Tue, Jul 26, 2022, at 5:36 PM, David Sterba wrote:
> On Tue, Jul 26, 2022 at 04:00:42PM -0400, Chris Murphy wrote:
>> 
>> 
>> On Mon, Jul 25, 2022, at 3:08 PM, David Sterba wrote:
>> 
>> > I think it's safe to use by default, with the usual question who could
>> > be affected by that negatively. The async triggers, timeouts and
>> > thresholds are preset conservatively and so far there have been no
>> > complaints.
>> >
>> > The tunables have been hidden under debug, but there are also some stats
>> > (like how many bytes could be discarded in the next round), so it would
>> > be good to also publish that when it's on by default.
>> 
>> In my testing, discard=async rather quickly submits recently freed
>> metadata blocks for gc, blocks referred by the backup roots in the
>> super. Is this a concern for recovery? Is there a way to exclude the
>> most recent ~5 generations of metadata from gc, and could it improve
>> the usefulness of backup roots for recovery?
>
> What is quickly here?

Seconds, less than a minute, all the blocks pointed to by backup roots are empty (zeros).

 The default timeout is set to 2 minutes and that's
> what I've seen when testing that on a fresh filesystem. 

Ok I'll retest with 5.19 series. The last time I tested time to drive gc backup rootswas circa 5.8.

There's some
> additional logic that's adaptive and derived from the latency increase
> caused by the discard, but this could be observed on some specific
> delete heavy workloads.
>
> There's no logic that would take into account generation so it could
> interfere with the backup root feature, but it's been unreliable already
> and there are no guarantees to keep the recently freed blocks unallocated.
> I've heared some feedback that the feature should be removed or
> improved, I'm personally in the "removed" camp.

I have no strong opinion. If it very rarely works, I'm less concerned. But if it can sometimes work a significant minority of the time, some folks occasionally benefit in a pretty significant way.

--
Chris Murphy
