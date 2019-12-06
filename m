Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB50A115376
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfLFOqI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:08 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46248 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfLFOqH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:07 -0500
Received: by mail-qt1-f193.google.com with SMTP id 38so7296849qtb.13
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CrGSROngNYHMrJo4yO4MKSjdAhSy80c70V3zqgJu568=;
        b=LQHPIyGnCujdsDV0b8Wctq5bd3lu/XAvr6t1hKzrtEEn+yQPiG/PwuWMXbz5+TOS8z
         EA2K1lmv9VFO4MNMzIr0+kmAuSgEKjcGei/zVJ1fcASkjRHA3OTeb0EnEedGzRRFYGIC
         EJBWmkBkkvSvL8IiFBBaLXj0SJBfokiCoGp02F9RBXg4GXOTShbtGfXhzZiosAMROmGw
         wc3eUQ67byxINRkS9FyP4YbfdNKtR5T7/WaeqHGeMkd2L4GQUzJAoFB4nB+a/x/CQd8A
         VbmiLygH4og4uyWMvoW0pTYXuwko+lwLlCAUnvPkOedGd20KSIThEAeUBg9I6glErpRZ
         J26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CrGSROngNYHMrJo4yO4MKSjdAhSy80c70V3zqgJu568=;
        b=GRByjodHZxDnxKlUYkrXIQoNaKzwOx9xMflgO6oXOk7eC4emAR+TiQABsKArnesu8H
         zbsnU3ZOvDXg8B4lD8Jn4reCqEgCC1SpjVBy+Ss0s+gvST4cymxZQlCJYZuOU2lteEIw
         eSGBvCzQ+3hHgKlUzphV2gkut51tgjEdaOoYKOIH/gKaZHMsI79cRTFANVVlySVyYgP2
         wT2/EkQWoi0oNW2kcEDDKiqKX+oD982zh4RaLl6iuHiBMS4veGt16b4ObS1kTY4JtQO6
         bUiq3x4gXbHMQ/LuFKOI4HB6PAPOF04EDwN3bGWkSsUV1+teR+VjyGEvuQ/yW+VJkuj+
         iAzg==
X-Gm-Message-State: APjAAAVk8OOgG/sFJSAa23V56/ILSW3DGA/yAzpYN1Cnykf0uTSMgvXC
        XN3UQW1okT/t3+BW8YhL4jtpSxnrOcdxBw==
X-Google-Smtp-Source: APXvYqyX5GvM+PiscEehyTDpPle2Q6mrPargaBYZ5S7RJP1yL99kPOmuXIulBfxv2x7y2OXLHFR2pg==
X-Received: by 2002:ac8:2310:: with SMTP id a16mr12815095qta.46.1575643566454;
        Fri, 06 Dec 2019 06:46:06 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y10sm5801939qky.6.2019.12.06.06.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 14/44] btrfs: hold a ref for the root in record_one_backref
Date:   Fri,  6 Dec 2019 09:45:08 -0500
Message-Id: <20191206144538.168112-15-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're looking up in an arbitrary root, we need to hold a ref on that
root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 138c21f5ed12..88f3d6eace7a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2523,6 +2523,8 @@ static noinline int record_one_backref(u64 inum, u64 offset, u64 root_id,
 			 inum, offset, root_id);
 		return PTR_ERR(root);
 	}
+	if (!btrfs_grab_fs_root(root))
+		return 0;
 
 	key.objectid = inum;
 	key.type = BTRFS_EXTENT_DATA_KEY;
@@ -2532,8 +2534,10 @@ static noinline int record_one_backref(u64 inum, u64 offset, u64 root_id,
 		key.offset = offset;
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (WARN_ON(ret < 0))
+	if (WARN_ON(ret < 0)) {
+		btrfs_put_fs_root(root);
 		return ret;
+	}
 	ret = 0;
 
 	while (1) {
@@ -2603,6 +2607,7 @@ static noinline int record_one_backref(u64 inum, u64 offset, u64 root_id,
 	backref_insert(&new->root, backref);
 	old->count++;
 out:
+	btrfs_put_fs_root(root);
 	btrfs_release_path(path);
 	WARN_ON(ret);
 	return ret;
-- 
2.23.0

