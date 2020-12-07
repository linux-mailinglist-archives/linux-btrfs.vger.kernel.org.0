Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14BF2D12E5
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgLGOAE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgLGOAC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:02 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CB6C09424B
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:49 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id 7so9391841qtp.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KUMwtyvBJyOvxYGVZ896Bgl7sIns8gjAueMfjoGX5eg=;
        b=BREltKcaxnNTUblm4IrNjbCoKJcq31RoEeevHYZWrUCYRk4emMLf22p61Z0fYAD1LA
         XagSbZtMX3aViNXDgwkgYyjkybp2dmxRfAYNKp3sd12MSiR+XCghkUwOjSCCAH6f8rNh
         WB7Ff96kHySMbaw+cMN/IgnARpwoaVs8FdlTczhzZJISRQ3FZozY6PTXgCqRIbwur99Y
         J/PfoepkO0UExvPLoi+1POQnsk995l/FB4NXsOUoWqeOYUS709/GaezqojGeZ5KHrN1b
         AxZQOlfN0TOWNsFb+hRnMkGDCGebPoqk8hNjyp+Mbi8KVceqPre50peW/O0eSmwdPxZZ
         XR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUMwtyvBJyOvxYGVZ896Bgl7sIns8gjAueMfjoGX5eg=;
        b=N4e40Goh3xZZJx//nSDCSIrk138fpjS0n0mPfBUrdeQqwJyRwMQLw8KjOV0q98K5Qx
         ZrkpTy+x3K9Dd4Pc/19A5NPbgTT6Oncg33O/UWv03RPo3HPfkbZYy6AAOpy5kxxYhyfl
         CeydmSpwSaNB3cyleDIkYXrwvrwC4J16xfwd2NCG17onerDllWaYcQ/FWIYCj2xsK3G0
         NwsvIpZYKav5mjki95bKQolxD3ftNtfelV4iaevJxUvmrK+FSy/yWs2F9oKlyL5zbsA2
         jYxLCuBliBsbdYLpvJSPlnVTcxuNsLdR5YqgaPc+xFBIuz37UGPrSMb6Xs11gSNI3ckm
         ItgQ==
X-Gm-Message-State: AOAM532wUb+XGhrjt4keh8/VRCzn4zxJ2ummGH6gM1BznAS02Y9ZMizv
        k1IJxchgdp+dl/8QaSfwSC1PRx4epBTwyt9r
X-Google-Smtp-Source: ABdhPJxKYNesBsNkkfg34w3o8twFo8UH9MoQFIQYU4BrwfJKAgsc/UQxU2sh87e/s/o+40mWqa2mDw==
X-Received: by 2002:ac8:730d:: with SMTP id x13mr6095772qto.162.1607349528372;
        Mon, 07 Dec 2020 05:58:48 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 6sm1528811qko.3.2020.12.07.05.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 32/52] btrfs: change insert_dirty_subvol to return errors
Date:   Mon,  7 Dec 2020 08:57:24 -0500
Message-Id: <965ee191ab820ce48c2b1263e4de65abf1a0902c.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This will be able to return errors in the future, so change it to return
an error and handle the error appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5770f4212772..f41044d2b032 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1556,9 +1556,9 @@ static int find_next_key(struct btrfs_path *path, int level,
 /*
  * Insert current subvolume into reloc_control::dirty_subvol_roots
  */
-static void insert_dirty_subvol(struct btrfs_trans_handle *trans,
-				struct reloc_control *rc,
-				struct btrfs_root *root)
+static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
+			       struct reloc_control *rc,
+			       struct btrfs_root *root)
 {
 	struct btrfs_root *reloc_root = root->reloc_root;
 	struct btrfs_root_item *reloc_root_item;
@@ -1578,6 +1578,7 @@ static void insert_dirty_subvol(struct btrfs_trans_handle *trans,
 		btrfs_grab_root(root);
 		list_add_tail(&root->reloc_dirty_list, &rc->dirty_subvol_roots);
 	}
+	return 0;
 }
 
 static int clean_dirty_subvols(struct reloc_control *rc)
@@ -1779,8 +1780,11 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 out:
 	btrfs_free_path(path);
 
-	if (ret == 0)
-		insert_dirty_subvol(trans, rc, root);
+	if (ret == 0) {
+		ret = insert_dirty_subvol(trans, rc, root);
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
+	}
 
 	if (trans)
 		btrfs_end_transaction_throttle(trans);
-- 
2.26.2

