Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3104469FD
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhKEUsz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbhKEUsr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:48:47 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACD7C061208
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:46:06 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x10so7898237qta.6
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Sl9rRM8WKYAZdMUVkJ5dq4FI5jhQCExoCrLWbxgbQf8=;
        b=HlcRSIR1f6xsz87NP5yU48MlxTHa8GYjUFQ77Zj2MOaJ7D8dTkmHy1jS4Az8wqbWWx
         BlhM0VD+jGYyj8S9So6JPa5SmOuRE/JT8cuFTB9haZ+K2zTfQXZocDTNMVPddxxBQgw+
         /R6iPyal2RdpQXlZSYpelvQi9P1Zm/zFPKUla3T0JPM5nL3aCL3DZ1lRP6AW5AxzrWfo
         1MSJFKtqGgkZI5cF78HxEReKtHOECnSxw1Fpwcdvk/0bsrHbXvoMxZ+5zoxM9st4OxC+
         Ee3qxp+tFm6Alv0PWQgEYmkhBA+Z719zsREaX50n7hekHgL13Z+f/pwAL0iS7rhLfEHs
         n6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sl9rRM8WKYAZdMUVkJ5dq4FI5jhQCExoCrLWbxgbQf8=;
        b=GjbCyxdKqnxhJpWHO0wOdfbe0g5eYv6a+ehNgZYgOMfP5Z0iUG1xaCm0AERs5Lwnxe
         mmFl1lnh6TBwHfJGFQfMIA8KvBzYVYuGXozPUmstsxM6AOPMP0MrUPprlMLG1syIdu2E
         s3s1sO1EyAF747PvhlCqf8gjNJke37v2oguIaIuZp3HB74DshpRCcQ7U3lC239F3FKV0
         RkKcaw04mii8/Esxn3SpqDGRfT3Y5dFev0EjDxZ4DipDaJ9zT0cPuQcwbuHOTeVBmMes
         bCa7wtdTB/0sMDHwKSFO/P3mPFa3NpP9L9+FvyNI22Mc1XwJnEwPXApwAKllVYnIZ2c6
         0j6g==
X-Gm-Message-State: AOAM532EHU51y82sTNhLbaP8BmpNzNnCk9oGgsT8HXZv5xHuhmfch38F
        a7Z9G1GOwvHxj+UPs8LZ6gzGKkL8+b+N1Q==
X-Google-Smtp-Source: ABdhPJyeR6JUmtbT78PxhvOgHlexUpiWojkCvJdvFDO9af6fnTiS1DJNBT6SQQlzceMGtoGneGEZDQ==
X-Received: by 2002:a05:622a:49:: with SMTP id y9mr64774858qtw.301.1636145165702;
        Fri, 05 Nov 2021 13:46:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j22sm6481608qko.121.2021.11.05.13.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:46:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/25] btrfs: remove BUG_ON(!eie) in find_parent_nodes
Date:   Fri,  5 Nov 2021 16:45:35 -0400
Message-Id: <21a64e8283e1d7567aff82e07826e8631d6123c1.1636144971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144971.git.josef@toxicpanda.com>
References: <cover.1636144971.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we're looking for leafs that point to a data extent we want to record
the extent items that point at our bytenr.  At this point we have the
reference and we know for a fact that this leaf should have a reference
to our bytenr.  However if there's some sort of corruption we may not
find any references to our leaf, and thus could end up with eie == NULL.
Replace this BUG_ON() with an ASSERT() and then return -EUCLEAN for the
mortals.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 7d942f5d6443..72ca4334186c 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1359,10 +1359,18 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 				goto out;
 			if (!ret && extent_item_pos) {
 				/*
-				 * we've recorded that parent, so we must extend
-				 * its inode list here
+				 * We've recorded that parent, so we must extend
+				 * its inode list here.
+				 *
+				 * However if there was corruption we may not
+				 * have found an eie, return an error in this
+				 * case.
 				 */
-				BUG_ON(!eie);
+				ASSERT(eie);
+				if (!eie) {
+					ret = -EUCLEAN;
+					goto out;
+				}
 				while (eie->next)
 					eie = eie->next;
 				eie->next = ref->inode_list;
-- 
2.26.3

