Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345095FB164
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 13:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJKL0K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 07:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJKL0J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 07:26:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B568323E
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 04:26:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A2E620172
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 11:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665487530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=X5R92XjWjkNTOQmTu4ZgsOXfWqV0QDfFaTJCNpxvG8U=;
        b=K6eAhiARV0eAyuSv02Tbp9500BOsY94vgdfzJx3uKJlYWKKkak2WfXJkUFSm5GONgb/ru3
        gOAftL5+l/8i04t5s8zWnPeoQ/GalkA+Au6914gW99h5uyHwvzaF2BGLxyYWfTXHqmm3TK
        +/A3+uaoUSX8Sa1cLbBHJYk+MtauQ88=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADB8213AAC
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 11:25:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3penHalSRWO2MgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 11:25:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: print-tree: follow the supported flags when printing flags
Date:   Tue, 11 Oct 2022 19:25:12 +0800
Message-Id: <37ed8ecbbc23d66955faf5b944be153db38e1dd7.1665487509.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we put EXTENT_TREE_V2 incompat flag entry under EXPERIMENTAL
features, thus at compile time, incompat_flags_array[] is determined at
compile time.

But the truth is, we have @supported_flags for __print_readable_flag(),
which is already defined based on EXPERIMENTAL flag.

Thus for __print_readable_flag(), we can always include the entry for
EXTENT_TREE_V2, and only print the flag if it's in the @supported_flags

By this, we can remove one EXPERIMENTAL macro usage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/print-tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 6b5fd37ab2bc..4cc44885466f 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1689,9 +1689,7 @@ static struct readable_flag_entry incompat_flags_array[] = {
 	DEF_INCOMPAT_FLAG_ENTRY(METADATA_UUID),
 	DEF_INCOMPAT_FLAG_ENTRY(RAID1C34),
 	DEF_INCOMPAT_FLAG_ENTRY(ZONED),
-#if EXPERIMENTAL
 	DEF_INCOMPAT_FLAG_ENTRY(EXTENT_TREE_V2),
-#endif
 };
 static const int incompat_flags_num = sizeof(incompat_flags_array) /
 				      sizeof(struct readable_flag_entry);
@@ -1731,7 +1729,7 @@ static void __print_readable_flag(u64 flag, struct readable_flag_entry *array,
 	printf("\t\t\t( ");
 	for (i = 0; i < array_size; i++) {
 		entry = array + i;
-		if (flag & entry->bit) {
+		if (flag & supported_flags && flag & entry->bit) {
 			if (first)
 				printf("%s ", entry->output);
 			else
-- 
2.37.3

