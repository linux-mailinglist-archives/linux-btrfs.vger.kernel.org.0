Return-Path: <linux-btrfs+bounces-3426-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4178802C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 17:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1AB283E5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 16:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E12517550;
	Tue, 19 Mar 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JRIu7jeD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D05810A0E
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867369; cv=none; b=Sl90WEihEVQmHF1XdFVYort2qy23Y/MzSmzx1T+gZrP/GnbFdPfR2L53gEKnA5PlIk10b7J4KLT3d/TdgGO4BVS2CsKHnU0nnxBZs27Gr6QT6FEAhjjJ+RpZu49QtMhvVojYnriXuabDtfydB4Rw9PvSHCszCmR2DpPzmIADITs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867369; c=relaxed/simple;
	bh=28rqPOzqrzU2xeKeaX/cB7xe1OCGgfzJP9tXmwdNDho=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4aLfkNIyWT/eJ/pNGulCQ1vnO72hG4PBhONgD481uf68edSPUykVnUyxWGlC00tRf9n1vldAavBV3If9hPEX+Jt6G+PanGlqJ5cIojHmxZJahreCHBRUOYOlx70Yd/f6Qj6oI+mFVtMq8HHHtA0/Kr6Murh2UzAxGbl0T82t8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JRIu7jeD; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-690bd329df2so40035226d6.2
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710867367; x=1711472167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nrknpnmmhSsDGdPuq/gQ6JDl7KQ3ZMmkGR/31N88j1s=;
        b=JRIu7jeDlPDSX+a8JeyjgGEO1t6Xo1tr6me6qswNClQ1yVYjVRGy6xAOu4fjDwthq/
         0Q60oK55Ok31DTXQhP6PYrl4l0JiAOUbbxdgEKNQKuE/Sd20t8s2Z4vuV9DfXGUcko2x
         d+Sl1QPyCpO8v0xEZqXB6VlHEm+MvdKANokn0W8z8eZY2UPhRy9gziX8qjDk9IhJAoKB
         +eCnkoXLfDd9BkuuZzAX977tCm7HTOl1enOC+cyCbZZVs1Fca6lwTVmhx3y156L/ryKn
         gzp2AqLfdzCBHXSbyRY9PvSIZyEuuurG/hxNTSvL7i15WEEyLYbayv99Wt0oFWcoJU/G
         Fhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710867367; x=1711472167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrknpnmmhSsDGdPuq/gQ6JDl7KQ3ZMmkGR/31N88j1s=;
        b=bhe3iLYh5MT267ssE58IhCohRs6DmgSgfsOxL6fKvD62SmjSDPptGeXTExtD/CcWkW
         ActGeeoedUw16cPKBd6nUx/kBevAgjbk1EayoKBFQ+hb4hobAHencFRUwiEsKaCF7Orz
         DmGDlioS0xhugZd4mHVES0gIDZBYPv/8DgOPzuB5XCMoLvKktvLk/pxPM24vuwj+paCL
         JFafTeFqBe0HsPxPl3xbJF/PbNpTfp5f2AOkRTgmqDWRAxP9IPkHtwwDbMRWY/ZgCXQN
         gFSqgcL+SAdXU+5DMkvQakinYE02l9gh2jrDhm+S8eC3YapHR5XSGnCGzrbhD6tb/ZZc
         nMSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4bkvduGp2nj95EOp0NMt4mpRfh7kfOw9BZMXKOK6IWazARXsqm57AigL+5meFGEFQZpenIbqkULfvs55nTG2XTh/waaf30/niIys=
X-Gm-Message-State: AOJu0YxLEonVQmumnEdjDSyXtmPg/RAn/QTq7WZX2QOkZF9ZRN/VlWif
	60J7H6ydtnG3mFKkVVnsgKW/K96gDYL+jdpBsr/ss39eoJP8d+cZbF2Q4d38xEs=
X-Google-Smtp-Source: AGHT+IFwH3KOQnVS99ANDSdHHQg7PS9aFQr53dY6vRcG7MYR/xNMzijOJJiHH6OsEwa9qfkSN7N01w==
X-Received: by 2002:ad4:44b2:0:b0:690:4942:dd89 with SMTP id n18-20020ad444b2000000b006904942dd89mr3238946qvt.28.1710867367281;
        Tue, 19 Mar 2024 09:56:07 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 1-20020a05621420a100b006961c9a2ed8sm2552906qvd.47.2024.03.19.09.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:56:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/3] fstests: btrfs/195: skip raid setups not in the profile configs
Date: Tue, 19 Mar 2024 12:55:57 -0400
Message-ID: <c19995ea42066da0eae381b499475c81679c8f0e.1710867187.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710867187.git.josef@toxicpanda.com>
References: <cover.1710867187.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

You can specify a custom BTRFS_PROFILE_CONFIGS to skip certain raid
configurations in the tests, however btrfs/195 doesn't honor this
currently.  Fix this up by getting the profile configs and skipping any
configurations that are not listed in BTRFS_PROFILE_CONFIGS.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/195 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/btrfs/195 b/tests/btrfs/195
index 96cc4134..df8f5ed6 100755
--- a/tests/btrfs/195
+++ b/tests/btrfs/195
@@ -21,6 +21,9 @@ _require_scratch_dev_pool 4
 # Zoned btrfs only supports SINGLE profile
 _require_non_zoned_device "${SCRATCH_DEV}"
 
+# Load up the available configs
+_btrfs_get_profile_configs
+
 declare -a TEST_VECTORS=(
 # $nr_dev_min:$data:$metadata:$data_convert:$metadata_convert
 "4:single:raid1"
@@ -38,6 +41,11 @@ run_testcase() {
 	src_type=${args[1]}
 	dst_type=${args[2]}
 
+	if [[ ! "${_btrfs_profile_configs[@]}" =~ "$dst_type" ]]; then
+		echo "=== Skipping test: $1 ===" >> $seqres.full
+		return
+	fi
+
 	_scratch_dev_pool_get $num_disks
 
 	echo "=== Running test: $1 ===" >> $seqres.full
-- 
2.43.0


