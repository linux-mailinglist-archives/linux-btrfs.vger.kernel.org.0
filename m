Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152BB31B653
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Feb 2021 10:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBOJVW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Feb 2021 04:21:22 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:52128 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhBOJVV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Feb 2021 04:21:21 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 4168145B715;
        Mon, 15 Feb 2021 11:20:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1613380834; bh=Os1tWV8bFPekbnJlhMlfxrk5Thu2x3I5hmlqqzWuSYE=;
        h=From:To:Cc:Subject:Date;
        b=SVLpboolr3/3T3zGS2ILeejs38Jou+4Drvrj1djii2+x+H+h0jUfd5+xLfBCMURx2
         vkxBpaomzj+Rc3lX7eKSgKyGC7WuGIYm6PC0mSYmJ7DuWZnnxLgYiAjdo5Wfl9Sb2Q
         Vhn3rstDD2EqrHdsUybh+xyutfMwijiNokI4cM5w=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 2DA2945B70E;
        Mon, 15 Feb 2021 11:20:34 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 2F_rGOzikWCd; Mon, 15 Feb 2021 11:20:33 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 8CCFC45B709;
        Mon, 15 Feb 2021 11:20:33 +0200 (EET)
Received: from localhost.localdomain (unknown [117.89.40.51])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 4E6AC1BE00E0;
        Mon, 15 Feb 2021 11:20:30 +0200 (EET)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su, nborisov@suse.com, boris@bur.io, dsterba@suse.cz
Subject: [PATCH RFC] btrfs-progs: check: continue to check space cache if sb cache_generation is 0
Date:   Mon, 15 Feb 2021 17:20:11 +0800
Message-Id: <20210215092011.6079-1-l@damenly.su>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: 885mlYtJBDatlFqhXX7fGXVJomoWHPGHj+q71h1YnnP5MCqCYip+XRWr7h97PgKk
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

User reported that test fsck-tests/037-freespacetree-repair fails:
 # TEST=037\* ./fsck-tests.sh
    [TEST/fsck]   037-freespacetree-repair
btrfs check should have detected corruption
test failed for case 037-freespacetree-repair

The test tries to corrupt FST, call btrfs check readonly then repair FST
using btrfs check. Above case failed at the second readonly check steup.
Test log said "cache and super generation don't match, space cache will
be invalidated" which is printed by validate_free_space_cache().
If cache_generation of the superblock is not -1ULL,
validate_free_space_cache() requires that cache_generation must equal
to the superblock's generation. Otherwise, it skips the check of space
cache(v1, v2) like the above case where the sb cache_generation is 0.

Since kernel commit 948462294577 ("btrfs: keep sb cache_generation
consistent with space_cache"), sb cache_generation will be set to be 0
once space cache v1 is disabled(nospace_cache/space_cache=v2).

Fix it by adding the condition if sb cache_generation is 0 in
validate_free_space_cache() as it's valid now since the kernel commit
mentioned above.

Link: https://github.com/kdave/btrfs-progs/issues/338
Signed-off-by: Su Yue <l@damenly.su>

---
Hi, while reading free space cache v1 related code, I am (still)
confused about the value meanings of cache_generation in sb.

For outdated space cache v1, cache_gen < sb gen.
For valid space cache v1, cache_gen == sb gen.
AS for values 0 and (u64)-1, many places use (u64)-1 to represent
cleared v1 caches. The only three places setting cache_gen to 0 are
1)  above kernel commit 948462294577.
2)  kernel btrfs_parse_options() while mounting zoned device.
3)  progs image/main.c:1147 while restoring image.

I'm wondering whether loosing check condition in this patch is correct
or not. So make it RFC. Thanks.
---
 check/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/check/main.c b/check/main.c
index c7c5408bea19..a652e445de90 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9951,7 +9951,12 @@ static int validate_free_space_cache(struct btrfs_root *root)
 {
 	int ret;
 
+	/*
+	 * If cache generation is between 0 and -1ULL, sb generation must equal to
+	 *   sb cache generation or the v1 space caches are outdated.
+	 */
 	if (btrfs_super_cache_generation(gfs_info->super_copy) != -1ULL &&
+	    btrfs_super_cache_generation(gfs_info->super_copy) != 0 &&
 	    btrfs_super_generation(gfs_info->super_copy) !=
 	    btrfs_super_cache_generation(gfs_info->super_copy)) {
 		printf(
-- 
2.30.0

