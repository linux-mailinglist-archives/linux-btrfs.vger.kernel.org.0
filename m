Return-Path: <linux-btrfs+bounces-22150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJfqG9mhpWmuCAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22150-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 15:42:33 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE65A1DB0E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 15:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C04323042999
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 14:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909693FFAB6;
	Mon,  2 Mar 2026 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lbJdy1+L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739633FFACC
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462394; cv=none; b=SJ1k/TwYs0DkORHoz5ksQiGkyAVTb/IZ8M98z5zK61j+LPnZuvlWhm/UA3U21nl7C+z62nxPinYDmng+k1nv+Xw7J1V9jd+Z11djYN1kuTpE1feuZRbvyLSlTKEHpdd+1VVjzO7yaZPhmJvltctJB7atLAwOL9YFUjlcDSL1oK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462394; c=relaxed/simple;
	bh=nroQfOqToxw5uCS4QFjyQzaDvOUMCvUacRmQnE0CgtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uOyrOSQfrvVpLOvPcla4xtwP82oUtRYInIO1/auQc16CKz43xnpL/W/eAnxnVM2DSgWNPVQ2Cjj/L37Gl2Prl20ykoRwJU3s9qMmdkI/Fs0xeiaVnwuP5KzJ4xhRC0LTIaiaMwN6Fr1zQnPs4IEc+oIRMhA5iyi0xw+1aqbgwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lbJdy1+L; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772462392; x=1803998392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nroQfOqToxw5uCS4QFjyQzaDvOUMCvUacRmQnE0CgtE=;
  b=lbJdy1+LiHZRodLGsQCuAK7lUp/SXGHFOK6tE4EDeVkF2mePAsVxwbM5
   hOHty7qlmSp+ogxpcElWAM4Wttr5bDvqA7r3xs8+S250sOnif3TNVLZQN
   b5tHz6SY+5+lupV0bz/A5SWFRaRbiOo0HbbCkuQl2S/CPOukfEM1UKZ/g
   406jafss6K2182VLq6KNsvvoVQqvzkVRm3n4yBlydU/vCUJmwOfr4cAV8
   qVq8N2sR81g2y+JBzvEmMdpKRw7R3Lv1LkUH8xCgqByWdwy/JwGdJ2zaT
   eilfwQ6abgUDrDWfXLhJ667NsrHWYY9xot4vP+mK4kIB240rik0TB5wFd
   w==;
X-CSE-ConnectionGUID: AbfcZ0r7QJeA7i6JPGX0gw==
X-CSE-MsgGUID: Tp9AWZmaTKmNMO4SUahVIg==
X-IronPort-AV: E=Sophos;i="6.21,320,1763395200"; 
   d="scan'208";a="141343843"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2026 22:39:46 +0800
IronPort-SDR: 69a5a132_yY3cQGqKIRJGC7i7btqKzDXIC70rkmhyhVnd/M1HC79se//
 JjNwRRJntB2Zm81u+h8BvqeVKsqkaKUPIHSQxNA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2026 06:39:46 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.176])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Mar 2026 06:39:44 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/3] btrfs: zoned: fix hang with generic/551
Date: Mon,  2 Mar 2026 15:39:39 +0100
Message-ID: <20260302143942.115619-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DE65A1DB0E2
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22150-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,wdc.com:dkim,wdc.com:mid]
X-Rspamd-Action: no action

Running fstests generic/551 multiple times in a row reproduces a hang with
zoned btrfs.

This hang can be caused by long reclaim sweeps und system preassure and
then flushing the block-group reclaim work. Mitigate this issue in two
steps:

* First create a syncronously executable version of
  btrfs_reclaim_bgs_work() in patch 2/3

* Change this synchronous version to accept a limit parameter, so we don't
  run it off for too long and then call btrfs_reclaim_block_groups() with
  a limit of 5 block-groups (this limit was arbitrarily chosen), this is
  done in patch 3/3.

* Patch 1/3 is a small refactor of btrfs_reclaim_bgs_work() extracting the
  reclaim of a single block-group into its own function, to make it a bit
  more readable.

Johannes Thumshirn (3):
  btrfs: move reclaiming of a single block group into its own function
  btrfs: create btrfs_reclaim_block_groups()
  btrfs: zoned: limit number of zones reclaimed in flush_space

 fs/btrfs/block-group.c | 272 ++++++++++++++++++++++-------------------
 fs/btrfs/block-group.h |   1 +
 fs/btrfs/space-info.c  |   3 +-
 3 files changed, 148 insertions(+), 128 deletions(-)

-- 
2.53.0


