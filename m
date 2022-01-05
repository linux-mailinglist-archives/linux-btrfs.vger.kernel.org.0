Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B365D48539D
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 14:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbiAENdK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 08:33:10 -0500
Received: from michael.mail.tiscali.it ([213.205.33.246]:38362 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233322AbiAENdI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jan 2022 08:33:08 -0500
Received: from venice.bhome ([84.220.25.125])
        by michael.mail.tiscali.it with 
        id f1Z22602T2hwt04011Z3Ym; Wed, 05 Jan 2022 13:33:04 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH][TRIVIAL] btrfs-progs: Allow autodetect_object_types() to handle the link.
Date:   Wed,  5 Jan 2022 14:32:58 +0100
Message-Id: <f4345fcac83ba226efdadcd4610861e434f8a73e.1641389199.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1641389584; bh=5Ad/PnzLZcwGugFcwiiN39s2DKDOcrWoesGI31DAv7s=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=QkxRFITcIDDukZe5YxObCCW6H2n9cpAFMG3fNf5i/NB092gDKZDtKbrDo2wYlOzU0
         ST++ZC7VRJHYUUNM9y/zxeR0/4Xcym0Lmu/Hm6gf186JcFx096KuGfEbvZCe9nkP7D
         08eytEBTel/n1H7YaMPfCXvfUme0cAiwrLz7MBoc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>


Hi All,

Boris Burkov reported a problem when "btrfs prop get" is invoked on a link of a block
device. This happens when btrfs is invoked on a LVM device (which typically is
a link with an user friendly name to the real block device). In this case btrfs
reports 'ERROR: object is not a btrfs object'.

------------------
Steps to reproduce:

$ sudo losetup -f disk-1.img 
$ sudo losetup -f disk-2.img 
$ sudo losetup -O NAME,BACK-FILE
NAME       BACK-FILE
/dev/loop1 /home/ghigo/test-allocation-hint/disk-2.img
/dev/loop0 /home/ghigo/test-allocation-hint/disk-1.img
                                  
$ cd /dev/
$ mv loop1 loop1-tmp
$ ln -sf loop1-tmp loop1
$ ls -l /dev/loop[01]*
brw-rw---- 1 root disk 7, 0 Jan  5 13:42 /dev/loop0
lrwxrwxrwx 1 root root    9 Jan  5 13:41 /dev/loop1 -> loop1-tmp
brw-rw---- 1 root disk 7, 1 Jan  5 13:42 /dev/loop1-tmp

$ sudo mkfs.btrfs /dev/loop[0-1]
[....]
$ sudo mount /dev/loop1 mnt/

$ # this is the error
$ sudo btrfs prop get /dev/loop1
ERROR: object is not a btrfs object: /dev/loop1

$ # this is what should happen
$ sudo btrfs prop get /dev/loop0
label=

------------------

The cause is in the function autodetect_object_types() that detects the type of
btrfs object passed. If the object is an "inode" type (e.g. file, link...) it
returns the type of object. If the object is a block device (it doesn't matter
if it is in a btrfs filesystem), it returns it as block device.
However it doesn't handle well the case where the object passed is a link
to a block device (which could be a valid btrfs object). For example
LVM/DM creates link to block devices.

This patch adds a further call to stat() (instead of reusing the previous lstat()
returned value) when btrfs-progs checks if the object is a block device.

Reported-by: Boris Burkov <boris@bur.io>
Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 cmds/property.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/cmds/property.c b/cmds/property.c
index 59ef997c..97dc5ae1 100644
--- a/cmds/property.c
+++ b/cmds/property.c
@@ -391,6 +391,14 @@ static int autodetect_object_types(const char *object, int *types_out)
 			types |= prop_object_root;
 	}
 
+	/*
+	 * Do a new stat to follow a possible link
+	 */
+	ret = stat(object, &st);
+	if (ret < 0) {
+		ret = -errno;
+		goto out;
+	}
 	if (S_ISBLK(st.st_mode))
 		types |= prop_object_dev;
 
-- 
2.34.1

