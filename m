Return-Path: <linux-btrfs+bounces-2195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B07E784C2D4
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 03:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D210285DE2
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 02:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22B41CD2E;
	Wed,  7 Feb 2024 02:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H9Qjxd85"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661C15E90
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274604; cv=none; b=hoKNMbQDCcn+RvgVlqbCY+SxL+5kpSpYNa2CAqJp6e9xVVIVeDaTTiccZ2DOg1zYfmz3fN8ADG7RYnS6s3rgmmFFMLdhrBm6W9V7bIEujW08OioXkDdLwBGp60jw9zt9fVTGtaXPgSwLW8+qdTXx+i1tRqkKhNwDqbBemjtpsJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274604; c=relaxed/simple;
	bh=SoniW+zNAIdb1gafBhZfLb/IMUzi2tzE4UyM10bhXqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyJ6WmNeBcAgJXY34NjFlU/tfKhw4vgUCMlTIwnkrK8MhZmYocZrZ0TmYMkMo8PpxfS3wm3nli/QxWAwusdRZseM3tk7K1f54Gd+zKCtnxgfoVE9wk4cnS1aFbzs/ZuKv2u3xwAAf5yLSDhplDWvweuH8zHBHUSoEeRGD+7+tOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H9Qjxd85; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707274602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1b0/5n6DZX0hvtAsUIcfz9s2iIhyENWSmHwcck3Q9JY=;
	b=H9Qjxd85SFISs4O7DxN2F4WTFjE0qWh0NIejiavk59SZGeiVmmxFFTn5OZMBNvV8KPNYnF
	BrxbM8TP3Ubi8+6pDJ2ot1FbQGH5Zor5bw5LvC5Nh0DxCthofhrxtostWn7OR3pVCnQdlG
	KdLDgGGuu3rce+eS7uY9WhiQA9g24QA=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v3 7/7] bcachefs: add support for FS_IOC_GETSYSFSNAME
Date: Tue,  6 Feb 2024 21:56:21 -0500
Message-ID: <20240207025624.1019754-8-kent.overstreet@linux.dev>
In-Reply-To: <20240207025624.1019754-1-kent.overstreet@linux.dev>
References: <20240207025624.1019754-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 68e9a89e42bb..b5b38eb91db6 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1947,6 +1947,7 @@ static struct dentry *bch2_mount(struct file_system_type *fs_type,
 	sb->s_time_min		= div_s64(S64_MIN, c->sb.time_units_per_sec) + 1;
 	sb->s_time_max		= div_s64(S64_MAX, c->sb.time_units_per_sec);
 	super_set_uuid(sb, c->sb.user_uuid.b, sizeof(c->sb.user_uuid));
+	super_set_sysfs_name_uuid(sb);
 	c->vfs_sb		= sb;
 	strscpy(sb->s_id, c->name, sizeof(sb->s_id));
 
-- 
2.43.0


