Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C391586237
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Aug 2022 03:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbiHABgU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 31 Jul 2022 21:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiHABgT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 31 Jul 2022 21:36:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377B4D118
        for <linux-btrfs@vger.kernel.org>; Sun, 31 Jul 2022 18:36:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C8B13602E3
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 01:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659317775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CLP1vHJKyOl8kqgGf5eTKjDRKufxslW5I4O6fBxcsZU=;
        b=cf3fwjtB2Zzz/BCpThiIvZ/emr3zt5NaRmuUy7iZ02XzYuzLUFoTCs3lbJLc9PWE3x3sVX
        edtUZ5O3vyibksTw4zjSmlxolj0zwe+jPLMWy2nfJ3G7POcs/zHqRc0se4wjHeEBr13wrv
        3XMXxqU6BB/qeWRrdGfadOc7oZUsb8E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C17E13A0D
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 01:36:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n0owOg4u52LzJwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Aug 2022 01:36:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: dump extra info if one free space cache has more bitmaps than it should
Date:   Mon,  1 Aug 2022 09:35:57 +0800
Message-Id: <8148a70ba12d1a0da36f0834fc2a92d4742820b7.1659317748.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is an internal report on hitting the following ASSERT() in
recalculate_thresholds():

 	ASSERT(ctl->total_bitmaps <= max_bitmaps);

Above @max_bitmaps is calculated using the following variables:

- bytes_per_bg
  8 * 4096 * 4096 (128M) for x86_64/x86.

- block_group->length
  The length of the block group.

@max_bitmaps is the rounded up value of block_group->length / 128M.

Normally one free space cache should not have more bitmaps than above
value, but when it happens the ASSERT() can be triggered if
CONFIG_BTRFS_ASSERT is also enabled.

But the ASSERT() itself won't provide enough info to know which is going
wrong.
Is the bg too small thus it only allows one bitmap?
Or is there something else wrong?

So although I haven't found extra reports or crash dump to do further
investigation, add the extra info to make it more helpful to debug.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/free-space-cache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 996da650ecdc..4ebfd9b7bc53 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -693,6 +693,12 @@ static void recalculate_thresholds(struct btrfs_free_space_ctl *ctl)
 
 	max_bitmaps = max_t(u64, max_bitmaps, 1);
 
+	if (ctl->total_bitmaps > max_bitmaps)
+		btrfs_err(block_group->fs_info,
+	"invalid free space control: bg start=%llu len=%llu total_bitmaps=%u unit=%u max_bitmaps=%llu bytes_per_bg=%llu",
+			  block_group->start, block_group->length,
+			  ctl->total_bitmaps, ctl->unit, max_bitmaps,
+			  bytes_per_bg);
 	ASSERT(ctl->total_bitmaps <= max_bitmaps);
 
 	/*
-- 
2.37.0

