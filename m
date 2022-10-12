Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968835FC301
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Oct 2022 11:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJLJW6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Oct 2022 05:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJLJW4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Oct 2022 05:22:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029829DF96
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 02:22:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 463E81F37C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665566573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wDNo1QwOOVFe7PqU9xncD6DhTuV7qAw9jKqmMGL5mhw=;
        b=htF1m8IWvz/kCwHxtvN/XKjbpx/trmOkLRgyYrO8SyFhUJUGeeE4HueMCbCj3D4PyV2rHX
        G96OQ9d9YyHsguRAyd8+vYfTkEN6/9IBnPZGUfMuHxP+l0WjBN0eR8DquuGQ4YNMgTfmTN
        LtN/lHuJqY1OrQcfTnX4yih8/NlGtQs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87B2213A5C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:22:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u+ASFGyHRmObdgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:22:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: make btrfs module init/exit match their sequence
Date:   Wed, 12 Oct 2022 17:22:35 +0800
Message-Id: <679d22de5f137a32e97ffa5e7d5f5961f7a2b782.1665566176.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BACKGROUND]
In theory init_btrfs_fs() and exit_btrfs_fs() should match their
sequence, thus normally they should look like this:

    init_btrfs_fs()   |   exit_btrfs_fs()
----------------------+------------------------
    init_A();         |
    init_B();         |
    init_C();         |
                      |   exit_C();
                      |   exit_B();
                      |   exit_A();

So is for the error path of init_btrfs_fs().

But it's not the case, some exit functions don't match their init
functions sequence in init_btrfs_fs().

Furthermore in init_btrfs_fs(), we need to have a new error tag for each
new init function we added.
This is not really expandable, especially recently we may add several
new functions to init_btrfs_fs().

[ENHANCEMENT]
The patch will introduce the following things to enhance the situation:

- struct init_sequence
  Just a wrapper of init and exit function pointers.

  The init function must use int type as return value, thus some init
  functions need to be updated to return 0.

  The exit function can be NULL, as there are some init sequence just
  outputting a message.

- struct mod_init_seq[] array
  This is a const array, recording all the initialization we need to do
  in init_btrfs_fs(), and the order follows the old init_btrfs_fs().

  Only one modification in the order, now we call btrfs_print_mod_info()
  after sanity checks.
  As it makes no sense to print the mod into, and fail the sanity tests.

- bool mod_init_result[] array
  This is a bool array, recording if we have initialized one entry in
  mod_init_seq[].

  The reason to split mod_init_seq[] and mod_init_result[] is to avoid
  section mismatch in reference.

  All init function are in .init.text, but if mod_init_seq[] records
  the @initialized member it can no longer be const, thus will be put
  into .data section, and cause modpost warning.

For init_btrfs_fs() we just call all init functions in their order in
mod_init_seq[] array, and after each call, setting corresponding
mod_init_result[] to true.

For exit_btrfs_fs() and error handling path of init_btrfs_fs(), we just
iterate mod_init_seq[] in reverse order, and skip all uninitialized
entry.

With this patch, init_btrfs_fs()/exit_btrfs_fs() will be much easier to
expand and will always follow the strict order.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
RFC->v1:
- Change the mod_init_seq[] array to static const

v1->v2:
- Rebased to latest misc-next to handle new init/exit entries
---
 fs/btrfs/compression.c |   3 +-
 fs/btrfs/compression.h |   2 +-
 fs/btrfs/props.c       |   3 +-
 fs/btrfs/props.h       |   2 +-
 fs/btrfs/super.c       | 242 ++++++++++++++++++++---------------------
 5 files changed, 122 insertions(+), 130 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 54caa00a2245..8d3e3218fe37 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1232,12 +1232,13 @@ int btrfs_decompress(int type, unsigned char *data_in, struct page *dest_page,
 	return ret;
 }
 
-void __init btrfs_init_compress(void)
+int __init btrfs_init_compress(void)
 {
 	btrfs_init_workspace_manager(BTRFS_COMPRESS_NONE);
 	btrfs_init_workspace_manager(BTRFS_COMPRESS_ZLIB);
 	btrfs_init_workspace_manager(BTRFS_COMPRESS_LZO);
 	zstd_init_workspace_manager();
+	return 0;
 }
 
 void __cold btrfs_exit_compress(void)
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 1aa02903de69..9da2343eeff5 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -77,7 +77,7 @@ static inline unsigned int btrfs_compress_level(unsigned int type_level)
 	return ((type_level & 0xF0) >> 4);
 }
 
