Return-Path: <linux-btrfs+bounces-10187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A62149EA936
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 08:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047DE284331
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 07:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8609222CBF4;
	Tue, 10 Dec 2024 07:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HHqYEDEO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEBD12BF02;
	Tue, 10 Dec 2024 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733814202; cv=none; b=X8aIoF6EKHF7mU8dPKQv+D/2AuOBPn8dCbA0SmQysE7gjM+j6ArFZxQpFRiZ0PUl/PtTu0fq5sLHlnjZl1skjNcWucwLjFMbbIjGXasYxr8bZ66T6kemsv2bfp4v+8itaGzPplANrI4mQLRX0v9NFIuup1yxyQ6nvHi3Z/u7/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733814202; c=relaxed/simple;
	bh=yec0SRkKHXC2fytoy58vG1exzqZjYAvzc7NIbtcE0XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQIS7bioIoYWnyhLaPj7IV9gMtMXqRgx8erRDYiBUGEC9rwisyKfimoJmgbVld37HUq87VHGbgkU4UNmKT3BzwsmFse95AHi/rRcipkmbPxSWjOAQhMyzjgeYQMWL0nazrNkq51pef7HtY8Z5t4XEFgnVgtuslHaalpH1qRWEEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HHqYEDEO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BjGfxialA2a5mWgG4RUZNeJe5MaOPl5EONhAim6GN7Q=; b=HHqYEDEOCbkfo4OQ5kcIl+0kHW
	P/bKjAC8JcE2eASHVSUJjShz6JUDC3qROBDJBfp9TvuOD/2GbR1Oo9bDaRkskfsfQQYXKtCY9sa4y
	B+zkVpYXtVNTnAaeinpUjWshdlyeRV+gDztOtrQKz5YYR7GFYYCy2r5+dMQjvXKVC+9PfkKUkdMtM
	Mop5zTAKH+9LuVPEcBfzKpqmpx4RESvlEu+RaKsrkwmzW0DL7xmmp7Btonb7sDc81Lk5K7LbsUbYP
	1/hStoZPxu9WCHb9OcOr/PiZDvgGIrBjUOHFHapUbW5FohalqEoZ5NxKl+oI2l8QRVt3ka5yvw/D0
	77N/EGkg==;
Received: from 2a02-8389-2341-5b80-e2a6-542f-4e27-82ec.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e2a6:542f:4e27:82ec] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKuHA-0000000AUtg-23NT;
	Tue, 10 Dec 2024 07:03:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH] common: loop device work on zoned file systems
Date: Tue, 10 Dec 2024 08:03:11 +0100
Message-ID: <20241210070314.1235636-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210070314.1235636-1-hch@lst.de>
References: <20241210070314.1235636-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Remove the call to _require_non_zoned_device from _require_loop because
there is nothing that prevents loop device to work on file systems on
zoned devices.  But loop devices are not supported directly on top of
zoned block devices, so add a _require_non_zoned_device to generic/563
to not run that test on zoned block devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/rc         | 3 ---
 tests/generic/563 | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index b3ea55a7fb5c..5ef5038a6d23 100644
--- a/common/rc
+++ b/common/rc
@@ -2269,9 +2269,6 @@ _require_loop()
     else
 	_notrun "This test requires loopback device support"
     fi
-
-    # loop device does not handle zone information
-    _require_non_zoned_device ${TEST_DEV}
 }
 
 # this test requires kernel support for a secondary filesystem
diff --git a/tests/generic/563 b/tests/generic/563
index 2056470df825..95a928fba562 100755
--- a/tests/generic/563
+++ b/tests/generic/563
@@ -38,6 +38,10 @@ _require_loop
 # cgroup v2 writeback is only support on block devices so far
 _require_block_device $SCRATCH_DEV
 
+# this test creates a loop device on the scratch block device, which is not
+# supported on zoned devices
+_require_non_zoned_device ${SCRATCH_DEV}
+
 cgdir=$CGROUP2_PATH
 iosize=$((1024 * 1024 * 8))
 
-- 
2.45.2


