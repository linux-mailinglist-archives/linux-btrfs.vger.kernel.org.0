Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B621589AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 06:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgBKFhr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 00:37:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:49916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbgBKFhq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 00:37:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 53419AB92
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2020 05:37:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs: relocation: Check cancel request after each extent found
Date:   Tue, 11 Feb 2020 13:37:28 +0800
Message-Id: <20200211053729.20807-4-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211053729.20807-1-wqu@suse.com>
References: <20200211053729.20807-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When relocating data block groups with tons of small extents, or
large metadata block groups, there can be over 200,000 extents.

We will iterate all extents of such block group in relocate_block_group(),
where iteration itself can be kinda time-consuming.

So when user want to cancel the balance, the extent iteration loop can
be another target.

This patch will add the cancelling check in the extent iteration loop of
relocate_block_group() to make balance cancelling faster.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 23b279872641..3379850d7695 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4181,6 +4181,10 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 				break;
 			}
 		}
+		if (should_cancel_balance(fs_info)) {
+			err = -ECANCELED;
+			break;
+		}
 	}
 	if (trans && progress && err == -ENOSPC) {
 		ret = btrfs_force_chunk_alloc(trans, rc->block_group->flags);
-- 
2.25.0

