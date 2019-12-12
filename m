Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E7111CBC1
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfLLLC0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:02:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45967 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfLLLCZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:02:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so563419pfg.12
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rLvlEok35MafMPzYVV8dLWPKxrqP2gkK5+o2+VtTio0=;
        b=ojF5EoYwn4/kOfpt55diLmfXR5EAAqoexOhFHM+jTx0C56s9aMyVvo92L/8Rd6mGSo
         p/Kit3oMU5yDo1HvjNyT18xjFSJ7HbgQI83j6BZvyLWq9DMvdVvS9q7k+gfrANmuhqno
         UHsbvfd8I67CZEjiRvQcbuwXiAn4fyyL22UtLw9NvG0NrneDYZY43WUArUBsG7To9Kf/
         AZkmmTYn1CpeImajmZ8rzfUkfuRarCMi2loEcHpj01QcWo7HDbLWi50UWBL+qwhkRQ8g
         xBIJkWUKRSUPw5agbxHlfRAEyg9/6v9I4qk83jv7x6PLjTDcWCPuemdxkB78sY1sqlf0
         eCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rLvlEok35MafMPzYVV8dLWPKxrqP2gkK5+o2+VtTio0=;
        b=V/TrrHxPnubtem0Z8RIHUoB7UJ/l4vy/nrnEcTBzZd1XSlxhYlKs9CuR38reZPR7iM
         gP2/30SJu1tlA3YiODG1cFSDH4ERl7k+/6BGfH5CpUS4z35sB1Fz3hf8xv/zWIiQRiIt
         11aGXe7yEQhPwrs6sKboJK3KE/hsIFMG4FJDdTD5kycRMJS4BkGSgDTh27/p1KdqnW25
         fQz+p0JHPySpV67sckEk8Z56UK+FPSqxYNoUDIEXE6DWiU2XlSBPDNyva6gDOzLy6tRJ
         UW8O8uY4u8aCHR0V3yz4SZ3VtugRPlHEO/orL5rAswTH2zdJZWoju7+efeRK2wDoSni5
         z0RA==
X-Gm-Message-State: APjAAAW+Khknr7m43CohGpaCsPPdfvIJPLWo0KtVFQWvufMZFlH7xyAz
        G0mgCkNQj9Hm4dLOMOscnFDdv8Sv260=
X-Google-Smtp-Source: APXvYqw4+aTmbIW5vdbTLo9Z5ZhxnGJl60ffCJWIIHiHDK03IKAvNIMPyIXeP03vwNDZqMbr6SCdww==
X-Received: by 2002:a63:5718:: with SMTP id l24mr9575984pgb.136.1576148544874;
        Thu, 12 Dec 2019 03:02:24 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id e20sm6587857pff.96.2019.12.12.03.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:02:24 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 07/11] btrfs-progs: handle split-brain scenario for scanned changed/unchanged device without INCOMPAT_METADATA_UUID
Date:   Thu, 12 Dec 2019 19:02:00 +0800
Message-Id: <20191212110204.11128-8-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191212110204.11128-1-Damenly_Su@gmx.com>
References: <20191212110204.11128-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

For the unchanged/changed device, just need to fs_devices in changing
state, or devices with same status:

a) The scanned device succeeded to sync into disk. The fs_devices
must be with INCOMPAT_METADATA_UUID. So their fsid and metadata_uuid
differs, and metadata_uuid is same as its fsid.

b) The scanned device failed to be into changing state. There
are some devices whose fsids are same as the device's.

c) The above cases all are missed, only unchanged devices are same
as the device.

Case b and c can be merged into one that only same fsid requirement is
meet.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 volumes.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/volumes.c b/volumes.c
index d094f85999d4..94940dd82d0f 100644
--- a/volumes.c
+++ b/volumes.c
@@ -319,6 +319,35 @@ static struct btrfs_fs_devices *find_fsid_changing_metadata_uuid(
 	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
 }
 
+static struct btrfs_fs_devices *find_fsid_changing(
+					struct btrfs_super_block *disk_super)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Handles the case where scanned device is part of an fs that had
+	 * multiple successful changes of FSID but currently device didn't
+	 * observe it.
+	 * Since the scanned devices does not own the metadata_uuid feature,
+	 * fsid and metadata_uuid of the changing devices must differ, and
+	 * their metadata_uuid must be same as disk_super->fsid.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, list) {
+		if (!fs_devices->fsid_change)
+			continue;
+		if (memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
+			   BTRFS_FSID_SIZE) != 0 &&
+		    memcmp(fs_devices->metadata_uuid, disk_super->fsid,
+			   BTRFS_FSID_SIZE) == 0)
+			return fs_devices;
+	}
+
+	/*
+	 * Back to find newer fs_devices is changeing or some in same stage.
+	 */
+	return find_fsid(disk_super->fsid, NULL);
+}
+
 static int device_list_add(const char *path,
 			   struct btrfs_super_block *disk_super,
 			   u64 devid, struct btrfs_fs_devices **fs_devices_ret)
@@ -338,6 +367,8 @@ static int device_list_add(const char *path,
 			fs_devices = find_fsid_changed(disk_super);
 	} else if (metadata_uuid) {
 		fs_devices = find_fsid_changing_metadata_uuid(disk_super);
+	} else {
+		fs_devices = find_fsid_changing(disk_super);
 	}
 
 	if (metadata_uuid && !fs_devices)
-- 
2.21.0 (Apple Git-122.2)

