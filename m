Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 719B111CBC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfLLLCa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:02:30 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42356 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfLLLC3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:02:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so570328pfz.9
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5q+lLSympSS8Qq1ZgfsoRfjAA0HVFX/einZgRwXV9fU=;
        b=bGU/A+ua/XbUqV1Rm+Zfbrl9kyBOK5bVhJp7LRGNZmRHT9zTJvdGVswp2vQ8h9XhGB
         VEN6hWOdr2agdO57TBEwBu+FnVMOt8SbcgFe73roQg5zpqlMROv9Mayf1BUcvFEEXhye
         WTox1aTEUpvCTfnXhdvqvLD2I/uxgr8t6Z4JyAams6aQ7Bc90zoIqMpuvk+Gc8ikRBnT
         xLNeHRMEHmVM5MbSJGuP5gFsaW2ByRWhB4uAk8eXbdiHHFbc0GnHjLS7bmSD6dmjbFyr
         LgNhoXFmS/jAs+VYp1GHJvFutJCDJU9KJ2bbSDoOpOKfof1QCYRMWx8AQKJpS5Vq9RLx
         n35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5q+lLSympSS8Qq1ZgfsoRfjAA0HVFX/einZgRwXV9fU=;
        b=DMU4zfhwdF+hfy2BWzLgX02ZdvDO5d6HWc2AkuSPbctqP51bAHuHY/1uZMZdO1CQLb
         OwY+34YcH2Nx0/UuN5Zi37IHWm5aF1FP2+Ln3N6hfmwNAn6fBcvu0g1lTlCLL4Jh3JQ1
         Nf7bQbc/wZhpqtIqT9RNJV9bRgj61kqj27awFjykbCIlwY/x222rRp1iIYIDw7JmD4Ru
         BIKlZA1CyDTsQPixb+sHkt30rKuPgF0GpOyyGTwEkmR4l3JLViPagijtQ8Lr3r0hbC2A
         9WIzkN9PG/PmvZQIZVl2zhrcEjwy4hX9NpLIqKCnjMW9KIBySIbzrgpVfjqAdv2yYkLI
         08RA==
X-Gm-Message-State: APjAAAUp2DNamJjK1ukN+gxZg+cgTevgrAP5xzwt7noMQFdV5+qEeL4Q
        FbmNJCpAIhvWSsZ83dlJKJ30oiIBglc=
X-Google-Smtp-Source: APXvYqyY3K5PBx0bZdFJkOm4YsG+Ac1W1zOI5Q8bODEjaxzePnKv26mvbsKDallMdt8ByoFglnrlVw==
X-Received: by 2002:a63:a4b:: with SMTP id z11mr9345709pgk.97.1576148548741;
        Thu, 12 Dec 2019 03:02:28 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id e20sm6587857pff.96.2019.12.12.03.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:02:28 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 09/11] btrfs-progs: metadata_uuid: rewrite fs_devices fsid and metadata_uuid if it's changing
Date:   Thu, 12 Dec 2019 19:02:02 +0800
Message-Id: <20191212110204.11128-10-Damenly_Su@gmx.com>
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

As what kernel does, changing fs_devices's fsid and metadata uuid
should be changed to the successful changed device's.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 volumes.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/volumes.c b/volumes.c
index 9d76f9a102b2..6decc699ba2c 100644
--- a/volumes.c
+++ b/volumes.c
@@ -359,6 +359,8 @@ static int device_list_add(const char *path,
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
 	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
 					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
+	bool new_device_added = false;
+	bool fs_devices_found = false;
 
 	if (fsid_change_in_progress) {
 		if (!metadata_uuid)
@@ -391,9 +393,11 @@ static int device_list_add(const char *path,
 		fs_devices->fsid_change = fsid_change_in_progress;
 		device = NULL;
 	} else {
+		fs_devices_found = true;
 		device = find_device(fs_devices, devid,
 				       disk_super->dev_item.uuid);
 	}
+
 	if (!device) {
 		device = kzalloc(sizeof(*device), GFP_NOFS);
 		if (!device) {
@@ -424,6 +428,7 @@ static int device_list_add(const char *path,
 			btrfs_stack_device_bytes_used(&disk_super->dev_item);
 		list_add(&device->dev_list, &fs_devices->devices);
 		device->fs_devices = fs_devices;
+		new_device_added = true;
 	} else if (!device->name || strcmp(device->name, path)) {
 		char *name;
 
@@ -446,6 +451,23 @@ static int device_list_add(const char *path,
                 device->name = name;
         }
 
+	/*
+	 * If this disk has been pulled into an fs devices created by
+	 * a device which had the CHANGING_FSID_V2 flag then replace the
+	 * metadata_uuid/fsid values of the fs_devices.
+	 */
+	if (new_device_added && fs_devices_found && fs_devices->fsid_change &&
+	    found_transid > fs_devices->latest_trans) {
+		memcpy(fs_devices->fsid, disk_super->fsid,
+		       BTRFS_FSID_SIZE);
+		if (metadata_uuid)
+			memcpy(fs_devices->metadata_uuid,
+			       disk_super->metadata_uuid, BTRFS_FSID_SIZE);
+		else
+			memcpy(fs_devices->metadata_uuid,
+			       disk_super->fsid, BTRFS_FSID_SIZE);
+		fs_devices->fsid_change = false;
+	}
 
 	if (found_transid > fs_devices->latest_trans) {
 		fs_devices->latest_devid = devid;
-- 
2.21.0 (Apple Git-122.2)

