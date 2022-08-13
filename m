Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242515917C2
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 02:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiHMALl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 12 Aug 2022 20:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiHMALk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 20:11:40 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D018FD56
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 17:11:38 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1D0365A1468
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 00:11:38 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4A0695A1157
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 00:11:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660349497; a=rsa-sha256;
        cv=none;
        b=WxYMTP47vyiTKkkWSRpJ1eNG1ReZJMOrvTyyW/1IP2c3flscujNjj2hRLlXTsdYf2bwlYX
        sTIhEdRRdr6FAm7L47sE7cjp0h7Kc9Qq/ciXd68d9/qZwv2BB0gxo8hinb1u8I1Ndv22nW
        5qGezsNb17dVj5bbepMFwnLpBjAFFXXgR6fuqUhWixtd+TroOnORlUokBezProA1kxfGLY
        2ZY6r56p4l+WhRQ+fuq/GXfsGh2CqQvKtYZ9aiwRUbSfTqlUjufIg3gha3dqDOlaN/2a6Z
        j1LUp0ZMDzL58I6NR4xfl/QrEH9THm/EzF9hmeIelhMkQlfo4jSt4iTX98lg5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1660349497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iSTCC1Wx0gucnQVZBd0RcP3XcKoV67GrA7LnESMgt1w=;
        b=yhnuYriMmxbaCvLh1exCWVeVwg+GJ6Oy22lmcLKtfkRg6u9ABE8zf4l8CCl+XNU0vhXErY
        Bim4OxUhHgRBEjz0GDvFHwR6b3m/sTjTYUn5fkbc4U+mrSuZ5NoomaFYcALR+H8haE73zJ
        1GN1rFmI50k9JqSFaiMURJmtpj9lY1b+hRTGAbLnIQE5dKw34miUlq/3kcQBFRIJgj/pjm
        0tRd3hv6fwG89Lxd+RXFox6Hs122TjN90hAfPXzRMSd8GseC7gRInb34mymikJBOmTqqnZ
        Aw90Hkv0ajaeaMoRjKz+DPzyf1k0zyyeIwA8CBIiaQYml4gUNTsamTDrVyauyA==
ARC-Authentication-Results: i=1;
        rspamd-7586b5656-kskzc;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Trail-Ski: 705fcf191dadcf3d_1660349497779_1886990060
X-MC-Loop-Signature: 1660349497778:137992305
X-MC-Ingress-Time: 1660349497778
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.98.242.216 (trex/6.7.1);
        Sat, 13 Aug 2022 00:11:37 +0000
Received: from ppp-46-244-252-68.dynamic.mnet-online.de ([46.244.252.68]:53586 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oMekY-0000lf-OC
        for linux-btrfs@vger.kernel.org;
        Sat, 13 Aug 2022 00:11:35 +0000
Message-ID: <533edd660d632b46a0cc6bde07276f07435a84de.camel@scientia.org>
Subject: du --bytes show different value for btrfs and e.g. ext4 with
 identical data
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Sat, 13 Aug 2022 02:11:30 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        HAS_X_OUTGOING_SPAM_STAT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

Forgive me if that has been answered before, but I couldn't find it on
the list or the manpage.

I have my personal data on several backup disks, all of them except one
(which is ext4) being btrfs.

The data on them is 100% identical (diff -qr --no-dereference brought
no difference). On the btrfs, the whole data is always in one
subvolume.


Yet, when I do:
  du --bytes (which implies --apparent-size)
I get (in my case):
  5035634863728 for (all the) btrfs
but
  5035836693616 for the ext4

Which is some 192 MiB more on ext4.


Because of --apparent-size, this shouldn't be any refcopy or
compression effects; also hardlinks shouldn't matter (and are the same
on all of the filesystems anyway).


Any idea why the results are different and shouldn't they be the same?
And if not, would it make sense to have this behaviour added to
btrfs(5)?


Thanks,
Chris.

