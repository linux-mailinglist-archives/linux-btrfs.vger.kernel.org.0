Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E3215F766
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 21:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbgBNUFF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 15:05:05 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39543 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387812AbgBNUFE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 15:05:04 -0500
Received: by mail-qt1-f194.google.com with SMTP id c5so7786784qtj.6
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Feb 2020 12:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5gpxxImQ2uv9mQRbSHoYhoJvdL+AU5KQyTOJpAq86kM=;
        b=kovI5XdKiLteEDgnnGm8Fy9FpwZnz4Og7yGXh2AIQWSZN7GL6wQi/oRt5Vuv5c2l+s
         GETS8Hz0WngBs5WeakhNTEHicL0m08pocrz3Q0fW8+svrp3zpuB4jSMU1ZOjn2CgIcV8
         weNiH9+1TvCeV+MShBojggRMKJkijCA1jH+fHAeX6QBKOlun0iOuCqQaOVM8ctulBPJL
         EX+HoLj4GEf6kYyGJOozLb26LgpCNlCVT0GtqIUkrLpF2tJwMsT8krlC+1ROeJSfOxzY
         MXC+EEqw7AO7BarBDc7nh5FIgFcvqNE/SjCgAtt0uZguI4Fwx/EQ9njJesDN5/EOKx5Z
         YgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5gpxxImQ2uv9mQRbSHoYhoJvdL+AU5KQyTOJpAq86kM=;
        b=Ar8tc3nO9Y6MgjXpGMnMjHrzO0DhmO0zM89pXaxig+fCTo2JNZU2q4I+7wAZRTFdk5
         cjBGy+uhGbsL3uKmrS/V8+V+uFDqAkdp3uw+m1mxddSPNvY9XveXEzR4AHVl/iMCAKLW
         CWuwXXUMTAM7WD1TZtprDbR739tTHY2uAejkxLDzGs/zxbmc6N37RaNsiX0S1Y5ooada
         Ue8X0sFAyB4zU5TG10YcbolZPMQctWrF5jq64tahs0ftUZsa28kkSBJ0O/NKRmGXaYnU
         dQq6g9MqoeCitXKl+fjcqmHxncUq/rYf992Z1AmIf1T/I/Z4teAi94q0veOGhmk9IoDs
         o6AA==
X-Gm-Message-State: APjAAAUivRWup6XgPLUUG6f7fV4OcYORCwbp2rLdBMeOirDlXXD3ob+8
        1IgXvjRS5Rsm+apW78vXYCoPX8QMnnI=
X-Google-Smtp-Source: APXvYqzU+vfRTv+TdUcBBAJsUVmmoc+wIlca4MFv+Kq4pTvZLxUyQRbvle745w1gVUA1024xkRUEMw==
X-Received: by 2002:ac8:a83:: with SMTP id d3mr4045210qti.228.1581710703379;
        Fri, 14 Feb 2020 12:05:03 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 138sm2419171qke.57.2020.02.14.12.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:05:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: bail out of uuid tree scanning if we're closing
Date:   Fri, 14 Feb 2020 15:05:01 -0500
Message-Id: <20200214200501.2524-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In doing my fsstress+EIO stress testing I started running into issues
where umount would get stuck forever because the uuid checker was
chewing through the thousands of subvolumes I had created.  We shouldn't
block umount on this, simply bail if we're unmounting the fs.  We need
to make sure we don't mark the UUID tree as ok, so we only set that bit
if we made it through the whole rescan operation, but otherwise this is
completely safe.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/uuid-tree.c |  4 ++++
 fs/btrfs/volumes.c   | 11 +++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 76b84f2397b1..30078b74220e 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -278,6 +278,10 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info,
 	}
 
 	while (1) {
+		if (btrfs_fs_closing(fs_info)) {
+			ret = -EINTR;
+			goto out;
+		}
 		cond_resched();
 		leaf = path->nodes[0];
 		slot = path->slots[0];
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 387f80656476..e40adf38ae5c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4286,6 +4286,7 @@ static int btrfs_uuid_scan_kthread(void *data)
 	struct btrfs_root_item root_item;
 	u32 item_size;
 	struct btrfs_trans_handle *trans = NULL;
+	bool closing = false;
 
 	path = btrfs_alloc_path();
 	if (!path) {
@@ -4298,6 +4299,10 @@ static int btrfs_uuid_scan_kthread(void *data)
 	key.offset = 0;
 
 	while (1) {
+		if (btrfs_fs_closing(fs_info)) {
+			closing = true;
+			break;
+		}
 		ret = btrfs_search_forward(root, &key, path,
 				BTRFS_OLDEST_GENERATION);
 		if (ret) {
@@ -4397,7 +4402,7 @@ static int btrfs_uuid_scan_kthread(void *data)
 		btrfs_end_transaction(trans);
 	if (ret)
 		btrfs_warn(fs_info, "btrfs_uuid_scan_kthread failed %d", ret);
-	else
+	else if (!closing)
 		set_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags);
 	up(&fs_info->uuid_tree_rescan_sem);
 	return 0;
@@ -4460,7 +4465,9 @@ static int btrfs_uuid_rescan_kthread(void *data)
 	 */
 	ret = btrfs_uuid_tree_iterate(fs_info, btrfs_check_uuid_tree_entry);
 	if (ret < 0) {
-		btrfs_warn(fs_info, "iterating uuid_tree failed %d", ret);
+		if (ret != -EINTR)
+			btrfs_warn(fs_info, "iterating uuid_tree failed %d",
+				   ret);
 		up(&fs_info->uuid_tree_rescan_sem);
 		return ret;
 	}
-- 
2.24.1

