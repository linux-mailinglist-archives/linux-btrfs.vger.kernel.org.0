Return-Path: <linux-btrfs+bounces-21352-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFd2OfL2gmlVfwMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21352-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 08:36:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81329E2B99
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Feb 2026 08:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D11D1301C71A
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Feb 2026 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56AC38E5D1;
	Wed,  4 Feb 2026 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NyMAVpaf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99D827E04C
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Feb 2026 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770190575; cv=none; b=YvObsZxiey8pWKFgfQP0YzwUzjr9ttbhoTZf6dL6G6St95paV+vI31s33b0GKWXN6DXaxOSpWbn//QVuwWF/Y2+Mc5h5rDDYDCAHcf0n/uC2FOKeP1eNLrsoUi9icEMQTEwqy9OWdbFvWH7OFIA38RAvaqFSaWhEz7aeAoWlM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770190575; c=relaxed/simple;
	bh=GLXJUNd4q6U05ipjoAupiUL0HQA2BOzwYus6JRa3V5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MsViULETnXExVXy7PM7jqIw35ioxG1yWrlJeYvKFONh/s9fVRABZknUXu/TxSBzd7smCuoC+tdjMZSPM1zNKyvhEPCM9e2iCM2eQgvLdJKZiIXGoHjyH2pPocj3P1gnHXcT9I5nZbdre1Ov5iat8oWsL4PEKT+n3boYSaZJbUc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NyMAVpaf; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770190574; x=1801726574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GLXJUNd4q6U05ipjoAupiUL0HQA2BOzwYus6JRa3V5w=;
  b=NyMAVpafxOzQHzTSNeYRzj4Amf8KdUCE+5QC+4Tlncl1LExr3cJB6dSh
   LI0OMRfsVgmL1jDkX5EoX2fihtS1EPVpD1rzr5oqJY16YwWGcs9C2xFS9
   raedQewYME66dgNHR2DCdo2auswA2m4RijkXlVvh0WJbF/bAzWKsxVJv2
   0j0IjnSl4gknqaAjw9mfVIU8dUksL3Pi+BDKo3ZrJxDipyxjk4Homqqdi
   ybNC/rFxetw+Ehxvup6RrJjFcFGvCgHNIBFAaqxewx7avVK1AkQlFYVMK
   MKPa9SCjZNLNJnLkXUAW8uLMrao2UC3KoJ7ubwNAp0uOFm/JPgisKZDa0
   w==;
X-CSE-ConnectionGUID: S4AGusVWSwauBX96JF053Q==
X-CSE-MsgGUID: x3WlqNUdQjqytcL/gxc3OQ==
X-IronPort-AV: E=Sophos;i="6.21,272,1763395200"; 
   d="scan'208";a="139250036"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2026 15:36:14 +0800
IronPort-SDR: 6982f6ee_Qqscmoftw2VCcVpLWkH3vWPQU2Rwc3uh5mej9DXsFXlgzeZ
 LcVgnv5y8iOVQKdJnB7hM6iwrBpBhvHgR7NL8/A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Feb 2026 23:36:14 -0800
WDCIronportException: Internal
Received: from wdap-p2d7qjs7w9.ad.shared (HELO naota-xeon) ([10.224.106.65])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Feb 2026 23:36:13 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 0/1] btrfs: tests: zoned: add selftest for zoned code
Date: Wed,  4 Feb 2026 16:31:24 +0900
Message-ID: <20260204073125.3173982-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.53.0
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
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21352-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naohiro.aota@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:mid,wdc.com:dkim]
X-Rspamd-Queue-Id: 81329E2B99
X-Rspamd-Action: no action

Having conventional zones on a RAID profile made the alloc_offset
loading code enough complex. It would be good time to add btrfs test for
the zoned code.

For now it tests btrfs_load_block_group_by_raid_type() with various test
cases. The load_zone_info_tests[] array defines the test cases.

- v3:
  - Rebased on fresh for-next
- v2: https://lore.kernel.org/linux-btrfs/20260126054953.2245883-1-naohiro.aota@wdc.com/
  - Fix compile error without CONFIG_BLK_DEV_ZONED
- v1: https://lore.kernel.org/linux-btrfs/20260123125920.4129581-1-naohiro.aota@wdc.com/

Naohiro Aota (1):
  btrfs: tests: zoned: add selftest for zoned code

 fs/btrfs/Makefile            |   4 +
 fs/btrfs/tests/btrfs-tests.c |   3 +
 fs/btrfs/tests/btrfs-tests.h |   8 +
 fs/btrfs/tests/zoned-tests.c | 676 +++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.c             |   3 +
 5 files changed, 694 insertions(+)
 create mode 100644 fs/btrfs/tests/zoned-tests.c

-- 
2.53.0


