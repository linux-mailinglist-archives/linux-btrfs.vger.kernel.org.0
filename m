Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3156F3B08
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 01:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjEAXaA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 May 2023 19:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEAX37 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 May 2023 19:29:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719553584
        for <linux-btrfs@vger.kernel.org>; Mon,  1 May 2023 16:29:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1D89721F15
        for <linux-btrfs@vger.kernel.org>; Mon,  1 May 2023 23:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682983797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=t6mCiGRV9KFdM9DGh+DFgTa4o/u46RbwzwRtkC2iP6U=;
        b=f76r6xClJC36jToQ5GCk25VuB+wEzhRdc5kd/kXECHf8weiEi7YXFzsp2hauygGBEIN5w5
        Rp0pRG1ZqemiBgB3HL5SmlBwpMe82a3J8UJRO2tzbqPHvgGlUYG/Xx7KL1idXjkLb4C9g0
        tLqbtZaM8/jApyu5PEVjr+WgjzZLvAw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DEC713580
        for <linux-btrfs@vger.kernel.org>; Mon,  1 May 2023 23:29:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YtaGCHRLUGTYUwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 01 May 2023 23:29:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: doc: fix the indent on the ORPHAN_OBJECTID
Date:   Tue,  2 May 2023 07:29:37 +0800
Message-Id: <20230501232938.10544-1-wqu@suse.com>
X-Mailer: git-send-email 2.39.2
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

When compiling the documents, we have the following warning:

  ~/btrfs-progs/Documentation/dev/On-disk-format.rst:369: WARNING: Bullet list ends without a blank line; unexpected unindent.

It's caused by a mismatched indent, just fix it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/dev/On-disk-format.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev/On-disk-format.rst b/Documentation/dev/On-disk-format.rst
index 8cbbaf37..9e8a9f7e 100644
--- a/Documentation/dev/On-disk-format.rst
+++ b/Documentation/dev/On-disk-format.rst
@@ -366,8 +366,8 @@ is located in the ``ROOT_TREE`` and is of the following form.
 +-----------------------------------+
 
 -  There is no item body associated with this key. All required information is
-  contained within the key itself and the ``ROOT_ITEM`` associated with the
-  objectid contained in ``offset``
+   contained within the key itself and the ``ROOT_ITEM`` associated with the
+   objectid contained in ``offset``
 
 When the file system is mounted again after failure, the ``ROOT_TREE`` is
 searched for all orphan keys and the process is resumed for each one using the
-- 
2.39.0

