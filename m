Return-Path: <linux-btrfs+bounces-7822-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAD096C861
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 22:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC17E1C249A2
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 20:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A4B14AD19;
	Wed,  4 Sep 2024 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="QGKgH9cy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A83148310
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2024 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481758; cv=none; b=m3z1NgRFvCv2LyJJWHXj/+dbptTNitVYWY9FOf0JnQS7ajh8ur6I9t34AJslzwzT/Q5reIDKA4bsBlR5eD8gXeSM5wUSKd0SDd0Z4IwUk6lRuiqhQUQdGWISMlHvovoy0SrINXu7PeXKlZBLdpQ7vwu8/Prh9QzKOCAtWLZUoRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481758; c=relaxed/simple;
	bh=2T/bTyebmmWzgd79hiDdf0J2vl5OhNotJm/x2K/voWI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwRBZb0FTpcwFCV1PP+NxxO3D17vy9xTyFobYn2o6ye1CrV6H9FPAoFpA4Gt5+184o3QmGq3B+DHewwh4M4NOjMMV7FoE4FYvgt32pfxM2kM6yOR8nqe5hj1U09bKwp9JQGDepu7GhL7aLNDRLxYB7ISPnki83YZ0PJxyxxRW+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=QGKgH9cy; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4567cdf32d8so225271cf.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2024 13:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481756; x=1726086556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rE3z53SxlgArsKnVp16449O9VmLlGGSseshi4KP5xk8=;
        b=QGKgH9cyqIb53RGflzg5ytpxJ/TdVSrfwsFChKeYhwCmjjeqWZXzJdNlbkFBwgHa4I
         tc9WTa1npQFptdXkziuE2qMmBd3m9KUqhKgCz3kto91ROnBC4aO7qnYJnv+WkzfxAsaz
         BYCf9zxzZ2+QRyGj6JrcG0k51R+A3UWulme+0bPhy+lLU8snL4HqHNppdydDuO0GLNGf
         J+znv50aoz9ecDGP0zeuvQemz5dFIenkv4Jqq7UmdP1vZFR8jTPgGY+n7nmJdw0wsLNj
         VjzzP8+eGpEGhQM29JOJ7FC3HpQf1DThSteMOfTVRTJv7fNj9vXcidEBq6DbkhceDUoN
         8gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481756; x=1726086556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE3z53SxlgArsKnVp16449O9VmLlGGSseshi4KP5xk8=;
        b=bDcHf94gMMzylgWh0ZxvTGDBTUzEero/FMCjvrzkgaLEurPdSYJvRz3FL0xoy3EQ0l
         BqlQi4ylke6Ysd6uiPUKODOdgyVvxpcXO7WPHPGiCbHoiDMBwwHjQ7za4d+AmMJJsTs9
         xGvFrip4ljyLNxLSdrMGUC8Q3tHGCcoI5t9NnvIkU15E6geLMeSgAeYTRjDIHGR9qGkf
         QlG/8lnmsxyW6tH9C+4BCw4eJ3R9nm9r8aYqxRtg4qsm1dWN6lJsRQ0r99pYlyVzW+Jo
         XQf5dxs+jMsNpNuCiA+CCHzePtgwCPPMB0sEpgesnvgI7DNdkPkXJTiHGK0ECNM14XBT
         Kq7g==
X-Forwarded-Encrypted: i=1; AJvYcCUNCd0yoUVCb7VR+fysxCSznFxo4aX4OMWNGIXqGCyzUk0uKuCGkavpWg1JhbSbXgNVVa+u7rutmqltQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8S4ZeIdBMbz0q8N4VWCPGK7m1M6gGL4po0Brv6VTh7icRq5S5
	SAjjCWB2oWb11yK8nwgyEFqJgsoxpcsGtM/sIBGGGI6Hv72QzJdXNglJo5WvmIQ=
X-Google-Smtp-Source: AGHT+IHwW5fXaHWnF6X5TRV/cQ4dUOF+w2NPeKDvoOEkYHuq6qKl8uAhehzsgXTy2K4uj8CzjjebGQ==
X-Received: by 2002:a05:622a:2292:b0:456:7877:1e91 with SMTP id d75a77b69052e-456965f44ebmr193409851cf.27.1725481755768;
        Wed, 04 Sep 2024 13:29:15 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b52ea3sm1489771cf.53.2024.09.04.13.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:15 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 01/18] fanotify: don't skip extra event info if no info_mode is set
Date: Wed,  4 Sep 2024 16:27:51 -0400
Message-ID: <6a659625a0d08fae894cc47352453a6be2579788.1725481503.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725481503.git.josef@toxicpanda.com>
References: <cover.1725481503.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New pre-content events will be path events but they will also carry
additional range information. Remove the optimization to skip checking
whether info structures need to be generated for path events. This
results in no change in generated info structures for existing events.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fanotify/fanotify_user.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9ec313e9f6e1..2e2fba8a9d20 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -160,9 +160,6 @@ static size_t fanotify_event_len(unsigned int info_mode,
 	int fh_len;
 	int dot_len = 0;
 
-	if (!info_mode)
-		return event_len;
-
 	if (fanotify_is_error_event(event->mask))
 		event_len += FANOTIFY_ERROR_INFO_LEN;
 
@@ -740,12 +737,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (fanotify_is_perm_event(event->mask))
 		FANOTIFY_PERM(event)->fd = fd;
 
-	if (info_mode) {
-		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
-						buf, count);
-		if (ret < 0)
-			goto out_close_fd;
-	}
+	ret = copy_info_records_to_user(event, info, info_mode, pidfd,
+					buf, count);
+	if (ret < 0)
+		goto out_close_fd;
 
 	if (f)
 		fd_install(fd, f);
-- 
2.43.0


