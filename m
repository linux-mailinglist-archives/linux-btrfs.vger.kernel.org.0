Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93AD6BC2FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 01:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCPAwP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 20:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCPAwO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 20:52:14 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5E2ABB04
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 17:52:12 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7082E3200907;
        Wed, 15 Mar 2023 20:52:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 15 Mar 2023 20:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1678927929; x=1679014329; bh=uOMoWRKqfWLVEqjgV4PBY/ZXg4W7UfvPDus
        ypqvsOyQ=; b=umiykBVJTKIiywk/nuGnx2wIpYCj0Ef8T9s39xhFDDiKPw8qQ+C
        U6lzesaARxSvCy0zld9B3A4TYWrBaeZfmzwYFDKixldLq2YTIVOVSjQHB0tltUAO
        AccGpyS2+1qmyNvV5L8sl3HO0J3d0QTLvomSEjsBGItfJ5hMHJ/2a9Q+LuQ7TE/s
        0KlltfAtexgBM6fFBc4YkphwNrfr4b6ZNyl75BnCpMZaxNnb4dMd7eiWE5QtTlRc
        Je8WcksY4lZmhED2mGDxWU4DQ0InuYUatY2+8kHahqLOIkRrcejaZos+C7repxi3
        pA9rXzFdNNy5NQFzdq2yCCj2se9CZ29aUTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1678927929; x=1679014329; bh=uOMoWRKqfWLVEqjgV4PBY/ZXg4W7UfvPDus
        ypqvsOyQ=; b=vdrHPn6j7Rqc2dcXpfGcpH90IgrQU+7cQ3klD2uBWXoCl89T6zC
        D8S8B59UgBNiH4CDU/oxQ4f2rM5MBWToebFqevt8vDKhgf+nqvVzGULTkEY5TQYF
        W8edji2462mlUL41itGO7EfW2+tIL8bM3RiZBYdTvZSPAA2OcCWzRbB3SZG6dySI
        rsa6gJUcbLGyLat6GmxMGnw/HcAhS4DrI6f6wenOnOX2yw7siEuwoOMcC/YmJNZt
        2Sj0Ij+ah8JGZqsh/j5o/Hd0AM4s/BD57yXsh5/LqAEvUS1MESit03EuQJUGrwqT
        ZpjDBclXIBlIN681rzFlMz8gL2G9By6/Meg==
X-ME-Sender: <xms:OGgSZBB2pJWK765pkHCqPgOwIxVVIZFZmuvNAHYn0z2Fe1Pd7l-fCA>
    <xme:OGgSZPjAzneviCquTd54XmhWrCG97TDrgI7UMuD0vgMPocXoTcQ2-JaH7CItB-ces
    Tdsyfj2OSqP0_lvSD8>
X-ME-Received: <xmr:OGgSZMlRZ7APPjWaJO0DiGbTJOSFtJ0qQ0GBs_U3w_nqfZur4grwKxjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvledgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epgfeiveetffduieeghfduffeufefhuedukeekleevkedvkedvieeifeeiveettefhnecu
    ffhomhgrihhnpehrvgguhhgrthdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdr
    ihho
X-ME-Proxy: <xmx:OGgSZLzUp-fLpSNSf2ba3qk4MUtOUyoFstCY1bSZO4hdxc6cXXLwnA>
    <xmx:OGgSZGRAKs39YOvdxjSCKHEDhwicsPfORjje9PRq-fkfPvCvA22sYQ>
    <xmx:OGgSZObe7eVYhjBqKCm3Am6P5GAm-Xy3zRQhsT9BLUfhFy7STE6bBw>
    <xmx:OWgSZMNmNGriVpC8X_Uq9_9rCN4g5536Ueq20KenolEuCzVnsn1REg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 20:52:08 -0400 (EDT)
Date:   Wed, 15 Mar 2023 17:52:07 -0700
From:   Boris Burkov <boris@bur.io>
To:     Neal Gompa <ngompa@fedoraproject.org>
Cc:     Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Davide Cavalca <dcavalca@fedoraproject.org>,
        Michel Alexandre Salim <salimma@fedoraproject.org>
Subject: Re: [PATCH] btrfs: fix dio continue after short write due to source
 fault
Message-ID: <20230316005207.GA11975@zen>
References: <ae81e48b0e954bae1c3451c0da1a24ae7146606c.1676684984.git.boris@bur.io>
 <CAL3q7H7wVW_E70+qvb4S7w06RvjW_2dXxzTLLQO45_vC0SLTkA@mail.gmail.com>
 <Y/UOnKe6Ap8+lGx0@zen>
 <CAEg-Je_03VLmcS_XzDytKWbkuDPy9DPesGvoPKa74BqzuRnm0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je_03VLmcS_XzDytKWbkuDPy9DPesGvoPKa74BqzuRnm0A@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 15, 2023 at 08:48:04PM -0400, Neal Gompa wrote:
> On Tue, Feb 21, 2023 at 1:52 PM Boris Burkov <boris@bur.io> wrote:
> >
> > On Mon, Feb 20, 2023 at 02:01:39PM +0000, Filipe Manana wrote:
> > > On Sat, Feb 18, 2023 at 2:25 AM Boris Burkov <boris@bur.io> wrote:
> > > >
> > > > Downstream bug report:
> > > > https://bugzilla.redhat.com/show_bug.cgi?id=2169947
> > >
> > > You place this in a Link: tag at the bottom.
> > > Also the previous discussion is useful to be there too:
> > >
> > > Link: https://lore.kernel.org/linux-btrfs/aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com/
> >
> > Thank you for the tip, I'll include those in V2.
> >
> 
> What happened here? I haven't seen a V2 posted (unless I missed something?).
> 
> 
> 
> --
> Neal Gompa (FAS: ngompa)

I did post a V2 (and a V3), but unfortunately, I found a bug in it since then.
https://lore.kernel.org/linux-btrfs/20230315195231.GW10580@twin.jikos.cz/T/#t
for reference.

V4 with a slightly different approach dropping tomorrow.

Boris
