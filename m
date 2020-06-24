Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8699920784E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404836AbgFXQDz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404765AbgFXQD1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:27 -0400
Received: from mail.nic.cz (lists.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B09C0617BB
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jun 2020 09:03:27 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 71D111408B2;
        Wed, 24 Jun 2020 18:03:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014604; bh=otqhNz+BRRpXbdY4iHCXuU5HASYzdeF1JrrlY4iku9U=;
        h=From:To:Date;
        b=qZqdIPfDRUdrjkxV5HxGGElGwDMh/y2+ziaVykglS79T6FOVsbCH/FvFHdrmhgDqJ
         MeST+peI99lqUU0dRLnZJzbKQEdQt8vYzYwuD/dkLSvK6jXdFxu1/IK8xwCRcSk3Nw
         Jt53Vl+1uZ/flmCdhW1dliZ4u+S2EZYD6EmuI5yg=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 18/30] fs: btrfs: inode: Allow next_length() to return value > BTRFS_NAME_LEN
Date:   Wed, 24 Jun 2020 18:03:04 +0200
Message-Id: <20200624160316.5001-19-marek.behun@nic.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624160316.5001-1-marek.behun@nic.cz>
References: <20200624160316.5001-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

All existing next_length() caller handles return value > BTRFS_NAME_LEN,
so there is no need to do BTRFS_NAME_LEN check in next_length().

But still, we want to exit early if we're beyond BTRFS_NAME_LEN, so this
patch makes next_length() exit as soon as we're beyond BTRFS_NAME_LEN.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 fs/btrfs/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 007cf32c16..da2a5e90a1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -217,8 +217,12 @@ static u64 __get_parent_inode(struct __btrfs_root *root, u64 inr,
 static inline int next_length(const char *path)
 {
 	int res = 0;
-	while (*path != '\0' && *path != '/' && res <= BTRFS_NAME_LEN)
-		++res, ++path;
+	while (*path != '\0' && *path != '/') {
+		++res;
+		++path;
+		if (res > BTRFS_NAME_LEN)
+			break;
+	}
 	return res;
 }
 
-- 
2.26.2

