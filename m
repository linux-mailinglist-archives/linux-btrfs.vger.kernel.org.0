Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9304B19F046
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 08:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgDFGLQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 02:11:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:42788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgDFGLP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Apr 2020 02:11:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 64FC0AD4D
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Apr 2020 06:11:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs-progs: tests: Introduce expand_command() to inject aruguments more accurately
Date:   Mon,  6 Apr 2020 14:11:06 +0800
Message-Id: <20200406061106.596190-3-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406061106.596190-1-wqu@suse.com>
References: <20200406061106.596190-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
We want to inject $INSTRUMENT (mostly valgrind) before btrfs command but
after root_helper.

Currently we won't inject $INSTRUMENT at all if we are using
root_helper.
This means the coverage is not good enough.

[FIX]
This patch introduce a new function, expand_command(), to handle all
parameter/argument injection, including existing 'btrfs check' inject.

This function will:
- Detect where to inject $INSTRUMENT
  If we have root_helper and the command is target command
  (btrfs/mkfs.btrfs/btrfs-convert), then we inject $INSTRUMENT after
  root_helper.
  If we don't have root_helper, and the command is target command,
  we inject $INSTRUMENT before the command.
  Or we don't inject $INSTRUMENT (it's not the target command).

- Use existing spec facility to inject extra arguments

- Use an array to restore to result
  To avoid bash interpret the IFS inside path/commands.

Now we can make sure no matter if we use root_helper, $INSTRUMENT is
always injected corrected.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/common | 176 +++++++++++++++++++++++++--------------------------
 1 file changed, 87 insertions(+), 89 deletions(-)

diff --git a/tests/common b/tests/common
index a040a1b803c4..ae8e1a231c4c 100644
--- a/tests/common
+++ b/tests/common
@@ -3,6 +3,9 @@
 # Common routines for all tests
 #
 
+# Temporary command array for building real command
+declare -a cmd_array
+
 # assert that argument is not empty and is an existing path (file or directory)
 _assert_path()
 {
@@ -135,6 +138,60 @@ _cmd_spec()
 	fi
 }
 
