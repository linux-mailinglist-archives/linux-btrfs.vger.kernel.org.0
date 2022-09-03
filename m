Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCB85AC18E
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Sep 2022 00:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiICWLU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 3 Sep 2022 18:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiICWLS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 18:11:18 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA782408A
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 15:11:17 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 213AC22670
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 22:11:17 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5BAA3222C5
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 22:11:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662243076; a=rsa-sha256;
        cv=none;
        b=njVzpZmyButp4vHwHDD30bzvf0A8iS2cuXYjS1k9K0hnuh30gJbJ7KzPoYEN5Jv2RcnsX7
        VNMkR0dTmDTLO8LDAKb3pQXOS17ZDn02H9zCfxBCZHpbG6pGXSKWt2T2Bd/svPBW97vfDC
        aF34mIuljFt+t6DcTh2i1g7+0K7FCUTjgMF1ZE5KbUHuWdUjVoqCckuQxJMInYklJJhO3U
        km1WqYoDsdSiYsmE0ufRlQNMLhspU01jux/FnZ/NEnB+Hqb2yxVx2ckMc6FE27GkUU9bKD
        65aHXhjs56pQJalwdAOvtFZpjUlZWDKcpeiCHmEqPJ/nRWaTG55CO/o2Rc9zlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662243076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=giIYLqODxENK/Hq3RaJL63zape/A/E6TncT/ORU3jl4=;
        b=2gYawQM7pGauTrIHshRCD3SH54suvthTZy8DsLq1EqOlVUktG97/Do4qroP2MgfFQVcQqt
        KHQi2RMLn1WRoy9iGa5OkDu6ksKLQbKYiIJB56qoF1XJu102KICH+88ouQ+XDjh8bb3P/m
        f+2VVnbbWXYVblit8TV0r7HSxFB/Td/JrKGtyqbCuOtrtf78VeQhyxE43FKUk4x9qRLD5k
        R+QH/vUdzxOpYqQj0LzF192969ya8Usn4OQwX0MYeu4doJlomGhRBHB9Ke2vTW5HkvI7Vn
        4oKX/h0Vjq7VNm7TOQ3Xis3riCXThLJs0ml1CDEKYUa3mQaY+90ulTmDx6PSRA==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-kjjv2;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Abaft-Desert: 349d8aac2e5cca77_1662243076857_3434432651
X-MC-Loop-Signature: 1662243076857:1085206453
X-MC-Ingress-Time: 1662243076857
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.121.210.155 (trex/6.7.1);
        Sat, 03 Sep 2022 22:11:16 +0000
Received: from ppp-46-244-252-68.dynamic.mnet-online.de ([46.244.252.68]:39168 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oUbM9-0006bA-H9
        for linux-btrfs@vger.kernel.org;
        Sat, 03 Sep 2022 22:11:14 +0000
Message-ID: <aece9d0d0f51f70b1e77bda701a6d4c4f860f518.camel@scientia.org>
Subject: Re: btrfs check: extent buffer leak: start 30572544 len 16384
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Linux BTRFS <linux-btrfs@vger.kernel.org>
Date:   Sun, 04 Sep 2022 00:11:09 +0200
In-Reply-To: <d8b54f683ae5e711c4730971f717666cfc58f851.camel@scientia.org>
References: <d8b54f683ae5e711c4730971f717666cfc58f851.camel@scientia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-1+b1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-0.5
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btw: This is on Linux 5.19.6, i.e. supposedly with the free-space-cache
v2 corruption fix.


But a freshly created fs with:
mkfs.btrfs -R ^free-space-tree

does *not* show the:
extent buffer leak: start 30687232 len 16384


Kinda loosing my trust in v2 space cache ;-)


Cheers,
Chris.
