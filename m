Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E3C5BE4EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Sep 2022 13:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiITLsw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Sep 2022 07:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiITLsb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Sep 2022 07:48:31 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF5D167E3
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Sep 2022 04:48:30 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28KBmRtP040830;
        Tue, 20 Sep 2022 20:48:27 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Tue, 20 Sep 2022 20:48:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28KBmRuR040827
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Sep 2022 20:48:27 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <062d63c8-39bf-62d8-4562-625184e97b6c@I-love.SAKURA.ne.jp>
Date:   Tue, 20 Sep 2022 20:48:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: [PATCH] btrfs: Call btrfs_set_header_generation() before
 btrfs_clean_tree_block()
Content-Language: en-US
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
References: <000000000000a4618905d1361d3e@google.com>
Cc:     linux-btrfs@vger.kernel.org,
        syzbot <syzbot+fba8e2116a12609b6c59@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Alexander Potapenko <glider@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000a4618905d1361d3e@google.com>
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

Link: https://syzkaller.appspot.com/bug?extid=fba8e2116a12609b6c59 [1]
Reported-by: syzbot <syzbot+fba8e2116a12609b6c59@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: bc877d285ca3dba2 ("btrfs: Deduplicate extent_buffer init code")
---
This patch is not tested due to lack of reproducer.
I don't know whether initializing only generation field is sufficient.
Please check before applying.

 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 6914cd8024ba..9c7bf0ef6a5f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4895,6 +4895,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	 */
 	btrfs_set_buffer_lockdep_class(lockdep_owner, buf, level);
 
+	btrfs_set_header_generation(buf, trans->transid);
 	__btrfs_tree_lock(buf, nest);
 	btrfs_clean_tree_block(buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
@@ -4905,7 +4906,6 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	memzero_extent_buffer(buf, 0, sizeof(struct btrfs_header));
 	btrfs_set_header_level(buf, level);
 	btrfs_set_header_bytenr(buf, buf->start);
-	btrfs_set_header_generation(buf, trans->transid);
 	btrfs_set_header_backref_rev(buf, BTRFS_MIXED_BACKREF_REV);
 	btrfs_set_header_owner(buf, owner);
 	write_extent_buffer_fsid(buf, fs_info->fs_devices->metadata_uuid);
-- 
2.18.4

