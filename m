Return-Path: <linux-btrfs+bounces-2420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCDB85620B
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 12:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDA21F26318
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB8912AAF0;
	Thu, 15 Feb 2024 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rAnssaug"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4BF6350A;
	Thu, 15 Feb 2024 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997635; cv=none; b=EL75WUC33d4SclbMDN6IME/lGfiAhYY93eDv57dm3LRpxOetI4X5KmgnCLpz++cHXtOAqCVxJdoURHDqw0ya/Dhf2sxkX0xjgSc6VQZ4aCUIFGdUim7BmRVxcUqXDTsjAgZuvR1rX2lDhPCW3cw7bWIPhY/TIOs27iSIxs4XoYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997635; c=relaxed/simple;
	bh=NHd5FSw4ryCo0Dbbe2nSqZgWMT7UDboXDEwMFKnALeQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KD2M5/szhAjopUETTrwnN+Vv67rHasQHjfTQDWs6glOgc33zyDiD7jryu5PjRmBQBq6dP3MvcSiJ9SidN/yzSmSZOZUURgS3aUCs/brlQMcosqSbLfV06DC4Nsmbyn6MXLd+haTLTEp7igUT9AypFQGBXa8cETouhEXwVQGsXIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rAnssaug; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707997630; x=1739533630;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=NHd5FSw4ryCo0Dbbe2nSqZgWMT7UDboXDEwMFKnALeQ=;
  b=rAnssaugBteClCuQEoo/dU6rDxDYBlN0mNLCcSKGZAdFv8fRIQH0QBRx
   WWz2phqCro/Ublyfy2Nw9y8qIwQVy4rkydUyBxLjrJ80SBg7UP9eH6lXv
   O+TfIEhJypTl4cYcZzKnv4+/wDa0KZOjHx3B+ZINlefX8L2R2BHz9ijSK
   fZjhhXIqDIiGK6GlfnSpvGsuUZi3MOrDZM7qi9QyaYY9HnQgMzrD/g5xm
   FqrhUSUGoDt46vLnbWoM+9Pgp+JgDnS42ERYqO0FeOeuSDdqFvjIg1k/U
   8R6js1BK+oGw00wk5KUidS7ei/NcqDdIeq7DWO7dN8zfuersRDPo7Y6hO
   A==;
X-CSE-ConnectionGUID: uL9wFSJdQSWProPzr7hjgw==
X-CSE-MsgGUID: 1TbV9rFHRDy4bkGHLlL+7A==
X-IronPort-AV: E=Sophos;i="6.06,161,1705334400"; 
   d="scan'208";a="8967189"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2024 19:47:09 +0800
IronPort-SDR: eQfgX6e3adQLrtBJumc7G9zNPDtWhDapHUtOtuoQg8NdRYz17979DiIWHs1wUtlyvLlbqEfCP8
 ka30iH8+WRPA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Feb 2024 02:56:42 -0800
IronPort-SDR: phYpwGTF6vs+yCo+oCelZcmF5rNE8kbO74p7i4UqVkX3h6EVrIAYFGjWAQ8PfwM86xkknCklbA
 fL9fNUIVRhpg==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Feb 2024 03:47:07 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 0/3] fstests: btrfs: add test for zoned balance profile
 conversion bug
Date: Thu, 15 Feb 2024 03:47:03 -0800
Message-Id: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALf5zWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0NT3aTEnMS85FTdtMwKXbOkFHNLS4vUtMQUAyWgjoKiVKAw2LTo2Np
 aAJyNwSFdAAAA
To: Anand Jain <anand.jain@oracle.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Zorro Lang <zlang@redhat.com>, linux-btrfs@vger.kernel.org, 
 fstests@vger.kernel.org, fdmanana@suse.com
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707997627; l=745;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=NHd5FSw4ryCo0Dbbe2nSqZgWMT7UDboXDEwMFKnALeQ=;
 b=ATrxHEpTGOPbuuLQaMenqBImkIvHQFpBCyZW4ASHiSv+5mYbrsu7YHmum+QsPwb9lPe7PM2Wb
 awuEKar70qMD3GQXclaIXWb4Z4mHR4kpTdg4Q1Zb+5O8l4aTGh/5wdb
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Recently we had a report, that a zoned filesystem can be converted to a
RAID although the RAID stripe tree feature was not enabled.

Add a regression test for the fix commit.

---
Johannes Thumshirn (3):
      filter.brtfs: add filter for conversion
      filter.btrfs: add filter for btrfs device add
      fstests: btrfs: check conversion of zoned fileystems

 common/filter.btrfs | 15 ++++++++++++
 tests/btrfs/310     | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/310.out | 12 ++++++++++
 3 files changed, 94 insertions(+)
---
base-commit: 5d761594fc5832d6d940f113b811157e332e14af
change-id: 20240215-balance-fix-6bd7998efad0

Best regards,
-- 
Johannes Thumshirn <johannes.thumshirn@wdc.com>


