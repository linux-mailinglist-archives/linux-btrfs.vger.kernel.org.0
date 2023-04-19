Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149046E839F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjDSVZU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjDSVZC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:25:02 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A25683E2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:34 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id br19so639636qtb.7
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939473; x=1684531473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tY/X5irnrKHcjd+q+bOmbN93LJUD4dQVn5bA9YCuDTI=;
        b=MIZNnriUnnrtUsnWJZCLtfus2Sf4aQSvl/ViTx0xeVsAJ2dgxU9c9lIUURD2B7pTx1
         bNb6jAj3GirASFgEU8y+Ub9K53HSfJGECUdu+zcE2kIul0zis9PftfL8MqxjImszdo4p
         Q6X8HqAAuFAlzldzw3toref0QqNHblkCHygcUpXoaCBLIiHnXpu2DUbaGip2PojwTso5
         SAiNzz70uSwhZwQ3r27rXPq6qTgk7M9hsN3gw7iMbhhiqaaUOYeiGDrSOYfEOgOr81mj
         opUtXaeVI4mALtULJUkTOTxvdvKAAJXpxsR/hOY/hNJ41hDx8T5q+ayuVXTD9VvGt9eV
         7oUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939473; x=1684531473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tY/X5irnrKHcjd+q+bOmbN93LJUD4dQVn5bA9YCuDTI=;
        b=SmrzFAPBV0eTaoPT2qrDysLM+WEszD19TfZUwpysWd+0ATZYf7mreYnd1SQ7nhs9In
         khTPe7i3Gq31ZpqwGUFt0V/5+Qaee5bos8lP7tHlcAnpaPmWuqApl1j/kkP1aXo70wfg
         OkSQolm9z13AEPxlMDArjD6zfQOYQlJYgoLwkEDf+sfpPAL6SWIXibKEwigT5B7M9ZUm
         LlKJUsRQFefZTDS33tfBQUmrB/Nqtt1rxP0xDuAL0b9Mf66xj8HFvC4zQG3Jk/68zKFZ
         lyZZ2s9sXOvo8ZXvYrtJ8OheSRybCxZxq/zR39V6OlHO34Oa+hvsVD0ZdoF1QaxQ6el5
         O/nA==
X-Gm-Message-State: AAQBX9cYe/ZtQfkXVMSs6xwi2BsfqNyEDr4ttdGkkSkF/36b4SpOt9P5
        PWZwnZKXl6lxu8mv23Bbl8XnFU49bV5u3Vv7pI8wjQ==
X-Google-Smtp-Source: AKy350YaRv/XwrOE7JxkKuoIP2lLIDH4A+Lpp7Y0mxTdcFo4TsNiw/THN52eCzbMALYg6IQTnaWuiw==
X-Received: by 2002:ac8:7d52:0:b0:3e9:aa91:3627 with SMTP id h18-20020ac87d52000000b003e9aa913627mr8281013qtb.65.1681939472712;
        Wed, 19 Apr 2023 14:24:32 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id z39-20020a05620a262700b0074a293b1843sm4981567qko.19.2023.04.19.14.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 15/18] btrfs-progs: add BTRFS_STRIPE_LEN_SHIFT definition
Date:   Wed, 19 Apr 2023 17:24:06 -0400
Message-Id: <3e1522ac773660a2d1d287becf90b3c9d5efa013.1681939316.git.josef@toxicpanda.com>
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

This is used by tree-checker.c, so sync this into volumes.h to make it
easier to sync tree-checker.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/volumes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 6e9103a9..206eab77 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -24,6 +24,7 @@
 #include "kernel-lib/sizes.h"
 
 #define BTRFS_STRIPE_LEN	SZ_64K
+#define BTRFS_STRIPE_LEN_SHIFT	(16)
 
 struct btrfs_device {
 	struct list_head dev_list;
-- 
2.40.0

