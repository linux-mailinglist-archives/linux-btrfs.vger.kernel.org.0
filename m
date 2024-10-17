Return-Path: <linux-btrfs+bounces-8982-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304189A1DCA
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 11:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD421F230CD
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 09:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2A51D8E12;
	Thu, 17 Oct 2024 09:04:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22521C683
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2024 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155869; cv=none; b=ez8Z7eYnCyARDAJdQdTc2aX7doNyPLQxFDp2Nu9XdjHYJdsDJOiZI+I7j/qfJ+bIqCU0PHhNoxbFXbKc7WLX0zESL3auhpqczEFsXQPhCgV6r93xvfFbWd3iFo6VxA5pskTC5cF9bCZz9wBYmHJ3wc/Kb0r+MwUQmItThJATomM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155869; c=relaxed/simple;
	bh=NJOmyhCMwCfgTjBDimASAQcflTEmisG8+Srhk0e8L9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VAgFDYz/3XYNsiUP9sU23bEgz/JBUtYwE78/jhb+KbH1l1sfgOmyfxSXwGBALxiMrLsI6vF+HrEpnyUIZfIFOuB8TCZyhwPCVvxK3CoUgBHpxvnoP85jCIoJAo7NhEQXVdKYoryj4Tz/yhuw11sIoNekiUpYTOSS0U3fg81WJUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539983beb19so734900e87.3
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2024 02:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729155864; x=1729760664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhvGp1Ykd0KSpMcemJnI1FixjA1e6qjP3JFUGONO3Tc=;
        b=chn08j4LU0yF8VHPS1QVCCbaswqO11bTnXxAKNjvZaA53Q6ukXZNtuWV6w8c1t2+Kl
         A6C1dS4e2ZReUBB6EQf2+kW9449aWp96QDZsDtAu2QMTo29QqWfgb48y8On2YZgZrkjB
         EThXB+WtI38ytZGoIWSlcxK7OaWkodaKLoPXgBInhj2OspfCwNfbi8JPQME+WN/bx+kM
         NNbxz9iLrbUJyCWdO45jaHiZ1xu+27i0GdGi8et/+8j/pF4biVXx18Q1GyfDZhATrKTK
         ez52QM2cXbpncCfFJCwuh1CxyKI5NW61zjExM6HsUFCqbbklOSwp+cAcI9XVx5W6AFwp
         E1+w==
X-Gm-Message-State: AOJu0Yzm/erOFmwNcYxm0XtvwFSF6pxUGwjbAVdPDfaxNvhccWDUA6RV
	mziZGwSXNDHpVvANA5uHCUtjKxBOg14Ce11HB9Jvyo2g/YCqHQucbIFr3Hoo
X-Google-Smtp-Source: AGHT+IFQjeqrDX09rDqRyP83uZQw8SCITgyH1agd29K4Duxc6WOMVhFNcZruKcnRmjwkk+m8s0B1fw==
X-Received: by 2002:a05:6512:3e1f:b0:539:fa3d:a73 with SMTP id 2adb3069b0e04-539fa3d0be6mr7039794e87.39.1729155863373;
        Thu, 17 Oct 2024 02:04:23 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c37fbesm19700495e9.8.2024.10.17.02.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:04:22 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 0/2] implement truncation for RAID stripe-extents
Date: Thu, 17 Oct 2024 11:04:09 +0200
Message-ID: <20241017090411.25336-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Implement truncation of RAID stripe-tree entries and add selftests for these
two edge cases of deletion to the RAID stripe-tree selftests.

Changes to v3:
- Use btrfs_duplicate_item() (Filipe)
- User key.offset = 0 in btrfs_search_slot() so we can find "front" delete
Link to v3:
https://lore.kernel.org/linux-btrfs/20241009153032.23336-1-jth@kernel.org

Changes to v2:
- Correctly adjust the btree keys and insert new items instead (Filipe)
- Add selftests

Link to v2:
https://lore.kernel.org/linux-btrfs/20240911095206.31060-1-jth@kernel.org

Johannes Thumshirn (2):
  btrfs: implement partial deletion of RAID stripe extents
  btrfs: implement self-tests for partial RAID srtipe-tree delete

 fs/btrfs/ctree.c                        |   1 +
 fs/btrfs/raid-stripe-tree.c             |  78 ++++++++-
 fs/btrfs/tests/raid-stripe-tree-tests.c | 214 ++++++++++++++++++++++++
 3 files changed, 292 insertions(+), 1 deletion(-)

-- 
2.43.0


