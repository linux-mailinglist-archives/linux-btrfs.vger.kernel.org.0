Return-Path: <linux-btrfs+bounces-16997-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FB2B8A66B
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 17:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D7C7E2A9C
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 15:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF6131FEE7;
	Fri, 19 Sep 2025 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfEdrCTF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C58F31E89A
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296959; cv=none; b=DfAEXFzYmPlEOhjsO5buOYUpokcHPOLD2kCz9wmkTjsmYAL858uo/yFnjd7am+3XPbP7Pi4MIvtLPtizWoUrNZCIilBaU/5rnv/ykSfclYhBgkWiunUNCpgbFW3pGKm8bSyrSPDam1YpuvBiSvdf9bwdIzmPJTLUgGbZoy76c6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296959; c=relaxed/simple;
	bh=4iwo/4hETyrGGvwl7DvWSV1pIW8nOTgSDeRa6KhBnMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqTXMV/1sEeRWbwirV4tGIU3uTTQHMzKX1sDN2zX+ZC/PB0K2aGbkDDlOFnb49nci1GhaNCRwM+TN89hFKq0kKBAA2mQKVO2yeW+mrhE+0/qfd4WF0K2nvQYEKNyg3cWYH1l5Ww3fpCDc5J3i6SzjB6y48QK6V+DJoehhaG7O7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfEdrCTF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45f2c5ef00fso18230925e9.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 08:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758296955; x=1758901755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6Nz4rZ6SPAY+5NRu1bbLzqkYF61IrDASgyLTr6XAmg=;
        b=DfEdrCTFo6rdzFYhld/JgF+qNufolUKLhbGDNtTgYPHDlacnV21osF/hPH9BqVco5A
         u/5u4Hbmx0xc4EcCChq8CAsPF8ecogqsmc6iaUBgL4tAtBjeqwoEGgmxGdou+gxqgL05
         nIAHEFYmokCTym8WnaPjHyGpKKlpxHw+2xKrezfoYo+yO7H9iXRToVdJIrnEwm3D1XR3
         LAJnYPnere9sfucV1mHf5UOYtTa7rJTLka3HATCQNY+2O7xu6QnPMRlcRFExIMulsXu+
         uejrcrNBwLoL3TBm5OaeM1hCaOlnvddNEb7j0U9ugsmxZNQhkFpZaevx2pNJwPBg64nW
         pz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758296955; x=1758901755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6Nz4rZ6SPAY+5NRu1bbLzqkYF61IrDASgyLTr6XAmg=;
        b=hEYtyvv/W9bpBxkV3jFQoBOH3jH8EVfdmejMJ9E8pUiSpmvG4BMebmk0QUgadVISrU
         YxwuoER2ZspU2gO1okf2ukCMPxga2kiKEXTd8PAlSURaDz2O6KUuDkvJQwBZrtzAEAdS
         q6oOyghCKr3lAb2Kom+6t0a3y4iVT0Az9qINiVIMl3uOyttD9M5jFr+RR1+znkeS3q9J
         kk2HOeWLcoSg4yaM3Yhe5zxfO4VDh35yUn9as6stO70BYzTZ5tXF9zvo1Spptx7j6Itz
         Vf7GbkAIrVq5ZjQdVxoVqrThdrJlMM9Fw6Kbam0EOPvIMXga725SL6zQjAFkvh1Tche+
         zBXg==
X-Forwarded-Encrypted: i=1; AJvYcCUetfU5Ih57ICgkVOYbXXBPk+sufRNu+54ghZJhwaRf8vAawVZ3nEVFwgdw7iHlHqm2f/dTBQN5BKPM2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzB/+H//iA7YlRoSSRrz1FAdYdx3nG04YnvL68DLmM+4tdZRppG
	I+yyvcGrdhJJuRc190aQN4vXK8XJ3imk+LXg+1J9ebAm1r56sC+jeNl4
