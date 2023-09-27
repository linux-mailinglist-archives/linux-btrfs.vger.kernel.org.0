Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA57E7B0B4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 19:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjI0RrO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 13:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjI0RrN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 13:47:13 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD30FEB
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:47:12 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7740c8509c8so699808585a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1695836832; x=1696441632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/vuMoLckYaeutabTNUQ3SzvUz8X85Zc7zWQhmqXj8k=;
        b=gdjyqRB9P82jdOhCbPQOWZlwANwzP4WNgcsEg4al+pWc9eb6KWfsA92754s8oS9IM2
         kdWW8VW7OeXwWcpzSgmoiTD1HahfXyNB0QvnlODhUmGipspiNiGg3EMaiEylmM/Y7ZtT
         mT0Fu7pv3EqDop+s3xSgcABu4+PRJ6gaXIWl792/349YSwrmwxqTk3u1ucA8hZ8tLYaK
         PW9A25CCUhlsbt9Ob7ReUR1GjFPPfaOYqj++AeZ5ikcUzgqzyGnHzsjbYV+065bsPULl
         SdYMChv5bFdZTv2mIXg22gTxQnEm3VY3taV9p3LHk989CTUacS+00g70DRm7dNDZUpjt
         s55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695836832; x=1696441632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/vuMoLckYaeutabTNUQ3SzvUz8X85Zc7zWQhmqXj8k=;
        b=NifjoNMfvGopMlnnklrDlBy5acEWZMp4PNJnF2iG73/e9pEYZlKHQR7OHcxoDP/ybe
         rQe3WyVfp+QvCQp4++bkELmNAnZBCaaEQ4y2w0fQ0pO5mogXgNdVKtgvZLM2FZktFB34
         nCpSOFejCOwMUgNtlGQHoXrGFvB5bVq7c3BZQhXC5AWN5gHe76K781vLhz4j/IK5Glv1
         jAzShjx1GVixTFityzkcxI0VErvqKbD6pBFiQZaAURXNbKyUwOLCiqJC1OS7EJcRBj1I
         pveYwZsRCR/Tgky1iXYzkc/cW3J0GZ85d276LY3lgTxviCid11x+q3iqVy58zK5iD9gp
         fh1Q==
X-Gm-Message-State: AOJu0YxHTyHvih/Nw0PBS3jj3zPsdNNMohTGMIdwgV2K5OM5cxFaNDss
        G/3TF7TPFJKM9QROgtx06k+A11t5G1hcD1PJd/olcw==
X-Google-Smtp-Source: AGHT+IFy8zPIntKD4PPb5uR9p+IikxxXZ/rGi0AqZqSQQKYqcK/7nPC//tB6dC89huVduar7hWHxNQ==
X-Received: by 2002:a05:620a:7f0:b0:774:15ea:55f with SMTP id k16-20020a05620a07f000b0077415ea055fmr2150817qkk.77.1695836831737;
        Wed, 27 Sep 2023 10:47:11 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m14-20020ae9e00e000000b007742ad3047asm3304264qkk.54.2023.09.27.10.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:47:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/3] btrfs: increase ->free_chunk_space in btrfs_grow_device
Date:   Wed, 27 Sep 2023 13:47:00 -0400
Message-ID: <c94cdbf63118d14cfc0f95827cd67d8be1bae068.1695836511.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695836511.git.josef@toxicpanda.com>
References: <cover.1695836511.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My overcommit patch exposed a bug with btrfs/177.  The problem here is
that when we grow the device we're not adding to ->free_chunk_space, so
subsequent allocations can cause ->free_chunk_space to wrap, which
causes problems in can_overcommit because we add this to ->total_bytes,
which causes the counter to wrap and gives us an unexpected ENOSPC.

Fix this by properly updating ->free_chunk_space with the new available
space in btrfs_grow_device.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 907ea775f4e4..1aedd15d1db7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2932,6 +2932,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 	btrfs_set_super_total_bytes(super_copy,
 			round_down(old_total + diff, fs_info->sectorsize));
 	device->fs_devices->total_rw_bytes += diff;
+	atomic64_add(diff, &fs_info->free_chunk_space);
 
 	btrfs_device_set_total_bytes(device, new_size);
 	btrfs_device_set_disk_total_bytes(device, new_size);
-- 
2.41.0

