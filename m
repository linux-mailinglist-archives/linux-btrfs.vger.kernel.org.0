Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F91A2B1B63
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 13:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgKMMw3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 07:52:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:46860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgKMMw2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 07:52:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605271947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CfO8S8xAGbPEpZVts/MyRk0bhUS4dk926TYIBWlqEW0=;
        b=KHVF1h3jvpN4TeXdUIA3acatstJNy2bE/xD5cexTBSvH+rvlPy98x0SARW3FGq8iIdNhXZ
        pdkdsE1IMRU0npvFOK05tOKnfF9WopflhlgrckD+mGeEaHUprsNCFKc2UgxaDiU5fkNzN5
        bPFcDcpiuzxM/hRNOIoGzeTY0WRExH8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D6DB4ABD6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 12:52:27 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 10/24] btrfs: introduce a helper to determine if the sectorsize is smaller than PAGE_SIZE
Date:   Fri, 13 Nov 2020 20:51:35 +0800
Message-Id: <20201113125149.140836-11-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113125149.140836-1-wqu@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
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
index 99955b6bfc62..93de6134c65c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3660,6 +3660,11 @@ static inline int btrfs_defrag_cancelled(struct btrfs_fs_info *fs_info)
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
2.29.2

