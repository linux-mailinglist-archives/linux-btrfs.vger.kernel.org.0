Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8719185E38
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Mar 2020 16:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgCOPcn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Mar 2020 11:32:43 -0400
Received: from smtp-16-i2.italiaonline.it ([213.209.12.16]:47373 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726501AbgCOPcm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Mar 2020 11:32:42 -0400
Received: from venice.bhome ([84.220.24.82])
        by smtp-16.iol.local with ESMTPA
        id DV7vj4MthjfNYDV7wjCbpf; Sun, 15 Mar 2020 16:24:32 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1584285872; bh=tXIHLeNCIQ8auEaEmcn1Jde5dT4fgevBhMxIor/oPvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Yt2I9LaqsP0e2S1RuO5v/TfJ9wnRfGTg8BTOm3L6srBiz3rj+FfrDywFhqZGYznuz
         2GJwfbZyB7nu5fZrXYcBI8w29DdRH3ZrurB6awW1CPwdBdqezuTmnpwWubr+749bHQ
         +lPWAt7pIZ82+ZrBSPt+crDcPvphUpNtf+ezhlIXgw9Upnx3oTrFCCzctIhoYP1IAf
         MOfwaoskoU2LdojksjU0srZDaLw//Tjkzy/4mMGQoRE6VGJqTg6sQt3EM7lPjXOvWZ
         wG8fJdoGUbwdx7IBDL69Mj3JX7+MLiNerkkDi1I8eKa7pXWNjITBXZjvZ5IMwGFkMD
         oQTr5mJ+mgvlQ==
X-CNFS-Analysis: v=2.3 cv=BYemLYl2 c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=ApJHA9tvkzbWOyiWpVMA:9
 a=PQZ_xfXKJu480mL2:21 a=o4hlldC9LnJVMAGp:21
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 2/3] btrfs-progs: Add BTRFS_IOC_GET_CHUNK_INFO ioctl.
Date:   Sun, 15 Mar 2020 16:24:29 +0100
Message-Id: <20200315152430.7532-3-kreijack@libero.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200315152430.7532-1-kreijack@libero.it>
References: <20200315152430.7532-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKeuC/zBMoiSUPj6vKAcEqpN98nRdSfcvkr9W7omw91sQbYuyvGGIkHAn9VgnTVZXXPuMGBIHFLvLNwQZ5IVvoCnMW7AYn57rrfajnvPlymCK7jC05wm
 KZUPI7v/C+2eiYevZ/GcZkmt3qGa15jX6zPKogjaQBP/+fx5PZh3WPYT12XIu/PlqPd6lDyrE7hFvt+ytTSWFwuWcnG5logk5LXsYTk7Zc/2SrdLRGdDqtAF
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 ioctl.h | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/ioctl.h b/ioctl.h
index 4e7efd94..bdf70849 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -775,6 +775,64 @@ struct btrfs_ioctl_get_subvol_rootref_args {
 };
 BUILD_ASSERT(sizeof(struct btrfs_ioctl_get_subvol_rootref_args) == 4096);
 
+struct btrfs_chunk_info_stripe {
+	__u64 devid;
+	__u64 offset;
+	__u8 dev_uuid[BTRFS_UUID_SIZE];
+};
+
+struct btrfs_chunk_info {
+	/* logical start of this chunk */
+	__u64 offset;
+	/* size of this chunk in bytes */
+	__u64 length;
+
+	__u64 stripe_len;
+	__u64 type;
+
+	/* 2^16 stripes is quite a lot, a second limit is the size of a single
+	 * item in the btree
+	 */
+	__u16 num_stripes;
+
+	/* sub stripes only matter for raid10 */
+	__u16 sub_stripes;
+
+	struct btrfs_chunk_info_stripe stripes[1];
+	/* additional stripes go here */
+};
+
+struct btrfs_ioctl_chunk_info {
+	/* offset to start the search; after the ioctl, this field contains
+	 * the next offset to start a search
+	 */
+	u64			offset;		/* in/out */
+	/* size of the passed buffer, including btrfs_ioctl_chunk_info */
+	u32			buf_size;	/* in     */
+	/*  number of items returned */
+	u32			items_count;	/* out    */
+};
+
+static inline struct btrfs_chunk_info *
+btrfs_first_chunk_info(struct btrfs_ioctl_chunk_info *bici)
+{
+	return (struct btrfs_chunk_info *)((char *)bici +
+		sizeof(struct btrfs_ioctl_chunk_info));
+}
+
+static inline int btrfs_chunk_info_size(struct btrfs_chunk_info *ci)
+{
+	return sizeof(struct btrfs_chunk_info) +
+		sizeof(struct btrfs_chunk_info_stripe) * (ci->num_stripes-1);
+}
+
+static inline struct btrfs_chunk_info *
+btrfs_next_chunk_info(struct btrfs_chunk_info *ci)
+{
+	return (struct btrfs_chunk_info *)((char *)ci +
+		btrfs_chunk_info_size(ci));
+}
+
 /* Error codes as returned by the kernel */
 enum btrfs_err_code {
 	notused,
@@ -945,6 +1003,8 @@ static inline char *btrfs_err_str(enum btrfs_err_code err_code)
 				struct btrfs_ioctl_ino_lookup_user_args)
 #define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
 				   struct btrfs_ioctl_vol_args_v2)
+#define BTRFS_IOC_GET_CHUNK_INFO _IOR(BTRFS_IOCTL_MAGIC, 64, \
+				   struct btrfs_ioctl_chunk_info)
 
 #ifdef __cplusplus
 }
-- 
2.25.1

