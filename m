Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAB53155BA
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 19:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhBIST3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 13:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbhBISRu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Feb 2021 13:17:50 -0500
X-Greylist: delayed 1860 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 Feb 2021 10:05:26 PST
Received: from mail.nic.cz (lists.nic.cz [IPv6:2001:1488:800:400::400])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BEBC06178B
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Feb 2021 10:05:26 -0800 (PST)
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:8982:ed8c:62b1:c0c8])
        by mail.nic.cz (Postfix) with ESMTPSA id A4DAC140A94;
        Tue,  9 Feb 2021 19:05:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1612893924; bh=MrBhBwBEB0/woWhybRYmQ/Xb97qPyqOd18InPxK+o3A=;
        h=From:To:Date;
        b=MLXKSdk95kv3QYSloK4pUu9e2Pe56OXsEN6yVZcA1PYP4Tvi8GxXtTUb/cOqtOHoR
         RThDUJRZA3Mx2IH3gAUwJJPfpnJQVKTMze4UAwE5NOUqcwWediE0ZYjvB8BYSO8cT1
         aA+rjht7lhc7SVUFoNr9vdAlAfFAtSuhvH+MPQ5Y=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     u-boot@lists.denx.de
Cc:     linux-btrfs@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Tom Rini <trini@konsulko.com>
Subject: [PATCH u-boot 1/2] fs: btrfs: skip xattrs in directory listing
Date:   Tue,  9 Feb 2021 19:05:07 +0100
Message-Id: <20210209180508.22132-1-marek.behun@nic.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,URIBL_BLOCKED,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST shortcircuit=ham
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Skip xattrs in directory listing. U-Boot filesystem drivers do not list
xattrs.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: David Sterba <dsterba@suse.com>
Cc: Qu Wenruo <wqu@suse.com>
Cc: Tom Rini <trini@konsulko.com>
---
 fs/btrfs/btrfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 346b2c4341..6b4c5feb53 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -29,7 +29,6 @@ static int show_dir(struct btrfs_root *root, struct extent_buffer *eb,
 		[BTRFS_FT_FIFO]		= "FIFO",
 		[BTRFS_FT_SOCK]		= "SOCK",
 		[BTRFS_FT_SYMLINK]	= "SYMLINK",
-		[BTRFS_FT_XATTR]	= "XATTR"
 	};
 	u8 type = btrfs_dir_type(eb, di);
 	char namebuf[BTRFS_NAME_LEN];
@@ -38,6 +37,10 @@ static int show_dir(struct btrfs_root *root, struct extent_buffer *eb,
 	time_t mtime;
 	int ret = 0;
 
+	/* skip XATTRs in directory listing */
+	if (type == BTRFS_FT_XATTR)
+		return 0;
+
 	btrfs_dir_item_key_to_cpu(eb, di, &key);
 
 	if (key.type == BTRFS_ROOT_ITEM_KEY) {
-- 
2.26.2

