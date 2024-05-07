Return-Path: <linux-btrfs+bounces-4812-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E458BEB49
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EEAA1F22225
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 18:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456A316D9DF;
	Tue,  7 May 2024 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ZJSJm9ZK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365A416D9C8
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105558; cv=none; b=BWIllUVj5QMQS0ClCwpzGSgyxkccJMnMHVHDoigMEukpKfdPIHTxR7NiOLgyEYLTSXgBmsCDA/f4JQ6XR36rMiFbHZbUTPLZ2lvbdTVD+rDoPYOVx/RncSiSSP352wPnHBTZtrZ1XbTs0VvhCLSoqd29UGNJolSsxF4cPm3a+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105558; c=relaxed/simple;
	bh=zoV9661pC/mzj2acwhd6/oXf5IOiZQXnPfw67Hhy384=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwNnSlRnOXGs2JupXC/GXJLwvurFD3FcLdzVNPzLmKBfHFVDhTLD7UvrHA3zK3nio47c44urropXoeFZZkpHAmukPDW+xCKY50FHDgNpwhwNFkCzMm5+nDeIXuBQW7MIipXfflFtK49nfy8tvQ0mTpWwf9k+6Vjqso6GvcRVGto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ZJSJm9ZK; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61816fc256dso35570637b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715105556; x=1715710356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJjfXXCDeBwxlqZFPLDX4+ku/LlOc7au7TobqVnD3kM=;
        b=ZJSJm9ZKoHslMP8AGoeOaOa+9LM6QlXxoX8Zm2ic7+9Zm9p5N8vwc3qAv4O8erhcV7
         JTz1P3tkLa9Y032vqYBcTB6i0hPWxTtIOGUC4pIZnhxVfYEmsaW6af8sYS/SbGBDMOk7
         AaQkjN80QDwXdQH0Dn78DPbFdKrLE+mzvB8SDw1eA7i9kXTqq8BW+tAEUGpwt8dSuDlq
         8fQcaSZ0vtnnfRI2cEOXmRbuFVehgxZUqxdAGX4ZbXndENCsn9zQKXGZjIIjFD4P5VKb
         Enf1OXMdQi/4KFKBvqQxJPorJXGekkDwbFhJjwUF4AeMD3daY3za9OwjiE3QxlP4FSNQ
         pt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105556; x=1715710356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJjfXXCDeBwxlqZFPLDX4+ku/LlOc7au7TobqVnD3kM=;
        b=EZwYh+Goclt+ZnCzqpyrYNzGBZ4j4tYCly65acT4MFfj5RLA9Nr/b5qWQR2pG2OiO4
         02oHotIQRsMhmGI5Ts0p9iGfBxChHhQCQn9L6gZIjqomOtoMephM8KLFyseG31Oo9EY5
         Dsjt+OG5bi24lxsLBnXjSZnWdk9lI5Sfe4dRnWMZmEstA5b505O5tDEciNCBZYwB3gj/
         d6TN+QGu9Rk04I/5/W29MxFTu3P7jjscDkG/NhLkKGTFO0TuPi0LRnpUCHzR7PyO7zbg
         tMlMu7j0lHuhW+JrVH9FRlPzacv8GYPDz4rvPgVfxAnktJCSrBLgwA8tRkcHnsd1BmR4
         P5pw==
X-Gm-Message-State: AOJu0YzQn2TrNVqJJgSYMaJx5DSxskVr1jgBJW/JMaFEuRVHbxi0whjx
	CJO2IE0oYppoMhuAEU+6VzUUwKZ2/TgjyKv2pMSZqbbBjSQApWI3vkM6bQqmI1073T1XjioXxOq
	I
X-Google-Smtp-Source: AGHT+IEjm462uk+8kFrpmSoX1lwWTEdIp9nFDwB1P3DccU5z8S9KZ3O+7d5qxcMXE93ZyITsMSKkJg==
X-Received: by 2002:a81:9182:0:b0:618:90cc:bc43 with SMTP id 00721157ae682-62085a7a6f8mr6430567b3.22.1715105556077;
        Tue, 07 May 2024 11:12:36 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t2-20020a81e442000000b0061b07de76b3sm2820250ywl.38.2024.05.07.11.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:12:35 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 10/15] btrfs: handle errors from ref mods during UPDATE_BACKREF
Date: Tue,  7 May 2024 14:12:11 -0400
Message-ID: <a6f40150d908cb77872229e2160d4922a6084b5a.1715105406.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715105406.git.josef@toxicpanda.com>
References: <cover.1715105406.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have blanket BUG_ON(ret) after every one of these reference mod
attempts, which is just incorrect.  If we encounter any errors during
walk_down_tree() we will abort, so abort on any one of these failures.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index df3b6acc63cf..0dc333331219 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5418,11 +5418,20 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	if (!(wc->flags[level] & flag)) {
 		BUG_ON(!path->locks[level]);
 		ret = btrfs_inc_ref(trans, root, eb, 1);
-		BUG_ON(ret); /* -ENOMEM */
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 		ret = btrfs_dec_ref(trans, root, eb, 0);
-		BUG_ON(ret); /* -ENOMEM */
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 		ret = btrfs_set_disk_extent_flags(trans, eb, flag);
-		BUG_ON(ret); /* -ENOMEM */
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 		wc->flags[level] |= flag;
 	}
 
-- 
2.43.0


