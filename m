Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EDC2A0FDA
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 22:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgJ3VDL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 17:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgJ3VDL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 17:03:11 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B83C0613D2
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:11 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id x20so6220284qkn.1
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=o4kW1gWmkUqX15XC3VgB86RSBgXKlsCwAe0i7TwFvdg=;
        b=VXM3fs0gBKJlp4+f+TRllDZ2Tg0hglPNgfuy7Mlm1tZN+VGx7C9oVMomm+BRcsskVf
         RuMENn4YuSWVCRBQzBcjhfIyf4FCxFxsNbHVnNoOkT+Yl9xuNd87YEyTa178OFtqLTrF
         PvGyzkJ8dH9P1xNE2nGADN6vuorZvbdW5jvcdXavbwq2szmYhMI55K6uaHE3HX5zYIF5
         0VPOZLe7KW2hs0sQ70ICudRcrkGSonKblo7bJwZUT9RUoimtyRDFsmRQ4fK1bubZDgc+
         Zt3XupSXyns/5eoTLVIrHbiLn8q+x6RTNhL51S2iK4AnK4EWHADmCeEjx9U8eJ2K4ef0
         gHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o4kW1gWmkUqX15XC3VgB86RSBgXKlsCwAe0i7TwFvdg=;
        b=R6ZB4xlHn+/bKPVEj4bXhrhOhaV2LcfiXqIvZiLf1Z75hxghneLvvsKfPIjQXxMZfW
         DS+B73Qdu20YcdL4TvkbnAPJW5sFFo7CnGkcsYRjzIqLwG21azZqzuaiXkiMCFWQTrJe
         LgamlMVwoE1dbTyz98AwEDomSAJiWmPayVI0T+0S5hv9Qi4dMvDjS51WxnCAXWFh7hte
         FG7CEVb8NmLVOkiD0ukT5iQNbZZt/9sf5iyAQalN84wufLwkeBD2T0upFBdavIFCvydH
         9fAfgJxCV/98Jlg1bIucYR/L4849XfJN1GCbJLF3E+rINQMOalO1TJIvIVYrqV4EC4Ik
         iYaA==
X-Gm-Message-State: AOAM532QRrXW8dy+appAZHc+lB9dwrXQ9fEXHPJu+nNos3+++jPhIyXy
        Y83L+SYnc6x2f/8IzRA9YGsfrluNGbosh4sP
X-Google-Smtp-Source: ABdhPJxbDeTbTwZZI+GN3zHHTPLSpm9BLuVOFlG1YSnEDMU17jxhvx0w42rParaUhwKgbuHlX0Oj+g==
X-Received: by 2002:a37:a38b:: with SMTP id m133mr4355038qke.45.1604091790086;
        Fri, 30 Oct 2020 14:03:10 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d14sm3344702qtr.62.2020.10.30.14.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 14:03:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/14] btrfs: remove lockdep classes for the fs tree
Date:   Fri, 30 Oct 2020 17:02:53 -0400
Message-Id: <4dcc77e1f45454ed6c21bae655041d33efd0e0b7.1604091530.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604091530.git.josef@toxicpanda.com>
References: <cover.1604091530.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have this weird problem where our lockdep class is set after we
read a tree block, which can race with concurrent readers and result in
erroneous lockdep errors.  We want to set the lockdep class at
allocation time if possible, but in certain cases we may not have the
actual root owner, such as with relocation or any backref lookups.  This
is only really a problem for reference counted tree's, because all other
tree's have their root reference set in their extent reference.  Remove
the fs tree specific lock class.  We need to still keep the reloc tree
one, it's still reference counted, because replace_path will lock the
reloc tree and the destination tree, and if they're both set to
tree-<level> we'll have issues.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 601a7ab2adb4..73eae594e934 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -160,7 +160,6 @@ static struct btrfs_lockdep_keyset {
 	{ .id = BTRFS_EXTENT_TREE_OBJECTID,	.name_stem = "extent"	},
 	{ .id = BTRFS_CHUNK_TREE_OBJECTID,	.name_stem = "chunk"	},
 	{ .id = BTRFS_DEV_TREE_OBJECTID,	.name_stem = "dev"	},
-	{ .id = BTRFS_FS_TREE_OBJECTID,		.name_stem = "fs"	},
 	{ .id = BTRFS_CSUM_TREE_OBJECTID,	.name_stem = "csum"	},
 	{ .id = BTRFS_QUOTA_TREE_OBJECTID,	.name_stem = "quota"	},
 	{ .id = BTRFS_TREE_LOG_OBJECTID,	.name_stem = "log"	},
-- 
2.26.2

