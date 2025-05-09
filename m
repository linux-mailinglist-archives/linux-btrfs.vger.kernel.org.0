Return-Path: <linux-btrfs+bounces-13853-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EAFAB10BD
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 12:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46243B2DF2
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 10:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B2B28FA81;
	Fri,  9 May 2025 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmfJ2EOj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F4228ECCB
	for <linux-btrfs@vger.kernel.org>; Fri,  9 May 2025 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786434; cv=none; b=sOH7a0Mxk+rAGo48Qp+in4Z69+n+ibhNuXum8zsH6NOlsqo8OD554Q0fyHwPkT++/bEPfYeOtVrDa0qJgfFAZ9hJ0CvToF4nGmJmX35X9NYnVpmwCHArK63e+IW+1PMwC4FDbIAmE8TMGSM+n2HioN9uGZJ5SpK/uWt9u7HMTPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786434; c=relaxed/simple;
	bh=HbGL7fF8xSfmY1a7Ti1ThV/K02ofpjbfYdCBBD6rSaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qv5ijwqjcCVmqVO70U02l9821H/Nc53uzubbqc4MEuqEyYAd2DgbnlRngR/hRk4L9abah9D0JzG+/D8UP4FfnBIbmMGiGG49Ea57R83r0wxBiClGwbRxBsFHdT7ia8g+3sy3EEMlC1iBKUwh33BKzoQ8+4GgEbd2m93AHIW4lqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmfJ2EOj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22e76850b80so15041555ad.1
        for <linux-btrfs@vger.kernel.org>; Fri, 09 May 2025 03:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746786431; x=1747391231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nzZ/c6Psm9q2OJFI9+Wxfmo9tgqHZzr3ZKibmbiEJ1I=;
        b=BmfJ2EOjDuz7oNturXPEREn4RJdBL6rhlidhKdIdb9B/huz/GRm+o3xOTLyOrgWUNu
         iAk/jHg0DOlBEcJQYR8t9dOKVwDfu9WpXP8twcGLll7125tTxP8lDY+7q+mbDgm9NF6N
         t7O8vx9IuRlKKqa4iQO0pm0RkhkjFo3U4ezIddP9PQZtI8T9O8mdLtAzlieKxlvHMGjg
         po61Br7+Fq+4b6DQU4EFbJtqXoIxTRYDeUwkge2BKTJH9IhTlQgpHTlyQsFuuZS2pYrp
         b+CK9apFkdFlYtuHzB5SBfisY56qt3yp72zolqQ6SB+yVBxuQDbz4fRtqGL7hl78GEaT
         m8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746786431; x=1747391231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzZ/c6Psm9q2OJFI9+Wxfmo9tgqHZzr3ZKibmbiEJ1I=;
        b=ihUaIzRVWAteYwJE7P0+rwUEHmuIc5X1jMF8s2BT6CWs2wlOJoQ1Z13agvwy5ECfUd
         P9jCgOAlxwgt+WLenI1Im7uZXmlASv/wJpH7v4ncijxkCXB+JIcrdBwswmkqJf4uXY36
         YBFyy1a4W6490hDGeWpZWGlbnCVDdFBxyE92oeJ1SB/SIOupDdDB4gsQZQ1wSzpepIgi
         YajD/uf45aTvX9x3Ei2HKQSwaMCLr75dYtG8Ij6DAD46c3mviIvg+45cy45W970Af4bz
         HAGonU6xIt/cviyGuN2KfBEmlSY6jMryidvj0mqZoEEj2gpG0wuutVS8ZxZ4TWhpmWyk
         wfew==
X-Forwarded-Encrypted: i=1; AJvYcCWPkVru7mqGc5SB9xyFrVTPdU6opxQrz58bHk8Qr2iG2RGyhaO06FWmx/J8oBPJ6bMNhxOtEOCMmNllaA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYfWQf29V+8HK80+wHsPXvKBow9o/SMvcU04iDCobpCu6MPsg4
	USRcPXpcjU2P9bGOKulyoH+pHbKxKN+21RaBm56v4h9jYdQKU05b
X-Gm-Gg: ASbGnctyICcfY8gq/U7iwdM/qkTe1OyzkDy68aPIMEKJCplMeWhZO5ysrRc9k51PUlN
	hInWb65OEHRQfgYWArnCDBPCUrBV61hO3NeX9t+O6SCLYMbpwHfXNQwrROz2D+sYlacqOeSjwMF
	sew++j7ucBx3b5tLmIuiO7VRRRQNwWT6nPrz851omfEDCwWSmxbQf03DElVUA2lpu47QLip91bV
	Q3j/wVreDn/1nOauqkbnOnCW2yCW08joe0jkB3WnQpgrJ4r3ez5GBWHc4XykFb5nf0V2OLFxSz1
	uBRektebDN76bk2e67fF93KpKq25d8qMJ3AkMsUKa2OWLPOVQv5zThOaXK75KBfDizdPmPCjOgY
	=
X-Google-Smtp-Source: AGHT+IG3/bl1qh16WQwLuzEz/9UIYEtSHl8YIAq43pjRV3vcLt8s0LXYGCJU3bGzhftLsuQFtybBvQ==
X-Received: by 2002:a17:903:2cb:b0:224:2207:5130 with SMTP id d9443c01a7336-22fc91a72a8mr36599135ad.45.1746786430741;
        Fri, 09 May 2025 03:27:10 -0700 (PDT)
Received: from kogasawara-server.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7544d7bsm14288725ad.34.2025.05.09.03.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 03:27:10 -0700 (PDT)
From: sawara04.o@gmail.com
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	anand.jain@oracle.com,
	johannes.thumshirn@wdc.com,
	brauner@kernel.org
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: Implement warning for commit values exceeding 300
Date: Fri,  9 May 2025 19:26:31 +0900
Message-ID: <20250509102633.188255-1-sawara04.o@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyoji Ogasawara <sawara04.o@gmail.com>

The Btrfs documentation states that if the commit value is greater than 300
a warning should be issued. This commit implements that functionality.
For more details, visit:
https://btrfs.readthedocs.io/en/latest/Administration.html#btrfs-specific-mount-options

Fixes: 6941823cc878 ("btrfs: remove old mount API code")
Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
---
 fs/btrfs/fs.h    | 1 +
 fs/btrfs/super.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index bcca43046064..7baa2ed45198 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -300,6 +300,7 @@ enum {
 #define BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR		0ULL
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
+#define BTRFS_WARNING_COMMIT_INTERVAL	(300)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
 
 struct btrfs_dev_replace {
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7121d8c7a318..23e230052941 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -569,6 +569,10 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_commit_interval:
 		ctx->commit_interval = result.uint_32;
+		if (ctx->commit_interval > BTRFS_WARNING_COMMIT_INTERVAL) {
+			btrfs_warn(NULL, "excessive commit interval %u, use with care",
+				  ctx->commit_interval);
+		}
 		if (ctx->commit_interval == 0)
 			ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
 		break;
-- 
2.49.0


