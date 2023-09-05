Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FE3792FD9
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 22:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243405AbjIEUWO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 16:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbjIEUWN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 16:22:13 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E961A4
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 13:22:01 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76df3d8fb4eso169989485a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Sep 2023 13:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1693945320; x=1694550120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wEk+ZX0NZDw+7/gtMgUr/G930GHBc2VHWc4PmHHmjs=;
        b=Yf/c4oTqiq2XmfdiWK9BlmuJyAAR23tiwdYe5+TbnWVEqtwuFTG6vIaGeqTa4X4RHb
         +3YZsW3xhqwpXjHCDbXVEU/AAkxml71QzVPxQGREho2YE/x01jMApxQ2uDp5l8YRqIQy
         ikKUeS2U4GWFZFblFWWBAC6ZWGE0xEd0l1Qd7LtZcR08RUBmhat4mxBjoLvIcP5v08IN
         9KnqD9WZJni0SOyP+m2PDO82mjRc8MjoJX4GIDK3ywFgs0rAYkBMfESw3max7V/IjYky
         c96AwB/VHzhECENO9SE/aGN/89Cn8w4wKPaGsHWgcQwudEOY9sRmKkuF3ZLOPFIBST12
         BglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693945320; x=1694550120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wEk+ZX0NZDw+7/gtMgUr/G930GHBc2VHWc4PmHHmjs=;
        b=iLvxIuzYi3jv2N9vgPk2clMHl/k/bs5RpZ7pUvAN0o6DCI9gjmWnnKgsvbJcHogRgc
         NhhzrJehkcByJcwGAzlxNRfueip0lvqMm2iKkGOQChMe7noKgOreyS55yUM4PSaGFljj
         9nQSJYBp/F0NHpBCvDyRzn8dUch1lYSVotDlFLhIV9HZD/8tYGmzfrC2Eq4Xa8tye78u
         WYakmka7glJdqqVLpQoTmPfKQx0TDEz5+aSEOG/qxdB0jlTn5O0AoQ2hd53bpFnMnkjY
         V0Q9eaRniq5RIxuAeMl+VOqmZ+r61vI60YLNmv6IDGGTr74ULYvSB8SicbnonYZNY4IR
         wY/A==
X-Gm-Message-State: AOJu0YxpG5cTpFNUWJ27iAdDBqisha1VNH2QQa0eifsRQ+aGh4tB9wWh
        sAAPI8MrXVOiiTMOPoFihzqLeSjuUJqrueBdiBU=
X-Google-Smtp-Source: AGHT+IHdfBEAg3v8mXlGSPSuTxdKqMthCg49mFjbUhnwD7UcTdwdjexpNtIGQtCFMRW+lf/oVPUQ6w==
X-Received: by 2002:a05:620a:1aa8:b0:76d:a008:f713 with SMTP id bl40-20020a05620a1aa800b0076da008f713mr17333910qkb.60.1693945320465;
        Tue, 05 Sep 2023 13:22:00 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a20-20020a05620a103400b0076cc4610d0asm4349034qkk.85.2023.09.05.13.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:22:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/3] btrfs-progs: add extent buffer leak detection to make test
Date:   Tue,  5 Sep 2023 16:21:53 -0400
Message-ID: <4df1b25365287e0fa3e7b4c8d1400ad5d576d992.1693945163.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693945163.git.josef@toxicpanda.com>
References: <cover.1693945163.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I introduced a regression where we were leaking extent buffers, and this
resulted in the CI failing because we were spewing these errors.

Instead of waiting for fstests to catch my mistakes, check every command
output for leak messages, and fail the test if we detect any of these
messages.  I've made this generic enough that we could check for other
debug messages in the future.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/common | 108 +++++++++++++++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 47 deletions(-)

diff --git a/tests/common b/tests/common
index 602a4122..607ad747 100644
--- a/tests/common
+++ b/tests/common
@@ -160,6 +160,18 @@ _is_target_command()
 	return 1
 }
 
+# Check to see if there's any debug messages that may mean we have a problem.
+_check_output()
+{
+	local results="$1"
+
+	if grep -q "extent buffer leak" "$results"; then
+		_fail "extent buffer leak reported"
+		return 1
+	fi
+	return 0
+}
+
 # Expanding extra commands/options for current command string
 # This function is responsible for inserting the following things:
 # - @INSTRUMENT before 'btrfs'  commands
@@ -206,6 +218,48 @@ expand_command()
 	done
 }
 
+# This is the helper for the run_check variants.
+# The first argument is the run_check type
+# The second argument is the run_check type that will get logged to tty
+# The third argument is wether we want the output echo'ed
+# The rest of the arguments are the command
+_run_check()
+{
+	local header_type
+	local test_log_type
+	local do_stdout
+	local tmp_output
+
+	run_type="$1"
+	shift
+
+	test_log_type="$1"
+	shift
+
+	do_stdout="$1"
+	shift
+
+	tmp_output=$(mktemp --tmpdir btrfs-progs-leak-detect.XXXXXX)
+
+	expand_command "$@"
+	echo "====== RUN $run_type ${cmd_array[@]}" >> "$RESULTS" 2>&1
+	if [[ $TEST_LOG =~ tty ]]; then echo "$test_log_type: ${cmd_array[@]}" \
+		> /dev/tty; fi
+	"${cmd_array[@]}" > "$tmp_output" 2>&1
+	ret=$?
+
+	cat "$tmp_output" >> "$RESULTS"
+	[ "$do_stdout" = true ] && cat "$tmp_output"
+
+	if ! _check_output "$tmp_output"; then
+		_fail "bad output"
+		rm "$tmp_output"
+		return 1
+	fi
+	rm "$tmp_output"
+	return "$ret"
+}
+
 # Argument passing magic:
 # the command passed to run_* helpers is inspected, if there's 'btrfs command'
 # found and there are defined additional arguments, they're inserted just after
