Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF8287B36
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2019 15:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407112AbfHINdh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Aug 2019 09:33:37 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40325 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407108AbfHINdg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Aug 2019 09:33:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so95715128qtn.7
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Aug 2019 06:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9CkSd9BE74+W51JiHMD0MEGF+qCN+/eIQz3CH+6fCG4=;
        b=CEsNXFHLrQ43EYfjarlfhurTCAViseulicL1Q4u7cGIZchC24tznjFnEZmJBt2czzs
         oyPTEq3xPccwcghUagDezQ19CTMR2hImRNplOFCIlfIjJejDWfeulzCl/eABVGQ1AeuD
         MGhS8kBA6AiWkTV54WmDW3OTaf+mB5+hDTVN08UWR36VOCjOztenAjZGy/cb/u4DKeZv
         iPI6ia+2Iff4oZNEgjN5lK/nPQmeUINU7N+sx2EznRVKvEeO7y+q9JqPKVkGFe1sPE/y
         fgdrEXZ1UA/85NIuw7qpvti9GDaxID+zxKZsy3fQJotkRq+mT77VJVNSy04G83QDMxiX
         tGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9CkSd9BE74+W51JiHMD0MEGF+qCN+/eIQz3CH+6fCG4=;
        b=qEKdhesAjO7pKs/VPSrPt78p6pVm3S4QCaxrZX43Fsp3sZzDd51YPnqPyo8f+cvusa
         lnDM1p0kKWrRSIdw04j0qsOGyIx0Zz0CFRvlFBZkwd/ImNeXKGDdAKcUhc8n/PmeXn0o
         3rOW1a3qYgGzBIn7eTsVtVvLoTEY20XqqLg0FmLQhOQGvKbmcvbL1r+v85KvlNVr8sRe
         JRxbHM9ytyW7Uj31gZzF8b/Ktkg30vbvFO4wP/14pgEAE3TUk4ne+tWb6hDsWDk5iAia
         SjYBl1V77BogZBci3VGDAMUE3jPk1v4rln03jAEziXTyK4Ni/qiDgz5eyvOcJ3S+RMDL
         p1uA==
X-Gm-Message-State: APjAAAVVouj0CDSu/e4v7q62T8MCWdGA1SyoBjy8j5mO9HWdmsv/E9b0
        FOwC3c7DTXdwOb8quJHGwSWaTytzWigtyw==
X-Google-Smtp-Source: APXvYqy8Ls9cMl2vKI7qQDBWFTQzkwpJkLvKevTUVkGKM8yxX8SdZwOnmjyYzMd3TPRgzpenkWBNag==
X-Received: by 2002:a0c:d6c3:: with SMTP id l3mr1378437qvi.219.1565357614908;
        Fri, 09 Aug 2019 06:33:34 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y188sm4195452qkc.29.2019.08.09.06.33.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 06:33:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/7] btrfs: add space reservation tracepoint for reserved bytes
Date:   Fri,  9 Aug 2019 09:33:23 -0400
Message-Id: <20190809133327.26509-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190809133327.26509-1-josef@toxicpanda.com>
References: <20190809133327.26509-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I noticed when folding the trace_btrfs_space_reservation() tracepoint
into the btrfs_space_info_update_* helpers that we didn't emit a
tracepoint when doing btrfs_add_reserved_bytes().  I know this is
because we were swapping bytes_may_use for bytes_reserved, so in my mind
there was no reason to have the tracepoint there.  But now there is
because we always emit the unreserve for the bytes_may_use side, and
this would have broken if compression was on anyway.  Add a tracepoint
to cover the bytes_reserved counter so the math still comes out right.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9867c5d98650..afae5c731904 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2758,6 +2758,8 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
 	} else {
 		cache->reserved += num_bytes;
 		space_info->bytes_reserved += num_bytes;
+		trace_btrfs_space_reservation(cache->fs_info, "space_info",
+					      space_info->flags, num_bytes, 1);
 		btrfs_space_info_update_bytes_may_use(cache->fs_info,
 						      space_info, -ram_bytes);
 		if (delalloc)
-- 
2.21.0

