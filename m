Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145C52172AF
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgGGPnB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPnA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:43:00 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F9CC061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:43:00 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id di5so14078924qvb.11
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wvZIkows8auYehqDoOck2uZN7Jfa9bG4yskXCxHR+6g=;
        b=HwEgY5rPoUvKCiOz9tpTZLddEjtoA1d/9GSeGDsUlbKX39urjo9EEdQ9a0/NQE90Np
         P4+urA92pJfCotzIV9IO/Q/xMaqy6aECzo0Hagtvu21ybd5+eWK3+D6YWRE42hQIg63E
         z6LweUhFs/8jDfD1u8FPq1SZovFE+OEGelG8Mn1qPbXv4r5DwRlbSA7t6EjXqG0iI6FB
         bw5G4rUEKB05SQoLrsTh0CLTqCwYOCs4bWp+W6yz5LGXwbtvtL0QszhRy9FTBGac6srY
         nTEDhUgAZXD8h6oqttyWZKX+HvpJKx+oAY/t2PtYlQeq8DB5ot1UGVlwcWyRgFepQzxa
         H2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wvZIkows8auYehqDoOck2uZN7Jfa9bG4yskXCxHR+6g=;
        b=PI1mdH2yu9agr0TUWjgTO5TLHZSm8OQJzpHunUSEYTF/v4CJOPmA/PoBEtSexcYqtp
         eRrPIs5u3vKZ6YUUFZ3mEHS4vp+A3Xnz5/4uQBsQhxu4mtjtPkYl7IqWt0algyKWf/B3
         6jUXjgPSj29bmWbSkJvixaK4M5PpB2xuz3sIlhEaaN8Xq90QDEMYvEInXdEvDi3It9DN
         JOr+UUrhRqZ6KprvUom5wKqBIwUeYMXGTR8TIN59acbS8Nn1Qf8K+cYN8OFtzoOnjXME
         /G89RYlnDJ+/wJFzY6uUks7SAr9qHw1M1TRIus1aqSPcDIu9vAenAg8quz0ztueLks31
         OEjA==
X-Gm-Message-State: AOAM531oSdItocr0MXrMl2WhyLI1SdtrMXHFSD5WmWB+rkrQMHjrdSFl
        IO9Hy7+ZXBdVx2odAxGnh8nNsWCoKYSBtw==
X-Google-Smtp-Source: ABdhPJzbxhdemk+gJMxiMEMl+CjHQleDohmKEBrM4bWsOGk3eLoqvCN7f7ZGAzY9ep2+zK/VYQiVhw==
X-Received: by 2002:a0c:a811:: with SMTP id w17mr17666528qva.164.1594136579248;
        Tue, 07 Jul 2020 08:42:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t9sm24901086qke.68.2020.07.07.08.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:42:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 05/23] btrfs: make ALLOC_CHUNK use the space info flags
Date:   Tue,  7 Jul 2020 11:42:28 -0400
Message-Id: <20200707154246.52844-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have traditionally used flush_space() to flush metadata space, so
we've been unconditionally using btrfs_metadata_alloc_profile() for our
profile to allocate a chunk.  However if we're going to use this for
data we need to use btrfs_get_alloc_profile() on the space_info we pass
in.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index dda0e9ec68e3..3f0e6fa31937 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -777,7 +777,8 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 			break;
 		}
 		ret = btrfs_chunk_alloc(trans,
-				btrfs_metadata_alloc_profile(fs_info),
+				btrfs_get_alloc_profile(fs_info,
+							space_info->flags),
 				(state == ALLOC_CHUNK) ? CHUNK_ALLOC_NO_FORCE :
 					CHUNK_ALLOC_FORCE);
 		btrfs_end_transaction(trans);
-- 
2.24.1

