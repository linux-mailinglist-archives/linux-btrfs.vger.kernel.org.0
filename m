Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E195E6EAA38
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Apr 2023 14:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjDUMV6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Apr 2023 08:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjDUMV5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Apr 2023 08:21:57 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8C5AF04
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Apr 2023 05:21:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E721E5C0217;
        Fri, 21 Apr 2023 08:21:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 21 Apr 2023 08:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1682079709; x=1682166109; bh=bTpYz9WqHC3yam/kzH5XmLQfD
        pDPKV+/kmd8oxCleO8=; b=ayQCfEDrSrqTM3sdZZFYrKsyIaNlTQJxR0DApgRGw
        P7v7d/WnuaY5mT5mJEMMhuxMLkG7bTk7u4sOC4jlmuYme4zF7+nqDUcI+tUpR6zr
        H55g+Q4i3blw7pr4mC4Aqw3O9sXSt+CQ3Y+kil/qtyvZMRyKKdv4+hSHZ2W0qpzZ
        N68oCZSebxgUSRbhUZZqVASh+d/fNvCn7mo0+MVqo9wP4sXhAd4cKpGmd8ipLDER
        nwdYvgSiJEdCx09rhx8A/aUSpB0ffjyossb4LubdSWviPQNcg9tM6g9AgntzXYr9
        rSl9N9tmmpqb8Hyhu/mcNIVhn3cu9NegM7IjVP/jySj5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682079709; x=1682166109; bh=bTpYz9WqHC3yam/kzH5XmLQfDpDPKV+/kmd
        8oxCleO8=; b=NQlNtfsZasU8+ewHPtaBH8Raw9SLU3v26iSrwnganaBoFsWKVHu
        ZaUU6Ic9iv+2l+D2HGoGzqiIeKcEa8qVpkaLQXtON6bi7EP/q4/Re1c5NIWUv8vt
        W/LHt3jSXcn93XlFjZ2FOll6lWFjGv3UOC/p8y8oxlq/sI3yIG0ig2AnKUYlJdLP
        oHD19JcgtUGDKQDGwV0pXYxrGRPMKWLlqExf8gF4ZMa8qddemBwPBvTOjs6pCyOT
        VDc9VX9aEU/DuJaYUr9IIqkeu/J2nwxBrZtnYUNDD0q74SbxwsqDg4HA3OhzMSkH
        gM/xFFtYC6xMiEiG2q1RRiPjplw2Eyx6xYQ==
X-ME-Sender: <xms:3X9CZNB1h5I3qjdVUoWLYMQWfhjk3b3bLDwFGV_TZmVdoNh_PyqZGQ>
    <xme:3X9CZLglPFvF8Ijztl5O3Cu2WBHTUMrxWOLtj3HUkeRFmJDql2ObIpXxzLJBn14IZ
    fVug7kN-t0TpAGDDg>
X-ME-Received: <xmr:3X9CZIm3fy9V-LnSzAg532Uq2NbhgWUbWgSb_f_KRLU34TFCT29iW2Ygocb9c3XQs5NuqHP0NAGFhDiL3PcmOpSCe4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeftvghm
    ihcuifgruhhvihhnuceorhgvmhhisehgvghorhhgihgrnhhithdrtghomheqnecuggftrf
    grthhtvghrnhepfefgiedvfeegffetfeffgfdtudelveegjeduveehgedtveetgeejleff
    ueffheeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprhgvmhhisehgvghorhhgihgrnhhithdrtghomh
X-ME-Proxy: <xmx:3X9CZHyndT3A12NSFE9C_2qhGdq8WZMSa-T8M9GPMaQFieLuNuzdiA>
    <xmx:3X9CZCR8JQog81P3_2BYGUxFk2adQy9_Bb3zYulKHuixI79WqC8Wkg>
    <xmx:3X9CZKbPlCnBgSYPX4IEyV58QNDtr1YkwFl4l_N-e_DIMdB5yNxbLg>
    <xmx:3X9CZFKmc1N3i-fupxKJ65-KpPY3qhBsLA8KzK6vW9dW3bQdokx4FQ>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Apr 2023 08:21:49 -0400 (EDT)
Subject: Re: Does btrfs filesystem defragment -r also include the trees?
To:     Qu Wenruo <wqu@suse.com>, dsterba@suse.cz
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <b7c067eb-e828-35f7-4b26-499173fd07d9@georgianit.com>
 <20230420224242.GZ19619@twin.jikos.cz>
 <6f795670-eae6-6aef-3fd0-dad81bb89700@suse.com>
From:   Remi Gauvin <remi@georgianit.com>
Message-ID: <fc0e9969-8414-e947-a768-320516c2eee0@georgianit.com>
Date:   Fri, 21 Apr 2023 08:21:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6f795670-eae6-6aef-3fd0-dad81bb89700@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2023-04-21 3:57 a.m., Qu Wenruo wrote:
> 

> 
> I did a quick glance, btrfs_defrag_root() only defrags the target
> subvolume, thus there is no way to defrag internal trees.
> 

It did *something* that allows Nautilus and Nemo to navigate a large
directory structure without stalling for > 10 seconds when moving back
and forth between subdirectories.

Unfortunately, I did not expect I would have to replicate this... I'll
see if I have an older snapshot and can do some kind of before and after
comparison.

