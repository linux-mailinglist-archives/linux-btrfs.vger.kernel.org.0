Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3BD4D9849
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 11:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346843AbiCOKDI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 06:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbiCOKDH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 06:03:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9CA4B1F7
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 03:01:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D2621F37E
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 10:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647338514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Dv6zWdCIN5OLBEHFCYSoDi3yMfmT4pjuUd4KkNV+smw=;
        b=PGW8E8tpaDXhhopVKiNuvOgomPY+APdJnEVwpHEQ1vUtLA2tt4aEw+eU01Zk4KcNuAL/El
        XtNnSJF+5mBa0QVEQeQIIXiOcW6taE0UZ1Sz5IDSiryQ+1x1Remq8+DVYRl8WoiR2kQyLh
        I2Jue6M3GGgAunT8ZVRo31ZZe61Po5w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5F1313B59
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 10:01:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nIO5IhFkMGLlEAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Mar 2022 10:01:53 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make enough noise for fstests to catch extent buffer leakage
Date:   Tue, 15 Mar 2022 18:01:33 +0800
Message-Id: <e29bd3f7a0b167cc6d7a6e40f8b3b62b88a64fc3.1647338477.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
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

Although we have btrfs_extent_buffer_leak_debug_check() (enabled by
CONFIG_BTRFS_DEBUG option) to detect and warn QA testers that we have
some extent buffer leakage, it's just pr_err(), not noisy enough for
fstests to cache.

So here we trigger a WARN_ON_ONCE() if the allocated_ebs list is not
empty.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 78486bbd1ac9..593eafc30261 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -76,6 +76,7 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 		return;
 
 	spin_lock_irqsave(&fs_info->eb_leak_lock, flags);
+	WARN_ON_ONCE(!list_empty(&fs_info->allocated_ebs));
 	while (!list_empty(&fs_info->allocated_ebs)) {
 		eb = list_first_entry(&fs_info->allocated_ebs,
 				      struct extent_buffer, leak_list);
-- 
2.35.1

