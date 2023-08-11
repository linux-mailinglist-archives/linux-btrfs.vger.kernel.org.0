Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6CF778737
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 08:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjHKGAp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 02:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHKGAn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 02:00:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70FC2722
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 23:00:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 69B6B1F88E
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 06:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691733640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=r1i8s42x9LvyC7zNGH7qxlmLVcmil+F0G/SF+785vd0=;
        b=gSMI4Vmg52AsRl2MOznellImQqDPoxlUJ7LMLgiqILlijjWylaHjbmrdqbU7OJuDlVL0P6
        1Rzg4vxlGPHxLEsY5lLez60UX7nueSKpCDJFSKgvfs79G97hlRcSXl+zv2IVoVF3f2ZpjL
        UP5R5OWG1LtWrOe9FihuL9UeFjZMdmw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A42E513592
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 06:00:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AKFFGYfO1WQfRQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 06:00:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: doc/dev: enhance the error handling guideline
Date:   Fri, 11 Aug 2023 14:00:28 +0800
Message-ID: <21bde19678039301b4806072e72b499085d0b40d.1691733623.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we only have a very brief explanation on the unexpected error
handling (only ASSERT()/WARN_ON()/BUG_ON()), and no further
recommendation on the proper usage of them.

This patch would improve the guideline by:

- Add btrfs_abort_transaction() usage
  Which is the recommended way when possible.

- More detailed explanation on the usage of ASSERT()
  Which is only a fail-fast option mostly designed for developers, thus
  is only recommended to rule out some invalid function usage.

- More detailed explanation on the usage of WARN_ON()
  Mostly for call sites which need a call trace strongly, and is not
  applicable for a btrfs_abort_transaction() call.

- Completely discourage the usage of BUG_ON()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/dev/Development-notes.rst | 55 +++++++++++++++++++++----
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/Documentation/dev/Development-notes.rst b/Documentation/dev/Development-notes.rst
index 9baef6b80220..20028be1e4be 100644
--- a/Documentation/dev/Development-notes.rst
+++ b/Documentation/dev/Development-notes.rst
@@ -112,15 +112,52 @@ nuclear option and do BUG_ON, that is otherwise highly discouraged.
 
 There are several ways how to react to the unexpected conditions:
 
--  ASSERT -- conditionally compiled in and crashes when the condition is false,
-   this is supposed to catch 'must never happen' at the time of development,
-   code must not continue
--  WARN_ON -- light check that is visible in the log and allows the code to
-   continue but the reasons must be investigated
--  BUG_ON -- last resort, checks condition that 'must never happen' and
-   continuing would cause more harm than the instant crash; code should always
-   try to avoid using it, but there are cases when sanity and invariant checks
-   are done in advance
+-  btrfs_abort_transaction()
+
+   The recommended way if and only if we can not recover from the situation and
+   have a transaction handle.
+
+   This would cause the filesystem to be flipped read-only to prevent further
+   corruption.
+
+   Additionally call trace would be dumpped for the first btrfs_abort_transaction()
+   call site.
+
+-  ASSERT()
+
+   Conditionally compiled in and crashes when the condition is false.
+
+   This should only be utilized for debugging purpose, acts as a fail-fast
+   option for developers, thus should not be utilized for error handling.
+
+   It's recommended only for very basic (thus sometimes unnecessary) requirements.
+   Such usage should be easy to locate, have no complex call chain.
+   E.g. to rule out invalid function parameter combinations.
+
+   Should not be utilized on any data/metadata read from disks, as they can be
+   invalid. For sanity check examples of on-disk metadata, please refer to
+   `Tree checker`.
+
+-  WARN_ON
+
+   Unconditional and noisy checks, but still allows the code to continue.
+
+   Should only be utilized if a call trace is critical for debugging.
+
+   Not recommended if:
+   * The call site is unique or can be easily located
+
+     In that case, an error message is recommended.
+
+   * The call site would eventually lead to a btrfs_abort_transaction() call
+
+     btrfs_abort_transaction() call would dump the stack anyway.
+     If the call trace is critical, it's recommended to move the
+     btrfs_abort_transaction() call closer to the error scene.
+
+-  BUG_ON
+
+   Should not be utilized, and would be faded out during development.
 
 Error injection using eBPF
 --------------------------
-- 
2.41.0

