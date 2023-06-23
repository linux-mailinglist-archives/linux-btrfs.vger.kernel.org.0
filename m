Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D60273BE4E
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jun 2023 20:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjFWSKc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 23 Jun 2023 14:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjFWSKb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jun 2023 14:10:31 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF7A2707
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 11:10:25 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 264C06C156A;
        Fri, 23 Jun 2023 18:10:24 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0CDC66C1335
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jun 2023 18:10:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1687543823; a=rsa-sha256;
        cv=none;
        b=JvUvBX+mAhhO1HZ3uc2CFQf8dduprzatvNVDvkcw65nU/FRMBX5Fl47+2D+Umi0VI4BSvR
        uxcZVRSwFfj2RM0KXG9AzGRu9/TNXgjiKEz2EnbHvfq+FTgtdmwrvaYfpvGP1Exe5xRti8
        J9fBVXLuzzydug5gYUBC6IaalYi18y6Djmynw4UlnFmlqWps5YkTrUulSdYmkBUiUnTZpT
        z7p7y8vRxS9ib+iHg4Hx6mfShKa0YK6BBlqvuGuuH9+I/XkO3kzzi3S5HOxuEhG3JlqODC
        7PZDwXds7sgbYiH54q4y7kpfKFCvfdqy4LpvUyJ8U/ivnX5I5teQrh41w8X+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1687543823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EROT3GQ4apwPjrqJ+taNYLXZyWl+gbBv/kXfB4+xWnM=;
        b=zVSltb0zCa1yK99setGkQA/P81cPG7qhq71C+6Rgfsq0+C8blqgVrHhAg1Go3owuc/MjUd
        +iTR0EMfJH6ZTz2a3O6tK9h2iBRa8IVevPO0EaCosN/xGuVK3I1a22sjkxUkrM5fVg+Bp/
        /d5I2R594CobqXudkFTGR/tu2U+VzimOb4GJmKNLokt+aXwMlmsHfiaOgwpmBKdxyuaV6D
        qjkvFc/HasCebndru0BaZMGQb1x6L/5hOEVuWMwvU0zUprE8k261QNMl+2Frpz1RhyoH2H
        jWvyi2LKoFTrrKBW9dCVkqaJlQ9a6HdjKusqcU2yOqV/XmNjF5jguylcq4+UHQ==
ARC-Authentication-Results: i=1;
        rspamd-9fcc56855-jzllm;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Plucky-Spicy: 783339ad4afc89b2_1687543823763_3612023313
X-MC-Loop-Signature: 1687543823763:2179889024
X-MC-Ingress-Time: 1687543823763
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.126.30.17 (trex/6.9.1);
        Fri, 23 Jun 2023 18:10:23 +0000
Received: from p5090fc90.dip0.t-ipconnect.de ([80.144.252.144]:54884 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <calestyo@scientia.org>)
        id 1qClEg-00CKj3-2M
        for linux-btrfs@vger.kernel.org;
        Fri, 23 Jun 2023 18:10:21 +0000
Message-ID: <beb5543f2944b9e40cfa1387e5ed1c01d06e0b65.camel@scientia.org>
Subject: Re: empty directory from previous subvolume in a snapshot is not
 sent|received
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Fri, 23 Jun 2023 20:10:15 +0200
In-Reply-To: <d7905c54-e8bb-882c-8e7c-048dfe865ee2@gmail.com>
References: <ea6099a3cff73c20da032afaaeb446c0b12ec1da.camel@scientia.org>
         <9fd09e52-e77e-415b-bd95-9c58dde263d0@gmail.com>
         <bbccd0204d2951f54f4303aca3af1b6dab2c3108.camel@scientia.org>
         <d7905c54-e8bb-882c-8e7c-048dfe865ee2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3-1 
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.


On Fri, 2023-06-23 at 07:55 +0300, Andrei Borzenkov wrote:
> It is not directory. It is "orphan subvolume graft point" for the
> lack 
> of better term.

Ah I see. Thanks.

I think this deserves being added to the btrfs(5) manpage, so I made a
ticket about it at:
https://github.com/kdave/btrfs-progs/issues/644


Thanks,
Chris.
