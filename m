Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2968D149E4E
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 03:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgA0CrV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jan 2020 21:47:21 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38981 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgA0CrU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jan 2020 21:47:20 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so6324720qtm.6
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Jan 2020 18:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9DsQHVRV327tp3DbyccS7hNtTNVjtFoplk31KZ1Ukis=;
        b=tE0UNT8tDyYdJYp1yLhaspKlQKpjcLDNIxXPmCGXGOn9FM0s5jo3yopKhUVC+FmMve
         tCH67ox0MG2wHrFBCorhbNOtlWNAG79TcQejVbi2LTokrXi9wyvtDEhKRuAPJfn5nCyl
         PpQgIG51NJoxwtC+1EeODx7MKmyRcCPLubm4Jpkmg0cgRvAjPfNmsncmM3BsGoFwvd/+
         ihiXkcx33St2VUXLIDTWnOoofqgTuu0K8NuaxA3Zw5xbSIN82M/VnYSPedVLvfjUi0QW
         n3SEqPAzljw8LFwVo+mJa5uFenC42YDB4BN736idVQsHwBUwkhHUQc0o4HcQOefqVsnu
         Nz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9DsQHVRV327tp3DbyccS7hNtTNVjtFoplk31KZ1Ukis=;
        b=mENY4GPhtw3MVUfMoswqG6IChTYGuFCjsUAQ62y6iswTJrvorRjpEEHbARTZjWLX3e
         xEeDIrSltvNMNnU6VoKX7x7eX5gZqeUsv6yfd9qX4xIFQX/1ZEgZOfPGCCxeLtCp+h1D
         vZe1rwU6fh/UOjGNcPC/EhCRob8P5P72bXBmc9wzJn6hen9gvgVOilaFWxFBiwWYe1Iw
         j8oEtDmGZXTAJrNcEbMoKD/IUETAroM9Z3z4u9jnkHJr67tLFE9jCbagRoEaGKn/bloD
         rbQcDyQUUvSy/8Q7h9BeqOcTBcgWzXGDeb7Q/meJCgYR4/ypzJmhtnIwAPvFqjWur7IF
         ysMA==
X-Gm-Message-State: APjAAAXGBpnaLTg+CIY+YSJrXmtzYBGccDN6YPV9RHHLPXZu0M5AoPAC
        4Aa0R7EbwPSxauW5oVmkH5Ftxssn
X-Google-Smtp-Source: APXvYqyJEa73zdjh6IxzYn9i6jGzcqj7+4TUaX12lGjQLQpmc4aHSAK5Ktql3K3Apl6ZUaiWVB0gKA==
X-Received: by 2002:ac8:3a02:: with SMTP id w2mr13469664qte.351.1580093239529;
        Sun, 26 Jan 2020 18:47:19 -0800 (PST)
Received: from localhost.localdomain (200.146.53.109.dynamic.dialup.gvt.net.br. [200.146.53.109])
        by smtp.gmail.com with ESMTPSA id c184sm8643337qke.118.2020.01.26.18.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 18:47:18 -0800 (PST)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 3/5] libbtrfsutil: Introduce btrfs_util_delete_subvolume_by_id_fd
Date:   Sun, 26 Jan 2020 23:49:52 -0300
Message-Id: <20200127024954.16916-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200127024954.16916-1-marcos.souza.org@gmail.com>
References: <20200127024954.16916-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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
+ * btrfs_util_delete_subvolume_by_id() - Delete a subvolume or snapshot using
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
index 3f8343a2..55d0cd26 100644
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
+	args.flags = BTRFS_SUBVOL_BY_ID;
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

