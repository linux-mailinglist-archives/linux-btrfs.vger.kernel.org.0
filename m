Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC0D52B1B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 07:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiERFDf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 01:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiERFDa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 01:03:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1598D4D9C3
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 22:03:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 341DA21B33
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 05:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652850207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rAjCxea0mo6sMrjkH9v77lN5j+9J0y/CH53WLNf8KgA=;
        b=uFk5kqfHSmUmo9SZ6KmHvZohtxIg9o7GWYL4+5oemySzShewIZVBg2DQ87ETiRYZ2pQ+SA
        lwvyP2wbBADoe9iHRuBVigHUt+N81nPdcntMQFSLFUZecyjWwDUp3L42iIoYIvdIZh6BRV
        VraB6TeurLSAQ2+rVFz1jJ702yKhnNM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BAB613491
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 05:03:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qVdiFR5+hGKeGAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 05:03:26 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: prevent remounting to v1 space cache for subpage mount
Date:   Wed, 18 May 2022 13:03:09 +0800
Message-Id: <141ea1f29543c7eccabc3899f34b691a13841a5a.1652850165.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
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

Upstream commit 9f73f1aef98b ("btrfs: force v2 space cache usage for
subpage mount") forces subpage mount to use v2 cache, to avoid
deprecated v1 cache which doesn't support subpage properly.

But there is a loophole that user can still remount to v1 cache.

The existing check will only give users a warning, but not really
prevents the users to do the remount.

Although remounting to v1 will not cause any problems since the v1 cache
will always be marked invalid when mounted with a different page size,
it's still better to prevent v1 cache at all for subpage mounts.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Assigned @ret to -EINVAL before going restore tag.
---
 fs/btrfs/super.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b1fdc6a26c76..aab8831119d1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1985,6 +1985,15 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	if (ret)
 		goto restore;
 
+	/* V1 cache is not supported for subpage mount. */
+	if (fs_info->sectorsize < PAGE_SIZE &&
+	    btrfs_test_opt(fs_info, SPACE_CACHE)) {
+		btrfs_warn(fs_info,
+	"v1 space cache is not supported for page size %lu with sectorsize %u",
+			   PAGE_SIZE, fs_info->sectorsize);
+		ret = -EINVAL;
+		goto restore;
+	}
 	btrfs_remount_begin(fs_info, old_opts, *flags);
 	btrfs_resize_thread_pool(fs_info,
 		fs_info->thread_pool_size, old_thread_pool_size);
-- 
2.36.1

