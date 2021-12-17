Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B972947866D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 09:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhLQIpa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 03:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhLQIp3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 03:45:29 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E593C061574;
        Fri, 17 Dec 2021 00:45:29 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id m186so1458959qkb.4;
        Fri, 17 Dec 2021 00:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qem6ObnSj1SC6nvlpPvXvZdiZP7lSTCoGpvaHyhm82E=;
        b=l1NCIXlH6w0OrXE67F+UB++mYFYAUWohT5otiFNmtksKpT/uLIMCAUKGmjbK0X6GfU
         dutdC+ea/BhN9yjBcUbbl1XngQsv7X4U7XySMvPdbWBm+3q7otvgVqlIPm+WCwVllEyC
         Ub2NU7NcohPa3YnbzyoUPw0NyeNBBjcBT2VYj0n94iRY//OVZB4/O6EtJMugFvOEDSOC
         2TnTxLiwwPXEyeK1kJcvxcJE0/QG12q4AFf4DtqcbbENJ/QolB0042WmE0KR2kSCusn/
         CECFi2TyLNdIe2QpQHXbsRtEDBcm2f/Hud4MNojTHe4kW/2ciT7YBr4Athy5dFSxZnLf
         U4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qem6ObnSj1SC6nvlpPvXvZdiZP7lSTCoGpvaHyhm82E=;
        b=05geGuA5XSjEcaSELnhTBQUGjNeBqS7D62PcmF1hs2B22l8JTnrRjGcsP3dRextYcc
         fd6a5vDeld0efVWQ5ELMztKs+94mbTQLd2BFHNgXg6TjzI5U62lcWmleytHqaNax91qm
         Ynp61MZJmsjB/ZzxHkMyMW5k2oUysHGp5i+uAh+pn5iQjnUUXYjhJeKqAYdWQ1nGra9P
         oOC36r9/c1Jzd0VgsCX+Wh86P7OYBgldCJD5d6gNAkXKiQd8drSB21GigyjbEIsHzsKA
         xwugLKxgECDBawVq8d+Ehm49Kc/yJ895mNid2TZD5FB47hBl+ZJ9BQcmoA4kJOAh5RI5
         vOrw==
X-Gm-Message-State: AOAM532OjvJ8e+aEcaH95/tyOTbUXLjRbbnuFHpAdrOb/k3pOfY07K71
        3BFMlKbCLleyLIpEB/GgYAGyibSyvmQ=
X-Google-Smtp-Source: ABdhPJzRraHpKVYsVkAiHTfVTzTDv6STGcz/k3Br9kAKIwMwS0JQ6+1A1v2+x7DLyKZ21TCV8dz/Qg==
X-Received: by 2002:a37:c20b:: with SMTP id i11mr1067667qkm.300.1639730728797;
        Fri, 17 Dec 2021 00:45:28 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d19sm6569666qtb.47.2021.12.17.00.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 00:45:28 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] btrfs: remove unneeded variable
Date:   Fri, 17 Dec 2021 08:45:22 +0000
Message-Id: <20211217084522.452493-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 fs/btrfs/disk-io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d94a1ca856aa..d33575e56da2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4658,7 +4658,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	struct rb_node *node;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_delayed_ref_node *ref;
-	int ret = 0;
 
 	delayed_refs = &trans->delayed_refs;
 
@@ -4666,7 +4665,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	if (atomic_read(&delayed_refs->num_entries) == 0) {
 		spin_unlock(&delayed_refs->lock);
 		btrfs_debug(fs_info, "delayed_refs has NO entry");
-		return ret;
+		return 0;
 	}
 
 	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
@@ -4729,7 +4728,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 
 	spin_unlock(&delayed_refs->lock);
 
-	return ret;
+	return 0;
 }
 
 static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
-- 
2.25.1

