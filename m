Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7A15AC1B1
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Sep 2022 01:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiICXGY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 3 Sep 2022 19:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiICXGX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 19:06:23 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED31B4B0FA
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 16:06:21 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 045AE3E0CFB;
        Sat,  3 Sep 2022 23:06:21 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2AC893E0B5A;
        Sat,  3 Sep 2022 23:06:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662246380; a=rsa-sha256;
        cv=none;
        b=Qumk6rS8YTKVMAGfxO1pZXQ74UVlqURd4cvRJQdBRkmtoiHXSsspOhjgKTmrOoDoip4/c/
        hKex1lWaKfdIjf4x0XPt2GrC9SjwKJ8vTwBYAGNAsdBCXql3Qh0YN9EhC/zrGvj2VOWpBz
        jl9Z1xIX6wywW9FYZ3PG8JYP3fvT/JU55RCfCd1YOlk3DjCWpzz4q8fd2+22Il0lWJl1BT
        3juXc73tfbK4+wJEQAzH7tdXgHE5MVhIezdZ25JD3WNZ95Jr730niizDQt9NyX7pOLaZlI
        CZ5oHjdTghSaH1f99E2mFaT513SObk1JAmCHjHfGyOExnozyHGNTlkiqhy/2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662246380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7KwMyrHtfiA76SJjevMZk/m+N1LoR1rmWgBEzxOo15A=;
        b=AN3Y/0WYAWv4ywxf4IIJTkOqZK7YA+nV6vQ5H67QPrsArFjTDWTHb5zW4MCT54K4l9mjGE
        1o/Jy+oeQvs+wQyBfUtJtkH/8JvcaKHZjIz3t78Lt5xF4tMo37k/dzLaZgV0ZrBWkMiiFJ
        Uj/VEfS6z+vw0rTbCqpja05tQSJv3NFRHuBevSymQdkrqxWwWGetiSNwwVrg+TJ/aHzQTO
        rjpq5jaj4mpqGr94vXzUAhU9OOv7pInfDYdhrtycQ+1dzex26ZJ3Pema2Yo0hfhi8sgwXC
        NyW8nAL2twldlJSphuUY9AFM32T3rG1VntIzJYYTdKMAzpF7bg9bupIWipuvNA==
ARC-Authentication-Results: i=1;
        rspamd-f776c45b8-v6xcr;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Stretch-Stupid: 66cb2b534952f82f_1662246380793_2247406069
X-MC-Loop-Signature: 1662246380793:2739356435
X-MC-Ingress-Time: 1662246380793
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.98.142.80 (trex/6.7.1);
        Sat, 03 Sep 2022 23:06:20 +0000
Received: from ppp-46-244-252-68.dynamic.mnet-online.de ([46.244.252.68]:60568 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oUcDQ-0001f9-Ro;
        Sat, 03 Sep 2022 23:06:18 +0000
Message-ID: <2895cb80db8794b1bf3ce4fccbb0e5df1ca311b0.camel@scientia.org>
Subject: Re: btrfs check: extent buffer leak: start 30572544 len 16384
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Linux BTRFS <linux-btrfs@vger.kernel.org>
Date:   Sun, 04 Sep 2022 01:06:12 +0200
In-Reply-To: <5d2ffc82-8b25-fb3b-4074-bb209747edf2@gmx.com>
References: <d8b54f683ae5e711c4730971f717666cfc58f851.camel@scientia.org>
         <aece9d0d0f51f70b1e77bda701a6d4c4f860f518.camel@scientia.org>
         <31ed8b19-ce24-67f8-8567-506d84cd5f4a@gmx.com>
         <5052c751772dd32713db530191a4fb8a4ad724df.camel@scientia.org>
         <5d2ffc82-8b25-fb3b-4074-bb209747edf2@gmx.com>
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

Google used to perform better ... I actually searched for the message,
but it only brought up some quite old patches:
https://patchwork.kernel.org/project/linux-btrfs/patch/1420444575-23259-1-git-send-email-quwenruo@cn.fujitsu.com/
https://patchwork.kernel.org/project/linux-btrfs/patch/aa032e11aa2b8667a28a93b90691d6f790711c62.1612449293.git.fdmanana@suse.com/#23954447


On Sun, 2022-09-04 at 07:01 +0800, Qu Wenruo wrote:
> Yep.

As always, thanks :-)


Cheers,
Chris.
