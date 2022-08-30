Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2C5A5AF1
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 06:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiH3E5k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 00:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiH3E5i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 00:57:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BC4AB42E
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Aug 2022 21:57:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0338521D71
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 04:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661835455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gS+bn0UBl8Q0oEHoDI0XZue5V6LhCkFUzy8e7xspGxc=;
        b=r01kjxOq/jZ5ngWpvmmGpGMiP+R7LzdZTX89+vb/CRBOCFUy/QPLfNvlmnPGLT9f0Pubz2
        9rm5VsK1GYin8DXJd22RYxK6O7TiDHyyzLLCuSvUPw6gGl6YqkheS1npGuk/V//q/Vet1Y
        1dqzVF9UsH73n3MCJL2sE8OCQ5tAE4k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5630513ACF
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 04:57:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id agw7CL6YDWO7BAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 04:57:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: fix eb leakage caused by missing btrfs_release_path() call.
Date:   Tue, 30 Aug 2022 12:57:16 +0800
Message-Id: <043f1db2c7548723eaff302ebba4183afb910830.1661835430.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Commit 06b6ad5e017e ("btrfs-progs: check: check for invalid free space
tree entries") makes btrfs check to report eb leakage even on newly
created btrfs:

 # mkfs.btrfs -f test.img
 # btrfs check test.img
  Opening filesystem to check...
  Checking filesystem on test.img
  UUID: 13c26b6a-3b2c-49b3-94c7-80bcfa4e494b
  [1/7] checking root items
  [2/7] checking extents
  [3/7] checking free space tree
  [4/7] checking fs roots
  [5/7] checking only csums items (without verifying data)
  [6/7] checking root refs
  [7/7] checking quota groups skipped (not enabled on this FS)
  found 147456 bytes used, no error found
  total csum bytes: 0
  total tree bytes: 147456
  total fs tree bytes: 32768
  total extent tree bytes: 16384
  btree space waste bytes: 140595
  file data blocks allocated: 0
   referenced 0
  extent buffer leak: start 30572544 len 16384 <<< Extent buffer leakage

[CAUSE]
Surprisingly the patch submitted to the mailing list is correct:

+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	while (1) {
...
+		if (ret < 0)
+			goto out;
+		if (path->slots[0] >= btrfs_header_nritems(path->nodes[0]))
+			break;
...
+	}
+	ret = 0;
+out:
+	btrfs_free_path(path);
+	return ret;
+}

So no matter if it's an error or we exhausted the free space tree, the
path will be released and freed eventually.

But the commit merged into btrfs-progs goes on-stack path method:

+       btrfs_init_path(&path);
+
+       while (1) {
...
+               if (ret < 0)
+                       goto out;
+               if (path.slots[0] >= btrfs_header_nritems(path.nodes[0]))
+                       break;
+
+               btrfs_release_path(&path);
...
+       }
+       ret = 0;
+out:
+       return ret;
+}
+

Now we only release the path inside the while loop, no at out tag.
This means, if we hit error or even just exhausted free space tree as
expected, we will leak the path to free space tree root.

Thus leading to the above leakage report.

[FIX]
Fix the bug by calling btrfs_release_path() at out: tag too.

This should make the code behave the same as the patch submitted to the
mailing list.

Fixes: 06b6ad5e017e ("btrfs-progs: check: check for invalid free space tree entries")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/check/main.c b/check/main.c
index 0ba38f73c0a4..0c5716a51ad1 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5776,6 +5776,7 @@ static int check_free_space_tree(struct btrfs_root *root)
 	}
 	ret = 0;
 out:
+	btrfs_release_path(&path);
 	return ret;
 }
 
-- 
2.37.2

