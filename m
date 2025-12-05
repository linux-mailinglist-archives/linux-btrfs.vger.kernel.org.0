Return-Path: <linux-btrfs+bounces-19540-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5FECA65F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 05 Dec 2025 08:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADAC1313DBDC
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Dec 2025 07:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AE2239E7D;
	Fri,  5 Dec 2025 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IUgOXX9m";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DUFd5oBZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF89139579
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Dec 2025 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919076; cv=none; b=BYEWUO+jjlK3kopAUdvljPEtahtEXqRGcQY1qakMUwiy2RZih3HCRB8eqTCwEsp+hjk77PxfksBGivebwUSAM/nfIypgwAOXgK24RYmtohkeyD9MHawwH/ikNzKxhfv75IZiUezgAme4EE1P9oEcKdH7yBtHPDxZ80yan5SPW/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919076; c=relaxed/simple;
	bh=ihQiQy/jjFETQLAT0ej3n5mNTfSvTSjLortugv0ZKeU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nQMIelPxVZr1PEGXQt5BIey2I8eR5okKDV6kQbDaiBWA3ZdW9LcxxaInHDJstnsYvqrg/Hj8aWzYtkPzcPcih7Cqzr9erTMSSPv+joBjS7K+T2de1elJNFUyuURQElqu6I2o97i9MldU7NV4b8KLZU3Y3g80NowwrEkBcBQYGog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IUgOXX9m; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DUFd5oBZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2FEC336CA;
	Fri,  5 Dec 2025 07:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764919068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a/RN6QY/5TFlxFjadMP4dBh9I2iUl+Y/zNSSIozTQTM=;
	b=IUgOXX9mqjp9tqzpyoEEx/K9PgRWzb92uJX6ONlaJHA5GFvh2/T+DD/mff7O2CqiZ/amIl
	oPWd3GdN56Ir6goY+t5Ix5QF9dGJQSMaZDe/qgd5EyxP2BDi6G4DEQ3x1VqZhpTsa60yfv
	SYWvuwCwHDIJfjvVlMA5FmizTqk4COw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DUFd5oBZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764919066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a/RN6QY/5TFlxFjadMP4dBh9I2iUl+Y/zNSSIozTQTM=;
	b=DUFd5oBZ1Jn7rmctds9dEG6ZTMxKf7xl1X4pUq7o/RYcumiZzpl6gBEFefMGHD+C8EzByj
	CXpNnIdYFSoFd24kXB3FgKlPa1UvWArGn6pqkBzBTgffA/eeCg3gk6/gWohH5MqyCO29u4
	Uzl2DkPo9KWNHOMkhQ8rinVeXkFhl9Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D92433EA63;
	Fri,  5 Dec 2025 07:17:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gcEHJhiHMmnMdwAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 05 Dec 2025 07:17:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2] fstests: generic/746: update the parser to handle block group tree
Date: Fri,  5 Dec 2025 17:47:26 +1030
Message-ID: <20251205071726.159577-1-wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: F2FEC336CA
X-Spam-Flag: NO
X-Spam-Score: -4.51

[FALSE ALERT]
The test case will fail on btrfs if the new block-group-tree feature is
enabled:

FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 btrfs-vm 6.18.0-rc6-custom+ #321 SMP PREEMPT_DYNAMIC Sun Nov 23 16:34:33 ACDT 2025
MKFS_OPTIONS  -- -O block-group-tree /dev/mapper/test-scratch1
MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

