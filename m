Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A8F15581F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 14:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgBGNIT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 08:08:19 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:42595 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGNIT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 08:08:19 -0500
Received: by mail-wr1-f52.google.com with SMTP id k11so2588150wrd.9
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2020 05:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XcmUwL5ya8Anb5xEWqigLuvAVCthUDkFcuayJ2Poc4c=;
        b=Fn/3kt8RNQM1CAtDzKCZspkDVVZ+d+WjK6iIejDjthLVaiqfeo4tYo502EvEunNdD3
         0osUOWuphF4t6uzZRR2G7t2DkYf4OIvf3Gm2hXmXEyyuzhYaq3ao8GKiQ7Ln2g6EtHDg
         bUjm+zNXCoSrnhBNXACUs7Fv8kwcp+Aw2Xj/Sr4q1397MIAgmgA18+5Vv3DsKNdox16v
         U7r6ITreAy74goBBd0TamsjapaTgFttQ0UHdQLN/kMWKSIn/wGYZBDB4wX92epIQs2g0
         F45Jo0cC2QRUCjGxVkN9U2Bq99OR/B7UBoZ1coDVoM0jQBVtjERN4e/WFUDFaxnZiRAQ
         UzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XcmUwL5ya8Anb5xEWqigLuvAVCthUDkFcuayJ2Poc4c=;
        b=EwukFW1JnY32NCEs4IVMpcwhNVbsbwpy7g2/uS/NEW7lTUyqTCnhDffBeikB2KbjhP
         uWO9MwVmkqYWVKPY90s6B3rAp3qLX5vgwq0KSazTnOfmL9WtOb2MkNF8q4pcspkwV2m4
         dfDTLVoM1t1aQGCWZ1fbAq6SB1VEX1hPQmk8AcRIkU5gdKXv7fB2HKJ+/cB6ajmtBVWG
         mJhZTYNyTB6llWUOLT6QGmpqXrPDvyJ2n9oDnFF2LdZTY1O12+t7GGYeYbGLOGmfA7j7
         hQJ3fHasrj0+yY9y7ut9AotqwrhuJWsN6a/nHZxJ3kuRp0a7ZFK/NFXKcva5KUbRM19S
         Rc1g==
X-Gm-Message-State: APjAAAV+TILVaTqaY1JWLAOticKAWjymZFUoO0gv7vnc/lpM0CBysLTn
        9TTp6wT9Vxb0SNx8KtiECMc=
X-Google-Smtp-Source: APXvYqzH0sT4+XrPHgiO9WRthafjEWzoN3yd3M7MfIg7wiet4Yuw6s1olK8AkT6FDxbCyWS90J3vlA==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr4686142wrv.108.1581080896321;
        Fri, 07 Feb 2020 05:08:16 -0800 (PST)
Received: from hephaestus.suse.de ([186.212.94.124])
        by smtp.gmail.com with ESMTPSA id n1sm3260702wrw.52.2020.02.07.05.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 05:08:15 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCHv2 3/4] libbtrfsutil: Introduce btrfs_util_delete_subvolume_by_id_fd
Date:   Fri,  7 Feb 2020 10:10:27 -0300
Message-Id: <20200207131028.9977-4-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200207131028.9977-1-marcos.souza.org@gmail.com>
References: <20200207131028.9977-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This new function will use the new BTRFS_IOC_SNAP_DESTROY_V2 to delete a
subvolume using it's id. The parent_fs argument should be a mount point.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 libbtrfsutil/btrfsutil.h | 11 +++++++++++
 libbtrfsutil/subvolume.c | 16 ++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/libbtrfsutil/btrfsutil.h b/libbtrfsutil/btrfsutil.h
index 0442af6e..c4cab2e0 100644
--- a/libbtrfsutil/btrfsutil.h
+++ b/libbtrfsutil/btrfsutil.h
@@ -488,6 +488,17 @@ enum btrfs_util_error btrfs_util_delete_subvolume_fd(int parent_fd,
 						     const char *name,
 						     int flags);
 
+/**
+ * btrfs_util_delete_subvolume_by_id_fd() - Delete a subvolume or snapshot using
+ * subvolume id.
+ * @path: Path of the subvolume to delete.
+ * @subvolid: Subvolume id of the subvolume or snapshot to be deleted.
+ *
+ * Return: %BTRFS_UTIL_OK on success, non-zero error code on failure.
+ */
+enum btrfs_util_error btrfs_util_delete_subvolume_by_id_fd(int parent_fd,
+							uint64_t subvolid);
+
 struct btrfs_util_subvolume_iterator;
 
 /**
diff --git a/libbtrfsutil/subvolume.c b/libbtrfsutil/subvolume.c
index 3f8343a2..204a837b 100644
--- a/libbtrfsutil/subvolume.c
+++ b/libbtrfsutil/subvolume.c
@@ -1290,6 +1290,22 @@ PUBLIC enum btrfs_util_error btrfs_util_delete_subvolume_fd(int parent_fd,
 	return BTRFS_UTIL_OK;
 }
 
+PUBLIC enum btrfs_util_error btrfs_util_delete_subvolume_by_id_fd(int parent_fd,
+							    uint64_t subvolid)
+{
+	struct btrfs_ioctl_vol_args_v2 args = {};
+	int ret;
+
+	args.flags = BTRFS_SUBVOL_SPEC_BY_ID;
+	args.subvolid = subvolid;
+
+	ret = ioctl(parent_fd, BTRFS_IOC_SNAP_DESTROY_V2, &args);
+	if (ret == -1)
+		return BTRFS_UTIL_ERROR_SNAP_DESTROY_FAILED;
+
+	return BTRFS_UTIL_OK;
+}
+
 PUBLIC void btrfs_util_destroy_subvolume_iterator(struct btrfs_util_subvolume_iterator *iter)
 {
 	if (iter) {
-- 
2.24.0

