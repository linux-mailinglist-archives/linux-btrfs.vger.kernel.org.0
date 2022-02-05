Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9AA4AAB08
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 19:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbiBEStJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Feb 2022 13:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiBEStI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Feb 2022 13:49:08 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4809C061348;
        Sat,  5 Feb 2022 10:49:07 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b9so19031676lfq.6;
        Sat, 05 Feb 2022 10:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j6S3Kh4JSsyzTJwIiEb9upRA50DMN8jNgyHoasqS+S0=;
        b=jBJmMOo5ZW14Olk3qfUs0XDrwzkaGx5kIfSeBM+nlE+u+dq+ma9HIzp3hs3OUYGr/p
         PLjqgZqH30yLlsq50r8gBLwnAjBF3MUoDQ7HrIj8QE07YcFDmzLUaRBqXTcfobDXDvCG
         Mh4z0ig4hVRhxmiUxTWgKJYm2QCbXWlv0vy2svr/1J4d5fivHvGlbn7v7z81psvnSqBC
         oVuu2zACt8p10ZilqXO1k7ZLOsTsd4i3k1jLHpJgCdA4+UaI7tTTy7J3cJF4OTvWZmvW
         S2A9JF7P7JLI9rJrWoKCD25MhT4QNAeTt0OYq5G9NCUkoFRVnI1aK/7T432HyzRFy6xy
         QAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j6S3Kh4JSsyzTJwIiEb9upRA50DMN8jNgyHoasqS+S0=;
        b=70Vq5rmnM5UrUft6eS7ePBbx3iEnTilAEP0fHHHALiJrqh2v/eBIcxrJum7Pswmn7R
         JtC/C3F8nCE1qgOg1GZwgXx+Z3lQirqGeM9iJMZPHDxjWkC/n1NPdtSyFx+BbMER6BvY
         BHljFJCUZfH62JKaHutl8yXmEpiC+PIqM+NILv1RxDWKBhgB68fmr7/BQPE8vZlu+6um
         8kPslDCY5kpuCbqttEmNv8X7ctkH9T/x5wi6MRXTYUem1vN0gnL9T/cWZFaEOO7U8efe
         IzXv5c/QafVHxl8z7K//qzwCsRITxwwEF41+espV292qzep5DwBfOwvYf76HH+/hBX8D
         TeOw==
X-Gm-Message-State: AOAM530HumREWiS+5xpFKIVhh5vQUM/yLlDl+/IzJtbZg2zhrCG1NVqP
        kK8GoHLEfbJNUMiIJNFGs4KzCgI2ngzYgJRG
X-Google-Smtp-Source: ABdhPJxhm+QVsiVh1pxN7Gz2ubSOYSNovsHCK3+QNevQ7qseNgNvzN8CzrEJXKnDM1Htp3aynUkJxg==
X-Received: by 2002:ac2:554a:: with SMTP id l10mr3176054lfk.534.1644086945544;
        Sat, 05 Feb 2022 10:49:05 -0800 (PST)
Received: from ArchRescue.. ([81.198.232.185])
        by smtp.gmail.com with ESMTPSA id a24sm833050ljp.112.2022.02.05.10.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 10:49:05 -0800 (PST)
From:   =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: [PATCH v3] btrfs: send: in case of IO error log it
Date:   Sat,  5 Feb 2022 20:48:23 +0200
Message-Id: <20220205184822.2968-1-davispuh@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220202201437.7718-1-davispuh@gmail.com>
References: <20220202201437.7718-1-davispuh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently if we get IO error while doing send then we abort without
logging information about which file caused issue.
So log it to help with debugging.

Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
---
 fs/btrfs/send.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d8ccb62aa7d2..b1f75fde4a19 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4999,6 +4999,8 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 			lock_page(page);
 			if (!PageUptodate(page)) {
 				unlock_page(page);
+				btrfs_err(fs_info, "send: IO error at offset=%llu for inode=%llu root=%llu",
+					page_offset(page), sctx->cur_ino, sctx->send_root->root_key.objectid);
 				put_page(page);
 				ret = -EIO;
 				break;
-- 
2.35.1

