Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC165B6476
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 02:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiIMAKu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 12 Sep 2022 20:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiIMAKt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 20:10:49 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4304B4A116
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 17:10:47 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 25C7F5C09A1;
        Tue, 13 Sep 2022 00:10:47 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 157D05C0B28;
        Tue, 13 Sep 2022 00:10:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1663027846; a=rsa-sha256;
        cv=none;
        b=hjKBXEHgDF+F5BE+5zhr76iwvyTfBTx9tnKnPaStJylsLD62GZg7M6C5ZeboAVbAGZevHt
        U9CLoMydDlE1RYakmPrRAVfJcIo6Drry4iadxcbpnOO7zT02fWWaNyPW602cgxnMb8cf4M
        zet+/41KlXQ/FGLl4EtmW4Dh55D84uT0W4BAn5yWAyZd/pKncrpLIZiWJ5f2PunXfFj09a
        yJQe3dq221afjKgEWKY6DFIKn3/3vcVc6c2vtHdJq4T/p5mMQkaYUP44/DUpKtPsaBZNij
        +d99vECGkiexyAR2vRJDLIZSakezJTSkLgAu8kwecW4mWvdIOderEUxjXiVUgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1663027846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o8wtAEOjvd+AdP/75k0oO42pGCQQ2sXXBV8BSQtV+gQ=;
        b=0r/M4YPxyoQuwlwyXzD0eeaW9KCIU0ZCWbWLVDhNDLJqoQm2BVATu52DfRqfQFJHy5khF0
        RJNkKWGZ5QqypoQ0iF4F4B3wcZbPWnAJjMt/Iz5y/P8SzzBo1+NOv9d6wXTbkVZvhAjC4R
        oPZPWYW6FsGDeN6pbz3AsKC+EACreQ4LVRoIT64uUUufPPh8K7JIgyrQRO+YqXS2m4vLzr
        krVGiHPhNb6ZEdy0TP81w2JIKoRaMXf5LoyVPKfBduw41QGUbpAPhkJf5nABnGLosEyt8v
        3uKi8lRJDKpoJw+k3tZz357r9qF/6qYlQpIMXTOliZV5RRd/9fI4n4ZkTFjDpw==
ARC-Authentication-Results: i=1;
        rspamd-f776c45b8-ftkfr;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Well-Made-Duck: 07860b892b468916_1663027846554_1617326336
X-MC-Loop-Signature: 1663027846554:3235136429
X-MC-Ingress-Time: 1663027846554
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.98.142.80 (trex/6.7.1);
        Tue, 13 Sep 2022 00:10:46 +0000
Received: from ppp-46-244-252-68.dynamic.mnet-online.de ([46.244.252.68]:45062 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oXtVh-0001Eh-1u;
        Tue, 13 Sep 2022 00:10:44 +0000
Message-ID: <b2f26520f1d000e074d79b5523c5416dc7dc51fe.camel@scientia.org>
Subject: Re: scrub results by email
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     "Kengo.M" <kengo@kyoto-arc.or.jp>, linux-btrfs@vger.kernel.org
Date:   Tue, 13 Sep 2022 02:10:38 +0200
In-Reply-To: <p06001014df4577e8554b@kyoto-arc.or.jp>
References: <p06001014df4577e8554b@kyoto-arc.or.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.45.3-2 
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

On Tue, 2022-09-13 at 09:00 +0900, Kengo.M wrote:
> I would like to send results of btrfs scrub by email.
> How are you all doing?

That's not really a btrfs specific question... but try using btrfs-
scrub’s -B option.


Cheers,
Chris.
