Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F834668765
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jan 2023 23:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjALW7x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 17:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbjALW7v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 17:59:51 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4266552C46
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 14:59:50 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 356E132005C1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 17:59:47 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Thu, 12 Jan 2023 17:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=terrorise.me.uk;
         h=cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673564386; x=1673650786; bh=QRo18tkdhw
        jLJVqe0T1DutnDqFflpYZbjcpn0BIxqRs=; b=l4acM1UO6jFnYjI9rJACaqAphK
        jCbGJarOl2ibGbmgHOEeECymJJkmf3s8TtYWvRUchLXm2chdc/nwsmZtaHoAgc9A
        8+p0Lq6P9q4Rl/dzVt71kg9WXSh2OzZ+t+zUBTrUx10HgiQS79fzta1GXqemCrQG
        G/EU1krnh8KwzreADUbycMStsd1H5xdf6cHerzrM+cvjs/yUjwmJKkM2qbGFl63f
        tVQVUvUnqVw+6DGJMKyFfGktqus2H/QKUnXcSNGyvaQ6jNWWZVgkycCHGUOqN+Pd
        mFuMYo+QqbSG9UynfrpBP2cxLFvWoFd1NNatp/erwrGJ935G2owDrDKd8g7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673564386; x=1673650786; bh=QRo18tkdhwjLJVqe0T1DutnDqFfl
        pYZbjcpn0BIxqRs=; b=PuFGtGS0uJ/keZKQ0hyA5jJXrfLSEXrWfpxdB/rP/BDR
        EPNf8qa0JT+tEQAbmV+/9uyVjIqy/Iml8pLgXBJWnBn8uKnkmA+kSgXAkXFvKyLs
        T0tsbRAQdBWX8gvdpBIU+jN1Rc0WVar5W/Uaw/zt7U6bjITRzLsKQTlZ8IM0OQP+
        vNAlVLZu/t7nSwjLbCWdfXguqdc5F4aRnpbTD5aNCggd/o2QyWTTujDbKp0B93Sz
        33B5dCkR+3y3eHkAp9+E3ftmfPW7wbwLizeY+G9oCHyEgZY8mIjV2zMG1mKN/+je
        7M4RSYOikaLuoZpQoYYPsyIN+6MdQQ3yA18WkmQWsw==
X-ME-Sender: <xms:4pDAYyZLSDx07AhDV6nzXIVcrAxJmfc-08tNT_L7vpRJnI-lzHYSvw>
    <xme:4pDAY1Y_SiEjn_eGqjJORSwm1brxVLYJuGrSZcNr4dUpviCIGf9rwOtuXgoPoz-OT
    6nQ3w1khaJXhlV0Lck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleejgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesthdtre
    dtreertdenucfhrhhomhepfdfhrhgrnhhkihgvucfhihhshhgvrhdfuceofhhrrghnkhhi
    vgesthgvrhhrohhrihhsvgdrmhgvrdhukheqnecuggftrfgrthhtvghrnhepgeffjeduff
    ehtdeigeelffdvfeeitefhjeevteettdehgfejkeelueevheeugefgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhrrghnkhhivgesthgvrh
    hrohhrihhsvgdrmhgvrdhukh
X-ME-Proxy: <xmx:4pDAY8-TLND2l8EDfN3E4iT_W9qujxwYCufnAxndw-UpBHX9y4CGkw>
    <xmx:4pDAY0pVfrnHzAyhPNtrKXAlJ0GF_9WkSC1-CIekx5e1XBDZYhDNwQ>
    <xmx:4pDAY9qQ5oNzcvkcFuULRbkDx6_9cdSMUlVdRAu3ick_YK1AOsOZcw>
    <xmx:4pDAY620zK5nS4sY_yVx00DHrLFwAvdR4Ce5RYrqslyDtvWAkVLJHQ>
Feedback-ID: i3b4144de:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AD260A6007C; Thu, 12 Jan 2023 17:59:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <b33290b5-b260-4d33-bd5c-11da3d08c0b7@app.fastmail.com>
In-Reply-To: <7c69dd49-c346-4806-86e7-e6f863a66f48@app.fastmail.com>
References: <7c69dd49-c346-4806-86e7-e6f863a66f48@app.fastmail.com>
Date:   Thu, 12 Jan 2023 22:59:26 +0000
From:   "Frankie Fisher" <frankie@terrorise.me.uk>
To:     linux-btrfs@vger.kernel.org
Subject: Re: errors found in extent allocation tree or chunk allocation
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 10 Jan 2023, at 12:49 PM, Frankie Fisher wrote:

> [   33.735212] BTRFS critical (device sde2): corrupt leaf: block=30874802077696 slot=176 extent bytenr=21866556121088 len=4096 previous extent [21866556112896 168 4503599627378688] overlaps current extent [21866556121088 168 4096]


> [2/7] checking extents
> ref mismatch on [21866556112896 4503599627378688] extent item 0, found 1
> backref bytes do not match extent backref, bytenr=21866556112896, ref bytes=4503599627378688, backref bytes=8192
> backpointer mismatch on [21866556112896 4503599627378688]
> extent item 22704514924544 has multiple extent items
> ref mismatch on [28106103517184 8192] extent item 4503599627370497, found 1

Based on the dmesg and btrfs check excerpts above, my research has led me to conclude that the likely cause of the corruption was a bit flip in the recorded length of an extent. This triggers the "previous extent overlaps current extent" kernel message, as the previous extent length is recorded as exactly 4PiB + 8192B. The gap between the two extents in the corrupt leaf kernel message is 8192B. And the btrfs check output backref bytes are listed as 8192B. So 
all of this points to a bitflip in memory before this part of the tree was written to disc.

The output of dump-tree puts the above in context:

        item 174 key (21866556104704 EXTENT_ITEM 8192) itemoff 7024 itemsize 53
                refs 1 gen 2228553 flags DATA
                extent data backref root 258 objectid 3633423 offset 0 count 1
        item 175 key (21866556112896 EXTENT_ITEM 4503599627378688) itemoff 6971 itemsize 53
                refs 1 gen 2228553 flags DATA
                extent data backref root 258 objectid 3633429 offset 0 count 1
        item 176 key (21866556121088 EXTENT_ITEM 4096) itemoff 6918 itemsize 53
                refs 1 gen 2228553 flags DATA
                extent data backref root 258 objectid 3633434 offset 0 count 1


I have run memtest86+ for some time which has demonstrated that if the RAM is faulty, it's a rare fault, so I feel hopeful that most/all of the rest of the data on the filesystem is intact.

In theory then, I can fix the filesystem by unflipping this bit (easy), and then updating the checksum in the csum tree (slightly more complicated but doable). I'm planning then to cobble together a programme based on some of the code in btrfsprogs to update data on my disc. Running "btrfs check --repair" seems an uncertain option to me as I don't know exactly what changes it might make to the disc, while I have a good idea of the changes I want to make to the btrfs structure.

My questions are:

* does this approach sound workable?
* are there any pitfalls that I might naively run into?
* are there any tools or libraries that will do some/all of this fix already? Or is there a simpler approach?
* are there any other things I should check in the filesystem structure before I plough on with my attempted repair?

Regards,

Frankie
