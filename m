Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F556D6CA8
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 20:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbjDDSwB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 14:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbjDDSwA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 14:52:00 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0893A9C
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 11:51:59 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 866485C0160;
        Tue,  4 Apr 2023 14:51:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 04 Apr 2023 14:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680634318; x=1680720718; bh=XH
        8CmtZZzoQ/wnp/6pGPTI1QDwquHsh+XngeUlv2Bz4=; b=kxweGoCNqMsmX0K/45
        xf22oCMR+3ZiiZN8vRibmJUNG+OvtAc2n6pKs5JRdlGh81Brh7xLpOocrWmTX5Fj
        V4PVhefZpEAngHklxsRX4i4VEH+8ABUG/rauKj+ywpsXz5qbUwP/qy2kjvo8GkCP
        aa9RYxoidK1PTZCBQd669agC0UyQ0e9NjZh8/p4n4QcWYSYMwV8KpEp3HS7Ab5lz
        iy7oH1tTWoZZcR5OB38LiAT3whlGLcEZiB7cSr7ez2n9i0jInQpDIVEyDfJi88N2
        iVkvCMEPGIe8MUKB+kuHaUWW70jXbORmOQHjp8pXHtJdtjbvg7AYmZt6nYar7sgp
        E+0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680634318; x=1680720718; bh=XH8CmtZZzoQ/w
        np/6pGPTI1QDwquHsh+XngeUlv2Bz4=; b=Pl+wUc2nzsr6lqnQ8nkywZgMCV/OH
        hLAhjWvP0445x7xjJTGSa75AYHtEouF3U1KdHRmprzD10wGb3s04b+hC1Kfw6FiM
        zcQ4UAwtfnFfcTVidjXnc4lhYp2xDrnc5SiNqfJzNMc38dpsfBdMFDkjL3K91pXA
        LuUeJqK+kRCbLh22xwY45UML8zXKiI8ssa6CfDYuESyBlZsPyJTmKh8ApRQQ7Q5W
        GsLjDn2nKrq8d0u46jP3Ax7CX1yGfvjSnLbfzku+zopgdQvi3KuurmHlMZzan4xY
        Af0SDsvTBbRKrtVRPFEvhE2XggyDUhCEWqNZVWRbD9p5TgSWqSwcGFFHw==
X-ME-Sender: <xms:znEsZB2HNBjcCCUtmuVCkj2qW3jU30pei3Ef8vf7ViTBR4FkKuTAlA>
    <xme:znEsZIGxc3yHp4yA65jj-trgyadsHO2Ae3UJXBvsHYdpoSwwVIGne4vRzTFlYTz1I
    B_8uwAWAieTXzzlaD4>
X-ME-Received: <xmr:znEsZB7SCGfhyyUAVaRWHg2aQnYfgTHwAK1N7-zYLAR6nun9L7L_iYNm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    ephedthfevgffhtdevgffhlefhgfeuueegtdevudeiheeiheetleeghedvfeegfeegnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:znEsZO3WE8jeqfcV00m4NoQTd_EqVn3O2QF4FyQLaCgoqRNQgVKqTQ>
    <xmx:znEsZEE1S-j5NQhjcu9vUA4aSqROb0kTMyqmnHzTm3pxDJJ6wAxC_Q>
    <xmx:znEsZP-usHBWpXLyLM-VBYk39BnOBVDjCowMkQIz6APOLuER3RqtrQ>
    <xmx:znEsZCZ-KOgyS0Z-4v33Xw__wV4Qk8nNBazlnxUgOFJDw28_ln_COw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 14:51:57 -0400 (EDT)
Date:   Tue, 4 Apr 2023 11:51:51 -0700
From:   Boris Burkov <boris@bur.io>
To:     Chris Mason <clm@meta.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Sergei Trofimovich <slyich@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christopher Price <pricechrispy@gmail.com>,
        anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Message-ID: <20230404185138.GB344341@zen>
References: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
 <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
 <ZBq+ktWm2gZR/sgq@infradead.org>
 <20230323222606.20d10de2@nz>
 <20d85dc4-b6c2-dac1-fdc6-94e44b43692a@leemhuis.info>
 <ZCxKc5ZzP3Np71IC@infradead.org>
 <41141706-2685-1b32-8624-c895a3b219ea@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41141706-2685-1b32-8624-c895a3b219ea@meta.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 04, 2023 at 02:15:38PM -0400, Chris Mason wrote:
