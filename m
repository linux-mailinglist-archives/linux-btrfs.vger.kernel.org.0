Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C88299FB8
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391852AbfHVTTL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:19:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36050 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731916AbfHVTTK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:19:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id z4so9011208qtc.3
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1o8IieOmo6+2IKl2pwbvEjA8/yPZzaeiP3so2okpJGU=;
        b=j8XJ3Dkg170UAkhTRF4WN5d3WKAcwJRaZ9UBWoBxiqxooHuwlhvgKIndIVe7FR8ZKj
         rrxGJrQONhMjx3pR+OarzYoHMTYmBy4pR1qTzYR87yHAk2sK07HcosvpEVaquTz+iASs
         XHCijTkkg032l63X+7qNhAWhjw5MW4ltMO+GkktKBhuZDxvHadgXNZMdPa3b6Xx8c8M6
         Kp5m4DtGdVDV4x3M/Hwl8ma2/sOF1/aipAqxdAdMeDL82NC5vj3fasZcHJU6jABLgYrg
         GyqQK/befwv5OSUQK2U+Yju/0bPE5qcD9YD3lBbQyb+Q2qBoUcpn2Ns+40GDsLzZ7z6Z
         mVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1o8IieOmo6+2IKl2pwbvEjA8/yPZzaeiP3so2okpJGU=;
        b=ZsgcYQTk17RhGglDxk79othdaNfIn0bqkUmeFU3fWbj8A5bGI2NAMKGk+LT8znTrZa
         7xLzAA+K0fTx+bIO1gR1c3cdsmBoRs5JVKNZkH8wUj2lSFrwwvlZljxO/s8BZUHZLq9y
         /7/aU3gPDrdkAiZG1DDlRenTW87rCV9aVnEsi7XAP7IqCYpv2eINtE0WDO9I2uNLkVHz
         qbcj3oXaEjisjTBFcib5su2C1jKjlikNmxe1gJrOXjlWSKzuiYZz4wmsG6eFwdcFSkSY
         UF17XU26ExAuf9iDho1kYtbN8xwRlXl8UW+JT3vMYAHj/7QAZPJVaZ3b//ykyIHp/ThE
         xNJA==
X-Gm-Message-State: APjAAAWBMyLjunjCLaqjJo8hIaejYrN38CeLuVdvgz2MU267LptmAgXn
        gNVyHb0ZPSImbDcjojija61iJA==
X-Google-Smtp-Source: APXvYqw8HDTNhbu9mCSNLcwA9JbUQci6tnfFGrWN7ZjO1kpJ9VeYpM0jQFpmeq35XTg/RpcpkDPJKQ==
X-Received: by 2002:ac8:64a:: with SMTP id e10mr1290355qth.30.1566501549873;
        Thu, 22 Aug 2019 12:19:09 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s27sm283609qkm.129.2019.08.22.12.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:19:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/5] btrfs: always reserve our entire size for the global reserve
Date:   Thu, 22 Aug 2019 15:19:01 -0400
Message-Id: <20190822191904.13939-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191904.13939-1-josef@toxicpanda.com>
References: <20190822191904.13939-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While messing with the overcommit logic I noticed that sometimes we'd
ENOSPC out when really we should have run out of space much earlier.  It
turns out it's because we'll only reserve up to the free amount left in
the space info for the global reserve, but that doesn't make sense with
overcommit because we could be well above our actual size.  This results
in the global reserve not carving out it's entire reservation, and thus
not putting enough pressure on the rest of the infrastructure to do the
right thing and ENOSPC out at a convenient time.  Fix this by always
taking our full reservation amount for the global reserve.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-rsv.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 76be1d978c36..67071bb8e433 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -296,15 +296,10 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	block_rsv->size = min_t(u64, num_bytes, SZ_512M);
 
 	if (block_rsv->reserved < block_rsv->size) {
-		num_bytes = btrfs_space_info_used(sinfo, true);
-		if (sinfo->total_bytes > num_bytes) {
-			num_bytes = sinfo->total_bytes - num_bytes;
-			num_bytes = min(num_bytes,
-					block_rsv->size - block_rsv->reserved);
-			block_rsv->reserved += num_bytes;
-			btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
-							      num_bytes);
-		}
+		num_bytes = block_rsv->size - block_rsv->reserved;
+		block_rsv->reserved += num_bytes;
+		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
+						      num_bytes);
 	} else if (block_rsv->reserved > block_rsv->size) {
 		num_bytes = block_rsv->reserved - block_rsv->size;
 		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
-- 
2.21.0

