Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A186251D79
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 18:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgHYQvK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 12:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHYQvK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 12:51:10 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCB9C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 09:51:08 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id i20so11588349qkk.8
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qh1+I5m3S0CUzdArGq/8+Vdc8tajBYMNIKh+mQHIE7s=;
        b=oawOzAj7eSO33quSGfXCx8Hc5pJyrt0a8wY66QlqrTcGwkqSE2o6SRobsDTC0xSZwU
         cayc2hvZ1sF8aymH4VcEK+HE4OrIjoD04T0hL+zVTAKEK7qizNMKAVhnhEXjUN7r9v85
         207wF0ZLOUaMccfxvHeSGP2kEchxu1gOzwBALss3m8XIxKrJt2o8DFiFCArri+Hjsy27
         Tj4pCPw2lAnCPAyMH6tGcVui5OXWNTn9/hUVk6iuTV4gnPrd8j579Pu/yLFSNH1xq24V
         fN3fzDQ5k5zE0Tjl5eXEJidsDPuhpOBDxjtg/UWAetiXdcB607wzEOPTaBfd3fhdCqnw
         C8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qh1+I5m3S0CUzdArGq/8+Vdc8tajBYMNIKh+mQHIE7s=;
        b=Qy0yTrtfNo2KKDIfpWO/cJN5FsOUJMUuBjWk7K8gYxG8msjgEtXaJiBACc6M0lBZai
         raShXgGxBAjm0gpphcyICWSGqTrxkoerRmrVCXzkYpw8JkUZ07HcCUkKOlt4C9Y3/P09
         YZNeoPnmcKIqWwfcX2SmwQOs1S/GH/ftLZluCn572LGJCcM4WemB1PqH7IxOilfGiEtt
         Wotq8mbc9oqTEvf9rbKXNTVWCcMK/dcd5sPH3fViHB4ErdMMsTU9Lg/Q8L7gr8NuJIcF
         9XzNFrM6Rg9TVsEg7+K/U88HIWXo6P8X4AeH0xEQljJSSlZCpFXI1PZQzL0jEk8Qkjlz
         +upw==
X-Gm-Message-State: AOAM5327A4Ox5YtXngmQKkgT0bWTIUDr9dvTj3F4rIXvM360Fs23cHQo
        zqQ7R0O/RGZ8jr/SzGFKhTyRnBsu3jHHX0nR
X-Google-Smtp-Source: ABdhPJzrfm6H6xB2mjXxuV8SVmykMFmyeNmpRKo7kc6fpQJiT7s0RDlTjZ5vcxiMiFnCsWs5C9rdaA==
X-Received: by 2002:a37:9245:: with SMTP id u66mr7785386qkd.471.1598374265057;
        Tue, 25 Aug 2020 09:51:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v202sm7545901qka.5.2020.08.25.09.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 09:51:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs-progs: add a warning label for RAID5/6
Date:   Tue, 25 Aug 2020 12:51:02 -0400
Message-Id: <bf9594ea55ce40af80548888070427ad97daf78a.1598374255.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We all know there's some dark and scary corners with RAID5/6, but users
may not know.  Add a warning message in mkfs so anybody trying to use
this will know things can go very wrong.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index 0a4de617..0db24ad4 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1183,6 +1183,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if ((data_profile | metadata_profile) &
 	    (BTRFS_BLOCK_GROUP_RAID5 | BTRFS_BLOCK_GROUP_RAID6)) {
 		features |= BTRFS_FEATURE_INCOMPAT_RAID56;
+		warning("RAID5/6 support is still experimental and has known "
+			"issues, do not rely on this for data you care about.\n");
 	}
 
 	if ((data_profile | metadata_profile) &
-- 
2.24.1

