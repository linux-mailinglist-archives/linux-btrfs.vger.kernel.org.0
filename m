Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9C216B842
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgBYD5B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:01 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34216 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgBYD5B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603021; x=1614139021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rg1rLjmj+DSyV1SVu1U/M6KZj12YPQ6OF9qfNb6SDtM=;
  b=oMU0EerB14JYLTyyAhNm0zGfvo7hukuhxbGH/wEKqvdRmd5Z2FaHcAVn
   Qal4yG+ptknNV6z1uZdXe+xtd2/6u9rkpVRNZtj+XPW+/ME/jeQelL6iZ
   XWMm1oBzPANBU8P8uLxrPut7repHT4w+mnwc0Op8i4sXDgsDlpwFBJhiE
   cadBQLm44o+/KtDfs2S+J2W0d91Yx1ZsdeZ+MQN6lCTsSZu3hFU2yWouH
   xEQsciD2wz1A95QEgpTwVDCHuQfNVHytwuXkU9GGcclvbzbKF5jmwlVGe
   xINodi6AIXU2DHFR6Z8XF1RjMLPwi0rYFQCX9swiOP8mSXHbcDWTa/0is
   g==;
IronPort-SDR: A3qeY6M9IA5XPc6kt1JVIw+YzV5UtZxjxcg1MFNFw39YiM1im5aUEQYCIgexR9aNYPbw6E6KqN
 thI+mOb9mD+uir65eUaNrCs2YHpsAV5tu4KztJ/nCO52tD+6Zj7806I/wy1F+9gATLupJK4vPd
 2gCXKe37fkrxvjkm9mbqx4dI9nPIvvhl1nThuuIGadyrdM+m4eJPP8MeZhObP8ii/UcKGANjEF
 XltaYTQN3SFlqhhh4kNHa0idhS7gvzzRLSzjj1Ty5HIWnDwFelYucJ3au2kS84jQxYrZBZaQfK
 uhY=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168264"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:56:57 +0800
IronPort-SDR: 9yN0LgqKVjgFIVd5TrCvlJnI2RahBBBA59Rz9HKsfNg4NcV5Rbkv3ydkyrxnI3uVc1n+GXRC6j
 5FBhAbzlyZtuproAHerADGodQet8gDUmKMPDLu+abIw27GRJajc1avWwaOE6wlH7i4BIV9nULV
 wOiCQNvFqDdp5rYfY3DKS41aYYRB7Ilvlmz5kKKX3XeNP0UMLbtB+68BL0JKbRt3rAonTOJ+S1
 PXguTmYxWMGdzk4+mhJeWt8t4HWydHn2lBfmMhvkj3O8SLCO5PkmUTxGZPPh1lnQjWYVruQxUa
 I5d7amYlg9G94ZQwB4E1mJCw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:25 -0800
IronPort-SDR: RbAFj17KKMxpUxwPaY1ANu5+QSdjXY7PnKhogQQBqIzY3jOSOdmERiHxq18nm47PAuaIVZxL6t
 ajuuQEPdfbJyb7N8gRRq50zMsv+M0c3QgkAMU2D1D5AQeWOEtR92SUz3pw/XiHqUQg4YZgO56+
 XpfaQmpV0+E0q8GW84OoLzt6NrPPFkzsnlFAIRqAtAq+6xOhcbYEK0bm69xnlic+hHdGyknKMs
 bIvK5mJzuPMWSHLEXst9+4eTN4LY7enIbs+Z6S/uSrWRNSNCg0EA19yT1NJr0hzLI4zMi6zjnH
 lv8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:56:57 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 02/21] btrfs: do not BUG_ON with invalid profile
Date:   Tue, 25 Feb 2020 12:56:07 +0900
Message-Id: <20200225035626.1049501-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Do not BUG_ON() when an invalid profile is passed to __btrfs_alloc_chunk().
Instead return -EINVAL with ASSERT() to catch a bug in the development
stage.

Suggested-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9cfc668f91f4..911c6b7c650b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4809,7 +4809,10 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int j;
 	int index;
 
-	BUG_ON(!alloc_profile_is_valid(type, 0));
+	if (!alloc_profile_is_valid(type, 0)) {
+		ASSERT(0);
+		return -EINVAL;
+	}
 
 	if (list_empty(&fs_devices->alloc_list)) {
 		if (btrfs_test_opt(info, ENOSPC_DEBUG))
-- 
2.25.1

