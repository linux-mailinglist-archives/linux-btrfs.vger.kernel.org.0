Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DF73EA3C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 13:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhHLLbm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 07:31:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47992 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbhHLLbl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 07:31:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3B3F1221F9;
        Thu, 12 Aug 2021 11:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628767875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Z+YuBZZqq+Ls7Efh6BpyiBwW4arUOhHA3XcxpOwBo1s=;
        b=V2G/mouY8oBZ+B78gvZ1c0X9ZEbrSFHDBLjeArjT+TurOstkdOB1cQDLOyiJdbONCMDRNr
        DfH/MGe+z+NqdtCGcdJpZM6mNTptYWqAcZeBL8DmX2o8fVlQRDfhjrOsKbgCwnAPdipXfY
        zVn9TL3IsSB/Xe4KZBfYOVRdcGBJB1o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6354E13C44;
        Thu, 12 Aug 2021 11:31:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RWSdCoEGFWGxWgAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Thu, 12 Aug 2021 11:31:13 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     dsterba@suse.com, guaneryu@gmail.com, wqu@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v4] btrfs/177: Handle the different fi resize output formats
Date:   Thu, 12 Aug 2021 08:30:48 -0300
Message-Id: <20210812113048.12720-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 78aa1d95dd99 ("btrfs-progs: fi resize: make output more
readable") added the device id of the resized fs along with a pretty
printed size. Create a new function to simplify the output message using
size in bytes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---

 Changes since v3:
 * Move the new function outside of the btrfs.filter, since it's meant to fix
   only this problem now. (Qu)

 Changes since v2:
 * Check the output to verify if the resize really happened (Qu)

 Changes since v1:
 * Do not adapt the output message to the newer format (Qu)

 tests/btrfs/177     | 33 ++++++++++++++++++++++++++++++---
 tests/btrfs/177.out |  4 ++--
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/tests/btrfs/177 b/tests/btrfs/177
index 966d29d7..3c206140 100755
--- a/tests/btrfs/177
+++ b/tests/btrfs/177
@@ -16,6 +16,32 @@ _begin_fstest auto quick swap balance
 _supported_fs btrfs
 _require_scratch_swapfile
 
+# Eliminate the differences between the old and new output formats
+# Old format:
+# 	Resize 'SCRATCH_MNT' of '1073741824'
+# New format:
+# 	Resize device id 1 (SCRATCH_DEV) from 3.00GiB to 1.00GiB
+# Convert both outputs to:
+# 	Resized to 1073741824
+_convert_resize_output()
+{
+        local _field
+        local _val
+        local _suffix
+        _field=`$AWK_PROG '{print $NF}' | tr -d "'"`
+        # remove trailing zeroes
+        _val=`echo $_field | $AWK_PROG '{print $1 * 1}'`
+        # get the first unit char, for example return G in case we have GiB
+        _suffix=`echo $_field | grep -o "[GMB]"`
+        if [ -z "$_suffix" ]; then
+                _suffix="B"
+        fi
+        _val=`echo "$_val$_suffix" | _filter_size_to_bytes`
+	echo "Resized to $_val"
+}
+
+
+
 swapfile="$SCRATCH_MNT/swap"
 
 _require_scratch_size $((3 * 1024 * 1024)) #kB
@@ -36,8 +62,8 @@ dd if=/dev/zero of="$SCRATCH_MNT/refill" bs=4096 >> $seqres.full 2>&1
 # Now add more space and create a swap file. We know that the first $fssize
 # of the filesystem was used, so the swap file must be in the new part of the
 # filesystem.
-$BTRFS_UTIL_PROG filesystem resize $((3 * fssize)) "$SCRATCH_MNT" | \
-							_filter_scratch
+$BTRFS_UTIL_PROG filesystem resize $((3 * fssize)) "$SCRATCH_MNT" |
+						_convert_resize_output
 _format_swapfile "$swapfile" $((32 * 1024 * 1024))
 swapon "$swapfile"
 
@@ -55,7 +81,8 @@ $BTRFS_UTIL_PROG filesystem resize 1G "$SCRATCH_MNT" 2>&1 | grep -o "Text file b
 swapoff "$swapfile"
 
 # It should work again after swapoff.
-$BTRFS_UTIL_PROG filesystem resize $fssize "$SCRATCH_MNT" | _filter_scratch
+$BTRFS_UTIL_PROG filesystem resize $fssize "$SCRATCH_MNT" |
+						_convert_resize_output
 
 status=0
 exit
diff --git a/tests/btrfs/177.out b/tests/btrfs/177.out
index 63aca0e5..eb374d34 100644
--- a/tests/btrfs/177.out
+++ b/tests/btrfs/177.out
@@ -1,4 +1,4 @@
 QA output created by 177
-Resize 'SCRATCH_MNT' of '3221225472'
+Resized to 3221225472
 Text file busy
-Resize 'SCRATCH_MNT' of '1073741824'
+Resized to 1073741824
-- 
2.31.1

