Return-Path: <linux-btrfs+bounces-14102-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0634ABAABC
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 May 2025 16:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7722217E73E
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 May 2025 14:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D80202C21;
	Sat, 17 May 2025 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn+QFStc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572091E519
	for <linux-btrfs@vger.kernel.org>; Sat, 17 May 2025 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747492483; cv=none; b=nuUy2OZm9cQ5e3CS5gtYqdgRNoOr+PSQPMMXNfn2wHG2HnxZE6d0iw3GrGmPLJbXZcMYfry/0CSMhErHhGO1i99j2fZuav/cmuJohA/gyvgHwu6z9+rZEV2H91m9qzlxsjY/Xufv0ZrKrrpvfXZFU6XMNFQQoK0t2pSYUf7JRO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747492483; c=relaxed/simple;
	bh=ad3t/I5wO2258ZQxGE9JXBS/Hr/CnWL6rsw3fMPNbfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgu1lbr4ArGj/ddHNUQ2Y+JsfcfKe7mbSSyYbqEYa9p7kPWUcspqPuaeKQ2w/fKsq85Dp+rvVFQbCrrtSiQInZfOqCEUlD1Fc1DQdJO4ogXrLU/PG5wtEYojLvzFGcMlBFNJR8T2B04L0Ra7rs47Osdv+x2HnCay5BOBb+FQkV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gn+QFStc; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-30eccc61f96so28706a91.2
        for <linux-btrfs@vger.kernel.org>; Sat, 17 May 2025 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747492480; x=1748097280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAUX5dYR94RbSH6j9jgLxozC6/Ke28EcbfMiH5D4U0Y=;
        b=gn+QFStcuFG+IVwa7hEJh07o6+vMm3sgaIt4r4kfLLePcPbF5gdZi0jUnTiwwQnX+g
         RhnktupTcWQ40amjrRUukK0ah0hDbxFxWa3tDeb8TJgcEo6q0krM9PynBYXQQOewKCpb
         vBcIzEY/XocYnCQEichdH7CYqh6AJyIAnqlun/Ci/FRVbUt212f19Uw13vwoJw8vLfGw
         70ig6pwNs2GYC9EnmqPjvkZI3bVz8NyalSspJ3hnSd8FJgE0Q5RzQFVkNJhsmCjf5iZW
         ejbVL06JGdK13Az8Tq6H0ENKnMrfm44m/CgeG/MF9TdHohWgc6OCdFOh4ASE6lLr2I1c
         iW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747492480; x=1748097280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAUX5dYR94RbSH6j9jgLxozC6/Ke28EcbfMiH5D4U0Y=;
        b=u5Yc1KmWJv3HIahrjh01jyeOp+mmeTjcoR6JEiV4hkeGkBKgw+7tiNLyivLJ5zErNV
         UowK3bqdJv2Ok79ZB+4qCoCcQToG1O67oUc9Cq/VcgqX1DW9BAK2PvzZkrpKS+zTzdNj
         1OvNlWQcdmVuUznGLu0llYeGsJusnjPkBwm0jty5oAm3vRLI2upvOiB09JbJGOZDIorY
         45QrsTUJKKDwpXsrYd36W/XCLX5flN7Vl9DBjezqpM9b6tSqGOZcteZJ9PNNhBEQE3Sq
         36acpebpKkXyvDJGdYinPCF1V2lfz44s6QXiHwcAnSsQhoP6iIPsPIkqAC7v6UqyP8+h
         Cnpw==
X-Gm-Message-State: AOJu0Yx9K6UWNneymBWUJo02gsdbxvG8rsJrNHQc68ZIkhp1QzOFtQWN
	4Hi3MAn/aeka1Gw5hQhGo/Ia2gQeUqb1zx7OkFxeIazQJOh2zppJe2cV
X-Gm-Gg: ASbGncsuYObg8L6ANrzdUzzk/EpcLZqlvxXw+89FvFbUV5aL+Rl7fKlIXnLbGKTKIzH
	+gdNsSY2GCFNk0rIp6HjhCFlo2KsQYXxGEre1nGiWg+O3yQsaIWN+qhryzQmyT1L3ZWG81zgjsI
	kPyXTGzEdOSMdFXWU7qT5/dOkUBjkBMubRdx6rdRT/LrpDwZ2lcrnqYwQaNJra9x7ThgCjJl3xT
	8yyJV2UxujMQdlfw9u4AH7c9PpFWsuNzlTNMNGGmxXXUzuDv7e+P5kSOE6r9iKinCicM8vNjNaq
	cR6KmrYMEBhNPQskcgKp3p/lDzws0jJ7SK4C6srC0HBtsorwYA==
X-Google-Smtp-Source: AGHT+IGVX7Mp7RBxgGBnTTaHoVUSKplmDegAIx8wWaClO30m/nKPECDNT2rczaBG1PuOWko91mrXtg==
X-Received: by 2002:a17:90b:3905:b0:30a:9935:be98 with SMTP id 98e67ed59e1d1-30e7d5be2femr3795054a91.4.1747492480558;
        Sat, 17 May 2025 07:34:40 -0700 (PDT)
Received: from SaltyKitkat.. ([154.3.35.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e7b4dda42sm3487857a91.35.2025.05.17.07.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 07:34:40 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: sunk67188@gmail.com
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix the comment of btrfs_path fields
Date: Sat, 17 May 2025 22:34:16 +0800
Message-ID: <20250517143435.31536-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This comment is originally added in
commit 925baeddc5b0 ("Btrfs: Start btree concurrency work."), for the
field keep_locks. The field keep_locks had been moved to another line,
while this comment is left in place.

Move the comment to the right place.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 075a06db43a1..00f67079f2ec 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -61,7 +61,6 @@ struct btrfs_path {
 	/* if there is real range locking, this locks field will change */
 	u8 locks[BTRFS_MAX_LEVEL];
 	u8 reada;
-	/* keep some upper locks as we walk down */
 	u8 lowest_level;
 
 	/*
@@ -69,6 +68,7 @@ struct btrfs_path {
 	 * and to force calls to keep space in the nodes
 	 */
 	unsigned int search_for_split:1;
+	/* Keep some upper locks as we walk down */
 	unsigned int keep_locks:1;
 	unsigned int skip_locking:1;
 	unsigned int search_commit_root:1;
-- 
2.49.0


