Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D4D123EC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 06:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfLRFS5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 00:18:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43646 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRFS5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 00:18:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id k197so588044pga.10
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 21:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=53WTG0ZE2+rSr5ljxHjD5nykGS67qMrrBZtOVNwxaX4=;
        b=vBIJJLeI0pzMDJ1F3fQ+wnBjH402UqEy+OQ3Y3RkGwSqxMF3z2o3yQ3tSGG9yY1a2t
         MZ1RTNYviujoi6ESQeyHtXhQruDpeJZSQ2G+uCUELstsLO9HP7JhPxHqmf4HIVqRUeFg
         5/7uULMineMrieOUSG7bStjsSQaG1P+tYgtcdQZjA4P1ptjC6UsDuQGkHI1g7M4IlCr5
         MblMiV0sTjMMfRJWK1Bu2HsP7G7kYECGFWMWRQ3Wg6UTgh0K4DVunzYnOV8NxPST2N62
         kioF0JPCz63aqdPQEk+FnH6B/MzGvESa3603D6GaWrpK7py4rj23U+rsdiu5GkrnaIu0
         Um4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=53WTG0ZE2+rSr5ljxHjD5nykGS67qMrrBZtOVNwxaX4=;
        b=K0hZaEJWUxen9KfX6W83PwDMCQuggMd0SO04k6SdiQuUOtsSfg/DZLUIkWxePpf5/+
         fdZbAmqgiRQzb5FMtLPKX1ICgq1sefzuApj1USYV/XejFynOMdf/TyAhtJCkm2a4MdiK
         ypezlywjnVBdGdFn+AAOplwqPZjC1wjpYvcUzA9GKrmLmmhIuM1j/Gubtg6DZLeClT2X
         6rN7ibBkgEEdf8Id50GXXryQSG4MQ984rhGiE7iUy6P2osWPCYbBdVa7fgyecTgPUpy7
         Kuhj/Gb2RzIo4XAv7NKsUkI+cbqjy5kaDmArYqr/HM7Lk/SsdZxg6htTrhWJmipsogAs
         kt0Q==
X-Gm-Message-State: APjAAAWvWpEwNumwrOCx0IP1H/V0SJSbu6owdxEXuOz8VKjgI3YRWWqT
        v7nip0UswLmOThZDwF26NxC8OLy/oIE=
X-Google-Smtp-Source: APXvYqw86eHVE6leaBbR5F0qYX/X6DNj01+H2vzNEKMziEpxkGeIEirOOL5XyEBVm5l5L1SiJUnZ+Q==
X-Received: by 2002:a63:154d:: with SMTP id 13mr889365pgv.248.1576646336118;
        Tue, 17 Dec 2019 21:18:56 -0800 (PST)
Received: from p.lan (81.249.92.34.bc.googleusercontent.com. [34.92.249.81])
        by smtp.gmail.com with ESMTPSA id e2sm1014781pfh.84.2019.12.17.21.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 21:18:55 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH V2 01/10] btrfs-progs: handle error if btrfs_write_one_block_group() failed
Date:   Wed, 18 Dec 2019 13:18:40 +0800
Message-Id: <20191218051849.2587-2-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191218051849.2587-1-Damenly_Su@gmx.com>
References: <20191218051849.2587-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

Just break loop and return the error code if failed.
Functions in the call chain are able to handle it.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 extent-tree.c | 4 +++-
 transaction.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/extent-tree.c b/extent-tree.c
index 53be4f4c7369..4a3db029e811 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -1596,9 +1596,11 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 
 		cache = (struct btrfs_block_group_cache *)(unsigned long)ptr;
 		ret = write_one_cache_group(trans, path, cache);
+		if (ret)
+			break;
 	}
 	btrfs_free_path(path);
-	return 0;
+	return ret;
 }
 
 static struct btrfs_space_info *__find_space_info(struct btrfs_fs_info *info,
diff --git a/transaction.c b/transaction.c
index 45bb9e1f9de6..c9035c765a74 100644
--- a/transaction.c
+++ b/transaction.c
@@ -77,7 +77,9 @@ static int update_cowonly_root(struct btrfs_trans_handle *trans,
 					&root->root_item);
 		if (ret < 0)
 			return ret;
-		btrfs_write_dirty_block_groups(trans);
+		ret = btrfs_write_dirty_block_groups(trans);
+		if (ret)
+			return ret;
 	}
 	return 0;
 }
-- 
2.21.0 (Apple Git-122.2)

