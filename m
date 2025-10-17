Return-Path: <linux-btrfs+bounces-17917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E45BE67AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 07:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40154355A81
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 05:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75D430F53A;
	Fri, 17 Oct 2025 05:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="htmKxxDM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A64F211A05;
	Fri, 17 Oct 2025 05:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680224; cv=none; b=COAdsGEf+I4DQRI4JQvdKsXAd+t+5mJjlrDcc3WWaumQpkwD6UYC5H4zS6uiVt6bHgUMGrFbqtT1UidkJaWTnS9JrPjOVX2bnz+mZXYlX886fiqKLZQtUbhR985Eq6WmPdde5EkYOPAiCp/F0hn2YLy/XnajWQnjTWPCgUKD+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680224; c=relaxed/simple;
	bh=c4Qk8M8YPSlP7WO+8b635rTxFnFMbs2P5u/+JBmT7B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxyoBZ2y3s2AHH10S3iTIlfndVJU9uWCqbQ6pwWdVk4gx4d6Ghq7dG5G+uSO2HGuGs0xCXFTqg3VYoP73GlopMSiHw4zCldIrrTUN4vUsmhv9BuepG5FwanaLDROO2253ELKcvnU/DVLv8kx/vQwzo0Y/MGlSAxj82UE9Nfg550=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=htmKxxDM; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760680223; x=1792216223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c4Qk8M8YPSlP7WO+8b635rTxFnFMbs2P5u/+JBmT7B8=;
  b=htmKxxDMwoddyc770BWJHZnmZt3iEE5L66aVnIuKUQ1q/HaqORuj0XLe
   8tbP96H6thWmzYeemvrVMAiWZjS+Ys5j7yVYQhBdRAuRnk2n/c67lTk7A
   BW3ltg77IkqOhTfUgosH90AcuiwrL5MnIZ7U51nXtLpCKwd94EZMMUDvd
   nXdj6YCN9QlIWRCJIh/vPPVjcnRUFnZuycLoZ2V/U0qAJrzj5ynpQutyp
   UATLjSqon10CRrJico4j0f00ARKbiWUPnRjjApL9wrxrKbCpNaPgS5ojC
   fsMHfdee3QfspK9xCGQr1yaO5txkBdhblaZ0VkUpxwpZ8dpPL51dGw9P4
   A==;
X-CSE-ConnectionGUID: ot6UtfBCQSyY9sYcV9GwMA==
X-CSE-MsgGUID: llUGJ1BiRlGOMoRfat/anA==
X-IronPort-AV: E=Sophos;i="6.19,234,1754928000"; 
   d="scan'208";a="134338862"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2025 13:50:23 +0800
IronPort-SDR: 68f1d91e_1eW5TAaUg80451h5rRqkzY+aMEiAeVVKNWRqxxMNVAQjjg9
 0QuepmuoPQv4COtsKXKRdyJ53lZPa4/3RHwZarA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2025 22:50:22 -0700
WDCIronportException: Internal
Received: from unknown (HELO neo.fritz.box) ([10.224.28.41])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Oct 2025 22:50:19 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	fstests@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Anand Jain <anand.jain@oracle.com>,
	linux-btrfs@vger.kernel.org,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	linux-xfs@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 2/3] common/zoned: add helpers for creation and teardown of zloop devices
Date: Fri, 17 Oct 2025 07:50:07 +0200
Message-ID: <20251017055008.672621-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017055008.672621-1-johannes.thumshirn@wdc.com>
References: <20251017055008.672621-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add _create_zloop, _destroy_zloop and _find_next_zloop helper functions
for creating destroying and finding the next free zloop device.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/zoned | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/common/zoned b/common/zoned
index 41697b08..e2f5969c 100644
--- a/common/zoned
+++ b/common/zoned
@@ -45,3 +45,56 @@ _require_zloop()
 	    _notrun "This test requires zoned loopback device support"
     fi
 }
+
+_find_next_zloop()
+{
+    id=0
+
+    while true; do
+        if [[ ! -b "/dev/zloop$id" ]]; then
+            break
+        fi
+        id=$((id + 1))
+    done
+
+    echo "$id"
+}
+
+# Create a zloop device
+# usage: _create_zloop <base_dir> <zone_size> <nr_conv_zones>
+_create_zloop()
+{
+    local id="$(_find_next_zloop)"
+
+    if [ -n "$1" ]; then
+        local zloop_base="$1"
+    else
+        local zloop_base="/var/local/zloop"
+    fi
+
+    if [ -n "$2" ]; then
+        local zone_size=",zone_size_mb=$2"
+    fi
+
+    if [ -n "$3" ]; then
+        local conv_zones=",conv_zones=$3"
+    fi
+
+    mkdir -p "$zloop_base/$id"
+
+    local zloop_args="add id=$id,base_dir=$zloop_base$zone_size$conv_zones"
+
+    echo "$zloop_args" > /dev/zloop-control || \
+        _fail "cannot create zloop device"
+
+    echo "/dev/zloop$id"
+}
+
+_destroy_zloop() {
+    local zloop="$1"
+
+    test -b "$zloop" || return
+    local id=$(echo $zloop | grep -oE '[0-9]+$')
+
+    echo "remove id=$id" > /dev/zloop-control
+}
-- 
2.51.0


