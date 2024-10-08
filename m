Return-Path: <linux-btrfs+bounces-8630-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BE0993BC7
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 02:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840141C21634
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 00:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0466AA94A;
	Tue,  8 Oct 2024 00:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgJdRct4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BFC2F5A
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 00:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728347323; cv=none; b=CBgYRths+bD6mHW0BoRe9v/suHnfHGVShl7gO6L1NG5qBTXbPLtEHH5riKwR8xnHCVUo4p7ANMWD5LRHOzxX7Ea9ZQGZ3rCLRw1QsJLtn+PjhxLG522/Qc2Kjy1nDaP/iXhberh6494wEY4A8ReSTMtf6vCBXJsdMkyRbmu42q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728347323; c=relaxed/simple;
	bh=Al5oyueJRBFmK1AW7h068iDI113Ba8YpdTMEU54baCM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AoGVaLuwXxat4kn1/9EnPVWN4yBn3e2C6RAkAyWIeTFTU9OtGM0yhSvXsc+V0CZ7IdCytSKqzKfiuPty1nTgTuDTha9wmoetmjI8MerTb8DdvvihnD79iWydEtDEfMtVF5mqo6qHza1ibzsSpXCC7edUa4eH/MbFNPIjrlZYOk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgJdRct4; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7163489149eso4447175a12.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2024 17:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728347321; x=1728952121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qZ0c7g9jHoncAQ8JRBs+6BAJQEN+9s2qy0nYUHz8W6w=;
        b=PgJdRct4itWSLTnlxTVIw2cX+QJFhU1s19hMJluwhjhGZpl8/xXylQuPsS3zrUrYrf
         g0E3ob90l92VPw4Erbon+NC1aafUhy6KEdE27f6t5Qqm5qZZmd26jJIs/Yb3T40vMHZx
         6z2UzYmOfIvv0UwAgRVQaKaI5k04yuUIcf5ObJUBsowWPYDsQI4xHRP0i1arLgLVqey3
         n3eoSQIVOtnknxzWxrN6afD51hrTi+5O/123G7AIqDjSH9iKGcX1G93ndzngdRuHk5wl
         Df8I3JMqRAtLOuKAaSFx5N18fT2+xV2szR9xGdYH6pX54x/qjfX6+lWx5rpcgTa7Pdlp
         jj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728347321; x=1728952121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZ0c7g9jHoncAQ8JRBs+6BAJQEN+9s2qy0nYUHz8W6w=;
        b=wSU7wdJmciOM+7kPPBBa6TCCujc1GJTjlwHOtQpHBPZlav5k9i8i+slyTHM4R5xxwT
         34jq3biiWwBPobt7XhDqCuZIIpNPojH2ft+mAatN1jc7BXW8qmw5luqCVEi1gbZzyf4b
         hl2bZRQIUpzwrAkEKpzqz8tjXw1XuP9Ze158l21kfNYMaKMoL+DojYasLLkfwqD+wVrA
         9DRTYosoMCnN8Ia0i+yc79dOlfXTTJDYsL62lGhwWASaC2yz9xmUYVrxQEw8ZznFRvXd
         6bF0hdowXoo5CfNpQQG2mnvhv+ofziN46tuUDqFOfhyxC7iZfEMXiqHS/2Rp5g2L8gD3
         az7A==
X-Gm-Message-State: AOJu0YwWoPqQNMX88TvjlvBZ/UlO3MLNlt6JU1swB8pe7FpEEik45R4s
	+vXLjOuW/rp1oie7WYDi+x1fKXXg1XHrGTcW9FWFfrD58sZIiTF97juTezyz
X-Google-Smtp-Source: AGHT+IGlIod3Qil1l+JDw6NcWY1/0W7RHvspD8dwa/dnMIjEF79QL4mo5U1cVMN6or+nrK8eZE5bQw==
X-Received: by 2002:a17:90b:102:b0:2c9:7611:e15d with SMTP id 98e67ed59e1d1-2e1e629fa8cmr17803501a91.20.1728347320677;
        Mon, 07 Oct 2024 17:28:40 -0700 (PDT)
Received: from localhost (fwdproxy-eag-006.fbsv.net. [2a03:2880:3ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0fb8c1sm6103548a91.43.2024.10.07.17.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 17:28:40 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 0/3] btrfs-progs: mkfs free-space-info bug
Date: Mon,  7 Oct 2024 17:27:45 -0700
Message-ID: <cover.1728346056.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mkfs creates a few block-groups to bootstrap the filesystem.
Along with these block-groups some free-space-infos are created. When
the block-group cleanup happens the block-groups are deleted and the
free-space-infos are not. This patch set introduces a fix that deletes
the free-space-infos when the block-groups are deleted.

When implementing a test for my changes I found that there was already
some code in free-space-tree.c that attempts to verify that all
free-space-infos correspond to a block-group. This code only checks if
there exists a block-group that has an objectid >= free-space-info's
objectid. I added an additional check to make sure that the block-group
actually matches the free-space-info's objectid and offset.

Making this change to fsck will cause all filesystems that were created
using mkfs.btrfs to warn that there is some free-space-info that doesn't
correspond to a block-group. I've softened the language and included
instructions on how to fix the issue.

CHANGELOG:
v3:
- Added patch 3/3 to add free-space-info checking in tree-checker.
- Softened the warning in patch 2/3

Leo Martins (3):
  btrfs-progs: delete free space when deleting block group
  btrfs-progs: check free space maps to block group
  btrfs-progs: free-space-info tree-checker

 common/clear-cache.c            | 11 +++++++++--
 kernel-shared/extent-tree.c     | 10 ++++++++++
 kernel-shared/free-space-tree.c |  3 +++
 kernel-shared/tree-checker.c    | 29 +++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 2 deletions(-)

-- 
2.43.5


