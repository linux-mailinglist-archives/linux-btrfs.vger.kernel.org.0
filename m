Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6193F3460
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 21:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbhHTTM6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 15:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238377AbhHTTMv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 15:12:51 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE35DC061756
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:12 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id e15so8305381qtx.1
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2sSy/FaB/T+5g8Xks4oX61sGI4GeC/NhOaqeeIW5V1U=;
        b=FpLlOBAAzDOY1+D6+kLQiVEgRlLW9ZWvB5iUQLIX2RiiYUp2owUf9yrhmHPvN+f136
         lIXqWCPfZ6KRiCZFoS2iaD5db8sUPovSgEqxGNArVdOrNC4TEC3RKJnmLvBcTJ9XFlHJ
         XsUwRH01uK+JvB7yzN1mUxUq71HB+l+nQtJS3Ie1IEeRwCS9CCvnO5snRIAxqXjsQGr9
         az0h3b1/RkNDLGdwlNywL+QhRsKOTt9Y2wVfJR+a6gtEbK23VhzYUnUx+Plt31gc37Cd
         I4/HoOS+yUYE28mYsCNIRlcR7xYwCZZ1bSjjogLo7qrJ50ujvnDS87V87qlvU7w1YZnK
         /7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2sSy/FaB/T+5g8Xks4oX61sGI4GeC/NhOaqeeIW5V1U=;
        b=EXJbCXW3Ckr9xNhU3KI/tESKC+TcAks0zjKR3bj5jBUIqZUyRHeNMXjWsyagv31KVe
         GpUPUn0EzHiQy63MiecEg+oNwSi0DOTcAqiKtxbZcSfV4tm8aBUYoVUNjtHpWIXmAuiK
         BD+DE3Nc4C/sD+cTwZYJ3FKV6o8+GGg6aL+xVGYct7hWGkFrXamptK5jQ9lU4k1dtgvo
         zJ/NVMe7tJpPmamAHGvbIxQBxDmxSUd9zE5rcPfcNZ4Att7xdhheu3nmPpQPYbXXhK8V
         e1th20X5ySB85eawz8cnwcpZnAguLHlsx+qEf3LCY3Q0WTMDmq1+yOdqKQ9dIQVETN7t
         MMog==
X-Gm-Message-State: AOAM531lUJS/FwP14XeR/e1lXDW2dLdntwNvykEIxyseyLGOSrmO+m+Z
        OswKAZt3VEPvifIaKcmkXN6CbVRXBy8+fQ==
X-Google-Smtp-Source: ABdhPJxnSpZMJZSggvMRSZifA8BoaYQPaNu0Ax0aKA8i/OgrN5ARr2kR46lGAEHKuLN7jMjTlJzZUg==
X-Received: by 2002:a05:622a:148c:: with SMTP id t12mr494538qtx.156.1629486731894;
        Fri, 20 Aug 2021 12:12:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d7sm3013451qth.70.2021.08.20.12.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:12:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 9/9] btrfs-progs: add the incompat flag for extent tree v2
Date:   Fri, 20 Aug 2021 15:11:57 -0400
Message-Id: <6648a0b053fe033a03fc27c4221de6adbdd22c56.1629486429.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629486429.git.josef@toxicpanda.com>
References: <cover.1629486429.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I will have a lot of preparatory patches to reduce the review pain of
this large feature.  In order to enable that work define the incompat
flag.  Once all of the work lands to support the feature there will be a
patch to actually enable us to select it and manipulate file systems
with that incompat flag set.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 3cca6032..fb918aba 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -496,6 +496,7 @@ struct btrfs_super_block {
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID    (1ULL << 10)
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
+#define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
 
 #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
 
-- 
2.26.3

