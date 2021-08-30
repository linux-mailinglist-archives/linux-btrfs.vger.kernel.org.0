Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1728F3FB5EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 14:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhH3MYD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 08:24:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58754 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhH3MYC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 08:24:02 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 45E322009B;
        Mon, 30 Aug 2021 12:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630326188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Bkj8H6STZ7TlRsKKK76y+kvd6CtJjmzSZPtHTvYc09E=;
        b=SU+vtYZdrWmQ26UXWdVBLFr9roYa+A9ntTCbWsCyy589AfxoDufsHAudVZKiSx3pOncNAq
        4QGI65hXoUhaQX4G5xruxci1GHmrux699ZeN3zW7hc69d8LPb/pFg/2Nwg3PEqR3Gb9d8F
        BGyWrrV3OHsSMvsK0ZWCdnV67DYNW7Y=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 094A413738;
        Mon, 30 Aug 2021 12:23:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id YoPzOqvNLGHOYwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 30 Aug 2021 12:23:07 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] common/renameat2: Make _rename_tests_source_dest take flags as 4th arguement
Date:   Mon, 30 Aug 2021 15:23:05 +0300
Message-Id: <20210830122306.882081-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently this function takes the flags parameter to be passed to the
renameat program by assuming there exists a 'flags' variable. Instead,
make the flags being passed as 4th argument to the function.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 common/renameat2 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/renameat2 b/common/renameat2
index 4b64eea7824b..4d25d7cebf94 100644
--- a/common/renameat2
+++ b/common/renameat2
@@ -61,6 +61,7 @@ _rename_tests_source_dest()
 	local source=$1
 	local dest=$2
 	local options=$3
+	local flags=$4
 
 	for stype in none regu symb dire tree; do
 		for dtype in none regu symb dire tree; do
@@ -90,11 +91,11 @@ _rename_tests()
 	local flags=$2
 
 	#same directory renames
-	_rename_tests_source_dest $testdir/src $testdir/dst     "samedir "
+	_rename_tests_source_dest $testdir/src $testdir/dst     "samedir " $flags
 
 	#cross directory renames
 	mkdir $testdir/x $testdir/y
-	_rename_tests_source_dest $testdir/x/src $testdir/y/dst "crossdir"
+	_rename_tests_source_dest $testdir/x/src $testdir/y/dst "crossdir" $flags
 	rmdir $testdir/x $testdir/y
 }
 
-- 
2.17.1

