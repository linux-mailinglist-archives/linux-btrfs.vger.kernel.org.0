Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4518C4AB43B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Feb 2022 07:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbiBGFuy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Feb 2022 00:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiBGFRi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Feb 2022 00:17:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A235C043181
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Feb 2022 21:17:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 08B39210E3
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Feb 2022 05:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644211055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=11E68eAM/6u075rZH0fGkyUbkOachpI2UWxbfQD7ZXw=;
        b=nJZb76ofCBdeCmTY7LL+W7KHZSA38CLjrP8jyxBRUd2JAbLBjGD8fGTrHBhW8t1Ehqb68c
        a8kVkBg3WLanj0+Gpojgyb/C3ESgzG8Fk5XnWGGWFQs+tlGNIZmwsQEOudf/uzpSXUk67J
        jECgQQGTQKgRoe60sVHY9+qm4rkYFMM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5342B13519
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Feb 2022 05:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OznZBm6rAGIMPQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Feb 2022 05:17:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: defrag: don't try to defrag extent which is going to be written back
Date:   Mon,  7 Feb 2022 13:17:15 +0800
Message-Id: <9df1dce96466f4314190cc4120f19d5b7d0fe5ed.1644210926.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
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

In defrag_collect_targets() if we hit an extent map which is created by
create_io_em(), it will be considered as target as its generation is
(u64)-1, thus will pass the generation check.

Furthermore since all delalloc functions will clear EXTENT_DELALLOC,
such extent map will also pass the EXTENT_DELALLOC check.

Defragging such extent will make no sense, in fact this will cause extra
IO as we will just re-dirty the range and submit it for writeback again,
causing wasted IO.

Unfortunately this behavior seems to exist in older kernels too (v5.15
and older), but I don't have a solid test case to prove it nor test the
patched behavior.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 133e3e2e2e79..0ba98e1d9329 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1353,6 +1353,10 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		if (em->generation < ctrl->newer_than)
 			goto next;
 
+		/* This em is goging to be written back, no need to defrag */
+		if (em->generation == (u64)-1)
+			goto next;
+
 		/*
 		 * Our start offset might be in the middle of an existing extent
 		 * map, so take that into account.
-- 
2.35.0

