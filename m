Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF77BFE682
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 21:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKOUnK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 15:43:10 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37801 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfKOUnK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 15:43:10 -0500
Received: by mail-qk1-f196.google.com with SMTP id e187so9199970qkf.4
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2019 12:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/KFNvH+dltAQTL/L+E2mXLT34MyE7eVOCmpIyLuaZgs=;
        b=kzBuUAt49HVgQN82WYuFOWgLlLaB5A3WpmWGQcOqfA8nzfUBtNt4a3CO7IyMMM+Kl9
         VBTW0TRLP+lECcoiQkWaeyZlL1BHa5C9ZfusxnEsUBPI8f88YoHLyjwFZN2luKcwIBfc
         BMFaXio0YGJgzeDPibXzEAAxiXCD8KyYpAnOXlSk7KIEhp5wDF8SW+5DA78f/tE4Bv5L
         kkvycLP4SUW6OaOeB7Yn87j1TIjhR1YdX0gdL+FGdJeEYZXhYy6btxB8ksEUm4Ib8cqq
         y2SUHdl/qAvXm5lbWJULT+QM7gIaRTWNPWJHJPY4JYEBCE677CLIwLF2eS2llay9AKyl
         QsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/KFNvH+dltAQTL/L+E2mXLT34MyE7eVOCmpIyLuaZgs=;
        b=nNd/hrOAOBeZ5TMJKwI4TrWPPYu1zkjcfhZ2aRN05BOyYN/L9oEs88UtEAMW+BO1bK
         OxsDQbnN4XI6FmohcZ2g9F+kDTZfqewQgYtZAr3KNksLBSG2nQLpLP1Ssjk9ecoWT+M5
         h/nJ3+wp9rMA8Z2j0S+khh3WagK7j6WOZMK4KLl/YaoMcWWYZ2a6ASDwJsh0dS7YkVYQ
         ldP8K1pjij/02cNlOkvWU9EEjPCLfKJaMF1k4v8naRKxsNHjlNjGsjhx/+slardULCBL
         +S+uAzeW1IVgXxfW3f/YKd5M6FIStzqmt9qC2cYdLf43CaeQ1xAgqGyS/nzL4rvXOHJ8
         4O0A==
X-Gm-Message-State: APjAAAWX+M8bZER7XVtIeB4gVmBQHVr+1Ffan4G0hEc7Eprq6tjoABx1
        R6cGTTc2iUWHri4RE1MfYB2GBTrtF5stwQ==
X-Google-Smtp-Source: APXvYqwHnDNgYC0OUpmcMWGFk7ZNk+KCcu4U1tCI3bIphZ66LG8N/CZUyE9y6MY67771/ibW22RxVA==
X-Received: by 2002:a05:620a:3cb:: with SMTP id r11mr14479646qkm.320.1573850588817;
        Fri, 15 Nov 2019 12:43:08 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o17sm4359342qkg.4.2019.11.15.12.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 12:43:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: do not corrupt the fs with rename exchange on a subvol
Date:   Fri, 15 Nov 2019 15:43:06 -0500
Message-Id: <20191115204306.3446-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Testing with the new fsstress support for subvolumes uncovered a pretty
bad problem with rename exchange on subvolumes.  We're modifying two
different subvolumes, but we only start the transaction on one of them,
so the other one is not added to the dirty root list.  This is caught by
btrfs_cow_block() with a warning because the root has not been updated,
however if we do not modify this root again we'll end up pointing at an
invalid root because the root item is never updated.

Fix this by making sure we add the destination root to the trans list,
the same as we do with normal renames.  This fixes the corruption.

Fixes: cdd1fedf8261 ("btrfs: add support for RENAME_EXCHANGE and RENAME_WHITEOUT")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f6fc47525a52..56032c518b26 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9575,6 +9575,9 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		goto out_notrans;
 	}
 
+	if (dest != root)
+		btrfs_record_root_in_trans(trans, dest);
+
 	/*
 	 * We need to find a free sequence number both in the source and
 	 * in the destination directory for the exchange.
-- 
2.23.0