-void __init btrfs_init_compress(void);
+int __init btrfs_init_compress(void);
 void __cold btrfs_exit_compress(void);
 
 int btrfs_compress_pages(unsigned int type_level, struct address_space *mapping,
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index 07f62e3ba6a5..e04289347775 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -454,7 +454,7 @@ int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-void __init btrfs_props_init(void)
+int __init btrfs_props_init(void)
 {
 	int i;
 
@@ -464,5 +464,6 @@ void __init btrfs_props_init(void)
 
 		hash_add(prop_handlers_ht, &p->node, h);
 	}
+	return 0;
 }
 
diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
index ca9dd3df129b..6e283196e38a 100644
--- a/fs/btrfs/props.h
+++ b/fs/btrfs/props.h
@@ -8,7 +8,7 @@
 
 #include "ctree.h"
 
-void __init btrfs_props_init(void);
+int __init btrfs_props_init(void);
 
 int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
 		   const char *name, const char *value, size_t value_len,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index c25220bae232..57125735de61 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2690,7 +2690,7 @@ static __cold void btrfs_interface_exit(void)
 	misc_deregister(&btrfs_misc);
 }
 
-static void __init btrfs_print_mod_info(void)
+static int __init btrfs_print_mod_info(void)
 {
 	static const char options[] = ""
 #ifdef CONFIG_BTRFS_DEBUG
@@ -2717,143 +2717,133 @@ static void __init btrfs_print_mod_info(void)
 #endif
 			;
 	pr_info("Btrfs loaded, crc32c=%s%s\n", crc32c_impl(), options);
+	return 0;
 }
 
-static int __init init_btrfs_fs(void)
+static int register_btrfs(void)
 {
-	int err;
-
-	btrfs_props_init();
-
-	err = btrfs_init_sysfs();
-	if (err)
-		return err;
-
-	btrfs_init_compress();
-
-	err = btrfs_init_cachep();
-	if (err)
-		goto free_compress;
-
-	err = btrfs_transaction_init();
-	if (err)
-		goto free_cachep;
-
-	err = btrfs_ctree_init();
-	if (err)
-		goto free_transaction;
-
-	err = btrfs_free_space_init();
-	if (err)
-		goto free_ctree;
-
-	err = extent_state_init_cachep();
-	if (err)
-		goto free_free_space;
-
-	err = extent_buffer_init_cachep();
-	if (err)
-		goto free_extent_cachep;
-
-	err = btrfs_bioset_init();
-	if (err)
-		goto free_eb_cachep;
-
-	err = extent_map_init();
-	if (err)
-		goto free_bioset;
-
-	err = ordered_data_init();
-	if (err)
-		goto free_extent_map;
-
-	err = btrfs_delayed_inode_init();
-	if (err)
-		goto free_ordered_data;
-
-	err = btrfs_auto_defrag_init();
-	if (err)
-		goto free_delayed_inode;
-
-	err = btrfs_delayed_ref_init();
-	if (err)
-		goto free_auto_defrag;
-
-	err = btrfs_prelim_ref_init();
-	if (err)
-		goto free_delayed_ref;
-
-	err = btrfs_interface_init();
-	if (err)
-		goto free_prelim_ref;
+	return register_filesystem(&btrfs_fs_type);
+}
 
-	btrfs_print_mod_info();
+static void unregister_btrfs(void)
+{
+	unregister_filesystem(&btrfs_fs_type);
+}
 
-	err = btrfs_run_sanity_tests();
-	if (err)
-		goto unregister_ioctl;
+/* Helper structure for long init/exit functions. */
+struct init_sequence {
+	int (*init_func)(void);
+	/* Can be NULL if the init_func doesn't need cleanup. */
+	void (*exit_func)(void);
+};
 
