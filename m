Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1593801B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 04:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhENCE2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 22:04:28 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:9190 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhENCE2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 22:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620957801; x=1652493801;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1UWGkQx6xrkrVGuL9t6NcS5NH1LoZHKVsKgYUigAdYI=;
  b=C3LwvvAvBaa9kVRWljQoXbHgBjDeMOMYCfrKoaaJgheu7QlT9jg4lqXp
   LfUL5Q9Vu9euZw8ggTwx9PXM/pWFj5M/h5pqbDsIu/1swcI5IbwwQcmNO
   IFwVNBpm4688ZBnnxyDnsEWN/o0xp+bN1OQNZr0mf2niPwYsUOP515zjb
   FV81uMvZAItn7lS8GJhxWydJ1ALTkEKc+MV5J5lGPrF50sFiP2MFnLCq9
   xBCqTDyRP2wi6xCGRVcj1SCkCxK6rW+51fXMmPyH743ft9sD04mGp5bxL
   HCOksNIpH6LxuAe9VbNs5Yxfg3A4MF72NigLDSXhIAazEaf9pO3h754AN
   w==;
IronPort-SDR: vF5JvkLUK7dXMK4CQsu7rjG/M6IPgmuEiiNuFDZMYG7Lt1yxE7gmaJnXCYU4o+TN+uVjAdmo3V
 ntsZBaU6gaj4ZH1UWvt7fKfVz6uUcrCb5WGutZcsshVB8JaKNGwbntxKMbxuNjLbFI2VwvCJGR
 ptiLvJAL+b2EXphrSTkv3uvVryJVeo+7ZmLLCQYtt3HvZ/SN75VYFJ3xeKPwgc9zpXgrlXbHiZ
 OOjFIgMuNuWGpBFR/X8V5qilgXBqhXrIBN199vkEwjXL1cDE/d1JG1X+Ra09Eha6edzrgvixv+
 jwc=
X-IronPort-AV: E=Sophos;i="5.82,298,1613404800"; 
   d="scan'208";a="272101654"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2021 10:03:20 +0800
IronPort-SDR: GUq00ZCCuDycclB6vJQXsk9xBiPYVb1yAWXO+itHag/ddsoNQ4F1vClOEDyz25ekk9SW140rWn
 l2WoJJhcXauU+Eoc3nTRoSh8gejEgvURKi/SuDAPQ9di0VJ5W+hXoDEgLkoyRs2W9EZNapomxu
 Aj6/EPnNEquB4To2Nip24QUay4E3ld+1Pr8Pu/yLjlOwp98VuGA4Ld1PlD6zcNLwqvPZFB80Lr
 CTdwR5fcXycVuxpubKKL9EVf9gBhBgwJ3NsVZZytgeywfmw3kuW9E9VNK6lBg3jzns8smx32KB
 uJw9/jCoxwDXJtmbZ60bvz6b
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 18:41:48 -0700
IronPort-SDR: KIzd4P1uQubx/BUNB72QqgkCdyuGOLW5Jy3Wdlx7lkgNLsdakQHKXmyOKR1Y/Q3ClDeozmeyg9
 TWlrrd7S7M+hA4nslexNzchBa/oj7DpZHzPjpgON6nowpyzy2QGgA+tJPguwWMrCz++YgUcT9x
 Y72OiRqDEfl0u/mVmjlkDDL7NvEKgJ0hiMPChUfSZm9x3J0gzP19ndvnLV9MAh1FwAcmV/1e16
 6NiqDPMTaBg25iEsIPtLHvwgjVhRnAySlrAycwipCjPgN/WYgSubmFSw/vVUVjg/SE+zpw+j5m
 sOM=
WDCIronportException: Internal
Received: from jpf004451.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.104])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 May 2021 19:03:17 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: disable space cache using proper function
Date:   Fri, 14 May 2021 11:03:08 +0900
Message-Id: <20210514020308.3824607-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As btrfs_set_free_space_cache_v1_active() is introduced, this patch uses
it to disable space cache v1 properly.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4a396c1147f1..89ffc17d074c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -592,7 +592,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		if (btrfs_is_zoned(info)) {
 			btrfs_info(info,
 			"zoned: clearing existing space cache");
-			btrfs_set_super_cache_generation(info->super_copy, 0);
+			btrfs_set_free_space_cache_v1_active(info, false);
 		} else {
 			btrfs_set_opt(info->mount_opt, SPACE_CACHE);
 		}
-- 
2.31.1

