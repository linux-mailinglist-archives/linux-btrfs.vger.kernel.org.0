Return-Path: <linux-btrfs+bounces-16267-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AB6B310BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 09:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB75AC5DAC
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 07:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0812E5404;
	Fri, 22 Aug 2025 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="JcM74I65"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F3A28469A
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848739; cv=none; b=RFFrbGHUzUGAN+UaCDbai5+puUox8x1TKwks+GpEe0vgorOkqwnqfXv0CYZy6PGT+D5r5/m5N45EgJU2Tl3m1aRUs4QbRoFG1olFhaM0FYah/np2gB6aSRIDVji0VQHBqKz24shyE+KNBdQGDJne/j8vFbaN8K+UVsykfVpGBGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848739; c=relaxed/simple;
	bh=pOYY8IbzykKlajiaUqPlg+H5I7fYOHJ6et8LTF9TFWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1HAiVhSqSrzzGpv68j2Z7CP3T0+7ZVijB02xrEPiVNUCBiW45m3oJCvw7O7qH6lmLLXFg3TIcZjm1pmIYzUKgG6on5e7h2lWGRLR7HOA9Oa5x9cv0yEotjnD7dmpJGV/mHnLiK2rQglGy1Rkuy3oOVwgkMp8UWfpgotiqWT2P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=JcM74I65; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24639fbdd87so2956235ad.1
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755848736; x=1756453536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQda6eBqVzSr9dgydh5Dkc6Xy9AQWu6zr5QDxwU9nZY=;
        b=JcM74I65aYL72jFTsppLeS89J9u4CON34oJH7Tc48hRjcn047nM0FCbkhUkDKksgT1
         l00sGRGCbjYiNsUcUPZ0rYSebJxJ6sx0Ln55SLa4DfCUXZBR9uk+lpCnauATjqI/0yCv
         VnvJowIW54FjV2OR4uxgsRhg85jzHb2mTGf92wPIoNXQILCTeDzPLLFDAek4OycQklUO
         cu+dnlnJ+ZnfqqXR1SWUBJ2Qt5UR95yLUeiJUkN0FrdD/s+srEhcVEsLh7RG3wtcy5iI
         rWoP4DPWtKwiNb1yMMRm78r6H3w7p1ErppQwnEaZaSqFl3zMhh/cnAlRA9pCX/QRK/Vw
         56Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755848736; x=1756453536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQda6eBqVzSr9dgydh5Dkc6Xy9AQWu6zr5QDxwU9nZY=;
        b=F67gD9MqETgIqKd4qZ37+ngfmdDpyEQF4VIVZ91gq/ipn4Lf7lfby/FhTLBE8jLeGY
         Xe8GKaogq07Yc3GnzpcB+4oQhVDw5vZYb6U6G1s+M9P79FOMe7YyWhVn1u+yuaRfTanl
         4Ss/dxHqJKRRkr+ytkbZiO/dOTYXCbOGQyLx9yxDB2DSWiuhgajCMcYqqgYQkZpBaP2l
         UQDuQ9GCh/o2iSANZVOyCXehdMdU9/cZTYVdhFnM8JCQ4XRGPwDQmYrr5vHKwZDNCWpZ
         2y6jCxvSF5Tlz8zKj1rt7+SRCX/2dLnaN01wRegtGlesD2ZfD5e20E9qDlA5g2zUNO2y
         yD3A==
X-Gm-Message-State: AOJu0YwTuG0b+JQBq+nYNdFo8lzxhGA2bSwkumrWGNlAkmWBetbDEQyT
	7nKwLdZlUcg3mvyFjzjyTQDQqSrdEtAPIsoWOmtVsBVEUjxGlx9awMeolxhMRDFu3RY=
X-Gm-Gg: ASbGncvm7DtptkC8uLJviJEEjUWMXTPeIE3iqOvmngfjCx/jGa+kg1EkuLccdlYYRJ3
	LUsMPm6BvkUKZanGDtuO1t0nGFLGK6zsPCtwFzUrBbX6YcbRC0uN9qv9dvwH1v+az05klG3RZ+7
	aVaKj21YTyp08O4PIibxFHapirA5o15KA9AtNvQjQ0Ux3FmbebAFE1wKXF0onPGZVhHudqtJNyU
	qyHY/BF9u01fDx9ccKULjsdJdMH8Mw27OvHcy/Hg/r/WP2NNPHzfUHcC00bH6KMVCceA4pqdjxo
	eXuhfHat3xB/yEEYsCCxSY0UBrKng/Z0h/AcKw1m0k7dwQHeuYfoRH09WtWUoPm/t68ZnZjzzeM
	uvHdexh9GtDlpBhRl7JX78wGY
X-Google-Smtp-Source: AGHT+IHXHQCF6vOrnsai6HbfSjEV2wNbQ9TB3wyUJIrIpWJasLsSLJwatr/p//AVc6F3BVE5eLBqcA==
X-Received: by 2002:a17:902:f707:b0:240:ac96:e054 with SMTP id d9443c01a7336-246337acf34mr23872025ad.23.1755848735931;
        Fri, 22 Aug 2025 00:45:35 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24646229d6bsm8245885ad.23.2025.08.22.00.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 00:45:35 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Daniel Vacek <neelx@suse.com>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <clm@fb.com>
Subject: [PATCH] btrfs: Accept and ignore compression level for lzo
Date: Fri, 22 Aug 2025 00:45:31 -0700
Message-ID: <a5e0515b8c558f03ba2a9613c736d65f2b36b5fe.1755848139.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compression level is meaningless for lzo, but before commit
3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
it was silently ignored if passed.

After that commit, passing a level with lzo fails to mount:

    BTRFS error: unrecognized compression value lzo:1

Restore the old behavior, in case any users were relying on it.

Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a262b494a89f..7ee35038c7fb 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
 		btrfs_set_opt(ctx->mount_opt, COMPRESS);
 		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-	} else if (btrfs_match_compress_type(string, "lzo", false)) {
+	} else if (btrfs_match_compress_type(string, "lzo", true)) {
 		ctx->compress_type = BTRFS_COMPRESS_LZO;
 		ctx->compress_level = 0;
 		btrfs_set_opt(ctx->mount_opt, COMPRESS);
-- 
2.47.2


