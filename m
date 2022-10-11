Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1259C5FB35B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 15:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJKNX7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 09:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJKNX0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 09:23:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9458A1FC;
        Tue, 11 Oct 2022 06:23:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EFE791F923;
        Tue, 11 Oct 2022 13:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665494584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=WEuTqwKGnR6JzojLJtw4CopPwGWNSDkvEdTVJG+8hvk=;
        b=MHIgnCOtE9soyeJ5NzGxfGnOfAe2+s+CibreCjkkPe7iSJ9DwDrG0UxKAj4Y0Leq0ZpbAg
        lCHLU/804Vh0TcDzdr0xDjVeN4iQD4+5YAdc59YVnT8DQ3EQC7gYQe3mXfYgLNITh6FdDW
        iLeRLVq4+z32PVK14ZnU6dpLnET+1p4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E6EB92C141;
        Tue, 11 Oct 2022 13:23:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3473ADA79D; Tue, 11 Oct 2022 15:22:59 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: [PATCH] MAINTAINERS: update btrfs website links and files
Date:   Tue, 11 Oct 2022 15:22:56 +0200
Message-Id: <20221011132256.333-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have the new documentation hosted on Read The Docs and content is
migrated there from the wiki. Also update http to https and add the
tracepoint definition header.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5ca4aefd184..5ec615e817be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4428,13 +4428,15 @@ M:	Josef Bacik <josef@toxicpanda.com>
 M:	David Sterba <dsterba@suse.com>
 L:	linux-btrfs@vger.kernel.org
 S:	Maintained
-W:	http://btrfs.wiki.kernel.org/
-Q:	http://patchwork.kernel.org/project/linux-btrfs/list/
+W:	https://btrfs.readthedocs.io
+W:	https://btrfs.wiki.kernel.org/
+Q:	https://patchwork.kernel.org/project/linux-btrfs/list/
 C:	irc://irc.libera.chat/btrfs
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git
 F:	Documentation/filesystems/btrfs.rst
 F:	fs/btrfs/
 F:	include/linux/btrfs*
+F:	include/trace/events/btrfs.h
 F:	include/uapi/linux/btrfs*
 
 BTTV VIDEO4LINUX DRIVER
-- 
2.37.3

