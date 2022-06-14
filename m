Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E05B54BDE6
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 00:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355068AbiFNWui (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 18:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355044AbiFNWug (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 18:50:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B14C52B0B
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 15:50:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 237271F9BD
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 22:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655247034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=65Wx0Usn2VXbYmkZ773JLVNg3GQ7HDzk0KBKaty8l4o=;
        b=NKBNvVMgO/jHt9Gc9/LGSFy9lxatvpNserQctudyRmecCbt7l0akwVsivAi5kIcjt+QoBg
        tV6Fpwm+IhD7pGuR0JAa1kzP8d1I0zlYa/5heyx4eZm2U3YM/Iov+QrWgnrvVB2NOVfnIO
        P8wSi631rc26L7ImDJrEs7hY363dIoM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 732E6139EC
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 22:50:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6A8bELkQqWKVbgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 22:50:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH DRAFT 2/4] btrfs: warn about dev extents that are inside the reserved range
Date:   Wed, 15 Jun 2022 06:50:12 +0800
Message-Id: <c4b02ac7bf6e4171d8cfb13dcd11b3bad8d2e4df.1655246405.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655246405.git.wqu@suse.com>
References: <cover.1655246405.git.wqu@suse.com>
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

Btrfs has reserved the first 1MiB for the primary super block (at 64KiB
offset) and legacy programs like older bootloaders.

This behavior is only introduced since v4.1 btrfs-progs release,
although kernel can ensure we never touch the reserved range of super
blocks, it's better to inform the end users, and a balance will resolve
the problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 051d124679d1..b39f4030d2ba 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7989,6 +7989,16 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 
+	/*
+	 * Very old mkfs.btrfs (before v4.1) will not respect the reserved
+	 * space. Although kernel can handle it without problem, better to
+	 * warn the users.
+	 */
+	if (physical_offset < BTRFS_DEFAULT_RESERVED)
+		btrfs_warn(fs_info,
+"devid %llu physical %llu len %llu is inside the reserved space, balance is needed to solve this problem.",
+			   devid, physical_offset, physical_len);
+
 	for (i = 0; i < map->num_stripes; i++) {
 		if (map->stripes[i].dev->devid == devid &&
 		    map->stripes[i].physical == physical_offset) {
-- 
2.36.1

