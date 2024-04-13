Return-Path: <linux-btrfs+bounces-4231-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FC78A3FB5
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795F71C211EE
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC64D5C611;
	Sat, 13 Apr 2024 23:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Nlpg6Wxx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27895B694
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052435; cv=none; b=ojwTpTDc3+J40npQnn/S/ujdbNvTafnQ8d0d/Z3Gb1uN47rtr5mBJWXJGOB+qbx8B8aYW7kqb+X9GIpNB8cKHI335RByJYhQLefAi2aBpuTYR2DMxJLrLJVm3ipLpC8MzMrqGGsuHN8MjvOkaIKgdXOMnu2BOhwXLVExS4Oshrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052435; c=relaxed/simple;
	bh=4/H0KfrR8wQ8m8zx7fjJBbBrsoaod5ugfdoev9QDSus=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFs5i4Fn4wQcF7Qfgq+t8mhI6Fdx0MOXOwK8EoK7NZ4eqMBdOqMsYclbCbPTMduBCl1E6eo2gT6zSvQMNfTGfZxHqYcjDKlq08at4RR17hq6PegaQW7U4uGsC3C29yygmxqgfcyzQA5akcz4ngmaSbtRZ96Uxu9QuAecZjA/Uqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Nlpg6Wxx; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43651b7004bso15011901cf.1
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052432; x=1713657232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zL7F7+sUV9ZVrGn2/64W+CFMy+5gyl6rf9lBD11Gf48=;
        b=Nlpg6WxxYzbLtor1mfBsSGaRt53dW7y8f9dn5vngn5gLpfivAfTcMK523jBH2p2PqY
         +t1N1ZZHIliSsYk3+0f3xRsjiSmaC/xoNNX1P9JKj4+ytpbKasd6lvn8HMb0Ox9ofHj1
         yZQGWcbwWaJ4w4oYETzOdstbC80FlqxdF84qg9051MTbXb9qrpuuGpNBxElX3A63ZP8U
         p7Lh0lclOMkVPkz9roQsonO85jzFzvMNdhML09N9NREn2Q7hM9A33HqvVKFG5KDb0iZR
         iFzehXOmmmMPX7RgO+m58PhCYhXHI9FNN9ZQo5t/awGyBLuOJq/I2lrBHh/fGQWEi9wG
         XnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052432; x=1713657232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zL7F7+sUV9ZVrGn2/64W+CFMy+5gyl6rf9lBD11Gf48=;
        b=kV7sBjDE70RZYwpPgQXeOi9NWdL8UQyrF3eq6HtJ84UeX3bOS3sShE0dhK1/hnpSkT
         N4k1bsjU4CRyMAL6o9GRR1plvho5fDD8FM5Ho2bp1+70r4UaN49yoEcoMm2P6agKtgPU
         GasOHdQj+++jvVk9Fxc5uQDnagUPC8Xcc12QEtUlZm9rWGp/8Orw8Jjz6ixpeYr2R0/g
         hI7NOnVPRtD9UpyDMkQtegppjW3sOWk1GI1VYXhtTFmKi8f/aCB+slQU6N/cBjiQTRGn
         al5rXUxkWb6EzDYz3hmm7TtDhRULhutZ5mYMbw1rbM+7FdvXeq+YcY7hf1NpB8flxOQW
         Avjw==
X-Gm-Message-State: AOJu0YyrPdn+Nbgei1rcUdqtsjY+xa+k4HTRzU70qS8plOx0R7W89J0Q
	9ZoiqsYL21AWiOCK6padENFrRD66fq62pQYSw4Fzx9KJqKIUnGRUSBMYIr2pjTyUTkAWvtNqa+A
	k
X-Google-Smtp-Source: AGHT+IH4dNvz9DcFjVAdeBMHHjLPostooEOJFuZq7FaFZ0Zji2xDHJ55xo4WEwz99iI/oHE7a3yg6w==
X-Received: by 2002:a05:622a:54d:b0:436:7f19:78ba with SMTP id m13-20020a05622a054d00b004367f1978bamr8805007qtx.54.1713052432411;
        Sat, 13 Apr 2024 16:53:52 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fp17-20020a05622a509100b004343d021503sm4030707qtb.67.2024.04.13.16.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 18/19] btrfs: remove the btrfs_delayed_ref_node container helpers
Date: Sat, 13 Apr 2024 19:53:28 -0400
Message-ID: <1d1242ed8cf7fb5705b55e5ee6a7a88faa392ef4.1713052088.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713052088.git.josef@toxicpanda.com>
References: <cover.1713052088.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we don't use these helpers anywhere, remove them.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.h | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 0bc80ed8b2c7..84bc990e34fd 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -399,33 +399,6 @@ void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
 				       u64 num_bytes);
 bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
 
-/*
- * helper functions to cast a node into its container
- */
-static inline struct btrfs_delayed_tree_ref *
-btrfs_delayed_node_to_tree_ref(struct btrfs_delayed_ref_node *node)
-{
-	return &node->tree_ref;
-}
-
-static inline struct btrfs_delayed_data_ref *
-btrfs_delayed_node_to_data_ref(struct btrfs_delayed_ref_node *node)
-{
-	return &node->data_ref;
-}
-
-static inline struct btrfs_delayed_ref_node *
-btrfs_delayed_tree_ref_to_node(struct btrfs_delayed_tree_ref *ref)
-{
-	return container_of(ref, struct btrfs_delayed_ref_node, tree_ref);
-}
-
-static inline struct btrfs_delayed_ref_node *
-btrfs_delayed_data_ref_to_node(struct btrfs_delayed_data_ref *ref)
-{
-	return container_of(ref, struct btrfs_delayed_ref_node, data_ref);
-}
-
 static inline u64 btrfs_delayed_ref_owner(struct btrfs_delayed_ref_node *node)
 {
 	if ((node->type == BTRFS_EXTENT_DATA_REF_KEY) ||
-- 
2.43.0


