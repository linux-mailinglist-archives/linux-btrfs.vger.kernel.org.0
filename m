Return-Path: <linux-btrfs+bounces-1784-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E888683BEC7
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 11:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08BC0B29263
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 10:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BB320DD8;
	Thu, 25 Jan 2024 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUMxC1EA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101D01CFB4
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178396; cv=none; b=BLWGBYvWv45EawshKXNiP/sYnVgLYNIZcfZS3GE5CJlj63YMUutQFhrOqSUcaWWUeG42A+yXCvHR5FL2WgBl8HOMFZ46F0KDccJiyB5Wu6pF+Fgrl5Bo59hpJra8mSrp6xg0hX0ZvtsgA8yY13pW1jkh3DqkKjEVI0INTZmes6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178396; c=relaxed/simple;
	bh=T8rH5YFFPkJlKTSKQlUXj0DLZVCGkkEI5I+ujzzul1A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZi2OJ8YeNUkKSqjE05j3Iko6Nm8QDZUIyqm2Y1mrmPc2OftRisMpB9Gi09M8yZm0EcqdIVEyko6n+0KZMZlPcvmOk/TTiCmjrWnhLB/e82WLBGUNTZVWZeUuPfy34vXqIkgJ6tKA1UQUh2Z2n3ppkYqmFtDc5UtBISOsgO3RVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUMxC1EA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208C9C433F1
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 10:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706178395;
	bh=T8rH5YFFPkJlKTSKQlUXj0DLZVCGkkEI5I+ujzzul1A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oUMxC1EArQmx7HQ7XlJQ4sfbQ5YxovnIMtr+DIKUD4mGdVDpsZHYYRwf+JqPJz06h
	 Bn3q0CYJJzx5vcZqRoLZUB00k51XqVwp8THGflQuRJgTiQc8ZGM0FIhXpNQnJKgiFF
	 297K4i3LMYn1p8l5uszCauMYkPWNjBG6MV4Z02YyD5a2qE+IVtGOHGa3FAZ0y8fT63
	 FQ5jFEZXVikO5DhTJ10gKNWVXWhOhgr5t2wSB5Kxdk8mSo+V86FxqWZICTDRpwYpBp
	 9ld2Aa5Bq1de0A1LWxQvLuNwOtjwuq4ItufgUGTG6zvZQ9YxggA0/apNhOHuXqx2gP
	 RRBlOds1Is9UA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs: document what the spinlock unused_bgs_lock protects
Date: Thu, 25 Jan 2024 10:26:27 +0000
Message-Id: <f92b992c1b9a48db3c6ca87f32d340d48c937943.1706177914.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706177914.git.fdmanana@suse.com>
References: <cover.1706177914.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Add some comments to struct btrfs_fs_info to explicitly document which
members are protected by the spinlock unused_bgs_lock. It is currently
used to protect two linked lists, the reclaim_bgs and unused_bgs lists.

So add an explicit comment on top of each list to mention its protected
by unused_bgs_lock, as well as comment on top of unused_bgs_lock to
mention the lists it protects.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/fs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index f8bb73d6ab68..b231a90e42cf 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -732,10 +732,13 @@ struct btrfs_fs_info {
 
 	/* Reclaim partially filled block groups in the background */
 	struct work_struct reclaim_bgs_work;
+	/* Protected by unused_bgs_lock. */
 	struct list_head reclaim_bgs;
 	int bg_reclaim_threshold;
 
+	/* Protects the lists unused_bgs and reclaim_bgs. */
 	spinlock_t unused_bgs_lock;
+	/* Protected by unused_bgs_lock. */
 	struct list_head unused_bgs;
 	struct mutex unused_bg_unpin_mutex;
 	/* Protect block groups that are going to be deleted */
-- 
2.40.1


