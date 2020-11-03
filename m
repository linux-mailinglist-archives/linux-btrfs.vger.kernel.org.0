Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCDF2A468B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgKCNcC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:32:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:44844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbgKCNcB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:32:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F0ITjYJVIsXk474dvJ/zwRTyBsaOnN9Y7QIdxp/Ydt0=;
        b=uJNSZ4Wy2NGyf2tjNcokr5S3f7sLOYuoJbIUMO7iPECYM13ssmntjQ/9TYZ8OwQQAWC6YF
        eD2l59enByej8m+IHUUlRIp/njhIDDvRleskQ786aA9qeRWjBQ816dvDTnFCWAJjvXG2OG
        ndKtmO7kTzSJfcYfBuPsLMH2GwNV8Kc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C89DAF95
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:32:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 15/32] btrfs: introduce a helper to determine if the sectorsize is smaller than PAGE_SIZE
Date:   Tue,  3 Nov 2020 21:30:51 +0800
Message-Id: <20201103133108.148112-16-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
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
index b46eecf882a1..a08cf6545a82 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3607,6 +3607,11 @@ static inline int btrfs_defrag_cancelled(struct btrfs_fs_info *fs_info)
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

