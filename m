Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F6612EB57
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 22:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgABV1E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 16:27:04 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41873 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgABV1E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 16:27:04 -0500
Received: by mail-qk1-f195.google.com with SMTP id x129so32369850qke.8
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 13:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6dIL2CDD+lbwVKjmjsWcfqgDq4bkzY0K07V/pgzdXVc=;
        b=sW/IamC7gOhWESa4BlbfSOO3yABbZb8OuoIr6vIr7xCfNmdkV4puEr4XNs7CjeapKC
         iwW9PVGLy72ndc9kAPbIXZ+MCrC1iLxCNTau1oULZhGTqrvlQu/yH566aaIKE9ePiJhH
         U0f9O6rFx0C6CiA/aBbDmh0UPiLOuDtdzQ5IDNtE7di1z25wBgzTiq/L/VvZzr5qmKiH
         wHf0muvVpQ/FWYAAfve9PEnnBwn5Ss2yy55TL73JLJNvbEsULHNK63QjmQ61CqrH9xA1
         iSKJAjt/bzeTswnDcNKLmACLMhyF6mc8v0dkOfBB5TOKGmSpiLLQvGzKOPqghnk+Xpav
         k5LQ==
X-Gm-Message-State: APjAAAWhWAjnKxDvqcBhvIoIwrSoOtCCw07EtDmA4oFUblz0KuchqOGm
        IWA+8d28CZ4aZohX+Qg7A+1BnsAr
X-Google-Smtp-Source: APXvYqyfu2cET+WmwdFPLaXU8Y0E+I2z9WdHSbA/rnTaRIpua8x/MA5b1W59SrEGqNIwUChHC3UmRA==
X-Received: by 2002:a37:4b93:: with SMTP id y141mr70999981qka.205.1578000423360;
        Thu, 02 Jan 2020 13:27:03 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id f42sm17553933qta.0.2020.01.02.13.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 13:27:02 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 11/12] btrfs: ensure removal of discardable_* in free_bitmap()
Date:   Thu,  2 Jan 2020 16:26:45 -0500
Message-Id: <fe33c76ede300fd4cb03d0a7878cac0cbee47c42.1577999991.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Most callers of free_bitmap() only call it if bitmap_info->bytes is 0.
However, there are certain cases where we may free the free space cache
via __btrfs_remove_free_space_cache(). This exposes a path where
free_bitmap() is called regardless. This may result in a bad accounting
situation for discardable_bytes and discardable_extents. So, remove the
stats and call btrfs_discard_update_discardable().

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/free-space-cache.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 6d74d96a1d13..2b294c57060c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1959,6 +1959,18 @@ static void add_new_bitmap(struct btrfs_free_space_ctl *ctl,
 static void free_bitmap(struct btrfs_free_space_ctl *ctl,
 			struct btrfs_free_space *bitmap_info)
 {
+	/*
+	 * Normally when this is called, the bitmap is fully empty.  However,
+	 * if we are blowing up the free space cache for one reason or another
+	 * via __btrfs_remove_free_space_cache(), then it may not be freed and
+	 * we may leave stats on the table.
+	 */
+	if (bitmap_info->bytes && !btrfs_free_space_trimmed(bitmap_info)) {
+		ctl->discardable_extents[BTRFS_STAT_CURR] -=
+			bitmap_info->bitmap_extents;
+		ctl->discardable_bytes[BTRFS_STAT_CURR] -= bitmap_info->bytes;
+
+	}
 	unlink_free_space(ctl, bitmap_info);
 	kmem_cache_free(btrfs_free_space_bitmap_cachep, bitmap_info->bitmap);
 	kmem_cache_free(btrfs_free_space_cachep, bitmap_info);
@@ -2776,6 +2788,8 @@ void __btrfs_remove_free_space_cache(struct btrfs_free_space_ctl *ctl)
 {
 	spin_lock(&ctl->tree_lock);
 	__btrfs_remove_free_space_cache_locked(ctl);
+	if (ctl->private)
+		btrfs_discard_update_discardable(ctl->private, ctl);
 	spin_unlock(&ctl->tree_lock);
 }
 
-- 
2.17.1

