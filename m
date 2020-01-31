Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1B3414F4C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgAaWgW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:22 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32856 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgAaWgW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:22 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so6742910qto.0
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cRM9PPePTz8q2Yy0WH5FdM9n9537Y5XGRyzvVXRZq9s=;
        b=UaVu8eZ/D4HgVObvZSpVavHrODBLpLKMspkKUYJuRJCJ0KbW3Pte4qH88e6P8oNdT2
         LWnohSzRrTwP28LSdZ08kXSKYqgTHzm36ddjub4VoJ5Ur7GKV1icIUxkZ/fapwhDg8Ox
         ydzEuRFrKP4QewWVcGfKD1zfbFpuz6ABx8ioq8aQ2hSsf78Y1P4GjIQoUjab9FXDUTd0
         qQhJsmLCVLSG69KfFHpEI0+YXN9yv+7/j7UOeiE3gz7qDnPrSJcKXXxMFsSjuCV39Sj7
         fEORHzHc/JashtZehxBnlSxwF5tqv/jfhW1UVm8EswqoacEQEnauViPZpgtTop/HK6TL
         D6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cRM9PPePTz8q2Yy0WH5FdM9n9537Y5XGRyzvVXRZq9s=;
        b=e7jOo6agEZSgW/PcHhiRkO7YPEFQehuVdKwWk35jBO6Qobv/betOiAPED2you9YcgB
         4j2QDxs/spdb4PEBSwwIp2dQX60cflcqQuMsRtiCGW3GL89OJaBjl6ankjLTwORXp5CK
         /2BatEDLSRVMq+X8Hjuq3dafg9/UN2yBBvLkxMx/VbeUu1iVWGNAiKfPdI/z1EagL9+/
         0nP45/4OuxLQ/ffe/r+6BwFHhcNixRlC3DKB/kTR8SQR0ljXbkk4OMKwKp9SAWQlOzVZ
         OoIX45NQsX8JjHM1d8Wo+hgn3k4lOQf8OkFUTP5fy8kEmJ1j8L0dpzlmwWq2kBxSnrxQ
         2/Hg==
X-Gm-Message-State: APjAAAU2qB1oeK6jqpa+s1Bukg8mSM3dXgaqdMyfdCfQnfKhWsyWM2TU
        LMjglViIzIXUiTiAL9TPP3qbIIYg0o0Mtw==
X-Google-Smtp-Source: APXvYqygoTO3R+4WAQjPOCi710FgSshd8BnaW3j10DaWyAZ45aRKvT6yvEecVkqtX9gx/7ClqARw9A==
X-Received: by 2002:ac8:969:: with SMTP id z38mr12610591qth.203.1580510180254;
        Fri, 31 Jan 2020 14:36:20 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i16sm5259045qkh.120.2020.01.31.14.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:19 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 02/23] btrfs: remove orig from shrink_delalloc
Date:   Fri, 31 Jan 2020 17:35:52 -0500
Message-Id: <20200131223613.490779-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't use this anywhere inside of shrink_delalloc, remove it.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index edda1ee0455e..671c3a379224 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -350,7 +350,7 @@ static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
  * shrink metadata reservation for delalloc
  */
 static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
-			    u64 orig, bool wait_ordered)
+			    bool wait_ordered)
 {
 	struct btrfs_space_info *space_info;
 	struct btrfs_trans_handle *trans;
@@ -569,7 +569,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case FLUSH_DELALLOC:
 	case FLUSH_DELALLOC_WAIT:
-		shrink_delalloc(fs_info, num_bytes * 2, num_bytes,
+		shrink_delalloc(fs_info, num_bytes * 2,
 				state == FLUSH_DELALLOC_WAIT);
 		break;
 	case FLUSH_DELAYED_REFS_NR:
-- 
2.24.1

