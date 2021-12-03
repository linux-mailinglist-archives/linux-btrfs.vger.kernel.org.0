Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC92467FD5
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383404AbhLCWWG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383391AbhLCWWF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:22:05 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCA4C061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:41 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id i12so4121841qvh.11
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=movu3ZDMaTPISGz+rJN4jMsmWtBrdiB3UzbXLgAyFOk=;
        b=r2//tP+IxEjvjxbHFXHdY3mns1j+J1iwupVAEOz4mQofhoHUPGnHWgKNrrWNYWvYK4
         5x/nFnJ+xzxmoZsL+7NXAG8yP9U5TCZ5XJ0L6WXXqOsLcpFx2mpxRMV4Gt4whGAflKrK
         5gnbmnHosJZ34R0M9/49xg7hmqeh9h5RaVyU2ucVTqPD3yr1oOk9EGjkZcjnob6ZkAMr
         BTEvqX0MhO0aJQjBsx4DzOoguUhh1djnNzNVSznhZZ/lJk6oMN/ttHOJAeQMZvi32guO
         tjmTuKhA7rg9HpmckvVqd6Rb1Plp8WuMW1CYxpV/pAQAm6wnonoINn/VsMvCieLRhl7n
         M0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=movu3ZDMaTPISGz+rJN4jMsmWtBrdiB3UzbXLgAyFOk=;
        b=D/LX8yl2OdrgSxlhIJq39v95gqFLTX9/oSz3Fqz7AhWmEgetL9zjgr6tVUercxvzqI
         aIuVXqJBS54V2U9hsdNih+VcsKbMrNNQRIpXyIEeADlUZsjibFGWaH3A5BUQ6ai1Ge0L
         mlvbjbbWJBd6kV9fANP2isG4FzYg7Wrncn3mujvW4JmNlCHQ8/WTjjUepcn8qzZcu+W4
         I5q5+wznn22CWr3PJ2ziXzorkUKAlNl7sYCM7chVtXNwHo9NnB1fj1S4A3g9V6+M4vG2
         5lROWZLJXx1crVGAZFvNlKgNPDQGZfDR6ZSMwaadc9TgsDmFrxN+zlucJi5aOWJu8x2y
         AjvA==
X-Gm-Message-State: AOAM530LTcwN7GJ9zjZvayaE/l21rzihjV3dseZDp4N59kcVFmQLKIcf
        UB4JCEpno143lONOs99SdXjO6Tz7Ywqauw==
X-Google-Smtp-Source: ABdhPJzblfZ8BsNqlw0BaGcFk5kUSan9uix/fklhnAAiDUHs6A+lIQQGfqTD5WtxDx0n8QfPvlac+g==
X-Received: by 2002:ad4:528d:: with SMTP id v13mr21708576qvr.100.1638569920453;
        Fri, 03 Dec 2021 14:18:40 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bp18sm2940129qkb.39.2021.12.03.14.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 15/18] btrfs: convert BUG() for pending_del_nr into an ASSERT
Date:   Fri,  3 Dec 2021 17:18:17 -0500
Message-Id: <ae5ba0416e8d9c8153b4f48ea8960262fc5cc560.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a logic correctness check, convert it into an ASSERT() instead
of a BUG().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode-item.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 652b7069f63d..9c44cf30d930 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -655,6 +655,9 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		else
 			control->last_size = new_size;
 		if (del_item) {
+			ASSERT(!pending_del_nr ||
+			       ((path->slots[0] + 1) == pending_del_slot));
+
 			if (!pending_del_nr) {
 				/* no pending yet, add ourselves */
 				pending_del_slot = path->slots[0];
@@ -664,8 +667,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				/* hop on the pending chunk */
 				pending_del_nr++;
 				pending_del_slot = path->slots[0];
-			} else {
-				BUG();
 			}
 		} else {
 			break;
-- 
2.26.3

