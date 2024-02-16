Return-Path: <linux-btrfs+bounces-2449-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55D8857A3D
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 11:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F23F28775C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7134128DD5;
	Fri, 16 Feb 2024 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ontfsx2r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1592576B
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079167; cv=none; b=CKRYoU+CkavQ7nHoeiMSPPkYIVVJMtQ3sBny1iOu3dGHg5viX8e9hIUoPEnZjbozcGJzlmGxTj/qfHSBCyuXHKsex4/MWg3fgVmJNS2wMNt+DtN2DB4RMXV4BZRqj2HZc2l83xX3/P+r/Ty5jDCysD7rvuvlbicxwyp4QUxciWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079167; c=relaxed/simple;
	bh=WHZ8aicHcfz1BdeGy1eQGCFjn9bzG9XO5BXtRPyB2Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TzD7t8WB3JesRhAMgQGQpTemGiBTphwv62W4CQYCf3W99ziG84bvoCTv3k2hgVlJF9jvZM0YFY3fRc/MyIXRtYEAJ7WpxgnfugEXLZQ/m2DAE+anzdh4toGaHqpUHwkASc3jhpfejR9XzRpiDRw/lCeaTZ5V3D8ExnJN9ZvANSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ontfsx2r; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d109e7bed2so23737381fa.2
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 02:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708079163; x=1708683963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y45aiho0adrCXEin8SrebLklNXqNIMifPcfGGWVb2sA=;
        b=Ontfsx2rH7l62VaMCRl009wV2oAu/L2wu4NpGgRVRcUs+609njCsqykQzG+gHk4o+X
         gYHOThPF0tdN1rWDdYsEUAAv1u6iRw6GATUTunRj1NV+li7xvqE4DpIItvhZD2R6/G6p
         Qn6ZiNWYTGWmaIdmlL98BbcmMMetOpAP8pi9gc2K3AVybjl0udUyWMFQU3HTtxkZz5kP
         czeFb+cIYbtQpcmnUjfG5RcZYkM0KFn0QZ2VhMmVPg3haWzX5zNVGxtfLBgRplk3pCme
         jqDOH6DYjnO2NT0YocHFCzVmbs5LeMefCNCQVrlmX8n7LRyv7KoS3n0Y1k2JP23WS46m
         Z6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708079163; x=1708683963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y45aiho0adrCXEin8SrebLklNXqNIMifPcfGGWVb2sA=;
        b=romXea9oDfrQRfrNSdIer3BO29ObAvcfVFklJUygVCZAgsG7pZknCI9bIQAgrqM5PO
         OY59WKqoI4wB4B/w5GqBf/pejaFqvWanzbNnr+I2DfUbr79m7iw+Xy6RzMrNo6dQo9us
         nLxIth3b1jXDDfypxVPa9Rm1s029eZHJh0DQU/2llvxE8FiKQF9i7inYpRd2Fs6ahYkO
         BOnui7H67TvyiYi6x9WaIOwv2J0DKOKNBHIXnL4ZOMzxEknlVgArX0LWDLwnMX7eon+i
         oqtwnJYrsDxkyxCCUOmcjiPVTKyYLc5LiV/at5fG8NVCY32eJ/m8LT8Q9bxNX8pA7X0T
         Mcvg==
X-Gm-Message-State: AOJu0YyXAKtJz9HIvR5hFYLBBciuh9Iy+RlyXGAx6uN847/TgTCSUnmr
	tamSXHgQ11FbIRag6BRT25LRog0IXQEZwYdy3RPf8Q3Kj7ni86s2d1RULkMzG6w=
X-Google-Smtp-Source: AGHT+IElFD9WtprpaNo+KJRxX4nOhQK04CKmxOaXBkM3KIdxkPX/38lwbEXWAtsrVjowlHPwBq+5LQ==
X-Received: by 2002:a2e:805a:0:b0:2d0:b29b:2350 with SMTP id p26-20020a2e805a000000b002d0b29b2350mr2992711ljg.1.1708079162905;
        Fri, 16 Feb 2024 02:26:02 -0800 (PST)
Received: from localhost.localdomain ([2406:4440:0:105::28:a])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090aec0e00b002990cc5afe8sm2824414pjy.42.2024.02.16.02.26.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Feb 2024 02:26:02 -0800 (PST)
From: Su Yue <glass.su@suse.com>
X-Google-Original-From: Su Yue <l@damenly.org>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	l@damenly.org,
	Su Yue <glass.su@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2] btrfs/172,206: call _log_writes_cleanup in _cleanup
Date: Fri, 16 Feb 2024 18:25:50 +0800
Message-Id: <20240216102550.46210-1-l@damenly.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Su Yue <glass.su@suse.com>

Because block group tree requires require no-holes feature,
_log_writes_mkfs "-O ^no-holes" fails when "-O block-group-tree" is
given in MKFS_OPTION.
Without explicit _log_writes_cleanup, the two tests fail with
logwrites-test device left. And all next tests will fail due to
SCRATCH DEVICE EBUSY.

Fix it by overriding _cleanup to call _log_writes_cleanup.

Signed-off-by: Su Yue <glass.su@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
changelog:
v2:
    Remove unneeded comments for _cleanup.
    Add rvbs.
---
 tests/btrfs/172 | 5 +++++
 tests/btrfs/206 | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tests/btrfs/172 b/tests/btrfs/172
index f5acc6982cd7..e5e16681ec21 100755
--- a/tests/btrfs/172
+++ b/tests/btrfs/172
@@ -13,6 +13,11 @@
 . ./common/preamble
 _begin_fstest auto quick log replay recoveryloop
 
+_cleanup()
+{
+	_log_writes_cleanup &> /dev/null
+}
+
 # Import common functions.
 . ./common/filter
 . ./common/dmlogwrites
diff --git a/tests/btrfs/206 b/tests/btrfs/206
index f6571649076f..d9ce33b659e7 100755
--- a/tests/btrfs/206
+++ b/tests/btrfs/206
@@ -14,6 +14,11 @@
 . ./common/preamble
 _begin_fstest auto quick log replay recoveryloop punch prealloc
 
+_cleanup()
+{
+	_log_writes_cleanup &> /dev/null
+}
+
 # Import common functions.
 . ./common/filter
 . ./common/dmlogwrites
-- 
2.43.0


