Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8714D189F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 14:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347035AbiCHNE6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 08:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347028AbiCHNE6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 08:04:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0630DEEE;
        Tue,  8 Mar 2022 05:04:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D44B1F396;
        Tue,  8 Mar 2022 13:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646744640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8ci3oFk/T/lPASeA/KfnjlxY0+i1knzS5vYQBEQE/Vk=;
        b=PvNjdvC+67OqklDEGgDWuxkMHzHsXTGbXScyEzDrYKGaKGtsZ4Q3PnhFtPpRnAz2vEHwzP
        n+ewB7yXNIK/lnSwS6wmFmysyiSU2YrypcwgMQ0HXIWeJbdH4KdDOFsox1sp6yVEc/ARN+
        JDvKcUQvGpooG3f5tc5Qi/ghQ+FfcDc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97CF113CA6;
        Tue,  8 Mar 2022 13:03:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mlWgGD9UJ2KpEgAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 08 Mar 2022 13:03:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] common/btrfs: don't skip the test if BTRFS_PROFILE_CONFIGS contains unsupported profile
Date:   Tue,  8 Mar 2022 21:03:42 +0800
Message-Id: <2684eb3da262f10c546a464850d063954a7250ae.1646744615.git.wqu@suse.com>
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

[BUG]
Sometimes the tester wants to use $BTRFS_PROFILE_CONFIGS to limit the
tests to certain profiles.

This is especially useful for btrfs subpage tests, as we don't yet
support RAID56 for it yet.

But unfortunately, if we specify $BTRFS_PROFILE_CONFIGS with the
following content:

 export BTRFS_PROFILE_CONFIGS="single:single dup:single raid0:raid0 \
			       raid1:raid1 raid10:raid10"

A lot of tests will not run, like:

  btrfs/064 30s ... [not run] Profile dup not supported for replace
  btrfs/065 26s ... [not run] Profile dup not supported for replace
  btrfs/066 27s ...  14s
  btrfs/069 25s ... [not run] Profile dup not supported for replace
  btrfs/070 59s ... [not run] Profile dup not supported for replace
  btrfs/071 25s ... [not run] Profile dup not supported for replace

[CAUSE]
Those test cases uses _btrfs_get_profile_configs() to grab the profiles
which support given workload (like replace/repace-missing).

But _btrfs_get_profile_configs() will behave different based on whether
BTRFS_PROFILE_CONFIGS is defined.

If not defined, it goes with default profiles, and just skip those
unsupported.
This is what we want.

But if the environment variable is defined, it will not run if there is
any unsupported profile in it.

[FIX]
Unify the behaivor by always skip the unsupported profiles, no matter if
$BTRFS_PROFILE_CONFIGS is defined or not.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/btrfs | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 670d9d1f2b09..ac597ca465a1 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -258,13 +258,7 @@ _btrfs_get_profile_configs()
 
 		for unsupp in "${unsupported[@]}"; do
 			if [ "${profiles[0]}" == "$unsupp" -o "${profiles[1]}" == "$unsupp" ]; then
-			     if [ -z "$BTRFS_PROFILE_CONFIGS" ]; then
-				     # For the default config, just omit it.
-				     supported=false
-			     else
-				     # For user-provided config, don't run the test.
-				     _notrun "Profile $unsupp not supported for $1"
-			     fi
+				supported=false
 			fi
 		done
 		if "$supported"; then
-- 
2.35.1

