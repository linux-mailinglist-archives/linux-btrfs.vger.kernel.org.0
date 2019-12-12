Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9D311CBB4
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfLLLBo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:01:44 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:45512 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfLLLBo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:01:44 -0500
Received: by mail-pl1-f181.google.com with SMTP id w7so430876plz.12
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pO/g9bUT2hETdxppuk7HxjTtqbNbIc8YIlIdCsaytvw=;
        b=R527+kuNtq3Sh39bZ2SbdT0YgnJq3IZsYn8TCipcLiFKg0kgOO38ryL3HK5hX4dYG3
         qu8APz0V/eNtm2c+IP95uLUnpVySBiAVGY+x40qGCPql3JIsRu6QU+VliCzDD7LsMcH0
         h80AqwxS7TC/i7qF8dxRbcSAWaSDzdazw28jl80gYK68SBePENJzySkgGHG0xk3rw4Ij
         NKFQaHtXywa6GgApMgWKn4PBdF/s+HJ0KMu3OO83te2AP6A7DLBEKHAidcgcodLIQJzs
         8rHy+hdk/VGJWmy9GciPW1Xh1NN0gG6TRlwh0BpJ/k5ratNM0LmLnKykbPAmiMpWJECg
         2TrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pO/g9bUT2hETdxppuk7HxjTtqbNbIc8YIlIdCsaytvw=;
        b=bkEt1S/dD5+VV53YC/8Syjm2AolFI+JUIpOUtHOld9THZDr94HyWx6Xj3/CySTwLoP
         zVpVJypXJFj560kRvMXIt4/WPUX2jrqhe4EtclGHHlegsOmpvAFGls9Z7nGBSq35D+dU
         tMmMq5ypKOc16sJQu+RmWMuvBJl/D+Qx+WNF6C8U8rsFAJC448QS61sLA0OP2vJGtiUR
         vtjRk5a+AgTxDMy3gEft/B+X1azA0Ff4C1eoVICwSVccMiOfKjX92w1hsawN39nbsu43
         mZrilKgdLB7mULsewaSc4/VZDMwzz8jg3XMAkaXfebp1TP/kryZE+wuV3n3laDDp0GIt
         yujw==
X-Gm-Message-State: APjAAAV6iQCYnY2nQgB3QlE8exVVT6OWnczVhaINRHbX3bl1HIEpbOK6
        dnI2w+PPOgr3XAiwffutEjOQSzI2LMM=
X-Google-Smtp-Source: APXvYqxoQBxpd/FSEYWjT3kJPqSVXeBk+P3FH9IIc4DCPmuJTcKaHjToSWca0ldWqFhyEk8v1MGP4Q==
X-Received: by 2002:a17:902:fe8d:: with SMTP id x13mr8949195plm.232.1576148503050;
        Thu, 12 Dec 2019 03:01:43 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id w11sm6682387pfn.4.2019.12.12.03.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:01:42 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 3/6] btrfs: split-brain case for scanned changing device with INCOMPAT_METADATA_UUID
Date:   Thu, 12 Dec 2019 19:01:29 +0800
Message-Id: <20191212110132.11063-4-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191212110132.11063-1-Damenly_Su@gmx.com>
References: <20191212110132.11063-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

This patch adds the case for scanned changing device with
INCOMPAT_METADATA_UUID.
For this situation, the origin code only handles the case
the devices already pulled into disk with INCOMPAT_METADATA_UUID set.
There is an another case that the successful changed devices synced
without INCOMPAT_METADATA_UUID.
So add the check of Heather fsid of scanned device equals
metadata_uuid of fs_devices which is with INCOMPAT_METADATA_UUID
feature.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 fs/btrfs/volumes.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b08b06a89a77..61b4a107bb58 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -654,7 +654,6 @@ static struct btrfs_fs_devices *find_fsid_inprogress(
 	return NULL;
 }
 
-
 static struct btrfs_fs_devices *find_fsid_changed(
 					struct btrfs_super_block *disk_super)
 {
@@ -663,9 +662,14 @@ static struct btrfs_fs_devices *find_fsid_changed(
 	/*
 	 * Handles the case where scanned device is part of an fs that had
 	 * multiple successful changes of FSID but curently device didn't
-	 * observe it. Meaning our fsid will be different than theirs.
+	 * observe it.
+	 *
+	 * Case 1: the devices already changed still owns the feature, their
+	 * fsid must differ from the disk_super->fsid.
 	 */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (fs_devices->fsid_change)
+			continue;
 		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
 			   BTRFS_FSID_SIZE) != 0 &&
 		    memcmp(fs_devices->metadata_uuid, disk_super->metadata_uuid,
@@ -676,7 +680,26 @@ static struct btrfs_fs_devices *find_fsid_changed(
 		}
 	}
 
-	return NULL;
+	/*
+	 * Case 2: the synced devices doesn't have the metadata_uuid feature.
+	 * NOTE: the fs_devices has same metadata_uuid and fsid in memory, but
+	 * they differs in disk, because fs_id is copied to
+	 * fs_devices->metadata_id while alloc_fs_devices if no metadata
+	 * feature.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
+			   BTRFS_FSID_SIZE) == 0 &&
+		    memcmp(fs_devices->fsid, disk_super->metadata_uuid,
+			   BTRFS_FSID_SIZE) == 0 && !fs_devices->fsid_change)
+			return fs_devices;
+	}
+
+	/*
+	 * Okay, can't found any fs_devices already synced, back to
+	 * search devices unchanged or changing like the device.
+	 */
+	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
 }
 
 static struct btrfs_fs_devices *find_fsid_changing_metada_uuid(
-- 
2.21.0 (Apple Git-122.2)

