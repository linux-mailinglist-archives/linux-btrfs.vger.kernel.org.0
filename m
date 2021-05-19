Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19AB389205
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 16:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354920AbhESOyN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 10:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354917AbhESOyM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 10:54:12 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91895C06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 07:52:51 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id a7so2584978qvf.11
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 07:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hDdgOQyp2r+Z6D7W01B9hwZHAqTsTTLSPZJNqft+VpM=;
        b=KLMYd33ZClKcnZycLTZtOsuNYurj2VN89onb/ly13J2AZHVAERjPujC//aCzS8bkbq
         s/VGCB8OyNDyXB5TRv8Qd9GMsEkz+K40VfZVMtt6q8eu+kjBZL4WC4rTdpkafMpnomft
         VONTBRRJ1X7JuRS10SOzmwwEJANa0/FFhtK8/y9GxzeQFPwta+J/UlLr7IXx1nI5RpOn
         89PA/r4Du7GhMTcs1P+r7Fqbn5AwwDXLwWyZkq/0NKClyJBgPUI/XM3/FdDZNLR+fWA6
         CzjP2z/48ooxF/2msQiHuDL7+0JIEqzDScCWnCsLhHP+WMALiYreYSJuWLgvB48sceXU
         hh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDdgOQyp2r+Z6D7W01B9hwZHAqTsTTLSPZJNqft+VpM=;
        b=CG3nE9PZu7jLPsZQQq8dc4KY+JLzahoinySh2bMIwk88PbW4PdJ++dZ3+5OUi115PD
         2Ze69ogRji504pk/xUZX/Y0zAH+n5GpyuIUX1tjgxvwZ1/Svfjx7u/CYHvp4TIdD+VIa
         t5ZRKn6cm5iGU9fuoHYXYEU1xKSG72nv6W70aHfLAUfpCHWOBhte2XaJ/+wLa1IkS7pD
         +xynJzSZtA3kR0DFDuHWXXUY7g/+ivMbiUiNnSfJYjKm/oQT1SJQLiB46P6b46VmH6TO
         6e0ZviHtCS2cGk3UAOuQ3aol91oDOKCDno6b3fr/OsycPd9KZpq+LqGqQVjf/Y0+KVKf
         w8Kw==
X-Gm-Message-State: AOAM532EFBYuIo5j4Xc26Jwrcr8Cn+cH6RAum+doJtZ97ThXp4uOMXIi
        rpKpkNzr1WWTXIKt7LA5N706YOEvZ6AZSA==
X-Google-Smtp-Source: ABdhPJxsnRucbWh0arficeZeM1W15K9lTeZnK5X8m2AsXmap2uy4BHxs/vGku8uGkRDVah6jJsVlsg==
X-Received: by 2002:a05:6214:2486:: with SMTP id gi6mr13320939qvb.54.1621435970404;
        Wed, 19 May 2021 07:52:50 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m21sm3892945qtu.11.2021.05.19.07.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:52:49 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: fix error handling in btrfs_del_csums
Date:   Wed, 19 May 2021 10:52:45 -0400
Message-Id: <dbb1747494ad6ea6e66fbe27c37ea3730a7ac615.1621435862.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1621435862.git.josef@toxicpanda.com>
References: <cover.1621435862.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Error injection stress would sometimes fail with checksums on disk that
did not have a corresponding extent.  This occurred because the pattern
in btrfs_del_csums was

	while (1) {
		ret = btrfs_search_slot();
		if (ret < 0)
			break;
	}
	ret = 0;
out:
	btrfs_free_path(path);
	return ret;

If we got an error from btrfs_search_slot we'd clear the error because
we were breaking instead of goto out.  Instead of using goto out, simply
handle the cases where we may leave a random value in ret, and get rid
of the

	ret = 0;
out:

pattern and simply allow break to have the proper error reporting.  With
this fix we properly abort the transaction and do not commit thinking we
successfully deleted the csum.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file-item.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 294602f139ef..a5a8dac334e8 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -788,7 +788,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 	u64 end_byte = bytenr + len;
 	u64 csum_end;
 	struct extent_buffer *leaf;
-	int ret;
+	int ret = 0;
 	const u32 csum_size = fs_info->csum_size;
 	u32 blocksize_bits = fs_info->sectorsize_bits;
 
@@ -806,6 +806,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 
 		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 		if (ret > 0) {
+			ret = 0;
 			if (path->slots[0] == 0)
 				break;
 			path->slots[0]--;
@@ -862,7 +863,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 			ret = btrfs_del_items(trans, root, path,
 					      path->slots[0], del_nr);
 			if (ret)
-				goto out;
+				break;
 			if (key.offset == bytenr)
 				break;
 		} else if (key.offset < bytenr && csum_end > end_byte) {
@@ -906,8 +907,9 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 			ret = btrfs_split_item(trans, root, path, &key, offset);
 			if (ret && ret != -EAGAIN) {
 				btrfs_abort_transaction(trans, ret);
-				goto out;
+				break;
 			}
+			ret = 0;
 
 			key.offset = end_byte - 1;
 		} else {
@@ -917,8 +919,6 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		}
 		btrfs_release_path(path);
 	}
-	ret = 0;
-out:
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.26.3

