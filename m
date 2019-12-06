Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1A6E115347
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfLFOh3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:37:29 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46312 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfLFOh2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:37:28 -0500
Received: by mail-qt1-f196.google.com with SMTP id 38so7271597qtb.13
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+4734BTgvOemryDNeGVwvVsStlsreybYIWJyzs2ZW0o=;
        b=UJV1FEW55/rlcVG5vUyKDRgYMMJUnli0niUVYAogIykbnyFn1r6LzyVdmqBf//kpms
         hX8xfSrFMHEwE+O5/FwhK6Wd3DuUYUMceGV5KFlqsTLCsp7SMDLDzavJuuYdXPsp99gP
         n1ZI4IcDFbROFIwDdA8G7P30BjE5uXVEoJQMHGrSmU2D0fbyaXXUL5O7i9ap0SaHqzSU
         MErigHTXTThu9PUEO4OhqEmxl5w8C1+5+upLUYy0tV+VyfkQj/oiHouMyYV1YM5vjVYs
         W9KgNpgX3VWqHQ1VGSjEQyjMp6pa45gj4+wQNuORn8Y8M/oEyzCRc6DQGOoqDcVgDClT
         3HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4734BTgvOemryDNeGVwvVsStlsreybYIWJyzs2ZW0o=;
        b=skvtZvmFSUEm77Xc9olGkwSQr6E0AqQVbk6FkqMtBXpmla3o3Pu33E6MzUbwC1ur7X
         Z4Ky2ZThIkfUcCtMhGyzxNwVquIZqsj+2SyjzKfzkNy9UsNIq/Zf3ys+gdUTY2yuMdrV
         9hvlOtqGxgfu+dzKpXxA0gy3as3D97K0xX8TrAxY0zzL1oXCe4xzFqS4A6wsZnjuKnvm
         h6W1hsjA0+274c4o+DAmj6ZeRQGjURwmZzeqNwWPY3N9BcYtjT9Nexwlk+grDffLAo3P
         i5sGumFMhKYFRryHjVZeyKOczVx+KWKQw9rhT1P0HrzsEB+XuikCtAg8CECzzKy5iEIf
         Gc0g==
X-Gm-Message-State: APjAAAXx/e34j5ebtCBMaU3ohdlDXzcaC//USaeZLrmoBW1/HB5i/7X5
        xkXzu6B3n6rYbFv57k3ZEx+dWht5Sc0tpw==
X-Google-Smtp-Source: APXvYqzpjO/UrXHETuV5+r3qkHV8g4IxYONcIO84XH/vgfYH5WwCagDJ+dO++goZ3i922CgrVZlZfg==
X-Received: by 2002:ac8:195d:: with SMTP id g29mr13032337qtk.65.1575643047255;
        Fri, 06 Dec 2019 06:37:27 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e13sm6250345qtr.80.2019.12.06.06.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:37:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/5] btrfs: handle ENOENT in btrfs_uuid_tree_iterate
Date:   Fri,  6 Dec 2019 09:37:16 -0500
Message-Id: <20191206143718.167998-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206143718.167998-1-josef@toxicpanda.com>
References: <20191206143718.167998-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we get an -ENOENT back from btrfs_uuid_iter_rem when iterating the
uuid tree we'll just continue and do btrfs_next_item().  However we've
done a btrfs_release_path() at this point and no longer have a valid
path.  So increment the key and go back and do a normal search.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/uuid-tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 91caab63bdf5..8871e0bb3b69 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -324,6 +324,8 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info,
 				}
 				if (ret < 0 && ret != -ENOENT)
 					goto out;
+				key.objectid++;
+				goto again_search_slot;
 			}
 			item_size -= sizeof(subid_le);
 			offset += sizeof(subid_le);
-- 
2.23.0

