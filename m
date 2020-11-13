Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E452B2029
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgKMQXm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgKMQXm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:23:42 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7FDC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:42 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id g19so4857577qvy.2
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IRfNdd73Bs7m54/hBEEmNRMtcKR05nMzxapQmsntDLM=;
        b=orI9TRmZbbiB5i+55kyO/FG6WgG8QdX+WvhWiehUsj0AblH+fZVUsPbBkxm4TZGlPb
         K3liPeDjxZHs7pJdEOtvRb1BC3Xtk2UqM6l5HDUDNKa1vc1KvUgT8OQP/rBif6+eiBeP
         M4MvQ5kFveU9dmeuDQsDjOF1J9MRYfAK9RtOk7E/MTdpkAeYZA2VNOt8VBRRpgfqY/5r
         tn8NHMXXcWSflPfLw4iPTjcghrFb2yY+ZdoGANaDOeSl+w7PTyo+sAs2kdLYZsSX1qOE
         PNPuIS6GvR/5KTVcxZSZYyE/26o+S5pYS7C6KPb2aP3p2CPgQJ70HQzY9Cg+dyQAyIJf
         /wYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IRfNdd73Bs7m54/hBEEmNRMtcKR05nMzxapQmsntDLM=;
        b=WyeJgNKtN7ad0YUx/fYeiZ+B+Wg5D8gqxYv1D9bTZtBaufGkRsCTUQFfq0VBCd1jZt
         wkxzg6cO3n41YhJbAXEvdMJ+6wrOVL21WXhQH5kmtFgRkMHUI2c2BPDRNS/RO+AbDYG2
         h5rZXhGHzQyXD+WXVU+phh9Mi5ofG8bQyrBpUbgquQHBWzbx0LG2BsUOccbNCYHQboS7
         CZcoWvS9hfq+pPBycsAF238JBfz+isIs0CRI9f+5xb9+U0GWrDR4GW98HO3aSggAwYPg
         LmBJKauROrcDINFCkNZrrnwck/fm5oSajkbCimfQXzkOeBLIjRUrmH9mJvc6s14fFAuM
         CQWQ==
X-Gm-Message-State: AOAM5324M0H/Df3zEBh4rw0P4VPQIWGApXUIuMkcF3PsyRXY/EjWzYW+
        NbeuxXDijtzblrnQ1nE2Q6ZnEmPDartpnQ==
X-Google-Smtp-Source: ABdhPJyEM/2C9wNXYwayQm0sTh9Dqy/d29/FF5dPDfPSvmsd9rNR8zSX7vHQRkx3lDjPHXCURuqnNw==
X-Received: by 2002:a05:6214:366:: with SMTP id t6mr3232140qvu.58.1605284616534;
        Fri, 13 Nov 2020 08:23:36 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i21sm6610199qtm.1.2020.11.13.08.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:23:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 01/42] btrfs: allow error injection for btrfs_search_slot and btrfs_cow_block
Date:   Fri, 13 Nov 2020 11:22:51 -0500
Message-Id: <cb4cb2576f0a369d8bf7123ce30ccd7201f9c934.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following patches are going to address error handling in relocation,
in order to test those patches I need to be able to inject errors in
btrfs_search_slot and btrfs_cow_block, as we call both of these pretty
often in different cases during relocation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index f2c3d29b6bc4..8e551b237ee0 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1494,6 +1494,7 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 
 	return ret;
 }
+ALLOW_ERROR_INJECTION(btrfs_cow_block, ERRNO);
 
 /*
  * helper function for defrag to decide if two blocks pointed to by a
@@ -2817,6 +2818,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		btrfs_release_path(p);
 	return ret;
 }
+ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
 
 /*
  * Like btrfs_search_slot, this looks for a key in the given tree. It uses the
-- 
2.26.2

