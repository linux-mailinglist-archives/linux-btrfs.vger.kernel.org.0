Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82F22D2F93
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgLHQ0M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbgLHQ0L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:11 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1356C0611CE
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:38 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id 4so8487979qvh.1
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LVjoueG7DPYL2gpBJdejG2XQObibV0Zvbm2kyS3mBis=;
        b=rn+AwlSp5cc5or+oVoHAMRNyalegjcsro547y4UCfRE8DRuR9PAHNQXQkF4lhhRvf9
         r88lyKTgzt6Oj+TgrS3gQ8dhUAKL9fKKIVDw/vnyQ8x1VUhRqxDI+lg/nZGg7D+DBfxi
         teOtiBvKEZODgAx1WwS5rOQTDiLj+V7O1zU/0RnJx4r5luAn/QlSGvbsTVVYec0/aFHv
         qKiW85coio85/7MbY6nLQvwnFn78lR6I7Q1CwTtTKQgerboWXYxGkXzoKbbVYYNgZR6j
         tT+Zl+inPs4wpWAq1RSO03/UNI7qyuhSz59daWdIEiR/O+yGCyRPo10GT/nmVIzd9xpy
         8v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LVjoueG7DPYL2gpBJdejG2XQObibV0Zvbm2kyS3mBis=;
        b=eBkLev6hLV2cwHhiZBP0ejy/ynSX55mlcuB1CQtx8uF2Htn+ong1YzpSOpzgFBFHQi
         gBftOWM+SsLCxdTBE4v082XXf+/bnchun99wBmORhfwDVBcwYJMqW7kmSTpSBxzb3jsb
         xvONenr9Yz8HLxAPx6g9Fn4/iqH5qrsH1S4Xss2RiOuL/7KOV+gvJ3BQYn9Oq4VKbCoB
         AqF+4kbEdfI1DqY1Qoxean4rOL0GwZOSrPsxFApVSjDVW+a+5HOlovN42MnmCM2/fgka
         QIG6eaziqwpBeGimTfPSEeskwkk7j5i2ukqwtoP3Cc3taS4bGp7HAQYNaZCZ7DJjrKzW
         WP+w==
X-Gm-Message-State: AOAM533kfsDig3C9BDswE3mg5FB9NxJvVFuIz7cU7jRusjOMo4/jbyq9
        OFvXDz1PyEUYxcj7962hlPoUp2rh14iRLgUc
X-Google-Smtp-Source: ABdhPJwoKkQfKn9xpzVtX8C/j8Ka+BMRDxZ0UOkU0kcKde9iQiDJOHXwJESKc2GNHPUDPBQr/DmpTg==
X-Received: by 2002:a0c:f809:: with SMTP id r9mr27579127qvn.17.1607444677521;
        Tue, 08 Dec 2020 08:24:37 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n95sm14764002qte.43.2020.12.08.08.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 16/52] btrfs: do proper error handling in record_reloc_root_in_trans
Date:   Tue,  8 Dec 2020 11:23:23 -0500
Message-Id: <276b6b304133163e72e11bf908fd5c5958316439.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Generally speaking this shouldn't ever fail, the corresponding fs root
for the reloc root will already be in memory, so we won't get -ENOMEM
here.

However if there is no corresponding root for the reloc root then we
could get -ENOMEM when we try to allocate it or we could get -ENOENT
when we look it up and see that it doesn't exist.

Convert these BUG_ON()'s into ASSERT()'s + proper error handling for the
case of corruption.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index fd00517fb0f6..bc676c11a2f4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1973,8 +1973,27 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
 		return 0;
 
 	root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset, false);
-	BUG_ON(IS_ERR(root));
-	BUG_ON(root->reloc_root != reloc_root);
+
+	/*
+	 * This should succeed, since we can't have a reloc root without having
+	 * already looked up the actual root and created the reloc root for this
+	 * root.
+	 *
+	 * However if there's some sort of corruption where we have a ref to a
+	 * reloc root without a corresponding root this could return -ENOENT.
+	 */
+	if (IS_ERR(root)) {
+		ASSERT(0);
+		return PTR_ERR(root);
+	}
+	if (root->reloc_root != reloc_root) {
+		ASSERT(0);
+		btrfs_err(fs_info,
+			  "root %llu has two reloc roots associated with it",
+			  reloc_root->root_key.offset);
+		btrfs_put_root(root);
+		return -EUCLEAN;
+	}
 	ret = btrfs_record_root_in_trans(trans, root);
 	btrfs_put_root(root);
 
-- 
2.26.2

