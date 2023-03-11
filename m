Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5156B5F55
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Mar 2023 18:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjCKRqt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 11 Mar 2023 12:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCKRqr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Mar 2023 12:46:47 -0500
X-Greylist: delayed 349 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Mar 2023 09:46:41 PST
Received: from sm-r-011-dus.org-dns.com (sm-r-011-dus.org-dns.com [84.19.1.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A8B40CB
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Mar 2023 09:46:41 -0800 (PST)
Received: from smarthost-dus.org-dns.com (localhost [127.0.0.1])
        by smarthost-dus.org-dns.com (Postfix) with ESMTP id 8248CA03FC
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Mar 2023 18:39:48 +0100 (CET)
Received: by smarthost-dus.org-dns.com (Postfix, from userid 1001)
        id 75DF7A056B; Sat, 11 Mar 2023 18:39:48 +0100 (CET)
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from ha01s030.org-dns.com (ha01s030.org-dns.com [62.108.32.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smarthost-dus.org-dns.com (Postfix) with ESMTPS id 1016AA03FC
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Mar 2023 18:39:48 +0100 (CET)
Authentication-Results: ha01s030.org-dns.com;
        spf=pass (sender IP is 94.31.96.101) smtp.mailfrom=hendrik@friedels.name smtp.helo=[192.168.177.41]
Received-SPF: pass (ha01s030.org-dns.com: connection is authenticated)
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     linux-btrfs@vger.kernel.org
Subject: Does it recover automatically? csum failed root -9 ino 261 off
 458928128 csum
 0x12f4019f expected csum 0x8bc10ca8 mirror 1
Date:   Sat, 11 Mar 2023 17:30:15 +0000
Message-Id: <emff14759c-322f-4c89-9c4f-252abeb71deb@59307873.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-PPP-Message-ID: <167855582335.26549.4195084997433320237@ha01s030.org-dns.com>
X-PPP-Vhost: friedels.name
X-POWERED-BY: wint.global - AV:CLEAN SPAM:OK
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I don't quite understand, why my disk is almost full. Thus, I ran btdu.
This showed me 50GiB as ERROR:
--- INFO: /<SINGLE>/<DATA>/<ERROR>/logical ino/ENOENT 
--------------------------------------------------------------------------------------------------------
...
--- Explanation:
Not an actual error - btrfs simply reports that there is nothing at the 
random sample location that btdu picked.
This most likely represents allocated but unused space, which could be 
reduced by running a balance on the DATA block group.
Note that even though this node is categorized as an error in btdu's 
hierarchy, it does not actually indicate a problem with the filesystem.

So, I ran a balance

btrfs balance start -dusage=35 ./

this stopped with an error.
ERROR: error during balancing './': Input/output error

Dmesg showed me:

[Sa Mär 11 17:53:23 2023] BTRFS info (device sda3): relocating block 
group 254498832384 flags data
[Sa Mär 11 17:53:24 2023] BTRFS warning (device sda3): csum failed root 
-9 ino 261 off 458928128 csum 0x12f4019f expected csum 0x8bc10ca8 mirror 
1
[Sa Mär 11 17:53:24 2023] BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 61, gen 0
[Sa Mär 11 17:53:24 2023] BTRFS warning (device sda3): csum failed root 
-9 ino 261 off 458928128 csum 0x12f4019f expected csum 0x8bc10ca8 mirror 
1
[Sa Mär 11 17:53:24 2023] BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 62, gen 0
[Sa Mär 11 17:53:25 2023] BTRFS info (device sda3): balance: ended with 
status: -5


So, there was some corruption on drive level, I suppose.

Does btrfs recover from this on its own? Or should I run a scrub?

Best regards,
Hendrik


