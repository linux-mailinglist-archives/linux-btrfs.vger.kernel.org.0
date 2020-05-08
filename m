Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8F21CA2F2
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 07:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgEHFrv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 01:47:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:50822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgEHFrv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 May 2020 01:47:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6667FAA55
        for <linux-btrfs@vger.kernel.org>; Fri,  8 May 2020 05:47:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: uapi: Add warning for btrfs_qgroup_inherit usage for snapshot creation
Date:   Fri,  8 May 2020 13:47:44 +0800
Message-Id: <20200508054744.28969-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Snapshot creation with btrfs_qgroup_inherit structure can easily lead to
qgroup inconsistent.

The inconsistency itself is not a big deal, but due to the limitation of
the ioctl, we can't inform user space to do a rescan.

Thus it's recommended to use BTRFS_IOC_QGROUP_ASSIGN to assign qgroup
relation other than do it in snapshot creation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 include/uapi/linux/btrfs.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index dc8675d892a4..b8881910bde3 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -132,6 +132,17 @@ struct btrfs_ioctl_vol_args_v2 {
 	union {
 		struct {
 			__u64 size;
+			/*
+			 * WARNING: Don't use this structure to assign qgroup
+			 * for snapshot creation.
+			 *
+			 * Such inheritance for snapshot can lead to qgroup
+			 * inconsistent due to massive extent ownership change.
+			 *
+			 * Due to the limitation of snapshot creation ioctl, we
+			 * can't inform user space to do a rescan.
+			 * Please use BTRFS_IOC_QGROUP_ASSIGN instead.
+			 */
 			struct btrfs_qgroup_inherit __user *qgroup_inherit;
 		};
 		__u64 unused[4];
-- 
2.26.2

