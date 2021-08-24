Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56673F685F
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 19:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbhHXRsi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 13:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbhHXRsc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 13:48:32 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63755C02519B
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Aug 2021 10:05:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso2783304pjq.4
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Aug 2021 10:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:signed-off-by;
        bh=dMaO1l8+EpNRB86nMLDc5nQcnZBOn+cLHhHRwBXY0Pw=;
        b=JGD3wweInEAYEiy2jI4OEkAEB1epfQwBkfpyrD9TK/fi/hwaxMOqTXlHCWNWOj6pVZ
         sJ2avkpUOlPJat1iv1R9NVUhuvr4darQNdbgU4JUq47s+fPQ+EGqrj8l0QMt/a1GqLQ/
         UMUUURN4sx/eCLHYruYu5HNCDPvVxADbefzsbq6XnTguDvBnnt//93PtZ65gIiYEr3zQ
         DJLazzOx9Ji8bDVc4Pvz/UXfAZMbfsnv38omqKlAMiD7cA91czxzbsfQY/x+aBsuEsyq
         eh1chtXusTsjurjKOmN4iJceVePNXwhNgR4TCd/aVUEmMH9cjuWc2hhRmdgA8rHIfcFm
         0TSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:signed-off-by;
        bh=dMaO1l8+EpNRB86nMLDc5nQcnZBOn+cLHhHRwBXY0Pw=;
        b=I0EfIazk8oZShRwQa8Ijm/SFmALX1+rEzJxFT62gdkW1UZxlmUt+AXLBrRReiqSbXZ
         UDFZpv2BBc2QihK5d3Xf4YfRfAFpQTkkEalf9K73rVkeshv1UZDYPyGdOvykhD5SSBa5
         2720wmJsQfNIFVX7cKDOa70BGskuvi5WRQ8DfyorIZovBADj67Fc4BhcEuU91EhHVZHU
         C0MoRQqU2YFbAvUh9Il0mC3WX6q1wJ4OEC235qG43u/YQLRKYjFtYs00tD7s0C4wg3WL
         bfi8lipt3lb2rSqvDTE06Fd1LoQrTnO328RhUQc44lqEJfpI1qMmOIzAn/OsdA1+D3G9
         YnFw==
X-Gm-Message-State: AOAM531uRy/l1xFrUufSxod6vw0HpWp4XveMG1kjtEh10RfC2+sa0lQ4
        Ymn52AkFzqhERL5sI6WFJGJScoyGYBn+T/hBEksL6w==
X-Google-Smtp-Source: ABdhPJx54jglHqSk95r0SEakCsi6zKjTypAKG6w3hYxDbzTQdKcEKF9ou8GvZ548tx607gVyIgGI+Q==
X-Received: by 2002:a17:90b:1b47:: with SMTP id nv7mr5409853pjb.182.1629824755572;
        Tue, 24 Aug 2021 10:05:55 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([113.99.5.109])
        by smtp.gmail.com with ESMTPSA id k22sm19224571pff.154.2021.08.24.10.05.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:05:55 -0700 (PDT)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH] btrfs-progs: Fix the issues btrfs-convert don't recognition ext4  i_{a,c,a}time_extra
Date:   Wed, 25 Aug 2021 01:04:47 +0800
Message-Id: <1629824687-21014-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I ran convert-tests.sh, and it reported that the
019-ext4-copy-timestamps test failed. The log  is as
follows

