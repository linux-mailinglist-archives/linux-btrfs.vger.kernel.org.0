Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F5F160A50
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 07:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgBQGRH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 01:17:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:41834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgBQGRG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 01:17:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D4149AAC2
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2020 06:17:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/3] btrfs: relocation: Check cancel request after each extent found
Date:   Mon, 17 Feb 2020 14:16:54 +0800
Message-Id: <20200217061654.65567-4-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217061654.65567-1-wqu@suse.com>
References: <20200217061654.65567-1-wqu@suse.com>
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
index dc97fdd58c3d..67433ae476d6 100644
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

