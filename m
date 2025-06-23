Return-Path: <linux-btrfs+bounces-14876-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76021AE4B7C
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 18:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429DE1886BAC
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 16:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8CB29B77B;
	Mon, 23 Jun 2025 16:56:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234BB27780D
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750697803; cv=none; b=Jg5m0+RSRuf2085w89h+xxu9ArcdGjydK/efxsUkQCHvdSpVp0ChmbFC0MTtMiA58zmlHM6Fn++dZPJW4u9LMzSLTO/5oKJHyCmi2lEubycxg/4CymmGvru0lKQdCr9tDSq2P1Sqf2Xwx+Hc7mZboOT98uWmo7MlEpdXVlsknEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750697803; c=relaxed/simple;
	bh=sPZ30p+8A4Xou5FgqBK912rPn2Bk+eqNhzJLWqT6HzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XRMnZKpJkGR11Gg4I9qNNWKR/qY2OT75UX8E29/UBB6UHwNdbwYQQnETNrFSjdv55hui5HIz08KRmOfUqhfNnuYVyg8UJutUto6PsIUw52eTqUEmwqd/icT7e+MfYA+vBspOo6ofeCGnEmpNaKNXZSxGhAFrB7mjLnr9XHB0SIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so2861501f8f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 09:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750697800; x=1751302600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDOPAMuW5xRrZJ/+k1AepebDwuljgqJ8BTIqO5YLnpM=;
        b=BeE2J1x7tpkwunguB03Bk+eZuzvd7aPgyIO6wuRrU3IZRkVWAwZ38SlnPFSQcR2nXq
         cZ8qd+ppl3Kine7etBH7qSQtYhLl47RHvRXFQmj+Rh25sZdqSWeDcNBGzHsL/9DRqLAC
         nskaXLPDEDpMI2sTCbFPQzwMLNQEtxfEfn/Q5juLlRUxuclkVflTG/UKizjI8QRUaoOd
         9Youod+anuTrinFhmdhM/5R/Txe+PaA4PFs6RZrsfcGQI7tzUjiNgGm2PlzkzXoLQmYJ
         X43x0pCtQ6I1kd5qmyk9UNpCp6GWGktoR5ag1RPYwOnKdfIhoVSxs4FEpU1yXjoUB8cx
         bcxw==
X-Gm-Message-State: AOJu0YzwDhaflu8et/nMWKxFC8GDAoDAoEQ70DJJPD66hB1AL9rI/ArW
	5J4dRUvfO9Uz9CuiXrDCCsLwkgREdCDJTgak+1th2gmjcaajK3kTdkI+Px23Qzlh
X-Gm-Gg: ASbGncs3cRTZPuerzbw0Hprl9V5wsXAe7uvkBEkMMpTFOYlK3LyItzwFv5DCXZ6OCX+
	7t1xu0YvJWCF7dkqOogsyZs1MvfW0QJIU/l8ZuRI7zBsovoiqptbShZOe+VBq2REZTJpcoU5GJg
	Cp1MHwqlubOi/V9DBSK+vfUUgFAnPFW5FrCQu6s+6rwG4Jx7OdL3d2RwEvbD93zguTFFghL2nAM
	0k7ZXkXocMiMoLvY7ksYVftWCZviM+dt4klhSkFcMRqSGKvufqrQtZKxFHVvvbYWUSKx1dKMOWE
	LdUWYbeqmjrlPE1Mnbhb7P+sl9UcNqEKLwlHB9OfTMnCJ0kcpR/ecAMIoVumNkKvJXTu51gjKfu
	MDjcRwtw9R5ualeXVaAnA2oU2+K+qO+h9UCWYFUoUiyx1ZSKcgrpPJmmm/YSA
X-Google-Smtp-Source: AGHT+IEEZvZPjqa2LHgLxEIXygg2vKkizFED02txoKfjR4LQOJiVZTJegpuuMEORR08sU8uOT51NPA==
X-Received: by 2002:a05:6000:2287:b0:3a4:ebfc:8c7 with SMTP id ffacd0b85a97d-3a6e71cb99emr256418f8f.8.1750697800182;
        Mon, 23 Jun 2025 09:56:40 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d118a1f2sm9713888f8f.83.2025.06.23.09.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 09:56:39 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/3] btrfs: zoned: reduce lock contention in zoned extent allocator
Date: Mon, 23 Jun 2025 18:56:26 +0200
Message-ID: <20250623165629.316213-1-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

While investigating performance issues on zoned btrfs, I've analyzed
lockstat output while running fio workloads.

Three locks that have always been on top are the space_info's ->lock, as
well as fs_info's ->treelog_bg_lock and ->relocation_bg_lock.

The first one is not as trivial to get rid and most likely legit in most
cases (see patch #3). The other two are only protecting a single value in
fs_info and can be replaced by REAC_ONCE() and WRITE_ONCE().

The series has been run through fstests on tcmu-runner emulated SMR drives
as well as Damien's fio benchmarks on real ZNS hardware and no regressions
have been observed.

Johannes Thumshirn (3):
  btrfs: zoned: get rid of relocation_bg_lock
  btrfs: zoned: get rid of treelog_bg_lock
  btrfs: zoned: don't hold space_info lock on zoned allocation

 fs/btrfs/disk-io.c     |  2 --
 fs/btrfs/extent-tree.c | 76 ++++++++++++------------------------------
 fs/btrfs/fs.h          |  7 +---
 fs/btrfs/zoned.c       | 13 ++++----
 fs/btrfs/zoned.h       |  7 ++--
 5 files changed, 32 insertions(+), 73 deletions(-)

-- 
2.49.0


