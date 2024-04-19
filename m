Return-Path: <linux-btrfs+bounces-4440-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5BC8AB4EF
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608431F2151A
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CEE13C80A;
	Fri, 19 Apr 2024 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JgGSZnPn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF6813BAFF
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550640; cv=none; b=UghLJe7L7qtXtO/ev5sDeuHW6EnQmOkVopDZDNPMNIDVg713onXQx0GY3M0kZ/HTTXFmRqn10h2d+a5h4Ou6aWMqFf2u99jyOka8YZWVyOWPHfZy/9VUtz3M8OnJexY62CotCSpLpxTdT23FmjVyol3V8Ln9E2w1fQK1IQEedlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550640; c=relaxed/simple;
	bh=q7/5CkeojkN4ZfhKHGwqBHU0G5fisrm/mgoKjJ+nB5I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdgpQGvcZOFg32lnhlfNkGhv8ga8GIVAuFvpyoHRU3zbWYmLnsiPN2/VwoVAfYs+nn5Hl2tNBgyPsq48GBGoOOOVB7ddHEuGWrQyfpa4PgSw/dclobUXUO4SlGtiP67KzMOWa3ysU9z/AIy/hKBdH8v2kZNQfirCkcIi8hU3n5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JgGSZnPn; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-434c695ec3dso13206821cf.0
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713550637; x=1714155437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4UX7HscCsJKX1WEuQVA5yF+d3O92wIy5EAeUIpWIcY=;
        b=JgGSZnPnDF1PNhmFE0WZQbMhKYPgLPcu2DqjtHtLROV0XG9Y4yGgoStyfD3i+8UHXs
         vopplyf4CqjJE4xGMJ4w0RcSmSSiB/vMvpLRRm4Myu37UI2HJpSV9IVC0AtpSihX5JyF
         d3XLOA91zshBYv5S5vzH881Poe/zx7aPN1FI3BsM9rftQd4ghTFCCGef5L616smkHbq+
         0o6Vva8+q15tTm3mqgAXZTMteYdcnY9N9a2XkZpavtW7wMTes7Wb4A2zBa7/JaMlO3xB
         pmnBLUE8+yfuOVA30MbIS8Ylib80Rx+ESvuQAUszUXuoZ6OaYMbRtiApN7K3CFHakD+i
         wgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550637; x=1714155437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4UX7HscCsJKX1WEuQVA5yF+d3O92wIy5EAeUIpWIcY=;
        b=cZXlobyfgPRpe9X58LU4cpn79EBp8IpUpwwIb27D8JVCDKYonoDe2ouuyHkGCyb25l
         i6Z0/3KBaHvZ6SdKSikXlDhskiXlF8GsIAy8Lz2+UwROA6H2gGMkPvxANxGBNnRup32V
         P/R5cfIJGPRF/iuZ4+ejj9rHf/6Hve7SKc0m8BloM09wAO/adSwdTPH/kgJr5ocPSe27
         8VHx9FT3CChELMF58ElwGdScLCEQsQ40O2Pu072t/MyDa8Hfn/4b2QQWOrtS+OZ7KM5s
         0kMMexZA66msJKMApB7PNBbA+aDs8a6rfha9H2L4hUJwN0XDof++IaqEIEf2IG/7nldw
         Vrfw==
X-Gm-Message-State: AOJu0YxPhQ86qeXXFqH+R5cdedzSrzmrSvPfYf7lWLqc+hYE1/dAkjEv
	zGLDFOQDVSnvtuPcYnFMnfpm2lbgSmzq5f0UKDNSo5vFmrA81VzmicC8si8isX2a8/k5hs+HdMN
	r
X-Google-Smtp-Source: AGHT+IEae//+zBwDRFX4vKX4urxs7Ga5kYoC/VB7cpB3Ti/991yW+f/pyfSOE2TthUDGnVALt3w3nQ==
X-Received: by 2002:a05:622a:10f:b0:438:e018:18e4 with SMTP id u15-20020a05622a010f00b00438e01818e4mr2176342qtw.27.1713550637382;
        Fri, 19 Apr 2024 11:17:17 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y15-20020ac8708f000000b0043476c7f668sm1796650qto.5.2024.04.19.11.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:17:17 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 02/15] btrfs: push ->owner_root check into btrfs_read_extent_buffer
Date: Fri, 19 Apr 2024 14:16:57 -0400
Message-ID: <3487ee70ac2e8fd2c82027c892e91f12a4a47324.1713550368.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713550368.git.josef@toxicpanda.com>
References: <cover.1713550368.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we're only doing this in read_tree_block(), however
btrfs_check_eb_owner() properly deals with ->owner_root being set to 0,
and in fact we're duplicating this check in read_block_for_search().
Push this check up into btrfs_read_extent_buffer() and fixup
read_block_for_search() to just return the result from
btrfs_read_extent_buffer() and drop the duplicate check.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c   | 7 +------
 fs/btrfs/disk-io.c | 6 ++----
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1a49b9232990..48aa14046343 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1551,12 +1551,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 		if (ret) {
 			free_extent_buffer(tmp);
 			btrfs_release_path(p);
-			return -EIO;
-		}
-		if (btrfs_check_eb_owner(tmp, btrfs_root_id(root))) {
-			free_extent_buffer(tmp);
-			btrfs_release_path(p);
-			return -EUCLEAN;
+			return ret;
 		}
 
 		if (unlock_up)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c2dc88f909b0..64523dc1060d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -251,6 +251,8 @@ int btrfs_read_extent_buffer(struct extent_buffer *eb,
 	if (failed && !ret && failed_mirror)
 		btrfs_repair_eb_io_failure(eb, failed_mirror);
 
+	if (!ret)
+		ret = btrfs_check_eb_owner(eb, check->owner_root);
 	return ret;
 }
 
@@ -635,10 +637,6 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 		free_extent_buffer_stale(buf);
 		return ERR_PTR(ret);
 	}
-	if (btrfs_check_eb_owner(buf, check->owner_root)) {
-		free_extent_buffer_stale(buf);
-		return ERR_PTR(-EUCLEAN);
-	}
 	return buf;
 
 }
-- 
2.43.0


