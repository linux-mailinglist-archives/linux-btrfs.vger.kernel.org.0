Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEF1140B6A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgAQNsV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:21 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42443 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgAQNsU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:20 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so21765952qtq.9
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IID+TNjtvNq2y6b27Gs67SLa1Kba2OW0SQsgqv4ynLA=;
        b=R/ppUSpyjsg3UB6LqFbUkfc+IUvKE3LxxSlh6vRswadKcVdqaEjsvOEjNN9daRTqev
         db3+OAhBj7PNI9bRQsLpxVX+69b9lEPwnE25Vc/VQgdun33FagwkAMV38ttqicNSRGhM
         x+EWaHn4iv9lQ70ynScbbW9F467OHha83Nq8FfxYvVnOPhBGnDHf0XeE/yABSkOtLcjU
         j1FP5aHwLW04lroQO4cjS+7CTiyzxxzgDX5L6OLylQmsb4pkgKHh1IUt4p4rGmbQaRQx
         dwIBVOLlRRQ7ESLXb7hvWuSGZtBDaLnCCUB3jvnuAfBWHhfKx35zIs+7jowItvy/AnfZ
         SMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IID+TNjtvNq2y6b27Gs67SLa1Kba2OW0SQsgqv4ynLA=;
        b=SJvVBejYHLEHVmgR7UQmKsepURHX2E95Ts0a8xN6LZYcjlxxeHpzlOYRANe8ePY12X
         dTFOlUX8WJq1xZuZ9Zky9MWVNJ5cu2NbY7CvrhCEYCmJz2/goN73pW6An0ELNgQUUQ+i
         hVeRfcIQg/mjibRuHS81uqobI6qjt4TCD0mMdY6yH8YaHiNTyNedU78N0/NMoOTkzZdo
         fuT2Cz2Gmd4MZS4RYfmTum86TFDjBQCX6Fzba44sbk49Wgkpq1GZlqiBSr+5m+/eD5xP
         hMZQQiEBE/2b4eFM+gXeimmhaf26oIigUnYDnmvJStDOsu7m+jbVP6WyDxzU50xjgou/
         Jh9g==
X-Gm-Message-State: APjAAAXjHWC9Tz4dZ0H3TINBD44wR8NpT0F4jNltirCC/D6nEHa8bILs
        AjN2r76Spje6z+KraY3uAkoKravkKrWnNg==
X-Google-Smtp-Source: APXvYqz1sm+2Hi1di5OYh1y+vH6nYXIKmlUHaK1H6TI55i0bE4iVN4UYcW66kceyaoMWXkhapdfZwg==
X-Received: by 2002:ac8:544f:: with SMTP id d15mr7672560qtq.53.1579268899642;
        Fri, 17 Jan 2020 05:48:19 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id m8sm13318001qtk.60.2020.01.17.05.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/43] btrfs: hold a ref on the root in resolve_indirect_ref
Date:   Fri, 17 Jan 2020 08:47:26 -0500
Message-Id: <20200117134758.41494-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're looking up a random root, we need to hold a ref on it while we're
using it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e5d85311d5d5..193747b6e1f9 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -524,7 +524,13 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 	if (IS_ERR(root)) {
 		srcu_read_unlock(&fs_info->subvol_srcu, index);
 		ret = PTR_ERR(root);
-		goto out;
+		goto out_free;
+	}
+
+	if (!btrfs_grab_fs_root(root)) {
+		srcu_read_unlock(&fs_info->subvol_srcu, index);
+		ret = -ENOENT;
+		goto out_free;
 	}
 
 	if (btrfs_is_testing(fs_info)) {
@@ -577,6 +583,8 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 	ret = add_all_parents(root, path, parents, ref, level, time_seq,
 			      extent_item_pos, total_refs, ignore_offset);
 out:
+	btrfs_put_fs_root(root);
+out_free:
 	path->lowest_level = 0;
 	btrfs_release_path(path);
 	return ret;
-- 
2.24.1

