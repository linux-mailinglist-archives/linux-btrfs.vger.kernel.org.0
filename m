Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920EE7163EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 16:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjE3OZd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 10:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbjE3OZJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 10:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AD410DA
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685456523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IaNRJCmDjWU8/6DXmsxqc7rHWPn8lAenVzUVcNnxOjU=;
        b=U9xoLXAXKKoMwbMkcGuTc9JWkSnSWZ+tEeJvRTGfLip18NcfrSVafGn6HZdvwqGJ15XFMZ
        T7owZ/tNjqqEuwmuqtuUPxGuASS9bHwsReAGpz3JNsKH7f9Vnnwp+Rrzx4nNURJzlOdgdj
        MI+G9ES8XIS+WoVKZKANmMH/gr722Q8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-5aj3IHlgM3uNVAZIgX1y4A-1; Tue, 30 May 2023 10:21:59 -0400
X-MC-Unique: 5aj3IHlgM3uNVAZIgX1y4A-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f6a96a6170so67450571cf.2
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 07:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685456517; x=1688048517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IaNRJCmDjWU8/6DXmsxqc7rHWPn8lAenVzUVcNnxOjU=;
        b=QUAGKnbsFMtmtt05nKlichRacl5NW7xSxXu44uOnxBSnd53sxTRJyKbX2lWzg7IXZS
         znvA0EYeO8zmiAw9pRmfVQoOBMdoAXuM7zUEKXyAZ8UfZwQzsX5u1XcpIlGhhp6nDztm
         4C/Sl1an8spbdE8T/WSI/ZJ3Xrg4eb4cGixL8iPVfOkn/LDahmGqOBrDksVb5jdAZmi5
         zbAXwQSnp+LO/7V5xFgljzwTbj2nMBoViDP+ZH5DGBhPe2gH1GYYUtd08/NwP1ljMyot
         U+kCqx8P02RqABhgUGRxg95dA9dnMSYWD2C0PkdH8FYTfNL3fc/BOGMu1x9UJdl/W5hA
         c0jg==
X-Gm-Message-State: AC+VfDyviEbO4PsHc/3Am6grcSYj5pWDCxTEkGDAqkSB7xhsu+6ocV9T
        I1MpS/aZJVlXbxzz4sed2iLB2OaHDghq5oKDzU6rnFZW7UbjCj6DR7RWPhzwpI4K3Emux5ZGt30
        gb4/JpYEn7B0ZMjP53VPxHx8=
X-Received: by 2002:a05:622a:1787:b0:3f8:20a:1c6a with SMTP id s7-20020a05622a178700b003f8020a1c6amr1912807qtk.40.1685456517403;
        Tue, 30 May 2023 07:21:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7yvPRFJ6QfVfk1/1OEdvl2Lu3bQMAfd0qtXiTSv1WBwMYtf1F4J8MySyj03BE8wXZx/eMRPw==
X-Received: by 2002:a05:622a:1787:b0:3f8:20a:1c6a with SMTP id s7-20020a05622a178700b003f8020a1c6amr1912788qtk.40.1685456517195;
        Tue, 30 May 2023 07:21:57 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i26-20020ac871da000000b003f394decd08sm4652992qtp.62.2023.05.30.07.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:21:56 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] btrfs: remove unused variable pages_processed
Date:   Tue, 30 May 2023 10:21:54 -0400
Message-Id: <20230530142154.3341677-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

clang with W=1 reports
fs/btrfs/extent_io.c:230:16: error: variable
  'pages_processed' set but not used [-Werror,-Wunused-but-set-variable]
        unsigned long pages_processed = 0;
                      ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/btrfs/extent_io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 89e093ae1c33..6919409c1183 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -227,7 +227,6 @@ static void __process_pages_contig(struct address_space *mapping,
 	pgoff_t start_index = start >> PAGE_SHIFT;
 	pgoff_t end_index = end >> PAGE_SHIFT;
 	pgoff_t index = start_index;
-	unsigned long pages_processed = 0;
 	struct folio_batch fbatch;
 	int i;
 
@@ -242,7 +241,6 @@ static void __process_pages_contig(struct address_space *mapping,
 
 			process_one_page(fs_info, &folio->page, locked_page,
 					 page_ops, start, end);
-			pages_processed += folio_nr_pages(folio);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
-- 
2.27.0

