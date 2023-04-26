Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AEC6EF1B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Apr 2023 12:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjDZKLS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Apr 2023 06:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbjDZKLR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Apr 2023 06:11:17 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780374212
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Apr 2023 03:11:14 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C5F655C0049;
        Wed, 26 Apr 2023 06:11:13 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute4.internal (MEProxy); Wed, 26 Apr 2023 06:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dend.ro; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682503873; x=1682590273; bh=aM
        YdJPQtVwy44bJoxSy5LLax6gd4m+6X5SP4xU4dzhE=; b=RW7o63Jms+oYDFB+fh
        KOmutLO6SIBbtSQpFEPEWVR0blZOrRhXcw1/evtRNNPDQ5GDlvmdOQb6TXkUAylm
        XaU+MK8ZE3u7Xo+OCa5G5GI73C8IVaGO/hPt5VkHh41KarNytU3ULWthIRn90PLk
        wfz41i1l5jaB4xNO6D9mW8gXF8RwB6L00LxFB+ngC4sE672I7RyhpNotDlLSbV9x
        ftaYNhmq5eeJ51CIqLX5pJFo2CZN85qe8N/mGeG+wK+smmGhbQHsfKNP99KqPIOK
        CkE5XfYX8Nb0HaGI3uSVWoQio9+uy0Pk3alhas3yZ2uFEEROjhlZ8mtiQSHovxV4
        8DGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682503873; x=1682590273; bh=aMYdJPQtVwy44
        bJoxSy5LLax6gd4m+6X5SP4xU4dzhE=; b=icDoipLNx8MCeCogNAFzfKO3+//W6
        ESLr8Yd+t8Rvf2sFkBKDnMDkF1UVVFJyVHDhO2ETyazg3xIPhjuh2jX/yQ2Y8BnX
        Y4SC2E2WObnPRDVDlQS3nXCn3YZprJW1gY1erkt/lR2JcfWt6cxe+x2owqxwJAKa
        Fmw2aNp5aeSzf8ObyHxmoT8V2TWC2xa3jJh110bETSbdBed/A9rg9bL89ibXwo6r
        UOXKZEC+g8ZNsP4sBTMgbF5wIwlvTItlk9plgWRV1wNz/4uiQ3d+v1QiQGvw+eUo
        iw6yCntrvupJsWihMtOk6ZWlQ+VMFVtJLPy+yEzv6I+xFOz6zok9VkZ2g==
X-ME-Sender: <xms:wfhIZDY9ejvhvKvN4QbNxkkFC_SH4tTMhK1TrN4wcCmHMJiD1tlVHA>
    <xme:wfhIZCawyK9PLzzWaEDw_BGzofI04AiS9L9da41LHnlt-fRBUEngHs_3kX7dCqHjY
    RB_p5J48anZt5An8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedugedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreerjeenucfhrhhomhepnfgruhhrvghnthhiuhcupfhitgholhgruceolhhnihgt
    ohhlrgesuggvnhgurdhroheqnecuggftrfgrthhtvghrnhepvdefgeegueekveeguddvie
    evudeuudfhvddugefgvdekkeffffegffdttdeugeeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomheplhhnihgtohhlrgesuggvnhgurdhroh
X-ME-Proxy: <xmx:wfhIZF98HXU41T4Cz08lXjPg5c17KfrIuGN-CkR7uwl4vxVEqCjN2w>
    <xmx:wfhIZJq6wqlxCFO7qDCellgFko4TVbzx70PfTko1fpp0o5NdMXOv1Q>
    <xmx:wfhIZOqTywkJXNs5CUH-F66qUxQbR2FG_V87MD-5Zs08d1jgguryVQ>
    <xmx:wfhIZMGBiM13iJoF6z5YroOFd6m32jZ-43q_Qs9gnJlIy3l5QfnrSQ>
Feedback-ID: ic7f8409e:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8F3FE1700089; Wed, 26 Apr 2023 06:11:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <ee974fc5-5c86-4190-86bc-60d978fd93e1@betaapp.fastmail.com>
In-Reply-To: <414d15aa-0260-b41f-1fea-0466cefdbd21@gmx.com>
References: <d2975210-6fd4-4bf2-b72f-ffba664bdcc0@betaapp.fastmail.com>
 <a0f6195f-e6d1-f633-9cd7-310fe5786546@gmx.com>
 <f057bdd1-bdd9-459f-b25f-6a2faa652499@betaapp.fastmail.com>
 <1e917ae3-71fd-b684-12b0-044e49d22afa@gmx.com>
 <974307f3-7cd7-4221-8ba2-30ce0d7bb49e@betaapp.fastmail.com>
 <414d15aa-0260-b41f-1fea-0466cefdbd21@gmx.com>
Date:   Wed, 26 Apr 2023 13:10:53 +0300
From:   =?UTF-8?Q?Lauren=C8=9Biu_Nicola?= <lnicola@dend.ro>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Corruption and error on Linux 6.2.8 in btrfs_commit_transaction ->
 btrfs_run_delayed_refs
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 26, 2023, at 12:17, Qu Wenruo wrote:
> However the target bytenr is between the above two keys:
>
>   693637402624 (A) < 693637414912 (A+12K) < 693637419008 (A+16K)
>
> Thus A+12K is definitely something wrong.

I have no idea if this means anything, but I noticed that the node from the dmesg output (693637414912) is different from the one that caused the original crash (693708427364).

The dump from the photo is incomplete, but the last key is 693638418432, which is smaller than 693708427364. The first key is 693633880064. So the node seems to be ~4.5 MB wide, while the missing one is another ~70 MB beyond that.

In any case, thanks for looking into it :-).

Laurentiu
