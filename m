Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1726140DA39
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Sep 2021 14:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbhIPMpJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Sep 2021 08:45:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37754 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhIPMpI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Sep 2021 08:45:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C65CC20219;
        Thu, 16 Sep 2021 12:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631796227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zTQ7NRVZqyQ7hP/NKX8hFWKDgfaVcQzuubPqZ8+V9q8=;
        b=nzc5YXudcED8qMiOoycI8jREld5PyRUe5LpzlSKQtBM207cj9Nd4IFMvISXGxRT22eb/2L
        ZHgwU2eH54ggK9Mm9171HnqcVrJlHmJYvTm2ZliMK7cBBFzNpsbyZU7+dqAQc/YlGCV0tT
        ElLpytA3LuDc4k3iOZpDXCxhnNYIgi4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C425C13CC7;
        Thu, 16 Sep 2021 12:43:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F2oEIQI8Q2FQSAAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 16 Sep 2021 12:43:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Eli V <eliventer@gmail.com>
Subject: [PATCH] btrfs: prevent __btrfs_dump_space_info() to underflow its free space
Date:   Thu, 16 Sep 2021 20:43:29 +0800
Message-Id: <20210916124329.65141-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's not uncommon where __btrfs_dump_space_info() get called
under over-commit situations.

In that case free space would underflow as total allocated space is not
enough to handle all the over-committed space.

Such underflow values can sometimes cause confusion for users enabled
enospc_debug mount option, and takes some seconds for developers to
convert the underflow value to signed result.

Just output the free space as s64 to avoid such problem.

Reported-by: Eli V <eliventer@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAJtFHUSy4zgyhf-4d9T+KdJp9w=UgzC2A0V=VtmaeEpcGgm1-Q@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/space-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 5ada02e0e629..e9a562d96ba6 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -414,9 +414,9 @@ static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 {
 	lockdep_assert_held(&info->lock);
 
-	btrfs_info(fs_info, "space_info %llu has %llu free, is %sfull",
+	btrfs_info(fs_info, "space_info %llu has %lld free, is %sfull",
 		   info->flags,
-		   info->total_bytes - btrfs_space_info_used(info, true),
+		   (s64)(info->total_bytes - btrfs_space_info_used(info, true)),
 		   info->full ? "" : "not ");
 	btrfs_info(fs_info,
 		"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu zone_unusable=%llu",
-- 
2.33.0

