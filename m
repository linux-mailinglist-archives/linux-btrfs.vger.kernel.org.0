Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8F011CBB3
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfLLLBm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:01:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34013 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfLLLBm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:01:42 -0500
Received: by mail-pf1-f194.google.com with SMTP id l127so586330pfl.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Djxe/PPl0LbZU+pLhTDhmQ7+WDv6iuRyef6eSJ8l57Q=;
        b=uVUuUebfOhFA7gVOzVjdoMco2K18biNK+xWc4/4cY5yULiGuYAGNUU8VAD4d2iib6m
         3MrN6MHjYgxL4yhMmAz2wGEo6wSgCOHzhvl9IXB2WUTZxzewORIjgYtwTii+fQKYfwvX
         CkTUkf1PzGgPuO9Odv7g4nVCm4SIJJltPMa5iGkd63UUp2mi2rUuIpVgTZLwdubEKV9B
         vM/VWVAYJHiIz8M0Gv0UOL5FKijHpEU4+4aAGzdJH+kvPr4PXykdgT8ZoJ806FeofJfj
         dg8hhshcN5rTRTj4dz8y5BskoNYudCedFX3pfXUDRdphGjDlxXEysZLB3F6r/hkFsnaq
         y5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Djxe/PPl0LbZU+pLhTDhmQ7+WDv6iuRyef6eSJ8l57Q=;
        b=BbIRHb2Hjc/1h35YpXw9mboIb2XOS+gR36lySnbhPAFOBDlhyXpRqhNSYd9VP3MQVJ
         sPTX0u0dqGG7rpAuNSkcCtSGEZ0ucYK+62wAMmpW6eAtzSU1Vaf2X4MvJfYpdJW51Ysr
         XatGalPOi8zIGNamlc9YMHGQriGE53bUo2wdu5Hq7i8b+ya6uGlhGLU+RIeTK540D5wD
         g8JGEWagegpRRJTWQeK9cyfshnWZADinPcA4Yq6u5u0XtMzyNzqFK5yUwLxBCU48twY8
         bhk3keTp1vEwITYZUIxFU0CpLhkE7wYzDsDnqrw5sneqJ5OyOpZ6zgJGxflOXGZltBSn
         znmA==
X-Gm-Message-State: APjAAAW2aIfUfKd7ENkJBGdLUWN1khmVaTF6/EsGt8wi5s7EzkgRPgzl
        hbryTTSKqfeFgzFfsdAFeQpV4XDuzYM=
X-Google-Smtp-Source: APXvYqx49cUFV8KJ3kXZysaQikGe4SXC172YzF+kfwfl3K//R+ihgyRicq+WiYsxuIe2UrYd/fW5gA==
X-Received: by 2002:aa7:8ad9:: with SMTP id b25mr9075793pfd.70.1576148500546;
        Thu, 12 Dec 2019 03:01:40 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id w11sm6682387pfn.4.2019.12.12.03.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:01:40 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 2/6] btrfs: metadata_uuid: move split-brain handling from fs_id() to new function
Date:   Thu, 12 Dec 2019 19:01:28 +0800
Message-Id: <20191212110132.11063-3-Damenly_Su@gmx.com>
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

The parameter @metadata_fsid of fs_id() is not NULL while scanned device
has metadata_uuid but not changing. Obviously, the cases handling part
in fs_id() is for this situation. Move the logic into new function
find_fsid_changing_metadata_uuid().

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 fs/btrfs/volumes.c | 78 ++++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9efa4123c335..b08b06a89a77 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -438,40 +438,6 @@ static noinline struct btrfs_fs_devices *find_fsid(
 
 	ASSERT(fsid);
 
-	if (metadata_fsid) {
-		/*
-		 * Handle scanned device having completed its fsid change but
-		 * belonging to a fs_devices that was created by first scanning
-		 * a device which didn't have its fsid/metadata_uuid changed
-		 * at all and the CHANGING_FSID_V2 flag set.
-		 */
-		list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-			if (fs_devices->fsid_change &&
-			    memcmp(metadata_fsid, fs_devices->fsid,
-				   BTRFS_FSID_SIZE) == 0 &&
-			    memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
-				   BTRFS_FSID_SIZE) == 0) {
-				return fs_devices;
-			}
-		}
-		/*
-		 * Handle scanned device having completed its fsid change but
-		 * belonging to a fs_devices that was created by a device that
-		 * has an outdated pair of fsid/metadata_uuid and
-		 * CHANGING_FSID_V2 flag set.
-		 */
-		list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-			if (fs_devices->fsid_change &&
-			    memcmp(fs_devices->metadata_uuid,
-				   fs_devices->fsid, BTRFS_FSID_SIZE) != 0 &&
-			    memcmp(metadata_fsid, fs_devices->metadata_uuid,
-				   BTRFS_FSID_SIZE) == 0) {
-				return fs_devices;
-			}
-		}
-	}
-
-	/* Handle non-split brain cases */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
 		if (metadata_fsid) {
 			if (memcmp(fsid, fs_devices->fsid, BTRFS_FSID_SIZE) == 0
@@ -712,6 +678,46 @@ static struct btrfs_fs_devices *find_fsid_changed(
 
 	return NULL;
 }
+
+static struct btrfs_fs_devices *find_fsid_changing_metada_uuid(
+					struct btrfs_super_block *disk_super)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Handle scanned device having completed its fsid change but
+	 * belonging to a fs_devices that was created by first scanning
+	 * a device which didn't have its fsid/metadata_uuid changed
+	 * at all and the CHANGING_FSID_V2 flag set.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (fs_devices->fsid_change &&
+		    memcmp(disk_super->metadata_uuid, fs_devices->fsid,
+			   BTRFS_FSID_SIZE) == 0 &&
+		    memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
+			   BTRFS_FSID_SIZE) == 0) {
+			return fs_devices;
+		}
+	}
+	/*
+	 * Handle scanned device having completed its fsid change but
+	 * belonging to a fs_devices that was created by a device that
+	 * has an outdated pair of fsid/metadata_uuid and
+	 * CHANGING_FSID_V2 flag set.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		if (fs_devices->fsid_change &&
+		    memcmp(fs_devices->metadata_uuid,
+			   fs_devices->fsid, BTRFS_FSID_SIZE) != 0 &&
+		    memcmp(disk_super->metadata_uuid, fs_devices->metadata_uuid,
+			   BTRFS_FSID_SIZE) == 0) {
+			return fs_devices;
+		}
+	}
+
+	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
+}
+
 /*
  * Add new device to list of registered devices
  *
@@ -751,13 +757,11 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			fs_devices = find_fsid_changed(disk_super);
 		}
 	} else if (has_metadata_uuid) {
-		fs_devices = find_fsid(disk_super->fsid,
-				       disk_super->metadata_uuid);
+		fs_devices = find_fsid_changing_metada_uuid(disk_super);
 	} else {
 		fs_devices = find_fsid(disk_super->fsid, NULL);
 	}
 
-
 	if (!fs_devices) {
 		if (has_metadata_uuid)
 			fs_devices = alloc_fs_devices(disk_super->fsid,
-- 
2.21.0 (Apple Git-122.2)

