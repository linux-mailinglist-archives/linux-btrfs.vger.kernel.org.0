Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B712655CE7
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Dec 2022 12:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiLYLLQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Dec 2022 06:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYLLP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Dec 2022 06:11:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F16388;
        Sun, 25 Dec 2022 03:11:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B5F186835A;
        Sun, 25 Dec 2022 11:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671966670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5eV6F658cFcpC0VsVn6pXZIGYCI35BGvUYyOtoGHsDY=;
        b=nK09TV89/GRldTnL3GMIZxrk1oLxgdJjt6KKUCTAXD31yB9GtOoN6zAWgxvfFJvBwvin2A
        aG4aPFODvCV/GQ+c7/ic65SiVb38nNv/poLnnNF4zSRt4/iLobHVJYTrodnorwInI2eKGr
        T5GUsyNXauFUevkOtHH847If7FFRylk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E00E713913;
        Sun, 25 Dec 2022 11:11:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AhClKs0vqGMPYwAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 25 Dec 2022 11:11:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: report/xunit: report excluded test cases
Date:   Sun, 25 Dec 2022 19:10:51 +0800
Message-Id: <20221225111051.71234-1-wqu@suse.com>
X-Mailer: git-send-email 2.39.0
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

When running fstests btrfs runs on my aarch64 VM, test case generic/619 is
always a pain, it takes around 100 times the execution time than my x86_64
VMs (100+s on x86_64 vs over 10000+s).

That test case itself would take more time than all the other test
cases, thus I have excluded generic/619 for all my aarch64 runs.

But if one test case is excluded, it will only not be recorded in the
xmls result at all, making later review harder to expose the problem.

Fix this behavior be also report the expunged cases in xunit.

Now the expunged cases will have the following output, without a
message:
	<testcase classname="xfstests.global" name="generic/619" time="0">
		<skipped/>
	</testcase>

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check         | 2 +-
 common/report | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/check b/check
index 1ff0f44a..c64dce75 100755
--- a/check
+++ b/check
@@ -578,7 +578,7 @@ _stash_test_status() {
 	local test_seq="$1"
 	local test_status="$2"
 
-	if $do_report && [[ $test_status != "expunge" ]]; then
+	if $do_report; then
 		_make_testcase_report "$section" "$test_seq" \
 				      "$test_status" "$((stop - start))"
 	fi
diff --git a/common/report b/common/report
index 64f9c866..399c6a0e 100644
--- a/common/report
+++ b/common/report
@@ -97,7 +97,7 @@ _xunit_make_testcase_report()
 			echo -e "\t\t<skipped/>" >> $report
 		fi
 		;;
-	"list")
+	"list"|"expunge")
 		echo -e "\t\t<skipped/>" >> $report
 		;;
 	"fail")
-- 
2.39.0

