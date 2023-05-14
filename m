Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D965701D2A
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 May 2023 13:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjENL6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 May 2023 07:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENL6P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 May 2023 07:58:15 -0400
X-Greylist: delayed 493 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 May 2023 04:58:12 PDT
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E782173C
        for <linux-btrfs@vger.kernel.org>; Sun, 14 May 2023 04:58:12 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4QK15J104cz1sB7b;
        Sun, 14 May 2023 13:49:56 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4QK15J0Cjvz1qqlS;
        Sun, 14 May 2023 13:49:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id UB-dtW7ziBo8; Sun, 14 May 2023 13:49:54 +0200 (CEST)
Received: from babic.homelinux.org (host-88-217-136-221.customer.m-online.net [88.217.136.221])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPS;
        Sun, 14 May 2023 13:49:54 +0200 (CEST)
Received: from localhost (mail.babic.homelinux.org [127.0.0.1])
        by babic.homelinux.org (Postfix) with ESMTP id 2C2374540C94;
        Sun, 14 May 2023 13:49:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at babic.homelinux.org
Received: from babic.homelinux.org ([127.0.0.1])
        by localhost (mail.babic.homelinux.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3U8DWC0ZL38O; Sun, 14 May 2023 13:49:51 +0200 (CEST)
Received: from paperino.fritz.box (paperino.fritz.box [192.168.178.48])
        by babic.homelinux.org (Postfix) with ESMTP id 57C454540B61;
        Sun, 14 May 2023 13:49:51 +0200 (CEST)
From:   Stefano Babic <sbabic@denx.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Stefano Babic <sbabic@denx.de>
Subject: [RFC PATCH] Makefile: add library for mkfs.btrfs
Date:   Sun, 14 May 2023 13:49:30 +0200
Message-Id: <20230514114930.285147-1-sbabic@denx.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Even if mkfs.btrfs can be executed from a shell, there are conditions
(see the reasons for the creation of libbtrfsutil) to call a function
inside own applicatiuon code (security, better control, etc.).

Create a libmkfsbtrfs library with min_mkfs as entry point and the same
syntax like mkfs.btrfs. This can be linked to applications requiring to
create the filesystem.

Signed-off-by: Stefano Babic <sbabic@denx.de>
---

This requires some explanation. Goal is to export mkfs.btrfs as library
to let it be be called from an application. There are use cases in embedded systems
where this is desired and the reasons are exactly the same
that lead to libbtrfsutil. I can shell out mkfs.btrfs, but this is not
the best option (security if shell is compromised, dependency that mkfs is available,
having a self contained application, output format not parsable, etc.).

For all these reasons, a library that creates a btrfs filesystem is desired.
The patch here just export mkfs.btrfs in the busybox way, that is exports mkfs_main(),
and just builds a library. It does not touch existing code (Makefile).

Agree that this can be just used by other Open Source projects that are compliant with
GPLv2, but this is exactly my use case :-).

I would like to know if such as extension can be accepted, even if I know
this is not a topic for most Linux distributions.


 Makefile | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 4b0a869b..af71f833 100644
--- a/Makefile
+++ b/Makefile
@@ -247,12 +247,13 @@ libbtrfsutil_objects = libbtrfsutil/errors.o libbtrfsutil/filesystem.o \
 convert_objects = convert/main.o convert/common.o convert/source-fs.o \
 		  convert/source-ext2.o convert/source-reiserfs.o \
 		  mkfs/common.o
-mkfs_objects = mkfs/main.o mkfs/common.o mkfs/rootdir.o
+mkfs_objects = mkfs/common.o mkfs/rootdir.o
+mkfsmain_objects = mkfs/main.o
 image_objects = image/main.o image/sanitize.o
 tune_objects = tune/main.o tune/seeding.o tune/change-uuid.o tune/change-metadata-uuid.o \
 	       tune/convert-bgt.o tune/change-csum.o
 all_objects = $(objects) $(cmds_objects) $(libbtrfs_objects) $(convert_objects) \
-	      $(mkfs_objects) $(image_objects) $(tune_objects) $(libbtrfsutil_objects)
+	      $(mkfs_objects) $(mkfsmain_objects) $(image_objects) $(tune_objects) $(libbtrfsutil_objects)

 udev_rules = 64-btrfs-dm.rules 64-btrfs-zoned.rules

@@ -320,8 +321,8 @@ MAKEOPTS = --no-print-directory Q=$(Q)
 progs_box_main = btrfs.o mkfs/main.o image/main.o convert/main.o \
 		 tune/main.o

