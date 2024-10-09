Return-Path: <linux-btrfs+bounces-8729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE2F99702A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 17:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB5728509F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 15:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220D1E1A14;
	Wed,  9 Oct 2024 15:30:58 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC527E765
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487858; cv=none; b=ErL2eg1i+4CaG+yRY3sY659LcMyoR5L5Pfi9cVP1fSHRYmmo2RoLei2xhQNBv4ndyOkckVJniCSshCQ7CpgEH7bd2IjhSK0O48AKYN9vYIh8UfKs43X1ODSGFOsYx3whnw7FI6JiqX83g6UBS/CG1pLSbDCOAtCsJUucBZRo+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487858; c=relaxed/simple;
	bh=yZS1gRV9Amfzo4O5lXKsH71lkC2BKtjwmrcqfCJrWYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PH9B7JmfeENPyastoyGVCrf4E5Wc/eGdD05y1BqTnE3pm80B0MK+KIYONwuFhVEuXsJltcnvL9Rs9HrZijg18ToKuL5mYHwDTs4Kk/UwmHkG0Y6J62odEB1fmp6VOweB/tX6K9OHlbOg+wV3MmSN/dWu/IxH1d23kSR7pWokv3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-430558cddbeso6876775e9.1
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 08:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728487855; x=1729092655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9Y0SqlRsRe2rsp2H7MsbwKJH7O9zRM1QhTy82zXMvo=;
        b=DajvWPj1FNkCStZPiL3hF9pEzVXrG4yThX/pupigWChkRrvoqnG0ALTj6UcHMX0OzC
         o+zWyPM30urUGmBa5XCSQke7Ge7lWLYjXBt/P6eZHgB98jtjXlHeWHsRRWZQg2MphtjF
         TgSx/ANm2+VKhUFL0lRXr0KD8nKyL6VM/5d+TPJaARZkiDRiA6MHsALsTACgWTO5MFvX
         upV7NBFcUG+32ECuo8S7FenNntnybsJK44bO31i4OCN+ijiVkj9/PxxLeOncPACLR1iw
         oQPSytW/NBl8VDB17EFicY0VFOBfPjIa5sO4kBfM4c6oiroSLtfK2OaOLSdocS04Irrk
         /MFA==
X-Forwarded-Encrypted: i=1; AJvYcCVqyDGoLTLs2eVSy5hf494XtGgznyH4+7BRvGJ4FoKmWXahZ1ynP+z6jtortKDqY7A9vPLz5Ro3QWuUWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLKuCwJYidww79gcM5/sZgEDq7JVm4tMtoq1K5o+TKk//kn2SN
	NptX5TpKen7pO1oqtKnWyQdxzsK5upal6zg74J+lJbKxTV3N8zdd
X-Google-Smtp-Source: AGHT+IF88kdUP2UkbDTmO8aiUAX4u4cnnTSqErLC75ExGKEEEnS7yOZD8t1VF8dj08CwweRO/DjPDg==
X-Received: by 2002:a05:600c:63d3:b0:426:5e32:4857 with SMTP id 5b1f17b1804b1-43115a2ea01mr531375e9.0.1728487854516;
        Wed, 09 Oct 2024 08:30:54 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f724f700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f724:f700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d371b0731sm3252521f8f.90.2024.10.09.08.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 08:30:53 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 0/2] implement truncation for RAID stripe-extents
Date: Wed,  9 Oct 2024 17:30:30 +0200
Message-ID: <20241009153032.23336-1-jth@kernel.org>
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

Changes to v2:
- Correctly adjust the btree keys and insert new items instead (Filipe)
- Add selftests

Link to v2:
https://lore.kernel.org/linux-btrfs/20240911095206.31060-1-jth@kernel.org

Johannes Thumshirn (2):
  btrfs: implement partial deletion of RAID stripe extents
  btrfs: implement self-tests for partial RAID srtipe-tree delete

 fs/btrfs/raid-stripe-tree.c             |  85 ++++++++-
 fs/btrfs/tests/raid-stripe-tree-tests.c | 223 ++++++++++++++++++++++++
 2 files changed, 304 insertions(+), 4 deletions(-)

-- 
2.43.0


