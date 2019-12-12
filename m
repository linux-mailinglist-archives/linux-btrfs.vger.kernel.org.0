Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB1A511CBC4
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfLLLCc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:02:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37523 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfLLLCb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:02:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so579371pfn.4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FCzqjF7wPpLXtJSukHdDkjlpAl6qG8iexlnaXNo3H+w=;
        b=WZ467oJgc2Q5olAcOnYkVvLyO70W4/gQesTa+pY6xMgpXgooXT5+0WZ4Avdx+C9DKE
         +0SV+NZIo9k4Zq4I+BrktBog9MTsp1jCE8VcMlhLHDdV/F1Ph55Bj5vKjCGlM9a/kaky
         BL3TFEvhbvG59Li0lXIYnfV8wJ2b22nQdTRMcgklToiOTKb3+w42sZZdOmOGwxfFpd5M
         yfWhBgGfX72Vj407Mz1nXdUlcIJNeHbfr3fTFoWge87l2KT/o8Gliw/03YdzFr+6RVxV
         i8rTq3PgkrR5Dq2JLBIUS8ZBmvCSlzrbHBMwHNJDbjAssCK3f/13i2aEcMcCnOystNtO
         2n1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FCzqjF7wPpLXtJSukHdDkjlpAl6qG8iexlnaXNo3H+w=;
        b=nDX0sF+JkSxATmo+/A7CwlbpLWtAokst5+jWA5ZuM+oDQCN76sDREzuAZ7EyDjtCRY
         3dx4pOVSAB14NnehYJe3nzBHtZyH9hBIwocaLsp2Azc1flOq3wNZu3T+qjy0RaQQTWnP
         isv56I8k2+AvkSlfd13zik87o0kCjJ0R/firr0zpcizugA3UorrKp6kVyiyUn9I5k6sf
         L+sHrkTXaU9FajGIOEIo5WoG1lw7Vdm0KGz+yuBxOhqe38mk/Ak16DtsXxVmAsW3piaf
         ZFt060X1aUcC5eowiLYp2QoeA088tEBFNqwSN0MhGXyLqJR8PbrduRR73fyO/9pYqIOI
         SZZw==
X-Gm-Message-State: APjAAAUre8FAW+ZpEfekdpOSYw7W4doAMsPdLfZxvjCRfIFTqk68sYwv
        UpXFitZgj69kdH13QHnyYuB7TzZRoSY=
X-Google-Smtp-Source: APXvYqzVaNTbPfkQBCSUpX5zVZjJhJQAnzS4XygWmYluMJqzFr5quRhm3PiI3QasFV6RgW3IioJGxw==
X-Received: by 2002:a63:d642:: with SMTP id d2mr9427863pgj.205.1576148550535;
        Thu, 12 Dec 2019 03:02:30 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id e20sm6587857pff.96.2019.12.12.03.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:02:30 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 10/11] btrfs-progs: metadata_uuid: clear FSID_CHANGING_V2 while open_ctree()
Date:   Thu, 12 Dec 2019 19:02:03 +0800
Message-Id: <20191212110204.11128-11-Damenly_Su@gmx.com>
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

Progs now is able to handle the metadata_uuid feature without kernel
help, clear the FSID_CHANGING_V2 flag if latest device is marked as
changing.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 disk-io.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/disk-io.c b/disk-io.c
index 659f8b93a7ca..09dacbc83e06 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -1177,6 +1177,7 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, const char *path,
 	int ret;
 	int oflags;
 	unsigned sbflags = SBREAD_DEFAULT;
+	u64 sflags; /* records btrfs_super_flags */
 
 	if (sb_bytenr == 0)
 		sb_bytenr = BTRFS_SUPER_INFO_OFFSET;
@@ -1242,12 +1243,19 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, const char *path,
 		goto out_devices;
 	}
 
-	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_CHANGING_FSID &&
+	sflags = btrfs_super_flags(disk_super);
+	if (sflags & BTRFS_SUPER_FLAG_CHANGING_FSID &&
 	    !fs_info->ignore_fsid_mismatch) {
 		fprintf(stderr, "ERROR: Filesystem UUID change in progress\n");
 		goto out_devices;
 	}
 
+	if (sflags & BTRFS_SUPER_FLAG_CHANGING_FSID_V2) {
+		sflags &= ~BTRFS_SUPER_FLAG_CHANGING_FSID_V2;
+		btrfs_set_super_flags(disk_super, sflags);
+		printf("Found metadata UUID change in progress flag, clearing\n");
+	}
+
 	ASSERT(!memcmp(disk_super->fsid, fs_devices->fsid, BTRFS_FSID_SIZE));
 	ASSERT(!memcmp(disk_super->fsid, fs_devices->fsid, BTRFS_FSID_SIZE));
 	if (btrfs_fs_incompat(fs_info, METADATA_UUID))
-- 
2.21.0 (Apple Git-122.2)

