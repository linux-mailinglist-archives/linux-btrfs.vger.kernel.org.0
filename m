Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1873E64DA95
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Dec 2022 12:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiLOLlg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Dec 2022 06:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLOLlf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Dec 2022 06:41:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1865527B19;
        Thu, 15 Dec 2022 03:41:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CB02B21D5E;
        Thu, 15 Dec 2022 11:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671104492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=N/pUhMeVx4FPWLcW5qWJaSOuqdX5ZvQL0X/Lug+kReA=;
        b=fvVogMgJwtYRvVhdRPjNhc4K5clTj1WUYqKuwob3X5ZuyjA/vXHIluAK5OGEwTg8Zh6qaj
        5XhIrb5foXj+8HL5ZBIAeVleVEwPX8SWTw9+Ezv3hFc5NILU9YsOjI0akVlh1nta1l9drK
        mPdLrdHGSdxty7gXTXDy9mu2CNla1es=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA96D138E5;
        Thu, 15 Dec 2022 11:41:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tGt+J+sHm2NFfwAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 15 Dec 2022 11:41:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [RFC PATCH] fstests: add basic json output support
Date:   Thu, 15 Dec 2022 19:41:13 +0800
Message-Id: <20221215114113.38815-1-wqu@suse.com>
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

Although the current result files "check.log" and "check.time" is enough
for human to read, it's not that easy to parse.

Thus this patch will introduce a json output to "$RESULT_BASE/check.json".

The example output would look like this:

  {
      "section": "(none)",
      "fstype": "btrfs",
      "start_time": 1671103264,
      "arch": "x86_64",
      "kernel": "6.1.0-rc8-custom+",
      "results": [
          {
              "testcase": "btrfs/001",
              "status": "pass",
              "start_time": 1671103264,
              "end_time": 1671103266
          },
          {
              "testcase": "btrfs/006",
              "status": "pass",
              "start_time": 1671103266,
              "end_time": 1671103268
          },
          {
              "testcase": "btrfs/007",
              "status": "pass",
              "start_time": 1671103268,
              "end_time": 1671103271
          }
      ]
  }

Which should make later parsing much easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

- Not crash safe
  If one test case caused a crash, the "check.json" file will be an
  invalid one, missing the closing "] }" string.

- Is json really a good choice?
  It may be much easier to convert to a web page, but we will still
  need to parse and handle the result using another languages anyway,
  like to determine a regression.

  Another alternative is .csv, and it can be much easier to handle.
  (pure "echo >> $output", no need to handle the comma rule).
  But for .csv, we may waste a lot of columes for things like "arch",
  "kernel", "section".

- No good way to handle old results.
  Unlike check.log, which can save old results without any problem, json
  can not allow multiple top-level json objects.

  Thus currently old "check.json" will be saved to "check.json.old",
  further older results will be lost.
---
 check       |  32 ++++++++++++--
 common/json | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+), 4 deletions(-)
 create mode 100644 common/json

diff --git a/check b/check
index d2e51296..cdb7f793 100755
--- a/check
+++ b/check
@@ -364,6 +364,11 @@ if ! . ./common/rc; then
 	exit 1
 fi
 
+if ! . ./common/json; then
+	echo "check: failed to source common/json"
+	exit 1
+fi
+
 if [ -n "$subdir_xfile" ]; then
 	for d in $SRC_GROUPS $FSTYP; do
 		[ -f $SRC_DIR/$d/$subdir_xfile ] || continue