@@ -216,11 +270,7 @@ expand_command()
 
 run_check()
 {
-	expand_command "$@"
-	echo "====== RUN CHECK ${cmd_array[@]}" >> "$RESULTS" 2>&1
-	if [[ $TEST_LOG =~ tty ]]; then echo "CMD: ${cmd_array[@]}" > /dev/tty; fi
-
-	"${cmd_array[@]}" >> "$RESULTS" 2>&1 || _fail "failed: ${cmd_array[@]}"
+	_run_check "CHECK" "CMD" "false" "$@" || _fail "failed: ${cmd_array[@]}"
 }
 
 # same as run_check but the stderr+stdout output is duplicated on stdout and
@@ -230,12 +280,8 @@ run_check()
 #	filter the output, as INSTRUMENT can easily pollute the output.
 run_check_stdout()
 {
-	expand_command "$@"
-	echo "====== RUN CHECK ${cmd_array[@]}" >> "$RESULTS" 2>&1
-	if [[ $TEST_LOG =~ tty ]]; then echo "CMD(stdout): ${cmd_array[@]}" \
-		> /dev/tty; fi
-	"${cmd_array[@]}" 2>&1 | tee -a "$RESULTS"
-	if [ ${PIPESTATUS[0]} -ne 0 ]; then
+	_run_check "CHECK" "CMD(stdout)" "true" "$@"
+	if [ $? -ne 0 ]; then
 		_fail "failed: $@"
 	fi
 }
@@ -245,11 +291,7 @@ run_check_stdout()
 # output is logged
 run_mayfail()
 {
-	expand_command "$@"
-	echo "====== RUN MAYFAIL ${cmd_array[@]}" >> "$RESULTS" 2>&1
-	if [[ $TEST_LOG =~ tty ]]; then echo "CMD(mayfail): ${cmd_array[@]}" \
-		> /dev/tty; fi
-	"${cmd_array[@]}" >> "$RESULTS" 2>&1
+	_run_check "MAYFAIL" "CMD(mayfail)" "false" "$@"
 	ret=$?
 	if [ $ret != 0 ]; then
 		echo "failed (ignored, ret=$ret): $@" >> "$RESULTS"
@@ -271,19 +313,8 @@ run_mayfail()
 # store the output to a variable for further processing.
 run_mayfail_stdout()
 {
-	tmp_output=$(mktemp --tmpdir btrfs-progs-mayfail-stdout.XXXXXX)
-
-	expand_command "$@"
-	echo "====== RUN MAYFAIL ${cmd_array[@]}" >> "$RESULTS" 2>&1
-	if [[ $TEST_LOG =~ tty ]]; then echo "CMD(mayfail): ${cmd_array[@]}" \
-		> /dev/tty; fi
-	"${cmd_array[@]}" 2>&1 > "$tmp_output"
+	_run_check "MAYFAIL" "CMD(mayfail)" "true" "$@"
 	ret=$?
-
-	cat "$tmp_output" >> "$RESULTS"
-	cat "$tmp_output"
-	rm -- "$tmp_output"
-
 	if [ "$ret" != 0 ]; then
 		echo "failed (ignored, ret=$ret): $@" >> "$RESULTS"
 		if [ "$ret" == 139 ]; then
@@ -312,12 +343,7 @@ run_mustfail()
 		exit 1
 	fi
 
-
-	expand_command "$@"
-	echo "====== RUN MUSTFAIL ${cmd_array[@]}" >> "$RESULTS" 2>&1
-	if [[ $TEST_LOG =~ tty ]]; then echo "CMD(mustfail): ${cmd_array[@]}" \
-		> /dev/tty; fi
-	"${cmd_array[@]}" >> "$RESULTS" 2>&1
+	_run_check "MUSTFAIL" "CMD(mustfail)" "false" "$@"
 	if [ $? != 0 ]; then
 		echo "failed (expected): $@" >> "$RESULTS"
 		return 0
@@ -337,9 +363,6 @@ run_mustfail_stdout()
 {
 	local msg
 	local ret
-	local tmp_output
-
-	tmp_output=$(mktemp --tmpdir btrfs-progs-mustfail-stdout.XXXXXX)
 
 	msg="$1"
 	shift
@@ -349,17 +372,8 @@ run_mustfail_stdout()
 		exit 1
 	fi
 
-	expand_command "$@"
-	echo "====== RUN MUSTFAIL ${cmd_array[@]}" >> "$RESULTS" 2>&1
-	if [[ $TEST_LOG =~ tty ]]; then echo "CMD(mustfail): ${cmd_array[@]}" \
-		> /dev/tty; fi
-	"${cmd_array[@]}" 2>&1 > "$tmp_output"
+	_run_check "MUSTFAIL" "CMD(mustfail)" "true" "$@"
 	ret=$?
-
-	cat "$tmp_output" >> "$RESULTS"
-	cat "$tmp_output"
-	rm "$tmp_output"
-
 	if [ "$ret" != 0 ]; then
 		echo "failed (expected): $@" >> "$RESULTS"
 		return 0
-- 
2.41.0

