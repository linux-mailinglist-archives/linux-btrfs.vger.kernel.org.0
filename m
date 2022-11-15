Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC1C62A24B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 20:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKOT5F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 15 Nov 2022 14:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKOT5D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 14:57:03 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71163C58
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 11:57:02 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 18EE61409B0;
        Tue, 15 Nov 2022 19:57:01 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 16819140AC9;
        Tue, 15 Nov 2022 19:56:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668542220; a=rsa-sha256;
        cv=none;
        b=3aJLXXKhxEdxFAr+W4EeVWkA4D7eA8V7SrZJO2ZuB0FPTowVsTl5S9kw9K7i0uTY1gI4KJ
        A3bigk8r0t7uUKM795rhX+5C6gRkyD8/Qn+KPCH5SFUfLGo3Xhic0ArRn6QjP6yL9k1u2f
        UB8CH3Jhz8+H/UtP3IMaetNgs1RUuhIiRa3sdJyvUvN/pL/vyOzHyHxbCBB3Jqr8oxy4mu
        MUyd+KtwXaQlCiD7fmqq9wapYZFsO9GUg9h5ZD4zrLpn3twgdqbGwgv3UnqKJwnAz3tf9T
        55B6Yf0GVWpKk3uq7tCjGtlSv1Xz9e6W1jGRK/2rhaNBfPXxj+ftFgJneG23GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668542220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lDmXqkEM46KHHAsyeyblWsMIBh1epx68KG4+aF33SRc=;
        b=x5DY0dBLqQTHX/C/Ysv9PZ/lwPgZbcvcStKh7lSaGlEF51tg6w5ERfdT8E5sZxoxUOtnyB
        458cDa4hZ9ztbu3ULok+rIKInW6Au4WkyuECRCP0k7npoatEUwOJBoBWRtkTRcKfwJIdMj
        hWROk5GOC3WY3lyfgJ8IkQQydoP+Fgas9zqNcmwiTRNeXOt97xGBIKcYMiZyMmCrGCfh+o
        +i02B013kqHaSBd8jYD7iBT1YS9OpszdQ6S+t3q6oUIqkpvqL0AmYHQwu6tyD7LnhrgyPa
        UdmsUH4fXVpPS6OSL/jqyTMtaDQEChOj2NatH0Uz8untJEZxd99QJmEwDe60Nw==
ARC-Authentication-Results: i=1;
        rspamd-5cb65d95c4-qxtjv;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Shoe-Chemical: 6016014353fe81c1_1668542220730_3318791709
X-MC-Loop-Signature: 1668542220730:1964376781
X-MC-Ingress-Time: 1668542220729
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.109.138.54 (trex/6.7.1);
        Tue, 15 Nov 2022 19:57:00 +0000
Received: from ppp-46-244-242-174.dynamic.mnet-online.de ([46.244.242.174]:43816 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1ov23D-00036T-GD;
        Tue, 15 Nov 2022 19:56:58 +0000
Message-ID: <4f3526771aa69fe275693aaa07e98e8e12452e99.camel@scientia.org>
Subject: Re: separate mailing list for patches?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Eric Levy <contact@ericlevy.name>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Date:   Tue, 15 Nov 2022 20:56:53 +0100
In-Reply-To: <48NELR.GD3GOBQRO8OC3@ericlevy.name>
References: <0YIELR.GA2T7GBWR97P2@ericlevy.name>
         <20221115194744.6a343639@gecko.fritz.box>
         <48NELR.GD3GOBQRO8OC3@ericlevy.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2022-11-15 at 14:52 -0500, Eric Levy wrote:
> At any rate, perhaps some subscribers have the preference for not 
> receiving patches, and might appreciate my idea

While I cannot speak for the developers, I'd guess they'd want to keep
*this* one as the development list, and rather have a separate user
list (if at all).


This however has also it's downsides (in particular for the users):
namely likely less attention by the developers ;-)


Cheers,
Chris.
