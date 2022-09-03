Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B19C5AC174
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 23:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiICVui convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 3 Sep 2022 17:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiICVuh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 17:50:37 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC2912614
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 14:50:35 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2B1EC3C121F
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 21:50:34 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5798F3C1169
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 21:50:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662241833; a=rsa-sha256;
        cv=none;
        b=V9S/l6wPSk/fFLlJw0HLdhZ7qGCIN8VlT7cPkvd1Z/aXqVi6IX4mMggUDjS2PTFpBpCfHC
        5SyEMIBzmAzlCq6MyBj4blnG04E/SCDlgbjO40TDwP+vp1tw/ZTEZbNXn6UOg2Dph7J8MC
        kgjs438jBkVzNrPv60ivVbJ3jqhmuMkAuaFHqu5UQty36dEdloqELDtm7f2RkvWdt8ZyUA
        hTk/hfj6eq1GDRFviSUN47c0ktMatTwzRcE89DQMxceLy6XySjZbavvnyj6xepgamjLdkE
        mQ6XUSI+jDtyzUav/d6JvV3SfNma1cFn2ymZ9r6r9ydR5N9Eowq08e+DHTV3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662241833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=04GuEp5uR7WAwx1RICuppPnqDlg0TUq0WKhxzr+aXOc=;
        b=srMgvMXfJAicEo03fJTRAFbk5KNGfSF9JmvSRYMPPoA+tZxmAjZoa/sVE6AU920jlAJ6VS
        xH1K8l854WOfOlCemIfxSXS9m/ZHrW5/RXxYfSD4w+q9BJNyN5VC4+zoYHr/yhAJmwUPWJ
        dXl9zC2yMcIy2d5pepzbhmP+5z25aW4rj2RTHAj72sq25PHgiRU6IDbTr7LimS+I0KdcaL
        WJQAtUtPf455yIlRjYuMlCl7obwFiiZcND5v7Fi8EaBsasiMDYYRaFYojeaAqr/b5OLB8a
        Fu4SiqCuViXRi9aVj3gJ0zgyssBWlhNFuVHaRl55IjSBwqrOo9aD+Rs5TFARRg==
ARC-Authentication-Results: i=1;
        rspamd-f776c45b8-4hrph;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Power-Daffy: 613fbbe55d217ab3_1662241833832_3403100123
X-MC-Loop-Signature: 1662241833832:3016766880
X-MC-Ingress-Time: 1662241833831
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.98.142.80 (trex/6.7.1);
        Sat, 03 Sep 2022 21:50:33 +0000
Received: from ppp-46-244-252-68.dynamic.mnet-online.de ([46.244.252.68]:56350 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oUb26-0006Xh-6r
        for linux-btrfs@vger.kernel.org;
        Sat, 03 Sep 2022 21:50:31 +0000
Message-ID: <d8b54f683ae5e711c4730971f717666cfc58f851.camel@scientia.org>
Subject: btrfs check: extent buffer leak: start 30572544 len 16384
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Linux BTRFS <linux-btrfs@vger.kernel.org>
Date:   Sat, 03 Sep 2022 23:50:26 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-1+b1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-0.5
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,
        HAS_X_OUTGOING_SPAM_STAT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

On a freshly created, never mounted btrfs I get a new:
extent buffer leak: start 30572544 len 16384

with btrfs-progs 5.19:

# btrfs check --mode lowmem /dev/mapper/data-a-1 ; echo $?
Opening filesystem to check...
Checking filesystem on /dev/mapper/data-a-1
UUID: ff14e046-d72c-4671-b30a-6ec17c58a0f1
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs done with fs roots in lowmem mode, skipping
[7/7] checking quota groups skipped (not enabled on this FS)
found 147456 bytes used, no error found
total csum bytes: 0
total tree bytes: 147456
total fs tree bytes: 32768
total extent tree bytes: 16384
btree space waste bytes: 140595
file data blocks allocated: 0
 referenced 0
extent buffer leak: start 30572544 len 16384
0
# btrfs check /dev/mapper/data-a-1 ; echo $?
Opening filesystem to check...
Checking filesystem on /dev/mapper/data-a-1
UUID: ff14e046-d72c-4671-b30a-6ec17c58a0f1
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 147456 bytes used, no error found
total csum bytes: 0
total tree bytes: 147456
total fs tree bytes: 32768
total extent tree bytes: 16384
btree space waste bytes: 140595
file data blocks allocated: 0
 referenced 0
extent buffer leak: start 30572544 len 16384
0


Is that just some diagnostics or what does it mean? "leak" never sounds
so good ;-)

Thanks,
Chris.
