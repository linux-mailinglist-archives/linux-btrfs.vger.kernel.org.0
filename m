Return-Path: <linux-btrfs+bounces-21594-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YARCLNEQi2l/PQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21594-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:04:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 124F2119F75
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48D1E3060297
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8A023DEB6;
	Tue, 10 Feb 2026 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oqEX8uuz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E312C21F3
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770721470; cv=none; b=pW/K40ShOpuRpnvbE7mtnfocywlrE3z1IQxq1W1tiD2KTuVESq5ByBpgchyAyWUN7iVThOMm1FqKDirg3Drn19T7g8biDD5rNaGsk/gDQbwZ6aGRwiAIXkahOgFtNJlWGY+Z6s8+OgN+8G+165sHaQ71BLnOkmhmCLhyj1Qc2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770721470; c=relaxed/simple;
	bh=1KqEgguEb80KmamZHO7waIjmWQIj0hCobg7gulbUpt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OaFOdMsgKQghiwyXm6N4EuAVYKEHccJA6t82BNakoxGWNyhRDCMxXlLdKyeNMigt2E4dOW1OAht7yzWtD6EPOl8P6ss0rvvk+d1Yyq4JC2IeKOltbIcbHzap2IZrlx3csz6jOg/GQFueTLxsMng2wn1EE/5MRLCPRRdKnoqoc3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oqEX8uuz; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770721467; x=1802257467;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1KqEgguEb80KmamZHO7waIjmWQIj0hCobg7gulbUpt0=;
  b=oqEX8uuzphMgWBSV75YeRMUWpjWO4f7WOZfi/dNwthRFD8zb9cRAr6X6
   +lQfEdyFCNp5tdZ1AdaLNnmbbsZCYFI3czgaNWGCVqqw6B331OHXBZUCh
   yyymeUt/RbAWx+XOZ8Q8KEJsAZqCDk1diIybhUzbTsEbRTG0/V2rI+WEa
   41kyGXiiJ70msq8MAxrz29buCjHE0rFUD6ew/rXk8N7z60nLPOihTdMeE
   Ee4q1dlH6bobMZncp7AS4nTIJgprWSEkT10OuVmA4Fbaj+KFscsnTAoJT
   cOwBsfwiYHVcwtO/19eNEUwaL0aPJLGDhzo8x75kz6NO/0rM5QS7uclRD
   A==;
X-CSE-ConnectionGUID: tpBt2UWkRYGui5KrzVyKeg==
X-CSE-MsgGUID: uQTlKWWNTSaLSJYrJCgPKQ==
X-IronPort-AV: E=Sophos;i="6.21,283,1763395200"; 
   d="scan'208";a="136948394"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2026 19:04:27 +0800
IronPort-SDR: 698b10bc_kuXKGa6qb44CkLBDGaNNgh9Xgj0HYTZNXzJUEspGjngbuCm
 1hae3Ba7rbBrxmV7wRt8EUsHdaTT2V3ZhrlbLbg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2026 03:04:29 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.118])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Feb 2026 03:04:25 -0800
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
Subject: [PATCH v3 0/3] btrfs: zoned fix two long standing ENOSPC bugs
Date: Tue, 10 Feb 2026 12:04:20 +0100
Message-ID: <20260210110423.264476-1-johannes.thumshirn@wdc.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21594-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:mid,wdc.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 124F2119F75
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

Changes to v2:
- Refine locking in 1/3
- Add Filipe's R-b to 2/3 and 3/3

Link to v2:
https://lore.kernel.org/linux-btrfs/20260210073309.195274-1-johannes.thumshirn@wdc.com/

Changes to v1:
- Don't pass block_rsv to btrfs_zoned_cap_metadata_reservation()
- Hold space_info->lock in btrfs_zoned_cap_metadata_reservation()
- Don't divide by 2 but use '>> 1'
- ASSERT() the -EAGAIN return of btrfs_delayed_refs_rsv_refill() only happens on zoned
- Call btrfs_mark_bg_to_reclaim() after unlocking
- Fix comment in 2/3
- Add description of RECLAIM_ZONES flush state
- Reflow 'ret' assignment in RECLAIM_ZONES flush state

Link to v1:
https://lore.kernel.org/linux-btrfs/20260209143644.96411-1-johannes.thumshirn@wdc.com/


Johannes Thumshirn (3):
  btrfs: zoned: cap delayed refs metadata reservation to avoid
    overcommit
  btrfs: zoned: move partially zone_unusable block groups to reclaim
    list
  btrfs: zoned: add zone reclaim flush state for DATA space_info

 fs/btrfs/block-group.c | 18 ++++++++++++++++++
 fs/btrfs/delayed-ref.c | 28 ++++++++++++++++++++++++++++
 fs/btrfs/space-info.c  | 22 ++++++++++++++++++++++
 fs/btrfs/space-info.h  |  1 +
 fs/btrfs/transaction.c |  8 ++++++++
 5 files changed, 77 insertions(+)

-- 
2.53.0


