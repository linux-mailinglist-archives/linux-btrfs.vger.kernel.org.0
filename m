Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC6D4DBF5A
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 07:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiCQGXK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 02:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiCQGWl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 02:22:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783B96621F
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 23:12:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 05D0921115;
        Thu, 17 Mar 2022 06:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647497574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=o9woxmYw3EvE32j1+0z/iSjKLx0F9FUp/rw2fhR9w10=;
        b=ocquPNFaazG1uHD/VqnaBlv/6Ivs5EiXKBroq88d83IrhwhhzQsL3zgooZKoWPxgTDIIUR
        R4Nyp/OyZr+68GCoJkgbhdg8qqfHK2XykZGqstklpZ26dqjRfxvCnvce79bSlqpMUcjeXl
        Lxayxwy0UJIvFewdURxX55ObH0BTV9Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2249613ACB;
        Thu, 17 Mar 2022 06:12:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hHjUN2TRMmIaSgAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 17 Mar 2022 06:12:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>
Subject: [PATCH] btrfs: check/qgroup: fix two error messages used in qgroup verification
Date:   Thu, 17 Mar 2022 14:12:50 +0800
Message-Id: <59b4af870c15cbd7e05d05d41312e5eb54632632.1647497564.git.wqu@suse.com>
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
There is a weird error message when running btrfs check on a specific
immage:

 [7/7] checking quota groups
 ERROR: out of memory
 ERROR: Loading qgroups from disk: -2
 ERROR: failed to check quota groups

[CAUSE]
The "Out of memory" one is in load_quota_info(), which is output in two
cases:

- No memory can be allocated for btrfs_qgroup_list
  AKA, real -ENOMEM.

- No qgroup can be found for either the child or the parent qgroup
  This returnes -ENOENT.

Obvious the image has hit -ENOENT case, but the error message is fixed
to ENOMEM case.

[FIX]
Fix it by using %m to output the real reason of failure.

Reported-by: Andrei Borzenkov <arvidjaar@gmail.com>
Link: https://forums.opensuse.org/showthread.php/567851-btrfs-fails-to-load-qgroups-from-disk-with-error-2-(out-of-memory)
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/qgroup-verify.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index 0813b8412057..d1478a40fde3 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -977,7 +977,11 @@ loop:
 					ret = add_qgroup_relation(key.objectid,
 								  key.offset);
 					if (ret) {
-						error("out of memory");
+						errno = -ret;
+						error(
+		"failed to add qgroup relation, member=%llu parent=%llu: %m",
+						      key.objectid,
+						      key.offset);
 						goto out;
 					}
 				}
-- 
2.35.1