> On 4/4/23 12:04 PM, Christoph Hellwig wrote:
> > On Tue, Apr 04, 2023 at 12:49:40PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> >>>> And that jut NVMe, the still shipping SATA SSDs are another different
> >>>> story.  Not helped by the fact that we don't even support ranged
> >>>> discards for them in Linux.
> >>
> >> Thx for your comments Christoph. Quick question, just to be sure I
> >> understand things properly:
> >>
> >> I assume on some of those problematic devices these discard storms will
> >> lead to a performance regression?
> 
> I'm searching through the various threads, but I don't think I've seen
> the discard storm quantified?
> 
> Boris sent me this:
> https://lore.kernel.org/linux-btrfs/ZCxP%2Fll7YjPdb9Ou@infradead.org/T/#m65851e5b8b0caa5320d2b7e322805dd200686f01
> 
> Which seems to match the 10 discards per second setting?  We should be
> doing more of a dribble than a storm, so I'd like to understand if this
> is a separate bug that should be fixed.
> 
> > 
> > Probably.
> > 
> >> I also heard people saying these discard storms might reduce the life
> >> time of some devices - is that true?
> > 
> > Also very much possible.  There are various SSDs that treat a discard
> > as a write zeroes and always return zeroes from all discarded blocks.
> > If the discards are smaller than or not aligned to the internal erase
> > (super)blocks, this will actually cause additional writes.
> > 
> >> If the answer to at least one of these is "yes" I'd say we it might be
> >> best to revert 63a7cb130718 for now.
> > 
> > I don't think enabling it is a very a smart idea for most consumer
> > devices.
> 
> It seems like a good time to talk through a variations of discard usage
> in fb data centers.  We run a pretty wide variety of hardware from
> consumer grade ssds to enterprise ssds, and we've run these on
> ext4/btrfs/xfs.
> 
> (Christoph knows most of this already, so I'm only partially replying to
> him here)
> 
> First, there was synchronous discard.  These were pretty dark times
> because all three of our filesystems would build a batch of synchronous
> discards and then wait for them during filesystem commit.  There were
> long tail latencies across all of our workloads, and so workload owners
> would turn off discard and declare victory over terrible latencies.
> 
> Of course this predictably ends up with GC on the drives leading to
> terrible latencies because we weren't discarding anymore, and nightly
> trims are the obvious answer.  Different workloads would gyrate through
> the variations and the only consistent result was unhappiness.
> 
> Some places in the fleet still do this, and it can be a pretty simple
> tradeoff between the IO impacts of full drive trims vs the latency
> impact of built up GC vs over-provisioning.  It works for consistent
> workloads, but honestly there aren't many of those.
> 
> Along the way both btrfs and xfs have grown variations of async discard.
>  The XFS one (sorry if I'm out of date here), didn't include any kind of
> rate limiting, so if you were bulk deleting a lot of data, XFS would
> effectively queue up so many discards that it actually saturated the
> device for a long time, starving reads and writes.  If your workload did
> a constant stream of allocation and deletion, the async discards would
> just saturate the drive forever.
> 
> The workloads that care about latencies on XFS ended up going back to
> synchronous discards, and they do a slow-rm hack that nibbles away at
> the ends of files with periodic fsyncs mixed in until the file is zero
> length.  They love this and it makes me cry.
> 
> The btrfs async discard feature was meant to address both of these
> cases.  The primary features:
> 
> - Get rid of the transaction commit latency
> - Enable allocations to steal from discards, reducing discard IO
> - Avoid saturating the devices with discards by metering them out
> 
> Christoph mentions that modern enterprise drives are much better at
> discarding, and we see this in production too.  But, we still have
> workloads that switched from XFS to Btrfs because the async discard
> feature did a better job of reducing drive write-amp and latencies.
> 
> So, honestly from my POV the async discard is best suited to consumer
> devices.  Our defaults are probably wrong because no matter what you
> choose there's a drive out there that makes it look bad.  Also, laptops
> probably don't want the slow dribble.
> 
> I know Boris has some ideas on how to make the defaults better, so I'll
> let him chime in there.
> 
> -chris
>

Our reasonable options, as I see them:
- back to nodiscard, rely on periodic trims from the OS.
- leave low iops_limit, drives stay busy unexpectedly long, conclude that
  that's OK, and communicate the tuning/measurement options better.
- set a high iops_limit (e.g. 1000) drives will get back to idle faster.
- change an unset iops_limit to mean truly unlimited async discard, set
  that as the default, and anyone who cares to meter it can set an
  iops_limit.

The regression here is in drive idle time due to modest discard getting
metered out over minutes rather than dealt with relatively quickly. So
I would favor the unlimited async discard mode and will send a patch to
that effect which we can discuss.

IMO, the periodic discard cron screwing up your box once a week or once
a day or whatever is a pretty bad user experience as well, as is randomly
hitting bad latencies because you haven't been discarding often enough.

Boris
