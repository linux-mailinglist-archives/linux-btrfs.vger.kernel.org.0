Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE625AC1A7
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Sep 2022 01:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiICXAr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 3 Sep 2022 19:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiICXAq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 19:00:46 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621503D580
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 16:00:45 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 27148820415;
        Sat,  3 Sep 2022 23:00:44 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3046882058B;
        Sat,  3 Sep 2022 23:00:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662246043; a=rsa-sha256;
        cv=none;
        b=FoeeDn8wGTM1Zico8oTtsUPWrAr6kMT8C8JFMRPtZK9/uc0kMM7Paj8UDmTDC8onwCcjnk
        SpRbrpD6wqdwfaGBYL9TMTaZlm5U/4/FdmNtEV9EyA9SU+lgPglY15QUz+5nV9TG0e0mvL
        KYgGVaLcO+4eZi4bsbhpjJO/1RnPs/2qyrlAq6mByNiUTWZKBWlfdC/JGlgbTK3cZR+kNz
        uuz7jKa+4pdOJZe/KkuCF2bc/VV8+4xCaAyo0gXlcXEbW5u1AuTRnn6zmpyDZS2gLIPYDB
        /hsQeczGmY7IOMl8ZLk1TuDVV0gzazfzik43/b7YpQCEH6eK80l+0vpZdCay1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662246043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlwjp+WMMQp/4aaTH74ebGbOHzz7vY6/+VlQZlIdZT0=;
        b=uAX1W9fQPeUtR4sDfaX4VV5RuC/FA0Fmn/aPaQsgPjtir4Msmb9Li7cea189Qc/VbLioES
        c1CCt1Shzuu+x8lqWmqQaQkRC3CihcM/xi6JEJgbNU3cozxhVuGFZoT6aJorsSScn25iy3
        LcpOVzElTG5vLFxUFlSwdWAZ7xBxTGP8S22lSRAl9LMj/ijnysA7S8RafLeTK5cf66aDkT
        3bua8EMvhYIUdWAbadDZ28Cu2cHVnmZ8tjUtLNoGZ/Ibmz4nfcsg0xeZeSMT9+zvQP0U/k
        P5MFFgRhIrXkfrHav9NNak9dP0bgJLRbKqZXpoeNXUcp3oLaON1CvFsHpx3WoQ==
ARC-Authentication-Results: i=1;
        rspamd-f776c45b8-s42hp;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Whimsical-Share: 568046b154570284_1662246043807_3031133193
X-MC-Loop-Signature: 1662246043807:1341097686
X-MC-Ingress-Time: 1662246043807
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.123.39.217 (trex/6.7.1);
        Sat, 03 Sep 2022 23:00:43 +0000
Received: from ppp-46-244-252-68.dynamic.mnet-online.de ([46.244.252.68]:52040 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oUc80-0000Gp-Da;
        Sat, 03 Sep 2022 23:00:41 +0000
Message-ID: <5052c751772dd32713db530191a4fb8a4ad724df.camel@scientia.org>
Subject: Re: btrfs check: extent buffer leak: start 30572544 len 16384
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Linux BTRFS <linux-btrfs@vger.kernel.org>
Date:   Sun, 04 Sep 2022 01:00:36 +0200
In-Reply-To: <31ed8b19-ce24-67f8-8567-506d84cd5f4a@gmx.com>
References: <d8b54f683ae5e711c4730971f717666cfc58f851.camel@scientia.org>
         <aece9d0d0f51f70b1e77bda701a6d4c4f860f518.camel@scientia.org>
         <31ed8b19-ce24-67f8-8567-506d84cd5f4a@gmx.com>
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

Hey Qu.

On Sun, 2022-09-04 at 06:58 +0800, Qu Wenruo wrote:
> Already known and fixed:
> https://patchwork.kernel.org/project/linux-btrfs/patch/043f1db2c7548723eaff302ebba4183afb910830.1661835430.git.wqu@suse.com/

As far as I understand this means that there's only an error in the
check,... but the filesystem itself is perfectly fine?


Thanks,
Chris.
