Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECFD5A9E5A
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 19:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiIARoV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 1 Sep 2022 13:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiIARn2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 13:43:28 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63C65E30F
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 10:41:02 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 173BE2C3E8A;
        Thu,  1 Sep 2022 17:01:56 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 10DB82C704A;
        Thu,  1 Sep 2022 17:01:30 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662051715; a=rsa-sha256;
        cv=none;
        b=cWNg3WO5eOB1sEF3fh2hrrdARccf14/i5f7Q9krEGTM0wFhsNb/ePQnbPXk6mZfZg0V+fA
        8g8ZpSbfzH9mWZs8l6N1Aen8u9ChaRFS9TJ7UWQBhMbduIfbdSUlri+RRJbkwgzoSN1wzR
        mh3+dYCoB5G0NRxETw3WEO2aL8ULeavjZFuGgrm66eTm7SiZ94e2y1U8K0KTMeskKDZPpQ
        YBAQmEyiuWksxJrV42Ntm3jdA9dr4pigQEQNoddcwYamHifPKGQdVI26CnmF/5x38o+D+4
        RdgX6BQ0fyFGtyNVYARSNKtglE+TqCGJVtvDOibLcTWTl+qIO3GOqNzbR+ZkVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662051715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dr0WTgZfvTmFsH03liW3WxAbRRMKTvSjWJY5DLzALA4=;
        b=G5z2OHCrAIFIK109Jnv/3VKuCHKIN7rhsznAVOAHhmaycfqnqptURgNYWBQo2Qti3jtskL
        jAEkETEa+2Ta1F6NZ6IMOejEjeRGDXvmk4zbMVtfFUivrSZ1AVMz9kKbpIi2Gir58bYrWf
        wV2MEGdB7f5nBhiDiXrC/gxfpsFQ74tBgBzcqMKd2gLKD487IegjD9KkOUbpX57/ellpNX
        OnbzeN0SVuvhJGVC154FPChKJHKwlhXlO/zoNZhCQ+CmvkBir+5PvqRqZ4bcD8jpprU7qe
        ZL8SqO1x709egOzUBCfz5CwSof5INCvI7SvSUoCbNHfKAG9m8ab21wUh9g9TZw==
ARC-Authentication-Results: i=1;
        rspamd-64cc6f7466-cwkfg;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Juvenile-Name: 5c0b3aeb094e40b9_1662051715773_3926237579
X-MC-Loop-Signature: 1662051715773:3044750681
X-MC-Ingress-Time: 1662051715773
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.121.28.249 (trex/6.7.1);
        Thu, 01 Sep 2022 17:01:55 +0000
Received: from ppp-46-244-252-68.dynamic.mnet-online.de ([46.244.252.68]:55432 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oTnZ3-00078U-NV;
        Thu, 01 Sep 2022 17:01:15 +0000
Message-ID: <8c5da92490778450db962564528ad9db5b8f7348.camel@scientia.org>
Subject: Re: Btrfs progs release 5.19
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Date:   Thu, 01 Sep 2022 19:01:10 +0200
In-Reply-To: <20220816135149.GC13489@suse.cz>
References: <20220816135149.GC13489@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-1+b1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-0.5
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.


I've just wondered whether:

On Tue, 2022-08-16 at 15:51 +0200, David Sterba wrote:
> Changelog:
>    * send: support protocol version 2

means that send/receive v2 would now already be used when using
btrfsprogs v.19?

Especially,... is it considered stable?


Thanks,
Chris.
