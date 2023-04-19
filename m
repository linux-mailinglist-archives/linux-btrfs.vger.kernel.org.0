Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E1D6E8397
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjDSVYn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjDSVYm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:24:42 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85169E60
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:18 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id oj8so995402qvb.11
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939457; x=1684531457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwhWVImHwlVJpKJyq0m+xGQR6xufVt8BES4EXZJ4PnY=;
        b=UBtpcO80AD5SWlzFNsGGTmyaKzHE/fqKYbwKrDx1HvVMV4GuEix5LmkZjsxjNpOsod
         v237n+6WBNhxcUPSRAWxf+9VFfgbMwQ5flvK1YVEJBp9GyRjBpEioPXiIJuwHL3HMZ2a
         GCKWEIpqBMX1CB18QMTCGjZRryXsJxi7j0qJoXj1nJhlPIATEsNRNhb8qwDtjhPD+PSe
         Jz4gMwx1ZGs3NZ6Zvsz4b6Q0iOtY0Vkanydli03FLR2oXlIqrk9TGc6jWuDkAUQj/Czz
         lECFWwZHMv5Kswp+LUmGagCL/PqkCVZrQcZ76hrZBUJHFAOv+Cffhum7CKgvQuxgLZyK
         aVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939457; x=1684531457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwhWVImHwlVJpKJyq0m+xGQR6xufVt8BES4EXZJ4PnY=;
        b=YGCL5JGomBe08AK7Sg6eAopNwOCPTHC7DoJMrXZm0xp0dH/bqfAtMGxAMj9enRKnBX
         ZSbyilCq5NmMAJYHOHliSaFfLpJ92glZxc7sBXL1AKmoJcDYgQ33dhGYSv0MnKUxaJio
         apH/wOU4oL3ri+kHa4vjqHuTFxrcLu0QR69GjLeIUNbowvRF/+g6yCZh/ZcgnBhucaX7
         yh0xl1PszfEOmNcHEdE0rycpzfVv1d8aFSJbRloJZ06kaEcx/jj2Hv2UyOpgL/pUg7X1
         rjlM44puB1nzZ8KOG6cl8K98BpoTnpw42F2IrxCJAjXgIi7LP+HDpT8OVvhBm9I7LajY
         sSyQ==
X-Gm-Message-State: AAQBX9d4xFUhf0WAFTIpiZSCYWbG94lYPkUN616EOqbR4/QQyl3YUtzg
        Vp7I9h9RPYaadAoyF4sGVaMcbLqTgX7wdD+rzVsdtw==
X-Google-Smtp-Source: AKy350bEMnpf5e5T1c/MA67+PS1zoiSQJUNP014YwbRwSQbpdvm2T04mB5k5e8uweo1OHDoiUM8fXQ==
X-Received: by 2002:a05:6214:b65:b0:5df:d35d:20fb with SMTP id ey5-20020a0562140b6500b005dfd35d20fbmr9193075qvb.7.1681939456018;
        Wed, 19 Apr 2023 14:24:16 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id z3-20020a0cf243000000b005dd8b934587sm6792qvl.31.2023.04.19.14.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/18] btrfs-progs: add btrfs_root_id helper
Date:   Wed, 19 Apr 2023 17:23:53 -0400
Message-Id: <832cc319f165f64cfd22a80e18de666b29e80520.1681939316.git.josef@toxicpanda.com>
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

This exists in the kernel and is used throughout ctree.c, sync this
helper to make sync'ing ctree.c easier.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 655b714f..d5cd7803 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -476,6 +476,11 @@ struct btrfs_root {
 	struct rb_node rb_node;
 };
 
+static inline u64 btrfs_root_id(const struct btrfs_root *root)
+{
+	return root->root_key.objectid;
+}
+
 static inline u32 BTRFS_MAX_ITEM_SIZE(const struct btrfs_fs_info *info)
 {
 	return BTRFS_LEAF_DATA_SIZE(info) - sizeof(struct btrfs_item);
-- 
2.40.0

