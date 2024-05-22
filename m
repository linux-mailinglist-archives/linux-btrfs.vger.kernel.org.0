Return-Path: <linux-btrfs+bounces-5192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E13ED8CBAEF
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 08:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0361C2198E
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 06:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB9979949;
	Wed, 22 May 2024 06:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UMTgQbS4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F90578C8F
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 06:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357834; cv=none; b=MuU0+c82Z4qKnHzIg7ogwrXiIBRh3LW2hGTGxMWJZJ/wYaHh421glPcSMPn3X4Jq4u1dn6sQdgG56IjV7T8+47QmStC4NFhulrQfwtG4xLPe7js8DHe2EA1eOY4YqHbTneoxFt/TbT2D3pvU/xCvjus/Ae0a8Llf3x/QH9XHDn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357834; c=relaxed/simple;
	bh=gvRqCmH3sPkyvRq89KJhIgW3RDMLvYt3mUEUvK97J78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaLByRMS2KvM4wKlO1xD3pnO4ELniXA6lFLg/1nVMgk8WgLG77y6uyJdRZgjBN8TpnwuNq6TZhIKiZeO6UvIA3sML+LdT62Qw9FqKdovmDP1NJe5M9T2Rz/cbwqhYBXMh/Wl0U96xYxjsDJehVJ2mGDEwd4eN1qpP6uvR1tn4Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UMTgQbS4; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716357832; x=1747893832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gvRqCmH3sPkyvRq89KJhIgW3RDMLvYt3mUEUvK97J78=;
  b=UMTgQbS4aDLPnvTPlgBiI9kw1B15fTqP/xNbVhsLWZTDpoYrmwHJMEhU
   iywVpFcjLEoLoUYifKwh+Og701H7nAqvOBo52tBf98K2NheZAw7T2RMug
   9YWJlz98+qWIcZzY9CCv1kye2LGIIQ7d1zDXpEuxGIigyyzplobD4ZWkE
   6s3J9TeCsGPcg8Xke0Gs8pYPwPQxuXjR/csA6PyJV4rx1WHvV6fE2wnRj
   wcn029rsoPCxPqUnDVwr8+oDbk9fIK4etfVhuUpgxp3sNnBMyQMX+uI4P
   nv6iqMwAjlfdbIDcEVwqRAw3/woHDCDOF6Dy4XGVVQ6UQ7J1nAjwraBeS
   w==;
X-CSE-ConnectionGUID: EhN8pg/QRkm6xWUrTmSmPQ==
X-CSE-MsgGUID: v4XhL6YpSbComrinYBBi3Q==
X-IronPort-AV: E=Sophos;i="6.08,179,1712592000"; 
   d="scan'208";a="17170976"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2024 14:03:43 +0800
IronPort-SDR: 664d7d24_Wkbi7Ap5AEkfWkuvqsZ1qwgwWJ2pBwdC09zwiv/ghdooGSe
 j7A24f8zo6Wd4O5MP3CB6xU/KoirdskmQQUswpA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 May 2024 22:05:40 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.60])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 May 2024 23:03:44 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 07/10] btrfs-progs: test: add nullb setup functions
Date: Wed, 22 May 2024 15:02:29 +0900
Message-ID: <20240522060232.3569226-8-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522060232.3569226-1-naohiro.aota@wdc.com>
References: <20240522060232.3569226-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions to setup, create and remove nullb devices.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/common | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tests/common b/tests/common
index 1f880adead6d..ef9fcd32870a 100644
--- a/tests/common
+++ b/tests/common
@@ -882,6 +882,69 @@ cond_wait_for_loopdevs() {
 	fi
 }
 
+# prepare environment for nullb devices, set up the following variables
+# - nullb_count -- number of desired devices
+# - nullb_size -- size of the devices
+# - nullb_zone_size -- zone size of the devices
+# - nullb_devs  -- array containing paths to all devices (after prepare is called)
+#
+# $1: number of nullb devices to be set up
+# $2: size of the devices
+# $3: zone size of the devices
+setup_nullbdevs()
+{
+	if [ "$#" -lt 3 ]; then
+		_fail "setup_nullbdevs <number of device> <size> <zone size>"
+	fi
+
+	setup_root_helper
+	local nullb="${TEST_TOP}/nullb"
+
+	run_mayfail $SUDO_HELPER "${nullb}" setup
+	if [ $? != 0 ]; then
+		_not_run "cannot setup nullb environment for zoned devices"
+	fi
+
+	nullb_count="$1"
+	nullb_size="$2"
+	nullb_zone_size="$3"
+	declare -a nullb_devs
+}
+
+# create all nullb devices from a given nullb environment
+prepare_nullbdevs()
+{
+	setup_root_helper
+	local nullb="${TEST_TOP}/nullb"
+
+	# Record any other pre-existing devices in case creation fails
+	run_check $SUDO_HELPER "${nullb}" ls
+
+	for i in `seq ${nullb_count}`; do
+		# Last line has the name of the device node path
+		out=$(run_check_stdout $SUDO_HELPER "${nullb}" create -s "${nullb_size}" -z "${nullb_zone_size}")
+		if [ $? != 0 ]; then
+			_fail "cannot create nullb zoned device $i"
+		fi
+		dev=$(echo "${out}" | tail -n 1)
+		nullb_devs[$i]=${dev}
+	done
+
+	run_check $SUDO_HELPER "${nullb}" ls
+}
+
+# remove nullb devices
+cleanup_nullbdevs()
+{
+	setup_root_helper
+	local nullb="${TEST_TOP}/nullb"
+
+	for dev in ${nullb_devs[@]}; do
+		name=$(basename ${dev})
+		run_check $SUDO_HELPER "${nullb}" rm "${name}"
+	done
+}
+
 init_env()
 {
 	TEST_MNT="${TEST_MNT:-$TEST_TOP/mnt}"
-- 
2.45.1


