Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DCF548047
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 09:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbiFMHHW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 03:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiFMHG7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 03:06:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EFE19C20
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 00:06:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B19C81FABD
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 07:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655104016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=65Wx0Usn2VXbYmkZ773JLVNg3GQ7HDzk0KBKaty8l4o=;
        b=u2/B7rHNzxlQ/d+R5U6vEqUsQHDuYybg9sJf18V+6HGveI8zx273sbBFN2XOAr/vgu9R6d
        jTIqcfH3rLfzB+n0XgDts0NeVJp7UVBEvb1UunHcVXcIiORv1arRscON9DgYYKPF+Kx9YJ
        IMSkIXRIS2ryP9swVb4MdXH7ZYwiO7U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD33C134CF
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 07:06:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MIKmHw/ipmJUCgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 07:06:55 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: warn about dev extents that are inside the reserved range
Date:   Mon, 13 Jun 2022 15:06:35 +0800
Message-Id: <c4b02ac7bf6e4171d8cfb13dcd11b3bad8d2e4df.1655103954.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655103954.git.wqu@suse.com>
References: <cover.1655103954.git.wqu@suse.com>
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

