Return-Path: <linux-btrfs+bounces-5343-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE348D2DE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 09:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFE61F23F63
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 07:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE67167D90;
	Wed, 29 May 2024 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d8hE3jeh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E76167277
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966823; cv=none; b=dyEaUD0T8fwDqf88wp3ejWQMD7StPEiAUd1t8tfFguOgKEW5xW3zZ8s+83gt53pwZpmimnZABzzYHiVuKVwF0sfJp9XWUETzTvfFxGZZhXDiWVJRpsRN+7lmQZYo0S36qJc4WHJRsiB2/PgmOeH7xUwxqfI59zY4ehGp84yFw0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966823; c=relaxed/simple;
	bh=R5LFSscyGt2HluMB4dxYPjK2W3lAzmiVBUiX9O/gb1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BApbYtmx3YCGD+5GtkhjX0+BAFU60yxnXPUE6vezz/42ulFeAn9wGvnkk24wv164dx6g0jgciiI/csUl902qq6TUgjfFa0wkd5eFL8LqtP6WSHxcp10BcpCUSQ+23kmNnfiJcbHCaCJVDvp2k/8Uz7vVbAm5VwCNc2tuCGF88wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d8hE3jeh; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716966822; x=1748502822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R5LFSscyGt2HluMB4dxYPjK2W3lAzmiVBUiX9O/gb1k=;
  b=d8hE3jehSpANZl6q4fzlPejZhQGbRnb3BbUUGYxIHsuVJZ2wJGFd1MpB
   yaZYmyN+pif4EXdGc7ApDsB5clwrjj52WYoEEKgkXfTvPDO8vgple9elw
   m1JYKWf8Xnpi//sse/0dHn1VWxrWgcQf6mKqBRBY+cm/g4c57HrLcbrw1
   Dx4faQZqTZxGV3YGzLrZvxeTDn1/YzdTeCC2Q9i2Dif91Nna8LfUtasuo
   02vlpTUA8MJKzMm1dt+ffR0yFX4Ow71BgsdQaSxx/pbgeAhKRD8R4Erj+
   So/iubWkKr2q2zUPf535sdG4olRXpml30CssNqTvQBU8j5Hfd43eObBxK
   w==;
X-CSE-ConnectionGUID: EzTfoKG/Q76b4wROqZBcvg==
X-CSE-MsgGUID: cMVZnTvkQMaYrXJi55NxOA==
X-IronPort-AV: E=Sophos;i="6.08,197,1712592000"; 
   d="scan'208";a="16865349"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2024 15:13:36 +0800
IronPort-SDR: 6656c950_yGGIEUwQm+CS9uh7IG9xq15MZ7maygSrT1pJ1zJH+4RSoj1
 /9BovcRjzgeweow2IBqoHFWF6cNEmSwfYOshv4A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 23:21:05 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 May 2024 00:13:35 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 07/10] btrfs-progs: test: add nullb setup functions
Date: Wed, 29 May 2024 16:13:22 +0900
Message-ID: <20240529071325.940910-8-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529071325.940910-1-naohiro.aota@wdc.com>
References: <20240529071325.940910-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions to setup, create and remove nullb devices.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
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


