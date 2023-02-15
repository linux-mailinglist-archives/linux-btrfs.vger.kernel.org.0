Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E404E6988BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 00:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBOXVm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 18:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBOXVm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 18:21:42 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E9742BE2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 15:21:41 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 73B743200786;
        Wed, 15 Feb 2023 18:21:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 15 Feb 2023 18:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1676503300; x=1676589700; bh=KFo94/K1qr
        3fmN5GMflPQO5kLDWOGNZrtYUsceX5gDM=; b=WJNogv/CoSAaPuc+ijHhrS/Leh
        Im54bJr929vwtdPnjjrIaOLOsfGqCmtSHTtwNzpLgFzV7DbX64PLVzPpoXQJTy2g
        XfeMGmkRk4TW6H0S39Pzex89ISeTqLoyyTcpD/BvI3XEXBCtTNx17Eh/0aCT31MU
        pDuWVI5rtEuKwYkII69vJazU/WI1pwNaA6RDZUwy+nzYm418pLyx8gtiFQLtiwH6
        nuJyuXLnebn1M5GF8hDQXpV8nut6SpVoEShQbTbiTb3fFozVe2BwXAFXqRa1UJAH
        cwmiO9+hFIXdkze4th2AFJvBzNvR32SJdSuLm7MrJ1TLePT2LWZ2Ysjxcs0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676503300; x=1676589700; bh=KFo94/K1qr3fmN5GMflPQO5kLDWO
        GNZrtYUsceX5gDM=; b=id1dUQWf3FLH+NcrEoymMPY9MJOmwEVi2ilkKJLio2PD
        dZTrgalxgWfniTCrqPjNPb8R63/sMYWLiiNCYtxqLQK8dq8eSaUKJHKDZxJcdZom
        qBOeyulp7Uu1zpy93NJ7oZ1jy4mhUkRsxGbHPffpGSxduQcwuXUrEtXTrsmy9YdE
        cjyBQ1AbzaW5S41MuW1yzv6Qs8BSihwwFeoWV/v9469VoiI8BQLMYCk2vfrdavmy
        l+YQWmMcmlA92cb6zsCJpEIsuSeaMlneXSGb7XAHcascoSUEcAe1cTFMEdRFVojf
        leocWZWfCoBEPDkXbsuDUX5VDARTeh+ub4eUFE9HWw==
X-ME-Sender: <xms:A2ntYwKKz6NaRmLb02Hr2DRbTEISpBpxG272rICh4lCAlby2s6BGXQ>
    <xme:A2ntYwKrKXO_iRFtnv1Jr_jVnDh7IvJPsnep9nryL3TlaAgMrQyfoubxewd-ydh1T
    HnlUFQMwHxZbi7hZ7w>
X-ME-Received: <xmr:A2ntYwv0mdEKlCmQAtuKAn7heE_8WkRfhGvWkbUPjhBPXUNZfDB5mS7C>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiiedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehieegjeehffeuhffhleffueegjeefledtveduvdekgfehfffgtedvudekleffffenucff
    ohhmrghinheprhgvughhrghtrdgtohhmpdhprghsthgvsghinhdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhr
    rdhioh
X-ME-Proxy: <xmx:A2ntY9Y21lj1NxJg4ps7DtvzJCaYeg950nEWBSlW-R-k_876HYd3cw>
    <xmx:A2ntY3ZhBaY9QMscdFRD7r7796snXa4YC75O9bLbmd9SS06B2KAWfQ>
    <xmx:A2ntY5AfiTMPvdV9scNIRL56jZPn3IrZph2TVBlZBInE3e1DiXXIvg>
    <xmx:BGntY4BnT-ZbX_t0iq_7tFaqO9eGy9Ye5Yucb9Od2CHZLyfmfHPUyg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Feb 2023 18:21:39 -0500 (EST)
Date:   Wed, 15 Feb 2023 15:21:38 -0800
From:   Boris Burkov <boris@bur.io>
To:     Chris Murphy <chris@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on
 ext4
Message-ID: <Y+1pAoetotjEuef7@zen>
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 15, 2023 at 03:16:39PM -0500, Chris Murphy wrote:
> 
> 
> On Wed, Feb 15, 2023, at 3:04 PM, Chris Murphy wrote:
> > Downstream bug report, reproducer test file, and gdb session transcript
> > https://bugzilla.redhat.com/show_bug.cgi?id=2169947
> >
> > I speculated that maybe it's similar to the issue we have with VM's 
> > when O_DIRECT is used, but it seems that's not the case here.
> 
> I can reproduce the mismatching checksums whether the test files are datacow or nodatacow (using chattr +C). There are no kernel messages during the tests.
> 
> kernel 6.2rc7 in my case; and in the bug report kernel series 6.1, 6.0, and 5.17 reproduce the problem.
> 

I was also able to reproduce on the current misc-next. However, when I
hacked the kernel to always fall back from DIO to buffered IO, it no
longer reproduced. So that's one hint..

The next observation comes from comparing the happy vs unhappy file
extents on disk:
happy: https://pastebin.com/k4EPFKhc
unhappy: https://pastebin.com/hNSBR0yv

The broken DIO case is missing file extents between bytes 8192 and 65536
which corresponds to the observed zeros.

Next, at Josef's suggestion, I looked at the IOMAP_DIO_PARTIAL and
instrumented that codepath. I observed a single successful write to 8192
bytes, then a second write which first does a partial write from 8192 to
65536 and then faults in the rest of the iov_iter and finishes the
write.

I'm now trying to figure out how these partial writes might lead us to
not create all the EXTENT_DATA items for the file extents.

Boris

> 
> -- 
> Chris Murphy
