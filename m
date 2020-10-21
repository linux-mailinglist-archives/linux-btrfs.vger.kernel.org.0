Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80256294856
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440855AbgJUG2M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:28:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:44794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440851AbgJUG2L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:28:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ulyjZ/QrDUjz2gNm2G7sW6yN4nI979QJhUmOmX/VziY=;
        b=SiwvaJcgYHL4lT0GBU4GCSQTOJgpuHcapBzL6qQKywTDDWMR5dcy+bkyFsBcdwayvgMx/H
        kSFrujX9scRz92lHQ7MdpAidQsjMFVTNKvwGZJrh/kS+GKrQOfGJmyPL3VmxzaHansaFsY
        CaQjfUaNMeAAJ9ODDsVpjtlSSp+vGcM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 596CAAC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:28:10 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 58/68] btrfs: output extra info for space info update underflow
Date:   Wed, 21 Oct 2020 14:25:44 +0800
Message-Id: <20201021062554.68132-59-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/space-info.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index c3c64019950a..f7c3fc3a8541 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -106,6 +106,8 @@ btrfs_space_info_update_##name(struct btrfs_fs_info *fs_info,		\
 				      sinfo->flags, abs_bytes,		\
 				      bytes > 0);			\
 	if (bytes < 0 && sinfo->name < -bytes) {			\
+		btrfs_warn(fs_info, "bytes_%s have %llu diff %lld\n",	\
+			trace_name, sinfo->name, bytes);		\
 		WARN_ON(1);						\
 		sinfo->name = 0;					\
 		return;							\
@@ -113,7 +115,7 @@ btrfs_space_info_update_##name(struct btrfs_fs_info *fs_info,		\
 	sinfo->name += bytes;						\
 }
 
-DECLARE_SPACE_INFO_UPDATE(bytes_may_use, "space_info");
+DECLARE_SPACE_INFO_UPDATE(bytes_may_use, "may_use");
 DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
 
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
-- 
2.28.0

