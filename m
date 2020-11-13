Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA532B204C
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgKMQYg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgKMQYf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:35 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88971C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:35 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id ek7so4842553qvb.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oG2xSIQfSsBa4fowGpsMfl0NuKBnt4pJHQ1tHJzF0hg=;
        b=g814Nos2Adsi+Z581aUemT7zLd5heuzMu4ka5NVaBqRC+4SQwmHcdQHx3osbnnbYAi
         J0d+Xrx0QYkh9UlkfI0VbRcZOMcekWKmdX7Kd1+f7UgMhgW+V0GqdQ0KNQrVKQj8PlLB
         xt/Dac2RRapiQiATke9AXcpLftL6VTaABoI0Fv+U2CgXGpx1vQHyoVwTUqQyRCEeCtan
         Sopsy0HiT++uitrE94Qji1E9Lf48oM2IR/8512DMYsV63kJ1U4+9FYPB3nAZLXXF/CFo
         +0zzYFqMh/AAOkbuCoqE2QzxKvVmJpif41h3ipCc4AVDWik3h644GRLMJzc57/1CVpGs
         TzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oG2xSIQfSsBa4fowGpsMfl0NuKBnt4pJHQ1tHJzF0hg=;
        b=LZ7O09ll/+FF52q0oDSvDG/sPBTpLVv/xwpPK37qa817h/Dom+KNqnJWNRmPWXktK/
         rthvs0ER2cXTkWEMKib8ZcY0vQKZpv8vFmdAgSDRR9UAFBWlSGLYjwHUPW3O6puC6iDT
         N+NOtaIGBZp+4EVNaLsoL/8L5vGHt7hlnw0aaw9N7dd02yG60tI5LZAckDhzLYjQN1YT
         wE7W8AlFtaDuIbJWqhKqcMd/PPxftesSvPp0VFwEfLmZhbvVOgPSyTxRVkvF/kKscBtf
         V6OH8mEQM/5yIe4Sh5KL1IIxB00TY9ssT9Qwq/zqJEErbOk8IpReHxk8+d/IbMt6NFCc
         iVSw==
X-Gm-Message-State: AOAM530lZAxLaf/PoHgCG5c3mxDZUrxYh7pyOXEDiQ2doR8AamKlYAjT
        eB2fET2YbACHneaUQDBGOhN9DRgRiTtnYw==
X-Google-Smtp-Source: ABdhPJwTDpRBdLmKh7Dng9KCo+iCGpgaPNCqpXACn3Sq4Z/rQGqyT4zJ0tz6VzqktuKpyhOgsstyLA==
X-Received: by 2002:a05:6214:10c4:: with SMTP id r4mr3117258qvs.62.1605284670425;
        Fri, 13 Nov 2020 08:24:30 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i21sm6611718qtm.1.2020.11.13.08.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 30/42] btrfs: handle the loop btrfs_cow_block error in replace_path
Date:   Fri, 13 Nov 2020 11:23:20 -0500
Message-Id: <d5517f164340355756609b26f258fecd6184da1e.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As we loop through the path to replace it, we will have to cow each node
we hit on the path down to the lowest_level.  If this fails we simply
unlock and free the block and break from the loop.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 32e183b1d958..3e788b1249d3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1286,7 +1286,11 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 				ret = btrfs_cow_block(trans, dest, eb, parent,
 						      slot, &eb,
 						      BTRFS_NESTING_COW);
-				BUG_ON(ret);
+				if (ret) {
+					btrfs_tree_unlock(eb);
+					free_extent_buffer(eb);
+					break;
+				}
 			}
 
 			btrfs_tree_unlock(parent);
-- 
2.26.2

