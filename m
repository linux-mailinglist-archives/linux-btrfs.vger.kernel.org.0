Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C1418A3A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 21:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgCRUTA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 16:19:00 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.124]:20623 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726836AbgCRUTA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 16:19:00 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 67FF6CC0F
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Mar 2020 15:18:59 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id Ef9XjUuwT1s2xEf9XjDUHt; Wed, 18 Mar 2020 15:18:59 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qd2sBufH3yYuOMkDsTyAwBL8CIUkfdqCnMCx10pwlnY=; b=rVK55Vo5Yd6KP2trOs0N7nxIa/
        9tkTJHIdxLb5dbIW/RCZSA/0DerSMmfsqdYbgz2p/pR65aHV3PuJj2DDexPQhd4SW2JXoaidc7dA4
        zOsZfvSxV/eV8YBXvGFZ7+qVRC540ZPPDRpL8U6qjkF+PcSnI1v/xAs3wjr5c3fGMQDNd/lUq/fZf
        I1wCoM3FCPvTCkFPmx1NnyZDOPOLa4K/LxUZmscvM43F8BDBsVaviGslJJbUMEzS1MWp0TJ/a6A6P
        NcUyEGAK5lFNkuBmLcIoow6w7fpmvDalQpr7YA/EHMVh0bBFmRDloxusFa5Kho48iyLnii5kbxxIp
        II9TYNDg==;
Received: from [191.249.66.103] (port=50308 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jEf9W-000yAj-RF; Wed, 18 Mar 2020 17:18:59 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Subject: [PATCH v4 09/11] btrfs-progs: mkfs: Introduce mkfs time quota support
Date:   Wed, 18 Mar 2020 17:21:46 -0300
Message-Id: <20200318202148.14828-10-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200318202148.14828-1-marcos@mpdesouza.com>
References: <20200318202148.14828-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 191.249.66.103
X-Source-L: No
X-Exim-ID: 1jEf9W-000yAj-RF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.prv.suse.net) [191.249.66.103]:50308
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 32
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

The result fs will has quota enabled, with consistent qgroup accounting.

This is quite handy to test quota with fstests, which doesn't support to
call ioctl for btrfs at mount time.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/mkfs.btrfs.asciidoc |  5 +++++
 mkfs/main.c                       | 16 +++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/mkfs.btrfs.asciidoc b/Documentation/mkfs.btrfs.asciidoc
index 0502d1d8..611ea9c2 100644
--- a/Documentation/mkfs.btrfs.asciidoc
+++ b/Documentation/mkfs.btrfs.asciidoc
@@ -87,6 +87,11 @@ updating the metadata blocks.
 +
 NOTE: versions up to 3.11 set the nodesize to 4k.
 
+*-Q|--quota*::
+Enable btrfs quota support. Result filesystem will have quota enabled and all
+qgroup accounting correct.
+See also `btrfs-quota`(8).
+
 *-s|--sectorsize <size>*::
 Specify the sectorsize, the minimum data block allocation unit.
 +
diff --git a/mkfs/main.c b/mkfs/main.c
index 1fb25a9d..70a66cef 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -949,6 +949,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	char *source_dir = NULL;
 	bool source_dir_set = false;
 	bool shrink_rootdir = false;
+	bool enable_quota = false;
 	u64 source_dir_size = 0;
 	u64 min_dev_size;
 	u64 shrink_size;
@@ -985,13 +986,14 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ "nodiscard", no_argument, NULL, 'K' },
 			{ "features", required_argument, NULL, 'O' },
 			{ "uuid", required_argument, NULL, 'U' },
+			{ "quota", required_argument, NULL, 'Q' },
 			{ "quiet", 0, NULL, 'q' },
 			{ "shrink", no_argument, NULL, GETOPT_VAL_SHRINK },
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP },
 			{ NULL, 0, NULL, 0}
 		};
 
-		c = getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:O:r:U:VMKq",
+		c = getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:O:r:U:VMKqQ",
 				long_options, NULL);
 		if (c < 0)
 			break;
@@ -1066,6 +1068,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			case 'q':
 				verbose = 0;
 				break;
+			case 'Q':
+				enable_quota = true;
+				break;
 			case GETOPT_VAL_SHRINK:
 				shrink_rootdir = true;
 				break;
@@ -1470,6 +1475,15 @@ raid_groups:
 		}
 	}
 
+	if (enable_quota) {
+		ret = setup_quota_root(fs_info);
+		if (ret < 0) {
+			error("failed to initialize quota: %d (%s)", ret,
+				strerror(-ret));
+			goto out;
+		}
+	}
+
 	if (verbose) {
 		char features_buf[64];
 
-- 
2.25.0

