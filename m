Return-Path: <linux-btrfs+bounces-16208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E2AB30638
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F182C16E766
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0C4372196;
	Thu, 21 Aug 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ute/rt2a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28549372165
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807628; cv=none; b=hYAKiqdNiXFQ6IJhEpEsJpcNngkpst8zVFErs0ZD0h8c1RTo6aiKzjhnE0YBhfP6EvkHKAx+PDUeUNKRTfzG5vJ1LtLvyw3qhTerHwxLPqu9342i9rp/TrFy7fsHQVTY1uqDIWdet9KjkXTJUOTWgItPaHLUbWvfc4+48I3vwYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807628; c=relaxed/simple;
	bh=79hNy8MLLzEWxtQB4sKNaWyskip03chASXjDy5oeEVE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgqeWLdt1rJJLTrlRgUNwWkdr2US6xhaUG9Ba2FW0WNCEvE2PdA+Z/62paxGvLWy7gJedaFa2qbpnBo+srcBaywGKpYgpDUV9MVEmm9i1HcMqPyELfDb1O2KsQrshPv/Pb7lzrVMzR3Ixr/Yw6GZxlyXaMO2wFFvI7Xz1/Q054I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ute/rt2a; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d6059643eso10784197b3.3
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807626; x=1756412426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQfgrNdLLZc/kRK8PuHP6T1NoeMFhCjwF6aVkuwb+Vw=;
        b=ute/rt2aDrIGbZcCD4LoRaErKtNRZOnwRe0tj73h6Uh6wBt09gFyfS/b+nr5VTrHRM
         jdjYrsHb9aizSdiPtxJVHryfIZOUzkn87zPRqYAq+K0hTuwI2KIe+d6AL2RHHxFmWjgp
         MDZwbUO1v7gEpLVagg0/apRbDMBjjdbsNvSjZkHOkpGRnZRMZ4/+ubFnpmObjsxFR51T
         LcFRDS6cb9uyvV5QZOB+NA8lyg3YSLW1rqv8ylfL4DfMwWfbG2xVo4FP9AyCF41kfH66
         kwrft+1sGQl0g5Niz8Pvx4ZmvYk4EdBSTpYybUhSzpeT3hEs1yilEbdxHSJLrW5JrGDP
         s1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807626; x=1756412426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQfgrNdLLZc/kRK8PuHP6T1NoeMFhCjwF6aVkuwb+Vw=;
        b=oLviQW6PUpN6um53vUOaQGCLIs9SSgbuEcCwXGVAwYiqa6Pk6n2zUf9bdgiAHlzH7d
         E8cdjW9t+FdAFLBxpr68h0WxOOBW9aWu/sPdVz3DkWkm2A2DCcFZejvVv+6ggaXNyL+z
         +JaAvuDeuKQK9St3XiBPPHJywDW2Ut2gqRoU6jjqNSneJTz4qwFU8jwyScVs5ddNTlFD
         un7NX9zyaEIDM7t4DFnV6dwcMvVo1G29Nn0RaDDZqHbwP82SORr77qCeNI1kH+UP4T5N
         NKxNU73m8vgbJU4+ml34mkO53dhWAxuSesRmixJ3w1mX8JJa1cVSdWI1myAtv3O2X48e
         phVg==
X-Forwarded-Encrypted: i=1; AJvYcCVx8dvLx8aXEvz2XanFMEfu5bYIP/+HO60cQd7jo4kXyeQ5nGeGKb/CIdKcS7r0s9RuTPCCWneDWxVLFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmpTle1FKNcc0iYGpmbsPkH4lcEe4fl4ooKJssxNbHZOGEPofc
	0fjTXxiz90UOaK0iIwogRyAeUWhoGb0TeJnwk6+TH5pch/BPRfOeiL2TU/IA5h+T+04=
X-Gm-Gg: ASbGncskG5eowoAQ/0Srf7vChk5mUYrHzsgSOS7acBf0C/xyhyJ0QDpFS/3sKycETps
	E7L1guD9HB7/zjqXhvUDDBquekv5myI9YmNHIqU1EdcANTRurjYp7PZYzfjgJLu95z8lD5Q+oHP
	itxG3W7kYcVXHCwWENsEzbZ4YYZk+oF3cU5rY78j9KYwmXeQ09SooEYaOY1QWVBrhEJeO3YU+bo
	62tOeeredfHrImC5CDWq5N63RaAxsKaqoODWhnf0P4yz/63cUfr0j28EKvZTldx077GwAH4EKjb
	SVkNXjBbrPs/q7sHKG7omnMtHGNmj8sB794bUeN2b+0GHbbZVWXvAbPApUQwrVSC6n8Bkl9pFba
	UbNEw3CrnXc3WeY29q8ZM5sVboY7I29SFj45Bqin7blt3EKK0ab7Bfss0ngk=
X-Google-Smtp-Source: AGHT+IH6qMUNtcjMenDwwsBm6WjRZG6TyRrHXTaa6FiUieFXv2EqpL/3ycbYTymZg5Nc7D4WJE0sWg==
X-Received: by 2002:a05:690c:b06:b0:702:52af:7168 with SMTP id 00721157ae682-71fdc2be3eemr6737757b3.2.1755807625992;
        Thu, 21 Aug 2025 13:20:25 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fa8224c2csm19078567b3.16.2025.08.21.13.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 07/50] fs: hold an i_obj_count reference while on the hashtable
Date: Thu, 21 Aug 2025 16:18:18 -0400
Message-ID: <56fd237584c36a1afd72b429a1d8fbf4049268cf.1755806649.git.josef@toxicpanda.com>
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

While the inode is on the hashtable we need to hold a reference to the
object itself.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 454770393fef..1ff46d9417de 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -667,6 +667,7 @@ void __insert_inode_hash(struct inode *inode, unsigned long hashval)
 
 	spin_lock(&inode_hash_lock);
 	spin_lock(&inode->i_lock);
+	iobj_get(inode);
 	hlist_add_head_rcu(&inode->i_hash, b);
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&inode_hash_lock);
@@ -681,11 +682,16 @@ EXPORT_SYMBOL(__insert_inode_hash);
  */
 void __remove_inode_hash(struct inode *inode)
 {
+	bool putref;
+
 	spin_lock(&inode_hash_lock);
 	spin_lock(&inode->i_lock);
+	putref = !hlist_unhashed(&inode->i_hash) && !hlist_fake(&inode->i_hash);
 	hlist_del_init_rcu(&inode->i_hash);
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&inode_hash_lock);
+	if (putref)
+		iobj_put(inode);
 }
 EXPORT_SYMBOL(__remove_inode_hash);
 
@@ -1314,6 +1320,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	 * caller is responsible for filling in the contents
 	 */
 	spin_lock(&inode->i_lock);
+	iobj_get(inode);
 	inode->i_state |= I_NEW;
 	hlist_add_head_rcu(&inode->i_hash, head);
 	spin_unlock(&inode->i_lock);
@@ -1451,6 +1458,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 		if (!old) {
 			inode->i_ino = ino;
 			spin_lock(&inode->i_lock);
+			iobj_get(inode);
 			inode->i_state = I_NEW;
 			hlist_add_head_rcu(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
@@ -1803,6 +1811,7 @@ int insert_inode_locked(struct inode *inode)
 		}
 		if (likely(!old)) {
 			spin_lock(&inode->i_lock);
+			iobj_get(inode);
 			inode->i_state |= I_NEW | I_CREATING;
 			hlist_add_head_rcu(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
-- 
2.49.0