-	err = register_filesystem(&btrfs_fs_type);
-	if (err)
-		goto unregister_ioctl;
+static const struct init_sequence mod_init_seq[] = {
+	{
+		.init_func = btrfs_props_init,
+		.exit_func = NULL,
+	}, {
+		.init_func = btrfs_init_sysfs,
+		.exit_func = btrfs_exit_sysfs,
+	}, {
+		.init_func = btrfs_init_compress,
+		.exit_func = btrfs_exit_compress,
+	}, {
+		.init_func = btrfs_init_cachep,
+		.exit_func = btrfs_destroy_cachep,
+	}, {
+		.init_func = btrfs_transaction_init,
+		.exit_func = btrfs_transaction_exit,
+	}, {
+		.init_func = btrfs_ctree_init,
+		.exit_func = btrfs_ctree_exit,
+	}, {
+		.init_func = btrfs_free_space_init,
+		.exit_func = btrfs_free_space_exit,
+	}, {
+		.init_func = extent_state_init_cachep,
+		.exit_func = extent_state_free_cachep,
+	}, {
+		.init_func = extent_buffer_init_cachep,
+		.exit_func = extent_buffer_free_cachep,
+	}, {
+		.init_func = btrfs_bioset_init,
+		.exit_func = btrfs_bioset_exit,
+	}, {
+		.init_func = extent_map_init,
+		.exit_func = extent_map_exit,
+	}, {
+		.init_func = ordered_data_init,
+		.exit_func = ordered_data_exit,
+	}, {
+		.init_func = btrfs_delayed_inode_init,
+		.exit_func = btrfs_delayed_inode_exit,
+	}, {
+		.init_func = btrfs_auto_defrag_init,
+		.exit_func = btrfs_auto_defrag_exit,
+	}, {
+		.init_func = btrfs_delayed_ref_init,
+		.exit_func = btrfs_delayed_ref_exit,
+	}, {
+		.init_func = btrfs_prelim_ref_init,
+		.exit_func = btrfs_prelim_ref_exit,
+	}, {
+		.init_func = btrfs_interface_init,
+		.exit_func = btrfs_interface_exit,
+	}, {
+		.init_func = btrfs_run_sanity_tests,
+		.exit_func = NULL,
+	}, {
+		.init_func = btrfs_print_mod_info,
+		.exit_func = NULL,
+	}, {
+		.init_func = register_btrfs,
+		.exit_func = unregister_btrfs,
+	}
+};
 
-	return 0;
+static bool mod_init_result[ARRAY_SIZE(mod_init_seq)];
 
-unregister_ioctl:
-	btrfs_interface_exit();
-free_prelim_ref:
-	btrfs_prelim_ref_exit();
-free_delayed_ref:
-	btrfs_delayed_ref_exit();
-free_auto_defrag:
-	btrfs_auto_defrag_exit();
-free_delayed_inode:
-	btrfs_delayed_inode_exit();
-free_ordered_data:
-	ordered_data_exit();
-free_extent_map:
-	extent_map_exit();
-free_bioset:
-	btrfs_bioset_exit();
-free_eb_cachep:
-	extent_buffer_free_cachep();
-free_extent_cachep:
-	extent_state_free_cachep();
-free_free_space:
-	btrfs_free_space_exit();
-free_ctree:
-	btrfs_ctree_exit();
-free_transaction:
-	btrfs_transaction_exit();
-free_cachep:
-	btrfs_destroy_cachep();
-free_compress:
-	btrfs_exit_compress();
-	btrfs_exit_sysfs();
+static void __exit exit_btrfs_fs(void)
+{
+	int i;
 
-	return err;
+	for (i = ARRAY_SIZE(mod_init_seq) - 1; i >= 0; i--) {
+		if (!mod_init_result[i])
+			continue;
+		if (mod_init_seq[i].exit_func)
+			mod_init_seq[i].exit_func();
+		mod_init_result[i] = false;
+	}
 }
 
-static void __exit exit_btrfs_fs(void)
+static int __init init_btrfs_fs(void)
 {
-	btrfs_free_space_exit();
-	btrfs_ctree_exit();
-	btrfs_transaction_exit();
-	btrfs_destroy_cachep();
-	btrfs_delayed_ref_exit();
-	btrfs_auto_defrag_exit();
-	btrfs_delayed_inode_exit();
-	btrfs_prelim_ref_exit();
-	ordered_data_exit();
-	extent_map_exit();
-	btrfs_bioset_exit();
-	extent_state_free_cachep();
-	extent_buffer_free_cachep();
-	btrfs_interface_exit();
-	unregister_filesystem(&btrfs_fs_type);
-	btrfs_exit_sysfs();
-	btrfs_cleanup_fs_uuids();
-	btrfs_exit_compress();
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mod_init_seq); i++) {
+		ASSERT(!mod_init_result[i]);
+		ret = mod_init_seq[i].init_func();
+		if (ret < 0)
+			goto error;
+		mod_init_result[i] = true;
+	}
+	return 0;
+
+error:
+	/*
+	 * If we call exit_btrfs_fs() it would cause section mismatch.
+	 * As init_btrfs_fs() belongs to .init.text, while exit_btrfs_fs()
+	 * belongs to .exit.text.
+	 */
+	for (i = ARRAY_SIZE(mod_init_seq) - 1; i >= 0; i--) {
+		if (!mod_init_result[i])
+			continue;
+		if (mod_init_seq[i].exit_func)
+			mod_init_seq[i].exit_func();
+		mod_init_result[i] = false;
+	}
+	return ret;
 }
 
 late_initcall(init_btrfs_fs);
-- 
2.37.3

