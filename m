Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4463ED320
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 13:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhHPLfw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 07:35:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26129 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236243AbhHPLfq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 07:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629113714; x=1660649714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FPSGTJdawAXKau7I8AQ5Jq9ZtizOZUYzbzv6fIsDvwc=;
  b=ljyzjArLW9qYZJcVlwgXeTNMAR82W/s5uFeYEunJ9yHhbyWLEqC81Xd4
   hpbvBWBJZcUsoza8fuDDRm1gRjTHUUGSx+adMZHMWwZVbxamKTGMry1Rt
   lP5OCNyRVNHYgky6GOBgc6zg8rFn9EcRXQgUsGAsGhs6kEXZfyZtcQaSB
   TNVguha7qn6S69vkB57VzcR9vekt6q8jKpWjJEAQyY69K6Rfl+NnN7/3g
   tMWF6FE2KmYMifC/NOhUKMfw8/CemfoaSOc2kSnY4Xnjt8tvtyUXynI3F
   e/ERkAjTEdI6YBxtuxvP1oLfpw9l/rgIlPRTJ1UkIdB8A/rXzJiljkofI
   g==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="182172003"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 19:35:13 +0800
IronPort-SDR: TfSEIcuSIAmg0TdJqpxolM3ZW3inPJ7+1CN8s2S08EIvkqJMq570GBo8vPzHXGaYBi0q3qB3H/
 6rbwx5PXjHgdwiimlW40U0c3h2YK/qsXvkvq7rjOVsjyj8Af9+kjngaj5JWkgn+B7gv0iVCT8d
 4HC6i6gv8ohrsQPxqLe6tOPZPx5DHWOPHeoqTMO2pspdAcMnDI9v2m5Ht9cug5Qwk/RCm9c1KH
 rWUELNPe/aO/GsxvZ9hF4Z6pS//VPN88hr8lxuwiKMXVeb8ihoHKFJpOPNUfwE7lpvV9k4hyeA
 7uayCenUtrJm0dy4tTxbQpYh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 04:10:39 -0700
IronPort-SDR: Fi7uRhQ1sCHwerDLN6RyLakftTGaO+KsVE8dCQF9gTUBk8188OOSCkDUnHIKyPOPztFDTeyNBC
 K7jHXXwA0mGp55RtzbBL3lOhTJhMiTD3jvatPjh2DGV2jsVhiYV2XsXsFU96cGZlewHcVzRryr
 WJTKnkOit296X7TY/+J47Ji1+ghnGLQNNAfwoG9HcjcQGdwRGl4ZGD1+BYxvcLLJbA5YRogP+I
 /U8ffY79XMS+/tHvtTmRKzIGihxD0riolWr2khdJNFfmvJR+nSXxkgDPKcv1Xwwz0LfTkGU3vK
 tSM=
WDCIronportException: Internal
Received: from ind008647.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Aug 2021 04:35:14 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 0/3] fstests: add checks for testing zoned btrfs
Date:   Mon, 16 Aug 2021 20:35:07 +0900
Message-Id: <20210816113510.911606-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Several tests are failing on zoned btrfs, but actually they are invalid.

One reason was creating too small filesystem. This issue is already
addressed with v2.

The other reason is lacking of zone support of some dm targets and loop
device. This series address the issue.

Naohiro Aota (3):
  common: add zoned block device checks
  fstests: btrfs: add checks for zoned block device
  fstests: generic: add checks for zoned block device

 common/btrfs      | 26 ++++++++++++++++++++++++++
 common/rc         | 13 +++++++++++++
 tests/btrfs/003   | 16 ++++++++++++----
 tests/btrfs/011   | 21 ++++++++++++---------
 tests/btrfs/012   |  2 ++
 tests/btrfs/023   |  2 ++
 tests/btrfs/049   |  2 ++
 tests/btrfs/116   |  2 ++
 tests/btrfs/124   |  4 ++++
 tests/btrfs/131   |  2 ++
 tests/btrfs/136   |  2 ++
 tests/btrfs/140   |  2 ++
 tests/btrfs/194   |  2 +-
 tests/btrfs/195   |  2 ++
 tests/btrfs/197   |  2 ++
 tests/btrfs/198   |  2 ++
 tests/btrfs/215   |  2 ++
 tests/btrfs/236   | 33 ++++++++++++++++++++-------------
 tests/generic/108 |  2 ++
 tests/generic/471 |  2 ++
 tests/generic/570 |  2 ++
 21 files changed, 116 insertions(+), 27 deletions(-)

-- 
2.32.0

