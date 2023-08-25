Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443C0788FBE
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 22:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjHYUUP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 16:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjHYUTu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 16:19:50 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8822F171A
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:48 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bda8559fddso963401a34.1
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 13:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692994788; x=1693599588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6AEW6ge5cEyzzzVA9dkAUL4qwB1kcQfIvwbaN5wWw4=;
        b=UosHxHtJJhlVjt/4z/ToE3gGz0pvhEQcXcY27kYDqxn/54RvRnQModTKWQaP+ERGH6
         ptAUUZulOM48B1lVjk4akmEiFPCNEKp7sVDWz5xiCC/1ybWFZ2lNKp5wslCakGz2qMx1
         PedcDY9p1jvRnAJHrNTBixWURR1ODru8YbdfqT9l1gRKlLnK8/ux42WsT3qLTBZ4R5lU
         Mvfk252N+TiYP8k+/YjaYRRqd0L73FPniUG7xgQsgUr5GfCuMyaa8zQNOIv/OQBj8UNE
         S0puJOwLrO/Arzz43xhZJXMgN9eODwJQiuoW+dem3HudhCnJG1wVz4TqR83C9nAjj6t5
         b1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692994788; x=1693599588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6AEW6ge5cEyzzzVA9dkAUL4qwB1kcQfIvwbaN5wWw4=;
        b=BP8BXC545Qfv2ZMlHuWZkjPUewPDzfueH+OVer32b5CXpXn24vYaep98ijaKeLnL4g
         sTLa3+bN3+DTLYkZUqrROrHnIADLUFyQgzqnIlSqm0QW2SxKnccecRxleVThVakiPA0V
         Z1YNf8+oSYtW5UtfYoIuSHa2lLvO2sSsFkRJkaVYaS1Eo7u2MmY2+AfySKQzcsHpbsoG
         /nNRHAZ8MJKZIT2bVETyvkAM7hlzBUmlTg/RY49n90YtMc3S5HUC30TRRTB6QU7zbnpx
         BdZZ4Mjk3s9gpnX8yvSenpZzupb6zl6Vwr4/hvkqfC3FPv1I9vssvS272ZMXID23tiwl
         7KcA==
X-Gm-Message-State: AOJu0Yxdn5saVqriFY2FFnYWlv6tZYS4+xtans3v19cW2uwbTzMJwI29
        kBOdWDmlx+4G6z0PiHggJpxE84rG5Hlk674rwk8=
X-Google-Smtp-Source: AGHT+IGs2DXZOins3JQtj5WFhqhuK3oMbr74WFEsFKwcWysDkfYBu/+q4uXqk/Wpb1ram+BlwgCL7Q==
X-Received: by 2002:a05:6870:219e:b0:1bf:b00:acc5 with SMTP id l30-20020a056870219e00b001bf0b00acc5mr4084214oae.28.1692994787740;
        Fri, 25 Aug 2023 13:19:47 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i20-20020a0cf394000000b005dd8b9345b4sm764333qvk.76.2023.08.25.13.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:19:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 09/12] btrfs: add btrfs_delayed_ref_head declaration to extent-tree.h
Date:   Fri, 25 Aug 2023 16:19:27 -0400
Message-ID: <a1a8c85cf3ee5c7664bff1922fec323e37850607.1692994620.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692994620.git.josef@toxicpanda.com>
References: <cover.1692994620.git.josef@toxicpanda.com>
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

