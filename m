Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE2B8190B8B
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 11:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCXKxX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 06:53:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:33674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbgCXKxW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 06:53:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1CB6DB210
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Mar 2020 10:53:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs-progs: tests/common: Don't call INSTRUMENT on mount command
Date:   Tue, 24 Mar 2020 18:53:10 +0800
Message-Id: <20200324105315.136569-2-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324105315.136569-1-wqu@suse.com>
References: <20200324105315.136569-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
With INSTRUMENT=valgrind set, some fsck tests will fail, e.g. fsck/013:
  ====== RUN CHECK mount -t btrfs -o loop /home/adam/btrfs/btrfs-progs/tests//test.img /home/adam/btrfs/btrfs-progs/tests//mnt
  ==114106==
  ==114106== Warning: Can't execute setuid/setgid/setcap executable: /usr/bin/mount
  ==114106== Possible workaround: remove --trace-children=yes, if in effect
  ==114106==
  valgrind: /usr/bin/mount: Permission denied
  failed: mount -t btrfs -o loop /home/adam/btrfs/btrfs-progs/tests//test.img /home/adam/btrfs/btrfs-progs/tests//mnt
  test failed for case 013-extent-tree-rebuild

[CAUSE]
Just as stated by valgrind itself, it can't handle program with
setuid/setgid/setcap.

Thankfully in our case it's mount and we don't really care about it at
all.

[FIX]
Although we could use complex skip pattern to skip mount in valgrind, we
don't really want to run valgrind on mount or sudo command anyway.

So here we do extra check if we're running mount command. And if that's
the case, just skip $INSTRUMENT command.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/common | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/common b/tests/common
index e04ceeb6ccbe..71661e950db0 100644
--- a/tests/common
+++ b/tests/common
@@ -154,7 +154,13 @@ run_check()
 	set -- "${@:1:$(($ins-1))}" $spec "${@: $ins}"
 	echo "====== RUN CHECK $@" >> "$RESULTS" 2>&1
 	if [[ $TEST_LOG =~ tty ]]; then echo "CMD: $@" > /dev/tty; fi
-	if [ "$1" = 'root_helper' ]; then
+
+	# If the command is `root_helper` or mount/umount, don't call INSTRUMENT
+	# as most profiling tool like valgrind can't handle setuid/setgid/setcap
+	# which mount normally has.
+	# And since mount/umount is only called with run_check(), we don't need
+	# to do the same check on other run_*() functions.
+	if [ "$1" = 'root_helper' -o "$1" = 'mount' -o "$1" = 'umount' ]; then
 		"$@" >> "$RESULTS" 2>&1 || _fail "failed: $@"
 	else
 		$INSTRUMENT "$@" >> "$RESULTS" 2>&1 || _fail "failed: $@"
-- 
2.25.2

