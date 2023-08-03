Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D351876F06A
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 19:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjHCRNs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 13:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbjHCRNl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 13:13:41 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745FA3C2F
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 10:13:39 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C6E585C009E;
        Thu,  3 Aug 2023 13:13:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 03 Aug 2023 13:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1691082817; x=1691169217; bh=bh
        FJyFn18uItQIOhKzQ6vtDvE9UAGOUfbycg9twPktU=; b=PriLpAZC1ZxpUzXQUu
        WAtpnNn5LakmQx7Kwt1QaLxQtNjeMzVUVmbS/kFn4XJ9MjTLH1eWDBYeB47o8OJp
        90OF3r0hTobbUeTSGS+oS6AfX11eTP4CxPpl3YeN1ip8OvvT8kyd0mS7VIz/+tb4
        Pur3xSlVEOzZEg6Cjq14yUuafHMe99NEAkYg1kcDevBqXgfCj+w1HYpHGXlQ8U7w
        NS4lfEjo37zJqL5pjkusv4pH1fwguObf5K0ni3ZKBYBwDCNxUmKXZC3TbrYpeqzO
        BwGunONakKuRziV+bZUJLqpjpfMjVHONd6gGfva5mNeRZGhTj7/SuVhXRjZEEinJ
        8sJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691082817; x=1691169217; bh=bhFJyFn18uItQ
        IOhKzQ6vtDvE9UAGOUfbycg9twPktU=; b=C7HHcIKD7VYjVHYC04CbPewMGEucB
        D2Ns7xwF8g28ZCJS8/3Oq5MB0TAV4FAU6NYkB87KcMuQoQzBiSld/6JqJmOqM+q9
        xum/LGeREQ22/RtMOJMjeIW6l0bOhsHZliTSrARAr7vZLMhdbf1y7tcQtK/p5n2/
        W1Ypez8RIGAylkJRmr9dMvz/JBZu4KojXg9aZXIGaAgumEAvWAwYZAP7fscp6+LC
        bYqCpk5JH+7xD5wROT+khxP9gN4QkfnavJ8b3riYaMhPMLveqJXHaS9sVAZtz4Fl
        0JQFq9wq9uiKBV+gafnGT1tIWaWc5LDbk5VCeZEV7S3prJq7CVdba4h6g==
X-ME-Sender: <xms:QODLZItwcH--udbrpDs8OiM17b47hpOuE1gPkdmu-MHBh9ReRj0x4A>
    <xme:QODLZFfpFtoC_qGmka9ycvwPGuXSR0gZCHSLT66OgzVd6gvwh_LKEVT-RVKMDqd3I
    duDP2JFn7GDYEvhhnU>
X-ME-Received: <xmr:QODLZDzc-fZo32q1e6DTKnG8_IjzaeBjFJS64T0PGqByu8Z8mvhw5z9KmLSMmaVJwNOzzw7cqo4I3gMuLsOCxw-H4Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedvgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:QeDLZLMZdPjqazE-QgmW_e7u2zGsKbXuy53x6a-t6CSDztfbeNKPag>
    <xmx:QeDLZI-HzT8xIkURNGNUAzeQ-20wgbu3yzcvCojyCn-WP1QQM1Godw>
    <xmx:QeDLZDXOB03NvX9krYkzqzqlBiJQHZ9Y42grWEgtlCKW3A8RTfG2EQ>
    <xmx:QeDLZMZW5m3a6_NWHJ0i3XsKgsMAFgPKvj-U1slsbx5IdV-sw1AZGA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Aug 2023 13:13:36 -0400 (EDT)
Date:   Thu, 3 Aug 2023 10:11:45 -0700
From:   Boris Burkov <boris@bur.io>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: small writeback fixes v2
Message-ID: <20230803171145.GE1934467@zen>
References: <20230724132701.816771-1-hch@lst.de>
 <20230727170622.GH17922@twin.jikos.cz>
 <20230801152911.GA12035@lst.de>
 <20230802124956.GA2070826@perftesting>
 <20230802151643.GA2229@lst.de>
 <20230802153527.GA2118368@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802153527.GA2118368@perftesting>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 02, 2023 at 11:35:27AM -0400, Josef Bacik wrote:
> On Wed, Aug 02, 2023 at 05:16:43PM +0200, Christoph Hellwig wrote:
> > On Wed, Aug 02, 2023 at 08:49:56AM -0400, Josef Bacik wrote:
> > > I ran this through the CI
> > 
> > Thanks a lot!
> > 
> > > [ 3461.147888] assertion failed: block_group->io_ctl.inode == NULL, in
> > > fs/btrfs/block-group.c:4256
> > 
> > Hmm, this looks so unrelated that it leaves me puzzled.  How confident
> > are you that this is a new issue based on the overall test setup?
> > 
> 
> This is the first I've seen this, so it could be new to for-next, your stuff, or
> just simply haven't hit it in the ~20ish runs I've done with this new setup.
> I'm going to go back and test these other ones with just for-next, but I wanted
> to get the results to you in case they rang a bell or you wanted to debug
> locally.

FWIW, I did not hit the crash in 1000 runs with that same config on the
btrfs_writeback_fixes branch.

> 
> > > I also got an EBUSY trying to umount $SCRATCH_MNT with generic/475 with
> > 
> > > on an ARM machine with 64kib pagesize.  Though I'm pretty sure you're not to
> > > blame for that last failure.  Thanks,
> > 
> > Yes, I've seen EBUSY in 475 quite regulary even without the changes,
> > I think I also mentioned it in reply to the other 475-related discussion
> > we had.  I tried to debug it for a while but didn't manage to get far.
> > 
> 
> Yeah it definitely reproduces on for-next, I'm debugging this right now so don't
> worry about this thing.  Thanks,
> 
> Josef
