Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F2873957F
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 04:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjFVCXn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 21 Jun 2023 22:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFVCXl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 22:23:41 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB161A1
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 19:23:40 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5A95082087C
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 02:14:03 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 697F88212FF
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 02:14:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1687400042; a=rsa-sha256;
        cv=none;
        b=Fhqw1QzjJFEe2NHevjlTtlTxQ+zQHYtKmSGqjJOSsuJh+RPdGtZGOfeILfB9nRfkTpzK9A
        iXhb5TwTdSOl+n3rLo8BT+fdMRXHKTVqk6T5+Me7FfQbbeEdVSk+b0H2UGvElsrYUDM6gz
        tP/vnlaRH/M7jLRDV99vnxnYDP2FxnDUDoM0p0dPspyhxU7WcJEiHbOzSHO6MKiDceDG2V
        WtDIfsEnmbq4sEza5BeMcfBjMgjTgPkRX0JZUzBVK+R2lZ6iFCcuDox4kDZuc99NstVT+d
        bG/cg7znyAZ9clINs5Dv/BNspMX1Q4clBvhM9Q6YEgxMrnFy74V5pE/e4Vjg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1687400042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lKQCvetYSZGHp9wgrW/KlmpqhYe1zSbmA061lxb5Ke4=;
        b=X5FIpMJHEezFuMIvowFmp0EWnW1QQDnvmJjLPXG3CFI4Y4lW0CbmH6UHrfJqEZqQ/KdLcO
        zEB5yUsFxf4Ej8wpx3tCVBmN4hl6K4SglSkmk9LBqnv3YVKeBJPSiWN8zC3t81gY+Kzjhk
        lL+Kr1f5/zIyaQ4EvAJtAazK8Lxn/yeszovFj1emNZmzOaZ7XSMYrEmkRQeXu55tG/7LtH
        UxVYmF5X/0F/yCs7p3AgAKchFVF5lYMFEVVWQKSVpAu5lRwGofLMO6u2knzc6cyT9rrtLH
        00YP5kuMIuhq9yQH0w9wyJhDIfJvOrimQLSEfxnHFUgC0pcqeWoalfzm8jhW/Q==
ARC-Authentication-Results: i=1;
        rspamd-85899d6fcc-c749q;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Tangy-Language: 6175ddbc7c0c8e70_1687400042931_2030389506
X-MC-Loop-Signature: 1687400042931:2298452461
X-MC-Ingress-Time: 1687400042931
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.125.42.143 (trex/6.9.1);
        Thu, 22 Jun 2023 02:14:02 +0000
Received: from p5090fc90.dip0.t-ipconnect.de ([80.144.252.144]:44400 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <calestyo@scientia.org>)
        id 1qC9pe-0077gz-0R
        for linux-btrfs@vger.kernel.org;
        Thu, 22 Jun 2023 02:14:00 +0000
Message-ID: <3c63874fbadcfa13ca6a6178242328deb81b8cd0.camel@scientia.org>
Subject: how to (space-)efficiently store XATTRs in btrfs?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Thu, 22 Jun 2023 04:13:55 +0200
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


I want to attach hashsums (of their data) to files as XATTRs, using
possibly more than one hash algo.

So for a file whose content is "foo", I'd have something like:
SHA2_512 = 0cf9180a764aba863a67b6d72f0918bc131c6772642cb2dce5a34f0a702f9470ddc2bf125c12198b1995c233c34b4afd346c54a2334c350a948a51b6e8b4e6b6
SHA3_512 = 6f1b16155d5f87af947270b2202c9432b64ff07880e3bd104a50605bc0f949d4e4bf30cddbb257a7f3a54881429f45efdb43fbe14371f9f7f5cb16789db9175d


Now I wondered which is the best way (from a btrfs PoV) to store that,
primarily with respect to space usage, and only secondarily with
respect to read/write speed.


1) It seems the XATTR value can be binary, i.e. including 0x0, right?

So does it make sense to convert the hash into its raw binary form, or
is there anyway some minimum amount of storage that btrfs takes per
XATTR, regardless of whether that's fully used or not?

If so which is that? Or is that made in bunches?


2) Similarly, is there an actual gain by using a shorter XATTR name or
does btrfs anyway allocate larger amounts for that, regardless of how
long the name actually is.

E.g. is
  user.SHA2_512
actually more space efficient than e.g.
  user.20b48846-10a2-11ee-88a2-7fd320700bfd.SHA2_512
where I'd have prefixed a UUID to (hopefully) avoid naming collisions.


3) Would I gain any advantage by placing multiple hashes in one XATTR,
instead of one XATTR per algo?
I mean I could do e.g.
  user.SHA2_512 = "0cf91…"
  user.SHA3_512 = "6f1b1…"
or all in one:
  user.hashes = "SHA2_512=0cf91…,SHA3_512=6f1b1…"


Thanks,
Chris.
