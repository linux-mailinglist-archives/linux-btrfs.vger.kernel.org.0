Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 622AE1850F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 22:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCMVXl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 17:23:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37389 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCMVXk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 17:23:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id l20so8892501qtp.4
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 14:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OOBFyqkrQr+Dn4m5CWFrw5I8BTcUf0dy0sA0giKOzqA=;
        b=jHLDtmT8SKO9dYksEaPCXlqBgyxuHWTxxieUrkjTFC6VRbAdiO5iUt21YPlK4JiQPG
         VGhtNiIcIr/5rGa7AC656nzzo5ixVHT5/341wInDjgKiAjAgremyiZrvRCFV7fQ3jzrZ
         inGg7oMCBWdZ0CNZj9Ch8VTq70EbSlX7UmPvExBsaVBuzlDW0t/aKba2LJrix94jaAFV
         m1KLvzZT3uuKPI/NAk0dx4viZi4G0TtwvQmQiGG8sOOwn7mHnjpEUu48hXvMUFkVFulQ
         SG0Mf8N2OZxDGiGIjEYn7qHg2/whOvW3uXI8DJ+l9BY0vS1rtbUcJiGkCNR36HQr+8+B
         diHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OOBFyqkrQr+Dn4m5CWFrw5I8BTcUf0dy0sA0giKOzqA=;
        b=nme0lUS6BN4r4cdfGYWY2SpaVZHEidRJLbI1WRSWWapFrvgshmby8dDO0E7mqcj25f
         ptk6fAQnk2rnBJ7GJKw+oDf3wEbt6wvZ7X2N6vuRkCJBTke/tR5EwcehChe9Gy2FTTyq
         hnTahkulxWLzTl+R0CRMFzsF33mJuqJpxJkurTw6PAWBNd9YjkOTZCR0hsesdC+ZqS04
         nmPt6hMZxfIz9Vo97I/ifUkT2whB6a8WOGOVoAvbR2F+SCCnGTJNG4eH6hpBXPOX8A1n
         9vPTrQ3DSYiEtcUK1cQEwk2iH+fKVrIaTctvumOhXNShTKsUINLUq/bruRsu//N2eLmI
         RxvQ==
X-Gm-Message-State: ANhLgQ380rP2gAnm6E93CLLxrwDWL80ExxkGZcxlAwi7FO3/oBacxCns
        w6c7XXSqQfOAofzFcK1eb76t/K5su0Q+ag==
X-Google-Smtp-Source: ADFU+vtBECs1hi+6qXfpMlNoIIP+/Y1plg23wpdK8cTNfIbEaua8Alk3FdLzr3QUDiYEDDbTX4nkEQ==
X-Received: by 2002:ac8:6704:: with SMTP id e4mr14519554qtp.311.1584134617923;
        Fri, 13 Mar 2020 14:23:37 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d73sm12462911qkg.113.2020.03.13.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:23:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/13] btrfs: make btrfs_should_throttle_delayed_refs only check run time
Date:   Fri, 13 Mar 2020 17:23:20 -0400
Message-Id: <20200313212330.149024-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313212330.149024-1-josef@toxicpanda.com>
References: <20200313212330.149024-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_should_throttle_delayed_refs checks run time of the delayed refs
and if there's enough space.  However we want to use these two checks
independently in the future, so make btrfs_should_throttle_delayed_refs
only check the runtime.  Then fix the only caller of
btrfs_should_throttle_delayed_refs to check the space as well, because
we want to throttle truncates on either space or time.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 3 +--
 fs/btrfs/inode.c       | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index acad9978b927..e28565dc4288 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -64,8 +64,7 @@ bool btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle *trans)
 		return true;
 	if (val >= NSEC_PER_SEC / 2)
 		return true;
-
-	return btrfs_check_space_for_delayed_refs(trans->fs_info);
+	return false;
 }
 
 /**
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b8dabffac767..d3e75e04a0a0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4349,7 +4349,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				break;
 			}
 			if (be_nice) {
-				if (btrfs_should_throttle_delayed_refs(trans))
+				if (btrfs_should_throttle_delayed_refs(trans) ||
+				    btrfs_check_space_for_delayed_refs(fs_info))
 					should_throttle = true;
 			}
 		}
-- 
2.24.1