-progs_box_all_objects = $(mkfs_objects) $(image_objects) $(convert_objects) $(tune_objects)
-progs_box_all_static_objects = $(static_mkfs_objects) $(static_image_objects) \
+progs_box_all_objects = $(mkfs_objects) $(mkfsmain_objects) $(image_objects) $(convert_objects) $(tune_objects)
+progs_box_all_static_objects = $(static_mkfs_objects) $(static_mkfsmain_objects) $(static_image_objects) \
 			       $(static_convert_objects) $(static_tune_objects)

 progs_box_objects = $(filter-out %/main.o, $(progs_box_all_objects)) \
@@ -396,17 +397,18 @@ static_libbtrfs_objects = $(patsubst %.o, %.static.o, $(shared_objects))
 static_libbtrfsutil_objects = $(patsubst %.o, %.static.o, $(libbtrfsutil_objects))
 static_convert_objects = $(patsubst %.o, %.static.o, $(convert_objects))
 static_mkfs_objects = $(patsubst %.o, %.static.o, $(mkfs_objects))
+static_mkfsmain_objects = $(patsubst %.o, %.static.o, $(mkfsmain_objects))
 static_image_objects = $(patsubst %.o, %.static.o, $(image_objects))
 static_tune_objects = $(patsubst %.o, %.static.o, $(tune_objects))

-libs_shared = libbtrfs.so.0.1 libbtrfsutil.so.$(libbtrfsutil_version)
+libs_shared = libbtrfs.so.0.1 libbtrfsutil.so.$(libbtrfsutil_version) # libmkfsbtrfs.so.0.1
 lib_links = libbtrfs.so.0 libbtrfs.so libbtrfsutil.so.$(libbtrfsutil_major) libbtrfsutil.so
 libs_build =
 ifeq ($(BUILD_SHARED_LIBRARIES),1)
 libs_build += $(libs_shared) $(lib_links)
 endif
 ifeq ($(BUILD_STATIC_LIBRARIES),1)
-libs_build += libbtrfs.a libbtrfsutil.a
+libs_build += libbtrfs.a libbtrfsutil.a libmkfsbtrfs.a
 endif

 # make C=1 to enable sparse
@@ -548,7 +550,7 @@ endif
 # NOTE: For static compiles, you need to have all the required libs
 # 	static equivalent available
 #
-static: $(progs_static) libbtrfs.a libbtrfsutil.a
+static: $(progs_static) libbtrfs.a libbtrfsutil.a libmkfsbtrfs.a

 libbtrfs/version.h: libbtrfs/version.h.in configure.ac
 	@echo "    [SH]     $@"
@@ -577,6 +579,19 @@ libbtrfs.so.0 libbtrfs.so: libbtrfs.so.0.1 libbtrfs/libbtrfs.sym
 	@echo "    [LN]     $@"
 	$(Q)$(LN_S) -f $< $@

+libmkfsbtrfs.so.0.1: $(mkfs_objects) $(objects) libmkfsbtrfs/libmkfsbtrfs.sym
+	@echo "    [LD]     $@"
+	$(Q)$(CC) $(CFLAGS) $(filter %.o,$^) $(LDFLAGS) $(mkfs_objects) \
+		-shared -Wl,-soname,libbtrfs.so.0 -Wl,--version-script=libmkfsbtrfs/libmkfsbtrfs.sym -o $@
+
+libmkfsbtrfs.a: $(mkfs_objects) $(objects) mkfs/main.box.o
+	@echo "    [AR]     $@"
+	$(Q)$(AR) cr $@ $^ $(objects)
+
+libmkfsbtrfs.so.0 libmkfsbtrfs.so: libmkfsbtrfs.so.0.1 libmkfsbtrfs/libmkfsbtrfs.sym
+	@echo "    [LN]     $@"
+	$(Q)$(LN_S) -f $< $@
+
 libbtrfsutil/%.o: libbtrfsutil/%.c
 	@echo "    [CC]     $@"
 	$(Q)$(CC) $(LIBBTRFSUTIL_CFLAGS) -o $@ -c $< -o $@
@@ -664,11 +679,11 @@ btrfsck.static: btrfs.static
 	@echo "    [LN]     $@"
 	$(Q)$(LN_S) -f $^ $@

-mkfs.btrfs: $(mkfs_objects) $(objects) libbtrfsutil.a
+mkfs.btrfs: $(mkfs_objects) $(mkfsmain_objects) $(objects) libbtrfsutil.a
 	@echo "    [LD]     $@"
 	$(Q)$(CC) -o $@ $^ $(LDFLAGS) $(LIBS)

-mkfs.btrfs.static: $(static_mkfs_objects) $(static_objects) $(static_libbtrfs_objects)
+mkfs.btrfs.static: $(static_mkfs_objects) $(mkfsmain_objects) $(static_objects) $(static_libbtrfs_objects)
 	@echo "    [LD]     $@"
 	$(Q)$(CC) -o $@ $^ $(STATIC_LDFLAGS) $(STATIC_LIBS)

--
2.34.1

