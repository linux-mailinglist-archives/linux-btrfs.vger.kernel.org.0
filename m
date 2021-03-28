Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F0634BAA2
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 06:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhC1EVb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 00:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhC1EVN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 00:21:13 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E67C061762;
        Sat, 27 Mar 2021 21:21:13 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id z10so9338382qkz.13;
        Sat, 27 Mar 2021 21:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sm83h8+rEUGmDC4inIRqKG9HzfQrR9277HI31Wu5Rgs=;
        b=RPJeQ71gWsaNxOahqxJSlGewtol7iRu9+W+0SMnrbqwjBz2hpNP7pK8MKq6lVbZK6p
         gMok+EXX++dDaLZvxDYJ12QOyII1769CSHFkjTkz1WLBoShkroTBdrXnAiGpNft79ySF
         HGduq9kn87wDx6ePEqkH2leudjcN1w0pX9smJDJXBxOI3wtlpFr1ooWj3ggnXn0uuUUI
         4rgAlbuVMXcTNakgiNGp/CZqsb8fB51C/0+0EzZ0r8QVOgAgZah8Pz4Gq8+zrH6FCe2e
         P5qWldho+aCNU+38SXbHUIJeNal94dLjPZn5mSswLxd8KbYwML2Wg5eMCRSKaw/22TRN
         Ro7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sm83h8+rEUGmDC4inIRqKG9HzfQrR9277HI31Wu5Rgs=;
        b=iZZqM6VlzjNxiBbZQWpw431pi99dQdw3qM4dMX38sgbkHhEYwLNV5NBnrxFIHPc06n
         FmkRrofPxDdYkv/1SUr+Y/SDa9quXGMPzumQpoDjey6Ki6Bhqmn1Rt7Nejtde/ZiUjAh
         sO6Z+PnHCgmrBDYGsNqEOwGmVH4NKKtmyYgOAxs9d4R/Bt2x3d6xc7mbKA008/0jIb89
         ADNSwJSMvNUB6zt3fCtfE0bVswJ9wxAdSMBgSiZdILAoOsVGXkpJAD6ik4Y8je9Gxv7T
         9XzlAinIKUZVVDfiRpazmkN7QsSjAGG2KxLKxlox4EVC9WNCe3GN86LJUQIEvTzpmP1n
         VC+A==
X-Gm-Message-State: AOAM531DIG4nNvPfGiEPSNIaioRN1VWAC2/Es1KmTXKr2bEbVdxBepg+
        q33GgI08U4iZ8Z37AKSF23k=
X-Google-Smtp-Source: ABdhPJx5oEU5cnpkzRipZdxkX50s/uajZGZgfTaYvkJUKgKZhhax0MtVq9R2CfK9NPRxsYQp4m/G3w==
X-Received: by 2002:a37:9e50:: with SMTP id h77mr19850568qke.138.1616905272925;
        Sat, 27 Mar 2021 21:21:12 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.118])
        by smtp.gmail.com with ESMTPSA id i6sm10092237qkf.96.2021.03.27.21.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 21:21:12 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] extent-map-tests.c: A typo fix
Date:   Sun, 28 Mar 2021 09:48:25 +0530
Message-Id: <d8d1c56fe98b1b887bfec2be16468380d10602a8.1616904353.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1616904353.git.unixbhaskar@gmail.com>
References: <cover.1616904353.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

s/interesects/intersects/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/btrfs/tests/extent-map-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index c0aefe6dee0b..319fed82d741 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -557,7 +557,7 @@ int btrfs_test_extent_map(void)
 		{
 			/*
 			 * Test a chunk with 2 data stripes one of which
-			 * interesects the physical address of the super block
+			 * intersects the physical address of the super block
 			 * is correctly recognised.
 			 */
 			.raid_type = BTRFS_BLOCK_GROUP_RAID1,
--
2.26.2

