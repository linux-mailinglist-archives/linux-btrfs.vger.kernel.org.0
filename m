Return-Path: <linux-btrfs+bounces-4830-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999B88BFC55
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 13:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE1D1F243F4
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 11:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B067182D9E;
	Wed,  8 May 2024 11:40:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A744E82D66
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168433; cv=none; b=YzcHWciSTIcpyLSut76tyk+x6V6YGN7FJf2dVpY4u7cVIRquifXuDJ/sTELC1SAvWyIGF0wHqidG5D24x80QpJM2m+TkWpI8tnc5xG2h7uTVD8xQapbWCLtmySQJSNRyb3isUKNW5UFZcAwnDw10Wjq4plW3zznCIexuAIItdxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168433; c=relaxed/simple;
	bh=1IUMLCB05ZTp4vFzwOQmCEE5dDb76+9qi0frX+CiJIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uSRdfqgAIaKOoE7VMfWBJ+MrhZ6KZmKitN91pAGnoCVkbNGcszsem6n636G6pt9NSbK8g0FCmZ+eOaxkziW3wHCooFLzpX25p7nKaWGGhU1BWDk/wtkScupeEiXr15ohbt3z5M0yhLnJZM0x3+hxlRNLf0Ig7wJ1oimWNf6y5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a599c55055dso1040742166b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 08 May 2024 04:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168430; x=1715773230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WK3l4//NtenmnTqhgsIOdb3TI0djhLPcYtzuFA4qABw=;
        b=xOpMBwwJUsaYWbz4Lo/Jl7N/bxpJkQ7QuRZA+DuAyz63+/rVNtkXd6gJSB4FJyWRZ0
         2fzyuHoVZAKbUGwuC9hnEgIYaktk4FRNPl8Mv0ppxFlqEORz2j7cfc5w55mcp9sRri33
         +5WYd6o7btiupuqVQ6NVlQmYpiM44oF+hBxGwZ3R2U0gcda3wcSKUUQmx8/H60OmIZ98
         DZZsd3+9kqsTSyEl7WqgF/u+9mkfkwqZLDzcog2UkWyLum/uPheqhnZjF9+liZjfSj/L
         KkfzQ/YLAR9JMwRlN7FsjEiFgdV494xNiNXKimrZJY9JofTyYIx9jGwgKHYkvILwQbes
         amNg==
X-Gm-Message-State: AOJu0YwsffVJK4fz5zjOfMwsyWUlamOhE/uBFBb7HKXQjoxdFojpL6Us
	H1lB7CijoZoRNoCkI/LPmWv5pzb5Dix3FE+3t2jntH9d2LPksJtSQRjDTg==
X-Google-Smtp-Source: AGHT+IGHFK/m0HjGlAvTAPU+ySlWVtsHQzE8Co7qc2knMZrsIYonrKmocWoZvkXHuG/0eOUyYMFOwQ==
X-Received: by 2002:a50:f603:0:b0:572:1625:ae99 with SMTP id 4fb4d7f45d1cf-5731da69870mr1777264a12.31.1715168429747;
        Wed, 08 May 2024 04:40:29 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f718be00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f718:be00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id x2-20020a056402414200b00572cf08369asm6710380eda.23.2024.05.08.04.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:40:29 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@kernel.org>,
	Johannes Thumshirn <jth@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/2] btrfs: pass 'struct btrfs_io_geometry' into handle_ops_on_dev_replace
Date: Wed,  8 May 2024 13:40:16 +0200
Message-Id: <20240508114016.18119-3-jth@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240508114016.18119-1-jth@kernel.org>
References: <20240508114016.18119-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Passing in a 'struct btrfs_io_geometry into handle_ops_on_dev_replace
can reduce the number of arguments by two.

No functional changes otherwise.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5eb41f50ee0c..1d4ee663d021 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6285,20 +6285,19 @@ static bool is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
 	return ret;
 }
 
-static void handle_ops_on_dev_replace(enum btrfs_map_op op,
-				      struct btrfs_io_context *bioc,
+static void handle_ops_on_dev_replace(struct btrfs_io_context *bioc,
 				      struct btrfs_dev_replace *dev_replace,
 				      u64 logical,
-				      int *num_stripes_ret, int *max_errors_ret)
+				      struct btrfs_io_geometry *io_geom)
 {
 	u64 srcdev_devid = dev_replace->srcdev->devid;
 	/*
 	 * At this stage, num_stripes is still the real number of stripes,
 	 * excluding the duplicated stripes.
 	 */
-	int num_stripes = *num_stripes_ret;
+	int num_stripes = io_geom->num_stripes;
+	int max_errors = io_geom->max_errors;
 	int nr_extra_stripes = 0;
-	int max_errors = *max_errors_ret;
 	int i;
 
 	/*
@@ -6339,7 +6338,8 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 	 * replace.
 	 * If we have 2 extra stripes, only choose the one with smaller physical.
 	 */
-	if (op == BTRFS_MAP_GET_READ_MIRRORS && nr_extra_stripes == 2) {
+	if (io_geom->op == BTRFS_MAP_GET_READ_MIRRORS &&
+	    nr_extra_stripes == 2) {
 		struct btrfs_io_stripe *first = &bioc->stripes[num_stripes];
 		struct btrfs_io_stripe *second = &bioc->stripes[num_stripes + 1];
 
@@ -6357,8 +6357,8 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 		}
 	}
 
-	*num_stripes_ret = num_stripes + nr_extra_stripes;
-	*max_errors_ret = max_errors + nr_extra_stripes;
+	io_geom->num_stripes = num_stripes + nr_extra_stripes;
+	io_geom->max_errors = max_errors + nr_extra_stripes;
 	bioc->replace_nr_stripes = nr_extra_stripes;
 }
 
@@ -6797,8 +6797,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    op != BTRFS_MAP_READ)
-		handle_ops_on_dev_replace(op, bioc, dev_replace, logical,
-					  &io_geom.num_stripes, &io_geom.max_errors);
+		handle_ops_on_dev_replace(bioc, dev_replace, logical, &io_geom);
 
 	up_read(&dev_replace->rwsem);
 
-- 
2.35.3


