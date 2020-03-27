Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7013B195F85
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Mar 2020 21:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgC0UVm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Mar 2020 16:21:42 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.189]:25579 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726710AbgC0UVl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Mar 2020 16:21:41 -0400
X-Greylist: delayed 1417 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Mar 2020 16:21:41 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id D44D16CB0E4
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Mar 2020 14:58:03 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id Hv7CjBGP3EfyqHv7Cj9KKG; Fri, 27 Mar 2020 14:58:03 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BeuzSJqhbI7Sy5DD0lNgT5zLFB8JnttXuEFOYmqN6kg=; b=aFl/tKHUcDOoccm3ZhoAJyW+Qd
        jnJcRS9T5IDzI0En1j7D1Ughj2qYWI3kNrZR4CrNM9XCU2Jg9ULCFOS11ok/30BuAFmFd6fPu34z0
        /pTZPBje0fYlVqHrHh9Ogcm4pRvOwjcoZE+iLZGoSTajgUsVR8L7cKWY2LFT1qxY11Qj2Q5u1HQ74
        tjS0/iRFCtRt96akXG6e24A1QH7Wn55UypZF2SxAiEoLKcX/CE6UPlYUfRSPHHuobhzESmxxQRVjQ
        kQFJO+JFs5jDLxLEqE0hD6fNlEBl925gCcFT2hBeuf20D4E2qCemI6yNFTUHWlB/KYpXiP3FmK16W
        bSkHll9g==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:45334 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jHv7B-002Xgn-6w; Fri, 27 Mar 2020 14:58:01 -0500
Date:   Fri, 27 Mar 2020 15:01:35 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] btrfs: inode: Fix uninitialized variable bug
Message-ID: <20200327200135.GA3472@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.218.116.241
X-Source-L: No
X-Exim-ID: 1jHv7B-002Xgn-6w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:45334
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

geom.len is being used without being properly initialized, previously.

Fix this by placing ASSERT(geom.len <= INT_MAX); after geom.len has been
initialized.

Addresses-Coverity-ID: 1491912 ("Uninitialized scalar variable")
Fixes: 1eb52c8bd8d6 ("btrfs: get rid of one layer of bios in direct I/O")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/btrfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fce94591e092..00ea02268f54 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7637,7 +7637,6 @@ static void btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 	else
 		async_submit = 1;
 
-	ASSERT(geom.len <= INT_MAX);
 	do {
 		ret = btrfs_get_io_geometry(fs_info, btrfs_op(dio_bio),
 					    start_sector << 9, submit_len,
@@ -7647,6 +7646,8 @@ static void btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 			goto out_err;
 		}
 
+		ASSERT(geom.len <= INT_MAX);
+
 		clone_len = min_t(int, submit_len, geom.len);
 
 		/*
-- 
2.26.0

