Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BC41C9C2A
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgEGUVD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:21:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:56548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgEGUVC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:21:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AC29EAD2C;
        Thu,  7 May 2020 20:21:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 33DD2DA732; Thu,  7 May 2020 22:20:12 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 19/19] btrfs: update documentation of set/get helpers
Date:   Thu,  7 May 2020 22:20:12 +0200
Message-Id: <86176aac59bae7968d271be7477fe8e36becc9fc.1588853772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1588853772.git.dsterba@suse.com>
References: <cover.1588853772.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/struct-funcs.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 225ef6d7e949..1021b80f70db 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -39,23 +39,26 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
 }
 
 /*
- * this is some deeply nasty code.
+ * Macro templates that define helpers to read/write extent buffer data of a
+ * given size, that are also used via ctree.h for access to item members via
+ * specialized helpers.
  *
- * The end result is that anyone who #includes ctree.h gets a
- * declaration for the btrfs_set_foo functions and btrfs_foo functions,
- * which are wrappers of btrfs_set_token_#bits functions and
- * btrfs_get_token_#bits functions, which are defined in this file.
+ * Generic helpers:
+ * - btrfs_set_8 (for 8/16/32/64)
+ * - btrfs_get_8 (for 8/16/32/64)
  *
- * These setget functions do all the extent_buffer related mapping
- * required to efficiently read and write specific fields in the extent
- * buffers.  Every pointer to metadata items in btrfs is really just
- * an unsigned long offset into the extent buffer which has been
- * cast to a specific type.  This gives us all the gcc type checking.
+ * Generic helpes with a token, caching last page address:
+ * - btrfs_set_token_8 (for 8/16/32/64)
+ * - btrfs_get_token_8 (for 8/16/32/64)
  *
- * The extent buffer api is used to do the page spanning work required to
- * have a metadata blocksize different from the page size.
+ * The set/get functions handle data spanning two pages transparently, in case
+ * metadata block size is larger than page.  Every pointer to metadata items is
+ * an offset into the extent buffer page array, cast to a specific type.  This
+ * gives us all the type checking.
  *
- * There are 2 variants defined, one with a token pointer and one without.
+ * The extent buffer pages stored in the array pages do not form a contiguous
+ * range, but the API functions assume the linear offset to the range from
+ * 0 to metadata node size.
  */
 
 #define DEFINE_BTRFS_SETGET_BITS(bits)					\
-- 
2.25.0

