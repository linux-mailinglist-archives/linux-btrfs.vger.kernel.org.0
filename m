Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D300F60E8B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiJZTLl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiJZTLX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:23 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296F513A7C3
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:48 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id x15so12427963qvp.1
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J598KhMubEcQc8LTYN7g732jht1tin2IwA60NXavMP0=;
        b=v0ukqdeReDOdVo3feaxVZEM4vT7TFeFWN2+PQTVtYSW8eAm7dHkHFErcijkiOTgMc+
         z46Hv2J2Y9UaSzKevGvY7iHM8oiC4VhIy4vfjZOSMi5gFCBppDc+7MogPJMVOv8xxJSu
         rd2cwkzJ5GpsvGgC7VdTUDrdadqWLuala1JFI/dWKDUL67D+Bvue77ugh11ocLRADmwr
         1TEIxFW3tNUK1zDSx99he1qgw24dhGISRj7laLg77nmCJ2SNVHklvW86/YQyDmKJX2Oj
         6ggPf7rEc2Ni063v/tS+kcibE2KHWLmgUj9fXsh+6uOsxBpeYv0Txd4HMA7cNbjTrtMy
         aulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J598KhMubEcQc8LTYN7g732jht1tin2IwA60NXavMP0=;
        b=D/ijBWVvfoTxZeykSWGEdw9DBN9CEV2xDvRhClggKcLCE/OsONKi0+TG928cSnt23X
         1fwUTqDplmF/IYJ7KxsNyxn06Oiyn6o2QFNA1Z0o6cZsYclcxB3GpOYg+jikKEudl71Z
         UKBjjl5bNlzb0CjT7wQn+F4JhYeuau8Gh5Qd7U3cGL6LLZQitYFVhuxX8X7wNy+JAHL3
         Gmm0rTzYkGxOqJJMOu3uROaaCWFZNB2d1Y02UHW2XDXm6zy8fwB6lNxMHSiX3AK04cbG
         VP3nU1ZWX2ERjhs6O09Ts54fg3wws/WRHPjW3sFeqiOKeeLQhpEeZFrX1Q0c4HejEsje
         xKmQ==
X-Gm-Message-State: ACrzQf3XVJ40uMjQZCOn62sfJtyLO9VcVe8t9nca4NIMS/QJvEfrs2bN
        1q4h37RrCtN1Vaw2WXsrbh9wLrXB5dZLwA==
X-Google-Smtp-Source: AMsMyM66eNNwO+R0PAEaiPUs4zb2q+59Ak5rvgP3eWGdLIVMy10/yJo5Elx81ve2g0ECvuWZyTZksg==
X-Received: by 2002:a05:6214:1d02:b0:4b7:6a28:3e85 with SMTP id e2-20020a0562141d0200b004b76a283e85mr30459661qvd.88.1666811327767;
        Wed, 26 Oct 2022 12:08:47 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id x11-20020a05620a258b00b006ceb933a9fesm4498153qko.81.2022.10.26.12.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:08:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/26] btrfs: add dependencies to fs.h and block-rsv.h
Date:   Wed, 26 Oct 2022 15:08:18 -0400
Message-Id: <167b0257aa04e4142750597be754696259d0205a.1666811038.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666811038.git.josef@toxicpanda.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
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

There's several structures that are embedded inside of fs_info.h, so if
we don't have all the proper includes when we include fs.h we'll get a
variety of compile errors.  I fixed this by adding a temporary c file
that just had #include "fs.h" and then added include files until the
compiler stopped complaining.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.h | 1 +
 fs/btrfs/fs.h        | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 7e9016a9e193..e2cf0dd43203 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -4,6 +4,7 @@
 #define BTRFS_BLOCK_RSV_H
 
 struct btrfs_trans_handle;
+struct btrfs_root;
 enum btrfs_reserve_flush_enum;
 
 /*
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index becb164d8a5d..f6e70c2b0c82 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -3,6 +3,14 @@
 #ifndef BTRFS_FS_H
 #define BTRFS_FS_H
 
+#include <linux/fs.h>
+#include <linux/btrfs_tree.h>
+#include <linux/sizes.h>
+#include "extent-io-tree.h"
+#include "extent_map.h"
+#include "async-thread.h"
+#include "block-rsv.h"
+
 #define BTRFS_MAX_EXTENT_SIZE SZ_128M
 
 #define BTRFS_OLDEST_GENERATION	0ULL
-- 
2.26.3

