Return-Path: <linux-btrfs+bounces-21562-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMZXHpslimlCHwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21562-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 19:21:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0413111379C
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 19:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 308953019118
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AAB2F6907;
	Mon,  9 Feb 2026 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="LDQgKwse"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46CA2E762C
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661224; cv=none; b=F463GuuGvHgdq4B+T3+7mcuSanFy1zjn8whN1NP9OvF4N5Jv0VYbF6EL9C+205a5QHQJkNQ3sU9wK6ScNUGPYhSvRSrvBTyg8aBLlRuMJE+iprlnBQpc89Ggj6Lzk0pjupk05ZF2QcKJ9TBAPhkdZDnbJZXO2jK7yc/6PqGryyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661224; c=relaxed/simple;
	bh=CGuk3MS9hmN4IAHBJzKpdqACCGoEDgKHIKm+Gz69gIE=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=ICrj807q7P6HX3+N1U+n1CSnv9e6nJXJ2s7CnFART4SAb7sldXIjWZKFhICkP29iwfxHcfhUGeeWZZYyCGrDpLjKTkXWhfB+Egb7hwnKXzus7Grcd6rnWTs2BPxAaiZ0z2+8FB+7doerlKV9KHjYi72mzVhKhlwMT/XODE94XoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=LDQgKwse; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 266AD2FF732;
	Mon,  9 Feb 2026 18:10:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1770660645;
	bh=8/0yh32eDFd6ZZDVMciUdSt2QeEiZVNPxLVuR/k4/vM=;
	h=From:To:Cc:Subject:Date;
	b=LDQgKwseD+oxSq341y4bfH7Zu6Sk5ZBjI+Ikc1M5+iJVl00rKP6Q7naCQJ4j2AQKZ
	 o03FajXUZ7c0NcVXhVOSyt7mbWHB7QNXYfccau5UCGu367pcpZYWkXoPRxzodAPwmU
	 fmGY/Z8KuKDBQYy/VZnbHJwprjlizWnsSHSRTrws=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH] btrfs: add remap tree definitions for print-tree
Date: Mon,  9 Feb 2026 18:10:19 +0000
Message-ID: <20260209181043.27364-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[harmstone.com,none];
	R_DKIM_ALLOW(-0.20)[harmstone.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21562-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark@harmstone.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[harmstone.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,harmstone.com:mid,harmstone.com:dkim,harmstone.com:email]
X-Rspamd-Queue-Id: 0413111379C
X-Rspamd-Action: no action

Add the definitions for the remap tree to print-tree.c, so that we get
more useful information if a tree is dumped to dmesg.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/print-tree.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index f189bf09ce6a..b7dfe877cf8d 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -38,6 +38,7 @@ static const struct root_name_map root_map[] = {
 	{ BTRFS_BLOCK_GROUP_TREE_OBJECTID,	"BLOCK_GROUP_TREE"	},
 	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
 	{ BTRFS_RAID_STRIPE_TREE_OBJECTID,	"RAID_STRIPE_TREE"	},
+	{ BTRFS_REMAP_TREE_OBJECTID,		"REMAP_TREE"		},
 };
 
 const char *btrfs_root_name(const struct btrfs_key *key, char *buf)
@@ -415,6 +416,9 @@ static void key_type_string(const struct btrfs_key *key, char *buf, int buf_size
 		[BTRFS_UUID_KEY_SUBVOL]			= "UUID_KEY_SUBVOL",
 		[BTRFS_UUID_KEY_RECEIVED_SUBVOL]	= "UUID_KEY_RECEIVED_SUBVOL",
 		[BTRFS_RAID_STRIPE_KEY]			= "RAID_STRIPE",
+		[BTRFS_IDENTITY_REMAP_KEY]		= "IDENTITY_REMAP",
+		[BTRFS_REMAP_KEY]			= "REMAP",
+		[BTRFS_REMAP_BACKREF_KEY]		= "REMAP_BACKREF",
 	};
 
 	if (key->type == 0 && key->objectid == BTRFS_FREE_SPACE_OBJECTID)
@@ -435,6 +439,7 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 	struct btrfs_extent_data_ref *dref;
 	struct btrfs_shared_data_ref *sref;
 	struct btrfs_dev_extent *dev_extent;
+	struct btrfs_remap_item *remap;
 	struct btrfs_key key;
 
 	if (!l)
@@ -569,6 +574,11 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 			print_raid_stripe_key(l, btrfs_item_size(l, i),
 				btrfs_item_ptr(l, i, struct btrfs_stripe_extent));
 			break;
+		case BTRFS_REMAP_KEY:
+		case BTRFS_REMAP_BACKREF_KEY:
+			remap = btrfs_item_ptr(l, i, struct btrfs_remap_item);
+			pr_info("\t\taddress %llu\n", btrfs_remap_address(l, remap));
+			break;
 		}
 	}
 }
-- 
2.52.0


