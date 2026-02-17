Return-Path: <linux-btrfs+bounces-21723-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FZeMFW7lGmKHQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21723-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 20:02:45 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E3E14F704
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 20:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A737300B592
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Feb 2026 19:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266D4372B26;
	Tue, 17 Feb 2026 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="xR+eTFGM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592AA36F402
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Feb 2026 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354963; cv=none; b=M8642VA/e1diDRb33mPt4YcX+CS6cbWTU3fuNu8XBDmQtgb2wKy9HwF0VBRHk+3L5Jcg9dgkaCiOqR0ZUF/oBWmPaI+q/37SfQ/avcvBTpU6ek+owbQSbOfz9svnSFQxXjbfTiqJLDEfWM6bLDsuS4c3NPH3lPkQv2qFP5SrIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354963; c=relaxed/simple;
	bh=+8X++Kpo/Bmppgv0iRYEnq6cdFGOPvjwcXCUkfqK0Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=GGlqg1jZSTCzNLGCuQtJNVpTsgfAYKu64n9QLfB/O+joFmqD9nkcZhOLTmZztKB+QC0rYVPHRTkN2CU+uCQ/PW5d3N/RazD7i/0FcTi49oJEpOQdxpDSUxhb34Rkt1bfQlFa17z1MYbKbNTDVWvGslcal3HSeaNMFaudag2r4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=xR+eTFGM; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id C0926303149;
	Tue, 17 Feb 2026 19:02:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1771354960;
	bh=7ZGtMb7ToSEbnlVuymFIVpieECAiQtyanEvPPEXqlow=;
	h=From:To:Cc:Subject:Date;
	b=xR+eTFGMcEZnPLdXEbOYS167dVuSYdpDTUGcQNWGfgwaf7AEUa2NFyl/522qA86CA
	 MPe1vIOwEZy8HQfmFtso3j5Q/HdG70PQo7EKOZbZLtuE7O487LkK3FV5K8xyHH91FL
	 5bpT4cpdXlXNvugYL4yoyyaF/0jhZpxqCfkbXURI=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org,
	anand.jain@oracle.com
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH] btrfs: fix warning in scrub_verify_one_metadata()
Date: Tue, 17 Feb 2026 19:02:27 +0000
Message-ID: <20260217190238.22006-1-mark@harmstone.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21723-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark@harmstone.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[harmstone.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,harmstone.com:mid,harmstone.com:dkim,harmstone.com:email]
X-Rspamd-Queue-Id: 68E3E14F704
X-Rspamd-Action: no action

Commit b471965f fixed the comparison in scrub_verify_one_metadata to use
metadata_uuid rather than fsid, but left the warning as it was. Fix it
so it matches what we're doing.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Fixes: b471965fdb2d ("btrfs: fix replace/scrub failure with metadata_uuid")
---
 fs/btrfs/scrub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2a64e2d50ced..052d83feea9a 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -744,7 +744,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 		btrfs_warn_rl(fs_info,
 	      "scrub: tree block %llu mirror %u has bad fsid, has %pU want %pU",
 			      logical, stripe->mirror_num,
-			      header->fsid, fs_info->fs_devices->fsid);
+			      header->fsid, fs_info->fs_devices->metadata_uuid);
 		return;
 	}
 	if (memcmp(header->chunk_tree_uuid, fs_info->chunk_tree_uuid,
-- 
2.52.0


