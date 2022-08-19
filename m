Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CEA59A86D
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Aug 2022 00:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbiHSWSt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 18:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiHSWSs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 18:18:48 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE67FB2768
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 15:18:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1492C580881;
        Fri, 19 Aug 2022 18:18:45 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Fri, 19 Aug 2022 18:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660947525; x=
        1660951125; bh=128wEOp9qbi2WcaWbz4K4eTbe997lW7H3cgghTVg8zE=; b=j
        8m7V7KUN9jIFOmJmSRGdvCgeBlQMBQrNCGbpDk1OkuKz/BxxNTi/KV38SZQsu6gz
        9GGvNs15gK4PRxObsxX+fZbOeR8xPHDTsQbPAK6RALuCUGWk15JO+gi7ogqyyQVj
        cIAkNpVvzBdHOz/5qT4oTFm9o69BLs+rSF3xqTp+O6zzCeYMICjPJgoEp32veUcd
        pNFnVvHBnQ+ue1PR2ZsWkBX3GVINdOg4l0nbF6lB0TU5+cBzyVzdtzwP5uhg4ukH
        3HI8rM63tTHi/1L1YwkxsAjdncd7scIiwo+tNGjMVEVlT0Wpie3W3RiuugNGvH3V
        PioaaVZNLNYlmcfu3kSWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660947525; x=1660951125; bh=128wEOp9qbi2WcaWbz4K4eTbe997
        lW7H3cgghTVg8zE=; b=5bpIvu8f6K9meNKQPPrF+UK8LmWvtYPzMWLm9BuDSoCt
        Wosj0E9s+/n/tfmC0Q6pbJQ6+QLSog3+t+Ic0wbsaL6OFMraghQKj18pCDEUyB6f
        abbPcKJ+m6f1D6F6qQj9G95t7nzI6pifbqWWYBI2piFNvWgkU3kef8czf/orRXPU
        JmDphkQK2BlU8o/H7nZj3CScG5WUSRffUHBg7T+jH4R8wVN3qbmllSE4YIzUmTu6
        j95FEWMghpp/wPOVbz46Y+Pxb10jeHuvw5UNJjoy6K2FBBAW4gAcg6PoMnZIbrbD
        +NJU8Gcl6Ue0ygp6qvFDzUogBUevyuz9GOmORV0lww==
X-ME-Sender: <xms:RAwAY0bHrf6Niiv7UnBOachbJTTc4XcznnyVfh4zl2I_OMmi4Cj0sw>
    <xme:RAwAY_bYhEHhuIdwQlnrQAaoRNzJArrE7UT2SUH3MpBtRH2x-MOYSA37R-SZThRtO
    _ZtocQ3kC3UQxdu2aM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeivddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefgvdeukedtfefgfefgtdelffdvieeltefgfedutdff
    leeuieevieevkeehtdehueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:RAwAY--8pY5sqrqS0czjOTNdfB9VW4Img8NbqzxDwoC4llk4pIdPnQ>
    <xmx:RAwAY-qXh1e685lSpD81dA0vzQOZcUmCRHVh8bnjyuuUN1pFUBjqNw>
    <xmx:RAwAY_quM0vuYVDGkpecvq01UNW9MB-ofyi2SrYf0886vqtZtv3Oew>
    <xmx:RQwAY-TojTs1f7mQ_NepYUuHhzIYMmbiIgVtvu2chvS8feq1ouMKbA>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C234D17003FD; Fri, 19 Aug 2022 18:18:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <1a102e00-144c-43c8-bb08-7bdb4072d056@www.fastmail.com>
In-Reply-To: <a6b0c534-4f05-4f60-a7fa-f33cfce990d7@www.fastmail.com>
References: <a3fc9d94-4539-429a-b10f-105aa1fd3cf3@www.fastmail.com>
 <87v8qokryt.fsf@vps.thesusis.net>
 <a6b0c534-4f05-4f60-a7fa-f33cfce990d7@www.fastmail.com>
Date:   Fri, 19 Aug 2022 18:18:21 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "George Shammas" <btrfs@shamm.as>,
        "Phillip Susi" <phill@thesusis.net>
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: What exactly is BTRFS Raid 10?
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

man mkfs.btrfs explains some of this. Minimum devices 2.

And keep in mind all btrfs raid is at the chunk level. Not block device level. So there's no such thing as a mirrored device, but rather mirrored chunks (two copies of a block group on separate block devices).

And yes, you can only lose one device with btrfs raid10. 

--
Chris Murphy
