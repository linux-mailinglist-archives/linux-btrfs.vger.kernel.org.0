Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6023334DE6B
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Mar 2021 04:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhC3C3P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 22:29:15 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:36946 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhC3C2r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 22:28:47 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 892D06C01AAB;
        Tue, 30 Mar 2021 05:28:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1617071325; bh=+zdoXbHmpxterW9MZWV+iI18Z1PRmTGHRV+FdElzSCU=;
        h=From:To:Cc:Subject:Date;
        b=AzAi7TKB90mBYGTGlOm+j50IhIjT7xPF72/mPP0TE1huX5M1OOR4qQNfBLvtdFidl
         S2+Wv5E0PV2GIewErBVGyvK07QvZBXeArvgKbDZVZoVaypKvwx9ABpkk/VlF6Ht3Ul
         7/uEJnH36mI8TalLK8BY8f2kK3MWBqjs8aBpNvDM=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 79C806C01AAA;
        Tue, 30 Mar 2021 05:28:45 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id ETImCL2cuwnU; Tue, 30 Mar 2021 05:28:45 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id E98286C01AA6;
        Tue, 30 Mar 2021 05:28:44 +0300 (EEST)
Received: from localhost.localdomain (unknown [45.87.95.48])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id D58801BE00C8;
        Tue, 30 Mar 2021 05:28:42 +0300 (EEST)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su, Boris Burkov <boris@bur.io>
Subject: [PATCH v2] btrfs-progs: check: continue to check space cache if sb cache_generation is 0
Date:   Tue, 30 Mar 2021 10:28:30 +0800
Message-Id: <20210330022830.491831-1-l@damenly.su>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: 885mkI9QEjm6g1u/R3PCZ3U6rDY6L+Cfm/vJrhAZwzvmU1qJf04NURK/nm1yS2A=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

User reported that test fsck-tests/037-freespacetree-repair fails:
 # TEST=037\* ./fsck-tests.sh
    [TEST/fsck]   037-freespacetree-repair
btrfs check should have detected corruption
test failed for case 037-freespacetree-repair

The test tries to corrupt FST, call btrfs check readonly then repair FST
using btrfs check. Above case failed at the second readonly check step.
Test log said "cache and super generation don't match, space cache will
be invalidated" which is printed by validate_free_space_cache().
If cache_generation of the superblock is not -1ULL,
validate_free_space_cache() requires that cache_generation must equal
to the superblock's generation. Otherwise, it skips the check of space
cache(v1, v2) like the above case where the sb cache_generation is 0.

Since kernel commit 948462294577 ("btrfs: keep sb cache_generation
consistent with space_cache"), sb cache_generation will be set to be 0
once space cache v1 is disabled(nospace_cache/space_cache=v2). But
progs check was forgotten to be added the 0 case support.

Fix it by adding the condition if sb cache_generation is 0 in
validate_free_space_cache() as the 0 case is valid now since the
kernel commit mentioned above.

Link: https://github.com/kdave/btrfs-progs/issues/338
Signed-off-by: Su Yue <l@damenly.su>
Reviewed-by: Boris Burkov <boris@bur.io>
---
Changelog:
  v2:
    Change the commit description little.
    Add the reviewed-by.
    Remove 'RFC' from subject.
---
 check/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/check/main.c b/check/main.c
index a5d2e4ee2dd6..15aa29335240 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9953,7 +9953,12 @@ static int validate_free_space_cache(struct btrfs_root *root)
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
2.30.1

