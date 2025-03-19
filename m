Return-Path: <linux-btrfs+bounces-12435-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3A1A69BAB
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 23:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A661886E6E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 21:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDB3217709;
	Wed, 19 Mar 2025 21:59:12 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.nerd2nerd.org (mail.nerd2nerd.org [148.251.171.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E8320C47C;
	Wed, 19 Mar 2025 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.171.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421552; cv=none; b=TzieFH/ICoLpCaa3AagfGojjPYy3CmrM2xz3EbMv2E6IkKhQJo11UUsxMu7F1AIy1saKWGBj1BSu1FLrF4hsYefpAY2jAQ8wtCTCHchw2UeFALDqJ24Fkq8Sgpd+8v4eN0oLaWgJ6tuhVLa2viB+8V8t5Y1EA7DTrd6wS0afpjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421552; c=relaxed/simple;
	bh=+j0KnPbxRceiN4nyHw95QpxMbV+ttJ7Y3YFnL4tYSPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kPUioXE7RjL5tQmxPA88mSjEn2bDQEIqUWnQe/WYlDkNdf+lCB9ni1zUAUXLM6VicELMjm+I8jmYEj0lQeZdoqRsUxoclN9Eih/Lb74a+lgXiEpxaU6PeffCtOeTUVMoqQVtWsumtFZ9dgbknsbjAM2JdHFQdyBjfb1zcmiAoNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bareminimum.eu; spf=pass smtp.mailfrom=bareminimum.eu; arc=none smtp.client-ip=148.251.171.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bareminimum.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bareminimum.eu
Received: from kosch.limbus.lpm.pw (2a0b.f4c0.00c1.920e.5dc1.f92c.7e43.b460.rdns.f3netze.de [IPv6:2a0b:f4c0:c1:920e:5dc1:f92c:7e43:b460])
	by mail.nerd2nerd.org (Postfix) with ESMTPA id EDFF560FE2;
	Wed, 19 Mar 2025 22:49:01 +0100 (CET)
Authentication-Results: mail.nerd2nerd.org;
	auth=pass smtp.auth=lemmi@nerd2nerd.org smtp.mailfrom=kernel@bareminimum.eu
From: Johannes Kimmel <kernel@bareminimum.eu>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	linux-kernel@vger.kernel.org,
	Calvin Walton <calvin.walton@kepstin.ca>
Subject: [PATCH] btrfs: correctly escape subvol in btrfs_show_options
Date: Wed, 19 Mar 2025 22:49:00 +0100
Message-ID: <20250319214900.25100-1-kernel@bareminimum.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, displaying the btrfs subvol mount option doesn't escape `,`.
This makes parsing /proc/self/mounts and /proc/self/mountinfo
ambigious for subvolume names that contain commas. The text after the
comma could be mistaken for another option (think "subvol=foo,ro", where
ro is actually part of the subvolumes name).

This patch replaces the manual escape characters list with a call to
seq_show_option. Thanks to Calvin Walton for suggesting this approach.

Fixes: c8d3fe028f64 ("Btrfs: show subvol= and subvolid= in /proc/mounts")
Suggested-by: Calvin Walton <calvin.walton@kepstin.ca>
Signed-off-by: Johannes Kimmel <kernel@bareminimum.eu>
---
 fs/btrfs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index dc4fee519ca6..a5f29ff3fbc2 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1139,8 +1139,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	subvol_name = btrfs_get_subvol_name_from_objectid(info,
 			btrfs_root_id(BTRFS_I(d_inode(dentry))->root));
 	if (!IS_ERR(subvol_name)) {
-		seq_puts(seq, ",subvol=");
-		seq_escape(seq, subvol_name, " \t\n\\");
+		seq_show_option(seq, "subvol", subvol_name);
 		kfree(subvol_name);
 	}
 	return 0;
-- 
2.49.0


