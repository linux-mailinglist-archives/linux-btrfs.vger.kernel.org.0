Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CB12FFFCD
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 11:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbhAVKHU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 05:07:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:58388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727261AbhAVKAo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 05:00:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611309490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BkWZYUAG7HI4cAcD4oEPJaJd37Jy2TIv0AltZTE5yoQ=;
        b=sf15IOY1CdIxdH6MYVR75U8e3D/VIxakhZ3g+YlJdTB20eOmDColwvKpacsCYP6ei/qRhW
        LBaEc17mFtS/A23w1o++bBQAMdUt+1KBFFKo8Lc4fSDZOzr4rr/tmZPe4pQr47tgs4Ig+E
        hiahxIOjUWnGhe/xJHCHlQUfsEqSoaw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1EAFB805;
        Fri, 22 Jan 2021 09:58:09 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 13/14] lib/zstd: Convert constants to defines
Date:   Fri, 22 Jan 2021 11:58:04 +0200
Message-Id: <20210122095805.620458-14-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122095805.620458-1-nborisov@suse.com>
References: <20210122095805.620458-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Those constants are really used internally by zstd and including
linux/zstd.h into users results in the following warnings:

In file included from fs/btrfs/zstd.c:19:
./include/linux/zstd.h:798:21: warning: ‘ZSTD_skippableHeaderSize’ defined but not used [-Wunused-const-variable=]
  798 | static const size_t ZSTD_skippableHeaderSize = 8;
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/zstd.h:796:21: warning: ‘ZSTD_frameHeaderSize_max’ defined but not used [-Wunused-const-variable=]
  796 | static const size_t ZSTD_frameHeaderSize_max = ZSTD_FRAMEHEADERSIZE_MAX;
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/zstd.h:795:21: warning: ‘ZSTD_frameHeaderSize_min’ defined but not used [-Wunused-const-variable=]
  795 | static const size_t ZSTD_frameHeaderSize_min = ZSTD_FRAMEHEADERSIZE_MIN;
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/zstd.h:794:21: warning: ‘ZSTD_frameHeaderSize_prefix’ defined but not used [-Wunused-const-variable=]
  794 | static const size_t ZSTD_frameHeaderSize_prefix = 5;

So fix those warnings by turning the constants into defines.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 include/linux/zstd.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/zstd.h b/include/linux/zstd.h
index 249575e2485f..e87f78c9b19c 100644
--- a/include/linux/zstd.h
+++ b/include/linux/zstd.h
@@ -791,11 +791,11 @@ size_t ZSTD_DStreamOutSize(void);
 /* for static allocation */
 #define ZSTD_FRAMEHEADERSIZE_MAX 18
 #define ZSTD_FRAMEHEADERSIZE_MIN  6
-static const size_t ZSTD_frameHeaderSize_prefix = 5;
-static const size_t ZSTD_frameHeaderSize_min = ZSTD_FRAMEHEADERSIZE_MIN;
-static const size_t ZSTD_frameHeaderSize_max = ZSTD_FRAMEHEADERSIZE_MAX;
+#define ZSTD_frameHeaderSize_prefix 5
+#define ZSTD_frameHeaderSize_min ZSTD_FRAMEHEADERSIZE_MIN
+#define ZSTD_frameHeaderSize_max ZSTD_FRAMEHEADERSIZE_MAX
 /* magic number + skippable frame length */
-static const size_t ZSTD_skippableHeaderSize = 8;
+#define ZSTD_skippableHeaderSize 8
 
 
 /*-*************************************
-- 
2.25.1

