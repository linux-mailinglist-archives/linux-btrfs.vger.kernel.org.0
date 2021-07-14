Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118163C7E62
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 08:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbhGNGOM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 02:14:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56600 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbhGNGOL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 02:14:11 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5471322769
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 06:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626243078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=FkDutLZ9AL3RkN5GIwaPTaw1aMPNnotOJFkOTbsN760=;
        b=p7qziTDMZabOFkcdWgpXAQzcAhvpFgvtAswqdTY9nPzlcGdgf4+aZAdQ+BooZ1ak0RIzid
        YT4kNfZOQGMB9fVvkX8DVJHVqmbSmdiL39c/Rpu1LMdbHmZpE5v17vJuyMYZ4Ww5YEE/cU
        xf0gMpVmVAycqkz6ByRr9j1x3M7v91Q=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8518B13653
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 06:11:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id sZzREAWA7mBlUgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 06:11:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: doc: fix the out-of-date contents on btrfs-progs support on free space cache tree
Date:   Wed, 14 Jul 2021 14:11:14 +0800
Message-Id: <20210714061114.189575-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since v4.19, btrfs-progs has full write support to free space tree, the
out-of-date warning in btrfs(5) has already confused some end user.

Update the content to avoid further confusion.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-man5.asciidoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/btrfs-man5.asciidoc b/Documentation/btrfs-man5.asciidoc
index 806ac786c3c4..813a9fb08d6e 100644
--- a/Documentation/btrfs-man5.asciidoc
+++ b/Documentation/btrfs-man5.asciidoc
@@ -385,10 +385,10 @@ implementation, which adds a new B-tree called the free space tree, addresses
 this issue. Once enabled, the 'v2' space cache will always be used and cannot
 be disabled unless it is cleared. Use 'clear_cache,space_cache=v1' or
 'clear_cache,nospace_cache' to do so. If 'v2' is enabled, kernels without 'v2'
-support will only be able to mount the filesystem in read-only mode. The
-`btrfs`(8) command currently only has read-only support for 'v2'. A read-write
-command may be run on a 'v2' filesystem by clearing the cache, running the
-command, and then remounting with 'space_cache=v2'.
+support will only be able to mount the filesystem in read-only mode.
++
+The `btrfs-check`(8) and `mkfs.btrfs`(8) commands have full 'v2' free space
+cache support since v4.19.
 +
 If a version is not explicitly specified, the default implementation will be
 chosen, which is 'v1'.
-- 
2.32.0

