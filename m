Return-Path: <linux-btrfs+bounces-2054-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 215BD846596
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 02:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86F61F26F9A
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 01:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F72BE59;
	Fri,  2 Feb 2024 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="qciq9Dl/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A534BE55;
	Fri,  2 Feb 2024 01:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706838855; cv=none; b=U1xggK2bIt3JpVT91mrh4YHKmKBE0r/JkTaWUdnMscv1hN5UCAoBkIg7KorpPPCrmKgXbCPdZmsFmDmhc5IXgZayMbFGJ3KM+HMYwC60xNASlL5TDHtk1bQTtKgwdDPeHxf7OE14gfAn1XryX1aFEo00cfWoNXjUOmFmVt5JVFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706838855; c=relaxed/simple;
	bh=vsD8NVDlsuUy+gkg9e+2hn/r5frQVC4+m3fkTZ7yDtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wl7+4CiNGUEkLpvJGOtQHq5kZVmWxe+y4k0qVgIJ3wfoSzbgqmramOAqro4uW4T8Tk2yDGdq6rlNWZBJiNBXt44avSkJMT/EKgHqPPOpFDzR7glelPgLilstqz3Reb2xQMhxjfkABozCOjTtHYZo41lJTxAznziXT/J95qBIsRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=qciq9Dl/; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1706838854; x=1738374854;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vsD8NVDlsuUy+gkg9e+2hn/r5frQVC4+m3fkTZ7yDtQ=;
  b=qciq9Dl/Lwu3m3NYVALd1ewJPCuO50nmLNZ/H01IjmKQLDI74Gw4Gl+J
   8nDpDnui5euXKqpcolMK0ftwptAuFr1JrwPNKvYch3l0UmTXMQpwKiUYi
   prvBeOjBpIyzESb2roWgo7+PiSx6EIft6rUriFwMxPpBVohuQIF3YvCBI
   wx5BHgyoJNTexARoncMhMmMbrKMRydq3qetokZB1fdne55i/m2QjMFCBa
   MepOMhvqZrIU2GWsQaNTK8ku8tTIlinA4H7SCXuIrci1cZEuqqbUmegfD
   FVWQf83jzordoVAh9VSgqMjEmEjli5LmjKqBtw3CRQ1bHHW9iS6nwQZEU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="147948400"
X-IronPort-AV: E=Sophos;i="6.05,236,1701097200"; 
   d="scan'208";a="147948400"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 10:53:02 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 67617CA205;
	Fri,  2 Feb 2024 10:52:59 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id A5B2FD41E3;
	Fri,  2 Feb 2024 10:52:58 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 46FE2E253A;
	Fri,  2 Feb 2024 10:52:58 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id E76C41A009A;
	Fri,  2 Feb 2024 09:52:57 +0800 (CST)
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Cc: Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2] t_snapshot_deleted_subvolume: add check for BTRFS_IOC_SNAP_DESTROY_V2
Date: Wed, 31 Jan 2024 23:23:48 -0500
Message-Id: <20240201042348.147733-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28158.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28158.003
X-TMASE-Result: 10--0.230800-10.000000
X-TMASE-MatchedRID: JUGAxiLh1cPcaPLLdBjevxqkhv3OdF4Dh6nwisY6+c0ErOtgylrM6mnX
	UUBQ4UsQbn+bq+W8j6V2vbKZ0Ubwp5nFDQsuYb5/W1M77Gh1ugYJlr1xKkE5ucC5DTEMxpeQfiq
	1gj2xET/gr0WZ6u+ypRIlVYCqhV5OHxPMjOKY7A8LbigRnpKlKZx+7GyJjhAUDVqkdheCqj8fYV
	pT7I/EHPdoaGy1IdC2/4uhiNc5tAeTp/b1uB9fwNvEw5dGxRulytIt/mHZpcMuYHZzOnqbEULkl
	G2PtdM1mw0Qaktp+ussz+cQMs/Tnp75MOLIf/j3DF+QsB+Q01JoBmTSwRxjXg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

On some platform, struct btrfs_ioctl_vol_args_v2 is defined, but the
macros BTRFS_IOC_SNAP_DESTROY_V2 is not defined. This will cause
compile error. Add check for BTRFS_IOC_SNAP_DESTROY_V2 to solve this
problem.

BTRFS_IOC_SNAP_CREATE_V2 and BTRFS_IOC_SUBVOL_CREATE_V2 were
introduced together with struct btrfs_ioctl_vol_args_v2 by the
commit 55e301fd57a6 ("Btrfs: move fs/btrfs/ioctl.h to
include/uapi/linux/btrfs.h"). So there is no need to check them.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 configure.ac                       |  1 +
 src/t_snapshot_deleted_subvolume.c | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index b22fc52b..b14b1ab8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -109,6 +109,7 @@ AC_CHECK_MEMBERS([struct btrfs_ioctl_vol_args_v2.subvolid], [], [], [[
 #include <stddef.h>
 #include <linux/btrfs.h>
 ]])
+AC_CHECK_DECLS([BTRFS_IOC_SNAP_DESTROY_V2],,,[#include <linux/btrfs.h>])
 
 AC_CONFIG_HEADERS([include/config.h])
 AC_CONFIG_FILES([include/builddefs])
diff --git a/src/t_snapshot_deleted_subvolume.c b/src/t_snapshot_deleted_subvolume.c
index c3adb1c4..402c0515 100644
--- a/src/t_snapshot_deleted_subvolume.c
+++ b/src/t_snapshot_deleted_subvolume.c
@@ -20,11 +20,6 @@
 #define BTRFS_IOCTL_MAGIC 0x94
 #endif
 
-#ifndef BTRFS_IOC_SNAP_DESTROY_V2
-#define BTRFS_IOC_SNAP_DESTROY_V2 \
-	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
-#endif
-
 #ifndef BTRFS_IOC_SNAP_CREATE_V2
 #define BTRFS_IOC_SNAP_CREATE_V2 \
 	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
@@ -58,6 +53,11 @@ struct btrfs_ioctl_vol_args_v2 {
 };
 #endif
 
+#if !HAVE_DECL_BTRFS_IOC_SNAP_DESTROY_V2
+#define BTRFS_IOC_SNAP_DESTROY_V2 \
+	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
+#endif
+
 int main(int argc, char **argv)
 {
 	if (argc != 2) {
-- 
2.39.3


