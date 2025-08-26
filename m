Return-Path: <linux-btrfs+bounces-16406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEAFB36EB3
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E24464237
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79125362987;
	Tue, 26 Aug 2025 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uGC5UlYj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108D934DCED
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222908; cv=none; b=kumFR3OKotJ/Bv38L9fQsUCJ3f/wOJ7Rc+EmZGYxEsUOYP74mSnxWLDxfSXTnbh7bCQsFuGJvaY765NpkymHraeKA0gwJH8yrB28Q8ZWSvUt3u7rVwhCD+INC+zo099CQAju1bRpiyBOi5YZdxG3plQAxuYF7BN+O4BE6R2UTbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222908; c=relaxed/simple;
	bh=GaKmvGab+0a2RrIuxhv8XqHzko9SenWylGMpW6UIOW4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yr/VPuPDCJMKohGDIntppHEvUchwtVx6wqEAI/bPoIVik/EH/sAFAk8TWB2M7RquqoqIcb9aFCl9TO7g7+vOpzLWKd74AdpH5DdQvPRplbFOOXhGbRFbDLhn9RDUPbDK0uX9OYQzlVHXXSFu5P8buuA171QOD8sy0EFPrkCZZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=uGC5UlYj; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e95246bd5e8so3616507276.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222906; x=1756827706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTOjoTpV6m7hLv/F0NHjQx0Ply5AcqoXgmnK8+LDP5A=;
        b=uGC5UlYjbB6rOseH9rP9MBsmDrcW30L2b2JfgIYz8Eyj3xR/rQwJmfyyU66fGoMvZd
         YIn1TRYIdFSV0VIFkfvJv0Y5xYinUBAW72kL9idKUi+wb0zTYCBo08c3pOGQrl3SHnH9
         vxnF5uYsccZbcvX9GNwpv0/djWeDtHVRSa5Rz3Uu5EFHcpmCsexCUXNdQWgH+hTiw2kj
         VGL2vVIQfEfXhMWUQAVfWEBK1kyEfBiNFS6a4c1WOmK2x/Zw3eXkvzoZrOe8uhHAs5td
         Hh0qDI46iRuFdj4JGFQTJ4/oAy2+e21u+KIat1IEqO+Z6mbnDl7hhYAeweAmG3iwJoz1
         Qv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222906; x=1756827706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTOjoTpV6m7hLv/F0NHjQx0Ply5AcqoXgmnK8+LDP5A=;
        b=orAq+vLaeHn1WwM6CdQHuZTEHNRpWyDm4d1dN7JPinMy3Mhr70h1BoKjKk7u5ALPhl
         iuxghGmBDf1WtBpMc8d8tkEfkQpUcB8yeVuQ6BhHhOyGtgwXcrmhQyv24BjY9/REWSSq
         vgexABDfAlVsplB88Bb3pmFnJBG+JrGGUP/TVNZnfFTpcBSLk8DTrZ3J5Tj4v6nBX4YO
         iSjOSvv2hee+D+r4Kqerc969mCMCBobh0L/F1HNHan/5IPBlCqBCE0iNsS5l7JEIV021
         wNyZcevKw2ZVJGAuQjAM61fw3By8myYY6gexjRvCDjNyUwQ9IoP+oUDQZeKPz8H25K79
         bLmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcZt8uEjXypQVy23ewm999Xrdj2TZL3BzB24AEGdsCHb0Qh0F5Nxi0fH1pY6qmYtH/rFXdyNYeuff7TQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1GvN3mpZW6TfYmV9F9Syfem+Lr6AtKTuipLZfHibG/Pm6F9Ui
	yzLSjpy0MtkfAOw6Cz2PXWtJAhCzV+alVAkKhdwV1uVRy7ZaFqI5bcjQ3OjSRlFl6tc=
X-Gm-Gg: ASbGncsRvDT1KI1sZBOaWWeOEJ+lo2jQdc+9twR1XhI/qD0inqF+D5ZwPZdo16DsTNF
	RAkKDOsjSgHzp1wOUKO6nbUcR0lfMK+6TOleC8Hxt087r4IvCVTkyUyuEP5Ixhi3emsMTOfNsLy
	nKTGBPTlTChYyo4u/FwK/22HxyUk81+ojuHcex9XRFShRzNM4iA1ccbFucXecSlLCjnoSntPZG7
	K/eLp9EDhr5X3FPrHZmiDf0MIxPQM0VlMXwZdQObQufrbqWYaaDu6uRk5KZ6KdsX9vzw8nKpiog
	jH2q0Gu8D7WxCF1jeuWYPd35dgPbVaeAYH06HRUl3jFQBMot3CB7AZGHnVZ69auLRDr3igcskKX
	yFrSXJnimcqmXNviG1Mzp+WZXDg2X8eeFYojy8735pPPVUUnua1VjZ+8N+BNZ7ZO1sP3BoA==
X-Google-Smtp-Source: AGHT+IFjze0r20/WCdIbB5fda9LnJE1jWaThHGsQzBCPZUwgD9yRzYM9e2CgIgaMhoLiVnPc0UCoRA==
X-Received: by 2002:a05:6902:150a:b0:e95:3e67:90de with SMTP id 3f1490d57ef6-e953e6797fdmr9650941276.27.1756222905943;
        Tue, 26 Aug 2025 08:41:45 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96eb3c35cdsm121586276.11.2025.08.26.08.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:45 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 39/54] fs: remove I_WILL_FREE|I_FREEING check from dquot.c
Date: Tue, 26 Aug 2025 11:39:39 -0400
Message-ID: <e2c8fe9fa28fb6e52d0e47e38d2ef93c9527b84f.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can use the reference count to see if the inode is live.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/quota/dquot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index df4a9b348769..90e69653c261 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1030,14 +1030,16 @@ static int add_dquot_ref(struct super_block *sb, int type)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode->i_state & I_NEW) ||
 		    !atomic_read(&inode->i_writecount) ||
 		    !dqinit_needed(inode, type)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&sb->s_inode_list_lock);
 
 #ifdef CONFIG_QUOTA_DEBUG
-- 
2.49.0


