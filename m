Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA64B2A827D
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 16:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbgKEPpa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 10:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731202AbgKEPp1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 10:45:27 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D667C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 07:45:27 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id z6so1554867qkz.4
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 07:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EAZpcOaOyDU9aa631GTc6Lw8qei6UHmVVSB7izx/mKU=;
        b=kRht/n45RGF2mki+r3LpMsnm6VCkpX9ZfWF5UOzV+cQJoH3MsIrNxBwsDe6pN8jQf7
         /j+Mx5QhdfPVQknDjA2a8zTrcJkiK7KKaNpVP/+zA4bWEI6wvutGt+Fye56TebBF6luY
         FhN5YOrFzmyHiXRUEzpy2bIonCEQkj7oNDqgdb0qns8jlbTcxw/qyMH5Xon1Ex9NMGzA
         mZDsF1h4HJMDKHFsRFZpqP71VlEmTStQolA2it0ATrTScjhszuAYqLkfzg0CvsrMAjBi
         rbb5cdYizAua+eUOT/cJC/CIex6TY+UWT/UQ/YWeewbc5lOAtNka5M1Xcw3dbycdyWqR
         1h+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EAZpcOaOyDU9aa631GTc6Lw8qei6UHmVVSB7izx/mKU=;
        b=gSH2Iw+jqAHY1tkYBygcSMgx69hkKwG9WqXXR5IRK/xh5Mls29huanthLfFdkGN8Nf
         S/dHo8HR68NX8iH67qWDxTE7C06NcAMf50kkWDPhWRC9FKJy9IVKuaXY/HrH+7EBw/74
         KAzkwdzk83Ls9xMDnNnkXhaIwJs1yR9X3pl+zwLaT5TpGkAH1rCNhhmGB/yeENIBtxjQ
         mAKgMnlNxuhWYH5K6+EU2TGTw+iKHeYkYy7s9SwSn1hZS/IDYVgktcTmGHvpRxZzEaVA
         H2vLvv/bP462JDkL+XiYgxEePYrJbmoyHrDUArQCzGehDvL2csRa1NQE1kI1CtfDSclt
         9gMg==
X-Gm-Message-State: AOAM532RG/7bDBoKssFPk4OR9DrOsmQADblyd4AOKv+s4O/MrSpa79pV
        l/J+D3EH8ptPoFni2TQIEBYIsh3pauD3W4Z2
X-Google-Smtp-Source: ABdhPJyA5BzOC3brO4PgXqnTMSyw543XBap0+hhopO8GgGZhvOjdtc6HKVrYpY+xY+zDr5nv0XvZ5Q==
X-Received: by 2002:ae9:e90d:: with SMTP id x13mr2691838qkf.66.1604591125597;
        Thu, 05 Nov 2020 07:45:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w5sm1232041qkf.31.2020.11.05.07.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:45:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/14] btrfs: remove lockdep classes for the fs tree
Date:   Thu,  5 Nov 2020 10:45:08 -0500
Message-Id: <e19ba3fe887ce6ace42c8d57cf0db54e38ab5eb3.1604591048.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604591048.git.josef@toxicpanda.com>
References: <cover.1604591048.git.josef@toxicpanda.com>
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
index 212806d59012..35b16fe3b05f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -173,7 +173,6 @@ static struct btrfs_lockdep_keyset {
 	{ .id = BTRFS_EXTENT_TREE_OBJECTID,	DEFINE_NAME("extent")	},
 	{ .id = BTRFS_CHUNK_TREE_OBJECTID,	DEFINE_NAME("chunk")	},
 	{ .id = BTRFS_DEV_TREE_OBJECTID,	DEFINE_NAME("dev")	},
-	{ .id = BTRFS_FS_TREE_OBJECTID,		DEFINE_NAME("fs")	},
 	{ .id = BTRFS_CSUM_TREE_OBJECTID,	DEFINE_NAME("csum")	},
 	{ .id = BTRFS_QUOTA_TREE_OBJECTID,	DEFINE_NAME("quota")	},
 	{ .id = BTRFS_TREE_LOG_OBJECTID,	DEFINE_NAME("log")	},
-- 
2.26.2

