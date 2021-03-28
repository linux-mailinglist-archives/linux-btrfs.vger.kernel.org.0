Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAFF34BAAB
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 06:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhC1EWD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 00:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhC1EVa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 00:21:30 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3E9C061762;
        Sat, 27 Mar 2021 21:21:30 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c3so9358569qkc.5;
        Sat, 27 Mar 2021 21:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q7WiPlyASy9s3Bxc2lCHDGa+FD52Kpy+J8LP+IaEsVo=;
        b=i6bVr3b8ITkruXp5JPCOUzWH5vXe3PAt+SBxAglgE8Zt/FLvbhraLyPDh4gjlqqD9V
         i5kwBFcJKiFer/vG1tOIeiOCgV0N30kp0GPwyV8OU4DhVVFt2EEzahKhcaIsPPavo3g6
         j4SBEaZJQtTDyCnELPRHA6g91GZyr4iEqVqhQXK8v8SGibvF6RuRaD9/wr1LsgZgtYfJ
         SpF93T8F1P7EZncoXlo8clTpiHq26dhf1pamFEiM6CcBztW4tCLt6GDXUgfnhk3xsV7l
         U6UEMLONQ3LoEgU495fJbhJMvNDfjGi0GutSFF8zLFy7qfKdXPXyImJ6Qpyyi5G2wool
         qNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q7WiPlyASy9s3Bxc2lCHDGa+FD52Kpy+J8LP+IaEsVo=;
        b=Q1Y+P6+35u99OOoLRQwvn2dVtjeBGHlPY6dr5CD4A89PGr+aQhHxHynWr9TJZifOno
         WSakFEEcNZqS5p42W11JRArg0LoRqFFWQ+slkw7VSz6G7Raw5IdSdw37q/FtWJCPxZlw
         nSxuwoQsEVrj+25aw84/U+iIoMaKEQfzJFJ9bsKVyo9SEAOQ+N3W9LNvC2NzfMWrn7uq
         tfntYDXsM5ccfJtVvEPceWS7X5dMmPCccTPCDUYRwYGVydR8p0k6AjPtQlABn7KgQ1KK
         /AtFVgLf7cFFiagSZ/3R5Pqp4ExZSBOi3dhfP7TUV11hRHGu3CB9JhNjRvZvt1fg6jIt
         3rfA==
X-Gm-Message-State: AOAM5329Xu+dKmUMjlpKrPcYMQ9RIkW5svybGCkrcaMyqkmoRkadhn8V
        ifIF83HR3WZiMLHl79jEiQA=
X-Google-Smtp-Source: ABdhPJz3UD8ZakBWudJ4i7QGemOu8/dXzF1DPiA/rTEvnvzctF/jtNSWN5GXeHq5WpygzR3Yl3ffBQ==
X-Received: by 2002:a05:620a:20db:: with SMTP id f27mr20377131qka.51.1616905289848;
        Sat, 27 Mar 2021 21:21:29 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.118])
        by smtp.gmail.com with ESMTPSA id i6sm10092237qkf.96.2021.03.27.21.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 21:21:29 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] inode.c: Couple of typo fixes
Date:   Sun, 28 Mar 2021 09:48:29 +0530
Message-Id: <b4ed7b980b45d5d8bd398df1316db4918aa195b7.1616904353.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1616904353.git.unixbhaskar@gmail.com>
References: <cover.1616904353.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

s/contaning/containing/
s/clearning/clearing/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/btrfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a520775949a0..dd7cc65db7bd 100644
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
2.26.2

