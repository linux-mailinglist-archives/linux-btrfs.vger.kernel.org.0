Return-Path: <linux-btrfs+bounces-11800-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A106A44D0B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 21:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3065D3B404C
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 20:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AB022A7E6;
	Tue, 25 Feb 2025 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PXqlaqa8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6930B22157B;
	Tue, 25 Feb 2025 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514646; cv=none; b=kAOTaNxe8Yc3YNQIvw9wC0Yb2r696M6IAyE9qAVwUtJxHrp+sSAWXEsmc/hfn4+tRnPG+J+2fTE4EO0/RV2Gl+V0Bov2TdQ8V0J0HEWFCMhmkJ4kJTB/5mVvkhINFqBaAoBON4GwU1ZO5f7BcSq+wPQDuNAj1inhBTYtddTegVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514646; c=relaxed/simple;
	bh=XpRal1wj/Zz/vEKSbdtAbxyigll6PJWqNf6bgOa/uwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b6UcrMEyogE9UvGC/9YkETzMn3aQ6btYNN59scdbTuYVvVEvVq0iqB9FSCsSlXyL61SV26jLNtmFdDOqTWeZvpnsZUp1n/QEhTYUy1sZSDGR+TAYYKRuJQF4MEArbQyzcmhclIPp4jLMUt6ollqa1tQcI0V11U/03+eZqveQKJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PXqlaqa8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id C2CA6206940D;
	Tue, 25 Feb 2025 12:17:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2CA6206940D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514640;
	bh=RCLH8aXh/e5sdYq7k7e2qGUG/PeWI3Ghf2E96MmmOCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PXqlaqa8hq7wCvePSwmkX/hYzUg+ju9Ou7bMg+YX8hyBGTbIPc21VpF1/Rau+Mozk
	 IFavdSKToQk7As2VHypOAXb4xve0beBhRHj2pB6jSrbyLVhpMjqfct4Ik7cqdh5u5O
	 CrVVlAliI3k9dFPrPolatWSJ8hKmlQi8g6zOp6X0=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:21 +0000
Subject: [PATCH v3 07/16] libceph: convert timeouts to secs_to_jiffies()
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-7-a43967e36c88@linux.microsoft.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
 James Smart <james.smart@broadcom.com>, 
 Dick Kennedy <dick.kennedy@broadcom.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>, 
 Xiubo Li <xiubli@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>, 
 Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication

This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
the following Coccinelle rules:

@depends on patch@ expression E; @@

-msecs_to_jiffies(E * 1000)
+secs_to_jiffies(E)

@depends on patch@ expression E; @@

-msecs_to_jiffies(E * MSEC_PER_SEC)
+secs_to_jiffies(E)

While here, remove the no-longer necessary checks for range since there's
no multiplication involved.

Acked-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 include/linux/ceph/libceph.h | 12 ++++++------
 net/ceph/ceph_common.c       | 18 ++++++------------
 net/ceph/osd_client.c        |  3 +--
 3 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 733e7f93db66a7a29a4a8eba97e9ebf2c49da1f9..5f57128ef0c7d018341c15cc59288aa47edec646 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -72,15 +72,15 @@ struct ceph_options {
 /*
  * defaults
  */
-#define CEPH_MOUNT_TIMEOUT_DEFAULT	msecs_to_jiffies(60 * 1000)
-#define CEPH_OSD_KEEPALIVE_DEFAULT	msecs_to_jiffies(5 * 1000)
-#define CEPH_OSD_IDLE_TTL_DEFAULT	msecs_to_jiffies(60 * 1000)
+#define CEPH_MOUNT_TIMEOUT_DEFAULT	secs_to_jiffies(60)
+#define CEPH_OSD_KEEPALIVE_DEFAULT	secs_to_jiffies(5)
+#define CEPH_OSD_IDLE_TTL_DEFAULT	secs_to_jiffies(60)
 #define CEPH_OSD_REQUEST_TIMEOUT_DEFAULT 0  /* no timeout */
 #define CEPH_READ_FROM_REPLICA_DEFAULT	0  /* read from primary */
 
-#define CEPH_MONC_HUNT_INTERVAL		msecs_to_jiffies(3 * 1000)
-#define CEPH_MONC_PING_INTERVAL		msecs_to_jiffies(10 * 1000)
-#define CEPH_MONC_PING_TIMEOUT		msecs_to_jiffies(30 * 1000)
+#define CEPH_MONC_HUNT_INTERVAL		secs_to_jiffies(3)
+#define CEPH_MONC_PING_INTERVAL		secs_to_jiffies(10)
+#define CEPH_MONC_PING_TIMEOUT		secs_to_jiffies(30)
 #define CEPH_MONC_HUNT_BACKOFF		2
 #define CEPH_MONC_HUNT_MAX_MULT		10
 
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 4c6441536d55b6323f4b9d93b5d4837cd4ec880c..c2a2c3bcc4e91a628c99bd1cef1211d54389efa2 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -527,29 +527,23 @@ int ceph_parse_param(struct fs_parameter *param, struct ceph_options *opt,
 
 	case Opt_osdkeepalivetimeout:
 		/* 0 isn't well defined right now, reject it */
-		if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000)
+		if (result.uint_32 < 1)
 			goto out_of_range;
-		opt->osd_keepalive_timeout =
-		    msecs_to_jiffies(result.uint_32 * 1000);
+		opt->osd_keepalive_timeout = secs_to_jiffies(result.uint_32);
 		break;
 	case Opt_osd_idle_ttl:
 		/* 0 isn't well defined right now, reject it */
-		if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000)
+		if (result.uint_32 < 1)
 			goto out_of_range;
-		opt->osd_idle_ttl = msecs_to_jiffies(result.uint_32 * 1000);
+		opt->osd_idle_ttl = secs_to_jiffies(result.uint_32);
 		break;
 	case Opt_mount_timeout:
 		/* 0 is "wait forever" (i.e. infinite timeout) */
-		if (result.uint_32 > INT_MAX / 1000)
-			goto out_of_range;
-		opt->mount_timeout = msecs_to_jiffies(result.uint_32 * 1000);
+		opt->mount_timeout = secs_to_jiffies(result.uint_32);
 		break;
 	case Opt_osd_request_timeout:
 		/* 0 is "wait forever" (i.e. infinite timeout) */
-		if (result.uint_32 > INT_MAX / 1000)
-			goto out_of_range;
-		opt->osd_request_timeout =
-		    msecs_to_jiffies(result.uint_32 * 1000);
+		opt->osd_request_timeout = secs_to_jiffies(result.uint_32);
 		break;
 
 	case Opt_share:
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b24afec241382b60d775dd12a6561fa23a7eca45..ba61a48b4388c2eceb5b7a299906e7f90191dd5d 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4989,8 +4989,7 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 	linger_submit(lreq);
 	ret = linger_reg_commit_wait(lreq);
 	if (!ret)
-		ret = linger_notify_finish_wait(lreq,
-				 msecs_to_jiffies(2 * timeout * MSEC_PER_SEC));
+		ret = linger_notify_finish_wait(lreq, secs_to_jiffies(2 * timeout));
 	else
 		dout("lreq %p failed to initiate notify %d\n", lreq, ret);
 

-- 
2.43.0


