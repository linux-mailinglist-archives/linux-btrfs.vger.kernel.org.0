Return-Path: <linux-btrfs+bounces-17678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AB4BD1EE3
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 10:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36DA04ED83E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 08:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE47C2ED87F;
	Mon, 13 Oct 2025 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CLEjrJ1D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A12EBDE5;
	Mon, 13 Oct 2025 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342896; cv=none; b=m1rPpiKU1UBBUhkv1Y3LTIJQD1A9TeO7gZFYgykkmrUhTQLRQVo4Eh8IWCRvfLRpsWqprAt8B7uttBH1H8BA+rSb8saawOXisuAW1ngluf394q/1o0J8FbLhna5/yXphslrAKAEHuui98iWdCCzBpEpoyDi1UdM0Y7PA2Rom1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342896; c=relaxed/simple;
	bh=lqCyvs8Tvl0RD2pp/02jv+mA9mElBHqo9a30rH/DgAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9uBBtmxU22eLOGLmOncylFD6DtuY540F1W+XA8gjCwNFmntvWYEjZiSpPfuTM9x4IZ+FXwtO0L5BigbBVo6JthJrH3QWJeboXWCK6Gbxaj0v+M23Mwtl0tEfUqU25Icw7jr6xSI49LM+u2QYz0hGb6YaUBmzuZPPdsTu7ym+RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CLEjrJ1D; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760342894; x=1791878894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lqCyvs8Tvl0RD2pp/02jv+mA9mElBHqo9a30rH/DgAk=;
  b=CLEjrJ1DYIrk7JVZt64CKZrGCTeQuNPnzPmvHtJj4r6+Y0OW/y0VC9sa
   TXmlPBy6khnudAPeR+rnOTKGXOu+5AjQQ3BBZ/+lxwPOU01bN4pvTLgMS
   cjaxos8+i2/0Ija9/2hQMEkd/PSPfqI9ukYtOeVxVR7B647bn2pNtsJ2s
   mvfylH5SwHmuQ6M0mrOPWNilUOHe3OAEEuRF63AZjmYFr6Vn0m1BuepIZ
   GkU4VD3cIYnQMiIg6FIGCfjffLRnZ9/1ohAzOwIN4zJIXKuppAHTciWVT
   WtQGaNiiaoWijjbSth+wv5l1XWrqctgGjzBSvfH9xfT4jtZBG3YRr7BJd
   Q==;
X-CSE-ConnectionGUID: cXWhI74hSK2bbeuwIRMs9w==
X-CSE-MsgGUID: 7CQEudEjRHysdgDbjEKhiw==
X-IronPort-AV: E=Sophos;i="6.19,224,1754928000"; 
   d="scan'208";a="133101998"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2025 16:08:13 +0800
IronPort-SDR: 68ecb36d_aTfLn65/bLqs8e+kwicIgymCSk8QlxZuEJPZ9cSwQ1pXVrH
 TREhbSDxL4yTpQ7oFQ0Oi9/etgXGpyPVVn7/XKg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2025 01:08:14 -0700
WDCIronportException: Internal
Received: from chnhcln-775.ad.shared (HELO neo.fritz.box) ([10.224.28.18])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Oct 2025 01:08:11 -0700
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
Subject: [PATCH v3 2/3] common/zoned: add _create_zloop
Date: Mon, 13 Oct 2025 10:07:58 +0200
Message-ID: <20251013080759.295348-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013080759.295348-1-johannes.thumshirn@wdc.com>
References: <20251013080759.295348-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add _create_zloop a helper function for creating a zloop device.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/zoned | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/common/zoned b/common/zoned
index 41697b08..59bebcae 100644
--- a/common/zoned
+++ b/common/zoned
@@ -45,3 +45,32 @@ _require_zloop()
 	    _notrun "This test requires zoned loopback device support"
     fi
 }
+
+_find_next_zloop()
+{
+    local last_id=$(ls /dev/zloop* 2> /dev/null | grep -E "zloop[0-9]+" | wc -l)
+    echo $last_id
+}
+
+# Create a zloop device
+# useage: _create_zloop [id] <base_dir> <zone_size> <nr_conv_zones>
+_create_zloop()
+{
+    local id=$1
+
+    if [ -n "$2" ]; then
+        local base_dir=",base_dir=$2"
+    fi
+
+    if [ -n "$3" ]; then
+        local zone_size=",zone_size_mb=$3"
+    fi
+
+    if [ -n "$4" ]; then
+        local conv_zones=",conv_zones=$4"
+    fi
+
+    local zloop_args="add id=$id$base_dir$zone_size$conv_zones"
+
+    echo "$zloop_args" > /dev/zloop-control
+}
-- 
2.51.0


