Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB396C38E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 19:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjCUSGt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 14:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCUSGt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 14:06:49 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1AB4DBE5
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:06:47 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id m16so3022837qvi.12
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679422006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCwEoyRPRdOYo3pD4ba8/CYZK/aWfvb7bEv1tr+fBQQ=;
        b=bcZ0yXemgdR1xjAjFMg4Rc6+rk5+v3fC6hA3sKOKgb3n1sxpYjRUzm+SyYDTpF5yq2
         ZwQ40BJCnSOTBKZOyWxZyGLimT8HpKAh6Q7BCfAB1mKeFZqR7f6uEHBfcYAmXfQ4ufcH
         l0rn3i+xTaKcuo5p3cSxV+oZ3tKQYZxtIKOIm/pWeTHTk0HK8YblQsRr1/4+2J1rJDTs
         fEMYLcvL0FHlA2BNR9Xxxm7gchB301DnvwBs0RZZFQYmtaoMtNJPAE2i3p99VuxK+uMH
         cMT6GopjTifOcv32UtQBoalSLd4QGHfaJHmZ4ooFHqPXu7E1dwCA5KkBgbKtN7uQQfU5
         +eQQ==
X-Gm-Message-State: AO0yUKXJvSHplagf8YW5DBfezEYJzKgQb03TUaR3EiIUqxYNa0QIXw5j
        62HMML5IQiQNciryadRc3H+UgSsDWc0LJOdpMWg=
X-Google-Smtp-Source: AK7set92g5J3kgqvESGE2x8zSiRagaSvdDdsh61XyZ3co89gjS30TmvkjNNjfb6PObCQHxZLVSWf4w==
X-Received: by 2002:ad4:5b84:0:b0:568:c5e3:a0ce with SMTP id 4-20020ad45b84000000b00568c5e3a0cemr1342205qvp.20.1679422006377;
        Tue, 21 Mar 2023 11:06:46 -0700 (PDT)
Received: from Belldandy-Slimbook.infra.opensuse.org (ool-18e49371.dyn.optonline.net. [24.228.147.113])
        by smtp.gmail.com with ESMTPSA id 84-20020a370c57000000b0074698d81ffasm2328796qkm.44.2023.03.21.11.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:06:46 -0700 (PDT)
From:   Neal Gompa <neal@gompa.dev>
To:     Linux BTRFS Development <linux-btrfs@vger.kernel.org>
Cc:     Neal Gompa <neal@gompa.dev>, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.cz>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Davide Cavalca <davide@cavalca.name>,
        Jens Axboe <axboe@fb.com>, Asahi Lina <lina@asahilina.net>,
        Asahi Linux <asahi@lists.linux.dev>
Subject: [RFC PATCH v2 1/1] btrfs-progs: mkfs: Enforce 4k sectorsize by default
Date:   Tue, 21 Mar 2023 14:06:10 -0400
Message-Id: <20230321180610.2620012-2-neal@gompa.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321180610.2620012-1-neal@gompa.dev>
References: <20230321180610.2620012-1-neal@gompa.dev>
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
 Documentation/Subpage.rst    | 15 ++++++++-------
 Documentation/mkfs.btrfs.rst | 13 +++++++++----
 mkfs/main.c                  |  2 +-
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/Documentation/Subpage.rst b/Documentation/Subpage.rst
index 21a495d5..39ef7d6d 100644
--- a/Documentation/Subpage.rst
+++ b/Documentation/Subpage.rst
@@ -9,17 +9,18 @@ to the exactly same size of the block and page. On x86_64 this is typically
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
 
-The initial subpage support has been added in v5.15, although it's still
-considered as experimental at the time of writing (v5.18), most features are
-already working without problems.
+The initial subpage support has been added in v5.15. Most features are
+already working without problems. Subpage support is used by default
+for systems with a non-4KiB page size since v6.3.
 
 End users can mount filesystems with 4KiB sectorsize and do their usual
 workload, while should not notice any obvious change, as long as the initial
diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
index ba7227b3..16abf0ca 100644
--- a/Documentation/mkfs.btrfs.rst
+++ b/Documentation/mkfs.btrfs.rst
@@ -116,10 +116,15 @@ OPTIONS
 -s|--sectorsize <size>
         Specify the sectorsize, the minimum data block allocation unit.
 
-        The default value is the page size and is autodetected. If the sectorsize
-        differs from the page size, the created filesystem may not be mountable by the
-        running kernel. Therefore it is not recommended to use this option unless you
-        are going to mount it on a system with the appropriate page size.
+        By default, the value is 4KiB, but it can be manually set to match the
+        system page size. However, if the sector size is different from the page
+        size, the resulting filesystem may not be mountable by the current
+        kernel, apart from the default 4KiB. Hence, using this option is not
+        advised unless you intend to mount it on a system with the suitable
+        page size.
+
+        .. note::
+                Versions prior to 6.3 set the sectorsize matching to the page size.
 
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

