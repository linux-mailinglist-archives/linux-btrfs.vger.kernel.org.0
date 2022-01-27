Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D89449EB6D
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 20:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343500AbiA0T5V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 14:57:21 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:54832 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343494AbiA0T5T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 14:57:19 -0500
Received: from venice.bhome ([78.14.151.50])
        by santino.mail.tiscali.it with 
        id nvxE2600k15VSme01vxGrt; Thu, 27 Jan 2022 19:57:17 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 3/3] Read/change the allocation_hint prop when unmounted
Date:   Thu, 27 Jan 2022 20:57:09 +0100
Message-Id: <1c6a98da2f8c4a7400f0a7e8862f697b9e8993a1.1643313144.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643313144.git.kreijack@inwind.it>
References: <cover.1643313144.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1643313437; bh=bTqA0gtpaBglS1OlwgBE85MoyAQuaipEp1r/2GrGpu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=y4FfiXTNXYg+rdMxTNa742Q68xJqeO7csAEiClIsKwfdoLoeRR6AeErEyaPXCfGOA
         VMy4zLe7dNTtDngoChA5dkO3cqXq88zRxAPvo63bvpI0h/3uwETc4ITcOgKq6pmxJm
         2AyCAmW99ymKGPTm7z4GiSRQgUErKiNnwzqc9NGE=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

This patch enable the changing of the allocation_hint even
when the filesystem is unmounted.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 cmds/property.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/cmds/property.c b/cmds/property.c
index a409f4e9..55de7e6b 100644
--- a/cmds/property.c
+++ b/cmds/property.c
@@ -28,6 +28,9 @@
 #include "cmds/commands.h"
 #include "cmds/props.h"
 #include "kernel-shared/ctree.h"
+#include "kernel-shared/volumes.h"
+#include "kernel-shared/disk-io.h"
+#include "kernel-shared/transaction.h"
 #include "common/open-utils.h"
 #include "common/utils.h"
 #include "common/help.h"
@@ -377,6 +380,115 @@ static struct ull_charp_pair_t {
 	{0, NULL}
 };
 
+static int find_device(const char *object, struct btrfs_device **device_ret)
+{
+	struct btrfs_fs_devices *fs_devices;
+	struct list_head *fs_uuids;
+	struct stat sttarget, st;
+
+	if (stat(object, &sttarget) < 0)
+		return -EACCES;
+
+	fs_uuids = btrfs_scanned_uuids();
+
+	list_for_each_entry(fs_devices, fs_uuids, list) {
+		struct btrfs_device *device;
+
+		list_for_each_entry(device, &fs_devices->devices, dev_list) {
+
+			if (stat(device->name, &st) < 0)
+				return -EACCES;
+
+			if (st.st_rdev == sttarget.st_rdev) {
+				*device_ret = device;
+				return 0;
+			}
+		}
+	}
+
+	return -ENODEV;
+}
+
+static int prop_allocation_hint_unmounted(const char *object,
+					  const char *name,
+					  const char *val)
+{
+
+	struct btrfs_device *device;
+	int ret;
+	struct btrfs_root *root = NULL;
+
+	root = open_ctree(object, btrfs_sb_offset(0), 0);
+	if (!root)
+		return -ENODEV;
+
+	ret = find_device(object, &device);
+	if (ret)
+		goto out;
+
+	if (!val) {
+		int i;
+		u64 v = device->flags & BTRFS_DEV_ALLOCATION_HINT_MASK;
+
+		for (i = 0 ; allocation_hint_description[i].descr ; i++)
+			if (v == allocation_hint_description[i].value)
+				break;
+
+		if (allocation_hint_description[i].descr)
+			printf("allocation_hint=%s\n",
+				allocation_hint_description[i].descr);
+		else
+			printf("allocation_hint=unknown:%llu\n", v);
+		ret = 0;
+	} else {
+		struct btrfs_trans_handle *trans;
+		int i;
+		u64 v;
+
+		for (i = 0 ; allocation_hint_description[i].descr ; i++)
+			if (!strcmp(val, allocation_hint_description[i].descr))
+				break;
+
+		if (allocation_hint_description[i].descr) {
+			v = allocation_hint_description[i].value;
+		} else if (sscanf(val, "%llu", &v) != 1) {
+			error("Invalid value '%s'\n", val);
+			ret = -3;
+			goto out;
+		}
+		if (v & ~BTRFS_DEV_ALLOCATION_HINT_MASK) {
+			error("Invalid value '%s'\n", val);
+			ret = -3;
+			goto out;
+		}
+
+		trans = btrfs_start_transaction(device->fs_info->chunk_root, 1);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			goto out;
+		}
+
+		/* Manually update the device item in chunk tree */
+		ret = btrfs_update_device(trans, device);
+		if (ret < 0) {
+			errno = -ret;
+			goto out;
+		}
+
+		/*
+		 * Commit transaction not only to save the above change but also update
+		 * the device item in super block.
+		 */
+		ret = btrfs_commit_transaction(trans, device->fs_info->chunk_root);
+
+		}
+out:
+	if (root)
+		close_ctree(root);
+	return ret;
+
+}
+
 static int prop_allocation_hint(enum prop_object_type type,
 				const char *object,
 				const char *name,
@@ -394,6 +506,9 @@ static int prop_allocation_hint(enum prop_object_type type,
 	ret = btrfs_find_devid_uuid_by_dev(object, &devid,
 		sysfs_file + sizeof(BTRFSYSFS) - 1);
 
+	if (ret == -ENODEV)
+		return prop_allocation_hint_unmounted(object, name, val);
+
 	if (ret)
 		goto out;
 
-- 
2.34.1

