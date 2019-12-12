Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02CD111CBC2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfLLLC2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:02:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42464 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfLLLC1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:02:27 -0500
Received: by mail-pg1-f195.google.com with SMTP id s64so965846pgb.9
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bE0+OeuKSDTmUIEJuVVKKRAOFsbafmVqNIWRa4Y/oaU=;
        b=tj2ANHhCanbjAXJ1n7d5/iWHpMo7sVvh9k35rYuSj5Xao9m2D79EkC1axLsMgxI1zL
         kDL9qMYWQB/e9Ti+GJ26f3DYf7L1JHTxFqu6gdNmjWVFZ+WBgi3DXnRN2KS6dKQnorp0
         Skr0GObPyf/nktRGZRiPMPqbuFEcVEnPPdR1byLv8dI4yK32kumLT8cZjgbkTZdQzQP5
         0FOfX5UH2tceqEO37ZFJs1kFpKJVTxL5RUjVpH3Aj/nnKYXBVZVzITI2t51WqjHu9fEJ
         wTFyPbU7ulTFkGPNRsrqEC+kd3jKs854BZaxE/vLTGNMBHmFotHSAririkPoyEZhJfpy
         DsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bE0+OeuKSDTmUIEJuVVKKRAOFsbafmVqNIWRa4Y/oaU=;
        b=hVp8/spwYHc5yFaiJCnrsBrRBXPWxipQzf98CBBCXdbpYusDlc/ZMS0dfdfEbPOjQS
         v0KxNL2baRabjNfckUu3pcocjy3wkHWqwsamV2gEln2s/S+lK2qjeqk/RRK6PmiYmlb3
         Y4FlDgXUpM3uiOyQFO1vh3++ABS9lw22wNYrwHt1zZxQxVMN3q+oAChYdR22ItKLbMD6
         +RXvNlzKGOBVmZW24thfnwo0pdi7LuZZzuwTDik3xmaAOl+//sMJOD2FCvDtr8QSiJIj
         0fXS8gQYhq+Fz1tEGRTk2AF66xpX5qVVOrFS+5ngDj4Gs70ycw9rzOiDTcKfz9SzfIOz
         O+OQ==
X-Gm-Message-State: APjAAAUzu3YJ0MbYaWzWcBwsvWO7mbgS1juAHPUZiqXewXuslC0Uq0CK
        DU3uVX2SqyTfp/p2Gr1zcsPDkM1Ly/0=
X-Google-Smtp-Source: APXvYqz8kpJeZIYt3fGE23x0E0+u/4UkEw7bxM817owWNQmX6xl2cL5CYAHFjjlcLqnhEn908lXRGQ==
X-Received: by 2002:a65:640e:: with SMTP id a14mr8974355pgv.402.1576148546580;
        Thu, 12 Dec 2019 03:02:26 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id e20sm6587857pff.96.2019.12.12.03.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:02:26 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 08/11] btrfs-progs: metadata_uuid: remove old logic to find fs_devices
Date:   Thu, 12 Dec 2019 19:02:01 +0800
Message-Id: <20191212110204.11128-9-Damenly_Su@gmx.com>
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

Now, the new code for finding fs_devices should work, remove
those old logic.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 volumes.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/volumes.c b/volumes.c
index 94940dd82d0f..9d76f9a102b2 100644
--- a/volumes.c
+++ b/volumes.c
@@ -371,12 +371,6 @@ static int device_list_add(const char *path,
 		fs_devices = find_fsid_changing(disk_super);
 	}
 
-	if (metadata_uuid && !fs_devices)
-		fs_devices = find_fsid(disk_super->fsid,
-				       disk_super->metadata_uuid);
-	else
-		fs_devices = find_fsid(disk_super->fsid, NULL);
-
 	if (!fs_devices) {
 		fs_devices = kzalloc(sizeof(*fs_devices), GFP_NOFS);
 		if (!fs_devices)
-- 
2.21.0 (Apple Git-122.2)

