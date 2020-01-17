Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35E26140B70
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAQNsb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:31 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39609 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgAQNsb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:31 -0500
Received: by mail-qk1-f194.google.com with SMTP id c16so22692114qko.6
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kvs2zgeWGFIOEWBcae13gISN2NDUfogrB0w8hZ982w4=;
        b=TO4gihvwUeiP5qJhw7ghkERY0q6u6k5Czm34/rIoaGAm5/UcDYufDp+XI6AbUmmdDV
         474EdSK96zcFC5IX5IZSRpFCG35Wb13zFVIdhvaP5EgO+VS0e8V/T4spcavTQjfSe0zz
         CKqhcTTJvbILjpbMtm3+a6+U03MSGGZSpmWumEtM4+k5Ri6rfnoEsaKqqKeMGOH/t8EZ
         1pUY+jVeiQ7S6HYJI+sirCtEDhkkX+BsmffF2uu9DWAboBqRdj7iTp7qnCEQ4z0Gvwwi
         lhhX50eDHPiAOvMPM6ke5CS+4FxGxl96waV5yabmi4kSPJkPHJBgUOoT8xI9BTL+LYvX
         gxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kvs2zgeWGFIOEWBcae13gISN2NDUfogrB0w8hZ982w4=;
        b=X89qDTNPWeGPdxM/i/2ltKUd8WZbauq10nDuVvLvB3KBobA3N2+f1ABMXfnnBezERF
         Ehau/KqCFjcD6tOUY5stMl/gL5VJ4f4JDpjaAEVZOPkCQLaUC5tkeWrMLpE0P1B89HqF
         8crIqOA6nDbp63DcRbbdfAocrm9c42XIwvqqDyLSzOPmkWK7g3ZqsTsqpkBVXCKJeUe0
         TR7pEzqoSG5Y8FY1JyWfxfpjkA184uupRQkH+9ar3S5GIobaAviE4xqKXBhh2eljOtnp
         9nvtyqHksjCiuT1t/zGMfznq2YcgA0TYdZz/DVw0UzkihfYMt1WLSAqxNpQudOdEVoow
         OBfQ==
X-Gm-Message-State: APjAAAWnnnnAlJKWVRGXw2iIiTIDe3mUIuEowCvmEDozJgyRSSXZvQF7
        kuC+a3+2EWmJlDThhs29T4A2GIGOOngQQQ==
X-Google-Smtp-Source: APXvYqw9P30NL4W/dCraD1JYd4U+9vo9pIgftM+CsR/pEwN52YKUnlYpYdYpujNlCw5yNwoZ/fRt2g==
X-Received: by 2002:a37:8e03:: with SMTP id q3mr33282550qkd.395.1579268909615;
        Fri, 17 Jan 2020 05:48:29 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x8sm11721136qki.60.2020.01.17.05.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/43] btrfs: hold a ref on the root in btrfs_search_path_in_tree
Date:   Fri, 17 Jan 2020 08:47:32 -0500
Message-Id: <20200117134758.41494-18-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up an arbitrary fs root, we need to hold a ref on it while we're
doing our search.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 62dd06b65686..c721b4fce1c0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2328,6 +2328,12 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 	root = btrfs_get_fs_root(info, &key, true);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
+		root = NULL;
+		goto out;
+	}
+	if (!btrfs_grab_fs_root(root)) {
+		ret = -ENOENT;
+		root = NULL;
 		goto out;
 	}
 
@@ -2378,6 +2384,8 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 	name[total_len] = '\0';
 	ret = 0;
 out:
+	if (root)
+		btrfs_put_fs_root(root);
 	btrfs_free_path(path);
 	return ret;
 }
-- 
2.24.1

