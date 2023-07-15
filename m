Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03471754862
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jul 2023 13:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjGOLI6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jul 2023 07:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjGOLI5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jul 2023 07:08:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D73BB5
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 04:08:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 384E021FC7
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 11:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689419335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jkFktFo7eqJQx6q/ybTPwwU26QLcaCQshKSDAoxvtxM=;
        b=U8ri88X4LphE9nf7ZqjN5xDcBvtSza+WyjmOlgNtVEowqEbPlNea6ouMUP9JFIWyAJzpfB
        D3MHhu54wKp5KUQ7sCoHBct5exdcmZQhqIbYcPTilNRNUUJ9kYz84TYfQe6DgeR46JzLXt
        qOcJaJfiNNznvsUu3p1uYTvXKspUtxU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B7DB133F7
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 11:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mJGyFEZ+smRcZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 11:08:54 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/8] btrfs: tests: add self tests for extent buffer memory operations
Date:   Sat, 15 Jul 2023 19:08:28 +0800
Message-ID: <950c5e69cce0f3def037e2373345b0fe6078bc85.1689418958.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689418958.git.wqu@suse.com>
References: <cover.1689418958.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new self tests would populate a memory range with random bytes, then
copy it to the extent buffer, so that we can verify if the extent buffer
memory operation and memmove()/memcopy() are resulting the same
contents.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tests/extent-io-tests.c | 147 +++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 3e625c558b0b..258b0dcffa62 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -648,6 +648,149 @@ static int test_find_first_clear_extent_bit(void)
 	return ret;
 }
 
+static void dump_eb_and_memory_contents(struct extent_buffer *eb, void *memory,
+					const char *test_name)
+{
+	for (int i = 0; i < eb->len; i++) {
+		struct page *page = eb->pages[i >> PAGE_SHIFT];
+		void *addr = page_address(page) + offset_in_page(i);
+
+		if (memcmp(addr, memory + i, 1)) {
+			test_err("%s failed", test_name);
+			test_err("eb and memory diffs at byte %u, eb has 0x%02x memory has 0x%02x",
+				 i, *(u8 *)addr, *(u8 *)(memory + i));
+			return;
+		}
+	}
+}
+
+static int verify_eb_and_memory(struct extent_buffer *eb, void *memory,
+				const char *test_name)
+{
+	int ret;
+
+	for (int i = 0; i < (eb->len >> PAGE_SHIFT); i++) {
+		void *eb_addr = page_address(eb->pages[i]);
+
+		ret = memcmp(memory + (i << PAGE_SHIFT), eb_addr, PAGE_SIZE);
+		if (ret) {
+			dump_eb_and_memory_contents(eb, memory, test_name);
+			return -EUCLEAN;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Init both memory and extent buffer contents to the same randomly generated
+ * contents.
+ */
+static void init_eb_and_memory(struct extent_buffer *eb, void *memory)
+{
+	get_random_bytes(memory, eb->len);
+	write_extent_buffer(eb, memory, 0, eb->len);
+}
+
+static int test_eb_mem_ops(u32 sectorsize, u32 nodesize)
+{
+	struct btrfs_fs_info *fs_info;
+	struct extent_buffer *eb = NULL;
+	void *memory = NULL;
+	int ret;
+
+	test_msg("running extent buffer memory operation tests");
+
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	if (!fs_info) {
+		test_std_err(TEST_ALLOC_FS_INFO);
+		return -ENOMEM;
+	}
+
+	memory = kvzalloc(nodesize, GFP_KERNEL);
+	if (!memory) {
+		test_err("failed to allocate memory");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	eb = __alloc_dummy_extent_buffer(fs_info, SZ_1M, nodesize);
+	if (!eb) {
+		test_std_err(TEST_ALLOC_EXTENT_BUFFER);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	init_eb_and_memory(eb, memory);
+	ret = verify_eb_and_memory(eb, memory, "full eb write");
+	if (ret < 0)
+		goto out;
+
+	memcpy(memory, memory + 16, 16);
+	memcpy_extent_buffer(eb, 0, 16, 16);
+	ret = verify_eb_and_memory(eb, memory, "same page non-overlapping memcpy 1");
+	if (ret < 0)
+		goto out;
+
+	memcpy(memory, memory + 2048, 16);
+	memcpy_extent_buffer(eb, 0, 2048, 16);
+	ret = verify_eb_and_memory(eb, memory, "same page non-overlapping memcpy 2");
+	if (ret < 0)
+		goto out;
+	memcpy(memory, memory + 2048, 2048);
+	memcpy_extent_buffer(eb, 0, 2048, 2048);
+	ret = verify_eb_and_memory(eb, memory, "same page non-overlapping memcpy 3");
+	if (ret < 0)
+		goto out;
+
+	memmove(memory + 512, memory + 256, 512);
+	memmove_extent_buffer(eb, 512, 256, 512);
+	ret = verify_eb_and_memory(eb, memory, "same page overlapping memcpy 1");
+	if (ret < 0)
+		goto out;
+
+	memmove(memory + 2048, memory + 512, 2048);
+	memmove_extent_buffer(eb, 2048, 512, 2048);
+	ret = verify_eb_and_memory(eb, memory, "same page overlapping memcpy 2");
+	if (ret < 0)
+		goto out;
+	memmove(memory + 512, memory + 2048, 2048);
+	memmove_extent_buffer(eb, 512, 2048, 2048);
+	ret = verify_eb_and_memory(eb, memory, "same page overlapping memcpy 3");
+	if (ret < 0)
+		goto out;
+
+	if (nodesize > PAGE_SIZE) {
+		memcpy(memory, memory + 4096 - 128, 256);
+		memcpy_extent_buffer(eb, 0, 4096 - 128, 256);
+		ret = verify_eb_and_memory(eb, memory, "cross page non-overlapping memcpy 1");
+		if (ret < 0)
+			goto out;
+
+		memcpy(memory + 4096 - 128, memory + 4096 + 128, 256);
+		memcpy_extent_buffer(eb, 4096 - 128, 4096 + 128, 256);
+		ret = verify_eb_and_memory(eb, memory, "cross page non-overlapping memcpy 2");
+		if (ret < 0)
+			goto out;
+
+		memmove(memory + 4096 - 128, memory + 4096 - 64, 256);
+		memmove_extent_buffer(eb, 4096 - 128, 4096 - 64, 256);
+		ret = verify_eb_and_memory(eb, memory, "cross page overlapping memcpy 1");
+		if (ret < 0)
+			goto out;
+
+		memmove(memory + 4096 - 64, memory + 4096 - 128, 256);
+		memmove_extent_buffer(eb, 4096 - 64, 4096 - 128, 256);
+		ret = verify_eb_and_memory(eb, memory, "cross page overlapping memcpy 2");
+		if (ret < 0)
+			goto out;
+	}
+out:
+	free_extent_buffer(eb);
+	kvfree(memory);
+	btrfs_free_dummy_fs_info(fs_info);
+	return ret;
+}
+
 int btrfs_test_extent_io(u32 sectorsize, u32 nodesize)
 {
 	int ret;
@@ -663,6 +806,10 @@ int btrfs_test_extent_io(u32 sectorsize, u32 nodesize)
 		goto out;
 
 	ret = test_eb_bitmaps(sectorsize, nodesize);
+	if (ret)
+		goto out;
+
+	ret = test_eb_mem_ops(sectorsize, nodesize);
 out:
 	return ret;
 }
-- 
2.41.0