...
mount -o loop -t ext4 btrfs-progs/tests/test.img btrfs-progs/tests/mnt
====== RUN CHECK touch btrfs-progs/tests/mnt/file
====== RUN CHECK stat btrfs-progs/tests/mnt/file
File: 'btrfs-progs/tests/mnt/file'
Size: 0           Blocks: 0          IO Block: 4096   regular empty file
Device: 700h/1792d  Inode: 13          Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Context: unconfined_u:object_r:unlabeled_t:s0
Access: 2021-08-24 22:10:21.999209679 +0800
Modify: 2021-08-24 22:10:21.999209679 +0800
Change: 2021-08-24 22:10:21.999209679 +0800
...
btrfs-progs/btrfs-convert btrfs-progs/tests/test.img
...
====== RUN CHECK mount -t btrfs -o loop btrfs-progs/tests/test.img btrfs-progs/tests/mnt
====== RUN CHECK stat btrfs-progs/tests/mnt/file
File: 'btrfs-progs/tests/mnt/file'
Size: 0           Blocks: 0          IO Block: 4096   regular empty file
Device: 2ch/44d Inode: 267         Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Context: unconfined_u:object_r:unlabeled_t:s0
Access: 2021-08-24 22:10:21.000000000 +0800
Modify: 2021-08-24 22:10:21.000000000 +0800
Change: 2021-08-24 22:10:21.000000000 +0800
...
atime on converted inode does not match
test failed for case 019-ext4-copy-timestamps

Obviously, the log says that btrfs-convert does not
support nanoseconds. I looked at the source code and
found that only if ext2_fs.h defines EXT4_EPOCH_MASK
btrfs-convert to support nanoseconds. But in e2fsprogs,
EXT4_EPOCH_MASK was introduced in v1.43, but in some
older versions, such as v1.40, e2fsprogs actually
supports nanoseconds. It seems that if struct ext2_inode_large
contains the i_atime_extra member, ext4 is supports
nanoseconds, so I updated the logic to determine whether the
current ext4 file system supports nanosecond precision.
In addition, I imported some definitions to encode and
decode tv_nsec (copied from e2fsprogs source code).
---
 configure.ac | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index c4fa461..20297c5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -253,7 +253,21 @@ AX_CHECK_DEFINE([linux/fiemap.h], [FIEMAP_EXTENT_SHARED], [],
 AX_CHECK_DEFINE([ext2fs/ext2_fs.h], [EXT4_EPOCH_MASK],
 		[AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [1],
 			   [Define to 1 if e2fsprogs defines EXT4_EPOCH_MASK])],
-		[AC_MSG_WARN([no definition of EXT4_EPOCH_MASK found, probably old e2fsprogs, no 64bit time precision of converted images])])
+        [have_ext4_epoch_mask_define=no])
+
+AS_IF([test "x$have_ext4_epoch_mask_define" = xno], [
+    AC_CHECK_MEMBERS([struct ext2_inode_large.i_atime_extra],
+        [
+            AC_DEFINE([HAVE_EXT4_EPOCH_MASK_DEFINE], [1], [Define to 1 if ext2_inode_large includes i_atime_extra]),
+            AC_DEFINE([EXT4_EPOCH_BITS], [2],[for encode and decode tv_nsec in ext2 inode]),
+            AC_DEFINE([EXT4_EPOCH_MASK], [((1 << EXT4_EPOCH_BITS) - 1)], [For encode and decode tv_nsec info in ext2 inode]),
+            AC_DEFINE([EXT4_NSEC_MASK],  [(~0UL << EXT4_EPOCH_BITS)], [For encode and decode tv_nsec info in ext2 inode]),
+            AC_DEFINE([inode_includes(size, field)],[m4_normalize[(size >= (sizeof(((struct ext2_inode_large *)0)->field) + offsetof(struct ext2_inode_large, field)))]],
+                [For encode and decode tv_nsec info in ext2 inode])
+        ],
+        [AC_MSG_WARN([It seems that ext2_inode_large don't includes tv_nsec related info, probably old e2fsprogs, no 64bit time precision of converted images])],
+        [[#include <ext2fs/ext2_fs.h>]])
+])
 
 AC_CHECK_HEADER(linux/blkzoned.h, [blkzoned_found=yes], [blkzoned_found=no])
 AC_CHECK_MEMBER([struct blk_zone.capacity], [blkzoned_capacity=yes], [blkzoned_capacity=no], [[#include <linux/blkzoned.h>]])
-- 
1.8.3.1


Best regards,
Li
