Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163345B37C5
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 14:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiIIMal (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 08:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIIMai (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 08:30:38 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DF5857C9
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 05:30:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4CE213200907;
        Fri,  9 Sep 2022 08:30:34 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Fri, 09 Sep 2022 08:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662726633; x=
        1662813033; bh=Gh0DLtxtA1OD6I+pWqKnR9ji2NIrgGpgARTtTOGPVyE=; b=e
        g19piqJkOpJ5sQqWkZlxZzdyu5bRzlb58GP7GTuUi6FbxWR4OLeZTxsn7S9+aD0t
        bsCfHlk1A+kfVxSNWsRpttCNiW7gON34YMak9M8iEz7M0/HYhllri1YsAbJcyKnQ
        RQ41FYCykKhOwbnQmnk+5EJZkqB28Ssoyi80yQojLwV36JusBwNTdHg1hFHpVF3V
        0tuzsLTnJs21EHlhFzWWqW3kYRO7aAtiMoeIgaJDGra0TDGxOZxxPIejj848hOC1
        IiIL/31fIgZxa9WfPg0aCV5JhKTCmv0leoxA2qcdi44AGO/2eF0GZcmmn0yprNiW
        WUwLUXz7wpaF5FCtlUCFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662726633; x=1662813033; bh=Gh0DLtxtA1OD6I+pWqKnR9ji2NIr
        gGpgARTtTOGPVyE=; b=ZBlA3ZyXasbxlGoY1PCqCR9PkJIyoN7cO4XXQ1VxctGV
        4yF2hX3tUOR+Sr/sTfbWrRhgYd9JwtRW93XiGPsNh3zZTsQad5oS90hEyhDwD7Jr
        kToIq/uiuWD9ATOjKcHv3UML6xcYBI+eUNCuYA0xOZUJK3BOexSsOgfhRiJ9ebLk
        xb71UvXeRhl6mahdrqbSATmzHgUTlCD6bRm8HTG1jROFf2WrF6jGFoeaodpTTjO3
        lLjxp1NrxmIhgmFGunT5U/qZVNbd+dmHFBE7cOmUC5ZJjyENnDSjuv5n5dWnmHYW
        iGl77a/mwIlWTNN1XauCYe8hhZBtIZTR9gA7XfW6vQ==
X-ME-Sender: <xms:6TEbY_ln0V1-QZ46U7IZcI-ENupwmtp-TouEYMIFZFX1ceIq-VKdeA>
    <xme:6TEbYy0XFSULhNG-_dJPIsQ7_l-zVNZOGR11Su6JxxiVt_WtkoI2PRKjb_3IwEkzE
    Bh1AGPD48Mwwispi44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedthedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdevhhhr
    ihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
    eqnecuggftrfgrthhtvghrnhepudehieevueetgffhkeetkeelveffueeltdejvdejveev
    vdeggfefhfegvddugeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:6TEbY1qkqRdtef_1kuyDa8CNvUXup7LpQelMaoO-uvTAVdFLW9vIvA>
    <xmx:6TEbY3lCv1DSAm2lXrfS_lVReQ64AgVgZd9R8wIeKpRnm-EBSSPJ3A>
    <xmx:6TEbY93H96gmJM9STVfHI6pToszherPGUq6OOlOz8kYamszxeuUMpA>
    <xmx:6TEbY6giYp1p57Q1J7fv1mcO1bedd8LbyEtH43iqJvC1TYrLAmBgjQ>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 903291700083; Fri,  9 Sep 2022 08:30:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <c8fc0db5-dd3f-49f0-bf15-1c0232835078@www.fastmail.com>
In-Reply-To: <20220909000446.zzsniu7rc6tl6sz7@regina>
References: <20220909000446.zzsniu7rc6tl6sz7@regina>
Date:   Fri, 09 Sep 2022 08:30:13 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     development.rex@posteo.net,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: Read only because of enospc
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



On Thu, Sep 8, 2022, at 8:07 PM, development.rex@posteo.net wrote:
> Linux my-pc 5.17.3-arch1-1 #1 SMP

It's a recent kernel, but you might try 5.19 series. Although offhand I'm not thinking of any fixes in 5.19, the main idea is to demonstrate is still a bug. 

Once the problem happens, could you collect these and post to the list? It may give a developer some insight what's going wrong.

btrfs fi us
grep -r . /sys/fs/$fsuuid/allocation

-- 
Chris Murphy
