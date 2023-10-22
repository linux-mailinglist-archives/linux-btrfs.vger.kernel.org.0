Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFC57D20E0
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Oct 2023 05:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjJVDkh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Oct 2023 23:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVDkf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Oct 2023 23:40:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C838119
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Oct 2023 20:40:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AB8641FDC5
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Oct 2023 03:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697946030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OLuM71+LAmTLpVS8XwEQ1AInfmtYktUm2GHJrn4y7Qs=;
        b=Zpf4ELiO/rqWmY9a9yUSY+iSfJ2eMJu8jzOtaTR4zJB0fQqBsbC5vZSxQg82+NI5+vZlVx
        b1vIBTiCv1OuFo0KPQIqzxhBqhK3MX6tZhzLwUBj4SW6f+U66eAEUd7Pj4eBqeHr9QftUb
        LXlQhMWVKd40Z0Vx+MeoZuVHSIp7H5U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D84201348C
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Oct 2023 03:40:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6N65JK2ZNGVHZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Oct 2023 03:40:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: check/lowmem: verify the sequence of inline backref items
Date:   Sun, 22 Oct 2023 14:10:08 +1030
Message-ID: <0af53e129f107cb91b7ce3f6d22e6f83e4457e70.1697945679.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697945679.git.wqu@suse.com>
References: <cover.1697945679.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.81
X-Spamd-Result: default: False [0.81 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         RCPT_COUNT_ONE(0.00)[1];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.09)[64.17%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 6cf11f3e3815 ("btrfs-progs: check: check order of inline extent
refs") added the ability to detect out-of-order inline extent backref
items.

Meanwhile there is no such ability in lowmem mode, this patch would
introduce such ability to lowmem mode.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c | 31 +++++++++++++++++++++++++++++++
 check/mode-lowmem.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 3b2807cc5de9..19b7b1a72a1f 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4234,6 +4234,7 @@ static int check_extent_item(struct btrfs_path *path)
 	unsigned long ptr;
 	int slot = path->slots[0];
 	int type;
+	int last_type = 0;
 	u32 nodesize = btrfs_super_nodesize(gfs_info->super_copy);
 	u32 item_size = btrfs_item_size(eb, slot);
 	u64 flags;
@@ -4245,6 +4246,8 @@ static int check_extent_item(struct btrfs_path *path)
 	u64 owner;
 	u64 owner_offset;
 	u64 super_gen;
+	u64 seq;
+	u64 last_seq = U64_MAX;
 	int metadata = 0;
 	/* To handle corrupted values in skinny backref */
 	u64 level;
@@ -4342,6 +4345,32 @@ next:
 	iref = (struct btrfs_extent_inline_ref *)ptr;
 	type = btrfs_extent_inline_ref_type(eb, iref);
 	offset = btrfs_extent_inline_ref_offset(eb, iref);
+	if (type == BTRFS_EXTENT_DATA_REF_KEY) {
+		dref = (struct btrfs_extent_data_ref *)(&iref->offset);
+		seq = hash_extent_data_ref(
+				btrfs_extent_data_ref_root(eb, dref),
+				btrfs_extent_data_ref_objectid(eb, dref),
+				btrfs_extent_data_ref_offset(eb, dref));
+	} else {
+		seq = offset;
+	}
+	/*
+	 * The @type should be ascending, while inside the same type, the
+	 * @seq should be descending.
+	 */
+	if (type < last_type)
+		tmp_err |= BACKREF_OUT_OF_ORDER;
+	else if (type > last_type)
+		last_seq = U64_MAX;
+
+	if (seq > last_seq)
+		tmp_err |= BACKREF_OUT_OF_ORDER;
+
+	if (tmp_err & BACKREF_OUT_OF_ORDER)
+		error(
+"inline extent backref (type %u seq 0x%llx) of extent [%llu %u %llu] is out of order",
+		      type, seq, key.objectid, key.type, key.offset);
+
 	switch (type) {
 	case BTRFS_TREE_BLOCK_REF_KEY:
 		root_objectid = offset;
@@ -4420,6 +4449,8 @@ next:
 
 	err |= tmp_err;
 	ptr_offset += btrfs_extent_inline_ref_size(type);
+	last_type = type;
+	last_seq = seq;
 	goto next;
 
 out:
diff --git a/check/mode-lowmem.h b/check/mode-lowmem.h
index c3cf0878147f..3f84280a89f7 100644
--- a/check/mode-lowmem.h
+++ b/check/mode-lowmem.h
@@ -64,6 +64,7 @@
 #define UNKNOWN_TYPE		(1 << 6) /* Unknown type */
 #define ACCOUNTING_MISMATCH	(1 << 7) /* Used space accounting error */
 #define CHUNK_TYPE_MISMATCH	(1 << 8)
+#define BACKREF_OUT_OF_ORDER	(1 << 9)
 
 int check_fs_roots_lowmem(void);
 int check_chunks_and_extents_lowmem(void);
-- 
2.42.0

