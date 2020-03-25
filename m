Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5152C1931A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 21:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgCYUKs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 16:10:48 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:37916 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727389AbgCYUKs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 16:10:48 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-16.iol.local with ESMTPA
        id HCMOjh5MEjfNYHCMPjKIfT; Wed, 25 Mar 2020 21:10:45 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585167045; bh=yjCKfiupFowMkGoaheuWChMhWQmQxEakxoyLtSkw+QM=;
        h=From;
        b=OPrAyUU5m6L516H3MVMwQmmBu3wQpzLD3bGu5es2RePu/p8K4dbvh6uK0V2oHrc9Z
         N7LHA0nvLd9c0KA8oi3+sf4yAQ6PnTv1wV4M9hnWGKcYnBhhpChCPDgznND2kCR5RI
         p0TEAHYlaiIQgXIJan7ko6nprhVad5qwKxFjaiwnZF/TKrEFD48aFhnH2H+L007YmR
         Szx9s7XUAgrbKrZETEKXnlnHR8QqrFGleiJlpbYFQ1bP9/MgPSzHqwx30HliVFAoXC
         lnBHig/AUVcmhUPuGCmOH07ucNDuj+GeK7wv7WZyGQOqIjspEF0WQ/tdxj7vuGjSP5
         f/wsCHqEqpT1A==
X-CNFS-Analysis: v=2.3 cv=av7M9hRV c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=LKmzqrTVISSj5QACPwEA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/4] btrfs-progs: Add missing fields to btrfs_raid_array[] for raid1c[34].
Date:   Wed, 25 Mar 2020 21:10:39 +0100
Message-Id: <20200325201042.190332-2-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200325201042.190332-1-kreijack@libero.it>
References: <20200325201042.190332-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEuCnovtdD+TRoeabWypWzplUOR+GkQayJ7V99CQYO85L74ziUcBkhKEpmAheyuIWsJLjTH4xPCec77502nddjJO1i3YdjhU/zRctjhI8g7IdiRAsFz7
 Ld9XB5oxruih8lvRlDt4unHGhNrd8uVKSMfKPgHXyqUIt02gTmRBXhw730zQPI5/KUlFH5iysPuetaOYmS5GnJD/+5iMn6eL/3VeZK8LKGVs1ZMK/1jLGIwR
 5BdJp6JXJquA/jRJz0x4ow==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 volumes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/volumes.c b/volumes.c
index b46bf598..9e37f986 100644
--- a/volumes.c
+++ b/volumes.c
@@ -65,6 +65,8 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.tolerated_failures = 2,
 		.devs_increment	= 3,
 		.ncopies	= 3,
+		.raid_name	= "raid1c3",
+		.bg_flag	= BTRFS_BLOCK_GROUP_RAID1C3,
 	},
 	[BTRFS_RAID_RAID1C4] = {
 		.sub_stripes	= 1,
@@ -74,6 +76,8 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.tolerated_failures = 3,
 		.devs_increment	= 4,
 		.ncopies	= 4,
+		.raid_name	= "raid1c4",
+		.bg_flag	= BTRFS_BLOCK_GROUP_RAID1C4,
 	},
 	[BTRFS_RAID_DUP] = {
 		.sub_stripes	= 1,
-- 
2.26.0.rc2

