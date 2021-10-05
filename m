Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5C0421ED1
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 08:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhJEGZY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 02:25:24 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61157 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhJEGZX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 02:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633415013; x=1664951013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K1fB5ICnOv9vPqUZ94BhSkHs5ngbM4t7Ik+Z0/PVlT0=;
  b=f96bQ2ACkzRnEg+R9VEOETV0KRMaW21s4bRDydKZqfAh4fdFXTUQPqoO
   KLLfuBOesg3k9bpPHM7EWUsaAx2LAiLrzXRxdGEFKvwsLAyvQa90q/tGG
   pARJPf3082CU3roN3QdbflZ0ZKbByJ/DNXSZQsTBIZ1G8JDoPs5WPlsI4
   fcWzTDWC178Q/FBUy3gOFQyXGvo7KCUvSrkN0lxTC4DVnhZrql6CTCCwO
   04cVr2jBi2TPTmLigQPmxR0oG3WeRQNsW3m1Zm+jSBaFckQVOcSng4zhQ
   0f4xTsfRbB/9M0gj7hZyUet0AfOvJXkaTsjC8Tr31Z+pAK3t5AxRlLy1t
   w==;
X-IronPort-AV: E=Sophos;i="5.85,347,1624291200"; 
   d="scan'208";a="186648917"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2021 14:23:33 +0800
IronPort-SDR: 3P/rPhSG0yB9cC3MzhHFzevXwnBuYZMmaEWlwhYl1FcFm2Zju5Q5NerS3M4GopGv6AEx26FDS7
 S8L1yAez81RqF3PSq/bGwEWDd2yUPzeWpyoqV8EhRQf33L/3EbwkiRKBP8qfqT2rEKxe1wJdNF
 A34lRJCdmv6b0lg4OXD2SdNAvkYvba1Ka1qwmxSF2IaRZhw238eg7K9TcGf9SPXB0DAPsOxs0y
 KqLqw6Deq03ilrivR6ste5A5Wff/10mXDYbJN7l8UGGvpf94UVj8a446mg6jI2k8SgBcU4CUis
 O3DEj1kbfuGWhOTXuqgJuhBc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 22:57:57 -0700
IronPort-SDR: TeMTui04gHF062zZuAX2voYonImexxrW0HuKEa+ChV3SimtMBR33GqOtQukoNl3Qw+20gVETWS
 6pFzg2rb/2PALyfF8ew60IAo96QMwWdZR84tYcE6p979IwD11cFO1J88brHOLNY3sQT2J0nA/n
 KdcDwjOvI4dKN1HU5SdifIHw4h1dB12co1XQGi9rOnXdkTAbyWiFXhL2xIRiTOvY6lOacRbPDH
 xUds3F7pDmX3TKNDseip2Pi2U2toCB9y4GGw7JcJo2S1JfZZkoVQWvmquEKdbgluaJYci9TJi3
 j3M=
WDCIronportException: Internal
Received: from g8961f3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.178])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Oct 2021 23:23:33 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 6/7] btrfs-progs: temporally set zoned flag for initial tree reading
Date:   Tue,  5 Oct 2021 15:23:04 +0900
Message-Id: <20211005062305.549871-7-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005062305.549871-1-naohiro.aota@wdc.com>
References: <20211005062305.549871-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Functions to read data/metadata e.g. read_extent_from_disk() now depend on
the fs_info->zoned flag to determine if they do direct-IO or not.

The flag (and zone_size) is not known before reading the chunk tree and it
set to 0 while in the initial chunk tree setup process. That will cause
btrfs_pread() to fail because it does not align the buffer.

Use fcntl() to find out the file descriptor is opened with O_DIRECT or not,
and if it is, set the zoned flag to 1 temporally for this initial process.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 kernel-shared/disk-io.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 740500f9fdc9..dd48599a5f1f 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1302,10 +1302,22 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *oc
 	if (ret)
 		goto out_devices;
 
+	/*
+	 * fs_info->zone_size (and zoned) are not known before reading the
+	 * chunk tree, so it's 0 at this point. But, fs_info->zoned == 0
+	 * will cause btrfs_pread() not to use an aligned bounce buffer,
+	 * causing EINVAL when the file is opened with O_DIRECT. Temporally
+	 * set zoned = 1 in that case.
+	 */
+	if (fcntl(fp, F_GETFL) & O_DIRECT)
+		fs_info->zoned = 1;
+
 	ret = btrfs_setup_chunk_tree_and_device_map(fs_info, ocf->chunk_tree_bytenr);
 	if (ret)
 		goto out_chunk;
 
+	fs_info->zoned = 0;
+
 	/* Chunk tree root is unable to read, return directly */
 	if (!fs_info->chunk_root)
 		return fs_info;
-- 
2.33.0

