Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5179A395103
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 May 2021 14:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhE3M6Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 May 2021 08:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3M6X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 May 2021 08:58:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783EFC061574
        for <linux-btrfs@vger.kernel.org>; Sun, 30 May 2021 05:56:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so7101538pjp.4
        for <linux-btrfs@vger.kernel.org>; Sun, 30 May 2021 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=egu6MpTm7FhNBAO4dyfnth3r8vmFSUUHom3bdCl/UX4=;
        b=O3dldIroRJw9E/dhnsVckOWt6QF8HPYRvXyNsVUwsi3qJf3s0Kl6NWJPzlTNFvTkVQ
         nV5GWl9UYwt2df1ygG+tuMzJOqEM2V6NSJ9qZXZKSzJnfOt8lCXLRCGmilJ6Aw0+iXc0
         khhBWlaKbCPVby4uDbEfWgeKatKgZCFhtMhJ4A6dtrVByTNUMo/jCzYYpxIMtJAExGMi
         1QGibx/ndgZ32U6zPVSQBToveU1oIRtQziEf3Xp89O8ygSVXiZDc8wqOibqa+ibCIEGq
         y3T9ZtCYNKbTb9jmfu8li8/JD58Rrw0IyizKO7QFJIumPugISGTzFCq44/Nt237/wbeG
         ZfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=egu6MpTm7FhNBAO4dyfnth3r8vmFSUUHom3bdCl/UX4=;
        b=bPubtFFhTYCh0UdW9OguF7g4pDd3w6Lbdeim/qhpLltCM8Mp5svX+5EsUAqmcZR8kZ
         //m75tDbI9xTIgb7nOL4XrZS/I1mxCHxszcEjpo6ynvZZISapkvvcpKp7j+GVK/FxONB
         nlZGP4oenZYoeXot6QVtO4UFmpuZhKIpSZ06ZII5W9UBa07C2RnaqzySnpdB//O7iFzt
         RKk3co3LZIHLmMbKlkJCHaqQjOx91UjsFlnsCYpObnTADBxFM1Ca4othsbdEZyJBcu7S
         7FLyZdQfFVVhQS3u8MPpv1C4r+KCI1pHe4lU5a/n4uRKxSjMI9Zc/qipgE73Q4HiLx6c
         Pu7w==
X-Gm-Message-State: AOAM532wGtVirodMrWq9YCQ/e33YMzyKkaIi3tz6hM9Rsku7MUH5g9W6
        dzgkT/iKT1TQ9nqXKBYFXRjsHJrvxgB0FzTt
X-Google-Smtp-Source: ABdhPJykX9BoEHlL2EqpV6BLEpaNmX8T7Kr/pMglNjdKaCedTpW2GGRdZ/Z7PnWzre2ruRWtB6DYiQ==
X-Received: by 2002:a17:902:9a42:b029:f5:1cf7:2e52 with SMTP id x2-20020a1709029a42b02900f51cf72e52mr15914040plv.25.1622379404905;
        Sun, 30 May 2021 05:56:44 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id o6sm8709758pfb.126.2021.05.30.05.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 05:56:44 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: device: print num_stripes in usage command
Date:   Sun, 30 May 2021 12:56:36 +0000
Message-Id: <20210530125636.791651-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch appends num_stripes for each chunks in device usage commands.
It helps to see profiles easily. The output is like below.

/dev/vdb, ID: 1
   Device size:             1.00GiB
   Device slack:              0.00B
   Data,single[1]:        120.00MiB
   Metadata,DUP[2]:       102.38MiB
   System,DUP[2]:          16.00MiB
   Unallocated:           785.62MiB

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/filesystem-usage.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 107453d4..4d8c0c2d 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -1192,6 +1192,7 @@ void print_device_chunks(struct device_info *devinfo,
 		const char *r_mode;
 		u64 flags;
 		u64 size;
+		u64 num_stripes;
 
 		if (chunks_info_ptr[i].devid != devinfo->devid)
 			continue;
@@ -1201,10 +1202,13 @@ void print_device_chunks(struct device_info *devinfo,
 		description = btrfs_group_type_str(flags);
 		r_mode = btrfs_group_profile_str(flags);
 		size = calc_chunk_size(chunks_info_ptr+i);
-		printf("   %s,%s:%*s%10s\n",
+		num_stripes = chunks_info_ptr[i].num_stripes;
+		printf("   %s,%s[%llu]:%*s%10s\n",
 			description,
 			r_mode,
-			(int)(20 - strlen(description) - strlen(r_mode)), "",
+			num_stripes,
+			(int)(20 - strlen(description) - strlen(r_mode)
+				  - count_digits(num_stripes) - 2), "",
 			pretty_size_mode(size, unit_mode));
 
 		allocated += size;
-- 
2.25.1

