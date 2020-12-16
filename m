Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF1F2DC42E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgLPQ2d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgLPQ2d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:33 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2E0C0611D0
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:23 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id l7so11606487qvt.4
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=57E4O92Kk5NHxfOb+zeLfEAGt+8uI+0goGLtIs7kD/I=;
        b=xx3AZSHJXeJU77DZleUvpxyxC0SMl3AQIXcJVoJO5x557POI0/NTtflwcbNVwaBY2U
         Vk+Xr8WmueB6xdmfgQmyPZzvmstRiAG8xMd5eNfYKNQVU0N0ENV5b5v9tNdxAu2wfJiB
         FYgJxcz+HSk/KNF4FeQ1QINZ4JNqgG+dhJzkWm+YpSPAKMGxpslw57xun1baWp/Rt83d
         WD4gs926x+agwMEQ3jqSS76N5r0wtqf6n/d/nEkzHhIVEvWEUlH6ELxpbKMXRzOhlENY
         ZociVMXDyqgYL7aJ/XoOTORxGBL8sdUzlqf31mWThmvsObWBdGLDcGWBLIPc8wgJQMbO
         UZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=57E4O92Kk5NHxfOb+zeLfEAGt+8uI+0goGLtIs7kD/I=;
        b=Hsp1sUj2RfJsaoPNA4I/ZUi0lHQOmLkdwSUf3t0mxts8oWucKvHau8p/ixuDPGwq2H
         uqlWmGE7RzQKifbdF8docoLTysHfp/ohcGn0pthDPdGlIsiu5dRRsEmO6mMihCqph+va
         2haS0VQ+gHOGw5xIGmevclYJQt1Qlj/PFwJGZ9+NitamhwGNxCe2kdYcefochFTQU4ul
         MZgB3sOMjUYmJrY6fgkVoSREO6JRN5ZPvKELu1AdBW7R4AGx4/SVYg/6E25F8ec6o+DR
         38FCW9bcI7xZqk3m8PibJu8EHnfVkK8dNJnsF73Z1RdP5WpBgYd/ILZbxJ5isn58OHXf
         1sIg==
X-Gm-Message-State: AOAM533XAqb4jJY+5mKYVPhLQu4DLkzc436RSx2fPvl/iKTUWmnk2Cwg
        hC63zjT6udufWDVh0PbOGiYZGluw2lp0hk6u
X-Google-Smtp-Source: ABdhPJxxQDfYDdoQZQZcsCsCX3QbCRutfBKX+v7GoDgI/FO9cFyBStmiTKouoBZGnO50FXjDDsvsww==
X-Received: by 2002:a05:6214:10c6:: with SMTP id r6mr43252446qvs.44.1608136042289;
        Wed, 16 Dec 2020 08:27:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o4sm1205193qta.26.2020.12.16.08.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 15/38] btrfs: handle record_root_in_trans failure in btrfs_record_root_in_trans
Date:   Wed, 16 Dec 2020 11:26:31 -0500
Message-Id: <5aa1ecd6b47f366cf145d10944f02bace7a337e3.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

record_root_in_trans can fail currently, handle this failure properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 5b3008ec4e13..4efdb87df27d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -480,6 +480,7 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	int ret;
 
 	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		return 0;
@@ -494,10 +495,10 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 		return 0;
 
 	mutex_lock(&fs_info->reloc_mutex);
-	record_root_in_trans(trans, root, 0);
+	ret = record_root_in_trans(trans, root, 0);
 	mutex_unlock(&fs_info->reloc_mutex);
 
-	return 0;
+	return ret;
 }
 
 static inline int is_transaction_blocked(struct btrfs_transaction *trans)
-- 
2.26.2

