Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719A36DB77F
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Apr 2023 02:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjDHAIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Apr 2023 20:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDHAIe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Apr 2023 20:08:34 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AA511668
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Apr 2023 17:08:32 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 9812332008FE;
        Fri,  7 Apr 2023 20:08:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 07 Apr 2023 20:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680912509; x=1680998909; bh=Am
        JxJXnwzau2fCMbsbSa2BePjhcFADGPY0eJ3a1Tq0o=; b=s+JIka9FHdLsrKNCgj
        qOuqWAkqwdYziczz7UL1Qll4dEJvP+8GmvNUyrGcrWaM2ckqTLoy8+OTWnMQqqJf
        +Le1ADb7H6xMuq239YWt3J8xbfC9EIf/QfBF3I6grBDuD5zOd2q6dVyFKIO7ocAy
        huadg58vMAkZhfhqhcnivqnF26avAD6PDEMQmRjCs09wBPXG/Ha66nkMMLYNYMMK
        ua+fKSJG8Ho1Z2gmvytm+WlqNHim7DOe4zPE05MG2OThJM2WG2y6hAJW1QL7GSJ8
        d1oNf4DpQb1n0kDPan6jGFaAMKDDaEVIj1CdBZng5kGo+jvnq0Rr9gvTbN+484Pm
        0FVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680912509; x=1680998909; bh=AmJxJXnwzau2f
        CMbsbSa2BePjhcFADGPY0eJ3a1Tq0o=; b=VVTQVMKRH0kznZQ6qB/wpF+u8s3ug
        WyHfBlE2oPTqn+LblAv7Id/5DhH8FpvCi6/Nz1dssLRpbMaNvPSdIos3Z2BHHJ3Y
        f1zZVOr41IJn4SE7cv7Fl/sKnXJhiCAZ4Xy8ELOoPlZkBLpt0MJEok6Jy2YN4hbn
        sET33N5qDR4tw6rZzpeKZk2rOYxNN9B3btflxUwDJitQDPDtJpMURwl2Cs+0EwJs
        gkD9uYXKggtBageJOik0DwgZfJxR1eeZ8QaepfcblgJpUGgB9+V3OeU2YOfr/e4u
        6UoVtVP6rfmd6kTga0GPZfK58nvOaPEKD/m/oWg523lzNC728KUs/Q2wA==
X-ME-Sender: <xms:fLAwZEfR0PRb1ssdM5uKIZ0jVPQmr5Fj4lkGborP2nmcw5LTCmQKzg>
    <xme:fLAwZGMBWaDSA40gQrj9aJFu1B-CICp29rmSWJu-bvHl9REY4MGg2fNzNyVBEN4d3
    jmJumqQjpwRyQMANx8>
X-ME-Received: <xmr:fLAwZFjhyFX9lFxQIZUKgjGrlFT7OQqVqtDEDOatUcBQO-15L57NdZQp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehueejudevkeffgeeghfegteegueetiefhfeektdehgedtteelteffieeghedtvdenucff
    ohhmrghinheprhgvughhrghtrdgtohhmpdhkvghrnhgvlhdrohhrghdplhgvvghmhhhuih
    hsrdhinhhfohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:fLAwZJ9uAFOjLPBx39P6bK_igWvAb9CQXo8RJfM_KANTVJK-1mAOOA>
    <xmx:fLAwZAu4adMaj7xL3-M3RGkUzT2q75HuvHm63MM-o1vrVO4ld_tpAg>
    <xmx:fLAwZAHbZ7TgnGCu8M8c6nhEcFSCm1SREyeRIKz_0xgZ1vnvU-CQ4w>
    <xmx:fbAwZNUOFdGDUH1_tBVEVh4jzFdcwD5KO9M2l3g9dkthKkDMzgJczw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Apr 2023 20:08:28 -0400 (EDT)
Date:   Fri, 7 Apr 2023 17:08:17 -0700
From:   Boris Burkov <boris@bur.io>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     dsterba@suse.cz, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on
 ext4
