Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DF27CB23F
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjJPSWI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjJPSWG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:06 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529DEAC
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:03 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66d0f945893so40709886d6.1
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480522; x=1698085322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYVHSmz3QYock1Rn/5GLr5Ch+VJ6Y1Sc8gFeLki2OwI=;
        b=KgPNGXp6fOXRwS+gWI0eYQWPDRqmZwSfHwkWjVcsG5TJhTh1HKfrpwaXjP5VhT2kAl
         2VcGiXOwF0ecGtOc2es4LvBUxTqNFmpie6t7z/AzxdBhyj+FvtJOmJJ+mqgjU7YYyaTs
         2HDf2Y84NGrat1lUx38wDQOkZLeaBy2PlwI9PKPjmoRiv34aI1N8/dTr7fzIkxvHKlg5
         +poLFk1X4clBKIWZM/8qKKukIeXXVPj/DpJKsT8YV2LZm5iPL+72MlMIWyYd2aGFvcYP
         dztioNLCWCFtOsnIJ2sN/UloiDPXTzH0jo12TTYcKkrri4deK+rchHHXnOcX25mHpijS
         7kuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480522; x=1698085322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYVHSmz3QYock1Rn/5GLr5Ch+VJ6Y1Sc8gFeLki2OwI=;
        b=v+x/M9EVmXlq74U+LUS6BxjgfsWGXeH+NXHkuhAs0P2ECD+d2bp47/xacF1xqa9JF4
         TBXLYFGkL7/N5TN7FTMEW+xm4Lp3ismFQ5g75PdUyXohXeAAWVR2XzYniGqhnR3S485v
         U0bBZ9+VwQJW5Rvf/p119+FLmQRkPS0ncWxhRX+OgKVnf7G95cDNwoownThrXMDjodXA
         Jipnowl3cmdx42PlR/B/4Kz32k8GBQzF12KdSlwTMu+wSixitczTwSDO9VLVND83oJuC
         xQbwJW3Q8HuVZsUi5v4Lm51GKQkmhyNtUkMlyHVTpn73RRC9zmEPFIss+wiUNKRVYCWf
         3TOw==
X-Gm-Message-State: AOJu0Yzdvt87lLv7EibGBiPWRowbKXJkZwLxzeE0WtxhA4O67P6CijKt
        VgdHx4hxomqIEx1lAtbqeOUKAC+1qgxEYYCOj6jJNQ==
X-Google-Smtp-Source: AGHT+IFFh+BaZ6kGGWqeEvVsqZNebRp1PherA59BfZ3pgGmxkGd9XVf4C+6LB0hCnMDR+Osahwrojg==
X-Received: by 2002:ad4:4e14:0:b0:66d:670:d425 with SMTP id dl20-20020ad44e14000000b0066d0670d425mr9365971qvb.31.1697480522296;
        Mon, 16 Oct 2023 11:22:02 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v8-20020a05622a188800b00418142e802bsm3224174qtc.6.2023.10.16.11.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 05/34] fscrypt: add documentation about extent encryption
Date:   Mon, 16 Oct 2023 14:21:12 -0400
Message-ID: <4458f5c9f167d7989a024490788bde7f740489db.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a couple of sections to the fscrypt documentation about per-extent
encryption.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/filesystems/fscrypt.rst | 41 +++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 1b84f818e574..dc8bf04484ba 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -256,6 +256,21 @@ alternative master keys or to support rotating master keys.  Instead,
 the master keys may be wrapped in userspace, e.g. as is done by the
 `fscrypt <https://github.com/google/fscrypt>`_ tool.
 
+Per-extent encryption keys
+--------------------------
+
+For certain file systems, such as btrfs, it's desired to derive a
+per-extent encryption key.  This is to enable features such as snapshots
+and reflink, where you could have different inodes pointing at the same
+extent.  When a new extent is created fscrypt randomly generates a
+16-byte nonce and the file system stores it along side the extent.
+Then, it uses a KDF (as described in `Key derivation function`_) to
+derive the extent's key from the master key and nonce.
+
+Currently the inode's master key and encryption policy must match the
+extent, so you cannot share extents between inodes that were encrypted
+differently.
+
 DIRECT_KEY policies
 -------------------
 
@@ -1394,6 +1409,27 @@ by the kernel and is used as KDF input or as a tweak to cause
 different files to be encrypted differently; see `Per-file encryption
 keys`_ and `DIRECT_KEY policies`_.
 
+Extent encryption context
+-------------------------
+
+The extent encryption context mirrors the important parts of the above
+`Encryption context`_, with a few ommisions.  The struct is defined as
+follows::
+
+        struct fscrypt_extent_context {
+                u8 version;
+                u8 encryption_mode;
+                u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
+                u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
+        };
+
+Currently all fields much match the containing inode's encryption
+context, with the exception of the nonce.
+
+Additionally extent encryption is only supported with
+FSCRYPT_EXTENT_CONTEXT_V2 using the standard policy, all other policies
+are disallowed.
+
 Data path changes
 -----------------
 
@@ -1417,6 +1453,11 @@ buffer.  Some filesystems, such as UBIFS, already use temporary
 buffers regardless of encryption.  Other filesystems, such as ext4 and
 F2FS, have to allocate bounce pages specially for encryption.
 
+Inline encryption is not optional for extent encryption based file
+systems, the amount of objects required to be kept around is too much.
+Inline encryption handles the object lifetime details which results in a
+cleaner implementation.
+
 Filename hashing and encoding
 -----------------------------
 
-- 
2.41.0

