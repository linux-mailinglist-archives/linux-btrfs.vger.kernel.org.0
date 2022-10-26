Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C20D60EA47
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 22:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbiJZUde convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 26 Oct 2022 16:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiJZUdb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 16:33:31 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7767C33F
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 13:33:30 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 36853540613;
        Wed, 26 Oct 2022 20:33:27 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 583FB540150;
        Wed, 26 Oct 2022 20:33:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1666816406; a=rsa-sha256;
        cv=none;
        b=1bTwQHMigu0WvpWixbCyjfpAoJa/l7bx++CRE1KZg8nMwyxmLSnwtPj462eIb62V1gbV50
        GOMjViWt8yG5fC2o13cDMVe08sb4YrvgsawGxn3K0QySIP92VKD57ZSMGvRVvLCwJJmv0+
        UfHevuGIbJ+Gobl9Qe9/jJgcSnMOBoMVpriVwOyFb6/bAv1/9b3BUTe3iQ5Tk1kZPc/W3i
        GaDGvn9vVH0EyJh2hxGAHPhm9Z6+j9BKco5maZH8Q09/hv/sRtf6aKiqd/4bBQ77jaznKs
        LUwIIYuUT0Xnrrf0MvbGEuVG3cMucMnJAf+OC406KXzdmu55rRalC7gzwwSwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1666816406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uXmGh5K+iUzLMF1VPH9SYFVnpHjeYKiLeK4XmS4+wGE=;
        b=xQ1VP4xuUe2N3zDbuK+x2blsDnfHqXM1ubjRMw0aCxBB2wYuMbD8TikOkMHSUmeNI+O8zh
        PJbKn6PH7uFlUPaZbxccawKkMVV4bg25N4eG5Hfzk0FIsNLhr+I4JdU0V+YvaHoviRuZhy
        /urUualvrGiRsvgewlQ7J/5h4FN7q4hc8pc0bxTwfMOuIcy8wa4gs0JC1lD34xzeWl3lYt
        DRozOgBGUg1WG5ISKzY49VF+FnTcPzkYhdrwPD+Yjqm0E2Z2iWY8VKIjOlEXVc+lvSHnbK
        eQ44YMV0g5ZLy7CPXVZZzXYUsMoGkIIlmOg3qnhi3pPBq8ZQ2tU13394sI+ivQ==
ARC-Authentication-Results: i=1;
        rspamd-7fb88f4dd5-qdsxl;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Obese-Share: 78db76c041deee80_1666816407071_1816131349
X-MC-Loop-Signature: 1666816407071:3866917348
X-MC-Ingress-Time: 1666816407070
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.126.154.5 (trex/6.7.1);
        Wed, 26 Oct 2022 20:33:27 +0000
Received: from p54b6dffd.dip0.t-ipconnect.de ([84.182.223.253]:38096 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1onn5V-0000Ze-9t;
        Wed, 26 Oct 2022 20:33:24 +0000
Message-ID: <5d59652451decb86786ff2dff9e4ffe3843f143b.camel@scientia.org>
Subject: Re: Lenovo X1 - kernel 6.0.N - complete freeze btrfs or i915 related
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Norbert Preining <norbert@preining.info>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Wed, 26 Oct 2022 22:33:19 +0200
In-Reply-To: <Y1krzbq3zdYOSQYG@bulldog>
References: <Y1krzbq3zdYOSQYG@bulldog>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey Norbert.


On Wed, 2022-10-26 at 21:45 +0900, Norbert Preining wrote:
> The laptop is freezing like hell. At the moment it hangs reproducible
> on every boot after a few seconds (around 20?).

Could it be the issue that has been reported independently by several
users?

E.g.:
https://lore.kernel.org/linux-btrfs/2291416ef48d98059f9fdc5d865b0ff040148237.camel@scientia.org/T/#u
https://lore.kernel.org/linux-btrfs/1c531dd5de7477c8b6ec15d4aebb8e42ae460925.camel@scientia.org/T/#t
https://lore.kernel.org/linux-btrfs/Y1krzbq3zdYOSQYG@bulldog/T/#u
https://lore.kernel.org/all/10522366-5c17-c18f-523c-b97c1496927b@net4u.de/
https://bugs.archlinux.org/task/76266
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1022848



Unfortunately, except for Josef Bacik's reply
(https://lore.kernel.org/all/Y1aeWdHd4%2FluzhAu@localhost.localdomain/)
there hasn't been any further word on this from any btrfs developer, so
it's hard to tell for people whether that issue could have caused any
further corruptions on the affected filesystems.

Also, in my case... I noticed the issue on some mv operation, as well
as on send|receive.... but otherwise I could mount my space cache v1
filesystems just normal without and lockups.
So it's also unclear, why it doesn't always show up.



Cheers,
Chris.
