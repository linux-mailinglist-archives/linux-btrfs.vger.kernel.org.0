Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB17D115380
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLFOqZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:25 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:45712 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfLFOqY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:24 -0500
Received: by mail-qv1-f68.google.com with SMTP id c2so2712433qvp.12
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tqjFPaSIMWGK3trwS7bmGXN/H40JuxpLUV/LPzvJNpQ=;
        b=eCKpOwAdpiWjx5E7PgYbwjVDxPH4UFBxfvnGpYzthQqpJGZCiGI6QR8YAJeXGrJxMZ
         BspMDvpww31W5QIsX2Fw3rqXYGZuUQvMMToQLL2xh773Mz8x5woIjDYxqbfIGTmDysrV
         fVXwuqbirqIZlNv7cy6wDkprA7LULBmIsVE/IT7aKcePIEbcIQi+MpEPizZgx2zrQsaL
         hVEdYtbpC/UHqoBTrLVVJTMjWe/9lAlUQ3UhjN5gm7BukKsw46Ye2auq8bCcsAEozMWN
         pgFe+9nNKHYrbhIb6Cc++sbHoSE6mkOyTY01myAzCHsm+islt8DFtAbkiP4eUHjg/syn
         szQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tqjFPaSIMWGK3trwS7bmGXN/H40JuxpLUV/LPzvJNpQ=;
        b=QSml2iSz1anssJMvGe5tI6CGJ+DncWXMhdUNtaL7JhJC1ZrwJiO34Ti6Bzy3LmYLWK
         OU0QKDvDxemG4O2ZeQpRCW0OH902BJxFz7H0HobX6h/4mVunLN6h7B4QcR0zJ527pe/5
         53OtEnIDnLDJY47NOamwQUoBefCyfMD+r4phn0mJkzWfdrhTetS5wZBUzcWCJl/oGb7u
         7IOsLBI+hEZhc96Nwg1h1vyUJwRc7USIc0yhYPE+xe34J+hXUMlkHpxCXcLc0mbPbQFT
         ZIiNTwKcLx3dyD/fQ8vhF7UNkD04AibYNhD0CQ+WOaFiVb9tbJrycF3fOKJC5s8elGIP
         t8Kg==
X-Gm-Message-State: APjAAAWwzlyegzejuxvfiMawZqqLHAKuEyoVCwyExvupMHqPSyz1pZcE
        jo/KOI25Qydi02QgkrsQNWd5bDpR2t1kcg==
X-Google-Smtp-Source: APXvYqzgdB727/4ivyCehh8ABdjA6WZNgJb/BSOOxgR/nLLSCAPgPrRAo1XefopXpcKBYD+3LKnxhA==
X-Received: by 2002:a0c:e150:: with SMTP id c16mr12894086qvl.51.1575643583439;
        Fri, 06 Dec 2019 06:46:23 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i4sm5851315qki.45.2019.12.06.06.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 24/44] btrfs: hold a ref on the root in prepare_to_merge
Date:   Fri,  6 Dec 2019 09:45:18 -0500
Message-Id: <20191206144538.168112-25-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up the reloc roots corresponding root, we need to hold a ref on
that root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 473bbbd58d31..19d69ce41f06 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2433,6 +2433,8 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		list_del_init(&reloc_root->root_list);
 
 		root = read_fs_root(fs_info, reloc_root->root_key.offset);
+		if (!btrfs_grab_fs_root(root))
+			BUG();
 		BUG_ON(IS_ERR(root));
 		BUG_ON(root->reloc_root != reloc_root);
 
@@ -2445,6 +2447,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		btrfs_update_reloc_root(trans, root);
 
 		list_add(&reloc_root->root_list, &reloc_roots);
+		btrfs_put_fs_root(root);
 	}
 
 	list_splice(&reloc_roots, &rc->reloc_roots);
-- 
2.23.0

