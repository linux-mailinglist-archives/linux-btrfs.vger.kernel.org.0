Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B6A2970FA
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 15:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373721AbgJWN6U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 09:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372968AbgJWN6T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 09:58:19 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0F1C0613CE
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 06:58:19 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q199so1163169qke.10
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Oct 2020 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oQU7QLhY1kKqjctlcWh/QGaZxq5YshwtcYffCP+u30o=;
        b=ACU/VAYm5n8MT/nfXrF96uFCpJ8YTAjRscyR/LBc6O05/KEhEwrqOkohwLyMg8rT6G
         3ggSFplVuVYR71XbU2LfkZ34G/hgoQX/yet+CZ4Nm4oN1xH5GB5BMD2JPv9MDMcYkBU7
         p9B3IOR3d8PmQOMsPd40+K4xcARbzTcJ3xXanV1UcVS9THDHrrsg3bjxJhUfdm2jFTQ4
         0PBpDdBYRMda93+rODQLPyBJEhmZie4rMlHFV4gblEt6YTeexwOrrvV0ciknIl8pYeVB
         xTmiyqScaf11Aod7wOqo6GsAp55qQDgnNLAl+id4iQcyuMCjERM7MSYWecHE683HIPE9
         OH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oQU7QLhY1kKqjctlcWh/QGaZxq5YshwtcYffCP+u30o=;
        b=es1Slfx44+6LTxo4N2tH9SkZWQIEEcnXQilERGv9B6+2T6k1Ajbag4fG3rLn4RAL/b
         u6nGpd4rzbgvXC9ytxSEiUM8gsNopvocy5LHrDi5Pzhr/DmkK7M/NqQQzqOUX1WBcH0r
         q1w+FUKIlaYnidinjmejecQ0u/QPUlMUwgJJZdfxrDtLEL1kR16cZdk9C3Fd4eVccT5z
         VmYLmGBN4J1BC7hN2CpNhiWPPiCuZBAW85vrRUsjwKmbeEB0xdIhHOjKFGfo/N/2/MPj
         IMpltI/ksssOyy5U12WZurKw3iUtoL72OvpK6ECjdxdA/n8w8ngg6jzh5ux1HWTeCzFC
         2myA==
X-Gm-Message-State: AOAM533vVjoAYzkjw3DL+ojnz7E13RomnBubJwRLlMHeyXXxPTJhG54e
        CHrHd1e7LNxXicYmXGOBi+gfUIFFda9gJtxI
X-Google-Smtp-Source: ABdhPJypREheLEiXOR+UVVJnX5qwUE+9LA1ymz7/GbbQtuR4lVhB8YY+aXnSacTS08CSUYjrGUH2Og==
X-Received: by 2002:a37:5906:: with SMTP id n6mr2398547qkb.254.1603461498211;
        Fri, 23 Oct 2020 06:58:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j25sm741101qkk.124.2020.10.23.06.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:58:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/8] btrfs: explicitly protect ->last_byte_to_unpin in unpin_extent_range
Date:   Fri, 23 Oct 2020 09:58:06 -0400
Message-Id: <129622d0259e8e3209d4c9f9fe9a44e58a011b93.1603460665.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603460665.git.josef@toxicpanda.com>
References: <cover.1603460665.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently unpin_extent_range happens in the transaction commit context,
so we are protected from ->last_byte_to_unpin changing while we're
unpinning, because any new transactions would have to wait for us to
complete before modifying ->last_byte_to_unpin.

However in the future we may want to change how this works, for instance
with async unpinning or other such TODO items.  To prepare for that
future explicitly protect ->last_byte_to_unpin with the commit_root_sem
so we are sure it won't change while we're doing our work.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ee7bceace8b3..5d3564b077bf 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2791,11 +2791,13 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		len = cache->start + cache->length - start;
 		len = min(len, end + 1 - start);
 
+		down_read(&fs_info->commit_root_sem);
 		if (start < cache->last_byte_to_unpin && return_free_space) {
 			u64 add_len = min(len,
 					  cache->last_byte_to_unpin - start);
 			btrfs_add_free_space(cache, start, add_len);
 		}
+		up_read(&fs_info->commit_root_sem);
 
 		start += len;
 		total_unpinned += len;
-- 
2.26.2

