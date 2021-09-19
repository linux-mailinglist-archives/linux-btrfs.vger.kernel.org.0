Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDBC410DA5
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 00:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhISWmK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Sep 2021 18:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhISWmK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Sep 2021 18:42:10 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C290C061760
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Sep 2021 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3CRX9/FrZ4fMbEfmxE7zzi3Oj63MQwW2mmB5QSuf0eY=; b=UrIakf2IdHFyMHo0FzNJ9yG1Mb
        LpRUkkIsy5UfPTrfNhyQaTro7JyooEs+z73d2tcUCrqYBUU1hMWTHn2vHQrytKgvMPCkGzbE8UZAY
        Jm6lslvMeADImcma9P3FgI8dlblrllbESmD8s6Ql+wzFvY5aSZ8RICiKdq/Sq+qLKlLUHw4JsGBW5
        7aKmkEUqDvQsRP8xdddV0XuHBWWA4Ql17kJzdrwkZfjFZboEi3azD7F6FtjVpENArkYNGrCzpLj9j
        38UzKNCXQ1JZipAManQb3bLNylLW44LRnrVcKcZBfohwAP9rzPcZBBemc9dheQOMPOI5V3LrOaiZN
        xjEYjNQw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41452 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1mS5UF-00018r-EE; Sun, 19 Sep 2021 23:40:39 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1mS5UF-002wsg-0c; Sun, 19 Sep 2021 23:40:39 +0100
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix initialiser warning in fs/btrfs/tree-checker.c
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1mS5UF-002wsg-0c@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Sun, 19 Sep 2021 23:40:39 +0100
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Debian gcc 10.2.1 complains thusly:

fs/btrfs/tree-checker.c:1071:9: warning: missing braces
around initializer [-Wmissing-braces]
  struct btrfs_root_item ri = { 0 };
         ^
fs/btrfs/tree-checker.c:1071:9: warning: (near initialization for 'ri.inode') [-Wmissing-braces]

Fix it by removing the unnecessary '0' initialiser, leaving the
braces.

Fixes: 1465af12e254 ("btrfs: tree-checker: fix false alert caused by legacy btrfs root item")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 fs/btrfs/tree-checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index a8b2e0d2c025..1737b62756a6 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1068,7 +1068,7 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 			   int slot)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
-	struct btrfs_root_item ri = { 0 };
+	struct btrfs_root_item ri = { };
 	const u64 valid_root_flags = BTRFS_ROOT_SUBVOL_RDONLY |
 				     BTRFS_ROOT_SUBVOL_DEAD;
 	int ret;
-- 
2.30.2

