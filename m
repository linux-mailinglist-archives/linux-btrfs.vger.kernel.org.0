Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A41E28B317
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Oct 2020 12:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbgJLKzd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 06:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387573AbgJLKzd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 06:55:33 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18EF920E65
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Oct 2020 10:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602500132;
        bh=gWJOkh1CzT6XoGk8bqorpSQPGICGrEFvg5uY6+uVrT0=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=FZkXznJsiZzcYf/euP8p5r0j1IzejCGPJmHTQtP98APH5/GnnFPON8QcvfBWXrylZ
         YKGsSiPpZYG4UiAGDDRGm4SGy6RuiwT9nGT239at5lCv1dhBqQjLBP9c1Z8y5IumRz
         +275zRDCuvE+MCyosgTSR1w88SuyH7beFTVl3BGQ=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: assert we are holding the reada_lock when releasing a readahead zone
Date:   Mon, 12 Oct 2020 11:55:25 +0100
Message-Id: <6c59a12446b7583172c886bee886d5229f7dccd5.1602499588.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602499587.git.fdmanana@suse.com>
References: <cover.1602499587.git.fdmanana@suse.com>
In-Reply-To: <cover.1602499587.git.fdmanana@suse.com>
References: <cover.1602499587.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When we drop the last reference of a zone, we end up releasing it through
the callback reada_zone_release(), which deletes the zone from a device's
reada_zones radix tree. This tree is protected by the global readahead
lock at fs_info->reada_lock. Currently all places that are sure that they
are dropping the last reference on a zone, are calling kref_put() in a
critical section delimited by this lock, while all other places that are
sure they are not dropping the last reference, do not bother calling
kref_put() while holding that lock.

When working on the previous fix for hangs and use-after-frees in the
readahead code, my initial attempts were different and I actually ended
up having reada_zone_release() called when not holding the lock, which
resulted in weird and unexpected problems. So just add an assertion
there to detect such problem more quickly and make the dependency more
obvious.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/reada.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index d9a166eb344e..6e33cb755fa5 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -531,6 +531,8 @@ static void reada_zone_release(struct kref *kref)
 {
 	struct reada_zone *zone = container_of(kref, struct reada_zone, refcnt);
 
+	lockdep_assert_held(&zone->device->fs_info->reada_lock);
+
 	radix_tree_delete(&zone->device->reada_zones,
 			  zone->end >> PAGE_SHIFT);
 
-- 
2.28.0

