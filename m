Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 795EC61E95
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2019 14:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbfGHMk7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jul 2019 08:40:59 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35867 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfGHMk7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jul 2019 08:40:59 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MODeL-1i8QoA0AXp-00OZfs; Mon, 08 Jul 2019 14:40:23 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Nikolay Borisov <nborisov@suse.com>,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        Qu Wenruo <wqu@suse.com>, Liu Bo <bo.liu@linux.alibaba.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: reduce stack usage for btrfsic_process_written_block
Date:   Mon,  8 Jul 2019 14:40:09 +0200
Message-Id: <20190708124019.3374246-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8sOT6VQRiNZC3jnSu4L3RMXdtdrKeV0mXzADeVPdh87PGDVia0j
 cZ7K+7QQbnacsI/brzzT4cGLeui4MFzcdlcsG/Tpmj1j1wAmNJ/wVoz9FRpZModKOFBjj2Q
 CnedBnvnsjIsGn0hJlExKEw/fB4ylt3TtRsAG/eupJh0y2ru/rLrUzSPnD2bbng0PDHBQ8r
 Ux0R6kwhmV6oCjpF5YfPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eFrmzYnB2jc=:PqiTgWnbJy5Ai0g76Ilnfs
 kczS6VYts7jyh4xHlK5BmvFxLit8H4LsbxW9vvXAcEyexUS4s25e0xthcTnYMCjIL2QUbb0sn
 qigWfvOX1bV2ODxd3laivsHJnn1Vk3MrP7gnyvk3fBLBCMrAlEFvqcW4Q+7ONUvcQiB7ZhUOP
 r9dGSKEYD+oqtRCN4cPj21022GkjbtmQ+GoztNE1/JaxhBk0bxxSGnGmXXomUPfBpQJ65ojwm
 A7PDqFmkM2s0MbDberXHqmwVt7cM+n73md0c1EyjwTn7x63ZupBpAwH+0x2VoRxzhNsuKRlmV
 1FXcyVyPVZmObtZwt9PdWWdEfr/DBDbZphob4UWdq6xLGu1k3E9YmzX4SsoxIgHT0ejdI5Q21
 J20UjXS0XG/+qZtPAGyDA2z8WmPGnzouLksywVYKSqqO3OzH4WyRNLbyGTcERTvIAnkmS2bHq
 Ps4MnRfz7rwkmHny1bmzlg6MH6GbqA/Ng79IvBixGAwB6d11wZb41yVP5+TZZYypgjnuSEutI
 S+/8U6qO7Jv8TPSl9s6CJjWeq8BQ4mY86MGWt+4iabNBjW4C/MRyjirMcseyeQNcYNe+E5PhZ
 ybltCMNVyjMhjMnC0k89W//Doa0MGHdcGbu1yjmtLmt2sRF5jFgTOWzF4GhPkeBGubPCYmX5K
 whjt6Z5IiLz3IUMpvS+llVzUHLXRE4/1p6nO9m8vkpGDDI2wcVsLzDStaYi4tLp3fGipDABqe
 hE63Q7hIZVfzSl+SpKjrzWWH6xbQq6xpF27Gug==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfsic_process_written_block() cals btrfsic_process_metablock(),
which has a fairly large stack usage due to the btrfsic_stack_frame
variable. It also calls btrfsic_test_for_metadata(), which now
needs several hundreds of bytes for its SHASH_DESC_ON_STACK().

In some configurations, we end up with both functions on the
same stack, and gcc warns about the excessive stack usage that
might cause the available stack space to run out:

fs/btrfs/check-integrity.c:1743:13: error: stack frame size of 1152 bytes in function 'btrfsic_process_written_block' [-Werror,-Wframe-larger-than=]

Marking both child functions as noinline_for_stack helps because
this guarantees that the large variables are not on the same
stack frame.

Fixes: d5178578bcd4 ("btrfs: directly call into crypto framework for checksumming")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/check-integrity.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 81a9731959a9..0b52ab4cb964 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -940,7 +940,7 @@ static void btrfsic_stack_frame_free(struct btrfsic_stack_frame *sf)
 	kfree(sf);
 }
 
-static int btrfsic_process_metablock(
+static noinline_for_stack int btrfsic_process_metablock(
 		struct btrfsic_state *state,
 		struct btrfsic_block *const first_block,
 		struct btrfsic_block_data_ctx *const first_block_ctx,
@@ -1706,8 +1706,9 @@ static void btrfsic_dump_database(struct btrfsic_state *state)
  * Test whether the disk block contains a tree block (leaf or node)
  * (note that this test fails for the super block)
  */
-static int btrfsic_test_for_metadata(struct btrfsic_state *state,
-				     char **datav, unsigned int num_pages)
+static noinline_for_stack int btrfsic_test_for_metadata(
+		struct btrfsic_state *state,
+		char **datav, unsigned int num_pages)
 {
 	struct btrfs_fs_info *fs_info = state->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-- 
2.20.0

