Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAD3389DC8
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 08:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhETGZN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 02:25:13 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49787 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhETGZL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 02:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621491830; x=1653027830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EXQYrOxZjgg6fIYeiBP7M89X55bT/59nLvijsn7XSNc=;
  b=O/tDvXSJBWQSz/vmlOjU7LhQOtE9KEmY4JZa+OsHvYcfhfFFwF7qAE5Y
   nMQMEUIXAZtBJMN8J676yJUb4lSAmxfUgPoVeVudRviG56k8XQaOFe8iE
   O/Gd3bhXQ+hiNVEUuaHfQNVLWs64+Kyr6K/BdmneKdKsQ2M5KEuA8IhNC
   toj73aQ8Exn20LsNO5fqm+Kp2aOgikyjXYXVwaxqzmhHhgRtCvOlQRd11
   Mhnbs09k0sGJax7WadJacJrg+scgMEOVjo68zvpdpMWyeRnhCUfefgSoP
   otCBuZny4dIrni+MjgKqCtUtJA/5DVjBaiDMlTBS/CcJvs4wV40HdmRGm
   Q==;
IronPort-SDR: 8xga3eza7VuP8pMoyKP+X81MDAAENaV2CVXXC0+3url7jD9NKSzqlp47Wed0TLUHj09xm24kzw
 RXNu1ARR1vo0uMs6Mu2IQ/be4R+qySj3Z8uo0X/lz4asLkJxLIC/hixv8JWR7UxQdy3mPRR78X
 rgmxGyoscQ731qYf5MZi3m+fuIzBy+RSKFXvYnUqIlawDPKURsDhoXC9SFeZrmsGstBQjkBNV0
 Sdm8flpknsz1gsYKbW21tzjFkct2iA3O8+PvsUGbEoeUfwK+fX67KjSfSADr13S4ixZKdCtoVv
 1mA=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="173440027"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 14:23:49 +0800
IronPort-SDR: lSWkZTS37S6BbkBJsoBTnosLR5XEhbP9b3bhXRtjTX9CvJ0eRpMBjOBTr1FbFUdespEWoiWFDS
 rVBO10vqHfUi0MfOGizu/NJZjJbyL5o6hmk10ysoqRBB6x14CPM5/1bsUl+TFekvck5YeugYtN
 q4p1RkVim7LA9dbWWhOihyGW1cY6Q5HQPm9bNzwCdDEANtfT8xv2PaQHSvVHWbCFYFFfmV7EA5
 2bLikmLqleg9HBFOQHlGzvjG81xOi1RsJpaxZVJly+ehQFIgARs0MF9ZboABuIc6ngqOv8r1CO
 jTPWEGzyNhfJEi1FBtSo+w+z
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 23:02:14 -0700
IronPort-SDR: RVC2mC4pcgRuyBRlbPvl8QsnjikqrHlKsYWS88jK/HRicADlJ3zUQHFJKCDRpIFNRL/jphUV0L
 hKQnKr9TovrrPUfTjT/zxlH0CPyG/qVm8cqWuGjfW8B3uaWXzmvRqIAjYzu86sZ+gXMroEK68F
 hcmuw05fOUPwzkj/TQxr8Dj1KEaExMj+MYtXr7qEa5wg+TiMeohciwyaw7HDEJNz1FGpQc/jw0
 ggIpqaiB7mcWfrBjzPDuK5n7gweIqK1v0sG5ktt00i+ohk/eNDLOi5VkIO2oMAPclRit73HOS+
 UY0=
WDCIronportException: Internal
Received: from wdsc_char_051.sc.wdc.com (HELO xfs.sc.wdc.com) ([10.4.170.150])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 May 2021 23:23:51 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     axboe@kernel.dk, mb@lightnvm.io, martin.petersen@oracle.com,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        johannes.thumshirn@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        willy@infradead.org, jefflexu@linux.alibaba.com, hch@lst.de,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 7/8] btrfs: fix variable type in btrfs_bio_add_page
Date:   Wed, 19 May 2021 23:22:54 -0700
Message-Id: <20210520062255.4908-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Make variable ret unsigned int since bio_add_zone_append_page() now
returns unsigned int.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 074a78a202b8..6ef276a95237 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3158,8 +3158,8 @@ static bool btrfs_bio_add_page(struct bio *bio, struct page *page,
 			       unsigned long bio_flags)
 {
 	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
+	unsigned int ret;
 	bool contig;
-	int ret;
 
 	if (prev_bio_flags != bio_flags)
 		return false;
-- 
2.24.0

