Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0F87859CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 15:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbjHWNwB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 09:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbjHWNv6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 09:51:58 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2598CDF
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:56 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-78a5384a5daso1597097241.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692798716; x=1693403516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6AEW6ge5cEyzzzVA9dkAUL4qwB1kcQfIvwbaN5wWw4=;
        b=GN0R8VEI8hWM0GZ1qcW3DbpbmjAh2OY9+uuzrqHPwmvqFfL1mE9b9xw+Z+1+ClaA1k
         xR5N1RxFq4hFteuVes1vthM9X0hI6WTBepZAf0SI2ZkOdTCG6K0cDr8K2JWj9uCyYggC
         K+OHIOTkOhlj55H/WLY57rGREKFiyt/xAYI5dnk9RdQSa8+ZU2LCSu3+yAOwYTAjxlJG
         kQUKtK9bLgLMl3L/GPfJZ1xM48d6+In48gWJ5uP92QLOAXou3HPksn9N7UFNEguTL0mJ
         hzpN4Q30MYPwLBi1mndf8oG3rywuhon6291d4c1u9s1mRaWlOt3rXgEEXgyl6EBLwcL7
         nKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798716; x=1693403516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6AEW6ge5cEyzzzVA9dkAUL4qwB1kcQfIvwbaN5wWw4=;
        b=Ak+RM90c24PwkwBeEF7Wu78Ffz9gj7a2eQE5I1VvA2P6tEKtC+95dP+AvMzugs1O7z
         hvVpuNMtNAs6FFGbWRj3DbBrssrUNStkGXElub3Iqu6yBO+QZrMVixQZKESYGzlhJUz4
         gB8o8/5wKS07uyx1q92iasEnXQxm/henV/7VaY/60dBYQb8QzLJspT169aabEv7G9L6P
         Y3ieQpg6N5TX/htcnL9w+p5lAwLGbo7JJJWh4/ik/qNdvFpjEFHrowZM5mDzKezWYo6+
         E6o0Sb9YmufWMp91z2XP3+w9k7Z13hdR4I8IutNJUQvcVEiVnkGgYwuHuGbEpXKJwMkG
         ExAg==
X-Gm-Message-State: AOJu0YyCh0Z0MPbLnFfHQqP7WIhJeBK9PbF1XqN5W58cXQuYM0uNqnRZ
        u/zOpcVnbyZHdmQJ/JRPl4dG0ThKfUQ4ovS6YDs=
X-Google-Smtp-Source: AGHT+IFKMRjbRNISU3pkHSGCactWIZi09EFRkuNNWjVpgKFNC86Hr0kuYWwbwsQ85zCDL7dvY5H5SA==
X-Received: by 2002:a67:f4c2:0:b0:443:ef68:1f07 with SMTP id s2-20020a67f4c2000000b00443ef681f07mr7597769vsn.2.1692798715825;
        Wed, 23 Aug 2023 06:51:55 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 10-20020a25030a000000b00c5ec980da48sm2843864ybd.9.2023.08.23.06.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:51:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/11] btrfs: add btrfs_delayed_ref_head declaration to extent-tree.h
Date:   Wed, 23 Aug 2023 09:51:35 -0400
Message-ID: <a1a8c85cf3ee5c7664bff1922fec323e37850607.1692798556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692798556.git.josef@toxicpanda.com>
References: <cover.1692798556.git.josef@toxicpanda.com>
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

extent-tree.h uses btrfs_delayed_ref_head in a function argument but
doesn't pull it's declaration from anywhere, add it to the top of the
header.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 88c249c37516..ab2016db17e8 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -7,6 +7,7 @@
 #include "block-group.h"
 
 struct btrfs_free_cluster;
+struct btrfs_delayed_ref_head;
 
 enum btrfs_extent_allocation_policy {
 	BTRFS_EXTENT_ALLOC_CLUSTERED,
-- 
2.41.0

