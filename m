Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAECE12F70F
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 12:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgACLTK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 06:19:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44749 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgACLTK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jan 2020 06:19:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so3138833wrm.11;
        Fri, 03 Jan 2020 03:19:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PC7p0XCA5xkdegVJF8IaN8vS8sFvlvdQ36BBUkcqTfE=;
        b=i3Z6PiOeL8yDJKskGGmhWzKgOKfb371wcVgyC62leiSETjpYSsbYG8RNK1Q+bj4KUd
         iHNs0hbzlje8Pg64SwpiqJQJYIChazE77HLOQAINmQyi0wGg3x/QwzixUw3Uz5QPvwS7
         8j1hdos0bSBqimFMZNSMKLoZCV/ugh5ySEVky38BBGwUh1rVUqbUnPh53Mvb/iO7ihSX
         xHZzQdpdIh07pmJgbDS/pWWj9KRsu4gFLCuWP5rUHD6W2/zzLeMyrFaaklQOqs5WbIFs
         P5t7h55Bv4MXK122ppR6KA5afk76M0emu6IaIWrvDMkUl6C6e+TVKA7oFtQnmNX6VxrD
         K51w==
X-Gm-Message-State: APjAAAUu27W084QKwd/uVpKNkVCrJ94daHPqLCTLeNzY9tJ9gvUFvMJg
        F9LqxRulyRWANMs8bOyEUj+wcrfB1/4=
X-Google-Smtp-Source: APXvYqw1Gt8cJYFKfIuueNCaJDz4qYaBR/hwk7FHaJ29lvNuBbNspLro6RfT5yXaAlT6MKG5qA9+Wg==
X-Received: by 2002:adf:eb0a:: with SMTP id s10mr91701679wrn.320.1578050347792;
        Fri, 03 Jan 2020 03:19:07 -0800 (PST)
Received: from linux-t19r.fritz.box (ppp-46-244-218-95.dynamic.mnet-online.de. [46.244.218.95])
        by smtp.gmail.com with ESMTPSA id b17sm57934523wrp.49.2020.01.03.03.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 03:19:07 -0800 (PST)
From:   Johannes Thumshirn <jth@kernel.org>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH] btrfs/140: use proper helpers to get devid and physical offset for corruption
Date:   Fri,  3 Jan 2020 12:18:10 +0100
Message-Id: <20200103111810.658-1-jth@kernel.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Similar to fstests commit 1a27bf14ef8b "btrfs/14[23]: Use proper help to
get both devid and physical offset for corruption." btrfs/140 needs the
same treatment to pass with updated btrfs-progs.

Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 tests/btrfs/140 | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/tests/btrfs/140 b/tests/btrfs/140
index 1c5aa679..2517263b 100755
--- a/tests/btrfs/140
+++ b/tests/btrfs/140
@@ -46,10 +46,26 @@ _require_odirect
 
 get_physical()
 {
-	# $1 is logical address
-	# print chunk tree and find devid 2 which is $SCRATCH_DEV
+	local logical=$1
+	local stripe=$2
 	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
-	grep $1 -A 6 | awk '($1 ~ /stripe/ && $3 ~ /devid/ && $4 ~ /1/) { print $6 }'
+		grep $logical -A 6 | \
+		$AWK_PROG "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$6 }"
+}
+
+get_devid()
+{
+	local logical=$1
+	local stripe=$2
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
+		grep $logical -A 6 | \
+		$AWK_PROG "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /$stripe/) { print \$4 }"
+}
+
+get_device_path()
+{
+	local devid=$1
+	echo "$SCRATCH_DEV_POOL" | $AWK_PROG "{print \$$devid}"
 }
 
 _scratch_dev_pool_get 2
@@ -72,10 +88,16 @@ echo "step 2......corrupt file extent" >>$seqres.full
 
 ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
 logical_in_btrfs=`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_filefrag | cut -d '#' -f 1`
-physical_on_scratch=`get_physical ${logical_in_btrfs}`
+physical=$(get_physical ${logical_in_btrfs} 1)
+devid=$(get_devid ${logical_in_btrfs} 1)
+target_dev=$(get_device_path $devid)
 
 _scratch_unmount
-$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical_on_scratch 64K" $SCRATCH_DEV |\
+$BTRFS_UTIL_PROG ins dump-tree -t 3 $SCRATCH_DEV | \
+	grep $logical_in_btrfs -A 6 >> $seqres.full
+echo "Corrupt stripe 1 devid $devid devpath $target_dev physical $physical" \
+	>> $seqres.full
+$XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $physical 64K" $target_dev |\
 	_filter_xfs_io_offset
 
 _scratch_mount
@@ -96,7 +118,8 @@ done
 _scratch_unmount
 
 # check if the repair works
-$XFS_IO_PROG -d -c "pread -v -b 512 $physical_on_scratch 512" $SCRATCH_DEV |\
+echo "Reading from physical $physical device $target_dev" >> $seqres.full
+$XFS_IO_PROG -c "pread -v -b 512 $physical 512" $target_dev | \
 	_filter_xfs_io_offset
 
 _scratch_dev_pool_put
-- 
2.16.4

