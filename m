Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDFC3094C7
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Jan 2021 12:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhA3L2m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Jan 2021 06:28:42 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:14341 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhA3L2l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Jan 2021 06:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612006120; x=1643542120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vauiWC1ysIQl4AhvH+FJysCs6hKEx24y6RjF+Cp4vyU=;
  b=Puty50RCloW6eANJdLzTIKaAtAqF8IDBSGSRunh1l75pXPs8C3KwsUMV
   GTJ0lyB7A4G6m4YfkIrivMORtJZcINYe8XuPmT8Yp3nMSf1KGk+ClpUTj
   q9dVfKpo2IS1ZL4rZQeE+Dpg2JVL35nvcp51p+LovVQYj9tZR0zVhSw7v
   M95Dgpuer0U55TRE0JsyEAJjnNh3eFDzFxAYRD7bIfgQEcYi23x/T0w/l
   T3Uw3q/1NjxREp2fvtOew3gq875SFms4isEOYapZJDRfcFENGZxptOyd9
   AZjV8CPV0DfzpnHBurdgR5cfxv9jQoGzVyzG7RipfxnkDIRziQqPIiObL
   Q==;
IronPort-SDR: j3HPIZ6r0PswsJxLnAyUggB74WDuErn/xQwc38bBVlgpXUjFei0emG04DT69nCOR74YNtOw0gI
 fFdVid2+UHVTT+7dQD0bRj0DgAWfz8DgzlqyUwAutObwFt9TcRaLjepUcBkdQKX/NsX9h25ffi
 VsTxJhkRQAKS77hh8fbC1vmVsLdjG605BtkFIDs8T5eXPFBjAFqO/MqAgXmCfGVn4Z0Dcvo7p5
 7EOVhEBGsXcuvwjisVJedX8bld+D373+maCuZpo7W0l8KY3s0Rhmo3fG9PMy8SeUoXe7Y0XDeK
 pp0=
X-IronPort-AV: E=Sophos;i="5.79,388,1602518400"; 
   d="scan'208";a="158695895"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2021 19:26:55 +0800
IronPort-SDR: xjEEpS44pL59wJhUTN3LQhLBTWfuXRKq1fbcNMnNl0V1SG9s5klfdIVOgNLJGY9qiUdRVB+Msp
 nhDxSE02uo05YNiR/3hk+M/S8lqsM+XFgBdtGwysAXRORbL+CM/TwBtQ8LW4WtyKOXyFaQe21C
 u8cvlmgPMxB3mm9n964I+QL8eWdrOTppS/g9/v0Fdpt0s1XAdUKQ2ojb4AwmoGtDKn4AX8+YlR
 7HQxNBIuDSzCEbHo5RjoW8NGixXKbNCojs9shE7KVeGGmEoBCBqObKCGQWQjQJaCMQPm3E6IvP
 /eLi2A5YpT0FxN+iQSDzCZFn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2021 03:09:08 -0800
IronPort-SDR: Z6AG2OTckQFbqZkSDGEZRSZ8blrHj8/l5YSxjb/ggs2bvh0DN9OC13bs+bwT2YYBR/mvt8yg4i
 RKHJa6jwFMxGiOvuKZn7TdnIEcdzWUHfjqmWSSuvSFugvmElGkgjc5mlSjJHH7TKxU7EXlODOX
 520IWOFa9MzISqGvvRvxhZGRzM/bUI/c2jdj2ELiXYAlcqpV7+if8ORcvaQ+KDN1kzHTBITMIR
 LsPhnU/ecKvzcB4nJaYEzZ6fc1vdXUJf6AwY1aAc8oGdmLDkHKgAjNhSyNUOgI5xVfZuXuCxFs
 Twg=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jan 2021 03:26:54 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        linux-btrfs@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH for-next 1/2] btrfs: fix compilation error for !CONFIG_BLK_DEV_ZONED
Date:   Sat, 30 Jan 2021 20:26:43 +0900
Message-Id: <7a77ab0c2204a5819f5734a9645a92b54792752d.1612005682.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1612005682.git.johannes.thumshirn@wdc.com>
References: <cover.1612005682.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The !CONFIG_BLK_DEV_ZONED case didn't compile correctly because the
function btrfs_use_zoned_append() was declared as static inline in zoned.h
resulting in multiple definitions of the function.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 086cd11a1848 ("btrfs: cache if block-group is on a sequential zone")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 52789da61fa3..cbd208192ce5 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -148,7 +148,8 @@ static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 					  struct extent_buffer *eb) { }
 static inline void btrfs_free_redirty_list(struct btrfs_transaction *trans) { }
 
-bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em)
+static inline bool btrfs_use_zone_append(struct btrfs_inode *inode,
+					 struct extent_map *em)
 {
 	return false;
 }
-- 
2.26.2

