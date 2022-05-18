Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6EB52B1F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 07:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiERFiM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 01:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiERFiL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 01:38:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F342FE4B
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 22:38:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E1CCC1F390
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 05:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652852288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zUwmwdyCcCbUN/Ygi7PylvW/lExKAx9LLDO+kUZ63rU=;
        b=NQCTpbwSFwrw3XQhJyzuc7chZ5tQ0ngYb2CqFHwUV7OxqZwE/KFvV044YO1D1ro80NpXM9
        NrOfr/7T/XygR0zsnLP5wm94LSOFceiSxJ7FJ9QGoIUp44IY0pO0xNQAuB225zydZPJGXX
        2TrIxeqpwc5by8phqlxgbVOvE5O3Log=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B19013491
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 05:38:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id phs3AkCGhGKMIwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 05:38:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: doc: add more explanation on subapge limits
Date:   Wed, 18 May 2022 13:37:50 +0800
Message-Id: <6c11754df4341351769a0da4eaac8939aa82b700.1652852267.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
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

The current subpage support in v5.18 has several limits, the most
obvious ones are:

- Only support 64KiB page size
- No RAID56 support

The supports are already queued for v5.19.

And some minor ones:

- No inline extent write support
  Read is always supported.
  Subpage mount will always just act as "max_inline=0".

- Compression write is only for page aligned range.
  Read is always supported, no matter the alignment.

- Extra memory usage for scrub
  Patchset is hanging there for a while though.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/Subpage.rst | 59 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/Documentation/Subpage.rst b/Documentation/Subpage.rst
index 0aadf3c00b98..1f56b35f2e04 100644
--- a/Documentation/Subpage.rst
+++ b/Documentation/Subpage.rst
@@ -6,6 +6,59 @@ using a filesystem that has different size of data block size (*sectorsize*)
 and the host CPU page size. For easier implementation the support was limited
 to the exactly same size of the block and page. On x86_64 this is typically
 4KiB, but there are other architectures commonly used that make use of larger
-pages, like 64KiB on 64bit ARM or PowerPC. A filesystem created on one cannot
-be mounted on the other.  The subpage support is still work in progress in 5.18
-but the support is incrementally added with each release.
+pages, like 64KiB on 64bit ARM or PowerPC.  This means filesystems created
+with 64KiB sector size can not be mounted on system with 4KiB page size.
+
+While with subpage support, systems with 64KiB page size can create (still needs
+"-s 4k" option for mkfs.btrfs) and mount filesystems with 4KiB sectorsize,
+allowing us to push 4KiB sectorsize as default sectorsize for all platforms in the
+near-future.
+
+
+Requirements, limitations
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The subpage support is initially added in v5.15, although it's still
+considered as experimental at the time of writing (v5.18), most features are
+already working without problems.
+
+End users can mount filesystems with 4KiB sectorsize and do their usual
+workload, while should not notice any obvious change, as long as the initial
+mount succeeded (there are cases btrfs will reject the subpage mount though).
+
+The following features has some limitations for subpage:
+
+- RAID56 support
+  This support is already queued for v5.19 cycle.
+  Any fs with RAID56 chunks will be rejected at mount time for now.
+
+- Support for page size other than 64KiB
+  The support for other page sizes (16KiB, 32KiB and more) are already queued
+  for v5.19 cycle.
+  Initially the subpage support is only for 64KiB support, but the design makes
+  it pretty easy to enable support for other page sizes.
+
+- No inline extent creation
+  This is an artificial limit, to prevent mixed inline and regular extents.
+
+  It's possible to create mixed inline and regular extents even with
+  non-subpage mount for certain corner cases, it's way easier to create such
+  mixed extents for subpage.
+
+  Thus max_inline mount option will be sliently ignored for subpage mounts,
+  and it always acts as "max_inline=0".
+
+- Compression write is limited to page aligned ranges
+  Compression write for subpage is introduced in v5.16, with the limitation
+  that only page aligned range can be compressed.
+  This limitation is due to how btrfs handles delayed allocation.
+
+- No support for v1 space cache
+  V1 space cache is considered deprecated, and we're defaulting to v2 cache
+  in btrfs-progs already.
+  The old v1 cache has quite some hard coded page size usage, and consider it
+  is already deprecated, we force v2 cache for subpage.
+
+- Slightly higher memory usage for scrub
+  This is due to how we allocate pages for scrub, and will be fixed in the coming
+  releases soon.
-- 
2.36.1

