Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3792560967F
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Oct 2022 23:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJWV0J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 23 Oct 2022 17:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJWV0I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Oct 2022 17:26:08 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C754C53022
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Oct 2022 14:26:07 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 02AA86C0D5B;
        Sun, 23 Oct 2022 21:26:07 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0891E6C0686;
        Sun, 23 Oct 2022 21:26:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1666560366; a=rsa-sha256;
        cv=none;
        b=hU+PErFhQwZakJhHy1dgy6k+YGYBWn8lAja9IfiJ9HXcL1slhIiz7jkA1dyB6187DVh+fo
        DlY2gwkfpcf4TmaC1PdeUCN0wQ9HeQEBJhHApKtQJBfq5agwsUknda/SGhNJmaLT4ZaHAr
        niGQFDCcI9fhBS5EsKb2zM1P55pPpgxHrhjJySzdlk7XzpbkXB0fIxptYLgotk2mlLBb5W
        9cyusfsMQSdYy/bkADWFGw4d2++q8cGxgSvhVTcWgbO+FWMTIRDawYXo9ojXq8Tr2zQXSL
        Siysc4CMNEf7BHxX2RVslBsNoIz1w3BQPxsE+/FvV7QP51owRrctTT6uCLO6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1666560366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1BU60qorZmt+Hig06YzSEZRK1KxsEa/YEDesO08vk4=;
        b=I0IPsC3foH9ORWe48AtEzh5wGK9UUJL0ynDArAIYauFmkniiKVl9AAzQbD0GlnSVV3cyln
        ABBI2dKfCyuO/5YqEhDxG1iPGo+nZWN43nEjeAtWn8HF03htpkFagWaPOoB269LxlEXZWz
        KEuZSIoOAGHKF/TAIieSm1iFXka0aIIZgvS02qyVQFuZT98fpIxbm3fhCYsgacR5Dw8Y56
        X9cha+vJZSGg4Wil9YNTqFP3s25r5cPPhkQvztVt/DrFoMUeYghgd3CP6QXsb/E3QuNuOr
        A0li3oMhFoAz02tPGPMk0fHHV0QXqOArNKnobYX75s1lfR42fTJWgsX8eSn/4g==
ARC-Authentication-Results: i=1;
        rspamd-7fb88f4dd5-zsbr9;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Macabre-Spill: 7516cfa403f8b5bd_1666560366655_3241905338
X-MC-Loop-Signature: 1666560366655:2447057646
X-MC-Ingress-Time: 1666560366654
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.106.246.144 (trex/6.7.1);
        Sun, 23 Oct 2022 21:26:06 +0000
Received: from ppp-88-217-43-50.dynamic.mnet-online.de ([88.217.43.50]:49706 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1omiTn-0002T7-U6;
        Sun, 23 Oct 2022 21:26:04 +0000
Message-ID: <4c841441c733161bcca5c2d81e60f2421118fb40.camel@scientia.org>
Subject: Re: btrfs and hibernation to swap file on it?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org
Date:   Sun, 23 Oct 2022 23:25:58 +0200
In-Reply-To: <093db874-03f3-7504-8fd8-488d5ce8ef10@tnonline.net>
References: <31660c315eeba4c461b6006b6d798355696d2155.camel@scientia.org>
         <093db874-03f3-7504-8fd8-488d5ce8ef10@tnonline.net>
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

Hey Forza.

On Fri, 2022-09-30 at 14:12 +0200, Forza wrote:
> Btrfs will not move the swap-file once it is created, so it is ok.

Well, at least as long every current (and future) part of btrfs
remembers that ;-)



>  This brings the limitations as you already mentionee; no 
> snapshots, no datacow, no compression and also no DUP/RAID profile.

But effectively one can make a separate subvolume and just have the
restrictions there? Well at least no snapshots, nodatacow and
nocompression.


> For those reasons I usually prefer to have a separate swap partition
> so 
> that I am free to use snapshots and other Btrfs features.

I'm also kinda inclined to to that, but less because of the feature
limitations and more because I'm a bit wary on how stable or fragile
the concept of the kernel bypassing the fs and directly writing to the
block device is.

OTOH, not having to "waste" considerable amount of storage just for the
hibernation file, would be quite nice.


> If you use 
> dm-crypt you can setup another lv or another partition for swap.

Sure, but again I'd have preferred not to add another DM layer.

And didn't some users recently report some issues with dm-
crypt+lvm+btrfs here?!
But maybe I mix something up and that was something else.



Thanks,
Chris.
