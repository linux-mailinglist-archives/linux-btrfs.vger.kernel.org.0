Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A49E6E949A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Apr 2023 14:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjDTMhW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Apr 2023 08:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjDTMhR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Apr 2023 08:37:17 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07556E61
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Apr 2023 05:37:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6DA075C01C4
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Apr 2023 08:37:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 20 Apr 2023 08:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm2; t=1681994230; x=
        1682080630; bh=KFBY3WW1yIHC7rg1PoytPiQxm1mSoA4Gn0RnCe5U4vw=; b=H
        A2viX/lEdnjmQUkVs1UTOaf+BmbRp+1N+pRuJp8zdUtR0/VArBaHpVfOLUQFvaqN
        G9jLvcDdThl4x5Gap3Rf6UPkZdFaXEZouAYPqZGHlB+V+GFOwQ252tZh7uyMANnW
        KEMlU/TSpz60iRyakhki4X4vmnR91yj4I29BWU6g3s0P4N6YPqUl0sGbMtpQJ/WQ
        jitmRU7TzM5De1v09Rjox9AeB9qjiuGGULJIXlo07SV27vJpPKrHlpRfSeZtWTH0
        YC/X1ULig9xDf5jm6e5b2/N2nWHK+KbWpvrahONwbfqVxtVWCmr0XzeFJK406FFS
        yrdWPWK7pV1vIaZcOAGSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681994230; x=1682080630; bh=KFBY3WW1yIHC7
        rg1PoytPiQxm1mSoA4Gn0RnCe5U4vw=; b=ezycbNNKEjTs+DJbfyZtaitDY1FDL
        ZDmO1Ix+6URUef5Q2reJo+CoTCGB+LIhhtsoiC5ODqWmZDEZ7bk0keeyn7kyHo7K
        JNous+oJIfDaeMUi3GFKcHbhiNpfb22lruslRr/4/t5qZIpBZCGfu7vXz9nFVvnB
        1pc1P6frFZPqxIzrtTHZGtkZzVVXdtFRMsvfOguwljFfNuBctnllCV/87EQbtsC9
        vKrOEv3y/5BylacalwKyAVZSd5mWvC3wtlnbfvBBfQyUQq6FU9vWh2l7d1jgsu6F
        mj5mX+AQrqOx4UmNFuXxA7UdVrTd65qSbWpPvEpXIXYQp3emhNvp0Q+IA==
X-ME-Sender: <xms:9jFBZA502Zx05uxFQ_OJRKV-C6l9Vb_rBtDs7noh-hJMTg771XI_Mg>
    <xme:9jFBZB4auY-HN71cQC8ndp2wpFYGpcpysxM44nHhNzyr5fh3JyDz7bFLVSjEfzo2f
    7FLZ9WAh-g-BFVZ8Q>
X-ME-Received: <xmr:9jFBZPdqT47KclnrOTIi0IXsmegm4NZLjaag5Zzv09i5s2vpO5cT1H84etMr-ofpYZn0pPEPW-O2pdk5je_H7pSZTDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtvddgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefvhffukffffgggtgfgsehtkeertd
    dtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhgihgr
    nhhithdrtghomheqnecuggftrfgrthhtvghrnhepgeeuhfetgffgfeetjeetgeetleeuve
    ejvefhuedtvdekjeegheevleekjeethfdunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:9jFBZFLhgQR9yXUqkgvcAt3dlz_PHQWaZJCNLZM4CtekWbXtA7_VPQ>
    <xmx:9jFBZEJgmKtc1AYgRnj2Yyuj9CjELypW1QkmRfD10RtUSl3p0kXmpQ>
    <xmx:9jFBZGzkGnA81P4JxB4kwwupuBYMRt0l3Hl4qxKbza61lHuNIGRClA>
    <xmx:9jFBZLkyL1ZfmDPklqp6yTUFugf6nZKwqhDireZa0d8T-qspWgD_UQ>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Thu, 20 Apr 2023 08:37:10 -0400 (EDT)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   Remi Gauvin <remi@georgianit.com>
Subject: Does btrfs filesystem defragment -r also include the trees?
Message-ID: <b7c067eb-e828-35f7-4b26-499173fd07d9@georgianit.com>
Date:   Thu, 20 Apr 2023 08:37:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have recently experienced that btrfs defragment (by itself, without
-r) of a subvolume can dramatically improve performance when accessing
very large directories.  I would go so far as to call it critical
maintenance when working with gtk3 based file managers.

What I am not clear on, however, does adding the -r *also* defragment
the subvolume extent tree, or do the two commands needs to be run
separately to get the full effect?

