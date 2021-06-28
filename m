Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770A13B5C74
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 12:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhF1K3B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 06:29:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37086 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhF1K3A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 06:29:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A72DD21B9E
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Jun 2021 10:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624875991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KlYjz+AQDsmzvdWzm8edKsRlec11vZzgVbIRvwBlJXA=;
        b=i3YVWTPitOIpRhjyDLrqpoTWaRS5UfcKOpJJFwgu67y0hlNmBEzGEnB5jYzWBrIHZx4VCP
        o3s9z3V2+qOqj2ByOrAf9z4QfDHy0TXRqJIhGLOQWW6MqpsqKOJXI7hSOHCLBzhJlsx6aA
        fiiqoHl8fl/uRzE0gA+38S42pRTmxsw=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id B506CA3B94
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Jun 2021 10:26:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: cmds/subvolume: try to delete subvolume by id when its path can't be reoslved
Date:   Mon, 28 Jun 2021 18:26:28 +0800
Message-Id: <20210628102628.354173-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a recent report of ghost subvolumes where such subvolumes has
no ROOT_REF/BACKREF, and 0 root ref.
But without an orphan item, thus kernel won't queue them for cleanup.

Such ghost subvolumes are just here to take up space, and no way to
delete them except by btrfs check, which will try to fix the problem by
adding orphan item.

There is a kernel patch submitted to allow btrfs to detect such ghost
subvolumes and queue them for cleanup.

But btrfs-progs will not continue to call the ioctl if it can't find the
full subvolume path.

Thus this patch will loose the restriction by allowing btrfs-progs to
continue to call the ioctl even if it can't grab the subvolume path.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/subvolume.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 9bd178082495..4881ba5be4b1 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -258,6 +258,7 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 	char	*path = NULL;
 	DIR	*dirstream = NULL;
 	int commit_mode = 0;
+	bool subvol_path_not_found = false;
 	u8 fsid[BTRFS_FSID_SIZE];
 	u64 subvolid = 0;
 	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
@@ -319,6 +320,18 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 
 		path = argv[cnt];
 		err = btrfs_util_subvolume_path(path, subvolid, &subvol);
+		/*
+		 * If the subvolume is really not referred by anyone, and
+		 * refs is 0, newer kernel can handle it by just adding an
+		 * orphan item and queue it for cleanup.
+		 *
+		 * In this case, just let kernel to handle it, we do no
+		 * extra handling.
+		 */
+		if (err == BTRFS_UTIL_ERROR_SUBVOLUME_NOT_FOUND) {
+			subvol_path_not_found = true;
+			goto again;
+		}
 		if (err) {
 			error_btrfs_util(err);
 			ret = 1;
@@ -395,8 +408,10 @@ again:
 
 	if (subvolid == 0)
 		pr_verbose(MUST_LOG, "'%s/%s'\n", dname, vname);
-	else
+	else if (!subvol_path_not_found)
 		pr_verbose(MUST_LOG, "'%s'\n", full_subvolpath);
+	else
+		pr_verbose(MUST_LOG, "subvolid=%llu\n", subvolid);
 
 	if (subvolid == 0)
 		err = btrfs_util_delete_subvolume_fd(fd, vname, 0);
-- 
2.32.0

