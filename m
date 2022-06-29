Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86003560A6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jun 2022 21:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiF2Ti7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jun 2022 15:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiF2Ti6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jun 2022 15:38:58 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D1317AAE
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jun 2022 12:38:57 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id AA87A320034E;
        Wed, 29 Jun 2022 15:38:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 29 Jun 2022 15:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1656531534; x=1656617934; bh=W9NfRNJeU7
        w4VpcPyl8a2lBPBjXjiKfI4jmw/c/Tfbk=; b=hAsWv7kSaqOJzHC5noedH72Le2
        DOZrjhxj2rmRLmhmiL+vRlkjPzxzwwykInhnnla5494zBded2YBorVTt4RViLfPC
        rrwydLbTkricx409LOBsOuQks4Jsmb8tldwl6JOBI9aRiQ1HoEKExtBo+eqQLdZx
        ip1a3ixp/WgUMLLLvXz+MENwgdXTiDoWLfKXBTbxV9eE2BeSj2spOR5HJrurhZf7
        nb8VU44z99yVJJpwYDUHZloXqD7+M/i0FT55XVC32x41L8A6VUnXqjoWGbSjej+G
        K8lXanyXislzbGUpvZAD1plJU6pIDnSNvbxs5njWMS58ytA/5P1Q2VR4pa1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656531534; x=1656617934; bh=W9NfRNJeU7w4VpcPyl8a2lBPBjXj
        iKfI4jmw/c/Tfbk=; b=nHlq8SFvqy6EBCcLQBTYexOpTflc3GiB6evHiaI2Kkim
        H44bmg8zUewODO4ZiZP3z9vbP0cp94uEEF0MzgxzYTJtEytShjOj2Gm51W//0b+r
        VxNNe5eoTCPt2HsGYfXnZcoxB8nghPOloDWxqDXzIsoHc+mMRX5DJriEWJ0p2HB1
        7tYmcnxeTmOtT3+neLIyi1aV+ikNiLFInT7bOPDZIWJGt3eYKl5VqRGowwHY+JII
        bHVX67PoKZcu4fZbFBaxdqxFfQ6GyuG4Kgbdasb/Za+vpVS9anrtZUcuK1ZJZBXz
        OSWnX33/3xRF76pSwBQpEC1cLvVeIEBfGh2RxFwiow==
X-ME-Sender: <xms:Taq8YqCDK-NzZ_WAmOKhc630EnUoC7KP3pSMa_bcUPLmVdM1IhVCNQ>
    <xme:Taq8YkjnPjFjTmbr2a-cF0ebXO8ycEmMLPY-Ia-Cl5M3-YTSiNYbELyzzkg10d4pw
    ID6G0C6LXD6wJLz3Jg>
X-ME-Received: <xmr:Taq8YtmBUxmkWFbUWMaD2bi90HVNBIpN6W7724JQ5i-JBH7TL38jAgTn1FuoakL2cBqLvd39rnlYlur2EGQR9zNK5kuzgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegledgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:Taq8YoyrJvZClj5xN2ggn8aDthIcO4LySpxhRfAB7iYDbWGk7ZnAQw>
    <xmx:Taq8YvSW6lVDO1iBruv-uVk8OyrdcBmlSIgPmyxTOHxujQszd82W3A>
    <xmx:Taq8YjYaWJqkMTd83U4zTXgf4cgzlzmhZpU0IajYaXbN7NHwXYdj3Q>
    <xmx:Tqq8YpdQGdfAFg3kXIyJtvCbGUCgtyoIkRIcr3dWwSXcSXLD_iSx_g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jun 2022 15:38:53 -0400 (EDT)
Date:   Wed, 29 Jun 2022 12:38:51 -0700
From:   Boris Burkov <boris@bur.io>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: fix read repair on compressed extents
Message-ID: <YryqSxHkXm84NWyT@zen>
References: <20220623055338.3833616-1-hch@lst.de>
 <20220629084201.GA25725@lst.de>
 <YryiSQcMbgOJbgqf@zen>
 <20220629190838.GA28224@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629190838.GA28224@lst.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 29, 2022 at 09:08:38PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 29, 2022 at 12:04:41PM -0700, Boris Burkov wrote:
> > Under that setup, the new btrfs/270 fails on step 4 checking if
> > the repair worked (the output looks all random rather than aa's)
> 
> I think that is the first, incorrect version that I posted that
> documents the current behavior.  The correct test is in my first
> reply to it.

Ah, I see, thanks. That second test passes for me, and fails on
for-next, for what it's worth.

Now I'll actually dig in to the patches/tests.
