Return-Path: <linux-btrfs+bounces-12283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA860A61566
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 16:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D543516C2D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 15:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C23B202C34;
	Fri, 14 Mar 2025 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vw4oB1ti"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F002010E3;
	Fri, 14 Mar 2025 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967692; cv=none; b=NNG5CutTJB9pwEt7umjNAH8Ou56bxZPMdyz9wOVPHP2/2ijKI1fOg/jzarEH+YXbvGK8UG29bycBCzgm6XYpjrpDaP/PJ9+NuQ79xTEVwFKuxv0V93M/ZT6ILBNsEqOuZhSYCVv/iQ660fiRqQRoj8TZKNdpOQk5X98McpvfuCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967692; c=relaxed/simple;
	bh=1ATMb0vulPx/wb7OMAj9EUf9MVvm6vgVhO1DyiqMZt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oR7nfrnqM75NrWxYNCsetHY9DCYWsZgMOdK9cdEOZUjS1Jx04hxgXbEYamWnSu2HUBRm6tQb9yq3aLY1qTCyDarTrLB6qAQrf5Emnp6yV1mnmLoR4wPylKi88POvVHNRElAB7Fk3/iAw/obP9F2s9fLBTmehW7s4tUfADwMI+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vw4oB1ti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2CCC4CEE3;
	Fri, 14 Mar 2025 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741967692;
	bh=1ATMb0vulPx/wb7OMAj9EUf9MVvm6vgVhO1DyiqMZt4=;
	h=From:To:Cc:Subject:Date:From;
	b=Vw4oB1tiojbOFEprYeglzHmEbyOmCWAevEsufmEehM+qGVA8YBzywyB+zqeNsPFKJ
	 SnOzuC2kO71Ekxj74cyp1wht2EWVYFMQoslCt0kNl96AvVPXJLClWRZ0IQLQo+G+v0
	 JmYgDtDPz0eUBuTUPuFE9wDx4v6ssRYxayBNv8pcu4f1EEEUHNp45MYTuwbtLWB+SQ
	 YvUDjb6Tm/rMbEMyH8M5NHbKVwwKakUBJnVTOK3M7atXuRNJBlPtv7RjFqOTDvPakx
	 zaC/53tJGVx8wW/hGj6nNOeRM0TLogGFIby+gMPVSzqzaOJ8MqtnFlAquyNf22Pi01
	 94iyegMPoDVUA==
From: Arnd Bergmann <arnd@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	Li Zetao <lizetao1@huawei.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: fix signedness issue in min()
Date: Fri, 14 Mar 2025 16:54:41 +0100
Message-Id: <20250314155447.124842-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Comparing a u64 to an loff_t causes a warning in min()

fs/btrfs/extent_io.c: In function 'extent_write_locked_range':
include/linux/compiler_types.h:557:45: error: call to '__compiletime_assert_588' declared with attribute error: min(folio_pos(folio) + folio_size(folio) - 1, end) signedness error
fs/btrfs/extent_io.c:2472:27: note: in expansion of macro 'min'
 2472 |                 cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);
      |                           ^~~

Use min_t() instead.

Fixes: f286b1c72175 ("btrfs: prepare extent_io.c for future larger folio support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c2451194be66..88bced0bfa51 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2468,7 +2468,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 			continue;
 		}
 
-		cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);
+		cur_end = min_t(u64, folio_pos(folio) + folio_size(folio) - 1, end);
 		cur_len = cur_end + 1 - cur;
 
 		ASSERT(folio_test_locked(folio));
-- 
2.39.5


