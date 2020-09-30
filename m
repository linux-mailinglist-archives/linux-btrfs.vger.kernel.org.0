Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0624F27DE12
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgI3B4l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:56:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:50484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729633AbgI3B4k (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:56:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601430999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9tM6N148Ox/Nh5KjVgE5urdKTEGEu8tgI2CnSGEo4UU=;
        b=aIQzwL/wZjcqZcRuS/LnzVbtYkrdL6UDnT1yTG6ZZGPdKVYFHYnZ/aPK6JHfJfsiKzXvJa
        EghOe5buwP6FYf2+1im9dRQo7EooE48WVmnTkjEI4WboUYlw5NL73cs89MtpfRlC424NbT
        jB/8PEco0Np8DSCoUP4GmMvEtOW0vcY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B5B4AFAB
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:56:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 25/49] btrfs: introduce a helper to determine if the sectorsize is smaller than PAGE_SIZE
Date:   Wed, 30 Sep 2020 09:55:15 +0800
Message-Id: <20200930015539.48867-26-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
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

