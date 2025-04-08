Return-Path: <linux-btrfs+bounces-12874-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179F8A80F5C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 17:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE1E7BAE83
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D3822687C;
	Tue,  8 Apr 2025 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQUaxuvB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4AC225412
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124990; cv=none; b=i+Pqe8U1HVBqY5taeDnztM8sp8mzIe2HNG4pVhDt5j9fMhNJ1TcN9j4p7pp2LIkJYTMLe6dZjxtoNPfYr71sv1ftnJaggmR2EeNuoWg+dCXk/vNDSjJsZOzVnLH/mWDDH/u1+12Eex53cYEelVZqdCtd/Zj4a1dlpAxaO3vC0YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124990; c=relaxed/simple;
	bh=Wn+KPkJgSwBg6FzvyEc1k1gdOX9wVmUtnmkPlu5E7zo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gEEK25x+TLXUvyyVITj30eDmFPNtc/XABsx+Ghq5GawovRcCN78FPxaM2UqE60axiEjDDdf8FoX1gfx5fWE798HezJfvlJh+hoUL+S+6YALy69Q5ZDi3tv+UB2rYmnyQVNc1BGPqTjr5rohUQ6RmSKrGsgEfIUHbIj1BKsbXQTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQUaxuvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591E1C4CEE5
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744124989;
	bh=Wn+KPkJgSwBg6FzvyEc1k1gdOX9wVmUtnmkPlu5E7zo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZQUaxuvBSrk4EvX+iIiUT0RU7tn/AEm/ImHZzYMhhrKoBJWY0tw/HcEiolNA9r8Eh
	 hOEM/yKe/D0d2lhFYPfCcCAm0oulgF8aw4SX/9P5LnAz4hn5SjlPIFXU5gaVFqcdWV
	 rhA8UpYRuxTIDT8PgOuGFTpAoFoSQA5LDDemoiO72WosGziZjOiuE+Ez5FWdeIXhGI
	 qSfct9UYb3Jplcov6Ag4LoO0P11cc/NnGZ3/VlQ9am2YlQgHBt/6gulp+dtOAEz5f6
	 aHMqvj07g7Hk0IkRFbEkLtaulB1mqMmWSLhQUD0NwYHUVwOJE6kb5IaxWhfOnIZ2JS
	 GKODrInJyNjew==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: tracepoints: remove no longer used tracepoints for eb locking
Date: Tue,  8 Apr 2025 16:09:44 +0100
Message-Id: <32af13afd65de36db7c6a05bf2725a31f47cbddf.1744124799.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744124799.git.fdmanana@suse.com>
References: <cover.1744124799.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There are several tracepoints for extent buffer locks that are not used
anymore:

  * btrfs_tree_read_unlock_blocking
  * btrfs_set_lock_blocking_read
  * btrfs_set_lock_blocking_write
  * btrfs_tree_read_lock_atomic

These stopped being used after we switched extent buffer locks from a
custom implementation to rw semaphores in commit 196d59ab9ccc
("btrfs: switch extent buffer tree lock to rw_semaphore").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 include/trace/events/btrfs.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index c261ccc3edec..848485d16587 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2336,11 +2336,7 @@ DEFINE_EVENT(btrfs_locking_events, name,			\
 
 DEFINE_BTRFS_LOCK_EVENT(btrfs_tree_unlock);
 DEFINE_BTRFS_LOCK_EVENT(btrfs_tree_read_unlock);
-DEFINE_BTRFS_LOCK_EVENT(btrfs_tree_read_unlock_blocking);
-DEFINE_BTRFS_LOCK_EVENT(btrfs_set_lock_blocking_read);
-DEFINE_BTRFS_LOCK_EVENT(btrfs_set_lock_blocking_write);
 DEFINE_BTRFS_LOCK_EVENT(btrfs_try_tree_read_lock);
-DEFINE_BTRFS_LOCK_EVENT(btrfs_tree_read_lock_atomic);
 
 DECLARE_EVENT_CLASS(btrfs__space_info_update,
 
-- 
2.45.2


