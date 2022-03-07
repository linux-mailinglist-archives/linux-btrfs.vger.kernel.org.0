Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1474D0B3E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbiCGWiP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343856AbiCGWiH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:38:07 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC9B6158
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:37:12 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id s15so14634246qtk.10
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dUavWJ9DB03+tFTUYTrAfLjwAy/jVwmNcHrmN7ZRHfc=;
        b=w+gctBJCOk442vzPEK+RE8f36lpMTpkG/3JbzwNbMzzekArsxTI6tFC/puR0GR3q7v
         oDIP0njxHq0QsV4qvgm618a16jmBKCIOBIHdmEoVG895q3Pi2jL79E7IDE2Z67vN0ilF
         9ABFZ8VAlpTQCHmboekkMb8HqgMaJ6qHgslpuM2tl48QN0rN7lfKB7gYMOykA/iTFdf5
         3RFThTfFnXwul0H1WPSl3dwZkRBlaoCxvU0w7DAHlFGN5c7T82D6Xc4EwSmSS7TS0jvw
         fvCtQDPZGxO+m2j0HQajVOaZh64KSABLJdMw4EnGL5a0FFluXnsgZ0TQaiTg6DEj+HEr
         4/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dUavWJ9DB03+tFTUYTrAfLjwAy/jVwmNcHrmN7ZRHfc=;
        b=wXCExTp7A2JtEyhBenvrgDz9JWDgh6GpctI41ZToUrfRkuFcl9uUoAFl5wjSH1rTjS
         HnzVt+PsYE23lRiBJr2/qpyq1rsHCNsrqPJY1Zf4RcF8eKc+wm8BnhLyoGQErca/qWS0
         1/S8jWq7wAEcM3wU7YoEMY6hPJvu9nDXBhrDf8LcHKoQf+049BseoiW6mprJxCu8QSum
         E37jD0PYsaJlAa/OCihYRc8zTMchiLTLIO+XQSz/ejQhq2cvuwjyhHf0KQGlYjZysiCz
         RBUxQ9iSH4nuzkycYmsi+29NrELLmfKdortMhtFxAyzMxnMeyKsOdj3U0jGs7OrC1qYu
         FShA==
X-Gm-Message-State: AOAM5313HWGB+n/dibiGXIc/GdIvcZuaQVl7HvWtXcU8zxmWvFsgVlry
        prsjxeWgZs7V5G6eaFUPJsujBu3RezpKFjfY
X-Google-Smtp-Source: ABdhPJwIiyexP/nOorofdnrZDkv1xkMlKajG0Whb4qo/PSboUZWYz2+wL9FbQZK+Y3QXnKsGahUeLw==
X-Received: by 2002:a05:622a:1893:b0:2dd:b1c5:db24 with SMTP id v19-20020a05622a189300b002ddb1c5db24mr11686946qtc.362.1646692631289;
        Mon, 07 Mar 2022 14:37:11 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i11-20020a379f0b000000b0067b1399f20esm2733824qke.44.2022.03.07.14.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:37:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/11] btrfs: zero dummy extent buffers
Date:   Mon,  7 Mar 2022 17:36:56 -0500
Message-Id: <bd193c475fc99e6e14a12dc40938ed22609220d6.1646692474.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646692474.git.josef@toxicpanda.com>
References: <cover.1646692474.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Our self tests allocate dummy extent buffers to test a variety of
things, however these eb's are very lightly initialized.  This causes
problems with the extent tree v2 stuff as we will read the header flags
and could have the V2 flag set and thus do the wrong thing.  Fix this by
zero'ing out the header of any dummy extent buffers we allocate.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 951b2e0e0df1..31309aba3344 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5960,6 +5960,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	set_extent_buffer_uptodate(eb);
 	btrfs_set_header_nritems(eb, 0);
 	set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
+	memzero_extent_buffer(eb, 0, sizeof(struct btrfs_header));
 
 	return eb;
 err:
-- 
2.26.3

