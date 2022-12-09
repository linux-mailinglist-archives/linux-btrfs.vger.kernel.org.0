Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E1A647DB5
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Dec 2022 07:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiLIGTY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Dec 2022 01:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLIGTV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Dec 2022 01:19:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD16379C8D;
        Thu,  8 Dec 2022 22:19:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8D90233784;
        Fri,  9 Dec 2022 06:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670566759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZLxTasF7iLaEstuKhC4o9SeUQ78YzUGlk7DjrJJbLFY=;
        b=t3LCUUXza6KWU6coM+f/SQkJVKCEyEGFjPW6tfFIykGNB6H4CatjkgELfoluKDHnwqvMuK
        fJCE1ZN9+TSlNJhDjec7iJgKDw8MdSzsVQLcKjq3AUHy3bCzEndi4rBwloST3I7f9tIZQw
        560PvmU/d+sM0YheljmHoIY8IVeIEUI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB7AB138E0;
        Fri,  9 Dec 2022 06:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OPqfHGbTkmNLCAAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 09 Dec 2022 06:19:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/080: fix the stray '\'
Date:   Fri,  9 Dec 2022 14:19:01 +0800
Message-Id: <20221209061901.30511-1-wqu@suse.com>
X-Mailer: git-send-email 2.38.1
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

[BUG]
The latest grep will report stray '\', causing golden output mismatch
for btrfs/080:

btrfs/080       - output mismatch (see ~/xfstests-dev/results//btrfs/080.out.bad)
    --- tests/btrfs/080.out	2022-11-24 19:53:53.137469203 +0800
    +++ ~/xfstests-dev/results//btrfs/080.out.bad	2022-12-09 11:41:46.194597311 +0800
    @@ -1,2 +1,3 @@
     QA output created by 080
    +grep: warning: stray \ before -
     Silence is golden
    ...
    (Run 'diff -u ~/xfstests-dev/tests/btrfs/080.out ~/xfstests-dev/results//btrfs/080.out.bad'  to see the entire diff)

[CAUSE]
Even for regrex of grep, '-' doesn't need special escape, thus
"\bno\-holes\b" indeed has an unnecessary '\' before '-'.

[FIX]
Just remove the stray '\'.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/080 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/080 b/tests/btrfs/080
index 45f5ad19..ac9d9b64 100755
--- a/tests/btrfs/080
+++ b/tests/btrfs/080
@@ -76,7 +76,7 @@ workout()
 # created fs doesn't get that feature enabled. With it enabled, the below fsck
 # call wouldn't fail. This feature hasn't been enabled by default since it was
 # introduced, but be safe and explicitly disable it.
-_scratch_mkfs -O list-all 2>&1 | grep -q '\bno\-holes\b'
+_scratch_mkfs -O list-all 2>&1 | grep -q '\bno-holes\b'
 if [ $? -eq 0 ]; then
 	mkfs_options="-O ^no-holes"
 fi
-- 
2.38.0

