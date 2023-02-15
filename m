Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751FE698529
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 21:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjBOUFV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 15:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjBOUFT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 15:05:19 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585F93A842
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 12:05:18 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 10725320099F
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 15:05:15 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Wed, 15 Feb 2023 15:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1676491515; x=1676577915; bh=9l05+nkhrK
        lB487+AFvmOhH0qytQmW7qdNMCD8uryDg=; b=44ZvENefXD6GGluhXpAmRTFU2J
        xUEwa0NqoGFfCjCz6o5jk2fXr8zqp8pDikxGQeZYNEl5ZtIs+xRdy+/p3mBJoT29
        y4vQM49v+PqRZSlO8D9CvrzNGZh9EJHiLh+Ir5kAYjtsqHjoGu1nCnCxZNJ9PojE
        Z3y15zy0PaupJYTTz83+H4EnOZAiisnMB0cNLiXbQ9mmA5yNIbhQCsVLQLTt0zyt
        Al8sXzeJVmj6Uo2dJSQP/uXAwR3Zio+JcH31cpe6X0kSVIkVC5+0Sk5cTocY7MVJ
        uIsqr0g5c4/W45xIz7zTxzCsb0azs1xOwOh9ZAYXdCZb/rmFGfxlsvT7jbOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676491515; x=
        1676577915; bh=9l05+nkhrKlB487+AFvmOhH0qytQmW7qdNMCD8uryDg=; b=k
        2B4vxFURocdbRhy1m7kF90R0iObKHRFP5GwMd73B7kjue0gl10f7FrjTbMbI1/Tq
        AzFx5WJJaljJsJ2iPtxVrcwyfYPHSlzT533EvUUpjFmnriy6J9UcfNC9xgC9ALYO
        UfWS5BlKHWl6i4PTb06ZeYLOcfpPUVZfxZ8vKWFvNQ/UMDCwGa37yNaT4yWx5Gsa
        qfGk3rw0uT7H7B2oUEL1I+YXElb8MvCEDB3QNc7DvX8xqVQPIPR2v1Faz3lzssis
        ZXK8F+b71mZM1Zd9gqcI5HnraZBVOGv8qzTA4IaJmSEU0xekQQ0f63Oj9o5sOprn
        0fADK3F0PnSe7lZSxhIpw==
X-ME-Sender: <xms:-zrtYx8pFP7o9ptp_FU4cbBB4mw-ZnsRrf1_cs8zDZ3NFudRqevF5A>
    <xme:-zrtY1t4EV5l6NkT6byiuTHz4LXwmeN42J2MOXFsCCDW77uWhY4LHv5cubjhcMq2E
    mcMqezIKc_fQrMm55A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeihedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvufgtsehttdertderredtnecuhfhrohhmpedfvehhrhhi
    shcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqe
    enucggtffrrghtthgvrhhnpeeffeeltdejheefudetjedvleffvdevieegueegffdvffev
    ffevkeeivdfhkeeikeenucffohhmrghinheprhgvughhrghtrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshestgholhho
    rhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:-zrtY_BY1pR0C7q2tt9MeaUTCuFW3-L5ef7NngG91S_AdBBjLBt_1g>
    <xmx:-zrtY1fqTlVRENO_rs6dL1y67DjvwaznkFFZmldG8B2N4Q0MuJCtCw>
    <xmx:-zrtY2O1m-_A5Eage1WjiyrYnLb1j0dh4ozn3A3xYFOyOv_Vs32QmA>
    <xmx:-zrtY8b47gTrRW0-tevWO88Sh15sO-KZcCZ-bU2vEWBCe4Qqi_Uesg>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 126DD170011F; Wed, 15 Feb 2023 15:05:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
Date:   Wed, 15 Feb 2023 15:04:54 -0500
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: LMDB mdb_copy produces a corrupt database on btrfs, but not on ext4
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Downstream bug report, reproducer test file, and gdb session transcript
https://bugzilla.redhat.com/show_bug.cgi?id=2169947

I speculated that maybe it's similar to the issue we have with VM's when O_DIRECT is used, but it seems that's not the case here.



--
Chris Murphy