generic/746 44s ... [failed, exit status 1]- output mismatch (see xfstests-dev/results//generic/746.out.bad)
    --- tests/generic/746.out	2024-06-27 13:55:51.286338519 +0930
    +++ xfstests-dev/results//generic/746.out.bad	2025-11-28 07:47:17.039827837 +1030
    @@ -2,4 +2,4 @@
     Generating garbage on loop...done.
     Running fstrim...done.
     Detecting interesting holes in image...done.
    -Comparing holes to the reported space from FS...done.
    +Comparing holes to the reported space from FS...Sectors 256-2111 are not marked as free!
    ...
    (Run 'diff -u xfstests-dev/tests/generic/746.out xfstests-dev/results//generic/746.out.bad'  to see the entire diff)

[CAUSE]
Sectors [256, 2048) are the from the reserved first 1M free space.
Sectors [2048, 2112) are the leading free space in the chunk tree.
Sectors [2112, 2144) is the first tree block in the chunk tree.

However the reported free sectors from get_free_sectors() looks like this:

  2144 10566
  10688 11711
  ...

Note that there should be a free sector range in [2048, 2112) but it's
not reported in get_free_sectors().

The get_free_sectors() call is fs dependent, and for btrfs it's using
parse-extent-tree.awk script to handle the extent tree dump.

The script uses BLOCK_GROUP_ITEM items to detect the beginning of a
block group so that it can calculate the hole between the beginning of a
block group and the first data/metadata item.

However block-group-tree feature moves BLOCK_GROUP_ITEM items to a
dedicated tree, making the existing script unable to parse the free
space at the beginning of a block group.

[FIX]
Introduce a new script, parse-free-space.py, that accepts two tree
dumps:

- block group tree dump
  If the fs has block-group-tree feature, it's the block group tree
  dump.
  Otherwise the regular extent tree dump is enough.

- extent tree dump
  The usual extent tree dump.

With a dedicated block group tree dump, the script can correctly handle
the beginning part of free space, no matter if block-group-tree feature
is enabled or not.

And with this parser, the old parse-extent-tree.awk can be retired.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add extra requirement for python3 if the fs is btrfs
- Utilize $PYTHON3_PROG other than calling the script directly
- Add the comment on we need single DATA/METADATA profiles
---
 src/parse-extent-tree.awk | 144 --------------------------------------
 src/parse-free-space.py   | 122 ++++++++++++++++++++++++++++++++
 tests/generic/746         |  24 +++++--
 3 files changed, 142 insertions(+), 148 deletions(-)
 delete mode 100755 src/parse-extent-tree.awk
 create mode 100755 src/parse-free-space.py

diff --git a/src/parse-extent-tree.awk b/src/parse-extent-tree.awk
deleted file mode 100755
index 1e69693c..00000000
--- a/src/parse-extent-tree.awk
+++ /dev/null
@@ -1,144 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2019 Nikolay Borisov, SUSE LLC.  All Rights Reserved.
-#
-# Parses btrfs' extent tree for holes. Holes are the ranges between 2 adjacent
-# extent blocks. For example if we have the following 2 metadata items in the
-# extent tree:
-#	item 6 key (30425088 METADATA_ITEM 0) itemoff 16019 itemsize 33
-#	item 7 key (30490624 METADATA_ITEM 0) itemoff 15986 itemsize 33
-#
-# There is a whole of 64k between then - 30490624−30425088 = 65536
-# Same logic applies for adjacent EXTENT_ITEMS.
-#
-# The script requires the following parameters passed on command line:
-#     * sectorsize - how many bytes per sector, used to convert the output of
-#     the script to sectors.
-#     * nodesize - size of metadata extents, used for internal calculations
-
-# Given an extent line "item 2 key (13672448 EXTENT_ITEM 65536) itemoff 16153 itemsize 53"
-# or "item 6 key (30425088 METADATA_ITEM 0) itemoff 16019 itemsize 33" returns
-# either 65536 (for data extents) or the fixes nodesize value for metadata
-# extents.
-function get_extent_size(line, tmp) {
-	if (line ~ data_match || line ~ bg_match) {
-		split(line, tmp)
-		gsub(/\)/,"", tmp[6])
-		return tmp[6]
-	} else if (line ~ metadata_match) {
-		return nodesize
-	}
-}
-
-# given a 'item 2 key (13672448 EXTENT_ITEM 65536) itemoff 16153 itemsize 53'
-# and returns 13672448.
-function get_extent_offset(line, tmp) {
-	split(line, tmp)
-	gsub(/\(/,"",tmp[4])
-	return tmp[4]
-}
-
-# This function parses all the extents belonging to a particular block group
-# which are accumulated in lines[] and calculates the offsets of the holes
-# part of this block group.
-#
-# base_offset and bg_line are local variables
-function print_array(base_offset, bg_line)
-{
-	if (match(lines[0], bg_match)) {
-		# we don't have an extent at the beginning of of blockgroup, so we
-		# have a hole between blockgroup offset and first extent offset
-		bg_line = lines[0]
-		prev_size=0
-		prev_offset=get_extent_offset(bg_line)
-		delete lines[0]
-	} else {
-		# we have an extent at the beginning of block group, so initialize
-		# the prev_* vars correctly
-		bg_line = lines[1]
-		prev_size = get_extent_size(lines[0])
-		prev_offset = get_extent_offset(lines[0])
-		delete lines[1]
-		delete lines[0]
-	}
-
-	bg_offset=get_extent_offset(bg_line)
-	bgend=bg_offset + get_extent_size(bg_line)
-
-	for (i in lines) {
-			cur_size = get_extent_size(lines[i])
-			cur_offset = get_extent_offset(lines[i])
-			if (cur_offset  != prev_offset + prev_size)
-				print int((prev_size + prev_offset) / sectorsize), int((cur_offset-1) / sectorsize)
-			prev_size = cur_size
-			prev_offset = cur_offset
-	}
-
-	print int((prev_size + prev_offset) / sectorsize), int((bgend-1) / sectorsize)
-	total_printed++
-	delete lines
-}
-
-BEGIN {
-	loi_match="^.item [0-9]* key \\([0-9]* (BLOCK_GROUP_ITEM|METADATA_ITEM|EXTENT_ITEM) [0-9]*\\).*"
-	metadata_match="^.item [0-9]* key \\([0-9]* METADATA_ITEM [0-9]*\\).*"
-	data_match="^.item [0-9]* key \\([0-9]* EXTENT_ITEM [0-9]*\\).*"
-	bg_match="^.item [0-9]* key \\([0-9]* BLOCK_GROUP_ITEM [0-9]*\\).*"
-	node_match="^node.*$"
-	leaf_match="^leaf [0-9]* flags"
-	line_count=0
-	total_printed=0
-	skip_lines=0
-}
-
-{
-	# skip lines not belonging to a leaf
-	if (match($0, node_match)) {
-		skip_lines=1
-	} else if (match($0, leaf_match)) {
-		skip_lines=0
-	}
-
-	if (!match($0, loi_match) || skip_lines == 1) next;
-
-	# we have a line of interest, we need to parse it. First check if there is
-	# anything in the array
-	if (line_count==0) {
-		lines[line_count++]=$0;
-	} else {
-		prev_line=lines[line_count-1]
-		split(prev_line, prev_line_fields)
-		prev_objectid=prev_line_fields[4]
-		objectid=$4
-
-		if (objectid == prev_objectid && match($0, bg_match)) {
-			if (total_printed>0) {
-				# We are adding a BG after we have added its first extent
-				# previously, consider this a record ending event and just print
-				# the array
-
-				delete lines[line_count-1]
-				print_array()
-				# we now start a new array with current and previous lines
-				line_count=0
-				lines[line_count++]=prev_line
-				lines[line_count++]=$0
-			} else {
-				# first 2 added lines are EXTENT and BG that match, in this case
-				# just add them
-				lines[line_count++]=$0
-
-			}
-		} else if (match($0, bg_match)) {
-			# ordinary end of record
-			print_array()
-			line_count=0
-			lines[line_count++]=$0
-		} else {
-			lines[line_count++]=$0
-		}
-	}
-}
-
-END {
-	print_array()
-}
diff --git a/src/parse-free-space.py b/src/parse-free-space.py
new file mode 100755
index 00000000..3c761715
--- /dev/null
+++ b/src/parse-free-space.py
@@ -0,0 +1,122 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Parse block group and extent tree output to create a free sector list.
+#
+# Usage:
+#  ./parse-free-space -n <nodesize> -b <bg_dump> -e <extent_dump>
+#
+# nodesize:     The nodesize of the btrfs
+# bg_dump:      The tree dump file that contains block group items
+#               If block-group-tree feature is enabled, it's block group tree dump.
+#               Otherwise it's extent tree dump
+# extent_dump:  The tree dump file that contains extent items
+#               Just the extent tree dump, requires all tree block and data have
+#               corresponding extent/metadata item.
+#
+# The output is "%d %d", the first one is the sector number (in 512 byte) of the
+# free space, the second one is the last sector number of the free range.
+
+import getopt
+import sys
+import re
+
+bg_match = "^.item [0-9]* key \\([0-9]* BLOCK_GROUP_ITEM [0-9]*\\).*"
+metadata_match="^.item [0-9]* key \\([0-9]* METADATA_ITEM [0-9]*\\).*"
+data_match="^.item [0-9]* key \\([0-9]* EXTENT_ITEM [0-9]*\\).*"
+
+def parse_block_groups(file_path):
+    bg_list = []
+    with open(file_path, 'r') as bg_file:
+        for line in bg_file:
+            match = re.search(bg_match, line)
+            if match == None:
+                continue
+            start = match.group(0).split()[3][1:]
+            length = match.group(0).split()[5][:-1]
+            bg_list.append({'start': int(start), 'length': int(length)})
+    return sorted(bg_list, key=lambda d: d['start'])
+
+def parse_extents(file_path):
+    extent_list = []
+    with open(file_path, 'r') as bg_file:
+        for line in bg_file:
+            match = re.search(data_match, line)
+            if match:
+                start = match.group(0).split()[3][1:]
+                length = match.group(0).split()[5][:-1]
+                extent_list.append({'start': int(start), 'length': int(length)})
+                continue
+            match = re.search(metadata_match, line)
+            if match:
+                start = match.group(0).split()[3][1:]
+                length = nodesize
+                extent_list.append({'start': int(start), 'length': int(length)})
+                continue
+    return sorted(extent_list, key=lambda d: d['start'])
+
+def range_end(range):
+    return range['start'] + range['length']
+
+def calc_free_spaces(bg_list, extent_list):
+    free_list = []
+    bg_iter = iter(bg_list)
+    cur_bg = next(bg_iter)
+    prev_end = cur_bg['start']
+
+    for cur_extent in extent_list:
+        # Finished one bg, add the remaining free space.
+        while range_end(cur_bg) <= cur_extent['start']:
+            if range_end(cur_bg) > prev_end:
+                free_list.append({'start': prev_end,
+                                  'length': range_end(cur_bg) - prev_end})
+            cur_bg = next(bg_iter)
+            prev_end = cur_bg['start']
+
+        if prev_end < cur_extent['start']:
+            free_list.append({'start': prev_end,
+                              'length': cur_extent['start'] - prev_end})
+        prev_end = range_end(cur_extent)
+
+    # Handle the remaining part in the bg
+    if range_end(cur_bg) > prev_end:
+        free_list.append({'start': prev_end,
+                          'length': range_end(cur_bg) - prev_end})
+
+    # Handle the remaining empty bgs (if any)
+    for cur_bg in bg_iter:
+        free_list.append({'start': cur_bg['start'],
+                          'length': cur_bg['length']})
+
+
+    return free_list
+
+nodesize = 0
+sectorsize = 512
+bg_file_path = ''
+extent_file_path = ''
+
+opts, args = getopt.getopt(sys.argv[1:], 's:n:b:e:')
+for o, a in opts:
+    if o == '-n':
+        nodesize = int(a)
+    elif o == '-b':
+        bg_file_path = a
+    elif o == '-e':
+        extent_file_path = a
+    elif o == '-s':
+        sectorsize = int(a)
+
+if nodesize == 0 or sectorsize == 0:
+    print("require -n <nodesize> and -s <sectorsize>")
+    sys.exit(1)
+if not bg_file_path or not extent_file_path:
+    print("require -b <bg_file> and -e <extent_file>")
+    sys.exit(1)
+
+bg_list = parse_block_groups(bg_file_path)
+extent_list = parse_extents(extent_file_path)
+free_space_list = calc_free_spaces(bg_list, extent_list)
+for free_space in free_space_list:
+    print(free_space['start'] >> 9,
+          (range_end(free_space) >> 9) - 1)
diff --git a/tests/generic/746 b/tests/generic/746
index 6f02b1cc..4eb4252b 100755
--- a/tests/generic/746
+++ b/tests/generic/746
@@ -93,13 +93,23 @@ get_free_sectors()
 			| sed -n 's/nodesize\s*\(.*\)/\1/p')
 
 		# Get holes within block groups
