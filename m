Return-Path: <linux-btrfs+bounces-11792-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27889A44BB8
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 20:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E939D7A9AFF
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 19:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B571B20E035;
	Tue, 25 Feb 2025 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5x/B3td"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E7A1990A2;
	Tue, 25 Feb 2025 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740512667; cv=none; b=Mvjul9qlFIFSVVWwuksYtmUFKZ9vI7HJjhhOjDMyxk7TPX5rmM9D6fLxYXYa4FYg40LqZjcphBjQukxnkCe0LxJQkc7O5iyzddQDvruqwCNoDT1iNzjdIB4z4Q18MAsObNhbxGodAN5whKRFN8zkH/49F5QEkDFxve6gLvjIDMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740512667; c=relaxed/simple;
	bh=j5yUuEoh109WA1aqshRDntEFnbJeNvWnm5FJnWd9Zog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GzJX4hyHRHW6ZWt9VHjiM5JYe3cmK4gjjnnAXYbXQ6iWmXjlyuhX6tPKHEgRc15vZ45ddOWVaeB+L+CN4ceOkRcJqBSpVRqcvTwD5H1GDyEUBoX2ImVKnJu9mKt85AF++LXum/f9+BFXaawbsRfnJLTSllFg/sBOfphwP66fdYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5x/B3td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B40C4CEE8;
	Tue, 25 Feb 2025 19:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740512666;
	bh=j5yUuEoh109WA1aqshRDntEFnbJeNvWnm5FJnWd9Zog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M5x/B3tdFbd/hFnohm5SCxIa/2W/QuPBRD1k08fxv2xLij0yHMyGY9Adgd5mf9u+B
	 xHQYWC9l5G41dD0KLLvpu7rY00ddYSY1N+ARtepf+LvetfqCzBSC0LIJG+b86Ui3kE
	 +egegMElQWU1RBJ/2T7FPzxeht+tx7Y7Ku6rpaSdc9IG/htdy65tx3oRShls1UDIvv
	 P+cgKs6s1mDmRObfyEcbquh0TLNjKSSaVuM457NEun5JvKz24V/eLiO5mDuBnZBlPS
	 HU33CoHeO+fOvXYREZSiPtmMc9IyTpwbIbDF/bvdrNN2fKAffwhEFbHpxNeWwPZmB1
	 8JTO6KN35YmQg==
From: Arnd Bergmann <arnd@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>,
	Li Zetao <lizetao1@huawei.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] btrfs: replace 64-bit division with a shift
Date: Tue, 25 Feb 2025 20:44:11 +0100
Message-Id: <20250225194416.3076650-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225194416.3076650-1-arnd@kernel.org>
References: <20250225194416.3076650-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

folio_size() is not a compile-time constant, so in some configurations,
the DIV_ROUND_UP() turns into a 64-bit division that is not allowed
on 32-bit architectures.

x86_64-linux-ld: fs/btrfs/extent_io.o: in function `writepage_delalloc':
extent_io.c:(.text+0x2b6e): undefined reference to `__udivdi3'

This is probably not the correct solution, but it should illustrate
the issue. A trivial fix would be DIV64_U64_ROUND_UP(), which of course
is very expensive.  Maybe there should be a DIV_ROUND_UP_FOLIO macro?

Fixes: aba063bf9336 ("btrfs: prepare extent_io.c for future larger folio support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/btrfs/extent_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7dc996e7e249..e4ba4fa3f48c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1505,8 +1505,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	 * delalloc_end is already one less than the total length, so
 	 * we don't subtract one from folio_size().
 	 */
-	delalloc_to_write +=
-		DIV_ROUND_UP(delalloc_end + 1 - page_start, folio_size(folio));
+	delalloc_to_write += (delalloc_end + 1 - page_start + folio_size(folio) - 1) >> folio_order(folio);
 
 	/*
 	 * If all ranges are submitted asynchronously, we just need to account
-- 
2.39.5


