Return-Path: <linux-btrfs+bounces-483-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444478015E6
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 23:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31F7281C34
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 22:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27375B5C5;
	Fri,  1 Dec 2023 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Fr5k1ZuA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F313D63
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 14:12:00 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d4f71f7e9fso10514587b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 14:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468719; x=1702073519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohptYzYgHlOumuqXZ0mAmMVKlzKLSW+TQdF6edwaJZU=;
        b=Fr5k1ZuAqESTCONSjsVERae+8KTWvY1B/QUYkt2ZggzTK8QgglJFRTJliZBCcOZNCj
         rBrJY3xHcKwcnAIvh7ys1CCJuZMzpTSH45pBwSNd4o6TplYnojD/2JMonw4fEN+ZNanF
         bz1EWuc2GznipJe3D4IWDzm3I9UrR818y9Z3a++H0QJZ4xSYJYZfzPkVREBCGF+w07ye
         2tR1o0CRLsRaBqY9sCnxO/Vu1kPwQxf17do9qqhEMi2nE+zjn7pkNv8uFgKcOYsr0Ic1
         rnXmOLztE7HMAyECUZaqYZKDeYvPtcRL1iuYCu1Bz1c6c18TTG8yoUrzpaJc0z3rGV6W
         tlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468719; x=1702073519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohptYzYgHlOumuqXZ0mAmMVKlzKLSW+TQdF6edwaJZU=;
        b=WSXBz2HhNpSZ3MJfB6YYpcKT6lBIv4Q9VKLhAefIErVly6q2YZE6W+6xKxA/oMVfSl
         Up7eYwyplgiqxo9o+GrQyiVaPOIhvTvYf/wr4gbEcymt6hcAyP2opMCYxNbQbwt+WcXl
         Xjm+XVq1O5OTZxKRlv2UzvaQxWL/NQL61e0SdSns+iAsWzn6dK+0AJGPuaGce7Eja1cH
         EJKFAE39e3Q29M7N+YzYlcEizlsrcmvzuOTolqE11e4qk6bcWE7WlFlWuYnoANCsU6H1
         m7mjk/LcMIgFQ6+NGVzM4ygRaf/K+Gu4b4kZ+A/ng2YT3lneQnsoiARnw8+iZDvcelX1
         a2zg==
X-Gm-Message-State: AOJu0Yx6eR9/Va7XolqoOTrG8qWpJ/Vp9FR7WABz+2MHva0bpaeSqaWd
	xKB+p1v+IA40QSfcbJ2tdIkndrST57DjL1XK7S4CXg==
X-Google-Smtp-Source: AGHT+IH557m518u3E1N6COVxegrdWL0VhOBMCiONVniKH6nlej8tgN3H5VGUfENJ4eyTMWGrStjVWw==
X-Received: by 2002:a81:794f:0:b0:5d2:1b58:174 with SMTP id u76-20020a81794f000000b005d21b580174mr356847ywc.25.1701468719151;
        Fri, 01 Dec 2023 14:11:59 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o125-20020a817383000000b005d39a1ae8b3sm1157032ywc.1.2023.12.01.14.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:11:58 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 01/46] fs: move fscrypt keyring destruction to after ->put_super
Date: Fri,  1 Dec 2023 17:10:58 -0500
Message-ID: <122a3db06dbf6ac1ece5660895a69039fe45f50d.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs has a variety of asynchronous things we do with inodes that can
potentially last until ->put_super, when we shut everything down and
clean up all of our async work.  Due to this we need to move
fscrypt_destroy_keyring() to after ->put_super, otherwise we get
warnings about still having active references on the master key.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/super.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 076392396e72..faf7d248145d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -681,12 +681,6 @@ void generic_shutdown_super(struct super_block *sb)
 		fsnotify_sb_delete(sb);
 		security_sb_delete(sb);
 
-		/*
-		 * Now that all potentially-encrypted inodes have been evicted,
-		 * the fscrypt keyring can be destroyed.
-		 */
-		fscrypt_destroy_keyring(sb);
-
 		if (sb->s_dio_done_wq) {
 			destroy_workqueue(sb->s_dio_done_wq);
 			sb->s_dio_done_wq = NULL;
@@ -695,6 +689,12 @@ void generic_shutdown_super(struct super_block *sb)
 		if (sop->put_super)
 			sop->put_super(sb);
 
+		/*
+		 * Now that all potentially-encrypted inodes have been evicted,
+		 * the fscrypt keyring can be destroyed.
+		 */
+		fscrypt_destroy_keyring(sb);
+
 		if (CHECK_DATA_CORRUPTION(!list_empty(&sb->s_inodes),
 				"VFS: Busy inodes after unmount of %s (%s)",
 				sb->s_id, sb->s_type->name)) {
-- 
2.41.0


