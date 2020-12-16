Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F32DC3E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgLPQTd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgLPQTc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:19:32 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DB0C0617A6
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:18:52 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id b64so18991260qkc.12
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QMa7bV9M06CL/jmsCalzp9jQP6wxpAhOdiQ2gxt0798=;
        b=yMIdoKibw18CQoRjkAQQj2eRRX0Yp89Vlnq7ZKnhcZiP6sSKfCSFX4GYRh2F6ES7ug
         OmREIH/CkQtfzi+RAR46S3JHHlDh3uEDPVVYsz+YW2lK3TyMCH52F/7rCmClErhtkJqZ
         NMwqodC2j2a+RO8gwBFYGCK811U950Ftg3yQjH8L2ZquTqsIodeYOR8u9/xr8i8hCGwB
         5Q1i2rlhsuYg8so+61fR5ROo5KJZYB4bhygbGN7vns+UlbJ+ULA3AJC1oO2de+WBiALb
         TAuA1P6UBtfwACcgdDU1N9siUvY2T8L9c6ymyKajSTQR5iJJecM6EDTkqJwXJ9DmGUjd
         a4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QMa7bV9M06CL/jmsCalzp9jQP6wxpAhOdiQ2gxt0798=;
        b=qpTo1KXetNPMQIePiZAIqcYU/j2Dhk4NSaD6r6KAqVKfiBa1EOoEO1xtSIpV5RAs48
         A7TUinG4c9k4mX5tCgCbhfEbrUb5t2PkS6RMMgye1TUGfefhogunkH5/bPVAnuwi5eI3
         9ToG3sWQ797LW8HlfByZgufmZMNU/Q/1miLM8ieHyDBJG9ONhKutLP90BZ1QL4F2+XNn
         THCnB3GQv2MUF9IXn0bysPXZWP4VNJ+w37jOKYtse3O1KJbZXKCqL8pc1teDTwedD/K+
         J5p4UU8lJOJNsXwvakWFdSMR50+JqizLP+Gmtoda6dKauS/Xb2nJZRRkYe7Gyaef+06R
         EEpg==
X-Gm-Message-State: AOAM533x/1ysB3H/+HKJinyixslkpjelORctA7sJWAZ/DCU5HZATxn0+
        OrIh8emmZL3GF+xg5pFijvLOotSoim+9xpks
X-Google-Smtp-Source: ABdhPJzhGPoT7ZBw8HtbgEy5KnYsGgkrpCA1JlMjoDzCUuiomLfPFoXNQfI8G09WErZDEYSiBgJ/QA==
X-Received: by 2002:a37:6790:: with SMTP id b138mr43571819qkc.465.1608135531293;
        Wed, 16 Dec 2020 08:18:51 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o30sm1179432qtd.24.2020.12.16.08.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:18:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/5] btrfs: allow error injection for btrfs_search_slot and btrfs_cow_block
Date:   Wed, 16 Dec 2020 11:18:43 -0500
Message-Id: <adca1f156b411abb1f094fe5bca34513fcd1f376.1608135381.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135381.git.josef@toxicpanda.com>
References: <cover.1608135381.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following patches are going to address error handling in relocation,
in order to test those patches I need to be able to inject errors in
btrfs_search_slot and btrfs_cow_block, as we call both of these pretty
often in different cases during relocation.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index cc89b63d65a4..56e132d825a2 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1494,6 +1494,7 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 
 	return ret;
 }
+ALLOW_ERROR_INJECTION(btrfs_cow_block, ERRNO);
 
 /*
  * helper function for defrag to decide if two blocks pointed to by a
@@ -2821,6 +2822,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		btrfs_release_path(p);
 	return ret;
 }
+ALLOW_ERROR_INJECTION(btrfs_search_slot, ERRNO);
 
 /*
  * Like btrfs_search_slot, this looks for a key in the given tree. It uses the
-- 
2.26.2

