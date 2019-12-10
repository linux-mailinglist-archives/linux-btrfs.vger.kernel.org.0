Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 271A7118128
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 08:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfLJHOI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 02:14:08 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:45587 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727347AbfLJHOI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 02:14:08 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 47XBBQ6myBz8v9M;
        Tue, 10 Dec 2019 08:14:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1575962046; bh=7BUFQQAFNdf5wyiECFapsfpB2NmRLlg6vFwWEnquTVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=GE8UuAwHJ4DA/xKLdshV6k9rZ99B7mJSkO0R3O7X1XnE0/+YS04TRhcadVtfaTGVP
         GnncW5tCfYJnRoMwDmJrpSGzFq0TGtp4eUEsUo0Gdcghs1RzLFbFPP0OkcWQgmnAIO
         NQ4QvRd6OhdF29NgroPFB03FxJr3LgYkpySzLZzzZl9WRSL9DjxU9VLsxk/fipYAAp
         r31cKmsCGEdBHmWV1TIwSbV7/8y8sH9bxueaoUCzxshR7PiyQLmY8RRgfqKqaVaupt
         zu3K7aTPfyIZ+0xJgo40BsHzjjLtB2QAG8kbe/Cf4BbbZvOZBVK3TXeHBubrqdWJsm
         XOCpcC9L49iSw==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.22.146
Received: from localhost.localdomain (firewall.henke.stw.uni-erlangen.de [131.188.22.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+v8h/Q7VOtmtu9xEDoHluFrLFawPVc1os=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 47XBBN46Dxz8t8v;
        Tue, 10 Dec 2019 08:14:04 +0100 (CET)
From:   Sebastian <sebastian.scherbel@fau.de>
To:     dsterba@suse.com
Cc:     josef@toxicpanda.com, clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@i4.cs.fau.de,
        Sebastian Scherbel <sebastian.scherbel@fau.de>,
        Ole Wiedemann <ole.wiedemann@fau.de>
Subject: [PATCH 2/5] fs_btrfs_struct-funcs: code cleanup
Date:   Tue, 10 Dec 2019 08:13:54 +0100
Message-Id: <20191210071357.5323-3-sebastian.scherbel@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210071357.5323-1-sebastian.scherbel@fau.de>
References: <20191210071357.5323-1-sebastian.scherbel@fau.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sebastian Scherbel <sebastian.scherbel@fau.de>

This patch changes several instances in struct-funcs where the coding style
is not in line with the Linux kernel guidelines to improve readability.

1. missing blank lines after decleration are added
2. tabs are used for indentations where possible

Signed-off-by: Sebastian Scherbel <sebastian.scherbel@fau.de>
Co-developed-by: Ole Wiedemann <ole.wiedemann@fau.de>
Signed-off-by: Ole Wiedemann <ole.wiedemann@fau.de>
---
 fs/btrfs/struct-funcs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 73f7987143df..4f63e69c5387 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -9,12 +9,12 @@
 
 static inline u8 get_unaligned_le8(const void *p)
 {
-       return *(u8 *)p;
+	return *(u8 *)p;
 }
 
 static inline void put_unaligned_le8(u8 val, void *p)
 {
-       *(u8 *)p = val;
+	*(u8 *)p = val;
 }
 
 /*
@@ -173,6 +173,7 @@ void btrfs_node_key(const struct extent_buffer *eb,
 		    struct btrfs_disk_key *disk_key, int nr)
 {
 	unsigned long ptr = btrfs_node_key_ptr_offset(nr);
+
 	read_eb_member(eb, (struct btrfs_key_ptr *)ptr,
 		       struct btrfs_key_ptr, key, disk_key);
 }
-- 
2.20.1

