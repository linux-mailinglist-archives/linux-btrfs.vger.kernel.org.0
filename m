Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65ACD365BF8
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Apr 2021 17:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhDTPRK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 11:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhDTPRJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 11:17:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E017C06174A;
        Tue, 20 Apr 2021 08:16:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a4so38029219wrr.2;
        Tue, 20 Apr 2021 08:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mgB0zcGWFNH/Q/FVhfin+obpUYcpRcl494fttRvC2kc=;
        b=BWTmydHs3Izqqn+cHtKSrjGm9O5nH41FX27Drc7tweu2Kla4Qj27OmTuxqTqBxCpjt
         5WIxSB9LXmQc7oHREnynz3T4N6gAmx9Lw8yDIesjzyjRtz8sQaaBdZ+f4BZWPXdTJpbL
         jhVYEeEHPnS0xF2vkW4SKW5i2SISppDdDPKrxPu71T9mc39bqe6z0fhl6S5evf8rkwZa
         sz25ETkot/D7nHS2yefY9TkBigDJxKhQ9xqhStnwtNWQDpM9lnZLNsni5Sg9o+KYoQvy
         PQhn4gJrKZvDSUIXjn3Odk3wKKYjqykpYjNd17b6u/LJSOTA6ntoCCta9x66QnWPU4Cj
         Lzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mgB0zcGWFNH/Q/FVhfin+obpUYcpRcl494fttRvC2kc=;
        b=dEoNDorsgCcDStGoww5EKU3zxTBnZZ48jCw37u6pOsdJwtntA1TB7QFfBEHIGb0Ou2
         F/S1WVbl0p/S9NBAxQmQ93aTcFCclL3XyT4kGaD0T0jMniI6LDW9EjWKnjYPSCE/0MFi
         vrn2kFPKX5iWYx9H3aGhcKvIxQ+2TrDfF0aqQfZYvlpeAI9seNPa1RHrDTanlTaoKSL0
         7sz87C5GqBedSvfFlOWpb514D0wvIhJGCnrmVs/AsJL8EbJiPM5lzTTvugNE6Vt08UV0
         Ad48MjVqb4x+lUGQOfap2YqU6hVHUT8Z85ISv+BNB/iKW2QVznQrB42MyYy82pObDe5W
         jzBA==
X-Gm-Message-State: AOAM533ZVzWm/hNA/s8PtO6hmih0UXpsI5ofHdBu3a22jax6Y7vdqFtD
        G7//DfoiAqFdjYw8pXoXlYvaCYmZGgqX7A==
X-Google-Smtp-Source: ABdhPJwpZe9twxVd5/Re4ELKgGEOdxkzHuBDhuUHrH4/PvlSj3nCn9tnG6VEZy6oXnkvlnA1kXJX5Q==
X-Received: by 2002:a05:6000:1ac7:: with SMTP id i7mr21610164wry.9.1618931797115;
        Tue, 20 Apr 2021 08:16:37 -0700 (PDT)
Received: from localhost.localdomain ([197.240.34.190])
        by smtp.gmail.com with ESMTPSA id a8sm30983776wrh.91.2021.04.20.08.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 08:16:36 -0700 (PDT)
From:   Khaled ROMDHANI <khaledromdhani216@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     Khaled ROMDHANI <khaledromdhani216@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v3] fs/btrfs: Fix uninitialized variable
Date:   Tue, 20 Apr 2021 16:16:26 +0100
Message-Id: <20210420151626.6045-1-khaledromdhani216@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As reported by the Coverity static analysis.
The variable zone is not initialized which
may causes a failed assertion.

Addresses-Coverity: ("Uninitialized variables")
Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
---
v3: catch default as an assertion failure
as proposed by David Sterba.
---
 fs/btrfs/zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 70b23a0d03b1..432509f4b3ac 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -143,6 +143,9 @@ static inline u32 sb_zone_number(int shift, int mirror)
 	case 0: zone = 0; break;
 	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
 	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
+	default:
+		ASSERT(zone);
+		break;
 	}
 
 	ASSERT(zone <= U32_MAX);
-- 
2.17.1

