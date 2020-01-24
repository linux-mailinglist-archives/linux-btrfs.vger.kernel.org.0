Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B579014892F
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404262AbgAXOdZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:25 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33218 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404167AbgAXOdX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:23 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so1658394qto.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IID+TNjtvNq2y6b27Gs67SLa1Kba2OW0SQsgqv4ynLA=;
        b=UzyqMpNDoIgy1ts3z7PdYPmElxsl8FtHJXG/WkbOGFvjCVRhzcip43aEkLB4CvD/OY
         lwU57MX1rbjRnkcB0APUGm+IAQ6P+INIlPmdltuMyuEodfjR1D+DPYWG1EMqmvjwmPf8
         D7C7Te3ZK/wqj6sNA2LJ7erTmrRIc5sGiP179E4REd5de/jylT7xy57CPWsShqTZTolP
         vo9KZX6O3I7Xvu0CNNUWawApCZaf+kzyjp3jfMkLz6fRIQBKTFiyjSS+ATAv6kRNdK/g
         dumHnmW777siDiKpWQSCAdU45iDtXZuFN8m92ckqd7bDk0wgT2hoOyPnhKP5CxR3ga7M
         0osQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IID+TNjtvNq2y6b27Gs67SLa1Kba2OW0SQsgqv4ynLA=;
        b=OkIqUEsFHuSLWyLAE9CpQGMZA4Ow4Zqv/OoRiHu2UQpVKIwxpWza8blYgtBSNgSMeZ
         6WpwKfIZrurJfPBeDQeY4c8O13z0i4d9LWqMWTOAL5SMiN/qcWphHQh1iYh7/cA79B4v
         ckqZndbMFaFXObKiRHGs4YUaaeSmlhg1xCJ75wMvpjrr013P6ll4hqczh8RLMD2Kjrmd
         zdzSjBR4cDs80eBQYFVSsGZi/ppvW5p/GjZH7hFAWMSOuCsR5niTTh9IStTxQRmfY96g
         WXl9Yy5DIdwx6EOOxhI9MTCOG3sziI2kWwA7GMLEZ2RgQawYp+w5Cv23KqvRmkPdc9F5
         cyCw==
X-Gm-Message-State: APjAAAUXD8Pc5iVikJCmVhbG8F5XeFk588XhO7mxjTj0yhH5NHrhvmIp
        8GlZzk1WXCaNyMaZ6Smd0xICiA==
X-Google-Smtp-Source: APXvYqxbULP4DsRIJbT00hG0EriNKK4SsHfTaCH1dMdeIFEfdHO74RmpiybTpx5kWyTVmgNQqiAOkQ==
X-Received: by 2002:ac8:43d0:: with SMTP id w16mr2452613qtn.43.1579876402077;
        Fri, 24 Jan 2020 06:33:22 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g18sm3135005qki.13.2020.01.24.06.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 11/44] btrfs: hold a ref on the root in resolve_indirect_ref
Date:   Fri, 24 Jan 2020 09:32:28 -0500
Message-Id: <20200124143301.2186319-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
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

