Return-Path: <linux-btrfs+bounces-15757-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAEEB1660B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 20:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04205856AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409302E172D;
	Wed, 30 Jul 2025 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="RzOi2//0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lTciy9UP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60412E11B8
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898770; cv=none; b=VORYy3pA8kBfxMlhJJou28SCdtiw22Mg5yI2l/NfIcoRrfqYoILneL8ddo+fQy5wfxJvt4yLik9ZEszK1efxBQXbxxQvkG+1/flxwR9v/esctyXLXGMozHjiHrquqQ7j97ZhunnLlewHyCnv8G42NC/mIyMWe8aP/qdmrwtpgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898770; c=relaxed/simple;
	bh=6bpB9ppT0Q8AiudsK2mXx+sYhl9EKJdVZCEqiHHMaWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHlal4C8ewUduVbP2f0FZ6XkRfBgDLaZw7bCYthNbYtzdOed/go8uc4Cpcfe5Ma0W9LT626bf86VS5BsZRHIW2eeo9BKUau+k0VO+AEl5YkITgW6VdsnHkgBkq5cUhHTKGsIR2gSB4pdvAgK6Zp4wrE2ioQQoSpe4GZ5Xe3w8X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=RzOi2//0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lTciy9UP; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C6328EC222C;
	Wed, 30 Jul 2025 14:06:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 30 Jul 2025 14:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1753898765; x=1753985165; bh=vPVxW42+/sW0N2QbAcSfr
	IpxL2FddYKkImk6A0Xtqk8=; b=RzOi2//0zbpTMuvQDyeqRI65CAiWoJlv0JSmo
	gdPSU0NidsapIy59dWJq/7g/rfP7nFDMUt5+S4vzkTCFPijg0ZU1TK70L11oTCxU
	v8vSj+lLJmpQ2mZdOhrhIuvePlgb0/GjHceNcDCsPyOfVVGL6bWos3wOidD+J7UL
	DqnS6rO5sIIWwh/6SHT2+7uzqwAgwdP/wV/M/trdCSOFEXTmoDeYtJ7R9j9sLqeP
	CNT45bojXrdMRa4UJG48q5UDDuoPSdYKbCMZvAmRGoAg5ixTMYmc6/KgFF2cPLFm
	vD9XdCv/ohMQFJ2BsI/i6TNHOFPIXGaBg3+8H2IZory1ONYnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753898765; x=1753985165; bh=vPVxW42+/sW0N2QbAcSfrIpxL2FddYKkImk
	6A0Xtqk8=; b=lTciy9UPi31NaBmIeRR588MHXYfef7tJx3GLPVcMZLtZlLVI67v
	spCMkbhnDiU4lS2DcjW8k1Xetm/sEwcKHIsfm0jA912d6+e9BKPmWV3LVVcs1i+A
	7dnFkF80mfZhsyQe53Vu6Aj1jzotF1IEJSFH6PqCdvmmHr7kTlJ/pJJGSAQcbdhW
	d4VxZom9+UTCCLw1nwb6nxJM6ZPzyhgx6qA8nGyPQEyCkxbi7tR5d7DhfxX5u8H0
	5Zc7YZf2BDyzxtirm9GzbpRyORijoNXNBDoHhFsFYI7g4zgIz54cjAh9C4MEGOMT
	sL7imDCffDHtH93xRd/PUre4gMiW8+auVEQ==
X-ME-Sender: <xms:DV-KaHfQSYlQB5E_ZNjSaBKlU9q0F-Jso-_8f303IOMOAgN2KhahOw>
    <xme:DV-KaAe16ll21LNHfI5pni9YPbtoSwM0Q5Z4_fl2v59kZoqSRHcR8pOKSOtJPM_Zh
    PAmIZJVVMoqR5AnJog>
X-ME-Received: <xmr:DV-KaJ_h0QTkB85qKpWfA4iUDRWoixDRoW_4h0ptKvpL0tqRslswuZkNAYTl_6nU1GK3wKBlZdJqra0oZsnO8f23R0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeen
    ucggtffrrghtthgvrhhnpeduudfhvedvudfggfeggfekgefgvdeijefggeekvdduteekhe
    fhvdffueegveefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomhdprh
    gtphhtthhopeifqhhusehsuhhsvgdrtghomh
