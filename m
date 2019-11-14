Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB0FCA65
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 16:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfKNP6o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 10:58:44 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:47053 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNP6o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 10:58:44 -0500
Received: by mail-qv1-f66.google.com with SMTP id w11so2529149qvu.13
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2019 07:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=g4Cq4oSZATopiVHWVuyHeblX9FKGAXQkB3bQW5IcCaE=;
        b=FkA1RHwSsEVhm+x5dz/3kKs3ygEJMicBgQ53LO5NW7BDgQufdH9otjwIZOIjahcqjc
         XoFAd+fT3dxigzSF6gthEyB1RN8B8VIIlO2G8Kd3vaYvH7XqBj2YcyZn4JNtcc2aE2Q2
         vLyZ7abpBFGnLbMBXCzAjNu3h756/Vca3+qUl5LCQqszLQVt9GF1BgADFg3XbSsypM/i
         p26fmcfThPHnhViUFYg7oETRsbIYm38X8tq61TyxbZwegpXM8KtdhBaPrptm+r04zZcI
         lF/lntT3R0Zkji1dDcuNYFGWkJ7d4BF4M5JATJHKVufb9kR8rT4FOXJB+puMgLCvWLil
         DNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g4Cq4oSZATopiVHWVuyHeblX9FKGAXQkB3bQW5IcCaE=;
        b=MaFzpTRdgTenO0tqYVAZDSw25mLUfXL41WyUQtm/lFCI5uaiHlB1JYBpAqb4P5nrM1
         kkyaFc2BsGnrggXJwbfoo+iBZWLt4Hp8xMsgKDAh/iBsHwRSYIdtfsfRW2Q48s4p6sJ2
         eL2DcrIfszxN28yruOPJvP2HmgZjiAP14yDwi4MAKsMBOw/k7ltjfn9VuA7Z+fs/kkb+
         ciTXKoOkNhiUQZ1DM+j03ivMfvlTRqbQX8w0q72eiHdKgIdR9F5GYHH7ttdDyuLBynJI
         1Xoufd6NzXYNV9G+DMZfz4xNzxltTvAL+BlhFwtzPY1WhooA0V+HymryotUl/x5jx+ML
         SFUw==
X-Gm-Message-State: APjAAAUZg73I5Vmv1Fjf6GXpZaVc4UfpMGnuIbVpNC1DBwS6FREG+3hY
        4+o/xF9FNW8f7hhEuQUGgli9Jg==
X-Google-Smtp-Source: APXvYqyALWLG2uRrukq54qZP0rq83mmA1JIq8/TCLDu3wP16nA01HCyou7KMGeca/Sdy6lYSRty8Ww==
X-Received: by 2002:ad4:55cc:: with SMTP id bt12mr8385893qvb.58.1573747123415;
        Thu, 14 Nov 2019 07:58:43 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u7sm2787280qkm.127.2019.11.14.07.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 07:58:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] fsstress: add the ability to create snapshots
Date:   Thu, 14 Nov 2019 10:58:35 -0500
Message-Id: <20191114155836.3528-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191114155836.3528-1-josef@toxicpanda.com>
References: <20191114155836.3528-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Snapshots are just fancy subvolumes, add this ability so we can stress
snapshot creation.  We get the deletion with SUBVOL_DELETE.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 ltp/fsstress.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index e0636a12..f7f5f1dc 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -129,6 +129,7 @@ typedef enum {
 	OP_SETATTR,
 	OP_SETFATTR,
 	OP_SETXATTR,
+	OP_SNAPSHOT,
 	OP_SPLICE,
 	OP_STAT,
 	OP_SUBVOL_CREATE,
@@ -255,6 +256,7 @@ void	rmdir_f(int, long);
 void	setattr_f(int, long);
 void	setfattr_f(int, long);
 void	setxattr_f(int, long);
+void	snapshot_f(int, long);
 void	splice_f(int, long);
 void	stat_f(int, long);
 void	subvol_create_f(int, long);
@@ -322,6 +324,7 @@ opdesc_t	ops[] = {
 	{ OP_SETFATTR, "setfattr", setfattr_f, 2, 1 },
 	/* set project id (XFS_IOC_FSSETXATTR ioctl) */
 	{ OP_SETXATTR, "setxattr", setxattr_f, 1, 1 },
+	{ OP_SNAPSHOT, "snapshot", snapshot_f, 1, 1 },
 	{ OP_SPLICE, "splice", splice_f, 1, 1 },
 	{ OP_STAT, "stat", stat_f, 1, 0 },
 	{ OP_SUBVOL_CREATE, "subvol_create", subvol_create_f, 1, 1},
@@ -1903,6 +1906,7 @@ zero_freq(void)
 #define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
 
 opty_t btrfs_ops[] = {
+	OP_SNAPSHOT,
 	OP_SUBVOL_CREATE,
 	OP_SUBVOL_DELETE,
 };
@@ -4703,6 +4707,55 @@ out:
 	free_pathname(&f);
 }
 
+void
+snapshot_f(int opno, long r)
+{
+#ifdef HAVE_BTRFSUTIL_H
+	enum btrfs_util_error	e;
+	pathname_t		f;
+	pathname_t		newf;
+	fent_t			*fep;
+	int			id;
+	int			parid;
+	int			v;
+	int			v1;
+	int			err;
+
+	init_pathname(&f);
+	if (!get_fname(FT_SUBVOLm, r, &f, NULL, &fep, &v)) {
+		if (v)
+			printf("%d/%d: snapshot - no subvolume\n", procid,
+			       opno);
+		free_pathname(&f);
+		return;
+	}
+	init_pathname(&newf);
+	parid = fep->id;
+	err = generate_fname(fep, FT_SUBVOL, &newf, &id, &v1);
+	v |= v1;
+	if (!err) {
+		if (v) {
+			(void)fent_to_name(&f, fep);
+			printf("%d/%d: snapshot - no filename from %s\n",
+			       procid, opno, f.path);
+		}
+		free_pathname(&f);
+		return;
+	}
+	e = btrfs_util_create_snapshot(f.path, newf.path, 0, NULL, NULL);
+	if (e == BTRFS_UTIL_OK)
+		add_to_flist(FT_SUBVOL, id, parid, 0);
+	if (v) {
+		printf("%d/%d: snapshot %s->%s %d(%s)\n", procid, opno,
+		       f.path, newf.path, e, btrfs_util_strerror(e));
+		printf("%d/%d: snapshot add id=%d,parent=%d\n", procid, opno,
+		       id, parid);
+	}
+	free_pathname(&newf);
+	free_pathname(&f);
+#endif
+}
+
 void
 stat_f(int opno, long r)
 {
-- 
2.21.0

