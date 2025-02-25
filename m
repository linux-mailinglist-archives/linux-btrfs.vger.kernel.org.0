Return-Path: <linux-btrfs+bounces-11791-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF37A44BB5
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 20:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E533B42A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 19:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33151207DE0;
	Tue, 25 Feb 2025 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8sAATfI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F4C4414;
	Tue, 25 Feb 2025 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740512661; cv=none; b=b41eDAoM6xidL8027EPrKmoUhQpDCssxL2km3l3PmNcSiO71jxQ1cKKuKTIC3Ecf2CjUW++JWi3t8gmgL4J8C6kMlZqLNZMlZGzhPKvwi3A5L1yJwOJpOIZzLL0qfACCEga9rmB+5heYM4oytV7uEDqinDt9on2kU486pF/+AJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740512661; c=relaxed/simple;
	bh=vIw4jvWwt8g3Zin5gdtPAweCnwzLAN65nBkcmGz60X8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GVU6ogvHQri/whP3TkkSRJ0Ccw6Z3v3VIXXFodG7zVhY83uJjlO76Sdl71E6pf11NaCuM8ohGx4hSkz7LjBrqcgpAGvtz5PlZJpD9W1fMIgDSOt/nX2C+i7ss3GeKfiKEq79nnNh+hkLsJofRXCMjY8VvnyMMEjynrK+QFEjzdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8sAATfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFD2C4CEDD;
	Tue, 25 Feb 2025 19:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740512660;
	bh=vIw4jvWwt8g3Zin5gdtPAweCnwzLAN65nBkcmGz60X8=;
	h=From:To:Cc:Subject:Date:From;
	b=r8sAATfIOix1IgDBq8FbEqOhGec2nmE/cv4BFDSEGWs22fWPT29ItLfHqxzhqByIl
	 2+KNfxTaW5BoFhpT02FKZ4CXf+rvbgpse5gALazikiBTrt5idFZmRC1kfE6y6pgrsp
	 B5EGuQWx/h0vjyM/SnptAFnG1LoawGs53A1qyMgTfHVIIEm4bCB5azWNGZ3H+hrNn4
	 47IIY9JJt3f7cM4Scl/TE/22CCylkLviwoi1BU3qXBc3fDeheJBMvblDI1ppN3RMkb
	 3jx/Nk9hEvtsnXRYeRVqtA+CuSDvPJ0lyfJMxDMePCg8i7khXe0nuNdIUigIYWjNgY
	 rjRYjPJep1hEg==
From: Arnd Bergmann <arnd@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	kernel test robot <lkp@intel.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>,
	Li Zetao <lizetao1@huawei.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] btrfs: use min_t() for mismatched type comparison
Date: Tue, 25 Feb 2025 20:44:10 +0100
Message-Id: <20250225194416.3076650-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

loff_t is a signed type, so using min() to compare it against a u64
causes a compiler warning:

fs/btrfs/extent_io.c:2497:13: error: call to '__compiletime_assert_728' declared with 'error' attribute: min(folio_pos(folio) + folio_size(folio) - 1, end) signedness error
 2497 |                 cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);
      |                           ^

Use min_t() instead.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502211908.aCcQQyEY-lkp@intel.com/
Fixes: aba063bf9336 ("btrfs: prepare extent_io.c for future larger folio support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/extent_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f0a1da40d641..7dc996e7e249 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2485,7 +2485,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 		 * code is just in case, but shouldn't actually be run.
 		 */
 		if (IS_ERR(folio)) {
-			cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
+			cur_end = min_t(u64, round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
 			cur_len = cur_end + 1 - cur;
 			btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
 						       cur, cur_len, false);
@@ -2494,7 +2494,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 			continue;
 		}
 
-		cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);
+		cur_end = min_t(u64, folio_pos(folio) + folio_size(folio) - 1, end);
 		cur_len = cur_end + 1 - cur;
 
 		ASSERT(folio_test_locked(folio));
-- 
2.39.5


