Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E5938BDAC
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 06:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbhEUFAG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 01:00:06 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33628 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbhEUFAC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 01:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621573118; x=1653109118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SrFjFY56fR+Rp22UAHX43bKEVCdx/FdHUM8fBb3hNus=;
  b=VPfewvVGpk8Fh9JfThicgvITfwtDxo358mBRjDSNSIbZ3Ey6iAjE7IYq
   tb0/zOAHOV2HdO+9U9P/RFbvw79FGL5gXCF2LqRDQJeAQNTpPw3Wn4EAt
   mkUV0KNjAjOxtO4auOe33PGcWOiDvDaiPxvjBmaan0AWBnHnwFu/9Qyfu
   nkVTv7lxA74qDTx9PAJFWETdRAYnEifPOJ6J2RQPUzrEg7PUAeLI7PGI+
   bX/S/88ChNSoEJXuMK+D0GYrPO6IYmlfoOLZE9C0AZiMFcVoNIp+89fjb
   J+WLrNdn/ewfzZGRU9BENZ9jSq2Mvf4gFw28ulug7cPYmpM5rWNZnTCYS
   g==;
IronPort-SDR: /xaIB8mAx+oOHh9eldnY6aDZbSz27N7DTC9AVcNt/AdUruUumBiflCa8+zCiVBRZ73a9/dHJjQ
 tkqc47ZtGEILB4UOvoyKmoDD/j88TcrrHCDOOoMhrt2w8v0tB7TNsxvdoehuGqqPwmbFRViU/K
 WnWzkMZPMAHVMmPxtb/18FVhSQnkwX/UZ4h788S/anFrp9sqPMrrrCe93uLbEkJ2ICghsMLfNH
 x+zp+t0TeEaqLwS6sRTg7V2SYGQFcZqdlQpp2LEZBR28xuRltxw7tX8eGkam24Hwy+nS9Y+ro2
 Wpk=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168955592"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 12:58:38 +0800
IronPort-SDR: edtZB23USbtceAITH6G+RtiVr/J4gUaWmuCBXFnzxZZUxFV6Qad79+cVm3inVStt/y1zfIkadB
 gMW14vlhwxIb7z2CjQWvU0au8ujruNaAsuBvc+i7Sm3fmfTvJB1uksGHAlyiDw3GAG6TtkR/r/
 2Op9qnSaEVkGp5D12++h+ycN1IlSdV3crEVGnoWb2lViSrE8D9tC6eQlQ+0fBrkHwyZ9cqz0Q6
 UsI1jKA58T8Vtg/+0MuzLKyIH5bfmefA0vgZAO4n6KvqCX1isV9WF2o8ek3zLzdIBYgbwItiNl
 Ncae6KPIZqMqu2lsLiD+uBdJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 21:37:02 -0700
IronPort-SDR: 64OVi2vKgFGMYpKgonKeeiu2FblrbDfuAL47mSRxUL374ggoRpwR1nG2qEJxNNsjLf8bC8gvy4
 vjWag2nNU6GSfsV/8C3qgvzWktqiykiNSBl/xnMHSl8ZerppNSD1SySq6SZ7mYCUXlqQ0Z5+cI
 T7yVeLJ2AISWw3M8qfN2HS5BQFzLiy9dlTaV1tTKklP5flEvFoC1+TkY+C05e6uhoikXeyUCtX
 v0zHoFxejpjlA0BKEXNX83JbJbgkftEvivlBB+odh9bCjYHCKOj8uBPt9swYV2ngDMcc9xD3RS
 ODo=
WDCIronportException: Internal
Received: from 9rp4l33.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.75])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2021 21:58:40 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 5/5] shared/032: add check for zoned block device
Date:   Fri, 21 May 2021 13:58:25 +0900
Message-Id: <20210521045825.1720305-6-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521045825.1720305-1-naohiro.aota@wdc.com>
References: <20210521045825.1720305-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Mkfs on zoned block device won't work on most filesystem. Let's
disable the test.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/shared/032 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/shared/032 b/tests/shared/032
index 360087ee1fb9..31ac52303dde 100755
--- a/tests/shared/032
+++ b/tests/shared/032
@@ -25,6 +25,8 @@ _supported_fs xfs btrfs
 
 _require_scratch_nocheck
 _require_no_large_scratch_dev
+# not all the FS support zoned block device
+_require_non_zoned_device "${SCRATCH_DEV}"
 
 # mkfs.btrfs did not have overwrite detection at first
 if [ "$FSTYP" == "btrfs" ]; then
-- 
2.31.1

