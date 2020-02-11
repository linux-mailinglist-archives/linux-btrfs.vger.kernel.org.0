Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFFBC159290
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 16:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgBKPKb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 10:10:31 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35875 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBKPKa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 10:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581433830; x=1612969830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+3grZabNE0tctZ91UB143uJ7lmRoYet3S8VPqzKxLEk=;
  b=CvFmTF4qPIVjo8TdrekoK2oVMpIbZfd0ss9BhhwQVby0gBZ7voJMjP3M
   59THANx9Ot03+syChjT4jW9U1EcI+DnaZ7/QrN9Jq1ULP1AARGTa3SUUg
   n/PwFQq4zQMYCdoDqdpA0YlA1+c2IhJTLR7zjb6erD0JWTl7xJ7XlSPLJ
   h916lNCgzAFRHu0BVfba2AKqQ0cgM9Y8wJLQSWI56aVGkKU3dqgNsciKd
   e3oHrrH7J6fpeOzc9KkUq6+fm6JO10doFBOTudwhIhsZbiWm7dwx4e16Z
   az6QodEsuK3CEULWQC/tm5F0XLAYNKAVX7RrGZaYfpdObCZuxkj9uSnSe
   A==;
IronPort-SDR: Dp2HGsINwAa62eYD6gSr5WuCejD552AO8G9zqg3X+h5fDpS7jGRxQ7t0eDjTAWgFzWIjm4LdxG
 SUkv9iTDF9iEyuzxX5MSKGgYirl0s4/6UeDplbTt8tIMe/y5JfyZITKtk0Pg9uOTx3ZmvzUvLy
 hFm9e8fVOX6aURxILFXRorbv+id0m0Ue7mkufi51s0d7Ls18aenyQPSmLc6lvcgrEOMaOtSDSf
 HofMXz3IwEwhpDGaNsevNwlfO3mD6eyyxbUGntgKDWNhA8R44aEG5nTQZ1rxCzzAJ0B4xyoF6H
 DBI=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="130128671"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2020 23:10:30 +0800
IronPort-SDR: a+ReiYhPdbzwAZQqPW/WW96CfVAWZypfi44hYV+nAUfQXUTZ8r15v5E/oCT9wPejMs+Yr29ifE
 nU6NyZ7Wr8QfUXX542uk1shMWFNs/h/Ph6d2k7yXo7K8eRRBNAJuw2UESBGigs4yz3fblcYDVG
 7Q27evCXRIxsJ/AlejrIReQKs2xHUzbKB336PIx6qAtvQfOmgCxRTrfsYZZTEu2nfOyKaeUY3g
 YE2hi5ALKHhRIwSckZllARaKElF1t9soxbLEpZ82ERCOYcNiwVMnWCYBr24ghaLSnASJb4YoOC
 2fNoRwr1kiQoAUV7v+zKVHQC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 07:03:20 -0800
IronPort-SDR: rdRphJFEF9mhUyJkZIF9KKMQJG+17WmoHf5AmTasoFDHj9X8j+ZbNdUSIyaXAS2ocBgBUWsp/n
 5eGlzmPVSpd4pAWgsieIC3xcF7sK6bhOBGrtDeZHh0LZZ3iqxBT/lMJxQpk0ScvDNQFJlRgtdI
 6omYfq8AA3nz1EsuwOMY9tqslhYosVudwA64zEeAQx5/wVlfBpB6b5/+uleSxRmk2vt746XK2f
 fba8PU5s53NoFggAtmW0frMQZhlFl/3OlwaQSPFx/vg+h4XBAYmY+U9gHZ0yNdtjcIgwDJygqS
 MCM=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Feb 2020 07:10:29 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/5] btrfs: use inode from io_ctl in io_ctl_prepare_pages
Date:   Wed, 12 Feb 2020 00:10:19 +0900
Message-Id: <20200211151023.16060-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200211151023.16060-1-johannes.thumshirn@wdc.com>
References: <20200211151023.16060-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

io_ctl_prepare_pages() get's a 'struct btrfs_io_ctl' as well as a 'struct
inode', but btrfs_io_ctl::inode points to the same struct inode as this is
assgined in io_ctl_init().

Use the inode form io_ctl to reduce the arguments of
io_ctl_prepare_pages().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/free-space-cache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 0598fd3c6e3f..f4ae7629a0e7 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -371,10 +371,10 @@ static void io_ctl_drop_pages(struct btrfs_io_ctl *io_ctl)
 	}
 }
 
-static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, struct inode *inode,
-				int uptodate)
+static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, int uptodate)
 {
 	struct page *page;
+	struct inode *inode = io_ctl->inode;
 	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
 	int i;
 
@@ -732,7 +732,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 
 	readahead_cache(inode);
 
-	ret = io_ctl_prepare_pages(&io_ctl, inode, 1);
+	ret = io_ctl_prepare_pages(&io_ctl, 1);
 	if (ret)
 		goto out;
 
@@ -1291,7 +1291,7 @@ static int __btrfs_write_out_cache(struct btrfs_root *root, struct inode *inode,
 	}
 
 	/* Lock all pages first so we can lock the extent safely. */
-	ret = io_ctl_prepare_pages(io_ctl, inode, 0);
+	ret = io_ctl_prepare_pages(io_ctl, 0);
 	if (ret)
 		goto out_unlock;
 
-- 
2.16.4

