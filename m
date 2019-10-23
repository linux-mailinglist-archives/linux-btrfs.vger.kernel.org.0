Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F142E1B78
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 14:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404089AbfJWM44 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 08:56:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:51084 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390611AbfJWM44 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 08:56:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4E14CB754
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 12:56:55 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: volumes: Use more straightforward way to calculate map length
Date:   Wed, 23 Oct 2019 20:56:47 +0800
Message-Id: <20191023125648.30840-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023125648.30840-1-wqu@suse.com>
References: <20191023125648.30840-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The old code goes:

 	offset = logical - em->start;
	length = min_t(u64, em->len - offset, length);

Where @length calculate is dependent on offset, it can take reader
several more seconds to find it's just the same code as:

 	offset = logical - em->start;
	length = min_t(u64, em->start + em->len - logical, length);

Use above code to make the length calculate independent from other
variable, thus slightly increase the readability.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cdd7af424033..a6db11e821a5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5616,7 +5616,7 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 	}
 
 	offset = logical - em->start;
-	length = min_t(u64, em->len - offset, length);
+	length = min_t(u64, em->start + em->len - logical, length);
 
 	stripe_len = map->stripe_len;
 	/*
-- 
2.23.0

