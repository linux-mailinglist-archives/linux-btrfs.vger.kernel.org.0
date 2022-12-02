Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA333640A99
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Dec 2022 17:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiLBQZi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Dec 2022 11:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbiLBQZT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Dec 2022 11:25:19 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B64D825C
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Dec 2022 08:23:41 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id fz10so5831820qtb.3
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Dec 2022 08:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88S1gAHlKxnKPDFU2sN2y38SNzLzOJGLtkXuglDwHO4=;
        b=R1+qkp8byu6uTfMr0/XmHaV3NtkLB5bJlwbY/r+VOv6lwfvfKpUxBDmExwcp6p2kcu
         9Zw/qHebK5zVgC2Wlf/sPkm+uoxSXxo6aqbNQ36PSu7B7LqzQLtn9uMU1yACVUJBJu8K
         48x4UKK/1Ogl/cyZd4TaiRRsgL7Pyc/2fjr/xB0GpCvfqXsh/PVIkP5HMVts83CTH+04
         dPgi1al0C41vMXWTIS7sfcAT14HptxVFRx71NL+R8h9RYAuzdvsi0jj7A9rjrx32AAIB
         yvSerWiJtT4yXm1SOFJdaoJ4eyHngiksEwePz+RE8bW8p/1Dy7mkfuaMLfQCwULotGqj
         Cf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88S1gAHlKxnKPDFU2sN2y38SNzLzOJGLtkXuglDwHO4=;
        b=tLQXh5BwFU9a/G99cMfqERGUQax0NXTRomUFbsMiNJfi0SyHEoLdROQrFnKbmpw/6g
         mIXE0xjoR/dTTBZ6LTebTBvzVyBuqq46kS4zWnpUzIeUyTEJw7IauoifBHEbfsja6EGH
         BRSPt0+sC+toQHV2e23S/+UeRAS4ZNs85nSCwGpIZ9eMWtCbypW8Z61G0BGghhCq+mwM
         jxRHtOtmbl+s5wqwnpmkIWFDG8fPi43cGNIJ2xtET4e/YryvDIQVAyVkXlm/0L0qPNFc
         myhyRIWkev0qqO0JlEsPzCTXbUdtOHvZ52hsF1A8suGrq7P44FH93YgX4qwr0wjSovmD
         ssGA==
X-Gm-Message-State: ANoB5pk2R2shgk341MMLFnNXIXjiR9DIsaQGHl8Rb4wkBsOyHtM19TD/
        EWAkNEG+8mPCAehuaYtmyv1DZm0a0l2uFv5v
X-Google-Smtp-Source: AA0mqf7VS1HNeJvV22/vwuEfeITc9mWVwQkqyaFLq4n0vIKHXN++cqwpR/japygv2xBi175qnRw/uQ==
X-Received: by 2002:a05:620a:1aa3:b0:6fa:b56f:7ede with SMTP id bl35-20020a05620a1aa300b006fab56f7edemr64185735qkb.383.1669998220225;
        Fri, 02 Dec 2022 08:23:40 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a404600b006fc9fe67e34sm5439570qko.81.2022.12.02.08.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:23:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 05/10] btrfs-progs: sync compression.h from the kernel
Date:   Fri,  2 Dec 2022 11:23:27 -0500
Message-Id: <7738294f4256151194a38246a7dce2e6f615c96e.1669998153.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669998153.git.josef@toxicpanda.com>
References: <cover.1669998153.git.josef@toxicpanda.com>
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

This patch copies in compression.h from the kernel.  This is relatively
straightforward, we just have to drop the compression types definition
from ctree.h, and update the image to use BTRFS_NR_COMPRESS_TYPES
instead of BTRFS_COMPRESS_LAST, and add a few things to kerncompat.h to
make everything build smoothly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kerncompat.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kerncompat.h b/kerncompat.h
index cff73bdb..d493f077 100644
--- a/kerncompat.h
+++ b/kerncompat.h
@@ -568,8 +568,8 @@ struct work_struct {
 typedef struct wait_queue_head_s {
 } wait_queue_head_t;
 
+#define __user
 #define __init
 #define __cold
-#define __user
 
 #endif
-- 
2.26.3

