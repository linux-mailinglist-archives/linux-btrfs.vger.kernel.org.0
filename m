Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178AD591C69
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 21:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbiHMT3L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 13 Aug 2022 15:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiHMT3K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 15:29:10 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49616586
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 12:29:08 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1A4A32C19C3;
        Sat, 13 Aug 2022 19:29:08 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0C7812C1C19;
        Sat, 13 Aug 2022 19:29:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660418947; a=rsa-sha256;
        cv=none;
        b=smcbPAAMOs8rTLAbSafFZxsm/HWB45LLJ7rtkmozbLNIbFuDB6TD6w7bUp1Ud2PoEldd/F
        06VRdG3RLykUy/dVTFydRc+UhX8w+oMowoFvV3wwyeRr3xoM8tRmh+8PjBQH8otNzolnrf
        0As3LBzuNDZ9fuuK2juSqMXiduILQCVCvf+nLWMPBAt1KcL0l0ILhKvRckU4jh9VL7T9P9
        QQupNZUzmSARSQ+SpjOQTDHo28BBUwO2uYDzKGrBfE3t7yoHp1ggbbhzlPcJ3222Npst24
        zo/1EPHEuCmiudu+iIptiuQYbHkhXRTmGJCayLYcsn1QvNGYXaQEggcyV2L7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1660418947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NKS+vr/vg5uYie6oL6fdXkAt9T20CeG3pm/2bPdRG/8=;
        b=TH1wQdKH42kNIWwHz8yv0WnP3nTSjEiLmKkUMf0pnq/cn9RBrtGM5Z7K8WY8rhJPdxpx8p
        neWjGTkKu1269iGfH/+lx1gVO4ytqhBkRf16u5mStnRvWjA27X8Ovjb9INnt4jgS6IYY6l
        da2xLlLXDz5eTeUQQp4qA8jYPXA5im3GOhBcBYqFLc8ESeYiPlDUuwliDBORT2wcqbbrcl
        ViAebPPtpN607050eyGiILw7k//VXOSSEWtnpnkM0t7WvGsSOCERakX7bW1EA7aSYYDbeH
        Pdk7vMeUu8q02aa4wmeOoLaMX9cW9OHtDiwwPq8n1i9Zyfqhb6AnV6hlPopX8Q==
ARC-Authentication-Results: i=1;
        rspamd-7c478d8c66-rxkkv;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Glossy-Occur: 14fad4f6558d40e0_1660418947679_515662095
X-MC-Loop-Signature: 1660418947679:2770080571
X-MC-Ingress-Time: 1660418947679
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.112.55.233 (trex/6.7.1);
        Sat, 13 Aug 2022 19:29:07 +0000
Received: from ppp-46-244-252-68.dynamic.mnet-online.de ([46.244.252.68]:41390 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oMwoj-00047G-0C;
        Sat, 13 Aug 2022 19:29:05 +0000
Message-ID: <26ee1f572c7b8460edafd07103c29ec8f7c0e214.camel@scientia.org>
Subject: Re: du --bytes show different value for btrfs and e.g. ext4 with
 identical data
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Date:   Sat, 13 Aug 2022 21:29:00 +0200
In-Reply-To: <ab7c756d-c045-bb0f-155e-8ba94ffaf6d7@gmail.com>
References: <533edd660d632b46a0cc6bde07276f07435a84de.camel@scientia.org>
         <ab7c756d-c045-bb0f-155e-8ba94ffaf6d7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 2022-08-13 at 10:30 +0300, Andrei Borzenkov wrote:
> 
> You did not show your actual command which makes it impossible for
> anyone to reproduce it. But my guess is that your du invocation
> includes
> size of directories which is different between different filesystems.

Ah... yes that's the reason.
Unfortunately du has no built-in option to exclude the dirs and count
only the sizes of regular files

But one can do e.g.:
$ find . -type f -print0  | du --apparent-size -l -c -s --block-size=1 --files0-from=-

Thanks,
Chris.
