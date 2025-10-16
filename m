Return-Path: <linux-btrfs+bounces-17890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90F6BE4321
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 17:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A3E427BDC
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39C234573D;
	Thu, 16 Oct 2025 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mk6qCHg+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5D32DF6E6;
	Thu, 16 Oct 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628042; cv=none; b=WROk3+iowaBlfSX8ZscFMis7jpsPv/B/Ba3GSDxvJQ9c+Z7s5WCB5RmnRTtm+pOR7sEQZL1285KcvXo5JdvigezdgrsIgR2j8DQjx1lST4GBl2VFrVqbzzRKIrGyIrdXz+QqecXdAE5e4ZWco8Ms1c23s/M6qcZI76ZllpUjTnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628042; c=relaxed/simple;
	bh=XLQDR+sCfZaZG59gmf6RoAAM8IPdatxdmZLU82p7m2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WYZyI//6bAX9teVbrNibgxfb8O7S+tsgayr3kHIcb/jn5oSG42/AXXPrt44NWglK9IOtYiwC0kdut3Uk/cR15a+KX8ICdHELp7dDJOlIXi9vntcQ1SE+afhmzq9P9WiroY/SxR/nx3LoEyrBWLbVBl1bzO2ODpjywpQw1ZK8esc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mk6qCHg+; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760628040; x=1792164040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XLQDR+sCfZaZG59gmf6RoAAM8IPdatxdmZLU82p7m2A=;
  b=mk6qCHg+CbRpFiH/5pAztfXRbff9VdSTIgRPHvItBhLcHixP8ECIqjyS
   D877OjzYYHEnIyN1pceDoOFyaOtp3ovGqw1QgQMcxpIuKh/eqMU+PuYZI
   AWB0qed+9eUfhT1YLoOh1i2OA2H1yWrBRa72wgF2tvjhv/mqN/41Msz0k
   PUGfH5tG6WiaYSbOju7FmoM89k/vzM3TO8uc52tGih34rnw4sM0PMWQoZ
   i9VtXeNYOdflufTALNlvNktMloPIlfT04EVmOyToFAVwpWfzXqocVjWrj
   j4vuqPeJsVLJDDsMfEKZP6+IF2Tq63FdWu5pC+kjl7kybrDch8yZqhi1u
   w==;
X-CSE-ConnectionGUID: F1WG1Bh6QLu/2rg8k8H1vg==
X-CSE-MsgGUID: s4XIg347TQifstIQtDFQAw==
X-IronPort-AV: E=Sophos;i="6.19,234,1754928000"; 
   d="scan'208";a="134589295"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2025 23:20:39 +0800
IronPort-SDR: 68f10d47_0c5eFRCxi8DGV+rNwXaI4ftU+2jw0VubaRAgfQnUwuTMg3l
 EYpzLQz27sZx2Bjx8id3Tehv1tNi/m2wps6S7+w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2025 08:20:39 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.40])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Oct 2025 08:20:35 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 0/3] fstests: basic smoke test on zoned loop device
Date: Thu, 16 Oct 2025 17:20:29 +0200
Message-ID: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a very basic smoke test on a zoned loopback device to check that noone is
accidentially breaking support for zoned block devices in filesystems that
support these.

Currently this includes btrfs, f2fs and xfs.

Changes to v4:
- Find next free id in _create_zloop
- Add _destroy_zloop
- Fix typo in _create_zloop documentation
- Redirect mkfs error to seqres.full

Changes to v3:
- Don't mkdir zloop_base in test but in _create_zloop
- Add Christoph's Reviewed-by in 1/3

Changes to v2:
- Add Carlos' Reviewed-bys
- Add a _find_last_zloop() helper

Johannes Thumshirn (3):
  common/zoned: add _require_zloop
  common/zoned: add helpers for creation and teardown of zloop devices
  generic: basic smoke for filesystems on zoned block devices

 common/zoned          | 60 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/772     | 43 +++++++++++++++++++++++++++++++
 tests/generic/772.out |  2 ++
 3 files changed, 105 insertions(+)
 create mode 100755 tests/generic/772
 create mode 100644 tests/generic/772.out

-- 
2.51.0


