Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7AC476397
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbhLOUnu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbhLOUnt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:43:49 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AEAC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:49 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id kl7so4574384qvb.3
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qmoQ1YTDAvgUw0lSwDgGTPIB5lB8HSiswzX8oGS3n/Q=;
        b=FrWErbb3ZgqO1jnq/2UBZ18paa49PDoR68or9CVaA8amdQJsFS6P6Dj39HRCi6y4AE
         +EHxBQA1Lsrd6ngswGADkymhplFBiIUw61E9waEzCr89NoV72NAdxtZ/ksVsMFzCHItk
         HF6ciNaCvRYEwv/vV7R1VNBXmGgEoGesIEq/V/1tvDbGsb2AaMJKLYsIiHDmvOAKM/jO
         zyz3LxngOdZJg+L0MFKjZV82fsrKEzOoZ66GWUVCzMrKowy6sYG+leHAIB1+G6bdk6mC
         m1J1S4bf0H1lq8JhcKlTNYZcshwqyV/TCb1Bskys6iGvJfeWwX9BFSIbIW8NRM9vJMuC
         OdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qmoQ1YTDAvgUw0lSwDgGTPIB5lB8HSiswzX8oGS3n/Q=;
        b=lE4HtzYU4gXjP6RQQJo13SDKj9AGrCTSD5/24Y65KBSqualwFCQ8FKfIAOZoT4ouMu
         0wog/3gd7CWfOeX8Eswv2C28jy1CwL+EBReIJfp7YfyThd78FuBzbKMF5D7mQ0LfSS2C
         Om6oIs5jUTXPlesaOOuYyzNOgEn+qvv29QJiz0upzoPZtdwoXbHZySZ9NyAw69RmSmG7
         dD7IV0IfbdPSMTvdpQv3idAxnWOoe75J9jMkRdGND43cX/KX3tg4CkFZowVWOvpPhjEF
         4fMvKxKJTVtjOAL1V2pRpGlAhBAIjeWPBPZ9xjW3ywfO8cCvthhUbCHNwNkWPFGOLRKx
         7wMw==
X-Gm-Message-State: AOAM532JgjJlKIwUAAq3qJQhjlWSEvdBA39c6fb6tEmHyt0lWiOSvXBo
        3IXsCi0sciEF+aLYVEfXtnPr6F0uQ4aobg==
X-Google-Smtp-Source: ABdhPJwAM4qhVwFckHJeiTs3K6gyapzaPSiHsgTToc9CPEM/tswlnU9+hyVl3tMDSkPpyzqvTbKPsg==
X-Received: by 2002:a05:6214:528b:: with SMTP id kj11mr8663446qvb.75.1639601028347;
        Wed, 15 Dec 2021 12:43:48 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a10sm1641897qkc.92.2021.12.15.12.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:43:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/9] btrfs: remove BUG_ON(ret) in alloc_reserved_tree_block
Date:   Wed, 15 Dec 2021 15:43:37 -0500
Message-Id: <5e43cbd72e5b7afca607fb97079c65fd73701b0d.1639600854.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600854.git.josef@toxicpanda.com>
References: <cover.1639600854.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Switch this to an ASSERT() and return the error in the normal case.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8cb67df5acef..3715ee1f0a08 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4762,9 +4762,10 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	ret = btrfs_update_block_group(trans, extent_key.objectid,
 				       fs_info->nodesize, true);
 	if (ret) { /* -ENOENT, logic error */
+		ASSERT(!ret);
 		btrfs_err(fs_info, "update block group failed for %llu %llu",
 			extent_key.objectid, extent_key.offset);
-		BUG();
+		return ret;
 	}
 
 	trace_btrfs_reserved_extent_alloc(fs_info, extent_key.objectid,
-- 
2.26.3

