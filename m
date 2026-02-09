Return-Path: <linux-btrfs+bounces-21548-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMKqGDjziWl+EwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21548-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 15:46:16 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5154110EAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 15:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDFBE30A6790
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 14:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3172222B2;
	Mon,  9 Feb 2026 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Cdbc65xL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85A037A48A
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647882; cv=none; b=UemB+KitiGpGV30XT5tObySexYp41zUgZVfLLDQtAboNaBknhF/2UAMvSy9jMxkoiN5oR+bO42sIOJtBasocSiymy99xaiHXc03TVGEy6L9JR3KE7nrFwxwyRRihPeAIl7EOJVhAYkVqDS7twLlRX9u51Jxd5T+iyIX6cpXu7y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647882; c=relaxed/simple;
	bh=5TtK4QL682SDtoW+nxy7KlLKFZMHHuJSwfsUd1B9bYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uOISGuwLbmdFiWTUTCtgkwSEkz63zEhAybq45NbfDvYTpKMW0+DP3MXm0k/5UGcyiuUL5xYTdxH+kiygK6Q/AJ8UJxkknCrvNwroXK2c3p3WzlDvg2olx/va5MZrw//sRFdUMqPv75GDBoMaK+fP/SpwHonW/jUMn84I1XJJ69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Cdbc65xL; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770647879; x=1802183879;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5TtK4QL682SDtoW+nxy7KlLKFZMHHuJSwfsUd1B9bYo=;
  b=Cdbc65xLlv75GRfK0CANSrHeKIE3A5r0RR8oay8+/1CtY3kiZ4nPW6hY
   8u2LIrPRktcNDut19rzy/WjiemeRDT19PkpmCQbpO3z+ZG1DnLasXJEh6
   1lMrF3S7NkOfRc122s0x71ntlfg3KXppuUL/MyKVYQVZjAcapOZgjRv8y
   kWJpwguqmpz6zjPiOLc9kMB2DlwTGvsYjlF+tZ1raYd/0kAumQxOoRyIR
   2xRSL4pv1fl8eQmBXyO2ukODO2tqbmS3uWEudtgNA7eoGX4IWjXed+C6L
   c4Y96wAdQHh8CyO/9qqNj3T6MQ5cRcovyDwJI+x7ziJJ6OtdtAFR84lHd
   Q==;
X-CSE-ConnectionGUID: os+AiArzQ/q60m7CjtuTOA==
X-CSE-MsgGUID: S4Gfzx5HTNKKuCWkfnNIOA==
X-IronPort-AV: E=Sophos;i="6.21,282,1763395200"; 
   d="scan'208";a="141537540"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2026 22:36:51 +0800
IronPort-SDR: 6989f105_G/n1AnlSz0zL7fZhDUZe2GQn/2eiMNopZTWx4DniF/FxBiE
 8Q1xRzW/uqlIqR0pvAMNJpX/ugwZ6LrfWPshWsw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Feb 2026 06:36:53 -0800
WDCIronportException: Internal
Received: from f170w04lxh.ad.shared (HELO neo.fritz.box) ([10.224.28.114])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Feb 2026 06:36:51 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/3] btrfs: zoned fix two long standing ENOSPC bugs
Date: Mon,  9 Feb 2026 15:36:41 +0100
Message-ID: <20260209143644.96411-1-johannes.thumshirn@wdc.com>
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
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21548-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[wdc.com:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:mid,wdc.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5154110EAD
X-Rspamd-Action: no action

This series fixes two long standing bugs with zoned BTRFS leading to
premature ENOSPC.

Patch 1 caps the amount of metadata reservations to not let
`bytes_may_use + bytes_zone_available` climb beyond a space_info's
capacity.

Patch 2 moves a block-group to the reclaim list, if it cannot be deleted
in btrfs_delete_unused_bgs() because there's still user data left.

Patch 3 adds a new zoned only state to the flush machinery performing
reclaim of block-groups that can be reclaimed.


For all these patches a single reproducer was used (and it can be turned
into a fstest):

```
#!/bin/sh

SCRATCH_DEV="/dev/vdb"
SCRATCH_MNT="/tmp/scratch"
MOUNT_OPTIONS="-o enospc_debug"

mkdir -p $SCRATCH_MNT
mkfs.btrfs -f $SCRATCH_DEV
mount $MOUNT_OPTIONS $SCRATCH_DEV $SCRATCH_MNT

blocks="$(df -TB 1G $SCRATCH_DEV | awk '/btrfs/ { print $3}')"

loops=$(echo "$blocks * 4 - 2" | bc)

for (( i = 0; i < $loops; i++)); do
	dd if=/dev/zero of=$SCRATCH_MNT/test bs=1M count=1024 > /dev/null
	if [ $? -ne 0 ]; then
		break
	fi
done

umount $SCRATCH_DEV
btrfs check $SCRATCH_DEV
```

Johannes Thumshirn (3):
  btrfs: zoned: cap delayed refs metadata reservation to avoid
    overcommit
  btrfs: zoned: move partially zone_unusable block groups to reclaim
    list
  btrfs: zoned: add zone reclaim flush state for DATA space_info

 fs/btrfs/block-group.c | 16 ++++++++++++++++
 fs/btrfs/delayed-ref.c | 26 ++++++++++++++++++++++++++
 fs/btrfs/space-info.c  | 12 ++++++++++++
 fs/btrfs/space-info.h  |  1 +
 fs/btrfs/transaction.c |  7 +++++++
 5 files changed, 62 insertions(+)

-- 
2.53.0


