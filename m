Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FBF39072B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 19:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhEYRMm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 13:12:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:34132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232224AbhEYRMl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 13:12:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621962671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hr8Mg50C9dz3BOOX0XVvK0dkoEhcXIp83ejOodMDMjE=;
        b=tdsk6Si6L4/cbECJV6Jqs4lGNOZvF1rr9Zeob3cwMxn5ues5jrAX3A81QOzEkThNhAlafk
        gZYtkpyapz8TW/DzVaQOYmrH/9goV3ok83PFXxRiJKAIjoV3K8MaCacmOBSN46Nokkqz69
        OrUIFvTSJxtaOkuZl87AhjHtx9bgjzI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 19A8CAEEB;
        Tue, 25 May 2021 17:11:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AECF4DA70B; Tue, 25 May 2021 19:08:34 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/9] btrfs: document byte swap optimization of root_item::flags accessors
Date:   Tue, 25 May 2021 19:08:34 +0200
Message-Id: <aa044ee1e458071530d3f74f53cddc72010f3f63.1621961965.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1621961965.git.dsterba@suse.com>
References: <cover.1621961965.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d78cb2d89d7e..a3b628ea4d64 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2216,11 +2216,13 @@ BTRFS_SETGET_STACK_FUNCS(root_rtransid, struct btrfs_root_item,
 
 static inline bool btrfs_root_readonly(const struct btrfs_root *root)
 {
+	/* Byte-swap the constant at compile time, root_item::flags is LE */
 	return (root->root_item.flags & cpu_to_le64(BTRFS_ROOT_SUBVOL_RDONLY)) != 0;
 }
 
 static inline bool btrfs_root_dead(const struct btrfs_root *root)
 {
+	/* Byte-swap the constant at compile time, root_item::flags is LE */
 	return (root->root_item.flags & cpu_to_le64(BTRFS_ROOT_SUBVOL_DEAD)) != 0;
 }
 
-- 
2.29.2

