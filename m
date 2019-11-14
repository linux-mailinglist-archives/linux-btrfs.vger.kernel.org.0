Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D25BFCA66
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 16:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfKNP6q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 10:58:46 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45085 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNP6q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 10:58:46 -0500
Received: by mail-qv1-f67.google.com with SMTP id g12so2520434qvy.12
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2019 07:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dxZVx/PJnza0xI4Zz8kIOALa/tO+ai8x1D+pTbwqyNo=;
        b=1sF4UxoXzVmoXhcN9dSJdZLEAYuGRdAXAX0B/X3n3+msajXvRZDNrnFtYh9Ya1QSu5
         M48WZuKr/6jh+0/VDkSYig4fHS9QZgONYW+TkYkLe0XaUANkLeDv/urpuRPSy7QiSC1R
         h6xjOUFl9D7nXF79Vr91P6lCdMk8ybHqH0QbUUaQFVoWVG8ik2mFDs33eK9AR8fotWY8
         nZ1jnSGs2HljpapMsm2DjcLAy0koruGtrwrxwR6g7FEf91j3/MMHjncuupqbhfXAQoLq
         cN+uZVjFEwF4GKAcvYJ1cNEKgdk0Aougz4EbYsAkFTFA7XaGe7Sa/yhyb+uN+Ox7Ukop
         MxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dxZVx/PJnza0xI4Zz8kIOALa/tO+ai8x1D+pTbwqyNo=;
        b=faJdRRX84LyfUtmNp0Em6Dv58A8FIDZ3cScihzA1QH20KRPsmx0OXpDIfUMjDa0eop
         NbaHNq+y53W2lDX3dGMIbOM5W0jQ9i9h5V6tGj1+rYmrK2JwfBPh243cAIat0Q6mj2s3
         /CalroGQa3m4DUZMg3jYuF1GpReokGgT3fln8d566hptmVH/JnLdl3IPneYE2nmkWKY2
         3pDBQNxz9q7MNoup043b1keELu9igO+G165+Vea9Zij8/k6Y184kb6Ef/bzgcNvL6FXj
         bwB2RCkejuEFrgNPmZoR12VWp0GQ8R3xVNGWq+XEt3xDDmQS7O1CfvjrEE9x8H625PRL
         RiwQ==
X-Gm-Message-State: APjAAAXpnq2cLZfn/yzUdKkzs9S3Kp3rTHkD2f/WdU8tBrf4AYsGPceF
        cbYhvJbDOtXxMOenKBwa2UtU4Q==
X-Google-Smtp-Source: APXvYqz/z/FgxDwJYI+62+a36LnfWXbQpUEZBeelbEV8EKgW2xMpambUM3u4ugadbl2Zr7P1GS1ZNg==
X-Received: by 2002:a05:6214:8ee:: with SMTP id dr14mr8883132qvb.122.1573747125306;
        Thu, 14 Nov 2019 07:58:45 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z5sm3414433qtm.9.2019.11.14.07.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 07:58:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] fsstress: allow operations to use either a directory or subvol
