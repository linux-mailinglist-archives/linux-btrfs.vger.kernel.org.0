Return-Path: <linux-btrfs+bounces-14903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 078FFAE60F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 11:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84AC1920059
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 09:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A541327BF93;
	Tue, 24 Jun 2025 09:37:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B68527AC28
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757843; cv=none; b=OiDFK5RW9ZNLVfLVC0BZuA7nXWj9eo8nGS+V2oJBFS87h+3TDnub2LH+mt9z3QXltP4HwzAzRNcDOiolfDmtzEHhGYy5M6r/v13NojAmIRZR54hQAc0eNZ7ZPmDYvvYNTu1eF148vXTorF9/WwERrF5mDEMhmmTXEc2syJDmfvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757843; c=relaxed/simple;
	bh=3B4MusQqLDxi2IFC3fUg8HijRn6Ba5cNTi1KuoI75so=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WswslLCarWwM+2b9SsAJDeAB/qD7MGhEBYBp3agh+eGjM4foC3dv/sUDTZgYkRQYe7Uw8mWL8kxsjL4Qkn/fkAwMnlJ8FHCghnw1sjlTDVllGDP38X5z9zsj4JiRkcL6ZEp7uxATYTbLctF2JT/1Yplp0arm3fD7g5psLXF+fVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4537fdec33bso946305e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 02:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750757840; x=1751362640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMgRhbnYYaMZKKsRz7xYKaYx6O+OLHwqTw2d0dV3EJs=;
        b=whlk7eMTsnXAayy7up0BLy4KSH1XC9nRrvAieDI8jouF2MfxCidDMY6VeX0/Rd8Aes
         PCpqnf5/97izh1snTB2sAxZZlVnexgGFuo34RbVHRKgnOz+WqWWHyuw9gXS/nTM6YaPW
         2Lmuj7i1u2TaucePT0yiGorgltP+lLpT1/GmfjIq0k6al6sHaemrlCyd/LI40M4MuKvd
         4K0eIjxoz0DO1Bz3eqeB7hrXjDZrouRV7Oe2gu8L/8eNhUbMQ1h7mabE41RiCCtgIDSc
         MZGcYC7jgAuvrzVl17MZI9s1b7QMsf/ElOL/aMdStz1HAU96cR/QkQelEDmTx03mfJGL
         iagA==
X-Gm-Message-State: AOJu0YzTP3zdCJehdcCsPlXlPTmbyh5A0WmLDgIDRimVgG6OfoCg0Yfo
	04bV1YmfCGfWVY7yT+u/VJaANA/J35B/d7O7hQpXiFctdbTosIrxpkJ0Km7MLXqx
X-Gm-Gg: ASbGncuC7RxHDDdueO/04T5GmC7fmRZ041sbVJHcyWRS1TQbfiL6yZzGusMMCU1qYff
	usKPLvFBtKVhMaRn0FE2HwZRQv4ol/JMhfZj6Uj/JjqpQCn27xVBpaSoWVcIcbgXMhIUfMFqt1X
	0XuqyOmD9UBxV6khkNWMv5WeLS6IBHzNR4rjW+m0hZj/26Y7n0375vTMuC+6q/D3gLfe5BhwxfL
	WyxxwHOKpnP9TDPLcnPWofW+pv+dFzdowApgfLF+m5+nSQMfrQ6AHiNac6jO3MgXcf5XYEeLExV
	TBYH4b95vfemZhUPSQ+89cGX1rucbxLSKVl4ssbv4fxjE5mt0mwU6+XXQ5WPQaH72HL+yvSlNhD
	d31pg5E/ub+QfQrBxZN19RmZqKKHrNJdN8MU2Cjdl3OE7Lu17jw==
X-Google-Smtp-Source: AGHT+IEjekjssw9TRsYo/68nfWtH1O68WUTUyXJOvCxpzSuOGud2XK7oj2z10KS07Yn0WChZodNqPg==
X-Received: by 2002:a05:600c:1f91:b0:450:c20d:64c3 with SMTP id 5b1f17b1804b1-4537a695f8amr40753015e9.18.1750757839406;
        Tue, 24 Jun 2025 02:37:19 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453769da7f6sm54880745e9.40.2025.06.24.02.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 02:37:18 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/3] btrfs: zoned: reduce lock contention in zoned extent allocator
Date: Tue, 24 Jun 2025 11:37:07 +0200
Message-ID: <20250624093710.18685-1-jth@kernel.org>
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

Changes in v2:
- Rewording of the commit message (Damien)
- No more local variables caching the values (Damien)

Johannes Thumshirn (3):
  btrfs: zoned: get rid of relocation_bg_lock
  btrfs: zoned: get rid of treelog_bg_lock
  btrfs: zoned: don't hold space_info lock on zoned allocation

 fs/btrfs/disk-io.c     |  2 -
 fs/btrfs/extent-tree.c | 86 +++++++++++-------------------------------
 fs/btrfs/fs.h          |  7 +---
 fs/btrfs/zoned.c       | 12 +++---
 fs/btrfs/zoned.h       |  6 +--
 5 files changed, 31 insertions(+), 82 deletions(-)

-- 
2.49.0


