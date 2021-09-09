Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9C84055D3
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 15:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356182AbhIINNz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Sep 2021 09:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355735AbhIINDl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Sep 2021 09:03:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D29536327F;
        Thu,  9 Sep 2021 11:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631188794;
        bh=zxIikZRaq4hB/3fhVzLvGkoBhdcJrIX7mwAZc2aU5dU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cv3zKUggy89WJEzni4DqAYroAQKT1Dg4rrA8q8++xleb7XB2PNAJnY+QzieAab/6d
         qLnfY2Qwne9Arl7u8WSiu8ssIKah12bnrb78VrQfHxh1T34uoyNumKsIAFiRX556p5
         FS9lw70dNYs3EDgPp1XDH5aH4f1vLbZ5KEYdXGJfHiB3yeQ2G1XBe+iUp6arUybdAp
         lZQ7FLVezUN1+iqVWXQMCoIF2j945JMPVk2WeGIg5KrGPpPF/9Ejab+XlgcIa+WyhW
         oi2hCwM7/HtjzKzZbLyWnofay/7I18SdPGOEYkhH2LwHTxBTHZzYya8wKh7I+OwnUE
         1E5byOfZY7V/A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, Ritesh Harjani <riteshh@linux.ibm.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 43/59] btrfs: subpage: fix race between prepare_pages() and btrfs_releasepage()
Date:   Thu,  9 Sep 2021 07:58:44 -0400
Message-Id: <20210909115900.149795-43-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909115900.149795-1-sashal@kernel.org>
References: <20210909115900.149795-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit e0467866198f7f536806f39e5d0d91ae8018de08 ]

[BUG]
When running generic/095, there is a high chance to crash with subpage
data RW support:

 assertion failed: PagePrivate(page) && page->private
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/ctree.h:3403!
 Internal error: Oops - BUG: 0 [#1] SMP
 CPU: 1 PID: 3567 Comm: fio Tainted: 5.12.0-rc7-custom+ #17
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
btrfs_readpage() which will unlock the page before it returns.

This leaves a window where btrfs_releasepage() can sneak in and release
the page, clearing page->private and causing above ASSERT().

[FIX]
In prepare_uptodate_page(), we should not only check page->mapping, but
also PagePrivate() to ensure we are still holding the correct page which
has proper fs context setup.

Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/file.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index dd2504322a87..7798355098db 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1343,7 +1343,18 @@ static int prepare_uptodate_page(struct inode *inode,
 			unlock_page(page);
 			return -EIO;
 		}
-		if (page->mapping != inode->i_mapping) {
+
+		/*
+		 * Since btrfs_readpage() will unlock the page before it
+		 * returns, there is a window where btrfs_releasepage() can
+		 * be called to release the page.
+		 * Here we check both inode mapping and PagePrivate() to
+		 * make sure the page was not released.
+		 *
+		 * The private flag check is essential for subpage as we need
+		 * to store extra bitmap using page->private.
+		 */
+		if (page->mapping != inode->i_mapping || !PagePrivate(page)) {
 			unlock_page(page);
 			return -EAGAIN;
 		}
-- 
2.30.2

