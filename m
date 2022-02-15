Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DDB4B75DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 21:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241056AbiBORMu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 12:12:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiBORMt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 12:12:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382A1119F3C
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 09:12:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E916F21114
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 17:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644945157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=cARkHiWhJdOI8P3W7ncZYBto4k8u5MBLPm99/P2fp+Q=;
        b=FY7cyW1EJ60P38EN0xJhqC+un/R/QsJt+nLCCi9aTEhVtpTJpc94FLGCfJi1utXK/X3FZO
        ujkAOMm/AxLysWSFfK7WC3B6jETfVlPuo4Ysr6iBLN+23DEKBTQtm2AWug/p5D64jCf9/H
        FnYV61xHTCZtRUMAiHLqFm/lrKy5qtw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D128B13CA5
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 17:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ONyGMgXfC2JdAwAAMHmgww
        (envelope-from <ailiop@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 17:12:37 +0000
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: enable default zlib compression in btrfs-image
Date:   Tue, 15 Feb 2022 18:12:13 +0100
Message-Id: <20220215171213.5173-2-ailiop@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The btrfs-image utility supports zlib compression natively, but it is
disabled by default. Enable it at the zlib-defined default compression
level (6).

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 Documentation/btrfs-image.asciidoc | 2 +-
 Documentation/btrfs-image.rst      | 2 +-
 image/main.c                       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/btrfs-image.asciidoc b/Documentation/btrfs-image.asciidoc
index 382651712bef..fa3647a5bc05 100644
--- a/Documentation/btrfs-image.asciidoc
+++ b/Documentation/btrfs-image.asciidoc
@@ -30,7 +30,7 @@ restored by running tree log reply if possible. To restore without
 changing number of stripes in chunk tree check -o option.
 
 -c <value>::
-Compression level (0 ~ 9).
+Compression level (0 ~ 9). Defaults to zlib level 6.
 
 -t <value>::
 Number of threads (1 ~ 32) to be used to process the image dump or restore.
diff --git a/Documentation/btrfs-image.rst b/Documentation/btrfs-image.rst
index a7b200c1e7f9..67f4e7d49618 100644
--- a/Documentation/btrfs-image.rst
+++ b/Documentation/btrfs-image.rst
@@ -27,7 +27,7 @@ OPTIONS
         changing number of stripes in chunk tree check *-o* option.
 
 -c <value>
-        Compression level (0 ~ 9).
+        Compression level (0 ~ 9). Defaults to zlib level 6.
 
 -t <value>
         Number of threads (1 ~ 32) to be used to process the image dump or restore.
diff --git a/image/main.c b/image/main.c
index 3125163d1bfc..cbdf619d0b8c 100644
--- a/image/main.c
+++ b/image/main.c
@@ -3050,7 +3050,7 @@ int BOX_MAIN(image)(int argc, char *argv[])
 	char *source;
 	char *target;
 	u64 num_threads = 0;
-	u64 compress_level = 0;
+	u64 compress_level = 6;
 	int create = 1;
 	int old_restore = 0;
 	int walk_trees = 0;
-- 
2.35.1

