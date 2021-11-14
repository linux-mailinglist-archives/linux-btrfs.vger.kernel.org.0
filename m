Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588A844F704
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Nov 2021 07:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhKNGSk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Nov 2021 01:18:40 -0500
Received: from smtpbg128.qq.com ([106.55.201.39]:51078 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229537AbhKNGSk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Nov 2021 01:18:40 -0500
X-QQ-mid: bizesmtp31t1636870518t26qdgq0
Received: from localhost.localdomain (unknown [125.69.41.88])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 14 Nov 2021 14:15:17 +0800 (CST)
X-QQ-SSF: 01000000002000C0F000B00A0000000
X-QQ-FEAT: k0yT7W7BRd2VRWWiQujtHiX3xQoNiuNYMFT0DoPO0z3Uo3znn2QbcyTmsDfNo
        ar7wVhLS9oX3ajjtFcMM8Dz7e/D89XhAS9Xnh/Z3a1IBnWScf/g+ul1B5W6jHtcsaY6R1Qk
        nn0VUsR1+9i/dGxoO4JS5RxjBcayC/gz8na74unuw3r3dm32csqn3SnUf1m8chRvmpHsTK+
        bF7cWdpryQPqIsde7vOFKB2nYF6KXUXYi1JYrTs154DrN4IulDDGmXgYHQi+UfOfbu+UMWI
        tu2AO+8ABSeJblX7kZpanQbya7mGgMhc9iJybxq/c3PXSfo+bxebvS9FOwB4fAEnlHP3+6x
        ieXsPV+Np7d599p8FqzRcI1i4qnAKbR0xl74Nmz
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     josef@toxicpanda.com
Cc:     clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] btrfs: remove unneeded variable ret
Date:   Sun, 14 Nov 2021 14:15:15 +0800
Message-Id: <20211114061515.247865-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The variable `ret' used for returning status in function
`unpin_extent_cache' is never changed. we can return 0
and remove the `ret' variable.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 fs/btrfs/extent_map.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 5a36add21305..ac432bed6052 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -296,7 +296,6 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
 		       u64 gen)
 {
-	int ret = 0;
 	struct extent_map *em;
 	bool prealloc = false;
 
@@ -328,8 +327,8 @@ int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
 	free_extent_map(em);
 out:
 	write_unlock(&tree->lock);
-	return ret;
 
+	return 0;
 }
 
 void clear_em_logging(struct extent_map_tree *tree, struct extent_map *em)
-- 
2.33.0

