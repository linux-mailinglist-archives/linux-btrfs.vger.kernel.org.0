Return-Path: <linux-btrfs+bounces-1700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 393D683AF90
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F1B1F282A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6267C7F7EA;
	Wed, 24 Jan 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="1mos43+D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD927E79A
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116781; cv=none; b=K/jg/8eTdGGNE+puWl4fUopSLr3tfmgTEvO8dxHLbPt+pn3VgZiadhBb0zuhxNhAwZALpc7i7YxqjKSwMgIHuxjXUbx43oOcFypQ+EkKi1BMMLehbRbnHeIEsHxYqNsB5T+3DKSTC+LwbCDqu3Wup8rgaBrSPXcQrGuGQmX1ufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116781; c=relaxed/simple;
	bh=NZRyzKRzNZ4Jx3CjS7t3Q2bBeJ7+CY5fV75V1z1QV3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSwb2lus8+Tz6FcNNQcfQ7CxoiFu2NbPId/9S32UQorxMKYp/StCAC0HsZsW8Ee+IUYxuUUoaZmMbfihUBZDqiHLF612qYBv/rpwzgA1cOxppv+DZ3m6tHH97EVsxrefIT2ApGnBb49tW63J9mekS20f8lhSNWG/1stATUP1vPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=1mos43+D; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ff7ec8772dso49931947b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116779; x=1706721579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jy9agr8g7LNh5MpRHg1aNLlpzBp6ZezqPeMd1029Udo=;
        b=1mos43+D/RmmSJ5RZ8Jtb9HsHlTz0OlO29uBN9Eic6t/x3H9eG62jICfwNjr8dpEaf
         EGzjQx/kfwDegHkmLn1m6VNtAvmvLrVGno4Nn4Yk3PrBpru26bVvbOBlJrLnxCX2xHuj
         4D14zaaNpozvwTW0mB7txHcPCcmkjm5Pb78Eqis7S+VoWklcZ8H+Og35rcP9XspdBJ8x
         hTDImO0nK72E3oslKdclK/AMHuuJ4gLadJrsrEOt9cKJePCE0RmyAmfMA/P2C2vCCG0M
         M0FN0WXA1SqhAtsl76QOO1/PCOvvq5HEU0O3bHcuoSTuD+kf7kVTUmLCyJhSX1V6hpNM
         sOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116779; x=1706721579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jy9agr8g7LNh5MpRHg1aNLlpzBp6ZezqPeMd1029Udo=;
        b=EuAEoFrEOmk2oYFZbbeA3UYtZrWzQV4ZRhW5DK058jLBV3ES9nsd7zJFdvOvzMHX/m
         nCUXAYZnRS7JVpzYkTFqaizNXJFCuNMlup6ZNPph3TGKwuIPCIRB0JwGL+hePTQc9FYl
         gISeLizBb8cIQMWpRdQb7BiEPMAuBgtQXBhxiKnoDbHHY4gTy2dScayRLc6GtpalcGzM
         mlMdDmix7tge+4dFAEy3DdZ9y9UQhcITRaik3GGziDXOnOKMSI7uQCTvyIsPDva+haod
         G3FaIwaWa99529SxZd74csF7Ihuk1FR16MsQPkxyuz0AhRGfQoSVR93RSzUY0qCHeWOo
         TUVw==
X-Gm-Message-State: AOJu0YxVqUiI+VUYkdbhQN+wvg1aeGjUpuLWzGhHWc9Foq1SYqwA+sny
	ymLtY3JsWVffpGk1mDABEhRUqiJh0LGfJzYoyKDrfVGrjxLZ+P4iOrt0mr/44kjuBoql0yRNjqI
	W
X-Google-Smtp-Source: AGHT+IFLR6VhFXCJZW6u8s6juTThWl/Limr7I+kO1XiEGx9xi6JAT694Cz+poX8K2oP+FtQx/o1VWQ==
X-Received: by 2002:a81:4817:0:b0:5ff:4c01:c622 with SMTP id v23-20020a814817000000b005ff4c01c622mr1129698ywa.87.1706116779122;
        Wed, 24 Jan 2024 09:19:39 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i6-20020a819106000000b005ffb11e67bdsm63881ywg.62.2024.01.24.09.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:38 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v5 18/52] btrfs: gate encryption behind BTRFS_DEBUG
Date: Wed, 24 Jan 2024 12:18:40 -0500
Message-ID: <5134ab713b080f78b90eae46671596f72bbb1815.1706116485.git.josef@toxicpanda.com>
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

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Since this is a disk format change and is currently in development, gate
the fscrypt ioctls for btrfs behind BTRFS_DEBUG.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 07c9e04cd0d8..95e2615bba51 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4595,6 +4595,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_fslabel(fs_info, argp);
 	case FS_IOC_SETFSLABEL:
 		return btrfs_ioctl_set_fslabel(file, argp);
+#ifdef CONFIG_BTRFS_DEBUG
 	case FS_IOC_SET_ENCRYPTION_POLICY: {
 		if (!IS_ENABLED(CONFIG_FS_ENCRYPTION))
 			return -EOPNOTSUPP;
@@ -4623,6 +4624,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return fscrypt_ioctl_get_key_status(file, (void __user *)arg);
 	case FS_IOC_GET_ENCRYPTION_NONCE:
 		return fscrypt_ioctl_get_nonce(file, (void __user *)arg);
+#endif /* CONFIG_BTRFS_DEBUG */
 	case FITRIM:
 		return btrfs_ioctl_fitrim(fs_info, argp);
 	case BTRFS_IOC_SNAP_CREATE:
-- 
2.43.0


