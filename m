Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC42577076D
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Aug 2023 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjHDSCR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Aug 2023 14:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHDSCR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Aug 2023 14:02:17 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EF546B2
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Aug 2023 11:02:15 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A2028320093E;
        Fri,  4 Aug 2023 14:02:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 04 Aug 2023 14:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1691172132; x=1691258532; bh=Rj
        UnQ+H6YkTWc4LUQozstqIYgW33J66At1wviRPsu30=; b=jQMsbkg7dxBrxTWIiE
        8LRJk/9JUyZ+HL+S7mgbQhpIRxdvsM9sg80riYX+7/xXIHhueu3KT86WdjjgaBop
        JEIIW/MZiSnpsYbPWdeSUaNoAUtD4cEo1SrPdn9I2hJ4ueVbEvu4BVXBZG3BRnCG
        fZ7IxDhDaRuSjhsiX1kfuMUkJdEKNGYXh9TTT4KkoyTMpVDy5kJc9gF5bEMiwGqK
        96TTeuUY9LkWSSYcu+ZzN296//iqSPjK7qMmNAuItl+U/qMZsSjGQiyVabKwIItN
        b3AXMyE5DyR0tibCwrS74GIzORYkSi8j7IgoN2nTez+1V/vP3Sxl/NZpSdr3t/fk
        C+XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691172132; x=1691258532; bh=RjUnQ+H6YkTWc
        4LUQozstqIYgW33J66At1wviRPsu30=; b=sXHb3sLvf6mNzGTnRHkYVDobaKnTU
        cqcYk39n60cMKoSUSJaDWJW738pMrYNEDvOiaDOWvG8fHYemI4hF3vOXUxkViYOP
        l6Ng+RaZX26AXijl3L5aQqSCmSOY+Amkn9PnOWGE4XwjQARkyFPc3TJMbmv2ayJe
        meA4WbBHULelht4yfT7AydzFI0o1HKjOPxAM9mL04ROlZiiUPxg5GB/BFBHPn4s+
        eLEznqm7q5mF3M+ZACRGFV9Q5toxL26CiZuR6nbZzIHWXPb1w4cxvNMbYQDubM+L
        Yrn/mHgf9GCWSiVxKqiwoIZ1VIoAWPUSdZkOxVRv5woBLWxy7OhZ2coLQ==
X-ME-Sender: <xms:Iz3NZJoaaBhZiuITV_mkocP5O8qICOV3mjXM5nIJtujVP5_73q8tfQ>
    <xme:Iz3NZLrLJ0Y5VvKGkBpEFDj1gz3ojDdA8Ibr9rdnotoDJRrpR2ZaGFJDCRr_dT9mP
    h3SolDjJ1y1fi5eh9s>
X-ME-Received: <xmr:Iz3NZGMy07KRHU04Ql98TnqYcaighVruIRNXCXhOeG6dlR8PscBI0DQ8YjXwL0FcCeIm5G2lzrdnG-B4LJjvpqQI4Ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeeggdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    elffegveegteeugeeltdeuledutddukeehhfduueehgeefveeiheetveeijeeuteenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Iz3NZE7SWHUdcx7GuOqtp_5u3O-62lobFEenJnB7rOMK1NH4adWSIA>
    <xmx:Iz3NZI5j74O5BjPiIZs5fRLlzL_m8q7H7yoyhjocmcYUsR2j8Ko2lw>
    <xmx:Iz3NZMiTLaxANlgqCAS7F1c9PCb1g8imUCEjxL1PZZjBhpLP5fUCPQ>
    <xmx:JD3NZGSZrj1heqKgv-71w7ZMDiRxqz5fynPP1WijTNmF_lIACGPnzg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Aug 2023 14:02:11 -0400 (EDT)
Date:   Fri, 4 Aug 2023 11:00:18 -0700
From:   Boris Burkov <boris@bur.io>
To:     Nicholas D Steeves <nsteeves@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: permanently wedged in filesystem, fs/btrfs/relocation.c:1937
 prepare_to_merge
Message-ID: <20230804180018.GA3699656@zen>
References: <a44b85f5-01b5-40d5-a067-883d9223366a@app.fastmail.com>
 <20230803211258.GA3669918@zen>
 <87fs4ztxbd.fsf@digitalMercury.freeddns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs4ztxbd.fsf@digitalMercury.freeddns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 03, 2023 at 09:23:34PM -0400, Nicholas D Steeves wrote:
> Boris Burkov <boris@bur.io> writes:
> 
> > On Thu, Jul 20, 2023 at 09:42:37AM -0400, Chris Murphy wrote:
> >
> > The btrfs allocator is far from perfect and despite a few measures that
> > attempt to prevent fragmentation, it can still happen. If you have a
> > system that reproduces this, you can consider using the scripts I wrote
> > here: https://github.com/josefbacik/fsperf/tree/master/src/frag to dump
> > the fragmentation level of the FS (and even visualize it) to confirm my
> > hypothesis. I'm happy to help you get that up and running.
> >
> > Now let's suppose you do have a workload that challenges our allocator,
> > fragments the data block groups, and chews through all the unallocated
> > space. We have a lot of those at Meta, so luckily, there is some relief
> > available.
> >
> > Fundamentally the remediation is to defragment the disk, which we do
> > do with data block group balancing. You can invoke this manually with:
> > `btrfs balance start -d<thresh> <fs>`
> > where <thresh> is a percentage fullness of data block_groups to target
> > with balancing. Lower is more conservative so you can start low and
> > increase it to 80 or so till you reclaim enough space. If you use that,
> > it's better to do it proactively periodically rather than after you get
> > stuck, 'cause as you saw, balances start failing with ENOSPC too.
> > (see point 2. above :))
> 
> Would it be useful to use fsperf's frag (module?) in combination with
> the required btrd to periodically assess the state of fragmentation?
> What are the downsides of doing this?

I think this is probably overkill, compared to experimenting with
auto-relocation and monitoring relocation/IO. Btrd is designed to run on
a mounted filesystem and uses the SEARCH_V2 ioctl so it should be "fine"
to use, but the script walks the entire extent tree so on a large file
system it will be slow and use lots of memory (it ooms on my test vms
when I'm not careful..)

I wrote this as a helper for testing out allocator changes targeting
fragmentation. fsperf is our perf testbed, so it runs some workload and
then when it's done on a basically inactive test fs, it runs the script.

I would say that it is unsupported for serious production use, and I
wouldn't use it in that way, but it doesn't use any insane features and
shouldn't crash your system besides normal resource hogging type issues.

I don't have concrete plans for btrfs to track block_group fragmentation
directly (haven't figured out if I can do it efficiently) but it would
be an interesting project for the future.

> 
> I'm specifically interested in minimising the risk of "everything was
> fine until the fs blew up", and it seems like running this test
> periodically would provide useful data that would inform the sysadmin
> about whether the risk of rewriting data at rest with a rebalance is
> less than the risk of encountering issues triggered by the less than
> perfect allocator.
> 
> Because it sounds like there still exist workloads that necessitate
> periodic rebalancing, sysadmins need a way to determine the degree of
> need for rebalancing in order to define a mitigation policy in a
> fact-based way.
> 
> Is fsperf the correct tool for this general case, or should we be using
> something else?

We monitor "unallocated" via btrfs filesystem usage. Unallocated
trending down while data usage % is relatively low is a good sign of
fragmentation and data over-allocation where balance would help.

> 
> 
> Thanks!
> Nicholas
> 
> P.S. Please CC me in replies.
