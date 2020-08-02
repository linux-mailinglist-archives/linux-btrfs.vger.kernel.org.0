Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4712354BF
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Aug 2020 03:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHBBNT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Aug 2020 21:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHBBNT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Aug 2020 21:13:19 -0400
X-Greylist: delayed 351 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Aug 2020 18:13:19 PDT
Received: from smtp.sws.net.au (smtp.sws.net.au [IPv6:2a01:4f8:140:71f5::dada:cafe])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506CCC06174A
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Aug 2020 18:13:19 -0700 (PDT)
Received: from liv.localnet (unknown [103.75.204.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: russell@coker.com.au)
        by smtp.sws.net.au (Postfix) with ESMTPSA id 687E5F883
        for <linux-btrfs@vger.kernel.org>; Sun,  2 Aug 2020 11:07:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
        s=2008; t=1596330437;
        bh=r+pMqMjvycItAfU0YdW0z0eHAYGNXCfNEVQ5kPnFDuA=; l=1803;
        h=From:To:Subject:Date:From;
        b=wuI7kJT5gNY1Gn7xg8uiYvMwpiy4x67CjVkU6rOETDS4qGAtyS4Q48J+sL2dIRWjW
         +WCNoQqlU3vX44bOfIx4zrGVA+3ocNCTZv8ECZhtiqt2n9y1fTe+vwU2CGt/Jxr0Dg
         S/LY1/jPH9DjjlJeGz8YJPyFP3yyfuDfNYVHMRf0=
From:   Russell Coker <russell@coker.com.au>
To:     linux-btrfs@vger.kernel.org
Subject: balance loop with raid-1 on 5.7.6-1
Date:   Sun, 02 Aug 2020 11:07:11 +1000
Message-ID: <13086015.6n0rELWJ5N@liv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My monthly cron job which runs a btrfs scrub followed by a btrfs balance has 
just gone into an infinite loop.

root@xev:~# grep -c "found 69 extents" /var/log/kern.log
322889
root@xev:~# uname -a
Linux xev 5.7.0-1-amd64 #1 SMP Debian 5.7.6-1 (2020-06-24) x86_64 GNU/Linux

Aug  2 02:57:09 xev kernel: [894810.916299] BTRFS info (device dm-1): scrub: 
finished on devid 3 with status: 0
Aug  2 02:57:09 xev kernel: [894810.947243] BTRFS info (device dm-1): balance: 
start -dusage=60 -musage=10 -susage=10
Aug  2 02:57:09 xev kernel: [894810.948707] BTRFS info (device dm-1): 
relocating block group 2734629453824 flags system|raid1
Aug  2 02:57:09 xev kernel: [894811.034399] BTRFS info (device dm-1): 
relocating block group 2659366862848 flags data|raid1
Aug  2 02:57:15 xev kernel: [894816.467989] BTRFS info (device dm-1): found 
12902 extents, stage: move data extents
Aug  2 02:57:40 xev kernel: [894841.585184] BTRFS info (device dm-1): found 
12902 extents, stage: update data pointers
Aug  2 02:57:41 xev kernel: [894842.878672] BTRFS info (device dm-1): found 69 
extents, stage: update data pointers
Aug  2 02:57:41 xev kernel: [894842.915311] BTRFS info (device dm-1): found 69 
extents, stage: update data pointers
[...]
Aug  2 11:04:01 xev kernel: [924022.697116] BTRFS info (device dm-1): found 69 
extents, stage: update data pointers
Aug  2 11:04:01 xev kernel: [924022.754418] BTRFS info (device dm-1): found 69 
extents, stage: update data pointers
Aug  2 11:04:01 xev kernel: [924022.805762] BTRFS info (device dm-1): found 69 
extents, stage: update data pointers
Aug  2 11:04:01 xev kernel: [924022.870560] BTRFS info (device dm-1): found 69 
extents, stage: update data pointers


-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/



