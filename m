Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EB66587E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Dec 2022 00:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiL1Xcs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Dec 2022 18:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiL1Xcp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Dec 2022 18:32:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C10120AC
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Dec 2022 15:32:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B97BE21A1A
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Dec 2022 23:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672270363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5YLC97ms06BkvvSHNeImdfiLm5bYGZks4ZpcD1hT+dg=;
        b=gN+07m3geBXk1t2Gvrcej6vYC8FAETN6GPsaNX9eSf5O95NlR6Bp7wNtFN5wVs7Ci2SzCV
        7wbDmfGVLbC4lWuNh6xOouKK7MFqY4HzIOAJ/pr1mCQ/DNIVJh0AUKuaLwJUxC3LWTm/xM
        qxzaPoB2N3Yuuo6lLrzEF6xVAeMwgoU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 183B5138F9
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Dec 2022 23:32:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ONfjNBrSrGP/BAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Dec 2022 23:32:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: add error message for metadata level mismatch
Date:   Thu, 29 Dec 2022 07:32:23 +0800
Message-Id: <0d9b80c4616b78c7d5129b1ae92d9b45c2d8cab4.1672190127.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1672190127.git.wqu@suse.com>
References: <cover.1672190127.git.wqu@suse.com>
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

From a recent regression report, we found that after commit 947a629988f1
("btrfs: move tree block parentness check into
validate_extent_buffer()") if we have a level mismatch (false alert
though), there is no error message at all.

This makes later debug much harder.

This patch will add the proper error message for such case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f8b5955f003f..ec48adba2ae9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -530,6 +530,10 @@ static int validate_extent_buffer(struct extent_buffer *eb,
 	}
 
 	if (found_level != check->level) {
+		btrfs_err(fs_info,
+	"level verify failed on logical %llu mirror %u wanted %u found %u",
+			  eb->start, eb->read_mirror, check->level,
+			  found_level);
 		ret = -EIO;
 		goto out;
 	}
-- 
2.39.0

