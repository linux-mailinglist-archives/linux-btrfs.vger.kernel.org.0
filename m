Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBEB629D92
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 16:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiKOPcd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 10:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiKOPcC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 10:32:02 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455AC2E9FC
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:32:00 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id o8so9999367qvw.5
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 07:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnXYrU8VIB8sygEzBVNCP/G5cdFprLNWi6nqJQSrz7g=;
        b=7hTbjTN9MLZVWHdACCVGJ6Lk0Nu+o9Q0QYJOmyVczCxAx7DcUD+2fyowzyvunRe8ar
         /UBUhLGas+YauMg5p+PpgJdVSGiTvonUKGkb3apmebaz96XlzAPfpFOFlRFlA18xKCsg
         gCZfNcGmUv0HdPBdx5ACyLt8SQvwfV+uLXnShgEPfPDLvHwQMvxTpqr5c/tw8hVa+6PF
         wHAqkjYoApFlE3trfdAG+MBQkEgnOoq10skj0CVvhGF8Xj1LbWGS5J9Ru+B3HHsZfJLe
         W+rihEKVnMsURCQJVfw3XcmJNzMl6JYHlRi2J81vVWevLfk54zE1rtxAi0b/8qmWk6wI
         C+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnXYrU8VIB8sygEzBVNCP/G5cdFprLNWi6nqJQSrz7g=;
        b=KLv6omGKCtTbffdXl88FP6PMTZQcE8aaZtu1wvqksUGquivPSL5rCWWvGbtxJo4QLc
         bSBZf2qvCHC34QHnryHxHEbeaf2paiEjNrCpLg7JnZbVUMKAlq+ByKOXL6HRjv/ycvbr
         PmnkSOuxVOFQ+CYAVwdJPRe6lPOwx52c5VYjmkv4+14y7sZ5uQz488RKSSracXo4t0/a
         2V8j7dgT0sBIj2iWWyFZw2whiDIYRcNNdxF/YwsTRDn0LgUQy5fMe98h7C6yt6g+eQOr
         iUB92Yab14CDDYUg968M9WkRw+6SKWG+X4CmCI2mWsTkmkpM9q89uHQZrcwOF0JuNlUm
         8Ghg==
X-Gm-Message-State: ANoB5pmLWVhQWtUXkKk9/ApTt7b6HtVAqvR6pwW1TKsLP3qrVJ1M9hzo
        jp1B8TLaQ1mBjwaH21CyFnlaywqI0IJTrQ==
X-Google-Smtp-Source: AA0mqf62lyItvguKvmp0quK5wmNOj2LFnaXhqHcdbT9C6aW5+rxKNTRFPmCNSPmBVf7qV7MLqfQdKA==
X-Received: by 2002:a05:6214:459c:b0:4bb:f952:c799 with SMTP id op28-20020a056214459c00b004bbf952c799mr17003280qvb.3.1668526317957;
        Tue, 15 Nov 2022 07:31:57 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id d16-20020a05622a15d000b003a540320070sm7450373qty.6.2022.11.15.07.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:31:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 16/18] btrfs-progs: don't use btrfs_header_csum helper
Date:   Tue, 15 Nov 2022 10:31:25 -0500
Message-Id: <20f12498a1c9d97585235c336205dcf74b414d8f.1668526161.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668526161.git.josef@toxicpanda.com>
References: <cover.1668526161.git.josef@toxicpanda.com>
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

This is a useless helper, the csum is always the first thing in the
header, simply read from offset 0.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/rescue-chunk-recover.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 460a7f2f..e6f2b80e 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -94,8 +94,7 @@ static struct extent_record *btrfs_new_extent_record(struct extent_buffer *eb)
 	rec->cache.start = btrfs_header_bytenr(eb);
 	rec->cache.size = eb->len;
 	rec->generation = btrfs_header_generation(eb);
-	read_extent_buffer(eb, rec->csum, (unsigned long)btrfs_header_csum(eb),
-			   BTRFS_CSUM_SIZE);
+	read_extent_buffer(eb, rec->csum, 0, BTRFS_CSUM_SIZE);
 	return rec;
 }
 
-- 
2.26.3

