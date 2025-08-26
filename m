Return-Path: <linux-btrfs+bounces-16399-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C46EB36F1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0941BC2852
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBF6369356;
	Tue, 26 Aug 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zolhkLjL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8E369334
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222899; cv=none; b=klZFYYGcMTJZ5zY4mOwMSeBntQUbTOhdKAixy/G1uT3J0vd2TZZewfBrgTSAjVVA/Ka02vhFL4rSBqj1ZJ+6nXHYovT6jxhvpGr90KWrN+YyTBDKALniqoCVKJgpG12CQDbQbNQ2LvrXe8O9FXipa9uRD2GJzH6IUwdzCylYm9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222899; c=relaxed/simple;
	bh=G1aMNZNoFlDJqDOwcnIWhE+hsa6d2Luem9buE1zdqp4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDY3pfhM8N+V+nAwOj4e53/f8dtFpxQlCQxigw2Shw18XuiLdLHclyBDTOXlNUXIrygl7ll7bXEDeoH9maT9RJnD9+gTvdzvXHtpqO+jCKx6cHRIGULRPqrZJ3vvLd/k//DRtBtP/OQqsVZm2sPQ6VstIhW4Q5iTwlSKecZI0II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zolhkLjL; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e931cad1fd8so4824607276.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222895; x=1756827695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8Pc8K7etH/ssaBOvhPppI+emHRcMCSy0sOBGONM6UY=;
        b=zolhkLjL4uPpQwgP0XbbIbRpbEVe3mlgpIZOJGifgLtwi197982ES22x2P7/Hppai5
         LMDylOyo6qBBgahg325iQ3IRwVIUfApE3nXkxlsb738isdDtPpaCZ8KdxxRDixjvXkCk
         hwU89wL0UvfUaGUEb+ZbKRgjzq1zL1Hwx8WjyfOQjekEUjNrE4BZqbsSJhsS+oYRebmz
         zCtHONbssV77ez2SAvEIxY1v4yOHuzDZjQGnLQm3SSB/XQTdEenCkTE9z7xHhr6DXsoN
         i1sII54P4yoD6tlpNfUA1okSZ0SRwRlrmNNP1nYhTIiJbGkKyWHEVszTGwEQNlorKM6E
         RBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222895; x=1756827695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8Pc8K7etH/ssaBOvhPppI+emHRcMCSy0sOBGONM6UY=;
        b=woenDwLi5kOtWKx9U+ABuDooBA+K4KAhdUykoB9jez5IQDim6tuhro08dLvwohcbOZ
         nI+m0JvPwHMwj8Yv0eM0PW5GJe/dvfXVk2zws7qeOCuIrSACFrjWAN4Fhopn8fbga2J5
         bHV8JrcOilGm1rISGRu7Rs07AoMv6YaJzucZ+3nJY7cjVlKJCv7BSo682t2g/9OSno8S
         0064s6SRUysnXNOLAgEjL5X9jeLEBBla/Xm0ngGfku+npSiLtIrmQ4D4q2qlBYpxods3
         J11FtMv/75aY3sxcFMKWMFepFIZFTKn31J1rg97EgY2cSTQeOfBExbuhzKknB2C5bVly
         E94g==
X-Forwarded-Encrypted: i=1; AJvYcCWOD3Rt3Im6CSchbPiA2dHkNdJejmTvCYvcMIKLcp3KaqLXmW/VUhdUaxVuZkRJlDHiwKjiRsrotMbqsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YysbtwojL87TKUHSZ/PVRDJMRfCgoTOAhg66KaOriPniPI1gVRo
	mLObO8jhb+LAc/kvC7piA/jqACL+jfxJclOV8ERAaMIZNUfeR4+FM4hsUFbD0Tp3nvY=
X-Gm-Gg: ASbGncvYXOHU2jVzh3QOGDs1J0qxUeLzg0FoCQgIOq5gkgOB3t4JRD3d7lAqDHzHzun
	qcRF84iMwqMGlanivAaOV645nPJw+02e0+Ndoi8H5onYwmx8WURBzSqlj4DHlfST5Vh7KZkCr45
	BF7koWOuFDStQ/6dpN6F9U8Sx2kWlEsDc3MgfXOYNiqybR0iu5X08MeVX97BXdrnadtjYzMenBO
	MblOqLDnnlMaWqRNlZl8XbNmAPuvD9xnBKrH2kaNTafY9fQdem9QxOpHobK/4pfnNEorWuII81m
	tDH6cUJaYr8Ms2prllqD/uNJASzELnqnp46AezEFaEST63B9xSl+kDT+h3+jV4vHPOFA+DkiN4z
	+zIoswFic9Oi0LzGCWxvb3GjjR1bTqVTk7b38ZpChwYlrzV/6S14J5zCb3MPH28rKZv+J0g==
X-Google-Smtp-Source: AGHT+IECWyUq5Swkb2LX4gAl0du30jLU3PMPKdvHwQvNIMFfmHVt+qIGh58VpZfE89ckqB90q+RBwQ==
X-Received: by 2002:a05:6902:220e:b0:e93:3d4b:632d with SMTP id 3f1490d57ef6-e951c2bf0d0mr16715139276.40.1756222895451;
        Tue, 26 Aug 2025 08:41:35 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96d59a5ba3sm1098948276.31.2025.08.26.08.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 32/54] bcachefs: use the refcount instead of I_WILL_FREE|I_FREEING
Date: Tue, 26 Aug 2025 11:39:32 -0400
Message-ID: <03228d047baf5100b48174b36af9b59db941cf55.1756222465.git.josef@toxicpanda.com>
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

We can use the refcount to decide if the inode is alive instead of these
flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/bcachefs/fs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 687af0eea0c2..7244c5a4b4cb 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -347,7 +347,7 @@ static struct bch_inode_info *bch2_inode_hash_find(struct bch_fs *c, struct btre
 			spin_unlock(&inode->v.i_lock);
 			return NULL;
 		}
-		if ((inode->v.i_state & (I_FREEING|I_WILL_FREE))) {
+		if (!icount_read(inode)) {
 			if (!trans) {
 				__wait_on_freeing_inode(c, inode, inum);
 			} else {
@@ -2225,7 +2225,6 @@ void bch2_evict_subvolume_inodes(struct bch_fs *c, snapshot_id_list *s)
 			continue;
 
 		if (!(inode->v.i_state & I_DONTCACHE) &&
-		    !(inode->v.i_state & I_FREEING) &&
 		    igrab(&inode->v)) {
 			this_pass_clean = false;
 
-- 
2.49.0


