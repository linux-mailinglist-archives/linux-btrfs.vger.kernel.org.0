Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A205609E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 21:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiF2TEt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 15:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiF2TEs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 15:04:48 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061D01EEF5
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 12:04:47 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 55346320094E;
        Wed, 29 Jun 2022 15:04:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 29 Jun 2022 15:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1656529483; x=1656615883; bh=wK4FYQaV8o
        XoGE9hLLjPOnyA/IT06Jb/DP8kRDXw3Zg=; b=gmAFK/VkUNrDAycR3jr0zPz9VF
        n39X9d7UhTDdWoJhlVDEOyHgo//sR4WLmvBYd1PZNdTmO7XnMI7/FusU/RXDnqxu
        CsYuPe5kwZfpf+4B/evliH3uCI2wE5Bq/wOP5zm1OwVPz25AK95pOxQo3d9NyhgG
        UOJfxcFSXb5Us0baSHNyxedt68Soaof6W/umS54LDGBV3QxUubHLuQF70oegx+r/
        2rfr51ph3MSPgBJNtAXgmJQKgLPwNUwS33c4FOepzfGOHcYQXlcGAzIKiLt0mya4
        ScqX+yhVDGoJkywp7AutIHhXWJbUDnywH0Y4oFEZERvY7I3pWtAwp9bDuGvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656529483; x=1656615883; bh=wK4FYQaV8oXoGE9hLLjPOnyA/IT0
        6Jb/DP8kRDXw3Zg=; b=Zq75JRWuoPPBw2XyiHCh5VyZVIwsuXpgG+kD7o9NKFns
        hM/raVahDBeMvt26SSahh/l5MM8e6OugB/UFU/FK+LvbLuQV/qaIV+5AbvC+Mr83
        y3tAhb8LYrKMauH1cJRSXj4tF45w9Jn1XsQ6mqJ5L9IeRx7Uf2SAFpOQtiQ5Vn+a
        HOsbXUYfHXrVBHvJHtOnkFzVeQ0h1illVddsITYJWCeQM4AA55gzJgVB0tmQyX2H
        cL4AJLvHKH0YoQ70LnhQWU6T8y/+rH5TYUh2rBQgeNRFxTg0mE4TrEQDtCd6ZzFK
        rYwkpyp37lvDsgsQa25MrAx3I4JJFvrQrgZWk11uyA==
X-ME-Sender: <xms:S6K8YhEpgrRKtzEQmnz0cJziqZmOJetLRIfTOEKtjA47rqVLrGqpCg>
    <xme:S6K8YmXe8q0HgG4wYVunbcmEQK1DVjLW0L5vr2bfK5WPd0MdraVHcnXPU9OsnGqAv
    YfpZPq4IB0Gx3AKJe8>
X-ME-Received: <xmr:S6K8YjLHs9bDKswhYy2PsvP6uNhwK0B1G5zbHFyHs1zjlcbLAWLjkw8lDS_US-m-tyCve2HMOHEYtsDwIR7wEcZBer1tqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegledgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedugeejuddtvdduvdelkeegueduvddvffegheefudeuhffhhefgheekvedvtdelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:S6K8YnEofjIy-N5AxRjcGCRaLasP5VNito32MG5nYehd3r8OzuK5_w>
    <xmx:S6K8YnWCfFqwvNJETspJX0kSgMZN31kbVgA2VLYd-Iz43q35pfhZ-Q>
    <xmx:S6K8YiNG-56giC6Xztpz4XxkgiVie97joVwE2AKVMvGJKTHDTl075g>
    <xmx:S6K8YiQtq1QXQXTNBxvT6q_0VTWIoDSrj3eG8mYEn_EAyQgirsck8Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jun 2022 15:04:43 -0400 (EDT)
Date:   Wed, 29 Jun 2022 12:04:41 -0700
From:   Boris Burkov <boris@bur.io>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: fix read repair on compressed extents
Message-ID: <YryiSQcMbgOJbgqf@zen>
References: <20220623055338.3833616-1-hch@lst.de>
 <20220629084201.GA25725@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629084201.GA25725@lst.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 29, 2022 at 10:42:01AM +0200, Christoph Hellwig wrote:
> Any chance to get a review on this one?

Hi, I'm taking a look, and wanted to confirm my test procedure for
examining your patches is correct.

I applied this series and:
btrfs: repair all known bad mirrors
on top of for-next

and I applied
btrfs read repair: more tests
to my xfstests

Under that setup, the new btrfs/270 fails on step 4 checking if
the repair worked (the output looks all random rather than aa's)

Am I missing something?

Thanks,
Boris

> 
> On Thu, Jun 23, 2022 at 07:53:34AM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > while looking into the repair code I found that read repair of compressed
> > extents is current fundamentally broken, in that repair tries to write
> > the uncompressed data into a corrupted extent during a repair.  This is
> > demonstrated by the "btrfs: test read repair on a corrupted compressed
> > extent" test submitted to xfstests.
> > 
> > This series fixes that, but is a bit invaside as it requires both
> > refactoring of the compression code and changes to the repair code to
> > not look up the logic address on every repair attempt.  On the plus
> > side it removes a whole lot of code.
> > 
> > It is based on the for-next branch plus my "btrfs: repair all known bad
> > mirrors" patch.
> > 
> > Diffstat:
> >  compression.c |  287 ++++++++++++++++------------------------------------------
> >  compression.h |   11 --
> >  ctree.h       |    4 
> >  extent_io.c   |   93 +++++++-----------
> >  extent_io.h   |    9 -
> >  inode.c       |   34 +++---
> >  6 files changed, 148 insertions(+), 290 deletions(-)
> ---end quoted text---
