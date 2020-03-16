Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D9A186762
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Mar 2020 10:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgCPJFR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Mar 2020 05:05:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:50786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730075AbgCPJFR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Mar 2020 05:05:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 18C09AEDE;
        Mon, 16 Mar 2020 09:05:16 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes.Thumshirn@wdc.com, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs-progs: Fix xxhash on big endian machines
Date:   Mon, 16 Mar 2020 11:05:12 +0200
Message-Id: <20200316090512.21519-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

xxhash's state and results are always in little, but in progs after the
hash was calculated it was copied to the final buffer via memcpy,
meaning it'd be parsed as a big endian number on big endian machines.
This is incompatible with the kernel implementation of xxhash which
results in erroneous "checksum didn't match" errors on mount.

Fix it by using put_unaligned_le64 which always ensures the resulting
checksum will be copied in little endian format as the kernel expects
it.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206835
Fixes: f070ece2e98f ("btrfs-progs: add xxhash64 to mkfs")
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 crypto/hash.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/crypto/hash.c b/crypto/hash.c
index 48623c798739..4009e84e8b2c 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -19,12 +19,7 @@ int hash_xxhash(const u8 *buf, size_t length, u8 *out)
 	XXH64_hash_t hash;

 	hash = XXH64(buf, length, 0);
-	/*
-	 * NOTE: we're not taking the canonical form here but the plain hash to
-	 * be compatible with the kernel implementation!
-	 */
-	memcpy(out, &hash, 8);
-
+	put_unaligned_le64(&hash, out);
 	return 0;
 }

--
2.17.1

