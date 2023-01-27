Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C02E67DD2E
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 06:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjA0Flq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 00:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjA0Flo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 00:41:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36623721D1
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 21:41:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED3D21FF5F
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674798100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CpIZgtGzaQZ5PCJtGuXbLfblmSGTOwDexI9nsq3zou4=;
        b=tlhz1UMX3shsrMkjL/12P4k7oDrVnmGXp8xSwLGdbxJB32DN9xbVM39OpANkV0JXNBY/si
        Z6x7eXQPjd7bOw7J3eKD7jMeZshPwEl74befHaTPicfLwzRjG3TgJaaKGEJ8KtfRDIDxs0
        hSMhcgju5VU5U5mSjqbwVfOKu6G3a9Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CBF0134F5
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YKUmBhRk02OnLwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 05:41:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs-progs: move a union with variable sized type to the end
Date:   Fri, 27 Jan 2023 13:41:17 +0800
Message-Id: <34378b3e8906ca7e24f981caf7296087767510ac.1674797823.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674797823.git.wqu@suse.com>
References: <cover.1674797823.git.wqu@suse.com>
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

[WARNING]
Clang 15.0.7 gives the following warning:

  image/main.c:95:2: warning: field '' with variable sized type 'union metadump_struct::(anonymous at image/main.c:95:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
          union {
          ^

[CAUSE]
The union contains meta_cluster, which variable sized:

  struct meta_cluster {
  	struct meta_cluster_header header;
  	struct meta_cluster_item items[];
  } __attribute__ ((__packed__));

Thus clang gives above warning since it's a GNU extension.

[FIX]
Just move the union to the end of the structure.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/image/main.c b/image/main.c
index ecf464e5b0a2..d4a1fe349d31 100644
--- a/image/main.c
+++ b/image/main.c
@@ -92,11 +92,6 @@ struct metadump_struct {
 	struct btrfs_root *root;
 	FILE *out;
 
-	union {
-		struct meta_cluster cluster;
-		char meta_cluster_bytes[IMAGE_BLOCK_SIZE];
-	};
-
 	pthread_t threads[MAX_WORKER_THREADS];
 	size_t num_threads;
 	pthread_mutex_t mutex;
@@ -119,6 +114,11 @@ struct metadump_struct {
 	enum sanitize_mode sanitize_names;
 
 	int error;
+
+	union {
+		struct meta_cluster cluster;
+		char meta_cluster_bytes[IMAGE_BLOCK_SIZE];
+	};
 };
 
 struct mdrestore_struct {
-- 
2.39.1

