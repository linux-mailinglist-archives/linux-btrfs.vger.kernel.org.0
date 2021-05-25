Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86C1390726
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 19:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhEYRMc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 13:12:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:33816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232224AbhEYRMc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 13:12:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621962661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bN6Qfg2U1nDDchbXuYjxe9c5nBODnl7dhsdvM3++zM=;
        b=KCVGWMWyTvQLhCQjKrBXgaUFNLC/aarWQQEWba4F2TR+FERtvs7cCx4suWHYayiRwi54Jt
        RI6oroj1o2qLwsNVNAZlmIcRjg2NJlt2Js/0GZRgXhHj/eXP9WMAD2WIc4137BJQor26Ip
        oQwegBmxiajfVACQBsnt9ovXDeqwmYo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DA10DAEEB;
        Tue, 25 May 2021 17:11:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 78E5DDA70B; Tue, 25 May 2021 19:08:25 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/9] btrfs: sysfs: fix format string for some discard stats
Date:   Tue, 25 May 2021 19:08:25 +0200
Message-Id: <aabd2d30ceb25be5dd6ba2812f85b92fea0544d1.1621961965.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1621961965.git.dsterba@suse.com>
References: <cover.1621961965.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The type of discard_bitmap_bytes and discard_extent_bytes is u64 so the
format should be %llu, though the actual values would hardly ever
overflow to negative values.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index c45d9b6dfdb5..4b508938e728 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -429,7 +429,7 @@ static ssize_t btrfs_discard_bitmap_bytes_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%lld\n",
+	return scnprintf(buf, PAGE_SIZE, "%llu\n",
 			fs_info->discard_ctl.discard_bitmap_bytes);
 }
 BTRFS_ATTR(discard, discard_bitmap_bytes, btrfs_discard_bitmap_bytes_show);
@@ -451,7 +451,7 @@ static ssize_t btrfs_discard_extent_bytes_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%lld\n",
+	return scnprintf(buf, PAGE_SIZE, "%llu\n",
 			fs_info->discard_ctl.discard_extent_bytes);
 }
 BTRFS_ATTR(discard, discard_extent_bytes, btrfs_discard_extent_bytes_show);
-- 
2.29.2

