Return-Path: <linux-btrfs+bounces-19642-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A083CB4F98
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 08:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20C183008FBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 07:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7F62C21E8;
	Thu, 11 Dec 2025 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWHkzR9e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21411FECBA
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765437909; cv=none; b=ZSA4K3h5jkSsmqF1/kKjh3YZ8GTAx0YncR7iWNQ0CXLotAA5k1QuP83omp9O2bhsV7WhC2ZklZStvy0k7H+dyIj8qQO0UxduAWrwDSMkRKh6xR+4M6UP1yEoXJ1SFjBsQH64fXoZts5S602EUWprZV8y7KLw0hns96T19+zYVjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765437909; c=relaxed/simple;
	bh=/3V+JZhda9mznwxE/BYDbFPeu0Pj5Fc+r2OGPcoaN0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y2AEmrc2Hz7L7KKczYznGZ+h+sRB/2Kw3E6uRUk7hxhwos2gKBynKRY0bySCNq9XTp4LnAO/ySAmunUyJTDCSC0d6HoH/TnwZs7LDa6L+zWezNAa+Vic4BfmUr+ASdSYTGYr8pg+eZ4CkxDL3B/sGS+EEKRIa1mg5IRXADCWiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWHkzR9e; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-be9ab2335beso9239a12.0
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 23:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765437907; x=1766042707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/HDLu0IlhQKOCd/Q+dHXUw6d/SJ0PWHGGqYky9xUaFM=;
        b=IWHkzR9eD7VPHg7XgIhEk2ythb48JeTQJIGVr/QY/Tq3qU58h35ouhLecNI/0ZO80d
         v3xqyixGj127Cn4snF4KceUrPTRLhvDJ6P7er8xletsjAbHMpIGFtnbt1og5LRjhfXit
         WfdafSI1QUQpC/pBl/4cCKHIN4/dRm5EyFoAZ4+bTuGy3F6j0dwOubghaxBYecp4VxZj
         Wh9fS3f+/qbW/1NlVF/fcwXgx5x42G40OLG7bVuBmFNywxBb5KgtJHu4jyaFTnN3aJbI
         8SfHLTfrByTKzTQkPPw/VDj26gPAdakvq2AIsfrPXfPlYiV+LS//JJN6MDMJMhqRUj8I
         BFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765437907; x=1766042707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HDLu0IlhQKOCd/Q+dHXUw6d/SJ0PWHGGqYky9xUaFM=;
        b=bd8jkyjHXUhqHL3AmW2W+H0/xbteKUYzLKM7NV6uxkcAjYbgGWiRiUJB75ZtqTu6Y4
         7BKDn6J7meS1g+53ieuhONmS25q1F+Ar8LODAGLSpNuQJGpvsriVlQtmxlFa6eVPEjJp
         6WGo7KCGtnn1VkaERF7OX1Ph9p0+p1ogUhe9zPzIe6bYbjVOMrPCk72pJZDY4efFEhA9
         U+qhWu3Grjk+GoR+SOv2k9IimGKBPkV7hYCcQmH8uaLEg+RDX/ao5O6tZ0ZwA7tCSpV0
         +2gojQCDGFWRFWaCyThCMV4slS2574ckpi/FipDunlJBQ1JRmYTIPbTRY1Nc+AVhRo5y
         zoMg==
X-Gm-Message-State: AOJu0YyZpaF7z/oDyYzXHBWij/gJPZEnqB1VDEaw0h8KDdnJOFbGTt5i
	FuZSlRhd89qWCELtXKeIwP9pnbaaTXyqlBjWFjvKiEIgkPM70LjrqaI3PWj5BqunTp+VyA==
X-Gm-Gg: AY/fxX5vaMyZEWFPwgTcmhS5MRsg1gas2PG8vhtPvg835GwP1s8dRirtcSOZqMd+a8B
	tLpyQEejiCHmrXbatU4L8myI3Qr9jI+UlMRUogXohxA5F9xGStYZuKOtY9dCg8FR1ATOMqkVvjp
	jbNhZtb4ueLF9nDNAn3A03qLiUMKMyV2CDlfiHkxW8B7b6bItb8hTWqkPPtVEuKIpWdQ6pELSBN
	saqQ08WYbLIoThtl5tXL43KqqV+6ZUISy6JM3KDVBWpAAAkDoBsIX5cmH0cfYsYSMNbw5g/z1kL
	3dHnGBMXT1LfQdLNBHwvTDMKQ1TS6xi/JFIKgzuBqe5MA9gfx/JgHwtVMJ72StyxhhNEtubknWe
	QxUA6SKgOqu9NrTYZV6FG6QHFKVHDQ78pJ55BR2NXRuOErw5B3nFpCYcf/SiYR+QLhH8KN5f10s
	NLMSsjN/F5tvmhDqlPxyIPKLTq/5W63nw=
X-Google-Smtp-Source: AGHT+IF+0w706pGBv9Giih76ZQNJlVjCpJroMZvFpKvH9lqXRIuLQVB1s3Vf13mRBK37swoYGr8R0A==
X-Received: by 2002:a05:6a00:1145:b0:7b6:ebcb:63fa with SMTP id d2e1a72fcca58-7f4f4b317c7mr1229436b3a.0.1765437906859;
        Wed, 10 Dec 2025 23:25:06 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4ab4984sm1526520b3a.33.2025.12.10.23.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 23:25:06 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org,
	Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 0/4] btrfs: some cleanups for two ctree functions
Date: Thu, 11 Dec 2025 15:22:15 +0800
Message-ID: <20251211072442.15920-2-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first three patches is cleanups for btrfs_search_slot_for_read().
There're only two callers that set @return_any to 1 and both of them
is unnecessary. So @return_any and related logic could be removed.

The last patch is cleanup for btrfs_prev_leaf(). Callers expect a
valid p->slots[0] to read the item's key. So make sure btrfs_prev_leaf()
return a valid p->slots[0] and remove related checks in callers.

No functional changes.

Changelog:
V2:

- Add assertion in btrfs_search_slot_for_read() to prevent misuse
- Remove unnecessary call btrfs_prev_leaf in btrfs_search_slot_for_read()
- Add details about changes in patch 4

Sun YangKai (4):
  btrfs: don't set @return_any for btrfs_search_slot_for_read in
    btrfs_read_qgroup_config
  btrfs: don't set return_any @return_any for btrfs_search_slot_for_read
    in get_last_extent()
  btrfs: cleanup btrfs_search_slot_for_read()
  btrfs: ctree: cleanup btrfs_prev_leaf()

 fs/btrfs/ctree.c           | 143 +++++++------------------------------
 fs/btrfs/ctree.h           |   3 +-
 fs/btrfs/free-space-tree.c |   2 +-
 fs/btrfs/qgroup.c          |  10 +--
 fs/btrfs/send.c            |  22 +++---
 5 files changed, 42 insertions(+), 138 deletions(-)

-- 
2.51.2


