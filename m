Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2BC636D52
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKWWid (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiKWWiM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:38:12 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69894183AC
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:38:11 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id k2so13472091qkk.7
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnXYrU8VIB8sygEzBVNCP/G5cdFprLNWi6nqJQSrz7g=;
        b=6l24NwFDlM6RQBxVKx4Qjfu0soFzG419scNriucgWaimEN21i+sSuOvND7F3q6oBlW
         waJoTs/wp3Cyqkt0wzSTLA6qQAZRiStn6XP3QdsQwCVP2mtnuZlpL+FLDJCi8Ku36oj/
         PTKmfYq2HhNmo3Oe2b/yml9Cw4PBidFKQM7/XOM+loG/XzUXn5vSF8sGhNXWylLva+iu
         h7YJcTBFaMY7fbRANWaHX/rKVzf723DV2mO8RykaK7/RdA331NbP0aGLMIC7cKPPP38V
         K4/WBXUOsNMoBT39n/C9zH7u3sOF4QxultIey6JptDAGgOeA2/xwsYzyrqaJ0+yKdf6x
         IYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnXYrU8VIB8sygEzBVNCP/G5cdFprLNWi6nqJQSrz7g=;
        b=aVrctCGSloEfZ2aOBxv+RWc/9dJiHd3EnsU4OVIKnvsyCRlU97rf3lRwG7CBOGOq96
         MXgysGcaE3v/j5XzQojrzOCF+EfmQL7d8OvsdpJc3pycIiGEzKSnRPABKumgHwx5MLmD
         uiJE25fiPW7lm0i/bghFnDzXQmNRO9xPiMPaUx6jddzoMGnS7dBfOxo9GTvt60VkDsrO
         tFCIpn6ID/pCmaAN2r8Nj1aKfFMBmfopqwbWlMfJhwlO8b10kf9bODKjSuh8wCu9attG
         yxlHe6VNrJcmEJMB+vr/OBFvoHdmEGn5HzyewWgeDmiPRqBdrPlC+3KqpN+Bs5aCVsA8
         6GsA==
X-Gm-Message-State: ANoB5pmwxt//ENxAFI7UF/cwhyQ5h6Pg2rdIfEpV18OP5gfltflPA2x5
        v14IRs1ujYcnFU7Y3YjTh40G6mkzQnM7DA==
X-Google-Smtp-Source: AA0mqf5jWFrsIdXlI5EXkPBr2uy5Z2/ubylbLZr3hx0JbC/R9KMMEpKvpgv2hPnwm2BsEfghOB+jew==
X-Received: by 2002:a37:86c6:0:b0:6ee:96d8:962d with SMTP id i189-20020a3786c6000000b006ee96d8962dmr26251993qkd.209.1669243090786;
        Wed, 23 Nov 2022 14:38:10 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id m2-20020ac86882000000b00399ad646794sm10533049qtq.41.2022.11.23.14.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:38:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 24/29] btrfs-progs: don't use btrfs_header_csum helper
Date:   Wed, 23 Nov 2022 17:37:32 -0500
Message-Id: <354e57e57b2d4ada9ee8877d98dd5899813a2af5.1669242804.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669242804.git.josef@toxicpanda.com>
References: <cover.1669242804.git.josef@toxicpanda.com>
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

