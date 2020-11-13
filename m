Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE412B2050
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgKMQYp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgKMQYn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:43 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2150C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:43 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id v143so9314051qkb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=W8bi0LsLZ9Op3BC6ygY4VwpzbB9YzP9G+uGYGGAxXJk=;
        b=taQszHitPQLcL4nvgk9Nz84gpHx7UcAvUpf2JN0nTGMlBKmgwEsAuCyo3q4p9TVSIk
         72rgCHdF7Ua5TvgthPbegMI1wQZpDrW2n+4NM4dm7/7jZyMqfAp0RFvCUY+rc5YlULR3
         3xKwWrD91qQP3am4reB6Wz054VTmncFq2uXu8XsJwZ6CZAZ5a4b6IpFVGpjrwhWicXoc
         n0l4AAG1lsAhRxb473kUnGpnDnVa9BvOozBv8s/Ykx11Sh47DwIE4diaL79lUjVZDgeu
         4VDb/AtAtfMsu3oxyZPnETUwz46OVW2AEBx57LbswHZdQD1QMDJxvgLPpFczqP8Xq8wd
         bDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8bi0LsLZ9Op3BC6ygY4VwpzbB9YzP9G+uGYGGAxXJk=;
        b=LAT4inSflfn1kyZz9omvKV8jcOCFbQd8tlNPcAlxSWNDfMC6VxACP7F5b69iQkPEH/
         v1prhyBBFWD+1nat4cpxhoUlKGtkfEVS/DJnmTWI1Lz9K6qPNRIwGyzattlRuFj2o+4D
         Y7AXm1Tt7IXgI+1Z0F7GhzQlm4t+IurMUawK9zmZmG6loUi1+xUCXjO6sU+6O/CO0GVt
         1TvJW44nMb9csr1PvYM1fRo+aYTtGVSdozf/49TaIr1aseRPQLhaXIe3mU9/8NAnkgdV
         iLO9cLVqZhlgUwGTPlaUIxwv/KjcZpJ1jZbADRTnu9fD+drZK88pbZqbrZ6IgGH3uZyJ
         wYRA==
X-Gm-Message-State: AOAM533h/DWLNc3R6i4045UX8qJH1zqpoHMYr1ylxpEQmo2lYfON9X8D
        d0DxzQfXLCrxHNATXKO3mX3k9SnaBXbUfQ==
X-Google-Smtp-Source: ABdhPJwz9ASRT2W1wH3kVBFpq35kiI7Hq47YMhq/zoCsjmn2orDTyX3HBxhugBjzdPnRec35/2FuWA==
X-Received: by 2002:a37:be83:: with SMTP id o125mr2841130qkf.2.1605284677614;
        Fri, 13 Nov 2020 08:24:37 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v204sm7296168qka.4.2020.11.13.08.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 34/42] btrfs: check for BTRFS_BLOCK_FLAG_FULL_BACKREF being set improperly
Date:   Fri, 13 Nov 2020 11:23:24 -0500
Message-Id: <8409722498fbf7f228f3c6bfab699f42b6e14efd.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to validate that a data extent item does not have the
FULL_BACKREF flag set on it's flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-checker.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index d8af62d9f98b..df39ad294aa2 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1272,6 +1272,11 @@ static int check_extent_item(struct extent_buffer *leaf,
 				   key->offset, fs_info->sectorsize);
 			return -EUCLEAN;
 		}
+		if (flags & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
+			extent_err(leaf, slot,
+			"invalid extent flag, data has full backref set");
+			return -EUCLEAN;
+		}
 	}
 	ptr = (unsigned long)(struct btrfs_extent_item *)(ei + 1);
 
-- 
2.26.2

