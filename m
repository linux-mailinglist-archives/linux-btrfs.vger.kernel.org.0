Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF474D1904
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 14:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbiCHNUI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 08:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiCHNUH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 08:20:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E153BBCA;
        Tue,  8 Mar 2022 05:19:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 76EAB1F39B;
        Tue,  8 Mar 2022 13:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646745548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KLwjcydIOifJk3BFEspHlgdR6tKKu38AYXUh4yZUGzo=;
        b=DI3vKkXVKKhCiDWgrRkyMP+bWTQuKY5lLXKuPRG8mKpT0NtTeoaGnzbX+xHOhKERfOCLfV
        ZXbHYNwAvBZU5+dAdXq0B4Z1yAuoyU4PY0rlgmu3ypSDMIbVnk3EA7AIA0Sii8yAjAT4et
        6MnVbk0RAhByEWuhwXTp356CnjQLybg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9973113CA6;
        Tue,  8 Mar 2022 13:19:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bdMcGctXJ2LXGQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 08 Mar 2022 13:19:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs/194: allow it to be run on systems with page size larger than 4K
Date:   Tue,  8 Mar 2022 21:18:49 +0800
Message-Id: <aea00b23566c603543e276febecd0f631c43621f.1646745497.git.wqu@suse.com>
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

Since btrfs has subpage support since v5.15, there is no need to require
such hard requirement on 4K page size.

We only need to check if the current system support 4K as sectorsize.

Now the test case can pass on aarch64 with 64K page size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/194 | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/194 b/tests/btrfs/194
index 228576e4e7f0..d749377cb19e 100755
--- a/tests/btrfs/194
+++ b/tests/btrfs/194
@@ -25,9 +25,7 @@ _scratch_dev_pool_get 2
 
 # Here we use 4k node size to reduce runtime (explained near _scratch_mkfs call)
 # To use the minimal node size (4k) we need 4K page size.
-if [ $(get_page_size) != 4096 ]; then
-	_notrun "This test need 4k page size"
-fi
+_require_btrfs_support_sectorsize 4096
 
 device_1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
 device_2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
@@ -37,7 +35,7 @@ echo device_1=$device_1 device_2=$device_2 >> $seqres.full
 # The wrong check limit is based on the max item size (BTRFS_MAX_DEVS() macro),
 # and max item size is based on node size, so smaller node size will result
 # much shorter runtime. So here we use minimal node size (4K) to reduce runtime.
-_scratch_mkfs -n 4k >> $seqres.full
+_scratch_mkfs -n 4k -s 4k >> $seqres.full
 _scratch_mount
 
 # For 4k nodesize, the wrong limit is calculated by:
-- 
2.35.1

