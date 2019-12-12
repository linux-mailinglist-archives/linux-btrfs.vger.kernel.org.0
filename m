Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1982311CBBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfLLLCR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:02:17 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:46670 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfLLLCR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:02:17 -0500
Received: by mail-pj1-f65.google.com with SMTP id z21so873711pjq.13
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZkU7GiVRo1EbBkkcon+70ZfebtsOT9k8iNA7sNJh8c=;
        b=Ic8+0gbxOO8oKbJ7TM34N8OlJKykGZxiDxVCKvhubtncRU+AH6izNvXS1Yvq38avoc
         xe72TxsGIsClJ5G08aveejg3JNPJUK3vVvQBUnGz5oZVEiIJM3oO+513nu2KUiUffuoZ
         SSPWvBj+9/kvNzLtVB2Av7Hqr8bVx3h9oBGA758+yA4/RXArGjjreXV2FvB8aRL6n7Ye
         ei/Hd4klj8mU/em0Z++DEu/eWlR3gYrHG9IC/loAdxn9zGPdEHbPqtoa6BudCWTPKRDr
         LBPyhZWhuavpCdPIzbaoaEeUWSwteSsZZORAM6GIMOdlTtBzFYgXvo2JfyDF73c0Oj/s
         wcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZkU7GiVRo1EbBkkcon+70ZfebtsOT9k8iNA7sNJh8c=;
        b=piTTAlnPmAKkg1W0Vm81pgDBCMYoQY90SekDjccb4yF860U414mC7MQpKyLUvZT9vc
         TD7jy/NW9FenZkRMwEKjtI4VFWACnPfHpXQpOPufsOmGdb/6FkSdT9ZBXMf1aXqARNVq
         nOLqT4LPwDrWPle/w8tN6dJL/aUX6fPovIROUknNQ4sRUi4iMUy4HZSNJf0+x4Yc1guh
         LzrvKqoP1DsxxGxFH6ztHji1DLP5ZS8DS4Vf2mAt8K05fZ8ER3l6mY6MhfWAPX2NaCxe
         zlAqKw/55jYfBaW0DzKSGgNNOQstHW/GY05m8P96OJIfvFLLYyF3ILuHtHRMl/0Gb21z
         1NwA==
X-Gm-Message-State: APjAAAXAwolgP2jaSjRRPmNjKlCUkaCfUcp3+af5ixvU3oquAyzLxpWG
        u32weqgpp4CKVm9rqgLKZyG9BBT2rM8=
X-Google-Smtp-Source: APXvYqwrbTV23CSeBWJzfBcyEmgtpEAR6PD9vOYfCtyjXtxRxKN7QUWARIselUtNwJH9cK7M4hOENg==
X-Received: by 2002:a17:902:aa04:: with SMTP id be4mr8584673plb.311.1576148536356;
        Thu, 12 Dec 2019 03:02:16 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id e20sm6587857pff.96.2019.12.12.03.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:02:15 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 03/11] btrfs-progs: metadata_uuid: add new member btrfs_fs_devices::fsid_change
Date:   Thu, 12 Dec 2019 19:01:56 +0800
Message-Id: <20191212110204.11128-4-Damenly_Su@gmx.com>
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

Like what is done in kernel, we need extra information for split-brain
cases.
The new member btrfs_fs_devices::fsid_change records whether the
devices are with FSID_CHANGING_V2 flag.

The existing btrfs_fs_devices::last_transid can be used like the
last_generation field in kernel. It records the highest generation of
the fs_devices.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 volumes.c | 4 +++-
 volumes.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/volumes.c b/volumes.c
index 143164f02ac0..88e926e98d5b 100644
--- a/volumes.c
+++ b/volumes.c
@@ -214,7 +214,8 @@ static int device_list_add(const char *path,
 	u64 found_transid = btrfs_super_generation(disk_super);
 	bool metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
-
+	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
+					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
 	if (metadata_uuid)
 		fs_devices = find_fsid(disk_super->fsid,
 				       disk_super->metadata_uuid);
@@ -238,6 +239,7 @@ static int device_list_add(const char *path,
 		fs_devices->latest_devid = devid;
 		fs_devices->latest_trans = found_transid;
 		fs_devices->lowest_devid = (u64)-1;
+		fs_devices->fsid_change = fsid_change_in_progress;
 		device = NULL;
 	} else {
 		device = find_device(fs_devices, devid,
diff --git a/volumes.h b/volumes.h
index 41574f21dd23..1c734b515346 100644
--- a/volumes.h
+++ b/volumes.h
@@ -72,6 +72,7 @@ struct btrfs_device {
 struct btrfs_fs_devices {
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
 	u8 metadata_uuid[BTRFS_FSID_SIZE]; /* FS specific uuid */
+	bool fsid_change;
 
 	/* the device with this id has the most recent copy of the super */
 	u64 latest_devid;
-- 
2.21.0 (Apple Git-122.2)

