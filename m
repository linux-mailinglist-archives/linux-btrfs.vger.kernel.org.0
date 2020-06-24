Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CABD207857
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 18:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404846AbgFXQEF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 12:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404725AbgFXQD0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 12:03:26 -0400
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7093C061796
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jun 2020 09:03:25 -0700 (PDT)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 76E691409D2;
        Wed, 24 Jun 2020 18:03:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1593014603; bh=jGk/eA4zftmwy6LrEgoR7s76rehlCJQCp46rWy5zAKY=;
        h=From:To:Date;
        b=dfrS4147mgyt4UKAMT4/Gk6HvjWmy0RnA7dBeuDQQW0pROSM7J9z4uHdGTBtGLRZj
         Jkpd79Fm8PTI7GBXeM0x0QwP77KoSYIjN93epKZJjskBED5/90jSgfkt8DXpoI62n5
         IJ8rpgdi2G/iPd+qcqSpaytS0AVsG6E9xp74zU0U=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     =?UTF-8?q?Alberto=20S=C3=A1nchez=20Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH U-BOOT v3 12/30] fs: btrfs: Crossport struct btrfs_root to ctree.h
Date:   Wed, 24 Jun 2020 18:02:58 +0200
Message-Id: <20200624160316.5001-13-marek.behun@nic.cz>
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

Crossport struct btrfs_root to ctree.h from btrfs-progs, with write
related members deleted.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 fs/btrfs/ctree.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0aa6b49a65..e658c88aee 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -69,6 +69,23 @@ enum btrfs_tree_block_status {
 	BTRFS_TREE_BLOCK_INVALID_OFFSETS,
 };
 
+struct btrfs_root {
+	struct extent_buffer *node;
+	struct btrfs_root_item root_item;
+	struct btrfs_key root_key;
+	struct btrfs_fs_info *fs_info;
+	u64 objectid;
+	u64 last_trans;
+
+	int ref_cows;
+	int track_dirty;
+
+	u32 type;
+	u64 last_inode_alloc;
+
+	struct rb_node rb_node;
+};
+
 struct btrfs_device;
 struct btrfs_fs_devices;
 struct btrfs_fs_info {
-- 
2.26.2

