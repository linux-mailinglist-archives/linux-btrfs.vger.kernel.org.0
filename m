Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 451C713ED38
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 19:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394901AbgAPSBM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 13:01:12 -0500
Received: from snd00005.auone-net.jp ([111.86.247.5]:62689 "EHLO
        dmta0002.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2394878AbgAPSBK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 13:01:10 -0500
Received: from ppp.dion.ne.jp by dmta0002.auone-net.jp with ESMTP
          id <20200116180107663.NIUO.69338.ppp.dion.ne.jp@dmta0002.auone-net.jp>;
          Fri, 17 Jan 2020 03:01:07 +0900
Date:   Fri, 17 Jan 2020 03:01:07 +0900
From:   Kusanagi Kouichi <slash@ac.auone-net.jp>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Implement lazytime
References: <20200114085325045.JFBE.12086.ppp.dion.ne.jp@dmta0008.auone-net.jp>
 <20200114212107.GM3929@twin.jikos.cz>
 <20200115134536820.LBFZ.46476.ppp.dion.ne.jp@dmta0009.auone-net.jp>
 <20200115163128.GT3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20200115163128.GT3929@twin.jikos.cz>
Message-Id: <20200116180107663.NIUO.69338.ppp.dion.ne.jp@dmta0002.auone-net.jp>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2020-01-15 17:31:28 +0100, David Sterba wrote:
> On Wed, Jan 15, 2020 at 10:45:36PM +0900, Kusanagi Kouichi wrote:
> > On 2020-01-14 22:21:07 +0100, David Sterba wrote:
> > > On Tue, Jan 14, 2020 at 05:53:24PM +0900, Kusanagi Kouichi wrote:
> > > > I tested with xfstests and lazytime didn't cause any new failures.
> > > 
> > > The changelog should describe what the patch does (the 'why' part too,
> > > but this is obvious from the subject in this case). That fstests pass
> > > without new failures is nice but there should be a specific test for
> > > that or instructions in the changelog how to test.
> > 
> > To test lazytime, I set the following variables:
> > TEST_FS_MOUNT_OPTS="-o lazytime,space_cache=v2"
> > MOUNT_OPTIONS="-o lazytime,space_cache=v2"
> 
> How did you verify that the lazy time updates were applied properly?

I ran the attached test.

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lazytime-test.diff"

diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 00000000..781b37c5
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,76 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Kusanagi Kouichi.  All Rights Reserved.
+#
+# FS QA Test 999
+#
+# Test timestamp is persistent across umount.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+check_persist()
+{
+    ls "$SCRATCH_MNT" > /dev/null
+    before="$(stat -c '%x %y %z' "$SCRATCH_MNT")"
+    $XFS_IO_PROG -c "$1" "$SCRATCH_MNT"
+    _scratch_cycle_mount strictatime
+    after="$(stat -c '%x %y %z' "$SCRATCH_MNT")"
+    if test "$before" != "$after"
+    then
+	echo "timestamp didn't persist across umount."
+	echo "ls $1"
+	echo "before $before"
+	echo "after  $after"
+	exit
+    fi
+}
+
+check_persist ''
+check_persist fsync
+check_persist syncfs
+check_persist sync
+
+"$FSSTRESS_PROG" -d "$SCRATCH_MNT" -v $(_scale_fsstress_args -n 1000 -p 2) > "$tmp".fsstress
+find "$SCRATCH_MNT" ! -type d -exec stat -c '%x %y %z %i %F %n' '{}' + > "$tmp".before
+_scratch_cycle_mount
+find "$SCRATCH_MNT" ! -type d -exec stat -c '%x %y %z %i %F %n' '{}' + > "$tmp".after
+if ! diff -u "$tmp".before "$tmp".after
+then
+    echo "timestamp didn't persist across umount after fsstress."
+    cat "$tmp".fsstress
+    exit
+fi
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 00000000..7fbc6768
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1 @@
+QA output created by 999
diff --git a/tests/generic/group b/tests/generic/group
index 6fe62505..7879eb70 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -595,3 +595,4 @@
 590 auto prealloc preallocrw
 591 auto quick rw pipe splice
 592 auto quick encrypt
+999 auto quick

--pf9I7BMVVzbSWLtt--
