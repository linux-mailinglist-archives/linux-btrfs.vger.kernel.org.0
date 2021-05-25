Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9406439072D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 19:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhEYRMq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 13:12:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:34270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232224AbhEYRMq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 13:12:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621962675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIYDCBOzPvSS0xQYIS1rzCcGy8f301QvTslUhHUojI8=;
        b=aSyktOKIjwpxTNzwhOpAw2Wjj/VjHZnZy83yM975EK7KDs6vTyBu05gnbmLlCVnRlnjApa
        jVvtZRZcul1qjOtQKtUf5uGtQKFMivvY7q98WM74i1SGLDXfnTnHrXkIr6UgpoGc+6gB2l
        1xIglAM/2ec0TKU2csJIpVcaHs45i0A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B38B1AEEB;
        Tue, 25 May 2021 17:11:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 52B62DA70B; Tue, 25 May 2021 19:08:39 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 7/9] btrfs: remove extra sb::s_id from message in btrfs_validate_metadata_buffer
Date:   Tue, 25 May 2021 19:08:39 +0200
Message-Id: <9728b5a77818ff0c6ab80f2fa1de72c9f5c2ab32.1621961965.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1621961965.git.dsterba@suse.com>
References: <cover.1621961965.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The s_id is already printed by message helpers.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8c3db9076988..6dc137684899 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -614,8 +614,8 @@ static int validate_extent_buffer(struct extent_buffer *eb)
 
 		read_extent_buffer(eb, &val, 0, csum_size);
 		btrfs_warn_rl(fs_info,
-	"%s checksum verify failed on %llu wanted " CSUM_FMT " found " CSUM_FMT " level %d",
-			      fs_info->sb->s_id, eb->start,
+	"checksum verify failed on %llu wanted " CSUM_FMT " found " CSUM_FMT " level %d",
+			      eb->start,
 			      CSUM_FMT_VALUE(csum_size, val),
 			      CSUM_FMT_VALUE(csum_size, result),
 			      btrfs_header_level(eb));
-- 
2.29.2

