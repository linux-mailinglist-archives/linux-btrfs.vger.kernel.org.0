Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA26294837
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440775AbgJUG1C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:43610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731630AbgJUG1B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9tM6N148Ox/Nh5KjVgE5urdKTEGEu8tgI2CnSGEo4UU=;
        b=sMC0yKNDWN2dMyD9LHwHjQbXNGtkkSsLl5b20Sr6spx7I2En/bLgDYoIp6oalrUrrT3N+z
        sl0YY/Nkf/hsiRb3We8gBYa0YOvRY/Ms7+4wT98u12m1cLm6IGGxJgxC6SHHrxS6h4Bqg5
        YbkJe8fQnkiGLe+E0vL9RmS04MWGH1E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F457AC35
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 27/68] btrfs: introduce a helper to determine if the sectorsize is smaller than PAGE_SIZE
Date:   Wed, 21 Oct 2020 14:25:13 +0800
Message-Id: <20201021062554.68132-28-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just to save us several letters for the incoming patches.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9a72896bed2e..e3501dad88e2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3532,6 +3532,11 @@ static inline int btrfs_defrag_cancelled(struct btrfs_fs_info *fs_info)
 	return signal_pending(current);
 }
 
+static inline bool btrfs_is_subpage(struct btrfs_fs_info *fs_info)
+{
+	return (fs_info->sectorsize < PAGE_SIZE);
+}
+
 #define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
 
 /* Sanity test specific functions */
-- 
2.28.0