X-Gm-Gg: ASbGncsdeTgSaiwvVj7qQ0T6tOoaEgjXdtgyveUrA1Om1Jj3FrjAf5Knu0BoFL8Z4/Y
	01+S6uO1SqfTGVXv3GKSyCr+UbiPr187lm13QqF0vmETmkx6SuOTpv3s7vj5BM3nvIg7j3TxBqj
	q6dKlw4WCdqA3HQdC98vhvUX4Ae0/zsm+/Q6cJnYSD9RlVql19sPrs0i7Iwum3q4LkI2cnrqGEk
	7ZAgxT7cv5eHHDEyBCvnqmFUtoS0ghbHo08IVVnjr0+IKBZmgSUGBUnnRMm2/vTCY3l1td8s38J
	ecgdY7vK4mFdKcTX0rEMGXKaqR20wAdCPoJ+EZJMij12Nkn2jTpZSFnG+j6q+1v93kfXp5OL++k
	xM+yRcyPeRguY2scPD+Fw1jOJajXmezG4w7AHU+P16JkEwxM9Q++UNfm9WYWbph/RzNRospdI
X-Google-Smtp-Source: AGHT+IFi3Qiw2JmDbZ5JtfHacDK+pNgJNUdMyHN8bx8JLqrebQREXbPs43I+kD+9QA6IwdllVAvzbw==
X-Received: by 2002:a05:600c:1d12:b0:45d:cff6:733f with SMTP id 5b1f17b1804b1-467ebacab73mr28722625e9.11.1758296954944;
        Fri, 19 Sep 2025 08:49:14 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f53c4sm8446746f8f.3.2025.09.19.08.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:49:14 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v5 1/4] fs: provide accessors for ->i_state
Date: Fri, 19 Sep 2025 17:49:01 +0200
Message-ID: <20250919154905.2592318-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919154905.2592318-1-mjguzik@gmail.com>
References: <20250919154905.2592318-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Open-coded accesses prevent asserting they are done correctly. One
obvious aspect is locking, but significantly more can checked. For
example it can be detected when the code is clearing flags which are
already missing, or is setting flags when it is illegal (e.g., I_FREEING
when ->i_count > 0).

Given the late stage of the release cycle this patchset only aims to
hide access, it does not provide any of the checks.

Consumers can be trivially converted. Suppose flags I_A and I_B are to
be handled, then:

state = inode->i_state  	=> state = inode_state_read(inode)
inode->i_state |= (I_A | I_B) 	=> inode_state_add(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B) 	=> inode_state_del(inode, I_A | I_B)
inode->i_state = I_A | I_B	=> inode_state_set(inode, I_A | I_B)

Note open-coded access compiles just fine until the last patch in the
series.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c4fd010cf5bf..a4e93fcd4b44 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -756,7 +756,7 @@ enum inode_state_bits {
 	/* reserved wait address bit 3 */
 };
 
-enum inode_state_flags_t {
+enum inode_state_flags_enum {
 	I_NEW			= (1U << __I_NEW),
 	I_SYNC			= (1U << __I_SYNC),
 	I_LRU_ISOLATING         = (1U << __I_LRU_ISOLATING),
@@ -840,7 +840,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	enum inode_state_flags_t	i_state;
+	enum inode_state_flags_enum i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -899,6 +899,35 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
+/*
+ * i_state handling
+ *
+ * We hide all of it behind helpers so that we can validate consumers.
+ */
+static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
+{
+	return READ_ONCE(inode->i_state);
+}
+
+static inline void inode_state_add(struct inode *inode,
+				   enum inode_state_flags_enum addflags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state | addflags);
+}
+
+static inline void inode_state_del(struct inode *inode,
+				   enum inode_state_flags_enum delflags)
+{
+	WRITE_ONCE(inode->i_state, inode->i_state & ~delflags);
+
+}
+
+static inline void inode_state_set(struct inode *inode,
+				   enum inode_state_flags_enum setflags)
+{
+	WRITE_ONCE(inode->i_state, setflags);
+}
+
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
 	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
-- 
2.43.0


