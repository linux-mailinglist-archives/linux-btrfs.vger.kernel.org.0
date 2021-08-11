Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6893E9451
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 17:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhHKPNY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 11:13:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39984 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbhHKPNW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 11:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628694777; x=1660230777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WB3vlUTr8ArDxDywgsUW4dk+jJwQp2ZWt/wFSDH6kXg=;
  b=B3ocPWf114VIPmXcbS6UOUEjCoC1hhmsDLK65sr6mgkEjyLy5wbqH2O0
   WORwZxPftub/vgKQVqkjB1iy1DND6jaeemmckACSwqi4EZgSpQPpBOAxX
   vZU8oh8G1JoCW0EHwwwGRDd2sJKQy/N+LkqOSQFMTZH/+vHUng80rT7lK
   HiOkyAOivzE0ag2mB1UneL4EcToP3pqhPceMd2BSrK15X6525dzswi+Sy
   NVAjCDXNhoIdkMGkrqFCV03Ha9T2jqL3xKchkt6P2d8rIv0cGZB3zrZjB
   RZnyq5t1oftnrERDHrsBsGf06V2PEWqVoNNUd5PWdmrhQ2i8oYjSfQRPY
   g==;
X-IronPort-AV: E=Sophos;i="5.84,313,1620662400"; 
   d="scan'208";a="176942561"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 23:12:57 +0800
IronPort-SDR: PBDwVTpUwbF78EBjfZx/+x8ME1w42EqjRVtUAMw74pPpi6hfS9surUmiOb3YbtAh2tB5a5kGYb
 r20QRTS7kBFZ4stCp1vvSRAColmQFp/yw7RC0yL/vCc1UG0Cv/+AQ5D7SnMmmPoXn9M9XT/xfF
 5QS4IqmaCl+D5Jtwwj3r6O5Mf29L3PDZ5D4Ikc4Qg+y38omhelVOps/d7bpZYm40dhpxR+54sA
 XFk8XzrxxyoL27rvIViHy7u/LNEi6gJK7mMZeJqYjFxo3gTNz3FNmWxmPzr0+wGfaG0w9OaGkZ
 2Zh9eHcEIHUQwr8wHm5n1DhM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 07:48:28 -0700
IronPort-SDR: maVAoMIKRIHfKf/oBpWafleXzDpBZtCwcJ4SkbcxlmWl1ByPLPku9oRZf9e74zJW6f4pDVQymO
 6KjnSvkN0fsf7Ed3Lv+mpKld3NaNkDIMuL8ODJLMuhXPUySHL176EGp1SPITcx3kruzkNWzQxD
 RD6+bwev3RtNkEZqig2gfWl49fB5F2C/jxdR9gOp7UeqJkivDp314OURu+HIdUpjhLS8K6g7k8
 lafqSKnKC3jpncVIlFMQhCw7QLMNklSDP5xjQV0zNj9173xKCsOOhDun3YXGv9dmWisYituG4p
 POE=
WDCIronportException: Internal
Received: from ffs5zf2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.58.251])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2021 08:12:58 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 3/8] btrfs/057: use _scratch_mkfs_sized to set filesystem size
Date:   Thu, 12 Aug 2021 00:12:27 +0900
Message-Id: <20210811151232.3713733-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811151232.3713733-1-naohiro.aota@wdc.com>
References: <20210811151232.3713733-1-naohiro.aota@wdc.com>
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
index 074ac96abcda..782d854a057f 100755
--- a/tests/btrfs/057
+++ b/tests/btrfs/057
@@ -16,7 +16,7 @@ _begin_fstest auto quick
 _supported_fs btrfs
 _require_scratch
 
-run_check _scratch_mkfs "-b 1g"
+_scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full 2>&1
 
 _scratch_mount
 
-- 
2.32.0

