Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20AB311CBB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfLLLBr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:01:47 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39563 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfLLLBr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:01:47 -0500
Received: by mail-pj1-f66.google.com with SMTP id v93so882897pjb.6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AI0BdMmmWTRIKTqPcqoA73oojnJqj0oYN0qY9MI7B5I=;
        b=lYHnLSa8FQk8Lj9wYy3eAaRTvsByXxZ9LsS00O/etHagR64MH9LsiBS2aKUXB9R1b/
         KvB26eoXXISk1TxBvcl604lzAAdTRlHkid4qTcyQVZaR2opSI0p9FtJdaanNjNTAHC5+
         pv/fLzzwnxqk7osaHJ7eNgtmxmhIipyx0G+KZSdM26DSLtjDw376sCnDJ4dqxxqZfV/o
         vc+f2hR5iBgBzdl6Ow9bSTadB9mHSVu2nC3r9cy5cQOh2nnO/uW4Eqnod+LMyhHuNtSk
         h+0yvYKyM+DomcmzGwv9ZWedkYsDzKYe1+6EDuihb7859BMghMuPdlzuahxCwEkmCsI9
         zl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AI0BdMmmWTRIKTqPcqoA73oojnJqj0oYN0qY9MI7B5I=;
        b=gGeO7w7Mrz1LwWERg78reIkNJcd8nAu6Xo9WsD7miseSiXge2aLY8DAoJPXhCo1ex9
         JBwGsl1AWlP+UPo1CFcN14VSQg9I1kUpqoafmiKDxdb2OMvxxGhB4XDm9vcf5bX1wMcY
         /I/L7zi4+v6Xf1wOZ1ndn3xOc/0OmVTu1zIjpY7CPNrzh/Z/OvXhbTEhYGzX6sJxmYc8
         vUjcdyYCYZQ3YswZhpVYaEy+jQInIWlmyKUmwKpbKBBFKjQkf26MpEWZc4NHF30PIJiR
         mCa1EHwwu5P41Se8te6Eq5keHZ/mbuCORpkJZQpvbG37hOlUzpW6wr5C6RNnOmX1PWIr
         IbBg==
X-Gm-Message-State: APjAAAXz7R6AwPPlC4nato8Lg3ZzcIgv3kl75hOm+VvvKcgPcHksMykU
        zbSZiEsaUCvy0dJdgyzuiBygOGIV1Hc=
X-Google-Smtp-Source: APXvYqx5qSi5vF96OYgpjO6pxXUzSYWLcAvGvR77tfxhxSe0jiICgWc8y7TQKK5NGM0BSd7h05T0vw==
X-Received: by 2002:a17:902:b208:: with SMTP id t8mr8996489plr.38.1576148506003;
        Thu, 12 Dec 2019 03:01:46 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id w11sm6682387pfn.4.2019.12.12.03.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:01:45 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 4/6] btrfs: split-brain case for scanned changed device without INCOMPAT_METADATA_UUID
Date:   Thu, 12 Dec 2019 19:01:30 +0800
Message-Id: <20191212110132.11063-5-Damenly_Su@gmx.com>
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

This patch adds the case for scanned not changing device without
INCOMPAT_METADATA_UUID.
For this situation, the origin code only handles the case
the devices already pulled into disk with INCOMPAT_METADATA_UUID set.
There is an another case that the successful changed devices synced
without INCOMPAT_METADATA_UUID. And the scanned device is the exactly
changed one.

So we should check if there is any changing fs_devices with
INCOMPAT_METADATA_UUID.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 fs/btrfs/volumes.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 61b4a107bb58..faf9cdd14f33 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -741,6 +741,35 @@ static struct btrfs_fs_devices *find_fsid_changing_metada_uuid(
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
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
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
 /*
  * Add new device to list of registered devices
  *
@@ -782,7 +811,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	} else if (has_metadata_uuid) {
 		fs_devices = find_fsid_changing_metada_uuid(disk_super);
 	} else {
-		fs_devices = find_fsid(disk_super->fsid, NULL);
+		fs_devices = find_fsid_changing(disk_super);
 	}
 
 	if (!fs_devices) {
-- 
2.21.0 (Apple Git-122.2)

