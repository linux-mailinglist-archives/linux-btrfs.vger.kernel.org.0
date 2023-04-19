Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4F86E839E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjDSVZL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjDSVYw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:24:52 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E1B6A42
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:24 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id qf26so1046649qvb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939463; x=1684531463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TneaNOI5xPmx1jwrTCHvRShtF0V3syewlI+A4v4lew=;
        b=vOWI4xSgW+PJ+8f159QaZyiHIVucTjz+dFMYQwn0tvg1M8865Iuo5P+LU5lM4Q5qlq
         mJgt3KNUX1ifPywIm0lBfIWTrOPuQqd3NOA9YKe7xrdEgfSlKYpKyC4sv7S7C9fFjBw5
         9waIRib3HSuEda0azR1L2vOv7zpLVBn9BOmGGUEGXsEMLJqf/iZeb/U3kY89K10Xy6lz
         5qierU/SKprmyAYucjKClnMLuxJGaBUetINhy46eGUjDg5JGuzSXi+iU1v2CkimaqNu2
         NIkjfpJ7MwlwyRsoVQIjgRMJ514m6f3ZDU2RvS/bveba4c5xhEZ4fxDrC/ohLlCjfoP/
         MCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939463; x=1684531463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TneaNOI5xPmx1jwrTCHvRShtF0V3syewlI+A4v4lew=;
        b=cyIRy239PaL37qWX4GKYdU8UUSKUtcxd2XIodLbKcOz6j9/CxLayBvNXG4OL4BeqY0
         2YxNPx0ADfSTzeMadUQZsDnEgqgCMZ7T0rO0Gta3r4tZ0Lk4agXE+0G1j0sKr6O9PkxG
         5CauS41XOGtTCseQOZcKW5xIt4ygA4Si0qjY7B1TLS1VBGiDhqsib/48sDlSf9Jm48dg
         lgeZBoBwz9BPs3fGvn4FCr9aSzx5QYM1CQfOj0qYI+3GLIFwXXFBz4P+Hh/yz/sseRkv
         N0KMobPXHeLLit4XAvPaibpEK6KfqPfaRMvYK9iwfbxhqAvavqgBbpj3RB60llraKZYd
         Ufow==
X-Gm-Message-State: AAQBX9cpOnyUtwawkiDKGfzZZ9UT4s8N1Bo8301JZPCuIIqLVvn21XZt
        KRv4N+59sP3RgR2igsofGKyyIhSZqUO3nAeirOLShA==
X-Google-Smtp-Source: AKy350ZOvKoNPrdOXVoolZF4UOU20zILlE0lyocTAGbicSk7WhlpsqHB0gZ9y7xnQgPgluEWiomPVg==
X-Received: by 2002:a05:6214:1c86:b0:5ef:4435:f1cd with SMTP id ib6-20020a0562141c8600b005ef4435f1cdmr25400629qvb.27.1681939462658;
        Wed, 19 Apr 2023 14:24:22 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id k15-20020a0cf58f000000b005dd8b934595sm4878qvm.45.2023.04.19.14.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/18] btrfs-progs: add accounting_lock to btrfs_root
Date:   Wed, 19 Apr 2023 17:23:58 -0400
Message-Id: <0aae3e1c47df23420ca83ff78fd261dd819bd2ef.1681939316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939316.git.josef@toxicpanda.com>
References: <cover.1681939316.git.josef@toxicpanda.com>
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

This is used to protect the used count for btrfs_root in the kernel,
sync it to btrfs-progs to allow us to sync ctree.c into btrfs-progs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 26171288..50f97533 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -479,6 +479,8 @@ struct btrfs_root {
 	/* the dirty list is only used by non-reference counted roots */
 	struct list_head dirty_list;
 	struct rb_node rb_node;
+
+	spinlock_t accounting_lock;
 };
 
 static inline u64 btrfs_root_id(const struct btrfs_root *root)
-- 
2.40.0

