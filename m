Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9992911CBB6
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfLLLBt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:01:49 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40833 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfLLLBt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:01:49 -0500
Received: by mail-pj1-f67.google.com with SMTP id s35so884758pjb.7
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fOGXbamTK5rFzTs2n1dxg+HTJ06AVL9Ez7fnVK8dDno=;
        b=FLTlN9OMZlBCSw3B02KZ4SGfK2rWzHzOdmwYkSN8lZtFJdkLaYfHRSdNhJVZmaVxwp
         WvO6sr0oLRsaCByFn4Y5mPIk8hh+NXLA+LVR62AxP5S9YuPHo3n+Z4+9rwh1cxeWr/aE
         onA2X0HYIXOAN5ukV9PFR/xZiYuSTeO0BsSpfisHYbkKLqGA0RxRoFsQw/9AzrZ7e8PI
         uz9izCXykcqEeCD5hpeGKzmVjuJ1xSUY5y7r+/+5Kli7MCOTU0tSNam0QjJltDAa1lMt
         Am7RoRI3Oaboa41R4hi0Mz+tTzUsAShIZ7nvqjWCUnlO1N5axJ+MnY3eHv2oG7KPxRVh
         9KPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fOGXbamTK5rFzTs2n1dxg+HTJ06AVL9Ez7fnVK8dDno=;
        b=PXVzjb/8F5iu++TNYTrkWgQZB8HRX2ANcaYSpBHtRA3fIQSRgXqdk2eenVqvBWO3hO
         7+djWGxBH133AA392eN6vinVpkbUesgEVGSMjX6qd5zda4NorozDVQnzo5n7coCNjs6P
         kV0mDoGirnabySd9SFrx+jPGmoEbb5f0osWTnkqShPxG8RYSQ5V/fhUfxvwQEAsOYgs3
         b8zmMwehwnyvKAZCmT5+Kev78thxbABQOlpp++U7Gzaz7pQk/PIQC3rq6QDDrEf1Nm5F
         ERdSpobncZ5kb3IpPm/PJ3meRbWHoIESLtI1MH6LZzzIEQgwJASE69NsntUSvDdaGxln
         v9/g==
X-Gm-Message-State: APjAAAVWoqf+5Q1NbiT79VtxxrI02oWH3JjHmL2566vh/Q/Dej8TJnVx
        TJytPKgyq/6o7FmB8dRI7Ga14qTA1FM=
X-Google-Smtp-Source: APXvYqxZQiB0sQ+oMqifTtfqAnKfRhhlOPS5kbtM8uCZOG5UBEEZ5ehik6u767pEBo+Aoe4GN0fg7g==
X-Received: by 2002:a17:90a:30a4:: with SMTP id h33mr9154540pjb.50.1576148507895;
        Thu, 12 Dec 2019 03:01:47 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id w11sm6682387pfn.4.2019.12.12.03.01.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:01:47 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 5/6] btrfs: copy fsid and metadata_uuid for pulled disk without INCOMPAT_METADATA_UUID
Date:   Thu, 12 Dec 2019 19:01:31 +0800
Message-Id: <20191212110132.11063-6-Damenly_Su@gmx.com>
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

Since a scanned device may be the device pulled into disk without
metadata_uuid feature, there may already be changing devices there.
Here copy fsid and metadata_uuid for above case.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 fs/btrfs/volumes.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index faf9cdd14f33..b21ab45e76a0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -964,13 +964,16 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	 * metadata_uuid/fsid values of the fs_devices.
 	 */
 	if (*new_device_added && fs_devices_found &&
-	    has_metadata_uuid && fs_devices->fsid_change &&
+	    fs_devices->fsid_change &&
 	    found_transid > fs_devices->latest_generation) {
 		memcpy(fs_devices->fsid, disk_super->fsid,
 		       BTRFS_FSID_SIZE);
-		memcpy(fs_devices->metadata_uuid,
-		       disk_super->metadata_uuid, BTRFS_FSID_SIZE);
-
+		if (has_metadata_uuid)
+			memcpy(fs_devices->metadata_uuid,
+			       disk_super->metadata_uuid, BTRFS_FSID_SIZE);
+		else
+			memcpy(fs_devices->metadata_uuid,
+			       disk_super->fsid, BTRFS_FSID_SIZE);
 		fs_devices->fsid_change = false;
 	}
 
-- 
2.21.0 (Apple Git-122.2)

