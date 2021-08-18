Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D933EFD0B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 08:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbhHRGpX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 02:45:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37012 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbhHRGo7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 02:44:59 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D8D3E21FDF
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 06:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629269064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AWEPQRi4e0UuGJfkHaA2QmSq+pORcEypbEcxIcRfzHg=;
        b=MHj7ZzM0+XWW8oHycJ2TpM7VBxxW683zda6qg3+mNjgGnoZgTjFUszky8dHUYjI4v8YbtK
        djOJdKUbfkTV1mKGu8nQRBRkfyqPymmxCmbZH93zOL4uvqx3AmqzL/oZr4YHIggcxwMCCK
        71dyDs10+CyVaUnqFDnV23z6ZRDemYo=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1C9E1134B1
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 06:44:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id aAG4M0esHGH4dAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 06:44:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: tests: also check subpage warning for type 2 test cases
Date:   Wed, 18 Aug 2021 14:44:18 +0800
Message-Id: <20210818064420.866803-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818064420.866803-1-wqu@suse.com>
References: <20210818064420.866803-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are two types of test cases:

- Type 1 (without test.sh)
- Type 2 (test.sh, mostly will override check_image())

For Type 2 tests, we check subpage related warnings of btrfs-check, but
didn't check it for Type 1 test cases.

In fact, Type 1 test cases are more important, as they involve repair,
which can generate new tree blocks, and we want to make sure such new
tree blocks won't cause subpage related warnings.

This patch will add the extra check for Type 1 test cases.

And it will make sure the subpage related warnings are really from this
test case, to prevent false alerts.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/common | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tests/common b/tests/common
index 805a447c84ce..a6f75c7ce237 100644
--- a/tests/common
+++ b/tests/common
@@ -423,13 +423,23 @@ check_image()
 {
 	local image
 
+	tmp_output=$(mktemp --tmpdir btrfs-progs-test-check-image.XXXXXX)
+
 	image=$1
 	echo "testing image $(basename $image)" >> "$RESULTS"
-	"$TOP/btrfs" check "$image" >> "$RESULTS" 2>&1
+	"$TOP/btrfs" check "$image" &> "$tmp_output"
 	[ $? -eq 0 ] && _fail "btrfs check should have detected corruption"
 
+	cat "$tmp_output" >> "$RESULTS"
+	# Also make sure no subpage related warnings
+	check_test_results "$tmp_output" "$testname"
+
 	run_check "$TOP/btrfs" check --repair --force "$image"
-	run_check "$TOP/btrfs" check "$image"
+	run_check_stdout "$TOP/btrfs" check "$image" &> "$tmp_output"
+
+	# Also make sure no subpage related warnings for the repaired image
+	check_test_results "$tmp_output" "$testname"
+	rm -f "$tmp_output"
 }
 
 # Extract a usable image from packed formats
-- 
2.32.0

