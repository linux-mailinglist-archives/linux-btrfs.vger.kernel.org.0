Return-Path: <linux-btrfs+bounces-17460-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7F0BBE2EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 15:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A92D18985C5
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 13:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4A22D0C80;
	Mon,  6 Oct 2025 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M0uX6mgj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDB52C3271;
	Mon,  6 Oct 2025 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759757180; cv=none; b=jf2YaUsbtIQmdaIshhmyd50C7bWlR4SUx0aw4BSUHbs4rbhx0qKLUV2XGqiuFHwj9cIY5ZutLO9WFfQJoeljQ1uirlcMlokkqVO7RSq/33Sh5EGf++IOA3FxjwnlY0XMX0Fgt6303w2hq4JGx9CiellHuzOGquA0epmztrscirw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759757180; c=relaxed/simple;
	bh=gbjTY/tmT9IB4E1uyn3TNX0KGzzsleZIO8vCB/ET5lY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbaTyG5XkP8p6RYcjB6KFFoX4hk4fTIaPxLGLbp3sQ1+VcSBrjNixQByjDnRQuPVyuBnvl3SSzKXVa7w8OV8a5enViWFHBIYrFB3eyG6+53gArezZ9r4M4HHn0hhQkKcB06GQOJ+eXak/5fwpYzKwjR5IIw4h7iYivAc99HoOSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=M0uX6mgj; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759757178; x=1791293178;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gbjTY/tmT9IB4E1uyn3TNX0KGzzsleZIO8vCB/ET5lY=;
  b=M0uX6mgjhIVkotk+/vDJd+yCdyBdhlXfkep79OwGEm6ITmZHB+GcJ5BK
   3UkyGuLLa02xj/iAHQ/GWF5CF8GGN9yZVht5awZTSI/IVdUQ65cbbgl/Y
   HG+sH8szALW4olh6iF2dEi7VQ0cbJ7IAozM4R6LXwXrMh83yoPaLUqttS
   SpzV010ywjwwgIOaP6GSDL+YkXBGaHcjW5FqS4HZVgCfMfEwHdA/tkz41
   CmXV+jHWmyo0uvKWwcPM+es2q6496H0z/UcCTOfXJalgmXyZhGT4Whoro
   bFxqBW6cVDZ9ZYoBXQlyYEAUnAEW4AfIgr9QkQgjvlfg5yYVvZwe/Orkm
   A==;
X-CSE-ConnectionGUID: chnLiNJMSMm4LLurQqLOFQ==
X-CSE-MsgGUID: zON17BiTQbGYc9CeLJEipg==
X-IronPort-AV: E=Sophos;i="6.18,319,1751212800"; 
   d="scan'208";a="133893162"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2025 21:25:00 +0800
IronPort-SDR: 68e3c32c_yy0R7epx853VNI0lJOTgyxrPbTqJPz03D18ZBPNylWpsBdM
 9xvwD3VJfdaLuDG2kTmttegGjVM0goP7c35O+8g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2025 06:25:00 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.183.246])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Oct 2025 06:24:58 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/2] fstests: basic smoke test on zoned loop device
Date: Mon,  6 Oct 2025 15:24:53 +0200
Message-ID: <20251006132455.140149-1-johannes.thumshirn@wdc.com>
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

Johannes Thumshirn (2):
  common/zoned: add _require_zloop
  generic: basic smoke for filesystems on zoned block devices

 common/zoned          |  8 +++++++
 tests/generic/772     | 53 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/772.out |  2 ++
 3 files changed, 63 insertions(+)
 create mode 100755 tests/generic/772
 create mode 100644 tests/generic/772.out

-- 
2.51.0


