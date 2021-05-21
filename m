Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07DF38BFDC
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 08:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhEUGoz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 02:44:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:58782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233646AbhEUGoT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 02:44:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621579302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31hiDlu2m0+PuxWAdKVpkI5nIDb/NFr953Ga8n0PrRg=;
        b=re3EmjYYHygKtP3pnMDoUrAp5VJKWt9YLRJyuRwiWsip2ZX0pnSRbJ+2yPbujyK/r57oTA
        zKaZHUXQZYmzNiUZuv6+3tHeAT9FFYwEFu1z33ETfiFWegoV3d7LM1fgGssroAuCHPVRIE
        ocPgMRh0mO9S35W1eEqHQz4TjRbofws=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E37EEAE92;
        Fri, 21 May 2021 06:41:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH v3 27/31] btrfs: fix a crash caused by race between prepare_pages() and btrfs_releasepage()
Date:   Fri, 21 May 2021 14:40:46 +0800
Message-Id: <20210521064050.191164-28-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521064050.191164-1-wqu@suse.com>
References: <20210521064050.191164-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running generic/095, there is a high chance to crash with subpage
data RW support:
 assertion failed: PagePrivate(page) && page->private, in fs/btrfs/subpage.c:171
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/ctree.h:3403!
 Internal error: Oops - BUG: 0 [#1] SMP
 CPU: 1 PID: 3567 Comm: fio Tainted: G         C O      5.12.0-rc7-custom+ #17
 Hardware name: Khadas VIM3 (DT)
 Call trace:
  assertfail.constprop.0+0x28/0x2c [btrfs]
  btrfs_subpage_assert+0x80/0xa0 [btrfs]
  btrfs_subpage_set_uptodate+0x34/0xec [btrfs]
  btrfs_page_clamp_set_uptodate+0x74/0xa4 [btrfs]
  btrfs_dirty_pages+0x160/0x270 [btrfs]
  btrfs_buffered_write+0x444/0x630 [btrfs]
  btrfs_direct_write+0x1cc/0x2d0 [btrfs]
  btrfs_file_write_iter+0xc0/0x160 [btrfs]
  new_sync_write+0xe8/0x180
  vfs_write+0x1b4/0x210
  ksys_pwrite64+0x7c/0xc0
  __arm64_sys_pwrite64+0x24/0x30
  el0_svc_common.constprop.0+0x70/0x140
  do_el0_svc+0x28/0x90
  el0_svc+0x2c/0x54
  el0_sync_handler+0x1a8/0x1ac
  el0_sync+0x170/0x180
 Code: f0000160 913be042 913c4000 955444bc (d4210000)
 ---[ end trace 3fdd39f4cccedd68 ]---

[CAUSE]
Although prepare_pages() calls find_or_create_page(), which returns the
page locked, but in later prepare_uptodate_page() calls, we may call
btrfs_readpage() which unlocked the page.

This leaves a window where btrfs_releasepage() can sneak in and release
the page.

This can be proven by the dying ftrace dump:
 fio-3567 : prepare_pages: r/i=5/257 page_offset=262144 private=1 after set extent map
 fio-3536 : __btrfs_releasepage.part.0: r/i=5/257 page_offset=262144 private=1 clear extent map
 fio-3567 : prepare_uptodate_page.part.0: r/i=5/257 page_offset=262144 private=0 after readpage
 fio-3567 : btrfs_dirty_pages: r/i=5/257 page_offset=262144 private=0  NOT PRIVATE

[FIX]
In prepare_uptodate_page(), we should not only check page->mapping, but
also PagePrivate() to ensure we are still hold a correct page which has
proper fs context setup.

Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 6ef44afa939c..a4c092028bb6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1341,7 +1341,17 @@ static int prepare_uptodate_page(struct inode *inode,
 			unlock_page(page);
 			return -EIO;
 		}
-		if (page->mapping != inode->i_mapping) {
+
+		/*
+		 * Since btrfs_readpage() will get the page unlocked, we have
+		 * a window where fadvice() can try to release the page.
+		 * Here we check both inode mapping and PagePrivate() to
+		 * make sure the page is not released.
+		 *
+		 * The priavte flag check is essential for subpage as we need
+		 * to store extra bitmap using page->private.
+		 */
+		if (page->mapping != inode->i_mapping || !PagePrivate(page)) {
 			unlock_page(page);
 			return -EAGAIN;
 		}
-- 
2.31.1