@@ -576,6 +581,11 @@ _stash_fail_loop_files() {
 _stash_test_status() {
 	local test_seq="$1"
 	local test_status="$2"
+	local start_epoch="$3"
+	local end_epoch="$4"
+
+	_json_add_one_result "${REPORT_DIR}/check.json" \
+		"$test_seq" "$test_status"  "$start_epoch" "$end_epoch"
 
 	if $do_report && [[ $test_status != "expunge" ]]; then
 		_make_testcase_report "$section" "$test_seq" \
@@ -804,6 +814,19 @@ function run_section()
 	seqres="$check"
 	_check_test_fs
 
+	local json_out
+	local json_section
+	if $OPTIONS_HAVE_SECTIONS; then
+		mkdir -p "$RESULT_BASE/$section"
+		json_out="$RESULT_BASE/$section/check.json"
+		json_section="$section"
+	else
+		mkdir -p "$RESULT_BASE"
+		json_out="$RESULT_BASE/check.json"
+		json_section=""
+	fi
+
+	_json_start "$json_out" "$(_full_fstyp_details)" "$json_section"
 	loop_status=()	# track rerun-on-failure state
 	local tc_status ix
 	local -a _list=( $list )
@@ -863,7 +886,7 @@ function run_section()
 		tc_status="pass"
 		if [ ! -f $seq ]; then
 			echo " - no such test?"
-			_stash_test_status "$seqnum" "$tc_status"
+			_stash_test_status "$seqnum" "non-exist"
 			continue
 		fi
 
@@ -936,7 +959,7 @@ function run_section()
 				      echo -n "	$seqnum -- "
 			cat $seqres.notrun
 			tc_status="notrun"
-			_stash_test_status "$seqnum" "$tc_status"
+			_stash_test_status "$seqnum" "$tc_status" "$start" "$stop"
 
 			# Unmount the scratch fs so that we can wipe the scratch
 			# dev state prior to the next test run.
@@ -991,7 +1014,7 @@ function run_section()
 		if [ ! -f $seq.out ]; then
 			_dump_err "no qualified output"
 			tc_status="fail"
-			_stash_test_status "$seqnum" "$tc_status"
+			_stash_test_status "$seqnum" "$tc_status" "$start" "$stop"
 			continue;
 		fi
 
@@ -1027,11 +1050,12 @@ function run_section()
 				rm -f $seqres.hints
 			fi
 		fi
-		_stash_test_status "$seqnum" "$tc_status"
+		_stash_test_status "$seqnum" "$tc_status" "$start" "$stop"
 	done
 
 	sect_stop=`_wallclock`
 	interrupt=false
+	_json_end "$json_out"
 	_wrapup
 	interrupt=true
 	echo
diff --git a/common/json b/common/json
new file mode 100644
index 00000000..762c9e3e
--- /dev/null
+++ b/common/json
@@ -0,0 +1,117 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# The json output would look like this:
+#{
+#    "section": "(none)",
+#    "fstype": "btrfs",
+#    "start_time": 1671102736,
+#    "arch": "x86_64",
+#    "kernel": "6.1.0-rc8-custom+",
+#    "results": [
+#        {
+#            "testcase": "btrfs/001",
+#            "status": "pass",
+#            "start_time": 1671102736,
+#            "end_time": 1671102738
+#        },
+#        {
+#            "testcase": "btrfs/006",
+#            "status": "pass",
+#            "start_time": 1671102738,
+#            "end_time": 1671102740
+#        },
+#        {
+#            "testcase": "btrfs/007",
+#            "status": "pass",
+#            "start_time": 1671102740,
+#            "end_time": 1671102742
+#        }
+#    ]
+#}
+
+# Add the header for one section.
+#
+# @section can be empty, in that case, it will be turned into "(none)".
+#
+# Caller can then call one or more _json_add_one_result() calls, then
+# finish with _json_end()
+_json_start()
+{
+	local output="$1"
+	local fstype="$2"
+	local section="$3"
+	local time=$(date "+%s")
+	local kernel=$(uname -r)
+
+	if [ "$section" = "" ]; then
+		section="(none)"
+	fi
+
+	# If the file exists, we can not write new JSON top-level
+	# object into it, or it will be invalid.
+	# So here we just save it to "$output.old"
+	if [ -s "$output" ]; then
+		mv "$output" "$output.old"
+	fi
+
+	echo "{" 				>> "$output"
+	echo "    \"section\": \"${section}\","	>> "$output"
+	echo "    \"fstype\": \"${fstype}\","	>> "$output"
+	echo "    \"start_time\": ${time},"	>> "$output"
+	echo "    \"arch\": \"$(uname -m)\","	>> "$output"
+	echo "    \"kernel\": \"$(uname -r)\","	>> "$output"
+	echo "    \"results\": ["		>> "$output"
+}
+
+# $1 is the json file to append the result. Must call _json_start() first.
+# $2 is the test case name, e.g. "btrfs/001"
+# $3 is the result, "pass"|"fail"|"notrun"|"expunge"|list"
+# $4 is the start epoch time, e.g. 1671090884, can be empty
+# $5 is the end epoch time, e.g. 1671090890, can be empty
+#
+# If any of $4 and $5 is empty, it will use current epoch time.
+# Normally empty $4 or $5 can only be utilized for cases like "notrun"
+_json_add_one_result()
+{
+	local output="$1"
+	local testcase="$2"
+	local status="$3"
+	local start_time="$4"
+	local end_time="$5"
+
+	if [ ! -s "$output" ]; then
+		echo "error: the output file is not prepared with _json_start()"
+		exit 1
+	fi
+
+	if [ "$start_time" = "" ]; then
+		start_time=$(date "+%s")
+	fi
+	if [ "$end_time" = "" ]; then
+		end_time=$(date "+%s")
+	fi
+
+
+	# Check if the we have some results before us.
+	if tail -n1 "$output" | grep -q "}"; then
+		# I hate the JSON comma rule.
+		echo "," 		>> "$output"
+	fi
+	echo "        {"	>> "$output"
+
+	echo "            \"testcase\": \"${testcase}\","	>> "$output"
+	echo "            \"status\": \"${status}\","		>> "$output"
+	echo "            \"start_time\": ${start_time},"	>> "$output"
+	echo "            \"end_time\": ${end_time}"		>> "$output"
+	echo -n "        }"					>> "$output" 
+}
+
+_json_end()
+{
+	local output="$1"
+
+	echo		>> "$output"
+	echo "    ]"	>> "$output"
+	echo -n "}"	>> "$output"
+}
-- 
2.38.0

