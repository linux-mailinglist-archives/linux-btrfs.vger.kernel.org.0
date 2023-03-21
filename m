Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E486C27B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 03:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCUCEU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 22:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjCUCES (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 22:04:18 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A03A2ED5B
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 19:04:06 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id c19so16353815qtn.13
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 19:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679364244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9njVCJrIQjld+/7I/yREHVWR6u9cpKpX0PR/OWJy6SU=;
        b=2IO91ZbahuTO3YeagzeMS0QklEgZbzcyuuVCy7+Dx0t/JCaxHtGclZNqIrYgxTW7/U
         i3hdrtHVfy1zvKCJ4gK85zcSq07FoUISeLJpL2YajjwJh2Ng5gM5qD6UbI9gvl0fbElO
         Yetb+ch/8337N/eckxgifTtegQw9NNZuvYCOdz64nDbca8Z9x9fZeOpdTkjC07tzrc4c
         amQ84RWLTmfT7pUQsUcZcmZwOf+rxGNTq69DAQuaJrnbG9VhjrBxRU5Yhx+ZLCfPZumV
         p+93MtG7dQh7US55RuvrdCGH7WGp0PfIiyPlMoKHC7xyxlwf3BdxucgF1ynC64qu3OUQ
         dwyQ==
X-Gm-Message-State: AO0yUKWRzucHtNaTw+1wBG/tbOl+nlyivMRdYakuaqW8/YVoAQOpfxIA
        hLz/c+i+otQ0VEVUCwGzxPeAu6DtALctgQ==
X-Google-Smtp-Source: AK7set9K2QFGGAp22x2x+Gt5Ai/vuxCPJqy+GBtlZYk+BwYCIEW2eva6DllKTlw9KW+T7syPNkzrzA==
X-Received: by 2002:ac8:5cc8:0:b0:3bf:c86b:3d2a with SMTP id s8-20020ac85cc8000000b003bfc86b3d2amr2070075qta.9.1679364244408;
        Mon, 20 Mar 2023 19:04:04 -0700 (PDT)
Received: from Belldandy-Slimbook.infra.opensuse.org (ool-18e49371.dyn.optonline.net. [24.228.147.113])
        by smtp.gmail.com with ESMTPSA id o140-20020a374192000000b007343fceee5fsm2382428qka.8.2023.03.20.19.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 19:04:03 -0700 (PDT)
From:   Neal Gompa <neal@gompa.dev>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>, Hector Martin <marcan@marcan.st>,
        Davide Cavalca <davide@cavalca.name>,
        Neal Gompa <neal@gompa.dev>
Subject: [RFC PATCH] btrfs-progs: mkfs: Enforce 4k sectorsize by default
Date:   Mon, 20 Mar 2023 22:03:20 -0400
Message-Id: <20230321020320.2555362-1-neal@gompa.dev>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have had working subpage support in Btrfs for many cycles now.
Generally, we do not want people creating filesystems by default
with non-4k sectorsizes since it creates portability problems.

Signed-off-by: Neal Gompa <neal@gompa.dev>
---
 Documentation/Subpage.rst    |  9 +++++----
 Documentation/mkfs.btrfs.rst | 11 +++++++----
 mkfs/main.c                  |  2 +-
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/Documentation/Subpage.rst b/Documentation/Subpage.rst
index 21a495d5..d7e9b241 100644
--- a/Documentation/Subpage.rst
+++ b/Documentation/Subpage.rst
@@ -9,10 +9,11 @@ to the exactly same size of the block and page. On x86_64 this is typically
 pages, like 64KiB on 64bit ARM or PowerPC. This means filesystems created
 with 64KiB sector size cannot be mounted on a system with 4KiB page size.
 
-While with subpage support, systems with 64KiB page size can create (still needs
-"-s 4k" option for mkfs.btrfs) and mount filesystems with 4KiB sectorsize,
-allowing us to push 4KiB sectorsize as default sectorsize for all platforms in the
-near future.
+Since v6.3, filesystems are created with a 4KiB sectorsize by default,
+though it remains possible to create filesystems with other page sizes
+(such as 64KiB with the "-s 64k" option for mkfs.btrfs). This ensures that
+new filesystems are compatible across other architecture variants using
+larger page sizes.
 
 Requirements, limitations
 -------------------------
diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
index ba7227b3..af0b9c03 100644
--- a/Documentation/mkfs.btrfs.rst
+++ b/Documentation/mkfs.btrfs.rst
@@ -116,10 +116,13 @@ OPTIONS
 -s|--sectorsize <size>
         Specify the sectorsize, the minimum data block allocation unit.
 
-        The default value is the page size and is autodetected. If the sectorsize
-        differs from the page size, the created filesystem may not be mountable by the
-        running kernel. Therefore it is not recommended to use this option unless you
-        are going to mount it on a system with the appropriate page size.
+        The default value is 4KiB (4096). If larger page sizes (such as 64KiB [16384])
+        are used, the created filesystem will only mount on systems with a running kernel
+        running on a matching page size. Therefore it is not recommended to use this option
+        unless you are going to mount it on a system with the appropriate page size.
+
+        .. note::
+                Versions up to 6.3 set the sectorsize matching to the page size.
 
 -L|--label <string>
         Specify a label for the filesystem. The *string* should be less than 256
diff --git a/mkfs/main.c b/mkfs/main.c
index f5e34cbd..5e1834d7 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1207,7 +1207,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	}
 
 	if (!sectorsize)
-		sectorsize = (u32)sysconf(_SC_PAGESIZE);
+		sectorsize = (u32)SZ_4K;
 	if (btrfs_check_sectorsize(sectorsize))
 		goto error;
 
-- 
2.39.2

