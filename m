Return-Path: <linux-btrfs+bounces-16766-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D5B50CF9
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 07:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760BD468654
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 05:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6456724BBF0;
	Wed, 10 Sep 2025 05:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kAakyLf0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE371DDDD
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 05:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757480675; cv=none; b=J7vRvkFU4oA3ybiPMYJqpXn7jG7Bx+XC5LYU4eEDiXfonuPVHCiTNeEJsSSv2ERKKG1Px/rd4kOuzP7447PtQnBnv+PEVeEFrrb2GJBw0FmOCfiaGM4GdTAY12jFFzTe6YYuyIKq/NqWwh0swsZwcM+pyJ75LA+jCXvHCBhM5t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757480675; c=relaxed/simple;
	bh=8DrSz96IQLCQIDuKELZksY6vIAKc7Rrkfc6R4XUsYIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5Wg++5onQdgTFcpQrJYGJPPkVIxafPRJDB9wpQnzjaBPazcsKUses/ohZvlJQKuvxr51cTIi8rrC832qo/uw5PKAsaUew3KskSa72qPvMf0LesTAHfyE8ktD9v2u7ReuDurd4jfTSBGBg9ksSG4NUQ+6YnmEWiXY3i8som5cAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kAakyLf0; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757480673; x=1789016673;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8DrSz96IQLCQIDuKELZksY6vIAKc7Rrkfc6R4XUsYIk=;
  b=kAakyLf0Vdj8YEESyVnQaqQMHdWI3FqAt7exXsNzQ3SzjXg+wLrmGYIo
   rRApwUVsaIvEeuaP8rVM45Udzh9VkFXhWcF/ek8G9CbFwn0z/sYgA3SmT
   WTnkfl9ilZnTvk2do5RxDA2hcV7jb2NksEE4VwcJ84bujHh3450IqO/zu
   JvzouaHFPVAtx80BTVE2K317kds0cidLpFBKzspZw8WC36T63b/9qhXjY
   QpEdyaOXhr7+As+7Et2+5LwNaW//eGAIPIwkvVHDnYQYI7+A022+nPeXl
   RH5GQSJzEWDbwMz7dPjVA4BU3meZzU/v+RtNtqrXqHjF1eSltf/fduJ8Y
   Q==;
X-CSE-ConnectionGUID: Tgob1N6TQUife6e0kJDPJA==
X-CSE-MsgGUID: wW5rjz4QRZ6g6lLIvBqMIg==
X-IronPort-AV: E=Sophos;i="6.18,253,1751212800"; 
   d="scan'208";a="114170310"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2025 13:04:32 +0800
IronPort-SDR: 68c106e1_jJs9rqDolJ5sW8bwkTxe0tUnonPGl7WkoVq69HVC6X+tGmY
 gCTDIf+VVTYismt+IwKdemb4Xh0e8POsYE1f3AQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 22:04:33 -0700
WDCIronportException: Internal
Received: from wdap-vuijzzqtlv.ad.shared (HELO naota-xeon) ([10.224.173.18])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 22:04:32 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/4] btrfs-progs: tests: add new mkfs test for zoned device
Date: Wed, 10 Sep 2025 14:04:08 +0900
Message-ID: <20250910050412.2138579-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a new mkfs test for zoned device. The test is based on
mkfs-tests/001-basic-profiles, but uses nullb devices instead of loop
devices, to set a zoned profile.

Two preparation patches are necessaly for the test case. The first and
second one fix the error handling of _find_free_index(). And, the third
one adds wait_for_nullbdevs like the loop device's counterpart.

Changes:
- v2
  - Refine error/warn helpers not to print the message to stdout.
  - Drop cond_wait_for_nullbdevs.
  - Check if btrfs-progs is build with EXPERIMENTAL in the test.


Naohiro Aota (4):
  btrfs-progs: tests: output error/warn message to stderr
  btrfs-progs: tests: check nullb index for the error case
  btrfs-progs: tests: add wait_for_nullbdevs
  btrfs-progs: tests: add new mkfs test for zoned device

 tests/common                                |  8 ++
 tests/mkfs-tests/039-zoned-profiles/test.sh | 98 +++++++++++++++++++++
 tests/nullb                                 |  7 +-
 3 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100755 tests/mkfs-tests/039-zoned-profiles/test.sh

--
2.51.0


