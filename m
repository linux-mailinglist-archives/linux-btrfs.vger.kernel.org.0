Return-Path: <linux-btrfs+bounces-15030-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F7CAEB2B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD27562EA0
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 09:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8A329A32A;
	Fri, 27 Jun 2025 09:19:38 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAD3293C43
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015977; cv=none; b=ahAEeNl+nVpMBV/yvhqDxDSOnMIDzcologWTr4EVyVfiziquF+DWCCzj1ra8VbGO8eWbpICmLTGv6FHkLJvU9C//FDfse7tNAFJIvTcDBkDzoBECDVlGK2k+ItfvOsqLO49ZbG2YmvpxYPwLmBRiGdIjOD55D5Q87upg3xC6elU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015977; c=relaxed/simple;
	bh=CZE0JdUs/ZDFtnqwSOcB4gTqax0/vy48BZEEpzAYZkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzNlNB6xpGlfn/IFHchTacPwsJdb2nN6tTmUzFw716I9W0MovmsyGw/5pKZtAR2yjmWye9/19nRNt2RD50duqERhOhdtD/5kGP5c2HycH5DdzuzbzmloEfzXJ5mMg4MJhesCdJ55OkoPRg3fo4ESzXxHHA8XxKyOix868z7rvS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a5123c1533so1065438f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 02:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751015974; x=1751620774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcGeMiJzlX0cejJJscbrX6MH/3H10V/x+HPDBmVOGmM=;
        b=hnAvoV+Q/qpvyLfeRH1rWSBFNHMxVkegEjmH96/6SeRkoB7TJF+n7iRhdqj/B0Bd21
         5eaSKDFc+bzTVpR6doXVC6gPDs+OdKYoQG5uyxYDAkquafgVHrDhWqEQ0/sWCFtGllNc
         3Q7hhWL4VfJoqhYm0yvghd6nzzWVDSWB4uZE5PCnMELRKjUfch2g9QA4XyI9gH7hc2IF
         Z78UdkQWETkoLAwZH1JtoyzKJNi5NMD6p/sEB9G0o+MWhMWxK+KUTtMgjyTNSemNyxZr
         P+s6on36PShjKLeY5yqcN2BTGCvoJSWESeQJkWnOYRDSODGY0V3J4xw4ibFT9peR7gj6
         H0Jw==
X-Gm-Message-State: AOJu0YyOonVyPXkb4kM8ClPEek/bD6IW1AVIHa9wOUiuoqlUXBhsOpgr
	ffYQdy5Niqr/EfJ365NfCkAHTR4tX6zNvdCugifW1k/hGVGr303VXFtjix6arg==
X-Gm-Gg: ASbGncvcchu0cGWAxzLtYkGJftPCT3susdCRxjR4GVL3z7AwetqxsBnmEKinVjqTNOa
	3FhGtruuPywm/aUGm1OZwLiFqwIiB/R6zmGWi9L+lhPUSs2JW9BmX2SKsJUEcHHj9P/XQu6qAlY
	auPk75HLzo1RwywiorYWlt8/22foMkhuKL8WHl5no9El6iF2vCkgKz4FyxvX/haG4QZaxPqj2/3
	87y3U72+jdJOmpMyVpK3UaQgucoOi64J4BziC1vWSns9nwjAXzb3u0I0pH63f2ybrNqrReccG6t
	xmKgIQzSIYSV5FhTcooqEmnkW/SARJNH5h6WWUokIu8OyaNMIA02k68dx8XJzYTuFVP29K85rOl
	tF5Xh7yYOU4llpbu7zQ9zRHAjyJGH/aXt3csqmhnD6jBEDS1qnYrsmqevZWY=
X-Google-Smtp-Source: AGHT+IEnG8ktbXEfmH14e7ipDL3zMmHMj0TCfvOj2mZGFoz36HdNN7VepbOvKyRws6I34h1P/zmKYw==
X-Received: by 2002:a05:6000:d05:b0:3a4:f024:6717 with SMTP id ffacd0b85a97d-3a8ff9eb581mr2235363f8f.53.1751015974059;
        Fri, 27 Jun 2025 02:19:34 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f719b2005a9e6e27159b0eb3.dip0.t-ipconnect.de. [2003:f6:f719:b200:5a9e:6e27:159b:eb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5966csm2152556f8f.72.2025.06.27.02.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:19:33 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC 9/9] btrfs: remove unused bgs on allocation failure
Date: Fri, 27 Jun 2025 11:19:14 +0200
Message-ID: <20250627091914.100715-10-jth@kernel.org>
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

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

In case find_free_extent() return ENOSPC, check if there are block-groups
in the filsystem which have been marked as 'unused' and if so, reclaim the
space occupied by these block-groups.

Restart the search for free space to place the extent afterwards.

In case the allocation is targeted for the data relocation root, skip this
step, as it can cause deadlocks between block group deletion and relocation.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.h | 11 +++++++++++
 fs/btrfs/extent-tree.c |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index a8bb8429c966..d5c91db88456 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -396,4 +396,15 @@ int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
 				     bool force_wrong_size_class);
 bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg);
 
+static inline bool btrfs_has_unused_block_groups(struct btrfs_fs_info *fs_info)
+{
+	bool unused_bgs;
+
+	spin_lock(&fs_info->unused_bgs_lock);
+	unused_bgs = !list_empty(&fs_info->unused_bgs);
+	spin_unlock(&fs_info->unused_bgs_lock);
+
+	return unused_bgs;
+}
+
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index da731f6d4dad..34d21713c6ab 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4683,6 +4683,11 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	if (!ret && !is_data) {
 		btrfs_dec_block_group_reservations(fs_info, ins->objectid);
 	} else if (ret == -ENOSPC) {
+		if (!btrfs_is_data_reloc_root(root) &&
+		    btrfs_has_unused_block_groups(fs_info)) {
+			btrfs_delete_unused_bgs(fs_info);
+			goto again;
+		}
 		if (!final_tried && ins->offset) {
 			num_bytes = min(num_bytes >> 1, ins->offset);
 			num_bytes = round_down(num_bytes,
-- 
2.49.0


