Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 426FC17632D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 19:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgCBSsL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 13:48:11 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42245 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbgCBSsK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 13:48:10 -0500
Received: by mail-qk1-f193.google.com with SMTP id o28so697094qkj.9
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2020 10:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yX213tUFP4N4D5kppstnK+ikKNenknoYE/JJXg8MV8c=;
        b=WzTdYA3x7C9b2u7kcomcM/cbqgC0Zrm6lQQzLhkWXzkDEUEOiBJUYM0KV+v9vW6CQ2
         I27xZXIHF38cSIoBbVfaXj3BkdD1PfJQvXq2AKgAHWbpWVcCWrHUhnCVa/hNWlX06REX
         zLaML4ceiNbqxaaaZpDWwvxFuBsvI3wJTp1tzFi5qynN0qfnLcXQcWEJHEhbKrgoqy2L
         tWD7xqPppP7Jf/O0DkUpCMZ8tLY7Jnmn4pnNwI1ULv1gznbpRXtRpYUGwTZdc6gYFWsv
         C6cnmpGjSedgsWMtF0w053okoehXJZ6Gclw7HYQpCSNiXanHPph+z1YI0UcW92fO8tlz
         f9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yX213tUFP4N4D5kppstnK+ikKNenknoYE/JJXg8MV8c=;
        b=XaHff80f4LODJTcNFi1rWBBT9vTv1W7wTgRTOiIOyvE4SZ27lJ4nEiMpy1B/oVU7OV
         VvaYuv7nJS/iKfZ77NvdVajNs06BIKAZgJcW3XzIzYlj+Piov1moRfs4dbtIIdFElmTk
         scU/06ed8pWo5BuqjDPJXHQn8yppVbCgVy1jrrevLFFDyf0K3zWVj0TCU2ouG3F1cLUH
         Mz97yvjuBP8+tBWMN9jhTB802EgZYsJTRcIfD7aOlNoVi/Afbs5mTJFag34lvJnmkTTk
         1sfMcxGMXbWDJKG+S8XEtmCQ3zNhj1XsbNGqilMwZNFD+HI1nVj1arnQ3fRf8Z68pxem
         Jmqw==
X-Gm-Message-State: ANhLgQ1L0g/pjgpSaKFF2Y05O5HS9ELVliByN0Zesu/y4ESQLibHYwot
        XydofFg9uLYmUSnPEiakc3jErHewpbA=
X-Google-Smtp-Source: ADFU+vvPwb879cn3XUeHsUogcyBAHEIuTvydlSm0NlXCGFwfwDHQQOgRDpN2h0jzpY52yC+3sD+JmA==
X-Received: by 2002:a37:5d45:: with SMTP id r66mr559494qkb.499.1583174888689;
        Mon, 02 Mar 2020 10:48:08 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 145sm10641996qkh.10.2020.03.02.10.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 10:48:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs: clear BTRFS_ROOT_DEAD_RELOC_TREE before dropping the reloc root
Date:   Mon,  2 Mar 2020 13:47:55 -0500
Message-Id: <20200302184757.44176-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200302184757.44176-1-josef@toxicpanda.com>
References: <20200302184757.44176-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We were doing the clear dance for the reloc root after doing the drop of
the reloc root, which means we have a giant window where we could miss
having BTRFS_ROOT_DEAD_RELOC_TREE unset and the reloc_root == NULL.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e60450c44406..acd21c156378 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2291,18 +2291,19 @@ static int clean_dirty_subvols(struct reloc_control *rc)
 
 			list_del_init(&root->reloc_dirty_list);
 			root->reloc_root = NULL;
-			if (reloc_root) {
-
-				ret2 = btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
-				if (ret2 < 0 && !ret)
-					ret = ret2;
-			}
 			/*
 			 * Need barrier to ensure clear_bit() only happens after
 			 * root->reloc_root = NULL. Pairs with have_reloc_root.
 			 */
 			smp_wmb();
 			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
+
+			if (reloc_root) {
+
+				ret2 = btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
+				if (ret2 < 0 && !ret)
+					ret = ret2;
+			}
 			btrfs_put_root(root);
 		} else {
 			/* Orphan reloc tree, just clean it up */
-- 
2.24.1

