Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDE83EFD0C
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 08:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbhHRGpZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 02:45:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37018 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238626AbhHRGpB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 02:45:01 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 23EEA2203A
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 06:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629269066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GHwPBpt8xQfWiN7/PA0HTS5ZEaeaPtLGP/KRlMoDC6g=;
        b=gC1J01LfAp4Y8ceuPolfLXd7JPG1A0xL7bmsq6v6mxNLXNnCBBvfEp+QSo7MVtp3z1AEu/
        cuFk6SR5f6WTTWGCRxwuW9rIldHIqpTWm5oYQnhM1gHn0YDWZvXxq++a2UzQUXI/OEv7FJ
        b7PFhPujW/hHtzAZtKx97cOd5uuwLr8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5B8CC134B1
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 06:44:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id UNpkB0msHGH4dAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 06:44:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: tests: don't check subpage related warnings for fsck type 1 tests
Date:   Wed, 18 Aug 2021 14:44:19 +0800
Message-Id: <20210818064420.866803-3-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818064420.866803-1-wqu@suse.com>
References: <20210818064420.866803-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For fsck tests, we check the subpage warnings for each type 1 test, but
such type 1 tests are mostly read-only tests, and one of the test will
trigger new subpage related warnings (fsck/018).

For subpage related warnings, what we really care are write operations,
including mkfs, btrfs-convert and repair, not those read-only tests.

So skip the subpage warning check for fsck type 1 tests to prevent false
alert of later more strict subpage warnings.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/fsck-tests.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/fsck-tests.sh b/tests/fsck-tests.sh
index ed18136f3ab9..70b307ab9629 100755
--- a/tests/fsck-tests.sh
+++ b/tests/fsck-tests.sh
@@ -64,7 +64,14 @@ run_one_test() {
 			fi
 			_fail "test failed for case $(basename $testname)"
 		fi
-		check_test_results "$RESULTS" "$testname"
+		# These tests have overriden check_image() and their
+		# images may have intentional unaligned metadata to trigger
+		# subpage warnings (like fsck/018), skip the check for their
+		# subpage warnings.
+		#
+		# We care subpage related warnings for write operations
+		# (mkfs/convert/repair), not those read-only checks on
+		# pre-crafted images.
 	else
 		# Type 1
 		check_all_images
-- 
2.32.0

