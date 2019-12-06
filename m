Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F51A115373
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfLFOqD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:03 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45368 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfLFOqC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:02 -0500
Received: by mail-qt1-f194.google.com with SMTP id p5so7308346qtq.12
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JLk4SYGy37fJBjRDw7Ytdl7Bh55Sf6BqQikAUfeWGHU=;
        b=SU6t2k/3Hwh2cSzSXNj5sChGiEZY6UnPnKR6cVXcgZBLiWDQkU+5JJSo+iUvPbzVTn
         VuZOdsAXrN+h3SxZcv7Ea1/v3ZhB2APqjhzbhZgY1IQyHEygPj736A8vLFMhVC6xcNZu
         8bzx+Lk78qW15UOf43HHYsWIMZLe2894cl0JubsYb/5YjXKMqaQjh6hUj2/sJW2kJM1S
         Hv1m3LH7AoWR2qoxDVMJCREToSzFy57N6wcKKgmFKDy7eqiuOg5/JyyCXIzl1/t9h4M3
         dUC3I6ROI+OypTQA9jj7iTMqTPkYi4wCZBxO/uX7M1ZuACHH/A2gdIB3f+o74KAohapd
         erRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLk4SYGy37fJBjRDw7Ytdl7Bh55Sf6BqQikAUfeWGHU=;
        b=O9jXEVBQeADHS3Tq6LtAh+9i9veFSb/R7qx3v7ksWA/Gthuij56L4cdU5bueDzcoe2
         niUFTjXtIw2x7yDS5RtGaTvkFIhl1xX3gzfmIo7Y+v5G7/HW3IoRIjzFAtFxqmg6GK2O
         zuy15sE5mTVPp7ytqwzWYDPzlI8rTTtfFAMqVG+j2pLJSZlkoAXbg99i5i+jKkyn6Axn
         BiLs9BXBc8a/bquG1O6HLXA7+j+MDV5skcdIUfrOX+wK2fABHmSKNY3YrhOPk+XB2QYu
         zuR4VKVTNaqeeaI3+88MfHG2/gL4rt8b+CKwLZ6R1avs9Yz//8lgpTmiPcC9qzqv+DAY
         YKgg==
X-Gm-Message-State: APjAAAVRXnZF03Eu8FtxeTCHaIp1HXGJEmo4ORx3HLVRgqOIC24cYNFU
        8aw+5iiLNxq8voQFboytXMNKqnuUIyDXkw==
X-Google-Smtp-Source: APXvYqxuGCfcgj6sQ/ColfmW6mSATnjlUBCBiPQtpUwS0QFzejYY7ChcFhLWXljva5Oop9zxGAjv7g==
X-Received: by 2002:aed:3e82:: with SMTP id n2mr13101024qtf.367.1575643561582;
        Fri, 06 Dec 2019 06:46:01 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j16sm6446356qta.59.2019.12.06.06.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/44] btrfs: hold a ref on the root in resolve_indirect_ref
Date:   Fri,  6 Dec 2019 09:45:05 -0500
Message-Id: <20191206144538.168112-12-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
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
2.23.0

