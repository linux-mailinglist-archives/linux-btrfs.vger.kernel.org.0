Return-Path: <linux-btrfs+bounces-1701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCCA83AF91
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C5C287566
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FF086156;
	Wed, 24 Jan 2024 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="EyUVMKIv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C698613E
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116783; cv=none; b=QsS05TWSJt2DO9h0c5LnSDHb4JZ7z8RxF30WPJIK44ZBBFE9n4FCgw02CG2wjBsaPKgks+kBnbi0skI7/seg7Tp3vzTeXxo2i9aI037CqQr6YaoNr7Fa/aJzrka8fSuR9yHXup8CkmG5wsHU587xVmvWCEzOYoVuo7FnuCh5gJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116783; c=relaxed/simple;
	bh=oS1MgH3lRCEp8fVEefp9ekMiukrY2HcvdAkncIOGYfU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iADWCOQqjSLjGwAjqsDn0OHNHM2v7vPCUVmsD9A7YJcGc6le1WFhFEpYNDGmC860eAdXYQvNc+AELENOBfvSpL5ugXXC3RW2L+n7DYhg2/wnfi+Oq9rKJq7vf5C6gQLLOoNFpQXnLroYhV66thHgkpoEQ1rSj51WykbsmCywyKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=EyUVMKIv; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ebca94cf74so56422457b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116780; x=1706721580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHv6I4cDHnW0vlMJvKGhfHAhzUDioGRjA/BiwZZacn8=;
        b=EyUVMKIv+bA416+8QO8K34J6OOkFRCqw2zUrTpVTMFp0k4yRjBYZlR96AErJwIs9bq
         BdRy15P9XR+PKKIM6eu91mB4/KRR6ZVpuuzDmTUmpETRL9Hw/7WJAjQUb0Hjerv76S0L
         TonAx24wKh6BjokN7CQ4g+Xr0bcFRTu1QuMx2MHfksdakm6MI0yUlz2LF117G+DJ+Xif
         X7/m+KTASxpEWHuHQ1MJku3h2zZA1kGcmgmM/BwdfBCMtniD8dOBGdUcxCx7vknU9ow8
         y4lpAQirohp3fXw3+ntDxo73ZwknZlHzpvDNjTVeofudL9DARFk94upHKLiOH0f0Oiqx
         uG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116780; x=1706721580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHv6I4cDHnW0vlMJvKGhfHAhzUDioGRjA/BiwZZacn8=;
        b=JCaqLXRRCeM8z6wiluCMpizSZXXxOI7qb7NDi3eXbqt8PJ1FMe2CLRMXMdBdr/+rV6
         e0/0YdZVTRioWQ91fbxLmVSNkoSTSsSrB/E9oxc/E0fF2NfXr0XXkOnMKos95tNFyw1U
         VVdTa6CB5L33RJ7/2FHy8ZNSqKzoyQF46NKJfXDfJwIPc4xCRlUD5O9V6LDs+xBbbq26
         BFosDpZfP9bbRgvlyIcu2RkIhNVSBWPYB35+mNld2yjoL5jDduTRL2J4CcvcGxg0wylX
         MjBDyUlOGbBtAC+hM7nXDneDcsqgO25af3QvW4phx9m/8ytKEwFyxmNJOaQOP5ExEJ/2
         nC+Q==
X-Gm-Message-State: AOJu0YwIoL5hRb2dNkgXfETvEzf9lYVYuVgcemVoU3h5BeiW5faYgTKc
	uMeFPJd+zFIasyj+zSqSZxSdd+A40FSEVJZpHhTeT6u8JMM22ClfUbt0vCUeyTWNR05btIj0lyY
	L
X-Google-Smtp-Source: AGHT+IErcX6og+2r1vzuPuo+OGpClj7kBE9aYVeYCRTTlgCGlY2iHvIO2evIV2kxmQlPTcqMXmSzeg==
X-Received: by 2002:a0d:f186:0:b0:5fa:82bd:8642 with SMTP id a128-20020a0df186000000b005fa82bd8642mr881366ywf.29.1706116780573;
        Wed, 24 Jan 2024 09:19:40 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id dt5-20020a05690c250500b005ca99793930sm65576ywb.20.2024.01.24.09.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:39 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 19/52] btrfs: select encryption dependencies if FS_ENCRYPTION
Date: Wed, 24 Jan 2024 12:18:41 -0500
Message-ID: <396f5067b2551a9f2de4b439509e1a285985d358.1706116485.git.josef@toxicpanda.com>
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

We need this to make sure the appropriate encryption algorithms are
turned on in our config if we have FS_ENCRYPTION enabled, and
additionally we only support inline encryption with the fallback block
crypto, so we need to make sure we pull in those dependencies.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 4fb925e8c981..5ff716beb997 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -18,6 +18,9 @@ config BTRFS_FS
 	select FS_IOMAP
 	select RAID6_PQ
 	select XOR_BLOCKS
+	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
+	select FS_ENCRYPTION_INLINE_CRYPT if FS_ENCRYPTION
+	select BLK_INLINE_ENCRYPTION_FALLBACK if FS_ENCRYPTION
 	depends on PAGE_SIZE_LESS_THAN_256KB
 
 	help
-- 
2.43.0


