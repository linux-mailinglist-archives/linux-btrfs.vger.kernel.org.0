Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A8312FCBA
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 19:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgACSsm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 13:48:42 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40255 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgACSsm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jan 2020 13:48:42 -0500
X-Originating-IP: 176.88.138.87
Received: from localhost.localdomain (unknown [176.88.138.87])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id DDBC8E0005;
        Fri,  3 Jan 2020 18:48:38 +0000 (UTC)
From:   Cengiz Can <cengiz@kernel.wtf>
To:     linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Cengiz Can <cengiz@kernel.wtf>
Subject: [PATCH] fs: btrfs: prevent unintentional int overflow
Date:   Fri,  3 Jan 2020 13:47:40 -0500
Message-Id: <20200103184739.26903-1-cengiz@kernel.wtf>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Coverity scan for 5.5.0-rc4 found a possible integer overflow in
tree-checker.c line 364.

`prev_csum_end = (prev_item_size / csumsize) * sectorsize;`

Quoting from scan results:

```
CID 1456959 Unintentional integer overflow

Unintentional integer overflow (OVERFLOW_BEFORE_WIDEN) overflow_before_widen:
Potentially overflowing expression `prev_item_size / csumsize * sectorsize`
with type unsigned int (32 bits, unsigned) is evaluated using 32-bit
arithmetic, and then used in a context that expects an expression of type u64.
(64 bits, unsigned).
```

Added a cast to `u64` on the left hand side of the expression.

Compiles fine on x86_64_defconfig with all btrfs config flags enabled.

Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
---
 fs/btrfs/tree-checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 97f3520b8d98..9f58f07be779 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -361,7 +361,7 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
 		u32 prev_item_size;
 
 		prev_item_size = btrfs_item_size_nr(leaf, slot - 1);
-		prev_csum_end = (prev_item_size / csumsize) * sectorsize;
+		prev_csum_end = (u64) (prev_item_size / csumsize) * sectorsize;
 		prev_csum_end += prev_key->offset;
 		if (prev_csum_end > key->offset) {
 			generic_err(leaf, slot - 1,
-- 
2.20.1

