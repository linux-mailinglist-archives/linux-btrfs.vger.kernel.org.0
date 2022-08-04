Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537FA58952D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 02:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240176AbiHDANv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 3 Aug 2022 20:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239190AbiHDANs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 20:13:48 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63534C632
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 17:13:46 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id F04786C1AD3
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 00:13:44 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 02EE46C16AB
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Aug 2022 00:13:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1659572024; a=rsa-sha256;
        cv=none;
        b=5KQjspxhCp2apSKzIXjIuyR6QuL7n5U2SGZ0OAej4XHY1kbDXhYHHT4qh3IFKNM4ixP7JG
        AxoB0zUPegnT7hkGpRB7aCeXQB6nULrPjNZ3oNwrRiDnqrgYkU8xwAsXbuCS1Eyf39GcZG
        jXoeHTWPMydHNb/ABuIeIfe0jlQy1cJVU9lYV0H0W6jw1gl7UlnD3cvYPANkVKBrFD+ZoT
        QlnKP5LCTxYiAbstzlBfHd0odyjV+ef6MpaQlOLTANno9v/qCsIGo2j3Kyg0tKKtFtd7v7
        RS0xc6PWyZPei9YMkS8ZpymqYSSOUdjBQIsdg3ZN6RKVKVtaPaPDo1z3yOGfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1659572024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YeeKD6eqRMgP/bzTg6VzwK6GGTVipvRLyB013oEJLmA=;
        b=Z5XY3rbWvpsfsmeCDmEPmCCWj5B+OHOVQUlKaoDlmiYIgbtoO0ZssVhQRHBUaWV8FX8A1q
        E9vRO1+ZLym7K1jM2cS9M/RnHqwFvBxIgbUuKu2Rk2hAmgCglXbm3Keba586mvE3/Pcnpi
        0HTPCsPxvtyzLo9V+grnhaEQX5oE5tNepYmguy64RtshWnK/RRH2ziaKnuQiFd58idHdkP
        XHIq2oA+qW4KUGA1WqmRngt3XxYhKMmUW3f/hBIN5+PfFXt9mLxbKKBRcBAG0CKnshQMrG
        BX+xc2SkBqFuALnKD73j9TGCWRfQ6JSzZRYFk6A1G8fWTd3QNVwwdrSmEuU7RA==
ARC-Authentication-Results: i=1;
        rspamd-7c478d8c66-m78gm;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Whimsical-Reaction: 1d4dbe9f23eb73e5_1659572024622_632743764
X-MC-Loop-Signature: 1659572024621:1021411907
X-MC-Ingress-Time: 1659572024621
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.110.28.208 (trex/6.7.1);
        Thu, 04 Aug 2022 00:13:44 +0000
Received: from ppp-46-244-251-215.dynamic.mnet-online.de ([46.244.251.215]:42900 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oJOUd-0002ld-5n
        for linux-btrfs@vger.kernel.org;
        Thu, 04 Aug 2022 00:13:42 +0000
Message-ID: <72eb149a1ca40c7998d212f9b4f4b4bcebc1f656.camel@scientia.org>
Subject: cache and super generation don't match, space cache will be
 invalidated
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Thu, 04 Aug 2022 02:13:36 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.3-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        HAS_X_OUTGOING_SPAM_STAT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

I have this on some filesystem:

# btrfs check --mode lowmem /dev/mapper/data-a-6b ; echo $?
Opening filesystem to check...
Checking filesystem on /dev/mapper/data-a-6b
UUID: d3da2d4b-d570-426f-a3ac-ac6d967a00aa
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs done with fs roots in lowmem mode, skipping
[7/7] checking quota groups skipped (not enabled on this FS)
found 4857668534272 bytes used, no error found
total csum bytes: 4737541408
total tree bytes: 5238358016
total fs tree bytes: 189153280
total extent tree bytes: 90341376
btree space waste bytes: 207077162
file data blocks allocated: 4900744863744
 referenced 4902769897472
0



First it's a bit strange that the generations don't match, cause the fs
was always unmounted cleanly.
Any ideas?


However, the main reason for writing is rather some suggestion for a
cosmetic improvement:

Unlike what btrfs check claims the space cache doesn't seem to be
invalidated, at least not during fsck time (I assume when the fs is
mounted rw?)

Maybe it would make sense to make that more clear in the message?


Cheers,
Chris.
