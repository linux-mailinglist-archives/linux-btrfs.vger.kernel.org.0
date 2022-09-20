Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8690A5BE76F
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Sep 2022 15:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiITNo0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Sep 2022 09:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiITNoY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Sep 2022 09:44:24 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C8520BE
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 06:44:22 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28KDhq9A065357;
        Tue, 20 Sep 2022 22:43:52 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Tue, 20 Sep 2022 22:43:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28KDhqfs065354
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Sep 2022 22:43:52 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <112cdf17-374f-fdc5-58ae-d8db3f695ac4@I-love.SAKURA.ne.jp>
Date:   Tue, 20 Sep 2022 22:43:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: [PATCH v2] btrfs: Call btrfs_set_header_generation() before
 btrfs_clean_tree_block()
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        syzbot <syzbot+fba8e2116a12609b6c59@syzkaller.appspotmail.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Alexander Potapenko <glider@google.com>
References: <000000000000a4618905d1361d3e@google.com>
 <062d63c8-39bf-62d8-4562-625184e97b6c@I-love.SAKURA.ne.jp>
 <PH0PR04MB74161B62751B7D8EDB3965719B4C9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <PH0PR04MB74161B62751B7D8EDB3965719B4C9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

syzbot is reporting uninit-value in btrfs_clean_tree_block() [1], for
commit bc877d285ca3dba2 ("btrfs: Deduplicate extent_buffer init code")
missed that btrfs_set_header_generation() in btrfs_init_new_buffer() must
not be moved to after clean_tree_block() because clean_tree_block() is
calling btrfs_header_generation() since commit 55c69072d6bd5be1 ("Btrfs:
Fix extent_buffer usage when nodesize != leafsize").

Since memzero_extent_buffer() will reset "struct btrfs_header" part, we
can't move btrfs_set_header_generation() to before memzero_extent_buffer().
Just re-add btrfs_set_header_generation() before btrfs_clean_tree_block().

Link: https://syzkaller.appspot.com/bug?extid=fba8e2116a12609b6c59 [1]
Reported-by: syzbot <syzbot+fba8e2116a12609b6c59@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: bc877d285ca3dba2 ("btrfs: Deduplicate extent_buffer init code")
---
Changes in v2:
  Don't remove btrfs_set_header_generation() after memzero_extent_buffer(),
  pointed out by Johannes Thumshirn <Johannes.Thumshirn@wdc.com>.

 fs/btrfs/extent-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 6914cd8024ba..cfbbd7dc3c46 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4888,6 +4888,9 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	    !test_bit(BTRFS_ROOT_RESET_LOCKDEP_CLASS, &root->state))
 		lockdep_owner = BTRFS_FS_TREE_OBJECTID;
 
+	/* btrfs_clean_tree_block() accesses generation field. */
+	btrfs_set_header_generation(buf, trans->transid);
+
 	/*
 	 * This needs to stay, because we could allocate a freed block from an
 	 * old tree into a new tree, so we need to make sure this new block is
-- 
2.18.4


