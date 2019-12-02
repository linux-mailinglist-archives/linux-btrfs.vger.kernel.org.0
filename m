Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8506610EF0D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 19:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfLBSTh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 13:19:37 -0500
Received: from smtp-18.italiaonline.it ([213.209.10.18]:59547 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727898AbfLBSTh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Dec 2019 13:19:37 -0500
Received: from venice.bhome ([84.220.25.30])
        by smtp-18.iol.local with ESMTPA
        id bqIHizXEsNNGebqIIidLfD; Mon, 02 Dec 2019 19:19:34 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1575310774; bh=d5J2z1w0T19VOpLdY/rfLZxI50QxrKgZ6iGJcZhPPcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NGRcaluck4r7llKek4Ij0Oz0WDGJnU2YQy4HkDBqfmTr7uHKDEa8Nz/PeyZdHuFnv
         n7u91Grp7IqEqoU8oUJADTY7mPUnUQ33C6ltrlQuWvJ5nnT3/9/NrTS3Mxwlb3cONx
         byhX5uO0NUGa9WeWD7nvoxuHE78vWeldnqiOFAM3UQMu5n4E866j8rf3gp5E9wM4wn
         uXLbo2A1KghkFioaqnv9jZ2l3wTfbNtcA3C+HFi8Nj+s5bhuo/6M2lSuwtHD5JJC5t
         W6sGlrin+FpQFgsTUT7jHP3cSv3RKp+HRhrjTW2arEPx2/+Hwm3y6/es7P79fdarGK
         gCeQ8GlA6HcEQ==
X-CNFS-Analysis: v=2.3 cv=B4jHL9lM c=1 sm=1 tr=0
 a=zfQl08sXljvZd6EmK9/AFg==:117 a=zfQl08sXljvZd6EmK9/AFg==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=f-10ACRE3To8864kkSMA:9
 a=1T4bNiD3cw4QP5G4:21 a=Mes8qeG62ao3A4co:21
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH] btrfs: add support for RAID1C3 and RAID1C4
Date:   Mon,  2 Dec 2019 19:19:28 +0100
Message-Id: <20191202181928.3098-2-kreijack@libero.it>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202181928.3098-1-kreijack@libero.it>
References: <20191202181928.3098-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBtZ8+d5evT+aAQb5+VPyGdO2xixP9IO1c3C4fWVCTfLFgfzVzcx9Zf/wM20tnu6U/y3AhmRARybpI2VrbF6SMj6YO40aCi4KAVwn4w1sayx5qv+Ridm
 TMw+t5XNSULMoy+/ZC0j8ww3EG+9GMMya9gH3z9reo1zDGe+O32wDWK+Jfib+AIOO0PT3EyaAh4Jr6JF7y+qKqsw39OE/FEymv8X7mOFLvaZxpanySEXSIaI
 icdfmLm2oN6wj9VMUR1giA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 grub-core/fs/btrfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/grub-core/fs/btrfs.c b/grub-core/fs/btrfs.c
index 48bd3d04a..191c5cd63 100644
--- a/grub-core/fs/btrfs.c
+++ b/grub-core/fs/btrfs.c
@@ -136,6 +136,8 @@ struct grub_btrfs_chunk_item
 #define GRUB_BTRFS_CHUNK_TYPE_RAID10        0x40
 #define GRUB_BTRFS_CHUNK_TYPE_RAID5         0x80
 #define GRUB_BTRFS_CHUNK_TYPE_RAID6         0x100
+#define GRUB_BTRFS_CHUNK_TYPE_RAID1C3       0x200
+#define GRUB_BTRFS_CHUNK_TYPE_RAID1C4       0x400
   grub_uint8_t dummy2[0xc];
   grub_uint16_t nstripes;
   grub_uint16_t nsubstripes;
@@ -1088,6 +1090,24 @@ grub_btrfs_read_logical (struct grub_btrfs_data *data, grub_disk_addr_t addr,
 	      stripe_offset = chunk_stripe_length * high + low;
 	      csize = chunk_stripe_length - low;
 
+	      break;
+	    }
+	  case GRUB_BTRFS_CHUNK_TYPE_RAID1C3:
+	    {
+	      grub_dprintf ("btrfs", "RAID1C3\n");
+	      stripen = 0;
+	      stripe_offset = off;
+	      csize = grub_le_to_cpu64 (chunk->size) - off;
+	      redundancy = 3;
+	      break;
+	    }
+	  case GRUB_BTRFS_CHUNK_TYPE_RAID1C4:
+	    {
+	      grub_dprintf ("btrfs", "RAID1C4\n");
+	      stripen = 0;
+	      stripe_offset = off;
+	      csize = grub_le_to_cpu64 (chunk->size) - off;
+	      redundancy = 4;
 	      break;
 	    }
 	  default:
-- 
2.24.0

