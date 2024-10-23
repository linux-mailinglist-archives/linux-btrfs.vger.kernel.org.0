Return-Path: <linux-btrfs+bounces-9094-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAAF9AC8A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 13:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D623280CE6
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 11:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7E119E804;
	Wed, 23 Oct 2024 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GxpwrNjs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05BB136331;
	Wed, 23 Oct 2024 11:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681794; cv=none; b=lqyRWi5vl3/FaGwvmStIUO4qfGxqmHZJsbMFYWHzzOglP2G8dLEtAW5GuMRNzG26LoZ8uBVH1I1OYVENR5UeL0j3zKzFu8oOLz3G1cczE9R+LTsaEQtCsG2ac12QWKgizSLsaCCx6d4FV5FGZzAHYTFzUWHZxGB7r7CzGJ/oYU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681794; c=relaxed/simple;
	bh=20+IhHzSy6px26ndP/QMlpnBhmMt8lB8+gQ+sPwjY7M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LUxI/2Dp+xecwJ/AFOXVBsWkKIszURve/82t6+8dKvwZ5QdJDPTBJUKuF6qUJn7h/1/k91PDVJCttWJnmrsSutEQ0LqoPW1/9jf/xkIS7wwObjCKMh4Lb1mxBy22Icl5X1MO9D5l9FyXju/aoz3Jn1SFuWV1jC0DGFLJc95rLeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GxpwrNjs; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1729681482; bh=JiDpDH6260JjAXoM2CIam0rvvgaHXdHTAJS8Aa6viY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GxpwrNjskbtkRJvoR7MvpMbm9YnhSxX1fKPYciVDZgUevDcCCFvypf4u3TrY3Vr5M
	 wMxEE9x+3yecxPxQLzN+ONl3zEH3pv2pE3XIpWEoJ2RiWDQrPk721vsWBROyqyYf/m
	 naXBPf5+Kbfaph+yKKUD12sS9HWjcEDoTbxNaRNk=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 127324C8; Wed, 23 Oct 2024 19:04:39 +0800
X-QQ-mid: xmsmtpt1729681479twhwhdqj4
Message-ID: <tencent_B5CA92105D925DA2993D4FD20DDD25BF8D07@qq.com>
X-QQ-XMAILINFO: MmPNY57tR1Xn8xVuMiIJ4Uq/ykwS2/TMtG2MzsSM0aB/WRQBYoSxgVfpOT0616
	 3CU5XihYICXwMEclebxkjYmqenWmvGUA2xiOgHZnVXxvK//4LWwX03CrnQKMulUX9CzMoTDfGYYi
	 SF59SCJdRLj2bnaRl5ulDE30EOCPIs5PMtuG+TCoh+a1OOcawEx0x9R9KYAqGdBabSzEDtdZlz8W
	 oudV54MLp6Od3k9VF8TgmqQW8DkS5BRVTaSfqGNclSDGU0L6Uf39sjMhpeFsb0asi8zZG6Y9Srq/
	 CX/le3Yl8u+BnjwrDIQsY41Mp2/mRc3RLPA0u467zvgSA2LRNs7+M9WBJcNCre0zd5Ftd1wmHPZy
	 fhE0gzoxrqlYyClhWb6paWEpbNc0icv4WYhBEl6hMojC3aUVJr4u0Ge/plkRoA1iEUenRMBBSguO
	 lI/o+XIWqd1So6DFN8yi9SZHgl+7W59MShKz7pNoLpAih7pruYl85OMGKrOoh6YtV2wl8i2HqoMd
	 LrFGwg7ZsDY9OjIGSFSDP+HPSx07Y+e3P3oWeT/xM0ewCiqjAm2CCJXynzL/Nzvqjt98FGjdaA2E
	 0l89u2LMxGULGvv1/DdBB3eR1ut8r/6D4tI8NSN/inqwzjpp0LjOTWBcRjPG8vNm81azLaNar0Hk
	 eB7OLOt/FwVDKHTGZQEesI8x+qhkoWRcIwg0+VSSSjhOyFlUK5NOFmLKFUt8tkXE5kv8x3Suniq1
	 xld7+5SGQax6XJS9i24PSrL7f6yF7pxeqWvUH1EzT4Ta7gnnh4jLLvLE41Y4MTEIe2RwhQgynGo0
	 nReUCFURRQhBcgSAg1cb+yqxHVSuhDLjbMkHCsU/IEC7TGT0xA/8k4bgPHbSzbqkn2gHqs0A3nHP
	 6zO39XaMtLDSSZmHcAb/QTE0iCPrwTMvbH8WdOljMSCVOeS8CGABWqVnd0D0G/9Cnl2ngezz5tir
	 u2umQIFoY=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+5d2b33d7835870519b5f@syzkaller.appspotmail.com
Cc: clm@fb.com,
	dsterba@suse.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] btrfs: add a sanity check for csum root before fill the data csum
Date: Wed, 23 Oct 2024 19:04:40 +0800
X-OQ-MSGID: <20241023110439.313902-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6718bd15.050a0220.10f4f4.01a0.GAE@google.com>
References: <6718bd15.050a0220.10f4f4.01a0.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a null-ptr-deref in btrfs_lookup_csums_bitmap.
The btrfs info contains IGNOREDATACSUMS, which prevents the csum root from
being loaded.
Before filling in the csum data, check the flag BTRFS_FS_STATE_NO_DATA_CSUMS
to confirm that the csum root has been loaded.

Reported-and-tested-by: syzbot+5d2b33d7835870519b5f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5d2b33d7835870519b5f
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/btrfs/scrub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3a3427428074..1ba4d8ba902b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1602,7 +1602,8 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	}
 
 	/* Now fill the data csum. */
-	if (bg->flags & BTRFS_BLOCK_GROUP_DATA) {
+	if (!test_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state) &&
+	    bg->flags & BTRFS_BLOCK_GROUP_DATA) {
 		int sector_nr;
 		unsigned long csum_bitmap = 0;
 
-- 
2.43.0