-		$BTRFS_UTIL_PROG inspect-internal dump-tree -t extent $loop_dev \
-			| $AWK_PROG -v sectorsize=512 -v nodesize=$nodesize -f $here/src/parse-extent-tree.awk
+		$BTRFS_UTIL_PROG inspect-internal dump-tree -t extent $loop_dev >> $tmp/extent_dump
+		if $BTRFS_UTIL_PROG inspect-internal dump-super $loop_dev |\
+				grep -q "BLOCK_GROUP_TREE"; then
+			$BTRFS_UTIL_PROG inspect-internal dump-tree -t block-group $loop_dev \
+				>> $tmp/bg_dump
+		else
+			cp $tmp/extent_dump $tmp/bg_dump
+		fi
+		$PYTHON3_PROG $here/src/parse-free-space.py -n $nodesize -b $tmp/bg_dump \
+			-e $tmp/extent_dump >> $tmp/bg_free_space
 
 		# Get holes within unallocated space on disk
 		$BTRFS_UTIL_PROG inspect-internal dump-tree -t dev $loop_dev \
-			| $AWK_PROG -v sectorsize=512 -v devsize=$device_size -f $here/src/parse-dev-tree.awk
+			| $AWK_PROG -v sectorsize=512 -v devsize=$device_size \
+			  -f $here/src/parse-dev-tree.awk >> $tmp/unallocated
 
+		cat $tmp/bg_free_space $tmp/unallocated | sort
 	;;
 	esac
 }
@@ -157,7 +167,13 @@ merged_sectors="$tmp/merged_free_sectors"
 mkdir $loop_mnt
 
 [ "$FSTYP" = "xfs" ] && MKFS_OPTIONS="-f $MKFS_OPTIONS"
-[ "$FSTYP" = "btrfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -f -dsingle -msingle"
+if [ "$FSTYP" = "btrfs" ]; then
+	# Only SINGLE chunks have their logical address 1:1 mapped
+	# to physical addresses.
+	MKFS_OPTIONS="$MKFS_OPTIONS -f -dsingle -msingle"
+	_require_command $PYTHON3_PROG python3
+fi
+
 
 _mkfs_dev $loop_dev
 _mount $loop_dev $loop_mnt
-- 
2.51.2


