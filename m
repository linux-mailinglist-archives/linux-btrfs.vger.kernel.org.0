Return-Path: <linux-btrfs+bounces-1322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F004B82893B
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 16:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7B7287FD6
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5697A3A1A2;
	Tue,  9 Jan 2024 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJSgErQL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8BF39FF7
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Jan 2024 15:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27C5C433C7
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Jan 2024 15:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704815189;
	bh=xzIVT+RhQcKW6YGvBFtaWk3VfxXICKHlbcY9FoKH0PM=;
	h=From:To:Subject:Date:From;
	b=oJSgErQLImhoRJnETiiZDAKSH/it3CqXJwYbEWXEDYcP79jPb+6HhOGgURPwpBGis
	 PscHGdvRc2SLbrkV1WCo0zc3UPMUJNRNLWG5/mpFsNZbWh88eOfcY//2Q7x7tl8u7t
	 ENWyQtP9j174wi16B1Bet4A2TZPyUohpvkAHtrny7Ev76ZSdVTdAmGdeUBh3R9dZod
	 baOfuDphBIsKzdBqgrZT9f/rVnPVtwfbiCx4dvVt8qTpC/gVvr6TsWNWMgB1/vrM7y
	 vQJERKrGYdGrCjrkmH4UMOubcyhFaTHD1N4zSE2XPTdMu0GHymrIaMfdoDmBan8Smn
	 MkXi55iHaSdoA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove extent_map_tree forward declaration at extent_io.h
Date: Tue,  9 Jan 2024 15:46:25 +0000
Message-Id: <9298fb200ab3faaaf932d0b166fbefd9e0b917ab.1704815143.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to do a forward declaration of struct extent_map_tree at
extent_io.h, as there are no function prototypes, inline functions or data
structures that refer to struct extent_map_tree.

So remove that forward declaration, which is not needed since commit
477a30ba5f8d ("btrfs: Sink extent_tree arguments in
try_release_extent_mapping").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 46050500529b..39f973778db2 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -205,8 +205,6 @@ static inline void extent_changeset_free(struct extent_changeset *changeset)
 	kfree(changeset);
 }
 
-struct extent_map_tree;
-
 int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
-- 
2.40.1


