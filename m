Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B7C78242C
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 09:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjHUHMX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 03:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjHUHMX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 03:12:23 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7429A6;
        Mon, 21 Aug 2023 00:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692601941; x=1724137941;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6/XeuW6QmqFPeM9FxzCFfiGyvcHLJtweQyWJOaazx0g=;
  b=kzikyqyP3a31twYY3ruj5O1s93bCnJe4mT3lT29We64ZNWDCgRUAXWXI
   RZSFKpwFXiKTNje0Oakd6n0HadMTpLZyF2IzJ77eGE5z6HXs5HQ3Bk3NT
   INR49oVFBAqWei7eObEjf+QpnfK2Pkm1uvAk5sshsYhyO4f2jg9sXUj+T
   que14hqxo0KbGpHc3ntjGMYdM7p+NHHdxG08Ihk26aHaoD+7a2PmuGBlS
   ioPok4EUzBe+rkinwBwv7bpVxMR0plHiQIdZ9fMJM9sSsfPgBVM+nK6yc
   M3N5JVpArpg+vAU8fm08E51mVc2T6zAJ8ZDjpKcqEwKq7frCKtIuedOdN
   A==;
X-IronPort-AV: E=Sophos;i="6.01,189,1684771200"; 
   d="scan'208";a="246252745"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2023 15:12:21 +0800
IronPort-SDR: VQ0SZFBIlRIo9SsEuADeXKtSGIOm0WweuLzwsyZh+hD8MNjBwudA8HvmmOvXXbRMtFXqTPvqB1
 qu7+wdqJF0h9ex2q2xQ5bqgSHgRdj8BFQe/NanzrplbgPxEuJLi3fDdecsORR7EKTmepOXdMk4
 ou0eKM568w+UxKANskqoJLlzFWXgbKQI6V2S1wiqm+ob2BiQx75JQbJj3T/IpV3re8Z1Qs4YR0
 VatP91BmUDE5GhY8fDneMmdFQkf2dwIBZ1oEJ1BrSFhzhiyuw6/QD46Zpy9hM6XmO+UarAZDwn
 3pA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2023 23:25:32 -0700
IronPort-SDR: S83IlObcPK8tOnrbAfRAezEnGM9crnzhzAsi9WSE3tHvUineaYUFkTUxUZl5401DK+7mQ8g3NJ
 NtKTTUBAqWCvNDyGlGFRim/KtJ4DqAnaY8TNNU158hWlwPfodvvnialSqAk4aJ1YumitBnUp4/
 wr65ShslQrucEPSNZvOAKM5SsPbpkHSRSY+4nFtkvE0VGAQAvBMohgoVbKJTNpdaGhEoazzvAX
 PSPXfhsuOCOwF9kbmzTSmTRPN9L1nWn2wFCD/pvWf/kK/TCv0cwK9YuNhNjdSXraD+LzsO9cIJ
 9F4=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.96])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2023 00:12:19 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 0/3] use shuf to choose a random file
Date:   Mon, 21 Aug 2023 16:12:10 +0900
Message-ID: <cover.1692600259.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently, we use "ls ... | sort -R | head -n1" (or tail) to choose a
random file in a directory.It sorts the files with "ls", sort it randomly
and pick the first line, which wastes the "ls" sort.

Also, using "sort -R | head -n1" is inefficient. Furthermore, even without
"head" or "tail", "shuf" is faster than "sort -R".

This series introduces a new helper _random_file() to choose a file in a
directory randomly. Also, replace "sort -R" with _random_file() or "shuf".

Changes:
- v2
  - Introduce _random_file() helper
  - Rewrite other "sort -R" with _random_file() or "shuf"
- v3
  - Fix _random_file() helper to add the base directory as prefix

Naohiro Aota (3):
  common/rc: introduce _random_file() helper
  fstests/btrfs: use _random_file() helper
  btrfs/004: use shuf to shuffle the file lines

 common/rc       |  7 +++++++
 tests/btrfs/004 |  2 +-
 tests/btrfs/179 |  9 ++++-----
 tests/btrfs/192 | 14 ++++----------
 4 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.41.0

