Return-Path: <linux-btrfs+bounces-16237-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821E2B306CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6591FB018D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679E9374400;
	Thu, 21 Aug 2025 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RmE+irxL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0385039097E
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807673; cv=none; b=fHxy8b+5gB8rZbQ3BCuAKYBc0rog/62OrDb2QQ8hCbB5wMU+0FIb55u+WUlJVFVl65sLrrnvzwvPweu44OhVk/d99+Ddx4tuoIy2Ms30zxzOp7WVLykBtUyl7zgRddOd+aeeZY512WIuI/9YKScI0WxS+bcw24WQGPk6dewZUos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807673; c=relaxed/simple;
	bh=1ynNzpiuwPqZZfc4RXGfh4iGaVDz+/1Rc+r/9GR0kTY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDbAqFc5+Ggi4+6fyGGbVN/jClk5hzob6ZNkndKqkvPANJ25/mbyIz08a13Dy9MrAC5T+CrYotFekl+LCjtaBKrr27oxsQDSgifFnmPl5duQruhVEyOALv1cuAL9T3r6+1p+he06wofvt2lGFLunB9f2L8xSJt/qOP+56vMmGps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RmE+irxL; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e94f19917d2so1386303276.1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807671; x=1756412471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7o1UME4c5fAFN/Xhsfm0V4nndfddrm872UrCQizuLdI=;
        b=RmE+irxLbr8dhHU/ye60oarMKOW3m1gPME3Wd7Ldi9qcnoXpt8r1SkMJeMJglf15U+
         1oFrhsxsO+YI+fJ+yx2xrQuMdSFROZyPo4NPa4x7eDchqOYHDxh24YwT128ODXGG6Egc
         XRAju03vaOqChD6PCt54IdhnDx40gjjAw9sIUt4H3+NRKquL+s4PnZDh0GtvsdqfEEuN
         7B6DZzuXUO3ZIJVFRXqvcb/vVb9Blafmaz1/3LBXltazJjHdjeBmAZyxNCXdntbrab6O
         GOCkxeVE9NDzklw0TwczMPWdl05mYGBGP4DERw7sTBitUGJ8SyOco+jJCe4v6AgT+NKV
         L2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807671; x=1756412471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o1UME4c5fAFN/Xhsfm0V4nndfddrm872UrCQizuLdI=;
        b=Fot5U4TQWZWgYdUrOLcgY4LtI2lMm3yceoXxeqAl9NfsFjUWmPTmiSXNdDXXpuqT/3
         8e5qXrzPPwdgujnQIT/Ph2g59dsza46dz+UOizSyIdBMALJvcprtEDSqCLMYN/Zso3xy
         5F4lktqiGvsdSaBfauFIE0z114Yq/vpX3t4e5c8B9LqYqB0fuN0sr1VM2U3mS8TKCLn4
         BE3vNMcRo9rMoHXQ+o6LkyfB7FJ1RM4VBgM11BtElLZDIBUhIMEIe9ATTFFETd2OM8bO
         Ds2fWTzJnXxcP7qE2YAxrPdUoaKN65GKLe+2E5eMm5Pcj1bgqKE+kD6h1NEnnPtOjI1o
         lDxg==
X-Forwarded-Encrypted: i=1; AJvYcCWA4/O7GVvWo/5OfFgPZjvetH++ObGfqbnz2Q01FJTIy2TY+f9ZQtIlri47Lf8vdpsP7XQyxvM7sT6oCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YynN4wkST/cCKn+Ukg5sKvImp+9ebsfr2/s1ZO73w9RVY4y/sPs
	7anOAj7XJHiqVZ4X4wj2enE3oKCynepBP3XQE+AuMbKXLVrIN2u6hRWTD7MJBoNgBUM=
X-Gm-Gg: ASbGncvkfw7f6cIILAV0TwiM2DPsOQyrmeZf19kNyvUq5Kz1scHisnJLI4j6IpV6Sg2
	2EB0ysUqTTGOcByZlH1UQWRgpPwMaLWMG93UgfQI/+C+l6eExx4BziXzCAIPCrFViINAQ69Gjzk
	l1PAS7nASzwLn/nx5T80YQMx3/LXOCt8+5ysD8AbjVufSXUu1jsZNlRy9lo3oGZdA/6FAOpxqsJ
	KrueOf8z2cyE0dpep1jn1tRW5YttHoD/3+utkB6m8JIdVdGtVw401s4E1qN2aMDNK/kFtsTDVf2
	e4WwEvMjTTvdI4DUiqEqVpnHSTWqdD5WRkWZUWkDS9d6LFi+Q63KjJsVaiWNTAml5V//sbA5gVp
	2DqED+V2gNSURng22J74sH3mBNaWthvbG7NaWOtkAGBS8G6VibYpfvQhJAag=
X-Google-Smtp-Source: AGHT+IEK9Y3HGsRw84lNwHY9ub4929O/sGVc990y8WeBLhD6pl7WYhs7lL5XHgi9vuczlX82x2XgRg==
X-Received: by 2002:a05:6902:33c5:b0:e93:4b5c:d50d with SMTP id 3f1490d57ef6-e951c2a6db5mr895451276.25.1755807670806;
        Thu, 21 Aug 2025 13:21:10 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94ee7b9ec3sm2508563276.17.2025.08.21.13.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:10 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 36/50] gfs2: remove I_WILL_FREE|I_FREEING usage
Date: Thu, 21 Aug 2025 16:18:47 -0400
Message-ID: <0551f9d37b57fecb82930a3465d42ee6a55ea11e.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have the reference count to check if the inode is live, use
that instead of checking I_WILL_FREE|I_FREEING.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/gfs2/ops_fstype.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c770006f8889..2b481fdc903d 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1745,17 +1745,26 @@ static void gfs2_evict_inodes(struct super_block *sb)
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 
 	set_bit(SDF_EVICTING, &sdp->sd_flags);
-
+again:
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) &&
-		    !need_resched()) {
+		if ((inode->i_state & I_NEW) && !need_resched()) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode)) {
+			if (need_resched()) {
+				spin_unlock(&sb->s_inode_list_lock);
+				iput(toput_inode);
+				toput_inode = NULL;
+				cond_resched();
+				goto again;
+			}
+			continue;
+		}
 		spin_unlock(&sb->s_inode_list_lock);
 
 		iput(toput_inode);
-- 
2.49.0


