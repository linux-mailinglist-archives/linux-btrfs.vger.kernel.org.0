Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDD9354E46
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 10:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbhDFIHq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 04:07:46 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49896 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbhDFIHm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Apr 2021 04:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617696466; x=1649232466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gc9qcK/c/0qNHpcrdUS+T17j3sV6oMs3sVwxP5RvDgg=;
  b=m0AA/1Ys0ZLCgEwHC31RliNinJ5tAsROQ8AmMXvblj/dzBeFq4SjcXFN
   VzHFHG3En0PZb0sCFpLgvKByOKfkF/4GXhAenC7sP3+O4sfKJfM8TARkB
   XJCAzAiKghAjdu5OlK5aTzVKI9SMQngTqLNdmtwkyYc8PsGvzveTdf1g7
   SW2w33Vr7L6sNpgmGgDpL2KknL8eFGO/zIwKG6FL0uGWViqFLzr+AVN6+
   b+JEAfr5kanuQQqNcc+gojtJDhlArk9aGakgtlv7CCV2OBjl0Ex4vGJIS
   8/iNO1jqtTeD39j+vLz3HTNrs6IsPofcp/+my5600GcoXIzCPzfDv74cw
   w==;
IronPort-SDR: AZj7QY604vCMSV3BLriakZoyNq/BmIp3ienngg6GWlB/kYUs7hvREVKXB4g6MUpN4h5TEFB4SQ
 5f148T+ChsBifc5Ur1YOwHZ9ztbGa8a3zyabgOqZdN3uUdjIUKPH/X2BJlEo2KatF7/DJ6o/4g
 kMo6VwjViRBheT0H0S0KkRTJ6BL5QhtVP9ll79X2dztsw9ZwwN2svckOpam3nGotHwMHWTJxot
 I4O3PE47/wn3+odJr3W5dvA5zhOLJWTPRW3I1CEa9fVNbU2n0DOVwnJHXoFRzGvsl9F1IuGCEx
 2Sg=
X-IronPort-AV: E=Sophos;i="5.81,308,1610380800"; 
   d="scan'208";a="268290673"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2021 16:07:30 +0800
IronPort-SDR: StYNu1OKWyLycqntU61N2eydo66+LqoeA7VNEmvHeQZszQzIfddh+QgwMl8CSHfDqeTV+uxkRu
 8nY3JXxPx9aiZzVBWowhISd7dvlZwc5tWeoCFD2H36Hk5YS14AsKFGaKQVAz/4RzuVAAvtFgAf
 gjvFBXCUM9dwmIQ9UYSnW5Wzc2pjcwJaDnsjcY0YAjbDgXKLi3fdw2fubM6YRezxOHZDS53RDn
 0/ojUoB7vIndYlEddQm3q2wbDgDwhSX5jztUqzEHe73pNpJxa5Sr9H3VYXqAI5YGUaJase50DK
 WOnG4w4Uo07IAo7oxC/YqFKc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 00:48:22 -0700
IronPort-SDR: 0nMDjjIWDW8iqD+GcgkaaLEhnMJasJXuTtEkX+SZF4lpM0htLt+e1LeuVcvbZZEqcKOTSW6hEz
 RCTTjKZhatsPri0zgf/qf8L55ijL5dQcs0lxA4nfoVlE6y0/AFxUw35p99CUwtrgp5qURmPSPs
 b5kL5c6la8Lq8O6SB63nN3RJGFC5xfSmdHem5eLHMP6ozZxqDJHea/LnqK1CcpNlrkYGuwMtwE
 0UxBRVYUGec0M6OggJb/8r2blZc1/4mkkiaxVDvjtkMQ2b8uPorgV20tjFUu2iMvHMc55PChVu
 RSs=
WDCIronportException: Internal
Received: from 5pgg7h2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.29])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Apr 2021 01:06:57 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 03/12] btrfs-progs: convert type of alloc_chunk_ctl::type
Date:   Tue,  6 Apr 2021 17:05:45 +0900
Message-Id: <e18107cf11f63a01073a8055fcbe6ef4c0e0418b.1617694997.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617694997.git.naohiro.aota@wdc.com>
References: <cover.1617694997.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Convert alloc_chunk_ctl::type to take the original type in
btrfs_alloc_chunk(). This will help refactoring in the following commits.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 kernel-shared/volumes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 3b1b8fc0b560..ea14a9413157 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -149,7 +149,7 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 };
 
 struct alloc_chunk_ctl {
-	enum btrfs_raid_types type;
+	u64 type;
 	int num_stripes;
 	int max_stripes;
 	int min_stripes;
@@ -1008,7 +1008,7 @@ error:
 static void init_alloc_chunk_ctl(struct btrfs_fs_info *info,
 				 struct alloc_chunk_ctl *ctl)
 {
-	int type = ctl->type;
+	enum btrfs_raid_types type = btrfs_bg_flags_to_raid_index(ctl->type);
 
 	ctl->num_stripes = btrfs_raid_array[type].dev_stripes;
 	ctl->min_stripes = btrfs_raid_array[type].devs_min;
@@ -1069,7 +1069,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		return -ENOSPC;
 	}
 
-	ctl.type = btrfs_bg_flags_to_raid_index(type);
+	ctl.type = type;
 	ctl.max_stripes = 0;
 	ctl.total_devs = btrfs_super_num_devices(info->super_copy);
 
-- 
2.31.1

