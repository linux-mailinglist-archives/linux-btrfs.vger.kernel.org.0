Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07262D2F91
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbgLHQ0K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbgLHQ0K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:10 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157BDC0619D4
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:01 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id n9so8480343qvp.5
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CFQS5oJ0NcfqH76o4PTWikteEs7+zX/hm+AegtBD5x0=;
        b=IzN2euUfLfrW+IWsMBY+nKe1fCaVFXAO1AbhEu9kqpvALQpyhbOW3jObJi4tQhrIRU
         70Vs/rvvSyJpu5XxSSPq/WcLwjng5iM2N8XKvLAmjtNlaGkHBW5OLLGfdcYL+VNeYORQ
         Qh+IIGpATZu4ASDR4sopp1X+mQQ0eXgZwvYfBTOhxbUpAmNc1QOlUvTf89MjkcJ+UefE
         QZbwcqozHdyY2QHnv9SB4WGrLrgfZBX6NOOM9oYs6SjRyHwZdLnuFEmJMoCeuQytEKxW
         Mv0avrL92Am2w4pQG9r4xsYXPGuZ0T1OOUVLTVIn4SUxS4+lY/l8QHLhbSqObaYvV/k7
         egZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CFQS5oJ0NcfqH76o4PTWikteEs7+zX/hm+AegtBD5x0=;
        b=Cm16LOFH6+v8277ygKMxABC61YuQDWLFduvWv2MWDQYwvI4PXK+9XT/vXB9/fizWGd
         f4DYlYvmDi1MOXkGhBqd0eNZg2DCtCmKwMrZdFEYT59lJQTYgYzdLRPdiIQ0vUutMR6Y
         tvMHitCa/dTyo6RdMjxviS34iDmk15co8yyXfIGKupk9VxjTi7uAv3tNYP5pcI9DBa86
         s4qboMhf4o+rDrvlK8w5ce838qqbglDjGANYqtAeXYV6VMEbGF4e5KexvL46DnNhIkb6
         XCcGts/HuiCaffu7kAaIL4fbhfKgkVS1CT5X0e8AeGHvsLdPCExDY9puUo3shf5SiO1K
         SzIA==
X-Gm-Message-State: AOAM532jrJUcVfbFWnVQeolou/FwbPQxLADUhHYTsJVyLmJyW3QvojBi
        iY1l9RcInawvPMCBTtWRXCw2jD3WixQZMDIM
X-Google-Smtp-Source: ABdhPJxE5o2UWtIzce9Sj91R/F0qr3iU8ZnZHCcbJU4d+/dyKIhHFTW8ZbJoUXPUSXx13dPCOHyIYQ==
X-Received: by 2002:a0c:a181:: with SMTP id e1mr27949454qva.53.1607444699774;
        Tue, 08 Dec 2020 08:24:59 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c2sm9218096qke.109.2020.12.08.08.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v6 26/52] btrfs: handle record_root_in_trans failure in create_pending_snapshot
Date:   Tue,  8 Dec 2020 11:23:33 -0500
Message-Id: <fe192a76a5ab6e430ffc6e6a3157577119b10203.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

record_root_in_trans can currently fail, so handle this failure
properly.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 7404d88e6201..375aa2bed36d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1567,8 +1567,9 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	dentry = pending->dentry;
 	parent_inode = pending->dir;
 	parent_root = BTRFS_I(parent_inode)->root;
-	record_root_in_trans(trans, parent_root, 0);
-
+	ret = record_root_in_trans(trans, parent_root, 0);
+	if (ret)
+		goto fail;
 	cur_time = current_time(parent_inode);
 
 	/*
@@ -1604,7 +1605,11 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		goto fail;
 	}
 
-	record_root_in_trans(trans, root, 0);
+	ret = record_root_in_trans(trans, root, 0);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 	btrfs_set_root_last_snapshot(&root->root_item, trans->transid);
 	memcpy(new_root_item, &root->root_item, sizeof(*new_root_item));
 	btrfs_check_and_init_root_item(new_root_item);
-- 
2.26.2

