Return-Path: <linux-btrfs+bounces-21053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHw9B3sgd2ntcQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21053-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 09:06:19 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DBB85449
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 09:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E19843018C02
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 08:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2572F6935;
	Mon, 26 Jan 2026 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LgydyNuQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6832EC090
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769414739; cv=none; b=YMLgtSTUUh72WR7h9vq6beaIyiPwX0IEsNsNtb1/t0bBpT/LphuqzQIBhQoV21mXYjqRcmbTYJgaveeQSnT/svt2YPwwjulCTE/M1nmA/3nep7I1DhFk8UVL9KGE/goNoWasae0jMgmuPQkUszQFkC/qbVjAci+4rxqO5j9im1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769414739; c=relaxed/simple;
	bh=GBHimS/2PDemVuQEnySaN26qVG/akUxblG62ownHrSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIuEc8UdbhnwijP4DKoT51W5ILJDhqCc1YswysjKvvTs7W7NllhpTMY+p94oT9wVAi5sww2RRuej3dhOHvoKrwxCLDCZT/9sFS9cjn/SnBIf+P17WDldm6WowXr3HYii3prS/o64gYwdIYoViCAiKVzRP/3w9znDHz1OP6+WBZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LgydyNuQ; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769414737; x=1800950737;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GBHimS/2PDemVuQEnySaN26qVG/akUxblG62ownHrSY=;
  b=LgydyNuQA6BLzDFVb9La0g/9RuXfh3AMpSD9rhCsyuAuKIx+GOX/DmlP
   2c7bZUogSNTzYHCxW9EigAHYyZ8HhqNRx/tufTN6+BaAPIF00cOMxksr9
   RSUJDXXYwBr+bm4OFvVGJwC1eLddMRrK4WTFx+rxhK4MgUCkGCR5AT5C7
   cUvZJQ/mP7Ti3rTgUMa/KzGrFS3PiZIF3uhaLAMxtxpxTz5x2K8P0Mm9N
   ZETfTiimka/b+CcW1ytLZ3bISf/q+2C56MRsVTwmiaTdfAH7QyqGPBGD8
   uGaSRWWlVMvCJtUwP63cqqO4zsd4bRzb45pgKslL+oEABrTFOpfDrkhcj
   w==;
X-CSE-ConnectionGUID: pS/3SM2cSqCSo2aspecx4Q==
X-CSE-MsgGUID: kKpTXIdvS3iKrIwODV69Tw==
X-IronPort-AV: E=Sophos;i="6.21,254,1763395200"; 
   d="scan'208";a="139202562"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2026 16:05:31 +0800
IronPort-SDR: 6977204b_PD3BK0oEK7c86em/J/+mzDK1nTIG4nMMHKh22dpLIOywbeJ
 4lVvXNzrdxTifkGk5OY1YcECdUmtBSQAcu9663Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jan 2026 00:05:31 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.73])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jan 2026 00:05:29 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chris Mason <clm@meta.com>
Subject: [PATCH] btrfs: fix copying the flags of btrfs_bio after split
Date: Mon, 26 Jan 2026 09:05:24 +0100
Message-ID: <20260126080524.612184-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[wdc.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21053-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wdc.com:email,wdc.com:dkim,wdc.com:mid,meta.com:email]
X-Rspamd-Queue-Id: C7DBB85449
X-Rspamd-Action: no action

When a btrfs_bio gets split, only 'bbio->csum_search_commit_root' gets
copied to the new btrfs_bio, all the other flags don't.

Copy the rest of the flags as well.

Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index d3475d179362..0a69e09bfe28 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -97,7 +97,13 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 		bbio->orig_logical = orig_bbio->orig_logical;
 		orig_bbio->orig_logical += map_length;
 	}
+
 	bbio->csum_search_commit_root = orig_bbio->csum_search_commit_root;
+	bbio->can_use_append = orig_bbio->can_use_append;
+	bbio->is_scrub = orig_bbio->is_scrub;
+	bbio->is_remap = orig_bbio->is_remap;
+	bbio->async_csum = orig_bbio->async_csum;
+
 	atomic_inc(&orig_bbio->pending_ios);
 	return bbio;
 }
-- 
2.52.0


