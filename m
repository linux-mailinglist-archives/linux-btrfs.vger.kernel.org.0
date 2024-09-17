Return-Path: <linux-btrfs+bounces-8094-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D72F497B4B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 22:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160251C22737
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 20:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AA3189B8C;
	Tue, 17 Sep 2024 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqj9NjS/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677FE185941;
	Tue, 17 Sep 2024 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726605233; cv=none; b=Sd2/AECQuTSvapgCflNzOnWTcozsh+Sic9MRHJdg3XdaN3zPfTPx3L0KQqFHmSWgXo7IaedX5fgrvliisSWIVnGY1NcZhov7jP28cCL/Ma5PhuSP5ugUKhSVgFMhGqOYNB5JdWDodEYK2cgrv9C5NDEUtvs7l0k/yTe9qNklM/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726605233; c=relaxed/simple;
	bh=+t7ySHneuGb20prj892wy2CcLCYqVgGLG5nM7No2EUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jzHTX6vBPnym4oW1d0Pzr/NX5JK05DNxgLkJnPcnJ54pDHrp7jpJxh4ZI+WpSoDc77t8VpPurF5Xo6Mr5WLhoPMfHnPLLGA1cB++dXPMZIUVamedsf0PliFuggU1goOaWDamPdyT9ShnrRneF3FNGtfT+tMQphLhtlMSkYG02Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqj9NjS/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cbaf9bfdbso40529475e9.0;
        Tue, 17 Sep 2024 13:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726605230; x=1727210030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n8v2WHKLVS+7/ajaQEhY20+/p6y8USIr8PhP1zwQM4E=;
        b=dqj9NjS/Exg69bcbwEDffRlD4i85lJV1ApkyBy0HZ4ImzyktHJx45HSGu0vEqSIoyw
         omyqQCtw7pOBP6/fyshlLOHKwgVyHILbsrCdl86JYaW2CBGJbR4Bkr5gMuPQzswRVduw
         CMkDixugpFsq0xOBSFbkSeQF9G/8C3kSLssfUW59U9cgV6ZOTSXBk42KRoGHzXgyJoJt
         CVZ+E88a8iAvjwVMIrht2ShN0W+fu4SMS3v/vZxP3TKyl1syyMSKTIts0GfV36HywLQN
         BXp8Ars11nKTqZ8CwKBOVsam8+sgcL1LSeKHr4zmw/OcwMsv06ojseMWZP0QZkFZjhhH
         HATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726605230; x=1727210030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8v2WHKLVS+7/ajaQEhY20+/p6y8USIr8PhP1zwQM4E=;
        b=Sku6kgnG58GrrCXabxj2y9Uc+/OAmEQpB5N0pz5g6Hk3UQl+//ev1Fa27V6MCu1xXu
         5/RuYf347SUtSbgwJshuVqtezbelypETWIkC4xsHjSHtHfeZRp9jumdBgTxnmIm6bajO
         ItP7GAeQBeRyKuxtvymbprRneTsVyHsVH02to3jnjgdSCVQTkHP4oNZsG4vCajCI5HdA
         q2zsY4hiyca2kxyVISjS4CuwLUJJpiCRC96DOpFD1aFWcoptGU9fTdEEGTMTj4fW2nN5
         fymXD2XF+p/ySOyW/3PV1kxYDHwg3+068iX1rd1NpWI2Zi5G8SwWplbdFd576UAtKaN7
         XTXA==
X-Forwarded-Encrypted: i=1; AJvYcCVjTiICVslpmfHlngXl/tUzJy4RpBYNA5TRgtdUxfFzvug5U4ufGKb2NLvrssfqJ6qwhIu/uaNSrsXGtQ==@vger.kernel.org, AJvYcCWkNhXsizuCL2wPtEvyfPaMn5sD+sELR8i9i5Y+3Q4ECiJDaoDwE4sTgSpDOpKk7McAOPTNiQzIq+bNNN2S@vger.kernel.org
X-Gm-Message-State: AOJu0YyGHv3q1o9wISt+XnFqh+Vl4FL/wbGsryeoWaXjbeB/vkKPSsrc
	DYRX3kDmGch9HcgcKu2QAGPILH1cwriWNaSCKxJTlfYKzdL+Xf5B
X-Google-Smtp-Source: AGHT+IH69j3OzWU6VvRWqEe7p3/6T0tqA1BR7bALXhl9pAAzBUt3C9WdSOHprezOZNWZocHp/lhzcg==
X-Received: by 2002:a05:600c:35ca:b0:42c:bae0:f065 with SMTP id 5b1f17b1804b1-42d9070beaamr109213165e9.5.1726605229309;
        Tue, 17 Sep 2024 13:33:49 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42d9b15c435sm148304545e9.23.2024.09.17.13.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 13:33:48 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] btrfs: Don't block system suspend during fstrim
Date: Tue, 17 Sep 2024 22:33:03 +0200
Message-ID: <20240917203346.9670-1-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v5:
* Make chunk size a define
* Remove superfluous trim_interrupted checks
  after moving them to trim_no_bitmap/trim_bitmaps

Changes since v4:
* Set chunk size to 1G
* Set proper error return codes in case of interruption
* Dropped fstrim_range fixup as pulled in -next

Changes since v3:
* Went back to manual chunk size

Changes since v2:
* Use blk_alloc_discard_bio directly
* Reset ret to ERESTARTSYS

Changes since v1:
* Use bio_discard_limit to calculate chunk size
* Makes use of the split chunks

Original discussion: https://lore.kernel.org/lkml/20240822164908.4957-1-luca.stefani.ge1@gmail.com/
v1: https://lore.kernel.org/lkml/20240902114303.922472-1-luca.stefani.ge1@gmail.com/
v2: https://lore.kernel.org/lkml/20240902205828.943155-1-luca.stefani.ge1@gmail.com/
v3: https://lore.kernel.org/lkml/20240903071625.957275-4-luca.stefani.ge1@gmail.com/
v4: https://lore.kernel.org/lkml/20240916101615.116164-1-luca.stefani.ge1@gmail.com/
v5: https://lore.kernel.org/lkml/20240916125707.127118-1-luca.stefani.ge1@gmail.com/

---

NB: I didn't change btrfs_discard_workfn yet to add error checks
as I don't know what semantics we should have in that case.
The work queue is always re-scheduled and created with WQ_FREEZABLE
so it should be automatically frozen. Shall I simply add some logs?

---

Luca Stefani (2):
  btrfs: Split remaining space to discard in chunks
  btrfs: Don't block system suspend during fstrim

 fs/btrfs/extent-tree.c      | 26 +++++++++++++++++++++-----
 fs/btrfs/free-space-cache.c |  4 ++--
 fs/btrfs/free-space-cache.h |  6 ++++++
 fs/btrfs/volumes.h          |  1 +
 4 files changed, 30 insertions(+), 7 deletions(-)

-- 
2.46.0


