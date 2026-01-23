Return-Path: <linux-btrfs+bounces-20959-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FoxNapsc2mnvgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20959-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 13:42:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7A975EE3
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 13:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D345302FAAF
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jan 2026 12:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B20829BDB4;
	Fri, 23 Jan 2026 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IFp2Ip9Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3E91F4CA9
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Jan 2026 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769172130; cv=none; b=LJZiPR4twZhEjfeVFuiHkUf7i63aouXiOiwt3LAuWG/p3WVpf6DxtNb9fGB/cChMABhqCezoX/gfaRq+sa8EGU+lERoJWmeTOBxmgPl9vOfdKX08bHTu4su3p6c9qBRrdGMYMpxrkadLclXrVcL3eb208JLezpVVel9LUQw24K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769172130; c=relaxed/simple;
	bh=PHgKkyfSopI0fmCzRHlQ+K0xYR97UH/kX4rWtqLwzA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XRlT/FXphutIg6JxiErAfkaxzzMShfx3Mpgb7PaCdllcpG7vv3xhzrtrz+I6O8vfJAW2Pl0C0OUn7xo7DBWS3hVPmQ9irHK3cMbKziMRPTcQixr2/olc47Ku5EONSEr+wemLxN38IB4cC1nKDrkmgTLPE6pWXAD2m4WX0FBZk0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IFp2Ip9Z; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769172128; x=1800708128;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PHgKkyfSopI0fmCzRHlQ+K0xYR97UH/kX4rWtqLwzA4=;
  b=IFp2Ip9ZC+TAWcBTVcAeocp6LLkAhA/oDuqq3UC8KQrlP+CiNiSeOuzr
   ifOmm7vawiz23qbbEs5w/Px1fzN9VGSX5FXqgdK1LymGLjwyFvdD+240W
   /3IwMVbzMl9+jVasiT91y176LOv50TR8td9erZSBxiOxGiIK1j7JO4QeG
   dScS2C7qZE6peyIIiFmTdghgsGV4+9/WooSUnPgr5Umnn+zuzaZFVc/f2
   8fFxrUvNyuMCEnfQQhhbic1DnFUrrM8XzuBzVRgWO10HSD9IyZC7Kd5S+
   /r/byy+thAyDQxIX10ju2Mp137gwKBL5YkaBP77Lx7VReHqGPuMtisFNu
   Q==;
X-CSE-ConnectionGUID: Re8ZuFANR4OTBnVcLuIsJw==
X-CSE-MsgGUID: wuqbco/WTPCNEkxdHHFSbw==
X-IronPort-AV: E=Sophos;i="6.21,248,1763395200"; 
   d="scan'208";a="140524243"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2026 20:42:02 +0800
IronPort-SDR: 69736c9a_VMTo9dgACS6MlGCXAuMbFazvLHgn5KIZoKmZciC9boSybT4
 wgh/5EKIM/aKI8UphdhWj1J87RR6KyDA6q8u3NA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2026 04:42:03 -0800
WDCIronportException: Internal
Received: from 5cg2075g8f.ad.shared (HELO naota-xeon) ([10.224.105.93])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jan 2026 04:42:02 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/2] fixup last alloc pointer after extent removal
Date: Fri, 23 Jan 2026 21:41:34 +0900
Message-ID: <20260123124136.4110463-1-naohiro.aota@wdc.com>
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
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20959-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naohiro.aota@wdc.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:mid,wdc.com:dkim]
X-Rspamd-Queue-Id: 2E7A975EE3
X-Rspamd-Action: no action

This series is a follow up of a previous fix patch [1], and also
addresses the same isssue as patch [2].

[1] https://lore.kernel.org/linux-btrfs/20251217111404.670866-1-naohiro.aota@wdc.com/
[2] https://lore.kernel.org/linux-btrfs/20260123081404.473948-1-johannes.thumshirn@wdc.com/

When a block group is composed of a sequential write zone and a conventional
zone, we recover the (pseudo) write pointer of the conventional zone using the
end of the last allocated position.

However, if the last extent in a block group is removed, the last extent
position will be smaller than the other real write pointer position. Then, that
will cause an error due to mismatch of the write pointers.

We can fixup this case by moving the alloc_offset to the corresponding write
pointer position.

Note that, while this series is complex (especially, the second patch)
is complex, it passed a selftest which will be added in a following
patch series.

Naohiro Aota (2):
  btrfs: zoned: fixup last alloc pointer after extent removal for DUP
  btrfs: zoned: fixup last alloc pointer after extent removal for
    RAID0/10

 fs/btrfs/zoned.c | 197 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 182 insertions(+), 15 deletions(-)

-- 
2.52.0


