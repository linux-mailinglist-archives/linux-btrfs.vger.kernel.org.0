Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397A1304890
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 20:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388353AbhAZFmj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 00:42:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:37454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbhAYKoq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 05:44:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611571440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=t8p4F4lY0153fmHVn1pyaemCFrPPSyVOX9KN261gsMc=;
        b=gPyg+ohIrWaHMSTpAuh1ACFHTyq+gDsUIaVnlSZBilJnFSogY5Q432/PAfdSHzHFDYp3Xw
        7lyN4HG5hwXsN08ORnEYgywKLX+wDomPRfw2HcXU+ra2vYpD6r3B01c8BCwWe/b8r0PC8f
        +mpfjq2C5ES/xL/+Lj6osjFrYFeHVMA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 66877ADC4;
        Mon, 25 Jan 2021 10:44:00 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] btrfs-progs: tests: Extend cli/003
Date:   Mon, 25 Jan 2021 12:43:57 +0200
Message-Id: <20210125104358.817072-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a test which ensures that when resize is tried on an image instead
of a directory appropriate warning is produced and the command fails.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/cli-tests/003-fi-resize-args/test.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/cli-tests/003-fi-resize-args/test.sh b/tests/cli-tests/003-fi-resize-args/test.sh
index 2e03725bb91a..0d2263f4b97f 100755
--- a/tests/cli-tests/003-fi-resize-args/test.sh
+++ b/tests/cli-tests/003-fi-resize-args/test.sh
@@ -54,4 +54,11 @@ for sep in '' '--'; do
 	run_check $SUDO_HELPER "$TOP/btrfs" filesystem resize $sep 1:max "$TEST_MNT"
 done

+
+# test passing a file instead of a directory
+run_mustfail_stdout "should fail for image" "$TOP/btrfs" filesystem resize 1:-128M "$TEST_DEV" |
+       grep -q "ERROR: resize works on mounted filesystems and accepts only" ||
+       _fail "no expected error message in the output 2"
+
+
 run_check_umount_test_dev
--
2.25.1