+_is_target_command()
+{
+	[[ $1 =~ /btrfs$ ]] && return 0
+	[[ $1 =~ /mkfs.btrfs$ ]] && return 0
+	[[ $1 =~ /btrfs-convert$ ]] && return 0
+	[[ $1 =~ /btrfs-corrupt-block$ ]] && return 0
+	[[ $1 =~ /btrfs-image$ ]] && return 0
+	[[ $1 =~ /btrfs-select-super$ ]] && return 0
+	[[ $1 =~ /btrfs-find-root$ ]] && return 0
+	[[ $1 =~ /btrfstune$ ]] && return 0
+	return 1
+}
+
+# Expanding extra commands/options for current command string
+# This function is responsible for inserting the following things:
+# - @INSTRUMENT before btrfs commands
+#   To ensure that @INSTRUMENT is not executed for things like sudo/mount
+#   which normally has setuid/setgid which will not be traced.
+#
+# - Add extra arguments for 'btrfs check'/'mkfs.btrfs'/'btrfs-convert'
+#   This allows us to test certain function like lowmem mode for btrfs check
+expand_command()
+{
+	local command_index
+	local ins
+	local spec
+	local i
+
+	ins=$(_get_spec_ins "$@")
+	spec=$(($ins-1))
+	spec=$(_cmd_spec "${@:$spec}")
+	cmd_array=()
+
+	if [ "$1" = 'root_helper' ] && _is_target_command "$2" ; then
+		command_index=2
+	elif _is_target_command "$1"  ; then
+		command_index=1
+	else
+		# Since we iterate from offset 1, this never get hit,
+		# thus we won't insert $INSTRUMENT
+		command_index=0
+	fi
+
+	for ((i = 1; i <= $#; i++ )); do
+		if [ $i -eq $command_index -a ! -z "$INSTRUMENT" ]; then
+			cmd_array+=($INSTRUMENT)
+		fi
+		if [ $i -eq $ins -a ! -z "$spec" ]; then
+			cmd_array+=("$spec")
+		fi
+		cmd_array+=("${!i}")
+	done
+}
+
 # Argument passing magic:
 # the command passed to run_* helpers is inspected, if there's 'btrfs command'
 # found and there are defined additional arguments, they're inserted just after
@@ -145,26 +202,11 @@ _cmd_spec()
 
 run_check()
 {
-	local spec
-	local ins
+	expand_command "$@"
+	echo "====== RUN CHECK ${cmd_array[@]}" >> "$RESULTS" 2>&1
+	if [[ $TEST_LOG =~ tty ]]; then echo "CMD: ${cmd_array[@]}" > /dev/tty; fi
 
-	ins=$(_get_spec_ins "$@")
-	spec=$(($ins-1))
-	spec=$(_cmd_spec "${@:$spec}")
-	set -- "${@:1:$(($ins-1))}" $spec "${@: $ins}"
-	echo "====== RUN CHECK $@" >> "$RESULTS" 2>&1
-	if [[ $TEST_LOG =~ tty ]]; then echo "CMD: $@" > /dev/tty; fi
-
-	# If the command is `root_helper` or mount/umount, don't call INSTRUMENT
-	# as most profiling tool like valgrind can't handle setuid/setgid/setcap
-	# which mount normally has.
-	# And since mount/umount is only called with run_check(), we don't need
-	# to do the same check on other run_*() functions.
-	if [ "$1" = 'root_helper' -o "$1" = 'mount' -o "$1" = 'umount' ]; then
-		"$@" >> "$RESULTS" 2>&1 || _fail "failed: $@"
-	else
-		$INSTRUMENT "$@" >> "$RESULTS" 2>&1 || _fail "failed: $@"
-	fi
+	"${cmd_array[@]}" >> "$RESULTS" 2>&1 || _fail "failed: ${cmd_array[@]}"
 }
 
 # same as run_check but the stderr+stdout output is duplicated on stdout and
@@ -174,20 +216,11 @@ run_check()
 #	filter the output, as INSTRUMENT can easily pollute the output.
 run_check_stdout()
 {
-	local spec
-	local ins
-
-	ins=$(_get_spec_ins "$@")
-	spec=$(($ins-1))
-	spec=$(_cmd_spec "${@:$spec}")
-	set -- "${@:1:$(($ins-1))}" $spec "${@: $ins}"
-	echo "====== RUN CHECK $@" >> "$RESULTS" 2>&1
-	if [[ $TEST_LOG =~ tty ]]; then echo "CMD(stdout): $@" > /dev/tty; fi
-	if [ "$1" = 'root_helper' ]; then
-		"$@" 2>&1 | tee -a "$RESULTS"
-	else
-		$INSTRUMENT "$@" 2>&1 | tee -a "$RESULTS"
-	fi
+	expand_command "$@"
+	echo "====== RUN CHECK ${cmd_array[@]}" >> "$RESULTS" 2>&1
+	if [[ $TEST_LOG =~ tty ]]; then echo "CMD(stdout): ${cmd_array[@]}" \
+		> /dev/tty; fi
+	"${cmd_array[@]}" 2>&1 | tee -a "$RESULTS"
 	if [ ${PIPESTATUS[0]} -ne 0 ]; then
 		_fail "failed: $@"
 	fi
@@ -198,21 +231,11 @@ run_check_stdout()
 # output is logged
 run_mayfail()
 {
-	local spec
-	local ins
-	local ret
-
-	ins=$(_get_spec_ins "$@")
-	spec=$(($ins-1))
-	spec=$(_cmd_spec "${@:$spec}")
-	set -- "${@:1:$(($ins-1))}" $spec "${@: $ins}"
-	echo "====== RUN MAYFAIL $@" >> "$RESULTS" 2>&1
-	if [[ $TEST_LOG =~ tty ]]; then echo "CMD(mayfail): $@" > /dev/tty; fi
-	if [ "$1" = 'root_helper' ]; then
-		"$@" >> "$RESULTS" 2>&1
-	else
-		$INSTRUMENT "$@" >> "$RESULTS" 2>&1
-	fi
+	expand_command "$@"
+	echo "====== RUN MAYFAIL ${cmd_array[@]}" >> "$RESULTS" 2>&1
+	if [[ $TEST_LOG =~ tty ]]; then echo "CMD(mayfail): ${cmd_array[@]}" \
+		> /dev/tty; fi
+	"${cmd_array[@]}" >> "$RESULTS" 2>&1
 	ret=$?
 	if [ $ret != 0 ]; then
 		echo "failed (ignored, ret=$ret): $@" >> "$RESULTS"
@@ -234,23 +257,13 @@ run_mayfail()
 # store the output to a variable for further processing.
 run_mayfail_stdout()
 {
-	local spec
-	local ins
-	local ret
-
 	tmp_output=$(mktemp --tmpdir btrfs-progs-test--mayfail-stdtout.XXXXXX)
 
-	ins=$(_get_spec_ins "$@")
-	spec=$(($ins-1))
-	spec=$(_cmd_spec "${@:$spec}")
-	set -- "${@:1:$(($ins-1))}" $spec "${@: $ins}"
-	echo "====== RUN MAYFAIL $@" >> "$RESULTS" 2>&1
-	if [[ $TEST_LOG =~ tty ]]; then echo "CMD(mayfail): $@" > /dev/tty; fi
-	if [ "$1" = 'root_helper' ]; then
-		"$@" 2>&1 > "$tmp_output"
-	else
-		$INSTRUMENT "$@" 2>&1 > "$tmp_output"
-	fi
+	expand_command "$@"
+	echo "====== RUN MAYFAIL ${cmd_array[@]}" >> "$RESULTS" 2>&1
+	if [[ $TEST_LOG =~ tty ]]; then echo "CMD(mayfail): ${cmd_array[@]}" \
+		> /dev/tty; fi
+	"${cmd_array[@]}" 2>&1 > "$tmp_output"
 	ret=$?
 
 	cat "$tmp_output" >> "$RESULTS"
@@ -275,8 +288,6 @@ run_mayfail_stdout()
 # same as run_check but expects the command to fail, output is logged
 run_mustfail()
 {
-	local spec
-	local ins
 	local msg
 
 	msg="$1"
@@ -287,17 +298,12 @@ run_mustfail()
 		exit 1
 	fi
 
-	ins=$(_get_spec_ins "$@")
-	spec=$(($ins-1))
-	spec=$(_cmd_spec "${@:$spec}")
-	set -- "${@:1:$(($ins-1))}" $spec "${@: $ins}"
-	echo "====== RUN MUSTFAIL $@" >> "$RESULTS" 2>&1
-	if [[ $TEST_LOG =~ tty ]]; then echo "CMD(mustfail): $@" > /dev/tty; fi
-	if [ "$1" = 'root_helper' ]; then
-		"$@" >> "$RESULTS" 2>&1
-	else
-		$INSTRUMENT "$@" >> "$RESULTS" 2>&1
-	fi
+
+	expand_command "$@"
+	echo "====== RUN MUSTFAIL ${cmd_array[@]}" >> "$RESULTS" 2>&1
+	if [[ $TEST_LOG =~ tty ]]; then echo "CMD(mustfail): ${cmd_array[@]}" \
+		> /dev/tty; fi
+	"${cmd_array[@]}" >> "$RESULTS" 2>&1
 	if [ $? != 0 ]; then
 		echo "failed (expected): $@" >> "$RESULTS"
 		return 0
@@ -315,8 +321,6 @@ run_mustfail()
 # So it doesn't support pipeline in the @cmd
 run_mustfail_stdout()
 {
-	local spec
-	local ins
 	local msg
 	local ret
 	local tmp_output
@@ -331,17 +335,11 @@ run_mustfail_stdout()
 		exit 1
 	fi
 
-	ins=$(_get_spec_ins "$@")
-	spec=$(($ins-1))
-	spec=$(_cmd_spec "${@:$spec}")
-	set -- "${@:1:$(($ins-1))}" $spec "${@: $ins}"
-	echo "====== RUN MUSTFAIL $@" >> "$RESULTS" 2>&1
-	if [[ $TEST_LOG =~ tty ]]; then echo "CMD(mustfail): $@" > /dev/tty; fi
-	if [ "$1" = 'root_helper' ]; then
-		"$@" 2>&1 > "$tmp_output"
-	else
-		$INSTRUMENT "$@" 2>&1 > "$tmp_output"
-	fi
+	expand_command "$@"
+	echo "====== RUN MUSTFAIL ${cmd_array[@]}" >> "$RESULTS" 2>&1
+	if [[ $TEST_LOG =~ tty ]]; then echo "CMD(mustfail): ${cmd_array[@]}" \
+		> /dev/tty; fi
+	"${cmd_array[@]}" 2>&1 > "$tmp_output"
 	ret=$?
 
 	cat "$tmp_output" >> "$RESULTS"
-- 
2.26.0

