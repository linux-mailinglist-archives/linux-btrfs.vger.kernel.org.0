Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73551655EEF
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Dec 2022 02:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiLZBBI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Dec 2022 20:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiLZBBF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Dec 2022 20:01:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4B8D50
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Dec 2022 17:01:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C9F44D954
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Dec 2022 01:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672016459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lMmmKR7Bjt1kG5Upm41T58LXXtEmI6rGBsZy86ghnF8=;
        b=h/bRapJw0aiN1U1qXKao9gw4UPXTQ9xJjGN/0ZuYl8eDrFFP/bPJAOX73LpJ9L+Sk21PSG
        zgiz1UXK5wEUua9FSYxwsnnqU5/Sh6WSreem43RWGrvDd8LNb7k86RYlCORmqhfbJqr2np
        3wNy3mJW5NsrpeHsdTmCltsE/uVdZS4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B979B138F2
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Dec 2022 01:00:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0KmQIkryqGNFaQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Dec 2022 01:00:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: add extra error message for tree block level mismatch
Date:   Mon, 26 Dec 2022 09:00:39 +0800
Message-Id: <59e14f15599dbe48acd0487dbc640ae4e7559e21.1672016104.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1672016104.git.wqu@suse.com>
References: <cover.1672016104.git.wqu@suse.com>
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

There is a bug report that commit 947a629988f1 ("btrfs: move tree block
parentness check into validate_extent_buffer()") caused some fs to go RO
under heavy write workload.

The full dmesg provided very little useful info, but surprisingly if
there is something wrong with the tree block, we should got some error
message in validate_extent_buffer().

However this is not always true, as there is one missing error message
for validate_extent_buffer(), tree level check.

So this patch will add the missing error message for
validate_extent_buffer() to make later debug much easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f8b5955f003f..3421f06eade3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -530,6 +530,10 @@ static int validate_extent_buffer(struct extent_buffer *eb,
 	}
 
 	if (found_level != check->level) {
+		btrfs_err_rl(eb->fs_info,
+	"level verify failed on logical %llu mirror %u wanted %u found %u",
+			     eb->start, eb->read_mirror, check->level,
+			     found_level);
 		ret = -EIO;
 		goto out;
 	}
-- 
2.39.0

