Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D663487E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Mar 2021 05:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCYEWL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 00:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhCYEWD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 00:22:03 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C76C06174A;
        Wed, 24 Mar 2021 21:22:02 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id v70so588216qkb.8;
        Wed, 24 Mar 2021 21:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dppjCLYM+97LqBPoYgSH+Q8eUt5Kfb8QazEKEOs8Je8=;
        b=sWEDG1iYo7fn753iriQHmWl263JI7EpZFyqxenrNcEb+5525eBEGg3Kqf/LvOvVAcy
         0FcEc/ZHUiJFWQbGglbBDS6j2XqlnYTJcD/Js0p3NVMCfXInWJVA/GARIcAU3yTaCB9c
         uRmo08zg7Y8tt1s3G67FcFGtJDtIjubkYw8SJeBU5vgF6hqLLGTSjEIJZM3ObUFUfbDs
         /T71epy/SjYnFGPjQ5EYEKcPqDROSbGJQs4uI2GtDR7hdvz/U1xntSItH3oL6OVQZqxd
         k5V+kr9WUb1czA9ZDTsKEOb4bMomn7QWJDThGqL7sBOurw+dc3eNOHvSmyOR1CXnd0A3
         4Nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dppjCLYM+97LqBPoYgSH+Q8eUt5Kfb8QazEKEOs8Je8=;
        b=BGY64k1CyleoKIwbu0QRtOR0GIyprAK/XjpNzDQ8RNFeZusftqEsXC8b719wfx5PnP
         b0uLpjfjcGuVK+A2PYnUhGJbCwdhewKoKfjGjFxUV5GGxYiRUrjz9NHvCzfJRe01059c
         cwrUE9ddaXVXytHs1bRuZ2Caz8PA2ddXsBJVGVqhyyUchEZ1X/ZMgeYDkgIhj1dlYPli
         vtapm/6llMasv+hicNjWwbUsPkaCU4gVWGQ2ksXDDcssOPLGyIZDIx8eynE+4ikxJ1RM
         TRCq/kgwed3I1rHn7g3yaSeDNQe3BuEHD8ClewVwhY+JwbZVznvX6nd9Xm01BGT52HSo
         GMeQ==
X-Gm-Message-State: AOAM532x6/YJe57iTja4mnbCo7k0l04AzLnbEnEylWBWAnE6yfMOMER9
        dekfHzgZuVJs9HITlO7KZ4mLaLBQEDGEDqIg
X-Google-Smtp-Source: ABdhPJxaedeJodJvswd//YzyelgpjiXPe92OtlWP0XyM14k5aGzrMdvUsDnfKOfkT8inFTlZGjKKZw==
X-Received: by 2002:a37:9fd2:: with SMTP id i201mr6126294qke.435.1616646122186;
        Wed, 24 Mar 2021 21:22:02 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.55.176])
        by smtp.gmail.com with ESMTPSA id s13sm3371544qkg.17.2021.03.24.21.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 21:21:59 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] btrfs: fixed rudimentary typos
Date:   Thu, 25 Mar 2021 09:51:13 +0530
Message-Id: <20210325042113.12484-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


s/contaning/containing
s/clearning/clearing/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/btrfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7cdf65be3707..e0c08176bc18 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2784,8 +2784,8 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	/*
 	 * If we dropped an inline extent here, we know the range where it is
 	 * was not marked with the EXTENT_DELALLOC_NEW bit, so we update the
-	 * number of bytes only for that range contaning the inline extent.
-	 * The remaining of the range will be processed when clearning the
+	 * number of bytes only for that range containing the inline extent.
+	 * The remaining of the range will be processed when clearing the
 	 * EXTENT_DELALLOC_BIT bit through the ordered extent completion.
 	 */
 	if (file_pos == 0 && !IS_ALIGNED(drop_args.bytes_found, sectorsize)) {
--
2.30.1

