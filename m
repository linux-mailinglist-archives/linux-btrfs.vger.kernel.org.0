Return-Path: <linux-btrfs+bounces-16767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7144AB50CFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 07:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528FC5E27CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 05:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DA42BDC0E;
	Wed, 10 Sep 2025 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f/4mjgDj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F8018871F
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 05:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757480676; cv=none; b=PF1ZoES2woyA0bjhINY4dpcEAw5wAR5Pt31ASiRQwNZxCpCcl/oTKaa/ktFRonwYxLbLrA7bKySyMy0zGiD+JJ1Bskd9jaRlo4cl4T7/K1Z5yP1B44NAbrLuSqUWm1H9uip9Ge/4QM45Icof0o/aZlhkmyzE3sLnzvdmjV2FX1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757480676; c=relaxed/simple;
	bh=x6tS6AP77nmBhaWSCFMkk9LoX9oP5pWKboOh9bbsOWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjcmqeZnVA1F/r9wd5vdqoDIY3a1XD0yZLN3PnULw8Hoit7/N8sLT21rFFB2lxjYataCGOPwnKt4hISsTVbgsE/M3/gSkXxoPOfuuV3WrEbtTMyLUuu4lZfmXTlFrS0diFfSxygeUqCl8sQMo+OOGJKBmXaNPa5oMwc669QFPyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=f/4mjgDj; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757480675; x=1789016675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x6tS6AP77nmBhaWSCFMkk9LoX9oP5pWKboOh9bbsOWM=;
  b=f/4mjgDjQxQ/pC8G16ubFy13nlJGy8KPizuWlwnnQyFMGXEwD1d24OnY
   YHTzrmPrQh5bZB87zDJ03Gx6cNBPp0sA0EK/0jUFbOChhGMF/EI3uXtTp
   uURL2l838M8mi+VhOEgZkNRwL0c3fMIRWkLNmaLyjl5L/HEhuqhmc/Xp3
   SC/YKf4Ymy9ArtqX3wbltbAwLGbEa9TM/QBowiT9tucYn8FI33t7dFbHU
   uK624J1uI2bRFGl54qXhT8EGH/011JI/rlY0XMS5i58jyNobgxopWMfiG
   SiGQT+TSQ2b64AI7V2ERl9klGkDDqQQVCvSwTUXuBEU69/E+moStIH3Rj
   g==;
X-CSE-ConnectionGUID: sYlbNSXlT0uaYcKUGDGVmw==
X-CSE-MsgGUID: a8pMIXvSS5CgUHWaRJeADA==
X-IronPort-AV: E=Sophos;i="6.18,253,1751212800"; 
   d="scan'208";a="114170323"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2025 13:04:33 +0800
IronPort-SDR: 68c106e1_yW95i95F0iHvew7ukgjzb+X3mKGHWCsBxmPevJwr0Q7znDk
 Udsondr/6sVgJF9Aj6DKGcpak8g/cQDqjpBzNuA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 22:04:34 -0700
WDCIronportException: Internal
Received: from wdap-vuijzzqtlv.ad.shared (HELO naota-xeon) ([10.224.173.18])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Sep 2025 22:04:33 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/4] btrfs-progs: tests: output error/warn message to stderr
Date: Wed, 10 Sep 2025 14:04:09 +0900
Message-ID: <20250910050412.2138579-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910050412.2138579-1-naohiro.aota@wdc.com>
References: <20250910050412.2138579-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Outputting these messages to stdout can compromise the functions' output.
Instead, output them to stderr to keep the results clean.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/nullb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nullb b/tests/nullb
index 457ae0d8354a..f3cdf9c19e16 100755
--- a/tests/nullb
+++ b/tests/nullb
@@ -34,12 +34,12 @@ SYSFS='/sys/kernel/config/nullb'
 # setup
 
 function _error() {
-	echo "ERROR: $@"
+	echo "ERROR: $@" 1>&2
 	exit 1
 }
 
 function _warn() {
-	echo "WARNING: $@"
+	echo "WARNING: $@" 1>&2
 }
 
 function _msg() {
-- 
2.51.0


