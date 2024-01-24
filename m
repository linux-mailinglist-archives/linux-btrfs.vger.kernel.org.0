Return-Path: <linux-btrfs+bounces-1726-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4D883B014
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1F4B2DC6D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24DE129A67;
	Wed, 24 Jan 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Lr/hgcy+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F021292F3
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116807; cv=none; b=iCt+/SX6IqzJm1zR+OnMfa5cmY8DPJEkpBP1Wamf36wilJPM1YpDVTvxndZLCC2+ySQp8k4bU0ARCq6glnUZICJW4i6UFXpNQYH1yMh5+iNll+yqVdS/xifeNGJ7fDMPjj/rELeES/lx8R9QQTJGN6qAqDxpeXQqRiRaMxrYPkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116807; c=relaxed/simple;
	bh=0RvlsfLOSn3+Tptx/+KHsomQ6m2NCD5RtDAhF7RPT5Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoYaNzw7cONHv2cjXHXjIV/1pcCCBcPD4joXJ3XlBavpe5Nym3zGW/RJ/jKtYAIuLf5z4HAT179qj/ms6VIq6uHQO2zKP1k5KRPFmtYDGaoQfg3GL6QFxhYmnPZlMjmhZij55l5vK9iSgy2GAZf+6wiMAihVK/CstzZ6Hfai3L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Lr/hgcy+; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60032f9e510so18446587b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116804; x=1706721604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZeC1YxJFTfa0zQ5hIQIZHx7xW86/p/Vd7B5Eiqx4Plo=;
        b=Lr/hgcy+DC4aXlu/T9nZjpSE6JUt89d6eUssXax/skFU2+RXTt1VcOiWJCCHq828Fv
         9E4OAaRbhkT1FdMJSOPZGWvD4jcMi+OJhObEFKVcbeoOR4H53GWKdDIQeF5Jhx2MyW42
         9QWtxluRpDhVGkDR5l/L6pvxxgHpFacuIa7cPa/N/4Zww4sK+uHNDKbFE+d5I7Kj6Cw4
         iz6BLrLc6d6SD6GKgRmEceAOaQD8LBbyAQBxkgeXHXJWR5LW5FRbymxcU+SnGGVn3nAt
         WnfDgl6yIfOa+aoe16atxpuBR7V04gD0ZH5+wHAvZUvAo+7y2SWEe6rAiqN07AcPcBZY
         fGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116804; x=1706721604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeC1YxJFTfa0zQ5hIQIZHx7xW86/p/Vd7B5Eiqx4Plo=;
        b=hlJH7Bj7JeFcn3LpBsNmUKb2ZtxAqpThpLaWJ5PNXyM38PfOQGFf8T27sCaY+e2cDt
         qc7Ei05YuvI/TEBK96opQ8K9NK7ZKKx44a/U7dUqIs9anPSoe0EvSYwStihFnrtpc7kp
         +yzUAvdHcSoeTxogVnkFbsjjLkCh0OeEMqFuDYY1xC6RsIg5d5Fa0noI2rxC9F6Yy22G
         wjkwSwpGb9AFtrXl6M05T5dBPRVIqBmQal06bR0TZSLWONWMf5d7yIi1708hZpIVeo8Y
         XenThOUdLWKT4NdkktjDOVvpwxGhNEHorOD5VXib3orXIDcZrovPW8YFVq8ZE6RI5hNv
         lvYw==
X-Gm-Message-State: AOJu0Yw6PWE2u/07ARGVUu+9VGi/TpMG4LGiP01/0GoxynjVmHtuXRhr
	G1tKRdeLu0aYJovjoMf/LsoSK2A7um49MsMh6a/b5MGtKmGu8RvyffsDkDnRVgKONBRdo3puF8q
	m
X-Google-Smtp-Source: AGHT+IFhVfwRbSQggUrFVDbhb45IeV65m2TER7oUFjuR4KmiKEal3XTLbaoJbpEIQKGHGdPfrT9lRw==
X-Received: by 2002:a81:7b09:0:b0:5ff:b29d:4532 with SMTP id w9-20020a817b09000000b005ffb29d4532mr1141928ywc.35.1706116804499;
        Wed, 24 Jan 2024 09:20:04 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d134-20020a0ddb8c000000b005ffd1bf706fsm61261ywe.96.2024.01.24.09.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:20:04 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 44/52] btrfs: don't search back for dir inode item in INO_LOOKUP_USER
Date: Wed, 24 Jan 2024 12:19:06 -0500
Message-ID: <d35eb165e63756db85f8e3630d807a5a8731e2cd.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need to search back to the inode item, the directory inode
number is in key.offset, so simply use that.  If we can't find the
directory we'll get an ENOENT at the iget.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 2740f0359446..f5dc281121d2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1902,7 +1902,7 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 	struct btrfs_root_ref *rref;
 	struct btrfs_root *root = NULL;
 	struct btrfs_path *path;
-	struct btrfs_key key, key2;
+	struct btrfs_key key;
 	struct extent_buffer *leaf;
 	struct inode *temp_inode;
 	char *ptr;
@@ -1956,24 +1956,6 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 			read_extent_buffer(leaf, ptr,
 					(unsigned long)(iref + 1), len);
 
-			/* Check the read+exec permission of this directory */
-			ret = btrfs_previous_item(root, path, dirid,
-						  BTRFS_INODE_ITEM_KEY);
-			if (ret < 0) {
-				goto out_put;
-			} else if (ret > 0) {
-				ret = -ENOENT;
-				goto out_put;
-			}
-
-			leaf = path->nodes[0];
-			slot = path->slots[0];
-			btrfs_item_key_to_cpu(leaf, &key2, slot);
-			if (key2.objectid != dirid) {
-				ret = -ENOENT;
-				goto out_put;
-			}
-
 			/*
 			 * We don't need the path anymore, so release it and
 			 * avoid deadlocks and lockdep warnings in case
@@ -1981,11 +1963,12 @@ static int btrfs_search_path_in_tree_user(struct mnt_idmap *idmap,
 			 * btree and lock the same leaf.
 			 */
 			btrfs_release_path(path);
-			temp_inode = btrfs_iget(sb, key2.objectid, root);
+			temp_inode = btrfs_iget(sb, key.offset, root);
 			if (IS_ERR(temp_inode)) {
 				ret = PTR_ERR(temp_inode);
 				goto out_put;
 			}
+			/* Check the read+exec permission of this directory */
 			ret = inode_permission(idmap, temp_inode,
 					       MAY_READ | MAY_EXEC);
 			iput(temp_inode);
-- 
2.43.0


