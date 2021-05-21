Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9D238C641
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 14:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhEUMKh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 08:10:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:58162 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234487AbhEUMKa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 08:10:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621598946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LLt5/qU5rA80I6M3qwgpwIKPgnlWQStv3G0mSPDQKxw=;
        b=SrYFgVShIZvLXJVEmd6ekKq11Bvp5/gZoJ4L3vHTXCsnKT6F+jfsU6puhdtpAlnm46jmbY
        eMhF5WYQyLPt9WDG6DSN2WCoB/P+/dBxQ+yFwFgCzLpWvyZO1HJLmXWbCwUfpIQRmaMBVk
        E43AU8U1EReB7e3wFpu9+0BS2zK0/6g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 251B6AAFD;
        Fri, 21 May 2021 12:09:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D16E6DA725; Fri, 21 May 2021 14:06:31 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/6] btrfs: introduce try-lock semantics for exclusive op start
Date:   Fri, 21 May 2021 14:06:31 +0200
Message-Id: <9a99c2204e431bc7a40bd1fb7c26ebb5fa741910.1621526221.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1621526221.git.dsterba@suse.com>
References: <cover.1621526221.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add try-lock for exclusive operation start to allow callers to do more
checks. The same operation must already be running. The try-lock and
unlock must pair and are a substitute for btrfs_exclop_start, thus it
must also pair with btrfs_exclop_finish to release the exclop context.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h |  3 +++
 fs/btrfs/ioctl.c | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3dfc32a3ebab..0dffc06b5ad4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3231,6 +3231,9 @@ void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
 			       struct btrfs_ioctl_balance_args *bargs);
 bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
 			enum btrfs_exclusive_operation type);
+bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
+				 enum btrfs_exclusive_operation type);
+void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info);
 void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
 
 /* file.c */
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c4e710ea08ba..cacd6ee17d8e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -371,6 +371,32 @@ bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+/*
+ * Conditionally allow to enter the exclusive operation in case it's compatible
+ * with the running one.  This must be paired with btrfs_exclop_start_unlock and
+ * btrfs_exclop_finish.
+ *
+ * Compatibility:
+ * - the same type is already running
+ * - not BTRFS_EXCLOP_NONE - this is intentionally incompatible and the caller
+ *   must check the condition first that would allow none -> @type
+ */
+bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
+				 enum btrfs_exclusive_operation type)
+{
+	spin_lock(&fs_info->super_lock);
+	if (fs_info->exclusive_operation == type)
+		return true;
+
+	spin_unlock(&fs_info->super_lock);
+	return false;
+}
+
+void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info)
+{
+	spin_unlock(&fs_info->super_lock);
+}
+
 void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
 {
 	spin_lock(&fs_info->super_lock);
-- 
2.29.2

