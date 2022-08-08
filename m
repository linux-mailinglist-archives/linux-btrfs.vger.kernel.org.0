Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405FE58CC6E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbiHHQ5z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 12:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243966AbiHHQ5r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 12:57:47 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3768B14D0A
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 09:57:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 98E772B059A3;
        Mon,  8 Aug 2022 12:57:44 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Mon, 08 Aug 2022 12:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1659977864; x=
        1659981464; bh=gMqlnLSI75AeYhYtPEVCnk+kyOXYTtWYzEtnlTd0w14=; b=s
        zWQmZKfAek6lGqGClbACpzEd8iCv/w2EWYjXWb+pQVYPRJ1pauyRCR+0bwVMi50r
        ZxYuYALwxJKqmURLDbQfaJ4qWEEd2Rvn+fk01kKPQQpmJOUTgKwEXwLmFJV+OXgV
        33d+8PkyRwwb/jm1p0wAA5nAXnBlkdo58NWPCVuyZBEVuMdyU1m3w5ePB3OwIHHe
        sLUEkpQcqORSPjOx7qBJl10BN52PEsDn5ZnIH6pFln3XlxcV9k9ckRtw18S49yjr
        36XwhJP6bmWjHj2JlHzyqP+/bNxz9hhynQc6BJi1JygAUEGm+Bqh/dadbXk2E8uN
        dm+FWN+umofVyfXZU3beA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659977864; x=1659981464; bh=gMqlnLSI75AeYhYtPEVCnk+kyOXY
        TtWYzEtnlTd0w14=; b=Q6NsKoA8iLs95m2ZPt1jhTDA8CSAPHpMGV7QkQbriAZG
        ZeUvpYhaX7286Wza1HfJO2hSyc//gG3bEaUUIFy0IOoEdWHbqqfbomrUZzqnEGtK
        yDpovcn6WUxdq6DlJpUGj/6qLUriz9SoP2bRGg45X104mYH0cPtdVUN/fXuGQwmB
        FsR3i8O+55GfeYeA60QK8MqWdcvBwqf4ZlmM3aMaQWfGjLeMNIHGIEAkPo/uToQr
        p2rQU/T0pVst22Pg5W5I8ZBdWOUQSJ7pG0AjJ8ug5LeTNmQ6HYLgHtLF1YuQNs7i
        zr0jN3Vujo3vycswg/ds+tfKwTDeVTBqVt4OoiiP5g==
X-ME-Sender: <xms:h0DxYhhi6Ao-0snY2OGe1pqDYF26w2gg1i1Sy7IhXMe9a3Pz8iChyg>
    <xme:h0DxYmBwKfMLG9jYgEdqyeYxl4_Ngu-LiGuJ-qg9so2ywB-wEBu9WnbVVWWcJ8vRC
    z4hw1G1y_0Xwnd82so>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefkedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeduheeiveeutefghfekteekleevffeuledtjedvjeev
    vedvgefgfefhgedvudegueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:h0DxYhFxe5MWIQ9NBXvAhf-wV_VvqDf3wJF_ZLsL8eM7lIUYiqIdEA>
    <xmx:h0DxYmTWs_Fd8NsfaZ33y9tTbb_vXltiCUp2kfUKFrD5q9vDvnepsg>
    <xmx:h0DxYuzkoxRfwb2pr8-hI1-_o87AUWIZ4iVXvToOxvGxdakG62AUyg>
    <xmx:iEDxYjtPx2IFdR1KfAPImh7wgnTrsu_4TSmrYwGLbbdKpraZNaRuyDSr5qg>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AF4D11700082; Mon,  8 Aug 2022 12:57:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-758-ge0d20a54e1-fm-20220729.001-ge0d20a54
Mime-Version: 1.0
Message-Id: <ebc960af-2511-457e-88ef-d1ee2d995c7d@www.fastmail.com>
In-Reply-To: <12ad8fa0-a4f6-815d-dcab-1b6efa1c9da8@bluemole.com>
References: <12ad8fa0-a4f6-815d-dcab-1b6efa1c9da8@bluemole.com>
Date:   Mon, 08 Aug 2022 12:57:22 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Michael Zacherl" <ubu@bluemole.com>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: Corrupted btrfs (LUKS), seeking advice
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



On Mon, Aug 8, 2022, at 9:06 AM, Michael Zacherl wrote:
> 
> # mount -o ro,rescue=usebackuproot  /dev/mapper/luks-test /mnt

Try

mount -o ro,rescue=all

If that works you can umount and try again adding all the rescue options except idatacsums. It's nice to have datacsum warnings (unless there's just to many errors.)

Otherwise its btrfs restore, which is tedious to use but you should still be able to get data off.

-- 
Chris Murphy
