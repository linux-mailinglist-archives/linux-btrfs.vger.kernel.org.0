Return-Path: <linux-btrfs+bounces-7773-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B1969508
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7F1B20CCF
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34159200102;
	Tue,  3 Sep 2024 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpdI4sXd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE5F1DAC6D;
	Tue,  3 Sep 2024 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347800; cv=none; b=PtMzj6t9esqE6XIcKJO1VIybrK5yEPlzwz5ODC/2f7VDnjWiD7v0gFqqC/RFt9kMRvWAXDewhfqor6a9XBV6Svqo5bBJC8oBmxmESZBFcrVukyBsOOkE6eqoMP9B/X9PlhF9fmGqu8fU+RhO2ZOiMzV6eSLpNDtVDCa1uAh2/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347800; c=relaxed/simple;
	bh=z6swSKawmGz2L/6jgeX/qoxljO1o27J0so2VByGdohU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSc2MIP2pTi7xEpK1m5ZirwIjv1UAn5bXBvxlmTZzVL73GNuOIKQxVMfxzqrPONSVjEzcoBxHlZggGWAaz1OIt0kQS+Yqq4XmgQJ7z2Kf6ufHLL3FboTqAyDmG6d4DAGZ/vXyC0Ufl0/8zwxmR8rDNBYAMDiYpLwCSmGKZ7j7Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpdI4sXd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42c7bc97423so27649435e9.0;
        Tue, 03 Sep 2024 00:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725347797; x=1725952597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lVwnFtHEZUL5wZWXdIC/LBjVNCrM9Gtz30ORTTH883M=;
        b=RpdI4sXdnCTyvxtch3pUSVLqwhTbvuBLtfAqE2AMeS29nv4JKucymL6ifW88JfJrDt
         foV3eraj95EXrjRSW5a5cm75/7cIzCx+hrmn6YHrJXs9hb+V8NiHVF1MTS4ohgH1OITp
         Jw2dGo7CGvFnlQmHwviXmSUWJVK2JNFmWOJJO0TJnu3HdA2Py1YUe4Gy73HN91Yv1T4I
         aOGwvGSy1Qf9CxRm18zgnrxVIpVtkADHRgMl89Io6f44Ca/MOca1wEd6YWtfPv40ScZJ
         X5jPJNLSIfztIH6qbuGQnbmIMJk7zwr54gEMcnnhI0TC6k3N9DgZXQkEI/YoD7N3LENV
         LoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725347797; x=1725952597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lVwnFtHEZUL5wZWXdIC/LBjVNCrM9Gtz30ORTTH883M=;
        b=iTcOoI9tILb/EZaH0dS+wqZGlUMpXx9VXBglSqnsjXIoxQqM1aCOwj86JWwjaMoXbW
         /aSTPzhK2hpYyp4tQaRh2bFUrkFvmsNtw+9NwcLs7G1ALU24YpdD/iVBLjkvaCZ7WbRF
         2WHGr3yVHybaByd/DHY/eGpSvFRS+Tsos8OduTskqP2iv9X0UTpGRvqPEpaF5txSDCyI
         DVhKrgBjJqK0MKEid3dLkKWR7iOiSR5PC7eSfzSbBCO7jEFWB73vGxejwj+Fo/MAD6Th
         pCVerGVofVbc3qlbDFYdW1h4N2qfAwI0O7ryboc3rzFNofkCPwzrpWdl77gjieQV8nbk
         Aeyw==
X-Forwarded-Encrypted: i=1; AJvYcCW0KwXc9kleUiTlNCw7QyYj0XZt0LBYy0OVwIj4UhYxVmInppH0GEdqOajzJrDaVdy2+ARBuxRWvvqYJg==@vger.kernel.org, AJvYcCWb28TB28Q9rgRZ/rD+JylaSYZXLr+BlBA/nt/XAEx9+obd1ymIU7oFaJlWTui5hhTy14sGheTfplLOh5Ur@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3OlRaZob0i60r6cTpS7dsq4fwwbaspxwKX2YwNZJDf2aDjTVu
	HZIJIrFeUfTFWbYRD2e02uMKB+vRaZPvUB0ZlUbgY01hphH1t8xJ
X-Google-Smtp-Source: AGHT+IHjhMLrzlwW+TJRN04WNryXYFEJBa861odBpzFctgKCxUP8vr4wpAMdRikqAwL04bT9KECHaQ==
X-Received: by 2002:a05:600c:4f07:b0:428:f0a:3f92 with SMTP id 5b1f17b1804b1-42bb01c1d40mr158473475e9.21.1725347796822;
        Tue, 03 Sep 2024 00:16:36 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42bb85ffbadsm154349815e9.12.2024.09.03.00.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:16:36 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] btrfs: Don't block suspend during fstrim
Date: Tue,  3 Sep 2024 09:16:09 +0200
Message-ID: <20240903071625.957275-1-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2:
* Use blk_alloc_discard_bio directly
* Reset ret to ERESTARTSYS

Changes since v1:
* Use bio_discard_limit to calculate chunk size
* Makes use of the split chunks

v1: https://lore.kernel.org/lkml/20240902114303.922472-1-luca.stefani.ge1@gmail.com/
v2: https://lore.kernel.org/lkml/20240902205828.943155-1-luca.stefani.ge1@gmail.com/
Original discussion: https://lore.kernel.org/lkml/20240822164908.4957-1-luca.stefani.ge1@gmail.com/

Luca Stefani (3):
  btrfs: Always update fstrim_range on failure
  btrfs: Split remaining space to discard in chunks
  btrfs: Don't block system suspend during fstrim

 fs/btrfs/extent-tree.c | 52 +++++++++++++++++++++++++++++++++++-------
 fs/btrfs/ioctl.c       |  4 +---
 2 files changed, 45 insertions(+), 11 deletions(-)

-- 
2.46.0


