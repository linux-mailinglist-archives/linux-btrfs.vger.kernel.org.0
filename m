Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E753199EB0
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 21:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgCaTKx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 15:10:53 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:59717 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727509AbgCaTKx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 15:10:53 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-16.iol.local with ESMTPA
        id JMHijXV70jfNYJMHjj3qIS; Tue, 31 Mar 2020 21:10:51 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585681851; bh=jiB7VSegMmHun/qtf1IscaDsX3ydWWc+sMSu9KK9XX0=;
        h=From;
        b=gdMTnS2kQYneRdX1HODsqF3WDVlpvqsvI6Cee0WOH9sdFN4ueZPocIuriAwZIpsiH
         gznlpxiS8pCGD9aKVe7lQoPvXE9YTPuRnmNF+uZXyCR85+4f+k+0q839UgtyodB28M
         JhxsmML3oxtlARXUk8vQmbbbyYYTXv23/hyxdpX6mSHZ5drkqPb6gsQFx5tEPIkfog
         Gam7IoAhXK6NDm1LqKYLBarZ1EydurDGlFm0dO5huAvpNC5AogduNHJk+G4H9DCxoS
         3pFpnC+cHh53IduDnZfUNyyE4dLI3ceGoOLG74Lj3xLr4vMn7S92ExNs6ysfHlWY86
         5poRZfmJFC4Dw==
X-CNFS-Analysis: v=2.3 cv=av7M9hRV c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=4G7CR4st1VtwzTxLfKwA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/4] Complete the implementation of RAID1C[34].
Date:   Tue, 31 Mar 2020 21:10:42 +0200
Message-Id: <20200331191045.8991-2-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331191045.8991-1-kreijack@libero.it>
References: <20200331191045.8991-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGNfLIHCkLZha9d5dLtr7lsKmMdrqTXWKjPExfzL24rKaiOhP05e2IuAS8mgYOBQ7n/WFTWzKxrs8waBs59DvmAOYl0UHtvoESmNGPjQQbe1Ct9ywePY
 cLjDv3yncj3M9CTr4Fnt06QQUtAUgp+oqHrlLNDVhAi2n5CQZTLaBYqNNx+HBp0wH5PLeOkL/D3SCMGfquR0QMF308wzWPbLVsXXTrS5GDT+YzW/HdlMcPrF
 Aj0OEcDmKJF7eKrmljdqxCa0FUZgSqsHX2Lja0lIaKUMElcIW733xuWE3etbT0otLV8Ar6e8zctT50v2X/QvOA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

- Complete the function btrfs_err_str adding some missing cases.
- Sync the enum btrfs_err_code (in ibbtrfsutil/btrfs.h) with the
rest of the codes (user space and kernel space).
- Add missing fields to btrfs_raid_array[] for raid1c[34]

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 ioctl.h              | 4 ++++
 libbtrfsutil/btrfs.h | 4 +++-
 volumes.c            | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/ioctl.h b/ioctl.h
index 4e7efd94..ade6dcb9 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -798,6 +798,10 @@ static inline char *btrfs_err_str(enum btrfs_err_code err_code)
 	switch (err_code) {
 		case BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET:
 			return "unable to go below two devices on raid1";
+		case BTRFS_ERROR_DEV_RAID1C3_MIN_NOT_MET:
+			return "unable to go below three devices on raid1c3";
+		case BTRFS_ERROR_DEV_RAID1C4_MIN_NOT_MET:
+			return "unable to go below four devices on raid1c4";
 		case BTRFS_ERROR_DEV_RAID10_MIN_NOT_MET:
 			return "unable to go below four devices on raid10";
 		case BTRFS_ERROR_DEV_RAID5_MIN_NOT_MET:
diff --git a/libbtrfsutil/btrfs.h b/libbtrfsutil/btrfs.h
index 4bc12754..60d51ff6 100644
--- a/libbtrfsutil/btrfs.h
+++ b/libbtrfsutil/btrfs.h
@@ -830,7 +830,9 @@ enum btrfs_err_code {
 	BTRFS_ERROR_DEV_TGT_REPLACE,
 	BTRFS_ERROR_DEV_MISSING_NOT_FOUND,
 	BTRFS_ERROR_DEV_ONLY_WRITABLE,
-	BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS
+	BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS,
+	BTRFS_ERROR_DEV_RAID1C3_MIN_NOT_MET,
+	BTRFS_ERROR_DEV_RAID1C4_MIN_NOT_MET,
 };
 
 #define BTRFS_IOC_SNAP_CREATE _IOW(BTRFS_IOCTL_MAGIC, 1, \
diff --git a/volumes.c b/volumes.c
index b46bf598..7f84fbba 100644
--- a/volumes.c
+++ b/volumes.c
@@ -65,6 +65,9 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.tolerated_failures = 2,
 		.devs_increment	= 3,
 		.ncopies	= 3,
+		.raid_name	= "raid1c3",
+		.bg_flag	= BTRFS_BLOCK_GROUP_RAID1C3,
+		.mindev_error	= BTRFS_ERROR_DEV_RAID1C3_MIN_NOT_MET,
 	},
 	[BTRFS_RAID_RAID1C4] = {
 		.sub_stripes	= 1,
@@ -74,6 +77,9 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.tolerated_failures = 3,
 		.devs_increment	= 4,
 		.ncopies	= 4,
+		.raid_name	= "raid1c4",
+		.bg_flag	= BTRFS_BLOCK_GROUP_RAID1C4,
+		.mindev_error	= BTRFS_ERROR_DEV_RAID1C4_MIN_NOT_MET,
 	},
 	[BTRFS_RAID_DUP] = {
 		.sub_stripes	= 1,
-- 
2.26.0

