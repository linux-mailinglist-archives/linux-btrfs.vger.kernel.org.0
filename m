Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C015558DC36
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245036AbiHIQg7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Aug 2022 12:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245186AbiHIQgq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Aug 2022 12:36:46 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5291D7;
        Tue,  9 Aug 2022 09:36:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n4so13160461wrp.10;
        Tue, 09 Aug 2022 09:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Ok5+N/ROSsdYONZgRo7NN1XD5pWHK7Ij0qh3WOIp4Hk=;
        b=oKtlwHul5j/zPHGlStukJ7puPsBguip4EroHiSwJj69SbsyIQOpOT70cl5OMzYVAXe
         I+HxbGGO4NqFB35SbGR5zgsEBBzKNtYkYGEe7q7bJYbZUEPvBQ1UT9KAtBEqtqK/hnaG
         ShUgVOUKcGhnmAHCL5q2o2p+ertnx/8x7UVBbQP+7aVJ50ykQ/The/m16DuqZ1ALEuEl
         t4Sr15Ng/WVy/KuWppQsFAa81SPVCdacWM4WxUYABmGAhmE/ren06b63cJElTfdqr+zI
         mqCtbaYP+kd1Q/vgmINgk3RKqjKqoc+MoIMS8RTP0J+a740hCjtCDt0GtetWe4+1ZhWr
         TBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Ok5+N/ROSsdYONZgRo7NN1XD5pWHK7Ij0qh3WOIp4Hk=;
        b=xHG2x1+Y320tjVjt1q19yUW/32avgNbN2tDxooOZmne0hyHw9BpqKVlx883623gPPs
         9UgquMwEht0P411ka7LfuW4vZZy4Z+f65U1uWi9Mj+PIw33pMMSB/+R+q3XA5gITO27D
         nBDYxmxQ8LA0u2NouFZchhadOsMNh7aM2A1TczvAxj6zCqZSaP19Qs3mCe95E4RTJ2hp
         quAro/RJmIbmRFVX+nO3V6yv6BOu3Y4fNzrrq150Syv+F8lx+juAo5zBrDJkfE9YV3pp
         whBas2mOPzDyi+vwKVV3Un5yuC0C+8Q4FrFcAJnm/+7iaDhhESinrK6wQsbPL1n/uaDL
         ctOQ==
X-Gm-Message-State: ACgBeo0gFZ7QtDZ2+ojgNuqOsLsLnF0DIx17vEZQmUyyTrZjlIkBnXGN
        gD2qrLyB1OslDVrdlntLNyCbRFsHKrGhSA==
X-Google-Smtp-Source: AA6agR6/nHRlqGWl2s71vXeZAAz1IiObS2iTo4xTRzVR/0nfk3Jy9qj99Lp4kxI2Gj1WaUJ27p/TBQ==
X-Received: by 2002:adf:de0f:0:b0:21e:ead4:23f5 with SMTP id b15-20020adfde0f000000b0021eead423f5mr14580915wrm.641.1660063003709;
        Tue, 09 Aug 2022 09:36:43 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a7-20020a056000100700b0021f0c0c62d1sm13856980wrx.13.2022.08.09.09.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 09:36:43 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH] fs/btrfs: Use atomic_try_cmpxchg in free_extent_buffer
Date:   Tue,  9 Aug 2022 18:36:33 +0200
Message-Id: <20220809163633.8255-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
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

Use `atomic_try_cmpxchg(ptr, &old, new)` instead of
`atomic_cmpxchg(ptr, old, new) == old` in free_extent_buffer. This
has two benefits:

- The x86 cmpxchg instruction returns success in the ZF flag, so this
  change saves a compare after cmpxchg, as well as a related move
  instruction in the front of cmpxchg.

- atomic_try_cmpxchg implicitly assigns the *ptr value to &old when
  cmpxchg fails, enabling further code simplifications.

This patch has no functional change.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 fs/btrfs/extent_io.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bfae67c593c5..15ff196cbd6d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6328,18 +6328,16 @@ static int release_extent_buffer(struct extent_buffer *eb)
 void free_extent_buffer(struct extent_buffer *eb)
 {
 	int refs;
-	int old;
 	if (!eb)
 		return;
 
+	refs = atomic_read(&eb->refs);
 	while (1) {
-		refs = atomic_read(&eb->refs);
 		if ((!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) && refs <= 3)
 		    || (test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags) &&
 			refs == 1))
 			break;
-		old = atomic_cmpxchg(&eb->refs, refs, refs - 1);
-		if (old == refs)
+		if (atomic_try_cmpxchg(&eb->refs, &refs, refs - 1))
 			return;
 	}
 
-- 
2.37.1

