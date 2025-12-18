Return-Path: <linux-btrfs+bounces-19854-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFB7CCAD3D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 09:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C3EF3008317
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 08:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B524432FA2C;
	Thu, 18 Dec 2025 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="i8AqiMZt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0912D9EC8;
	Thu, 18 Dec 2025 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045850; cv=none; b=sJ+4F2wysZPW6OQ5b6ElH02CXrQayYwDBCG9ZYq6aZDo6AziT0iRr23jC2iA3kkez79H6Z/axW5nmcydZR0USP/7fW7Xo3jtoykfKB1gDld/aJjbMBd6Gf84scfcbnQ5XzCApLl0kXWk91sGZ7vISJJ1ES1jGdroQAbng4lCyRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045850; c=relaxed/simple;
	bh=J2IS8U9a9EtD5utFJy4qj8i174f2l54TnwNC7tUNoyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GXDC6w9Lbl+vDyB9qnHIYBzXQgzQBme/V7+dAxq2bwMgbPikjDFVAOz7ezaWik8im29lWZBo+xkIHsPfPfWJ3JGg33ELQYEz54EdIy1n1POH6HTZ5lQzMOUJZP9dSfZeDDqQ4PuRGXoZ2mfcyn7QGvVXS8tq6PQBAL2bxDTO37E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=i8AqiMZt; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1766045803;
	bh=QMOt8eJN3mjsg5ICNzvJjPyuY+zOmNxK8x4e/QA/JTg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=i8AqiMZtYrLTUdarEzm7mdi80UlRVUPx9oiOCdqGybOmhrhJQkdFlB2FuvDJBuTCk
	 Nop7KL5wIqJrHnGUwtsYas0Rjo/HoypzSfwriXcUZZl1w3o8HuEeDKD/beZi16whZV
	 JAKKhbtM2x4qVVO4hn6NKRQ0eH2gaJgScSoXPr3Q=
X-QQ-mid: esmtpsz17t1766045798t73a39d12
X-QQ-Originating-IP: dLhky4rDvNYv/0tJwvWCtG3bpeJNT5YeNUzgT0dy928=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Dec 2025 16:16:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13799518469486644733
EX-QQ-RecipientCnt: 5
From: Qiang Ma <maqianga@uniontech.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] btrfs: Fix -Wmaybe-uninitialized warning
Date: Thu, 18 Dec 2025 16:16:18 +0800
Message-Id: <20251218081618.2038279-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MmIUUz9KGMMd2tkHFEALn/l7l0VpMd7c5iETnH80T61x/U72t+6qCJs2
	NTfb/MprU5/R7t4gkkHh78pFlhQx6ajoTm/3oloVDac2YRXhWbG1YFADnsCJkLDBe18rKWe
	Yr01WMJlzMv83eZGdwp5HeQ5Dq+OD+2806bW2BQ95L2G+JBnk+EsKFneuW0IrIuxrB+/0vu
	kTMleiVy6cn/TLJ7ebMxZHskD2dXILk10fB0VlBNK2HjdHLwrj1oALHEA8LbLsUFh0D1dN9
	Jo/0+DSfepl/9wyIRWB2Ba3rd0/JbfWuH6bwlZWz54nft74icT8wkCq/WRuXmxRaY5yzeSW
	drMs1X+4B3K3jBSK0X2KOi9vIfkyMyI5T7OsKqMDlitenH+u6Z02aaL8jn4zTuRcRVeF5Rh
	KZfNgxcdnRDQmPYIZQCO/w091VDgIoG/S5ox4jma+0vIiwllxitOy9em43N/EtteMV2mS80
	SY21mRWznCaVRvjQZRshtx9zYHNMomzoArPNFdd/uIXwH8er54fEAgEa6JxtNDfTZY9bmkp
	Hl9r/7lJ1/pBPl0VZ6ImUHK61A74zeuCFqrs2i8eShBjeL/6sOgbtwBpa67iTX3Q26w+zRG
	R+yOXx9RcFrC5LbeK16v9PGxFKmUxyBWl+3vAJiI0aZnCzdrgf4X5OoZjSMyvySR/vw2Sgi
	aflzIqqI6SumPbw3B30f7Kya7ICYqbMuHNiCbrU3DVaqN1wfvfsCFqzxo2/TgWO6Y/QEH9D
	hW5Go/qStBcSI5SoW8rgNOrLfUxRGB0/HnzXQRnYIXLHBjILBEkG9BTcUvarAmZlhNqj8Ur
	mKTLTTI5sHbBYmeVVgi/eTDpbxU/rJk0QurNfmgWb0RxqTXpD87ORmXHdS93igBU4TWv5dB
	EUDNRKOCFaMbq+433mCeQHTk69oqZ+G7x7dKOWUQZBy28vGfeL4pvHnkDvgX3ylZUUBQG46
	scWvH2+7HPofNe0UNq8IbIHa8eFK488vTiyJZ2EpM1ogAYmpX7i1uzFbf4GlBP+869DQhI6
	OuoaJekrwObCH+tGhG
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Fix a -Wmaybe-uninitialized warning by initializing
the variable to NULL.

$ make CFLAGS_tree-log.o=-Wmaybe-uninitialized

In file included from fs/btrfs/ctree.h:21,
                 from fs/btrfs/tree-log.c:12:
fs/btrfs/accessors.h: In function 'replay_one_buffer':
fs/btrfs/accessors.h:66:16: warning: 'inode_item' may be used uninitialized [-Wmaybe-uninitialized]
   66 |         return btrfs_get_##bits(eb, s, offsetof(type, member));         \
      |                ^~~~~~~~~~
fs/btrfs/tree-log.c:2803:42: note: 'inode_item' declared here
 2803 |                 struct btrfs_inode_item *inode_item;
      |                                          ^~~~~~~~~~

Warning was found when compiling using loongarch64-gcc 12.3.1.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 31edc93a383e..0d6faaaa70f1 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2798,7 +2798,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 
 	nritems = btrfs_header_nritems(eb);
 	for (wc->log_slot = 0; wc->log_slot < nritems; wc->log_slot++) {
-		struct btrfs_inode_item *inode_item;
+		struct btrfs_inode_item *inode_item = NULL;
 
 		btrfs_item_key_to_cpu(eb, &wc->log_key, wc->log_slot);
 
-- 
2.20.1


