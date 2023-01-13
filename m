Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4896766A43A
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 21:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjAMUnT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Jan 2023 15:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjAMUnR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Jan 2023 15:43:17 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B03487925
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 12:43:16 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6BB705C00CB;
        Fri, 13 Jan 2023 15:43:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 13 Jan 2023 15:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1673642593; x=1673728993; bh=JA/2JvtqPr
        Ft7uSVbNJ6TOf8g8v74Z9Ve9JKBDfB1ag=; b=LtZ8jf0Yq4RJwAuiSo6bgVFMOJ
        ssKOspyEybVmL/3Bqps0597nsyGWSvxVaFHddG7aAs4HQocmy+s/W8rcavpU8Afx
        qXAue7l+qtcOGvLrydpbrVEevOAb+MYbI924uyCjyWjgkaiYdfxHrhOhPyUYRAoo
        a9DRm8vAVa2TQV3oA1Uf53oqWlba3JYQ/kN/2uQg7bJLOZs0NDqIszt0MAAbnGce
        hyUAtJUNGpLcHP9XUpWnPLSsA3lj6TRNwh44Qr3nl8+T4RGg6dYeu53sFK/Xddk4
        jvPULFTN03TufvWqt9B6ClPZtFoCa3omwdzh/2q0y26YIuE1hsm3LQa6OgeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673642593; x=1673728993; bh=JA/2JvtqPrFt7uSVbNJ6TOf8g8v7
        4Z9Ve9JKBDfB1ag=; b=gy38vxB8Ki/KqzsW79snA6wLhqv4XMK/8hLG4hjolAMf
        a17L3gMbtpg/fWWBCXGleHmvuVz0vtLTCauzlrxe/6dXTdiBep1NQu5ZtYsZIHop
        z2YRcDlL5umW5eoSi2JI01WER8O5HCorC5tYb2SippPB/8jJfqd8C45qX5sY0VVT
        A5mijttTh4Lh0ub2TbLaiW61UjXRcV4/J8c2h5MrfMwerKp0oaHv5QeeZzm04JnU
        ebiJmS8uaRpc+SlVjRT9u685Ws4uU+5AYMLPr298wn279N+2w86VyYsq8NYlvd8B
        /Q8QyOqpOUZMyitH70raAjKOoTU3LQOAV91sjz1BvQ==
X-ME-Sender: <xms:YcLBY1Q6LJ3bpmzhMoyf5w6c-WFnecCskZLG5bVnFvL5VyRvptYWsA>
    <xme:YcLBY-xpoo1iUe9NNQHFIWUwESX52adi7UJlEL8OxM2fryvr-DQJEZtNJ8KOgEADv
    cgzKX33XeNK5BXqTVg>
X-ME-Received: <xmr:YcLBY615QX4mKkshJR-8PeXjzFDmRv3Eby0tRKC4kKK_ps2j4y_0zmad>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleekgddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:YcLBY9CokQto3bKFMlSKBjBb8MU5B-jwjselL7pqHRHhQyraTY_1ZA>
    <xmx:YcLBY-iEswbj5X9kEsJI84fqKVBCliC8oMt4xaNum1n6arHqhrFNqQ>
    <xmx:YcLBYxqjnlo7gwJO_ACjlQJyw7ykRkMGqB6OcOYGztTvVLY0yP8InQ>
    <xmx:YcLBYyb-BqdeF3GEyCslxfR7GsGXQIFhMpyuxMMxRaikg9H5MJQt1Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jan 2023 15:43:12 -0500 (EST)
Date:   Fri, 13 Jan 2023 12:43:11 -0800
From:   Boris Burkov <boris@bur.io>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: hold block_group refcount during async discard
Message-ID: <Y8HCX0bDfPbvRg0G@zen>
References: <07df5461bf34cf138f2f4b281a6fa6a0b389ff68.1673568238.git.boris@bur.io>
 <20230113132625.GV11562@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113132625.GV11562@twin.jikos.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 13, 2023 at 02:26:25PM +0100, David Sterba wrote:
> On Thu, Jan 12, 2023 at 04:05:11PM -0800, Boris Burkov wrote:
> > Async discard does not acquire the block group reference count while it
> > holds a reference on the discard list. This is generally OK, as the
> > paths which destroy block groups tend to try to synchronize on
> > cancelling async discard work. However, relying on cancelling work
> > requires careful analysis to be sure it is safe from races with
> > unpinning scheduling more work.
> > 
> > While I am unable to find a race with unpinning in the current code for
> > either the unused bgs or relocation paths, I believe we have one in an
> > older version of auto relocation in a Meta internal build. This suggests
> > that this is in fact an error prone model, and could be fragile to
> > future changes to these bg deletion paths.
> 
> Which version is that? I'll add stable tag anyway but for a cross
> reference from a real deployment. Thanks.

I misunderstood the state of our branch. The code we were running has
Johannes's original patches for the reclaim worker and an internal only
patch that removes the pinned check. So I don't think there is any
commit in your tree which lacks the pinned check.
