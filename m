Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC0125695
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 23:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLRWUi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 17:20:38 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:32974 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRWUh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 17:20:37 -0500
Received: by mail-qv1-f68.google.com with SMTP id z3so1432396qvn.0
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 14:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=npYbZs/0MvOLk8eHQpDIgHq2hArzrfYft5Zmgh+wzjk=;
        b=cjf9iuybksC+27NqgZwlI7tvCXWRQle5w4LR6B/di+Q+CMZmvtccl/vVYzkOPG0iIF
         wQIOs0T3rmom0kJ0H1mMFLzl1U8iekNV8GMYc8DUwi+7zleYZMeBQkCWyz5XiRw/xDQq
         44nCcTwhWMVzW+SBpm0YVLgU06SBn9lRkZApuen9rHzxEHhTz0GiqxJIOfbqT+Qbd+y7
         DU3vvIpiBIm3SKR62LxNaZDcZV3e85ngtXFCMHVt+J+YpfLrCeq37Hr5Na1wMvFhc96c
         xO0uxXJTWUrSTs96E3JODm6zgUKapdFWpys63FtOcaKNKTviL7Y2trPdLRo9JkskuD0u
         dQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=npYbZs/0MvOLk8eHQpDIgHq2hArzrfYft5Zmgh+wzjk=;
        b=QniHQ14588ap7jT4hlRtdhjV/0nfxH9DXSQHV/oEfkgKBNQ6+3bmD4RdyBFL0lW2eJ
         l8M6GI1DlbGKo4a8UJgFrm+v/OAq0exJdkmweKog93UXTIPDpHoWk6Hn6znqtxlEY/KF
         5reVRO0AZsZOUP2z3pcIyQUHyaxVR7dYAL1dwflzbgKHN2gOIdurllBo6I/eUupy1G9r
         7ivIPsiP/+ybxTh4Y21gor7qLhnXuLMs0F5ACVGw/wiG3y8N3A6Q9LhK5I7P1bZI/QzM
         Mlja9rE9Ob9WFHzXX6520syQAmq7yXCi1VLDnKmEkDqYEvI4PH9Tyd2Lkh5bVg0MJHcB
         MOGg==
X-Gm-Message-State: APjAAAUGYP1nz89rzqkZaRnZn5QOSYBLrDQYBE8aE0615Ixir1OT1dGi
        8T2S9NKCN/egVIF3vzPitjtLFdfla9p1qA==
X-Google-Smtp-Source: APXvYqw7ubTG7lZv5JVCiqFOLPSNEoLSB55iGdTr5bT2vbPbEmdeG1wrCmNIKNSNZcscafSB7jKtsg==
X-Received: by 2002:a0c:c351:: with SMTP id j17mr4820178qvi.80.1576707636731;
        Wed, 18 Dec 2019 14:20:36 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f42sm1229613qta.0.2019.12.18.14.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 14:20:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/3] btrfs: do not delete mismatched root ref's
Date:   Wed, 18 Dec 2019 17:20:29 -0500
Message-Id: <20191218222029.49178-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191218222029.49178-1-josef@toxicpanda.com>
References: <20191218222029.49178-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_del_root_ref() will simply WARN_ON() if the ref doesn't match in
any way, and then continue to delete the reference.  This shouldn't
happen, we have these values because there's more to the reference than
the original root and the sub root.  If any of these checks fail, return
-ENOENT.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/root-tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 0a455f116666..f2a59ec6c1ce 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -346,11 +346,13 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 		leaf = path->nodes[0];
 		ref = btrfs_item_ptr(leaf, path->slots[0],
 				     struct btrfs_root_ref);
-
-		WARN_ON(btrfs_root_ref_dirid(leaf, ref) != dirid);
-		WARN_ON(btrfs_root_ref_name_len(leaf, ref) != name_len);
 		ptr = (unsigned long)(ref + 1);
-		WARN_ON(memcmp_extent_buffer(leaf, name, ptr, name_len));
+		if ((btrfs_root_ref_dirid(leaf, ref) != dirid) ||
+		    (btrfs_root_ref_name_len(leaf, ref) != name_len) ||
+		    memcmp_extent_buffer(leaf, name, ptr, name_len)) {
+			err = -ENOENT;
+			goto out;
+		}
 		*sequence = btrfs_root_ref_sequence(leaf, ref);
 
 		ret = btrfs_del_item(trans, tree_root, path);
-- 
2.23.0