Message-ID: <20230408000817.GA2450@zen>
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <1334e2af-b55f-3bb2-6e1a-6ab0b0ef93f0@leemhuis.info>
 <20230406154732.GV19619@twin.jikos.cz>
 <dbd7d712-0c46-7a18-d8fc-fc263f4de6e9@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd7d712-0c46-7a18-d8fc-fc263f4de6e9@leemhuis.info>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 07, 2023 at 08:10:24AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 06.04.23 17:47, David Sterba wrote:
> > On Wed, Apr 05, 2023 at 03:07:52PM +0200, Linux regression tracking #adding (Thorsten Leemhuis) wrote:
> >> [TLDR: I'm adding this report to the list of tracked Linux kernel
> >> regressions; the text you find below is based on a few templates
> >> paragraphs you might have encountered already in similar form.
> >> See link in footer if these mails annoy you.]
> >>
> >> On 15.02.23 21:04, Chris Murphy wrote:
> >>> Downstream bug report, reproducer test file, and gdb session transcript
> >>> https://bugzilla.redhat.com/show_bug.cgi?id=2169947
> >>>
> >>> I speculated that maybe it's similar to the issue we have with VM's when O_DIRECT is used, but it seems that's not the case here.
> >>
> >> To properly track this, let me add this report as well to the tracking
> >> (I already track another report not mentioned in the commit log of the
> >> proposed fix: https://bugzilla.kernel.org/show_bug.cgi?id=217042 )
> > 
> > There were several iterations of the fix and the final version is
> > actually 11 patches (below), and it does not apply cleanly to current
> > master because of other cleanups.
> > 
> > Given that it's fixing a corruption it should be merged and backported
> > (at least to 6.1), but we may need to rework it again and minimize/drop
> > the cleanups.
> > 
> > a8e793f97686 btrfs: add function to create and return an ordered extent
> > b85d0977f5be btrfs: pass flags as unsigned long to btrfs_add_ordered_extent
> > c5e9a883e7c8 btrfs: stash ordered extent in dio_data during iomap dio
> > d90af6fe39e6 btrfs: move ordered_extent internal sanity checks into btrfs_split_ordered_extent
> > 8d4f5839fe88 btrfs: simplify splitting logic in btrfs_extract_ordered_extent
> > 880c3efad384 btrfs: sink parameter len to btrfs_split_ordered_extent
> > 812f614a7ad7 btrfs: fold btrfs_clone_ordered_extent into btrfs_split_ordered_extent
> > 1334edcf5fa2 btrfs: simplify extent map splitting and rename split_zoned_em
> > 3e99488588fa btrfs: pass an ordered_extent to btrfs_extract_ordered_extent
> > df701737e7a6 btrfs: don't split NOCOW extent_maps in btrfs_extract_ordered_extent
> > 87606cb305ca btrfs: split partial dio bios before submit
> 
> David, many thx for the update; and thx Boris for all your work on this.
> 
> I kept a loose eye on this and noticed that fixing this turned out to be
> quite complicated and thus required quite a bit of time. Well, that's a
> bit unfortunate, but how it is sometimes, so nothing to worry about.
> Makes me wonder if "revert the culprit temporarily, to get this fixed
> quickly" was really properly evaluated in this case (if it was, sorry, I
> might have missed it or forgotten). But whatever, for this particular
> regression that's afaics not worth discussing anymore at this point.

In this case, the broken patch was also a serious fix for a deadlock,
so I worry it would be "out of the frying pan and into the fire." with
reverting it, so it never really entered my mind as an option.

I'll try to keep that option top of mind next time, though, as it did
take a while to iterate towards a (hopefully) successful fix.

Also thanks for linking that other report. I had no clue that someone
had already found the previous patch on 2/15. I wasn't sure of it till
the next day, when I finished root causing the bug, IIRC.

Thanks,
Boris

> 
> Again, thx to everyone involved helping to get this fixed.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> P.S.: let me use this opportunity to update the regzbot status
> 
> #regzbot fix: btrfs: split partial dio bios before submit
