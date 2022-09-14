Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022855B8B4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 17:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiINPG7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 11:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiINPGr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 11:06:47 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B1776460
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:45 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id b23so6460794qtr.13
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=Ph4kscEWnOgHmomTRnjQCm6MKqqe5qRplQf1YaR6vPA=;
        b=pbOmxjuceCGcRy5w2QDU6VH2T2OYecIrG0ADYbcsKusg0dmvYvWBgvc2CsINcoS6Vr
         MOZ1lIeNt3TpcUZdTQcK1wbW/ErMeBI0NObvbdnw4o+ifsxkkyZt/XezgdmFu2EizVpC
         tA0weDt2AATGOrBFNKgRZ6+qdDNo+tQ53eW0LuAh5Y8sPnhlRV3+7APecJcpgnRXOp07
         5FUOv+p6Xl1s8ujLLITqYiWqk0GCicW5cDCIa1czBlohqSzU09R62Pmjdb+/1Hx0DW16
         HvezKVvLSse3TaPDmqSEigj8Spy4a58FOeaIk0lA658LQKju4MQZWm2bKxTq+ouEtEz5
         6upQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ph4kscEWnOgHmomTRnjQCm6MKqqe5qRplQf1YaR6vPA=;
        b=1FrDZ2Ws24lvx9YutTPahRh7MU3UAqGKx1qrW7QKG4DG90QcUiOvImpWexCICxj7YZ
         13oliFkEidpGtqTpKOpBbiOTFCo7WlvO23gNF3/HpxBbDdUSu6Hu/yrci4opfAZLVftH
         AqQqirzvbQ8a0LtCvXVr229LHUVIdD5SaOtxET9RqRMvD6WGKbSZoHCSdg3raQRDkTW6
         ThBw/mvGwZ5m7c+ABTNS2R0hHrXrhN7cbLHkImAUm+2oOA7Egi0MihEVYIxCS5NHq7yI
         KEj6UmvdFFuADfKbO5UHQBOdJkuJSTnKwpI1KB0D3XBWFKY8etszbB6mvy/BYfI4iQV9
         s8Rw==
X-Gm-Message-State: ACgBeo3UkAf77voXpknWoWWm0TjdPabcSUmIT+aqc+mOo0JRiVxvlphK
        mtHYPPF7iGG9v3ObIEZSaaHw0NfVgYk56g==
X-Google-Smtp-Source: AA6agR7XZylg9NCHXxzgDFrCYdI/7rQX5BIWe8I0QaeeY4sn+jOdqQ2gDBhQbAY5sS++n+xGBuHo4A==
X-Received: by 2002:a05:622a:492:b0:35c:be5e:74a1 with SMTP id p18-20020a05622a049200b0035cbe5e74a1mr1459263qtx.677.1663168004521;
        Wed, 14 Sep 2022 08:06:44 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a0e9600b006ce76811a07sm1890768qkm.75.2022.09.14.08.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:06:44 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/17] btrfs: remove set/clear_pending_info helpers
Date:   Wed, 14 Sep 2022 11:06:25 -0400
Message-Id: <1925067c136aec3e1a01af78dbee66b6b0ebcc26.1663167823.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663167823.git.josef@toxicpanda.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
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

The last users of these helpers were removed in

5297199a8bca ("btrfs: remove inode number cache feature")

so delete these helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8b7b7a212da0..0003ba925d93 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1644,30 +1644,6 @@ do {									\
 #define btrfs_clear_pending(info, opt)	\
 	clear_bit(BTRFS_PENDING_##opt, &(info)->pending_changes)
 
-/*
- * Helpers for setting pending mount option changes.
- *
- * Expects corresponding macros
- * BTRFS_PENDING_SET_ and CLEAR_ + short mount option name
- */
-#define btrfs_set_pending_and_info(info, opt, fmt, args...)            \
-do {                                                                   \
-       if (!btrfs_raw_test_opt((info)->mount_opt, opt)) {              \
-               btrfs_info((info), fmt, ##args);                        \
-               btrfs_set_pending((info), SET_##opt);                   \
-               btrfs_clear_pending((info), CLEAR_##opt);               \
-       }                                                               \
-} while(0)
-
-#define btrfs_clear_pending_and_info(info, opt, fmt, args...)          \
-do {                                                                   \
-       if (btrfs_raw_test_opt((info)->mount_opt, opt)) {               \
-               btrfs_info((info), fmt, ##args);                        \
-               btrfs_set_pending((info), CLEAR_##opt);                 \
-               btrfs_clear_pending((info), SET_##opt);                 \
-       }                                                               \
-} while(0)
-
 /*
  * Inode flags
  */
-- 
2.26.3

