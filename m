Return-Path: <linux-btrfs+bounces-15022-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F25AEB2AA
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87723BD4C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74702989B7;
	Fri, 27 Jun 2025 09:19:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8405B25FA0E
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015967; cv=none; b=CfG83slVz7KdTVKGQVjJ6PiEbKdhi2eNYLAFETnuLlTsQ4v4E6cjV44BwuNYbpc939qxDhP67hkul+9mdlCfJNLQ9h6/gfDAkDV/1xpvkCQdN9+mpyfn6Q6umHTlP307p3zHpJ4mvFCrPgAKl1azetSQ2uY7iDCV0cGugLITRj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015967; c=relaxed/simple;
	bh=4fFmO0+RQdWsZA+ZU5O3Az/fvkKMQPVWEIau22TExng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxJEki4aq8hAKG56W0TEBpn+SqaPmFAmCVXzn8q9yhqKvos8CG9Kngo31/wJM8TSwI2Wqfqp4J5nKzbBXVDJ0g4nDIqx5TrMs7mtIdxYS5rHam9x63dV7FhsNfKgpE3K9gpeZ/zKZv8CkcbhG59uf+meOluNVOK/sSO6TS7jx5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so1497795f8f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 02:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751015964; x=1751620764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Obybzh2aJ6/9Xz1PzWvoo/ploI+LdfgmCZTBcuCZccs=;
        b=nmrYATl3U9HWPAhPEXJ6FsYE4hOMKs3TXOXMq/XEsoSTLm8Bke2IO2r0qLUA+GWaOB
         Iq2V0G0IjV4gIWgTi9ZnfEa8Z35H2XROZL+IdDWz8SS6k9OJcXpHGqAmYRiSlH2YJFvq
         M1qbuROv3PqAl5MBe51tRC0vZxQvcYaWnaSkr++/O85mMRLcqLj/PyFqGofPBncUvZt7
         TY4UPkE8xa997j902cpDDpciLeJd1FG14ZMQVKN7RPBoO8b8bKFHK3pgVTVJHxD69Ais
         WfdY7U69BtRYdzcHJbO74oOz2FQTQ+SiGBzAIOAvGsEWxLjFiwC+xNjAA0w15AwaW5w2
         5wVw==
X-Gm-Message-State: AOJu0YyGy3vQBIMoDAansmVfP4M3JOdPRihRy4bJyPgXvXy+1/Lt4qMS
	Ug5W7nr+ryRH9lflMJ9nmfCXV7D16QAX6XX4uQp3nvdcIrjTLKRlqe5NKGPZYw==
X-Gm-Gg: ASbGncuawVRC3/Fsxy4hSwCjlejOx1ZdQ3jnQZssyk1Nu1fy20o3ajLGo/ZI3ywCFr3
	6HHYDxvPyBs5fRzrvkRMUPFRwbYFInuSiWgHd1B7Y8ewv8ePmFtADnMiGsIg3OXyGdFX6vgGGWr
	0x8nnXFXoqEwMacf+uqjer+8Rs3yoa8weuKFt2cJzGNMM2gysCDIEW5J8jJmlGHWMCQM0AglxuF
	dG/C9UipKdKpA4W3OKzItRGgbBVRAdu1iSvALnvopGQlBsWMhs/IVuj9ptWtQn1Mrhkhp1xp7DR
	YsqsoebMH5Ql2ow8ouYPzfrQ2OQgky74oaKtZH8DI/nI8AJ0dzhgkR+/AFZw7P6SmDMaQfMDG6Y
	DyzzAICrqRNGdusqNW0mCsP1y4WSzzT0g+cKQblkTtPXa7p42
X-Google-Smtp-Source: AGHT+IEL8VnXKLrQ1mTAU7OsYOYB91y49GcAxZD1gCSlGnNgb5jquzIi4v+OUpuepp4ed7lZYQrBHA==
X-Received: by 2002:adf:f6d1:0:b0:3a4:f50a:bd5f with SMTP id ffacd0b85a97d-3a917603848mr1983295f8f.31.1751015963742;
        Fri, 27 Jun 2025 02:19:23 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f719b2005a9e6e27159b0eb3.dip0.t-ipconnect.de. [2003:f6:f719:b200:5a9e:6e27:159b:eb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5966csm2152556f8f.72.2025.06.27.02.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:19:23 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH RFC 1/9] btrfs: zoned: do not select metadata BG as finish target
Date: Fri, 27 Jun 2025 11:19:06 +0200
Message-ID: <20250627091914.100715-2-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627091914.100715-1-jth@kernel.org>
References: <20250627091914.100715-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Naohiro Aota <naohiro.aota@wdc.com>

We call btrfs_zone_finish_one_bg() to zone finish one block group and make
a room to activate another block group. Currently, we can choose a metadata
block group as a target. But, as we reserve an active metadata block group,
we no longer want to select a metadata block group. So, skip it in the
loop.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index bd987c90a05c..0d5d6db72b62 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2651,8 +2651,10 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
 
 		spin_lock(&block_group->lock);
 		if (block_group->reserved || block_group->alloc_offset == 0 ||
-		    (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM) ||
-		    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags)) {
+		    (block_group->flags &
+		     (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM)) ||
+		    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+			     &block_group->runtime_flags)) {
 			spin_unlock(&block_group->lock);
 			continue;
 		}
-- 
2.49.0


