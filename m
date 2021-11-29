Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272564627FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 00:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhK2XRa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 18:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhK2XRP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 18:17:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B768C061758;
        Mon, 29 Nov 2021 15:02:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A7893CE13DF;
        Mon, 29 Nov 2021 23:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C16C53FAD;
        Mon, 29 Nov 2021 23:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638226936;
        bh=WaUWXxNKGrqJexnmsIfPnE6pHCB4zCYmP3pB5o5fl4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RnO0pin373qkyR601VSZts28ERAF6PB1mETGFiRk2t/ljAes7cDjSmd4sUBCJvGCm
         5jOFzGlduN9ZAz7BMSGZQ2p4m2X8W8vUIPlaEEQ4/Q4iowBS1+/PYkbjR7qahlTcb8
         00eUCrljdvyaG7szImq/EvZ+8F/EETU6zdZF73WYTxj3ccHLLv4XXvuf0bGbmJeuY9
         xZtJNH/KBEDXDqL6joqvFfHiyFmjso95jlTgEM1p6+QtBNLnR7fIVpmz3V9NE8onSn
         exesyViGwmybqVtqCFbqzAwsVvBXkMxlNUP0Uwiq2UekBxQR1S9F2LPXZ3HnWM3G6w
         NlDg321vildsg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/3] btrfs: Use generic Kconfig option for 256kB page size limit
Date:   Mon, 29 Nov 2021 16:01:40 -0700
Message-Id: <20211129230141.228085-3-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129230141.228085-1-nathan@kernel.org>
References: <20211129230141.228085-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use the newly introduced CONFIG_PAGE_SIZE_LESS_THAN_256KB to describe
the dependency introduced by commit b05fbcc36be1 ("btrfs: disable build
on platforms having page size 256K").

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/btrfs/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 520a0f6a7d9e..183e5c4aed34 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -18,8 +18,7 @@ config BTRFS_FS
 	select RAID6_PQ
 	select XOR_BLOCKS
 	select SRCU
-	depends on !PPC_256K_PAGES	# powerpc
-	depends on !PAGE_SIZE_256KB	# hexagon
+	depends on PAGE_SIZE_LESS_THAN_256KB
 
 	help
 	  Btrfs is a general purpose copy-on-write filesystem with extents,
-- 
2.34.1

