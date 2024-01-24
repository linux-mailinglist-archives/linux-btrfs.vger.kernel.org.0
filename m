Return-Path: <linux-btrfs+bounces-1683-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2DF83AF81
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B441C22D28
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510D67F7C6;
	Wed, 24 Jan 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ohtvNq7X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9987E781
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116766; cv=none; b=pBE2wg5yz+uGeIbjMLbBkNY61ZX4q4whmL96t587H/nqmxm+mBeYIgnppC7wr9lggFCe4U0i17JXWaS88q5D0huPPuOucKvMqI9ol6Cyl4Xuqluol4FsSYEOq/0BFLkjoR5jPiUS8chUrmYdIE4V9pxAT+z7PndgHOsKXkwt8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116766; c=relaxed/simple;
	bh=ekMpzHwQIrCuGBB2Zq2BvYOSsjtqURynD2EbscpeJ/4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANeE0ZGJYvVAZGAo7LaZSIX5zd+HBhc79mvO+MtMnRXztNjvRIPk58hu3jchJz8Vwy8F6MuWNZ+KURjMqu1pUQh2UgcIwj4hDycgNNvfNOOTBNpD+d2uHpfSIIgaf/b+c82vti06q9OzGeD205CxjZc5xKZ2LAG6NtKQUajRJWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ohtvNq7X; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5f69383e653so56933247b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116764; x=1706721564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dux0do5jDp6Yi0VHeyOod1beQ1gQTM0o+sZNmEB04qE=;
        b=ohtvNq7XOoDxp8APbRVl47ve3p3lnBVwoz2BajAA5lAN1D81heCR/PXEk7zHnIG7Px
         JewKeqpIUgyWveOYHn9pQvXIMEtE1/ALL5ZArjYsGmHNhNrHSm45+cwiJJrJNyNukGmH
         VPR5ajR0Vv2e4Ib498V3iry0r8sbEAWzULLPH7f8l0fiBXeUvLN1sIH96SdyTJ+JFqqE
         phiqNg77iBgg8LNnc4ZvOa+VQZMS69FcZcSP7Wpl73+FcE+wBkgQ3Hp1n82EZ6GclzHK
         13gOqRsbwvtgRie1eGplaPZ5B9+p05KDzdDvEnxHns4eqbmDWNGu8PRA94/MjhuqT6I+
         BWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116764; x=1706721564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dux0do5jDp6Yi0VHeyOod1beQ1gQTM0o+sZNmEB04qE=;
        b=CQGjSn31oA2FIp8cmkvHJV24vP816Z25lxkI/WVsaHyL8UsrTA0itf+1wXJ+FiRIc7
         hnLDNx4uqJrEs1f5X4EgmE8/dS93dn5277pSJLbYg/tz+hUmVva/74ZBZyYXoSt0Ka55
         /QAHM6/Hbq4eJ9JPPeZobqQpoC98ITDfh5N/ZaOKIuGmfTGZuEG+jcwlYQJzBaS7wClA
         8vFsNykxuoduDZErCNA1eeBQfIUgojrg4LJFiSWhMa31HgKWGHRp5doyW/qchgUqk4Ef
         cjTC3TIOs8fgq9c6hg5sUkxDv9UYxqOqOrFsswQG2AUNBQMupsBVbQHs/HR7lOjmQtTA
         QIIw==
X-Gm-Message-State: AOJu0Yys0LXBwlYRpy0+gHx8UtJldBN177fnDkbaPzA1DN8JXEAFT+8h
	pNcv8zDy+BGmGL+bzJJu1VX99PxQKbDNNPCUb7aIlfx/gV29PDGXes2CiTiP1OigjIh5bENnbNu
	5
X-Google-Smtp-Source: AGHT+IGoLzUK5UGIfX9LNbzYVNLRK9w0LFtpbB3+ls8PeiPGF8dj7iMpwSvPEyEjVyl5diiUPJdwfQ==
X-Received: by 2002:a81:c24b:0:b0:602:9eb8:1b20 with SMTP id t11-20020a81c24b000000b006029eb81b20mr1037675ywg.64.1706116763794;
        Wed, 24 Jan 2024 09:19:23 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a72-20020a0dd84b000000b005ffe2119b63sm65034ywe.48.2024.01.24.09.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:23 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 02/52] fscrypt: allow inline encryption for extent based encryption
Date: Wed, 24 Jan 2024 12:18:24 -0500
Message-ID: <ba0289bf103653d5d98ef576756c9a2a66192865.1706116485.git.josef@toxicpanda.com>
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

Instead of requiring -o inlinecrypt to enable inline encryption, allow
having s_cop->has_per_extent_encryption to indicate that this file
system supports inline encryption.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/crypto/inline_crypt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 50294cece233..c64ef93b6157 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -106,8 +106,11 @@ int fscrypt_select_encryption_impl(struct fscrypt_inode_info *ci)
 	if (ci->ci_mode->blk_crypto_mode == BLK_ENCRYPTION_MODE_INVALID)
 		return 0;
 
-	/* The filesystem must be mounted with -o inlinecrypt */
-	if (!(sb->s_flags & SB_INLINECRYPT))
+	/*
+	 * The filesystem must be mounted with -o inlinecrypt or have
+	 * has_per_extent_encryption enabled.
+	 */
+	if (!(sb->s_flags & SB_INLINECRYPT) && !sb->s_cop->has_per_extent_encryption)
 		return 0;
 
 	/*
-- 
2.43.0


