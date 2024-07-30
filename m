Return-Path: <linux-btrfs+bounces-6892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14837941ACE
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 18:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDD01F232F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 16:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A71118B462;
	Tue, 30 Jul 2024 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="aDnPl3kq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221B2189914
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358047; cv=none; b=pnKVcgGJaQ9xQ6rxhSatXt1tdVDM4nEEJ48HmtQNOmAvTZtMOtEYCm8qfk7H2DlZgGfvezjaErC1cmhxMejAYfBFY0/fi4O7+3hmV9JWAbPsWOOPFiATpAWkRpwgWfigXYeI8KxEL78lrt6UvwY3tDMlfC9fRPKkTkBZoofXyNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358047; c=relaxed/simple;
	bh=WuaOSKi/E7lRp+lo23KrCkqVHysWhpDw5hBVzXXvVjA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rq0j2Ouxspsi1M4H1jmVvkul+YDcBJvBc0Md3/puqyTNzvxorOMFzD69w4MG8Gk6E+KZUqTEEiRXK9LVX8WvNKWgOEInkrL9xgAZE9Fv32TDF0Ouzb1vSw6Q2MOjvA41DNr07s27LUmU/qtUC6cGcLH9jhKRFIEruxyMSN98eT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=aDnPl3kq; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-66599ca3470so34217757b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 09:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722358044; x=1722962844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6/bcl7MUrOdNxmIDWSxSn4y0smYyQz6bnmAt/eOYcX0=;
        b=aDnPl3kqLXnpE9r4W7SIm7Tizd7sC786JmcKoKm1YIeabERlSfigLpXFy3WPM11UDo
         nnL9N6aFw1Vkj27Erz25RWtBasrpqIPS4UIVj/3CL+VVana2eLLM+4t6d3Zn75jNW2Qj
         pJj7l2l8EXzIbO7e6cCNw1MRO6u2lA86Vyg+A2uX0BP6kufFHeLBIcn5LHM6vuHA7n+b
         HLU/DwFkqnnScK5B9RZ/X2IR8eT5WLCRTGHOWSe1dJAa6hviixS7RCZdq+DCm7y7VIhm
         simc3VGLZeilrCrAvC4LXWnrZadJWk8nDx/j3wZP2KODYfJmOk5tPI3Y20iLZCpGltAm
         5cKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722358044; x=1722962844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/bcl7MUrOdNxmIDWSxSn4y0smYyQz6bnmAt/eOYcX0=;
        b=wecj+z0EtdCEbJcBEq4X7A1bclOLO8Szjsc1j0XRU87zUBh1OfnBXZmuJDBSqrKLjF
         hvnoX9LTRTKU1QxWKrD/5ZHTLY/dNrJhov8nb8dnql5n19v+jdoCXBkanFpTDQkKaIpI
         pBcsdnJjcb3HWQHG8NOXwA3U8QUhASoTOUWCE1DFwFF2C9QH23v9uikheQ7qUr01H6iZ
         pYWB0T/zR80p6/0B1SUIb0hEyL5zdtceEP6abMWautD7T471+kKrdFk2uyAV3vaT2daG
         QtgSubncoxPJpxZ5lKYI0SEN8YZ+6E2Ut/3eoBqkg/qIOPtvZv/oYIVz1gXwVOYh4K5h
         IBCA==
X-Gm-Message-State: AOJu0Yxl58GECEPusRXHstElWG1FyguW9QYQcqWM1BAvUJvF/q/HMW02
	ARMLaH0gMD3b9M4AygNs3rsQVHXdxa+TkB+04DZ3VX0Zp1tGHjCSN+65qipA/P9AeojNkkKrClT
	t
X-Google-Smtp-Source: AGHT+IHytHv0mI+7jrcGMTU2ZvrgX5s8jDg2FB27cSE+A4Q/kG4gVFctuTuMJUXAADvvNDS8XcxcEw==
X-Received: by 2002:a05:6902:1029:b0:e05:a60e:e896 with SMTP id 3f1490d57ef6-e0b5449b644mr14191354276.4.1722358043836;
        Tue, 30 Jul 2024 09:47:23 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b29f1c269sm2374835276.11.2024.07.30.09.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:47:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2] btrfs: emit a warning about space cache v1 being deprecated
Date: Tue, 30 Jul 2024 12:47:19 -0400
Message-ID: <51e96d7a2754991bc369065d74290e7a436934c7.1722358018.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We've been wanting to get rid of this for a while, add a message to
indicate that this feature is going away and when so we can finally have
a date when we're going to remove it.  The output looks like this

BTRFS warning (device nvme0n1): space cache v1 is being deprecated and will be removed in a future release, please use -o space_cache=v2

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- Made it all one line as per Dave's comment.

 fs/btrfs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 0eda8c21d861..1eed1a42db22 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -682,8 +682,11 @@ bool btrfs_check_options(const struct btrfs_fs_info *info, unsigned long *mount_
 		ret = false;
 
 	if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
-		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE))
+		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE)) {
 			btrfs_info(info, "disk space caching is enabled");
+			btrfs_warn(info,
+"space cache v1 is being deprecated and will be removed in a future release, please use -o space_cache=v2");
+		}
 		if (btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE))
 			btrfs_info(info, "using free-space-tree");
 	}
-- 
2.43.0


