Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAC038BDA9
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 06:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbhEUFAD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 01:00:03 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33623 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbhEUE77 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 00:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621573115; x=1653109115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GPKlneebGRfzv1TU74qOb8uhhF4+ljzDSNaTz9A4GvU=;
  b=mh3I6FQFim5JPngBmzCigZvbYBR+xx4OAGpayw7eOmkTwxCojOhY+sTV
   1KZjxUUQq6MdVgmoAj7Um6m6GyTZMjXhIYkXehJSnihNYNG5Qj08oNWUo
   BPhAIZyfYG8p7u+VVimABVsX73ZFudYsAwyiKfjYREQAHa3qnxdDmjg9E
   LJVI4jIvBaT79g/GKkdam60/NtH2In79+TzATdeLP3I6DItadRslkB/d7
   /SZAQ/XzgT5tGjWwKmGagjGxaH3rjV/cU6re3mB92plx0mxX8jvMMagei
   Z7C8qf7OARsRh/ZAMrZ8Z2ip+uDa1qBlu9h20vBgMMJk0DbTsU7Ia0eiY
   Q==;
IronPort-SDR: 86WoBdxNE9M78ZRKrQ1EGKP9YvZXwedh19CxMwV1J9dWoO70lQVI9Is7mGnUEqbZ2TRdFjFUnb
 0Gy7Lxe9JL122Cf3vSdYFqt/WpEbhh5lWNJqDkxtS4/AeTZWJ3qYS1/TMrUsD10b7TS8tXHpFk
 +2XEcwd8s7p/97MaKrV9eISjCWGA75xE9IOnICK8g+TCZ5zCaQXB+N4Yls+TmUQ8fp9FArHWl9
 KmZM3SdtB5mpnxtfho/vcliWEXkzep9+Jys2pjOm7eq3M+zgnz3yBJR4dVhrTA1TGQUSdna8Q+
 /sU=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168955588"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 12:58:35 +0800
IronPort-SDR: PKGcKz0qr4v1RxhcF1i2qfHVmFcf/+jy023nLAsb9NMHr/s83CBw4OeEnWxxcTTz6XbkuSDQTY
 SH0M0JSwfHPeAXPDiib541u07L18OCaWmOUk5Jmf4P7Kq+oLtu2mjYT/SiGLAO6jXcFBfBhoWS
 QSzJvDXU2AAW84XfVxePbcNG4S5g+/zctN7T1NshNzm2mYctJHoG1WQ7aWlHYAIjY0SFv5UOO0
 cBy2ZGSdAhJEzpZwiiUSRgQN2baPlqIomKP2FuAMtwCzASLMlsI6+HGXS0FrOT8825X+UPeinT
 KrFwq6/Jo1sL7RexmDTp64C0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 21:37:00 -0700
IronPort-SDR: BWi14BB6BBcCRfvR0Le93yYKJiNB3YXYtkYAQUriq3lnw/jTje/51R8G56PrFc95daZ2R52pAx
 DKfF5p8WTLsPN6Gb6fHRNKJsgucpzZn6qaa3Uy/b7Qel8P1T9NqfCFUyREhjaptLyGuWJnkOwD
 lsOHwNHZX+8p1IxpkjLUJL07HfPG0pOP0H+Axj8PzfxZ9kE6jpL5Cwe4P+SBz+g6ZYmpNd6KHZ
 o+KpqP839QFHLbY1n8sXjzQ5+SqLliMQw76qRyxX/I2VM8glYqC31ozRGyygYnnSABDH4wzOrt
 6nM=
WDCIronportException: Internal
Received: from 9rp4l33.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.75])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2021 21:58:37 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/5] btrfs/057: use _scratch_mkfs_sized to set filesystem size
Date:   Fri, 21 May 2021 13:58:22 +0900
Message-Id: <20210521045825.1720305-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521045825.1720305-1-naohiro.aota@wdc.com>
References: <20210521045825.1720305-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs/057 is using _scratch_mkfs directly to set filesystem size. This
can be _scratch_mkfs_sized instead, to go through several
checks (e.g., minimal filesystem size check).

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/057 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/057 b/tests/btrfs/057
index bf9ab14a89b2..e2c651911ded 100755
--- a/tests/btrfs/057
+++ b/tests/btrfs/057
@@ -31,7 +31,7 @@ _require_scratch
 
 rm -f $seqres.full
 
-run_check _scratch_mkfs "-b 1g"
+_scratch_mkfs_sized $((1024 * 1024 * 1024))
 
 _scratch_mount
 
-- 
2.31.1

