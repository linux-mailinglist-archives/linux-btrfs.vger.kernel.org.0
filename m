Return-Path: <linux-btrfs+bounces-10088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B749E654B
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 05:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A39169F9D
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 04:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C972D193081;
	Fri,  6 Dec 2024 04:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZrVBQud/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B8C192D80
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 04:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458133; cv=none; b=ISOweRqwyOcvqdNE0O6/hNsBUY4DfLGw9BrzcvY5fnfGiiQgaqb5Ms3aZ6eXNhUE5Y+0cZ2xQvVD6gxqK9idfi6cLD7K5T0mbWUIGbZjCSgCKhPscXIg/ugis+QtVq5CXgInjgr3MJK4WEy2s31+XQygCXn5dpm4lnDlLQqD/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458133; c=relaxed/simple;
	bh=mfEM/DG4PNsmSscMrTtijAKM7ewta8wLDkEBOoOqr1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GSDe9HIQRIgPdHq9xvZRNwbgHTDwhS19cBIJd0s4RB47kR2dMhiUDBpdJUc/ki6STFaheKUWNcEKoqTP/QT9X6PMPeTB9agSHo7OAvb/ydEAMvO6E3/USUz1tWbpRry3F9ZChhAfU3Xihx+ozGZZfvAj+B4DGacD1K6pnfu5t9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZrVBQud/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21564262babso1485175ad.3
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2024 20:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733458131; x=1734062931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pycc29BcH8MRwie8Do3jeg7dOfWDOOE59oanfpjCi0o=;
        b=ZrVBQud/OGxzB/B/f18babgbVCORCrWMXfrTAA5dku3BxdfA3gludd3umcMX2hYrXM
         lObEWPSn0Ejcs1XdC+Z7ou9zrityUFjbTGQC2VSrnFYDaQT/0Pmn3wANh5qoRbsSnxK8
         aDsdIf0SXer1f3UFi0jfj913y5GtdbeDJQbxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458131; x=1734062931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pycc29BcH8MRwie8Do3jeg7dOfWDOOE59oanfpjCi0o=;
        b=oQvz+tUyb2OqN9C0gC7rjbNZ5vDVnrL+vBo+VqjnenRdC5LVC+b1pzirHhRZoqQ2iE
         FEaQhrWU0pPloOGeZfHHkjIJura8yL3zTBRaOG3GmjuZRsrfSZZcuBgx5W8PPuuh6xxn
         U1IrfZy3vZb08JxkPQr4rvL5UnS0YOr/DQZ+Y9K5IHqT+D8IWDBCX5IODMT6vJlGal1q
         lhPAVgWUaExEXSi4ouQ5xZ4YJWxu37FKDovpuwmJUUCu4ud4FoCG97zxibZ1j0zhc+0L
         /Yentfu5q1Hoc2EE6l08A3YBjw3gKLKn/zYrcobPDEtaNlx5lhhrduVM7h3KCEacS52G
         03mg==
X-Forwarded-Encrypted: i=1; AJvYcCXRe2Sz3sxIH/+gnHfNG52RCBDSiII5vIEMGYMyfH9vHVUCVl5UmgLYE8IkTcgOFmkJZGo5h1zP4H219g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZAQ9RcsYXbPwefJYn0j+8KCNoh02Ho94+19ptrxxtnpOz4Hr5
	Azsur3MSKOPplbQioWMbC9PaX8CD409yv2c2syThumTYl9vnUBg8eCXYROADlA==
X-Gm-Gg: ASbGnctMjEyJ16G4BVLS4Sa/EE/f1mK1BK4Pufk9AmQTktMLx428zEgpwUKnriceqLa
	lEQi/QURnB0BNHBX94ST5Lx+/yc2CZk4s0HZULC+RD2O3ZoOrhLfl8N9eNofdq4rf34QuovVRWW
	W91tBqlbP9Ht1vwyfppw/GC9KC0zsOrIQeT21go02FBUsw/RMGEh138GUdBmG55U+Q8Kkc1Xnz6
	ziZGyvzL22Tw60xuUhVmer/ZzdmkWZyPPLhOn41/xp1TidHnVODwOmkG7sIgDkj96y+zHBE2BI+
	sUhfDbeue9rEWFLv8w==
X-Google-Smtp-Source: AGHT+IHxgK0uBuqS9VxoHyUeS6mBM9E7ub6R77truPmNtH3VetfzIrO8WGEyYuJM9Zme/SwKoAuxfA==
X-Received: by 2002:a17:902:c402:b0:215:a3fd:61f9 with SMTP id d9443c01a7336-21614dce2fdmr7340275ad.15.1733458130805;
        Thu, 05 Dec 2024 20:08:50 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f26ff2sm19920525ad.227.2024.12.05.20.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 20:08:50 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10-v6.6] btrfs: don't BUG_ON on ENOMEM from btrfs_lookuip_extent_info() in walk_down_proc()
Date: Fri,  6 Dec 2024 04:08:46 +0000
Message-Id: <20241206040846.4013310-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit a580fb2c3479d993556e1c31b237c9e5be4944a3 ]

We handle errors here properly, ENOMEM isn't fatal, return the error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 fs/btrfs/extent-tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0d97c8ee6..f53c4d52b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5213,7 +5213,6 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 					       eb->start, level, 1,
 					       &wc->refs[level],
 					       &wc->flags[level]);
-		BUG_ON(ret == -ENOMEM);
 		if (ret)
 			return ret;
 		if (unlikely(wc->refs[level] == 0)) {
-- 
2.19.0