X-ME-Proxy: <xmx:DV-KaElmB-mND2CRCpwlyBPB4HuD3Ze1bLteO81cZysuQwnqCKfn_g>
    <xmx:DV-KaD-k6YH2WM9R2jQETc0_fI-mOOxKwuGFT4OjjiFXlxwLEL_kLw>
    <xmx:DV-KaKmS8rPmt7BYSQ8gEJIEw6H0zmg7MBSNRC9MvNxoGFzJwvSB8A>
    <xmx:DV-KaI0IB7OKyYOjyPdN497GVZwJWXr6maUqG4d1Gn963JbLYATpSw>
    <xmx:DV-KaOh4rPyV2DBssmSY7mcVITFgq_LpNUk-YX_Y-ti61Mx74zNYhUZy>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 14:06:05 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: wqu@suse.com
Subject: [PATCH] btrfs: fix iteration bug in __qgroup_excl_accounting()
Date: Wed, 30 Jul 2025 11:07:14 -0700
Message-ID: <3cc7e1d9f60efebe0b19f96eb4526dc195be4b2a.1753898804.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__qgroup_excl_accounting() uses the qgroup iterator machinery to
update the account of one qgroups usage for all its parent hierarchy,
when we either add or remove a relation and have only exclusive usage.

However, there is a small bug there: we loop with an extra iteration
temporary qgroup called `cur` but never actually refer to that in the
body of the loop. As a result, we redundantly account the same usage to
the first qgroup in the list.

This can be reproduced in the following way:

mkfs.btrfs -f -O squota <dev>
mount <dev> <mnt>
btrfs subvol create <mnt>/sv
dd if=/dev/zero of=<mnt>/sv/f bs=1M count=1
sync
btrfs qgroup create 1/100 <mnt>
btrfs qgroup create 2/200 <mnt>
btrfs qgroup assign 1/100 2/200 <mnt>
btrfs qgroup assign 0/256 1/100 <mnt>
btrfs qgroup show <mnt>

and the broken result is (note the 2MiB on 1/100 and 0Mib on 2/100):
  Qgroupid    Referenced    Exclusive   Path
  --------    ----------    ---------   ----
  0/5           16.00KiB     16.00KiB   <toplevel>
  0/256          1.02MiB      1.02MiB   sv
  Qgroupid    Referenced    Exclusive   Path
  --------    ----------    ---------   ----
  0/5           16.00KiB     16.00KiB   <toplevel>
  0/256          1.02MiB      1.02MiB   sv
  1/100          2.03MiB      2.03MiB   2/100<1 member qgroup>
  2/100            0.00B        0.00B   <0 member qgroups>

with this fix, which simply re-uses `qgroup` as the iteration variable,
we see the expected result:
  Qgroupid    Referenced    Exclusive   Path
  --------    ----------    ---------   ----
  0/5           16.00KiB     16.00KiB   <toplevel>
  0/256          1.02MiB      1.02MiB   sv
  Qgroupid    Referenced    Exclusive   Path
  --------    ----------    ---------   ----
  0/5           16.00KiB     16.00KiB   <toplevel>
  0/256          1.02MiB      1.02MiB   sv
  1/100          1.02MiB      1.02MiB   2/100<1 member qgroup>
  2/100          1.02MiB      1.02MiB   <0 member qgroups>

The existing fstests did not exercise two layer inheritance so this bug
was missed. I intend to add that testing there, as well.

Fixes: a0bdc04b0732 ("btrfs: qgroup: use qgroup_iterator in __qgroup_excl_accounting()")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/qgroup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1a5972178b3a..ccaa9a3cf1ce 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1453,7 +1453,6 @@ static int __qgroup_excl_accounting(struct btrfs_fs_info *fs_info, u64 ref_root,
 				    struct btrfs_qgroup *src, int sign)
 {
 	struct btrfs_qgroup *qgroup;
-	struct btrfs_qgroup *cur;
 	LIST_HEAD(qgroup_list);
 	u64 num_bytes = src->excl;
 	int ret = 0;
@@ -1463,7 +1462,7 @@ static int __qgroup_excl_accounting(struct btrfs_fs_info *fs_info, u64 ref_root,
 		goto out;
 
 	qgroup_iterator_add(&qgroup_list, qgroup);
-	list_for_each_entry(cur, &qgroup_list, iterator) {
+	list_for_each_entry(qgroup, &qgroup_list, iterator) {
 		struct btrfs_qgroup_list *glist;
 
 		qgroup->rfer += sign * num_bytes;
-- 
2.50.1