Date:   Thu, 14 Nov 2019 10:58:36 -0500
Message-Id: <20191114155836.3528-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191114155836.3528-1-josef@toxicpanda.com>
References: <20191114155836.3528-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Most operations are just looking for a base directory to generate a file
in, they don't actually need a directory specifically.  Add FT_ANYDIR to
cover both directories and subvolumes, and then use this in all the
places where it makes sense.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 ltp/fsstress.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index f7f5f1dc..30b2bd94 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -200,6 +200,7 @@ struct print_string {
 #define	FT_ANYm		((1 << FT_nft) - 1)
 #define	FT_REGFILE	(FT_REGm | FT_RTFm)
 #define	FT_NOTDIR	(FT_ANYm & (~FT_DIRm & ~FT_SUBVOLm))
+#define FT_ANYDIR	(FT_DIRm | FT_SUBVOLm)
 
 #define	FLIST_SLOT_INCR	16
 #define	NDCACHE	64
@@ -3165,7 +3166,7 @@ creat_f(int opno, long r)
 	int		v;
 	int		v1;
 
-	if (!get_fname(FT_DIRm, r, NULL, NULL, &fep, &v1))
+	if (!get_fname(FT_ANYDIR, r, NULL, NULL, &fep, &v1))
 		parid = -1;
 	else
 		parid = fep->id;
@@ -3729,7 +3730,7 @@ getdents_f(int opno, long r)
 	int		v;
 
 	init_pathname(&f);
-	if (!get_fname(FT_DIRm, r, &f, NULL, NULL, &v))
+	if (!get_fname(FT_ANYDIR, r, &f, NULL, NULL, &v))
 		append_pathname(&f, ".");
 	dir = opendir_path(&f);
 	check_cwd();
@@ -3761,7 +3762,7 @@ getfattr_f(int opno, long r)
 	int             xattr_num;
 
 	init_pathname(&f);
-	if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, &fep, &v)) {
+	if (!get_fname(FT_REGFILE | FT_ANYDIR, r, &f, NULL, &fep, &v)) {
 		if (v)
 			printf("%d/%d: getfattr - no filename\n", procid, opno);
 		goto out;
@@ -3880,7 +3881,7 @@ listfattr_f(int opno, long r)
 	int             buffer_len;
 
 	init_pathname(&f);
-	if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, &fep, &v)) {
+	if (!get_fname(FT_REGFILE | FT_ANYDIR, r, &f, NULL, &fep, &v)) {
 		if (v)
 			printf("%d/%d: listfattr - no filename\n", procid, opno);
 		goto out;
@@ -3930,7 +3931,7 @@ mkdir_f(int opno, long r)
 	int		v;
 	int		v1;
 
-	if (!get_fname(FT_DIRm, r, NULL, NULL, &fep, &v))
+	if (!get_fname(FT_ANYDIR, r, NULL, NULL, &fep, &v))
 		parid = -1;
 	else
 		parid = fep->id;
@@ -3968,7 +3969,7 @@ mknod_f(int opno, long r)
 	int		v;
 	int		v1;
 
-	if (!get_fname(FT_DIRm, r, NULL, NULL, &fep, &v))
+	if (!get_fname(FT_ANYDIR, r, NULL, NULL, &fep, &v))
 		parid = -1;
 	else
 		parid = fep->id;
@@ -4326,7 +4327,7 @@ removefattr_f(int opno, long r)
 	int             xattr_num;
 
 	init_pathname(&f);
-	if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, &fep, &v)) {
+	if (!get_fname(FT_REGFILE | FT_ANYDIR, r, &f, NULL, &fep, &v)) {
 		if (v)
 			printf("%d/%d: removefattr - no filename\n", procid, opno);
 		goto out;
@@ -4646,7 +4647,7 @@ setfattr_f(int opno, long r)
 	int             xattr_num;
 
 	init_pathname(&f);
-	if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, &fep, &v)) {
+	if (!get_fname(FT_REGFILE | FT_ANYDIR, r, &f, NULL, &fep, &v)) {
 		if (v)
 			printf("%d/%d: setfattr - no filename\n", procid, opno);
 		goto out;
@@ -4792,7 +4793,7 @@ subvol_create_f(int opno, long r)
 	int			err;
 
 	init_pathname(&f);
-	if (!get_fname(FT_DIRm | FT_SUBVOLm, r, NULL, NULL, &fep, &v))
+	if (!get_fname(FT_ANYDIR, r, NULL, NULL, &fep, &v))
 		parid = -1;
 	else
 		parid = fep->id;
@@ -4872,7 +4873,7 @@ symlink_f(int opno, long r)
 	int		v1;
 	char		*val;
 
-	if (!get_fname(FT_DIRm, r, NULL, NULL, &fep, &v))
+	if (!get_fname(FT_ANYDIR, r, NULL, NULL, &fep, &v))
 		parid = -1;
 	else
 		parid = fep->id;
-- 
2.21.0

