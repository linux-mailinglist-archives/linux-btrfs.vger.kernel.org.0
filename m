Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42295511244
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 09:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358698AbiD0HWc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 03:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357783AbiD0HWa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 03:22:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD2F5DA5C
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 00:19:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B5C421F747
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651043958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sZHUfL2KXkbIrlO9qOF/yFbkAntyM39BzRMfgF0zv/8=;
        b=V4ljbmICUPV/88hWsf0mZGCmM+NrC3EUGE4rS5+OprwMOFD+1tkl1VtFb6WhjEVfJBRsMu
        qmreXqMaMXsglAgp/QTqcVgf9245BHanXhyWSDGnD5LpDn1EwsarTN0OBmJsvmcy2qymBl
        GuEIlXiSSYJC9j8tBL35iTxg6+kMink=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0517813A39
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EM7ZLnXuaGIbJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2 02/12] btrfs: always save bio::bi_iter into btrfs_bio::iter before submitting
Date:   Wed, 27 Apr 2022 15:18:48 +0800
Message-Id: <b11499d578ab90258d83ec9be6d46df78c1056bf.1651043617.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <cover.1651043617.git.wqu@suse.com>
References: <cover.1651043617.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Lower level bio mapping, from driver to dm, even btrfs chunk mapping
can modify bio::bi_iter.

This prevents us from doing two things:

- Iterate the bio range of a cloned bio
  This is only utilized by direct IO, thus it's already using
  btrfs_bio::iter, which is populated in btrfs_bio_clone_partial().

- Grab the original logical bytenr of a bio
  This will be utilized by incoming read repair patches.

So to make sure all btrfs_bio submitted to own a proper iter, this patch
will assigned btrfs_bio::iter in the following call sites:

- btrfs_submit_dio_bio()
- submit_one_bio()
- submit_compressed_bio()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 2 ++
 fs/btrfs/extent_io.c   | 6 ++++++
 fs/btrfs/inode.c       | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 69c060dc024c..559bf53beaed 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -428,6 +428,8 @@ static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
 	blk_status_t ret;
 
 	ASSERT(bio->bi_iter.bi_size);
+	/* Check submit_one_bio() for the reason */
+	btrfs_bio(bio)->iter = bio->bi_iter;
 	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
 	if (ret)
 		return ret;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 07888cce3bce..a3962df30603 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -186,6 +186,12 @@ static void submit_one_bio(struct bio *bio, int mirror_num, unsigned long bio_fl
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bio->bi_iter.bi_size);
 
+	/*
+	 * Save current bi_iter into btrfs_bio::iter, as lower level (including
+	 * btrfs chunk mapping) can modify bi_iter, preventing us from using
+	 * bi_iter to iterate cloned bio or grab the original logical bytenr.
+	 */
+	btrfs_bio(bio)->iter = bio->bi_iter;
 	if (is_data_inode(tree->private_data))
 		btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
 					    bio_flags);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b4cfd78f50e8..1b596de0c4e9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7923,6 +7923,8 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 	bool write = btrfs_op(bio) == BTRFS_MAP_WRITE;
 	blk_status_t ret;
 
+	btrfs_bio(bio)->iter = bio->bi_iter;
+
 	/* Check btrfs_submit_bio_hook() for rules about async submit. */
 	if (async_submit)
 		async_submit = !atomic_read(&BTRFS_I(inode)->sync_writers);
-- 
2.36.0

