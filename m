Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CF92DC439
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgLPQ2k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgLPQ2j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:39 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9043FC0619DB
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:51 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 19so23043115qkm.8
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8fTlPURwi1njot0TAiCWtZWFXAYhGZrv+pY5V3rdfo=;
        b=NkVZEB5dr7kaHHC215UjcKswFVnJtD0LtWcqkItwcZDcYoZWW5vmmxhC+zgNHWpaHd
         pKffOtJwscm8/OMX8FPsfz+azEJG24ho+7ynuHXl1J5D/qoi8Zg8JEfUXwIoEMBZrild
         42PIMVBtVmCS9zKUmG7879Psxgs1/Ou6J9Cks8Jcj/eCdYwQPCeWLVQd2DG9LDjZW0d9
         H2WcdaQrmqfGbNjzhpKrhfI+VipeFkvDheLuA0KcWX+SNxbUEQC18csmmrg9BqnScOZx
         TtR5SqM7LoLtoqozD3WgDP9lsWXrJKxmLBvroEnyuOfw0rVvTn3u5xrIJf3XMRVdfT47
         ucpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8fTlPURwi1njot0TAiCWtZWFXAYhGZrv+pY5V3rdfo=;
        b=VpZOE7T/4IHpFZBGHR76/brsPyjVx45PT6WqqAC7wbwS32h/9nhVI7W8rdl3SmufP7
         owfBYMIC5vshN62ha7uizKKsbXoT5T5rwjbq5WIQcI6SYg/adQZHZx+sGnwrjohNFBg+
         kcXYtwKmfoxaB8frH5aeX0vAOpuiBYFW2yod0glp5FalyR7ryy4sGuzMOnnKOl2CWKnB
         uUICw8zJFihHNVj+ewrrl/H8lhb+r7DHu/jGp5R7FKGAHviVkxh4k/oUwOv7oBGHph5K
         ZMUk/tvaEQj8U2RsCxrVjm457VWNL2UFOvw1n1RPP6ODJV15y84naDg35MQLdElfNeGR
         0qIw==
X-Gm-Message-State: AOAM533BqvRGKaYvtiOU9mwMz+DiitexpHbNQrBXdogdgvh5WHBVCU34
        sbSWc0v90j9CW4wQx/2X+Fq0LKWEt/4tFEsb
X-Google-Smtp-Source: ABdhPJzHMaK+mmX12Q8nBNCjiXcY6uILp9WdJVpF7qK/SNq2XJkS7Mi/QKAYY5jDlYQGEpFJI3QudA==
X-Received: by 2002:a37:8341:: with SMTP id f62mr46533489qkd.93.1608136070517;
        Wed, 16 Dec 2020 08:27:50 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d123sm1427394qke.95.2020.12.16.08.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 31/38] btrfs: check for BTRFS_BLOCK_FLAG_FULL_BACKREF being set improperly
Date:   Wed, 16 Dec 2020 11:26:47 -0500
Message-Id: <4fb851bdc44ef89ece4afad51082e0b9eaf71eec.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to validate that a data extent item does not have the
FULL_BACKREF flag set on it's flags.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-checker.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 028e733e42f3..39714aeb9b36 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1283,6 +1283,11 @@ static int check_extent_item(struct extent_buffer *leaf,
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

