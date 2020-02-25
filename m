Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F6E16B854
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 04:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgBYD5X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 22:57:23 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34241 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbgBYD5V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 22:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582603041; x=1614139041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XWrI90aDEphiiA5Z6NW3K5GOLZGJ7lzPGm1rMKuq+hg=;
  b=pk+MyDRTR8cPdld1BMIGSK+l8LYDtP2pdezGzriEpsDAwrnhkW1PdNh9
   0InzXvuhCcf7d4rsjQlBbzhtYSCHSjKSXbu+UPDvcVYnhOprsCq5MLaNz
   XEucmN5G4itBrKM+jP6QUzP8ju4e+Zu2ZkwHwNCI8wKfcVeYFB7AEs4dT
   ZOySLsHnkFZh4Qnsgqz1h8Tk/dusZIPS9Pd47oI+2SRjo25HdZkXoKh4a
   JWwRyiCW3MSz2Iaf1qpAUo6M8qbZWfvTwThJYKrlN4rssty5oNKWrTcEC
   pbcT+IZDXP2HpG6Y72RDmGzv1WJQ4hyrXy3o54HcMZs+zq2oidMODjCq9
   g==;
IronPort-SDR: rqop3zUc9d98Q2yTAY5uSppm7eLvEAAyJW+D84V9upUdn8hNI5UQ3A3Z/q0h6MbhOlT9oW+j+G
 FJISJMHho4xmTNkKVKe/VXGalHUSJH6K98wYZxA6P3zD0iY8h0Wfcwdx0F/mau7Wmx4Srx+ugV
 0F5WwCnY77PQNDlRXQQTxcu/oRFU6EY6YHIfcsw9/7jpTQOKkSv1qUKISvs6OywjIizEm3Gk5/
 okXwTSCv92H/ygygKdysnFQ5orVALFOcwlio6TAYxjO9j37ixvzHEOUisl0LhBjQcz3Ee3ZZEF
 2Vo=
X-IronPort-AV: E=Sophos;i="5.70,482,1574092800"; 
   d="scan'208";a="131168314"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 11:57:21 +0800
IronPort-SDR: NfO4TinymR6TuEs4ejiuqvmIJUbNsfP8Fv7KX5KP96//hAKNztpgk4MvuqYgYMu407uKeqlR8L
 TIW//J/TJqISXhhSA2DhyY9u67kbPr94bgF+6WG7CG0u2v/9Kb2kbY3EkXhdp8FptgsLxhlY0K
 RAyR+SCyKp+yM3Ko1mkMsd7141kxqXYPJ9LeoTiQOsDmOz23eHHyrdmfKCa73zS0c4WFb1MuvQ
 OiYwnmW4xCNQbFMlLDR7bhwOcZpdQngEXAIPvHIzxYsqQS8GeLZrRhSaBVHYc53q8KhkPPDB/f
 J4jIwWwu2va3cMp5L75h5guk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 19:49:49 -0800
IronPort-SDR: r4RRgt7DwMBS8zdORmjO7B8i88iZTEm+chR4/S4fhSQcHxuRwwtwwtBnRcDkafBsgCBUr1mCPd
 kyCWpS08AsPqxDqk5m1xCM7ITWJyvQQkssAe7tCiZO6LW8w9htcPihzXl/GUTUYH4UTDGCQ2+h
 dzE1832+pf8wxROnpgQL6RKj4k3GOKA4d4j5pvFdNXWRKsryek69Yhofv/7a4VFPcg2vi2nKDw
 58hSSxJ73cHE0phPOrfr1Z9oO0omsAmZg2M+nZpFCd5hsD/WwvSoBaR1m3MSx7GFRR4TIiowBl
 6qg=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Feb 2020 19:57:21 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 20/21] btrfs: skip LOOP_NO_EMPTY_SIZE if not clustered allocation
Date:   Tue, 25 Feb 2020 12:56:25 +0900
Message-Id: <20200225035626.1049501-21-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225035626.1049501-1-naohiro.aota@wdc.com>
References: <20200225035626.1049501-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LOOP_NO_EMPTY_SIZE is solely dedicated for clustered allocation. So, we can
skip this stage and give up the allocation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index cb82eaf28033..055097bff12b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3848,6 +3848,9 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 		}
 
 		if (ffe_ctl->loop == LOOP_NO_EMPTY_SIZE) {
+			if (ffe_ctl->policy != BTRFS_EXTENT_ALLOC_CLUSTERED)
+				return -ENOSPC;
+
 			/*
 			 * Don't loop again if we already have no empty_size and
 			 * no empty_cluster.
-- 
2.25.1

