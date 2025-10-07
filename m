Return-Path: <linux-btrfs+bounces-17514-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C381BC16C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 14:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645CD1897FEB
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 12:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ADE2E03E8;
	Tue,  7 Oct 2025 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jWQS0WFN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950542DFA21;
	Tue,  7 Oct 2025 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841890; cv=none; b=eHOhfQwV8jULSCUVWRWR4JJR06SBRjHbfUzZwZcwOJf+06Gb69SQMUDXYnpW633np4/15P50nEkyLjWFwyo9c418bcYj3bLrSghjb1CIRWkGzP/t0NITSix3HwyRxsGh2WPaIWJMjzegClaNItpynX7qqzm+amCZwp4dgHeOJvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841890; c=relaxed/simple;
	bh=bPAkmy4CZ7P8vGb6ZqOQ1RQIYe2VPFhJGhaoMcBCR74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dioRIgmTD1oWb8lm0dhs9cZAsnEoc1NVQ8kTHoongbxD/eduYfUWUOtqWANgSJE+h+RuBy2YN2UxpnrwQ0DXzpCDoMptfaQbvArt/ypAdfLhvgCR1P4PUWA0/7EphpG7k4oscK6yip2CnapYdk3vs71G5XybkGNK6ygHURMErPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jWQS0WFN; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759841888; x=1791377888;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bPAkmy4CZ7P8vGb6ZqOQ1RQIYe2VPFhJGhaoMcBCR74=;
  b=jWQS0WFN1/jeVqqF9+kzICfXo0CKtZEj/DX9R/daW1JMo8Y60HESQoN0
   gJL1ArH3J2DpOtzj6uCmPc58lQ1ZkVHD2jfDs/6x7l30EVrZ91V3qOesm
   Q2u91EJHSzZAIPVq7rGF4hreF8EpGOpy6fqlUr908PfkgreSQv4PSmTzb
   laIHSJOcZ47JZ9kHhjqXAmroP35EQYndc9kU2s1KwzHzndnTeZ+dXzczp
   1nxtwYp1h8KiUAptYkc8XFJuskWLI778mnbj1vPVuIjUnaSbh6qNOrsyH
   D3QYA5RACTwkMakh5SLP3tYuJhNCqzx6nIzi7ZjWAV30TXAOvz/K8WqAI
   Q==;
X-CSE-ConnectionGUID: cEowS2JjQMiq3GgjvzdYkg==
X-CSE-MsgGUID: dnLEV6fyTu2VjF1sotXygg==
X-IronPort-AV: E=Sophos;i="6.18,321,1751212800"; 
   d="scan'208";a="132746695"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2025 20:58:07 +0800
IronPort-SDR: 68e50e5f_/VKi5uW20mWkIAVpgmlzkxpGeCZZ5Wh/nG1JBKMY1d6U6i+
 IM61i8s3g+94ZrMqe9JbR1CGiZPzmH3VDfIWU7g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2025 05:58:08 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.183.247])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Oct 2025 05:58:06 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/3] fstests: basic smoke test on zoned loop device
Date: Tue,  7 Oct 2025 14:58:00 +0200
Message-ID: <20251007125803.55797-1-johannes.thumshirn@wdc.com>
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

Changes to v1:
- Add patch 2/3 factoring out creation of a zloop device
- Fix commit description for patch 3/3

Johannes Thumshirn (3):
  common/zoned: add _require_zloop
  common/zoned: add _create_zloop
  generic: basic smoke for filesystems on zoned block devices

 common/zoned          | 31 +++++++++++++++++++++++++++
 tests/generic/772     | 50 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/772.out |  2 ++
 3 files changed, 83 insertions(+)
 create mode 100755 tests/generic/772
 create mode 100644 tests/generic/772.out

-- 
2.51.0


