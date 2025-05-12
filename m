Return-Path: <linux-btrfs+bounces-13905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A50CAB4173
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 462A27AF38A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7A6297A7C;
	Mon, 12 May 2025 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZ949Gct"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD00B297A61;
	Mon, 12 May 2025 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073046; cv=none; b=O2L5tpQEReVp8u8wMbpAZZOuUTw+8PNcUuu6RumQ+T9AUevLIJ2JdeIZYuCOcdZm6n5syUfnfliH9hAbjkzCDiTyZzWlDe5SM6eH4PfiAkQOCtPRAMCJjSHQbtkh2PlGGaWDvGzNLgaElms4WPUXd0noYiAyqbobiq/Na55mS+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073046; c=relaxed/simple;
	bh=KfslzzOhSDhXLF+0kIJzc6/p/RNxe9WfOgHTcGyODic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JHue/RBUlLWEeLSQLsJNJn48FC7FBY/4dsv6ieiQULHAWw0psEKkcoTw8g0EDfkjZS8ZU61UteyiDBoZqIXghBBWGhf5MlDtwW/v9lXWn1W3qHAZliZMfkt9DuJv5d7Zm9smKHziXp3IhlmQGIGNQiyGrzxRF+YnS2PbslV42AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZ949Gct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1E9C4CEF2;
	Mon, 12 May 2025 18:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073046;
	bh=KfslzzOhSDhXLF+0kIJzc6/p/RNxe9WfOgHTcGyODic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZ949GctLtBw71dJxp9irDYUd4mH97CzY55RSiedFK3y4TzKces41CXD4F/dtlX39
	 F2yM9lSW8rhsEs2nPsqe7LEfi2IG+K2L2vSHxF2OBRanElzWMkFyCIePXWaYgK2MF2
	 kUFD/gjhQvNVAe3WtkGrki5PjdbcHsZpyCyIYeOVBA4nu+UUZEQnOTRGgrwtMW/oO7
	 OAmuMw0+TObzUqjfWcNcRwRQUAQbb9Tqi2KKF6r3umXu5lS0+2mGGcZDUzp5EPnYET
	 GWWGtt/S8WZpCXmSDgVRIR468M406eh9zJJeaFY0W5HLgxkv16V8mzKA86qjXjz6bF
	 gtyMSODer/6FQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 06/15] btrfs: handle empty eb->folios in num_extent_folios()
Date: Mon, 12 May 2025 14:03:41 -0400
Message-Id: <20250512180352.437356-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180352.437356-1-sashal@kernel.org>
References: <20250512180352.437356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.6
Content-Transfer-Encoding: 8bit

From: Boris Burkov <boris@bur.io>

[ Upstream commit d6fe0c69b3aa5c985380b794bdf8e6e9b1811e60 ]

num_extent_folios() unconditionally calls folio_order() on
eb->folios[0]. If that is NULL this will be a segfault. It is reasonable
for it to return 0 as the number of folios in the eb when the first
entry is NULL, so do that instead.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 6c5328bfabc22..2aefc64cdd295 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -297,6 +297,8 @@ static inline int num_extent_pages(const struct extent_buffer *eb)
  */
 static inline int num_extent_folios(const struct extent_buffer *eb)
 {
+	if (!eb->folios[0])
+		return 0;
 	if (folio_order(eb->folios[0]))
 		return 1;
 	return num_extent_pages(eb);
-- 
2.39.5


