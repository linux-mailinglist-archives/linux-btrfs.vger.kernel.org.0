Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F7961FAF
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2019 15:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbfGHNn1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jul 2019 09:43:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40746 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbfGHNn1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jul 2019 09:43:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so8320883pla.7;
        Mon, 08 Jul 2019 06:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=XuKn7QldX9ga0MGEIqR1MDmcCIUcjpzwfNVtfmUSJ4w=;
        b=uWwOohpp2nqU3NtPtZWQxFxwCSSm8ZlE19OOy4vbMIq1RF6fgtut/kIc5iouE9ONyv
         DDRwvD7kH0cqzKbjYh6pBwotAYyfo3954KUPnpfA0+tEAJbJXyJngJWcSj/DUrFsrY4X
         6mREzGaO206+umbYNT9ZUpYaNQ3iZ4xIzXOv7KkVt504W58WK7ouRHWY0HqqOTbLT4Tn
         Q4HhXdHdxbv0dqgXCyf6WpDIwTdCG+wfwODsphKMKSZug+MrcS1eaffkum5PtF8cbI1y
         3uRWttVKxGkO0i4SgenaoOzwM405HUwXjnH2Jk4P8ecMWVwyZ7fQwab+rwbP9fjHOQmz
         RlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=XuKn7QldX9ga0MGEIqR1MDmcCIUcjpzwfNVtfmUSJ4w=;
        b=E2HsFIX2M/+4M1EipvbAJw5EDYadihVB3cYXbz2Poqb9iWUmZs3tw85whoqV8WxFY8
         Wfidb9zTZIjHqa1GImCbQsWPUA0bUfi+RrNhaL9lJUIgtQvl919kBhrQGn8Kgf/La3RI
         Cw2SszOr8D9KMIv2y5eSFqmHhDojNoRVTAI4ZtKJf2QQ5/3wNqwdPwn81O8hjQobNjeG
         8NmJHsPJ2T9jWgKksZN9BGfueSmPZlsO+cTXgRNuDjXe7nXIYaLrxEgWKM2JN5desRti
         lUG9WeDF+vS2PpHTjmvITYq3bPN9o1t2ChC5bxmn36ifGcOpBQCF3aqv2ehEr/KcxR0Q
         odOA==
X-Gm-Message-State: APjAAAWCFmgb3nijZY5vwxHMtJp8QFg/L1uzMX2IGm5gz1/aOUNN/ODY
        fhfA46/CtF1Y8ocM4Vr+Ilw=
X-Google-Smtp-Source: APXvYqxJZKLKGQL7DHLKzYDKoNJH1aiFzFzS+IvviyDVDkgXb+/bk5t9P31KksFr5hLmmWfehkMXOQ==
X-Received: by 2002:a17:902:424:: with SMTP id 33mr25088347ple.151.1562593406398;
        Mon, 08 Jul 2019 06:43:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w16sm22871212pfj.85.2019.07.08.06.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 06:43:25 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH -next] btrfs: Select LIBCRC32C again
Date:   Mon,  8 Jul 2019 06:43:23 -0700
Message-Id: <1562593403-19545-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With CONFIG_BTRFS_FS=y and CONFIG_CRYPTO_CRC32C=m, we get:

fs/btrfs/super.o: In function `btrfs_mount_root':
fs/btrfs/super.c:1557: undefined reference to `crc32c_impl'
fs/btrfs/super.o: In function `btrfs_print_mod_info':
fs/btrfs/super.c:2348: undefined reference to `crc32c_impl'
fs/btrfs/extent-tree.o: In function `btrfs_crc32c':
fs/btrfs/ctree.h:2609: undefined reference to `crc32c'
fs/btrfs/ctree.h:2609: undefined reference to `crc32c'
fs/btrfs/ctree.h:2609: undefined reference to `crc32c'
fs/btrfs/dir-item.o: In function `btrfs_name_hash':
fs/btrfs/ctree.h:2619: undefined reference to `crc32c'
fs/btrfs/ctree.h:2619: undefined reference to `crc32c'

and more.

Note that the comment in the offending commit "The module dependency on
crc32c is preserved via MODULE_SOFTDEP("pre: crc32c"), which was previously
provided by LIBCRC32C config option doing the same." is wrong, since it
permits CONFIG_BTRFS_FS=y in combination with CONFIG_CRYPTO_CRC32C=m.

Cc: David Sterba <dsterba@suse.com>
Fixes: d5178578bcd4 ("btrfs: directly call into crypto framework for checksumming")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 fs/btrfs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 212b4a854f2c..4c80c70597f9 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -2,6 +2,7 @@
 
 config BTRFS_FS
 	tristate "Btrfs filesystem support"
+	select LIBCRC32C
 	select CRYPTO
 	select CRYPTO_CRC32C
 	select ZLIB_INFLATE
-- 
2.7.4

