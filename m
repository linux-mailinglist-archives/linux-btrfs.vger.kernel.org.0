Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336C06D6618
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 16:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjDDO4J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 10:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjDDO4B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 10:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39734ED8
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 07:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680620089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EljYz9VZ7nVcMno61oSjo4fgwJueEqLgTdTvZAW6Ojc=;
        b=JnwgKaSwwyWuucjtkK6Wfn+G2iAvl0im/3ibO4J2+S6oRcvHrC514oEcRbM81xg5/7+NcK
        kK4m0i/RvMHfKFEjSICFP/e+Ex7x2QIIsq3xgvyYtao7SAjJT37Zvaaetekvec2a/rSONC
        t9WUMGPJtmLSND9r+Ls5caNcJEk6rzo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-bVvJzPeuNLGe3PU9FyQPUA-1; Tue, 04 Apr 2023 10:54:48 -0400
X-MC-Unique: bVvJzPeuNLGe3PU9FyQPUA-1
Received: by mail-qk1-f200.google.com with SMTP id 198-20020a370bcf000000b007468cffa4e2so14830780qkl.10
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Apr 2023 07:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EljYz9VZ7nVcMno61oSjo4fgwJueEqLgTdTvZAW6Ojc=;
        b=vLRl1Wc9QylRWTAjztcdlYdx8WTohIx+ZyGSf/cZDIwLVM35hBc2zfU88ToM+C+ImM
         Bq0ZlCd5kmlKKxCgiN6kpl7aBS1MAS5VnUpQO6dh61vWB/vSup29+gmeA24jLKguo8TX
         eK81W+JrdoJzMgE76VUckOmi3/mUZNS6X8szIKzKoKBLJ81LJ7LdY1LRGcuM52Rsa8Kh
         rksvJKUlVv7p3ekYTKUg9uyaI/MRvoZ87jtE9H5F2dmKyWA7s26wK0l2vPMnM8x4Ey9h
         Ovl9XO68AmRf66Yv2SXPtqewmct3c//Mt0j3teVTVnkmIk/BDQ9oBgg8cXkmqiDDX5Xi
         TGvQ==
X-Gm-Message-State: AAQBX9fCCMfAyT2g2ob64zU9orBurecmMhUjdiX2yDjwvmQ4sSrt8a/N
        s/XYB+RnL3yIVSfw16hyNsv+1V2PmPsMM/U4vppXqaa6mjSYAraYiXIjlQVoR3HUbWRO8BrHTjk
        sKLrzBpD9DEHqfEOt6wI01w==
X-Received: by 2002:ad4:5be5:0:b0:5df:4d41:954d with SMTP id k5-20020ad45be5000000b005df4d41954dmr4197900qvc.3.1680620087796;
        Tue, 04 Apr 2023 07:54:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350awxiwQj29WkT4ggcZAS6daFPDjxiKszMVMUv7HrI39sj994HHwSVJ4OpAB2k+VsVfNFDI7fw==
X-Received: by 2002:ad4:5be5:0:b0:5df:4d41:954d with SMTP id k5-20020ad45be5000000b005df4d41954dmr4197864qvc.3.1680620087448;
        Tue, 04 Apr 2023 07:54:47 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:54:47 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com,
        Allison Henderson <allison.henderson@oracle.com>,
        Mark Tinguely <tinguely@sgi.com>
Subject: [PATCH v2 02/23] xfs: add parent pointer support to attribute code
Date:   Tue,  4 Apr 2023 16:52:58 +0200
Message-Id: <20230404145319.2057051-3-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Allison Henderson <allison.henderson@oracle.com>

Add the new parent attribute type. XFS_ATTR_PARENT is used only for parent pointer
entries; it uses reserved blocks like XFS_ATTR_ROOT.

Signed-off-by: Mark Tinguely <tinguely@sgi.com>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_attr.c       | 4 +++-
 fs/xfs/libxfs/xfs_da_format.h  | 5 ++++-
 fs/xfs/libxfs/xfs_log_format.h | 1 +
 fs/xfs/scrub/attr.c            | 2 +-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index b1dbed7655e8..101823772bf9 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -976,11 +976,13 @@ xfs_attr_set(
 	struct xfs_inode	*dp = args->dp;
 	struct xfs_mount	*mp = dp->i_mount;
 	struct xfs_trans_res	tres;
-	bool			rsvd = (args->attr_filter & XFS_ATTR_ROOT);
+	bool			rsvd;
 	int			error, local;
 	int			rmt_blks = 0;
 	unsigned int		total;
 
+	rsvd = (args->attr_filter & (XFS_ATTR_ROOT | XFS_ATTR_PARENT)) != 0;
+
 	if (xfs_is_shutdown(dp->i_mount))
 		return -EIO;
 
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 25e2841084e1..3dc03968bba6 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -688,12 +688,15 @@ struct xfs_attr3_leafblock {
 #define	XFS_ATTR_LOCAL_BIT	0	/* attr is stored locally */
 #define	XFS_ATTR_ROOT_BIT	1	/* limit access to trusted attrs */
 #define	XFS_ATTR_SECURE_BIT	2	/* limit access to secure attrs */
+#define	XFS_ATTR_PARENT_BIT	3	/* parent pointer attrs */
 #define	XFS_ATTR_INCOMPLETE_BIT	7	/* attr in middle of create/delete */
 #define XFS_ATTR_LOCAL		(1u << XFS_ATTR_LOCAL_BIT)
 #define XFS_ATTR_ROOT		(1u << XFS_ATTR_ROOT_BIT)
 #define XFS_ATTR_SECURE		(1u << XFS_ATTR_SECURE_BIT)
+#define XFS_ATTR_PARENT		(1u << XFS_ATTR_PARENT_BIT)
 #define XFS_ATTR_INCOMPLETE	(1u << XFS_ATTR_INCOMPLETE_BIT)
-#define XFS_ATTR_NSP_ONDISK_MASK	(XFS_ATTR_ROOT | XFS_ATTR_SECURE)
+#define XFS_ATTR_NSP_ONDISK_MASK \
+			(XFS_ATTR_ROOT | XFS_ATTR_SECURE | XFS_ATTR_PARENT)
 
 /*
  * Alignment for namelist and valuelist entries (since they are mixed
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index ae9c99762a24..727b5a858028 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -967,6 +967,7 @@ struct xfs_icreate_log {
  */
 #define XFS_ATTRI_FILTER_MASK		(XFS_ATTR_ROOT | \
 					 XFS_ATTR_SECURE | \
+					 XFS_ATTR_PARENT | \
 					 XFS_ATTR_INCOMPLETE)
 
 /*
diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 31529b9bf389..9d2e33743ecd 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -441,7 +441,7 @@ xchk_xattr_rec(
 	/* Retrieve the entry and check it. */
 	hash = be32_to_cpu(ent->hashval);
 	badflags = ~(XFS_ATTR_LOCAL | XFS_ATTR_ROOT | XFS_ATTR_SECURE |
-			XFS_ATTR_INCOMPLETE);
+			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT);
 	if ((ent->flags & badflags) != 0)
 		xchk_da_set_corrupt(ds, level);
 	if (ent->flags & XFS_ATTR_LOCAL) {
-- 
2.38.4

