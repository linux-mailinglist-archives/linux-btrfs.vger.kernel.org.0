Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD27521D5F2
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 14:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbgGMM3N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 08:29:13 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19772 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbgGMM3K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 08:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594643348; x=1626179348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+xA6xZfQbYpVOG6CLdU4tovv5U0Sd9oi2wfTHzhpWiU=;
  b=Snv1vcH1jhJXNxH500il4Obb/JIzSzv91tlybsuJYTxiEBjWsD3av/pF
   5gO6l3V9v0D3X3AAloguc4Cgc4yThxvCh6grEx1Xk9XVLHhFvuE/Odm3Q
   o8SU85d254wLKm+8IpUr7Ig7WXHMevaCxeJfBKI8gbb8kE78c8DZXs5dV
   ceLHfg56ql2UKKcLWV4JvEVI0DHZ54xpon+NIWKLkqhIOgBmGeB7Gfa91
   uCZQHh9qXnnT6smbOSDcLmKYR9eOu7DYTkY7NQtbsPhQIu1WMNJhy8xdr
   2bgMSu+gazlTXK4BPDR9kx3q/Wr8GD6J+RkqvY+EhiVY8KNUZKkvNrdhu
   w==;
IronPort-SDR: A4FuUOmqrpkWxp9Elpabz1VOnKg70QhrlrgsDZz4xI3cZYbCQwISlX0+UUN/uIiQbNQEgER71M
 Gcr+9oFzwGAMx6g2jNK1x9TkXuTL92hAvbRQYgnjQ9d/9HMh36ferjUKhMVvMz823ceW0zYXdm
 1jtAOrtWEZ1EyA7vAeWM4WUNwLW7azTRjw325FxVXjuYc4dUCLmd8ccvy6+Px9JIoMyvtK93J6
 mlFUfznF74iVGPC0XY96daMT3LUrE765XH8SVrLuL57M0TqImWzk1ZqHQ6yTa8esnbxMhFgdM2
 xEE=
X-IronPort-AV: E=Sophos;i="5.75,347,1589212800"; 
   d="scan'208";a="142312951"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2020 20:29:08 +0800
IronPort-SDR: ZrEy51MGEvBbPz/cVXf2Jwz381QfctpI2UioLIqMz0ureMesUcWfjL/MupNuD5gevBtikrDm0A
 iM2ZHxOqfroWxP5SNcJCJc3yi9OhV0wYU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 05:17:37 -0700
IronPort-SDR: Qky5Lg1Hw+IMtDt65UfVP8xACAayJrk115Y9+eGDBv1ghPxbT5JwcsDRtrfinOKkZ+zA2HEBdd
 4LAOOH6bNvWw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2020 05:29:08 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/4] btrfs: add filesystem generation to fsinfo ioctl
Date:   Mon, 13 Jul 2020 21:28:59 +0900
Message-Id: <20200713122901.1773-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200713122901.1773-1-johannes.thumshirn@wdc.com>
References: <20200713122901.1773-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add retrieval of the filesystem's generation to the fsinfo ioctl. This is
driven by setting the BTRFS_FS_INFO_FLAG_GENERATION flag in
btrfs_ioctl_fs_info_args::flags.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ioctl.c           | 5 +++++
 include/uapi/linux/btrfs.h | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 3a566cf71fc6..f1b433ec09e8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3247,6 +3247,11 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
 		fi_args->flags |= BTRFS_FS_INFO_FLAG_CSUM_INFO;
 	}
 
+	if (flags_in & BTRFS_FS_INFO_FLAG_GENERATION) {
+		fi_args->generation = fs_info->generation;
+		fi_args->flags |= BTRFS_FS_INFO_FLAG_GENERATION;
+	}
+
 	if (copy_to_user(arg, fi_args, sizeof(*fi_args)))
 		ret = -EFAULT;
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index b3e0af77642f..b8373723eb4a 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -250,6 +250,9 @@ struct btrfs_ioctl_dev_info_args {
 /* Request information about checksum type and size */
 #define BTRFS_FS_INFO_FLAG_CSUM_INFO			(1 << 0)
 
+/* Request information about filesystem generation */
+#define BTRFS_FS_INFO_FLAG_GENERATION			(1 << 1)
+
 struct btrfs_ioctl_fs_info_args {
 	__u64 max_id;				/* out */
 	__u64 num_devices;			/* out */
@@ -261,7 +264,8 @@ struct btrfs_ioctl_fs_info_args {
 	__u16 csum_type;			/* out */
 	__u16 csum_size;			/* out */
 	__u64 flags;				/* in/out */
-	__u8 reserved[968];			/* pad to 1k */
+	__u64 generation;			/* out */
+	__u8 reserved[960];			/* pad to 1k */
 };
 
 
-- 
2.26.2

