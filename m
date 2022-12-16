Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE39F64E76B
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 07:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLPGvn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 01:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPGvm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 01:51:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677F157B67;
        Thu, 15 Dec 2022 22:51:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DFA3C33B67;
        Fri, 16 Dec 2022 06:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671173499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=c47ZrksvcC+20FYyDUkQkjMf4qjqEYWZbJR5xQFWl4Y=;
        b=DgTYyyG5i3k8ik2mjAnd77LIqs55SyO4SuZvqmtx1Qo616PjCGDh2UmK/en1jvY5Tt8Qzo
        b7ZZQ+BguB8Fzsdc7J13Ahd0AkY7BJhk5u6OQ65oOMi0PCtgj/R4qcd6ZOJokhr/pq16mN
        fRsXHOlkWs/5YdYqsFpHxx8EABPz0+g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA51F138F0;
        Fri, 16 Dec 2022 06:51:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 50F0K3oVnGMKfwAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 16 Dec 2022 06:51:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: report: always save the dmesg as system-err if KEEP_DMESG is set
Date:   Fri, 16 Dec 2022 14:51:21 +0800
Message-Id: <20221216065121.30181-1-wqu@suse.com>
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

When KEEP_DMESG is set to "yes", we will always save the dmesg of any
test case (no matter if it passed or not) into "$seqnum.dmesg".

But this KEEP_DMESG behavior doesn't affect xunit report.

This patch will make xunit report to follow KEEP_DMESG setting.
Since error is checked by testcase.failure attribute, this new
<system-err> section should not cause the existing parsers to treat
passed cases as errors.

KEEP_DMESG is only followed if all the following conditions are met:

- KEEP_DMESG is set to yes

- Using xunit reporting
  xunit-quite won't save the dmesg for passed test cases.

This extra saved dmesg would definitely boost the xml size, but if the
end user wants to save all the dmesg (for later verification), then I'd
say it's a unavoidable cost.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/report | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/report b/common/report
index 64f9c866..4a747f8d 100644
--- a/common/report
+++ b/common/report
@@ -87,6 +87,19 @@ _xunit_make_testcase_report()
 	echo -e "\t<testcase classname=\"xfstests.$sect_name\" name=\"$test_name\" time=\"$test_time\">" >> $report
 	case $test_status in
 	"pass")
+		# If we have KEEP_DMESG and want full output, also save the
+		# dmesg into the passed result
+		if [ "$KEEP_DMESG" == yes -a "$quiet" != "yes" ]; then
+			local dmesg_file="${REPORT_DIR}/${test_name}.dmesg"
+			if [ -f "$dmesg_file" ]; then
+				echo -e "\t\t<system-err>" >> $report
+				printf	'<![CDATA[\n' >>$report
+				cat "$dmesg_file" | tr -dc '[:print:][:space:]' | \
+					encode_xml >>$report
+				printf ']]>\n'	>>$report
+				echo -e "\t\t</system-err>" >> $report
+			fi
+		fi
 		;;
 	"notrun")
 		local notrun_file="${REPORT_DIR}/${test_name}.notrun"
-- 
2.38.0

