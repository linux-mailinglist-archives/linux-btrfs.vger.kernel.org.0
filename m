Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D96167DE1
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 14:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgBUNCe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 08:02:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:39934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbgBUNCd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 08:02:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CDC6AAE63;
        Fri, 21 Feb 2020 13:02:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82627DA70E; Fri, 21 Feb 2020 14:02:15 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] btrfs: define support masks for ioctl volume args v2
Date:   Fri, 21 Feb 2020 14:02:15 +0100
Message-Id: <c25c2e84ebc5ef31227ae23d44e09ddc8c343a7b.1582289899.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582289899.git.dsterba@suse.com>
References: <cover.1582289899.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The ioctl data for devices or subvolumes can be passed via
btrfs_ioctl_vol_args or btrfs_ioctl_vol_args_v2. The latter is more
versatile and needs some caution as some of the flags make sense only
for some ioctls.

As we're going to extend the flags, define support masks for each ioctl
class separately.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 include/uapi/linux/btrfs.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 7a8bc8b920f5..49ed71df5e94 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -97,16 +97,26 @@ struct btrfs_ioctl_qgroup_limit_args {
 };
 
 /*
- * flags for subvolumes
+ * Arguments for specification of subvolumes or devices, supporting by-name or
+ * by-id and flags
  *
- * Used by:
- * struct btrfs_ioctl_vol_args_v2.flags
+ * The set of supported flags depends on the ioctl
  *
  * BTRFS_SUBVOL_RDONLY is also provided/consumed by the following ioctls:
  * - BTRFS_IOC_SUBVOL_GETFLAGS
  * - BTRFS_IOC_SUBVOL_SETFLAGS
  */
 
+/* Supported flags for BTRFS_IOC_RM_DEV_V2 */
+#define BTRFS_DEVICE_REMOVE_ARGS_MASK					\
+	(BTRFS_DEVICE_SPEC_BY_ID)
+
+/* Supported flags for BTRFS_IOC_SNAP_CREATE_V2 and BTRFS_IOC_SUBVOL_CREATE_V2 */
+#define BTRFS_SUBVOL_CREATE_ARGS_MASK					\
+	(BTRFS_SUBVOL_CREATE_ASYNC |					\
+	 BTRFS_SUBVOL_RDONLY |						\
+	 BTRFS_SUBVOL_QGROUP_INHERIT)
+
 struct btrfs_ioctl_vol_args_v2 {
 	__s64 fd;
 	__u64 transid;
-- 
2.25.0

