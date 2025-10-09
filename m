Return-Path: <linux-btrfs+bounces-17574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21227BC7EA8
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 10:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8066F3AE820
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 08:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC332E9EA7;
	Thu,  9 Oct 2025 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbvDejU9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD2F2E8E11
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996813; cv=none; b=PmTBrsZwq+LRwmzEwl0IhLpPqT1BeDv0lp6VsCk+HkKy/nHuwLrpbo7Oq+DJk5kzmgX4mnbPInVU+gT71L8zJEKI4qPb3JiARomG6SD3luF9W9INKivYm3cY5fCy+GG7UcJIp4fBJVq+tPVOtOzcCH+YWADPJLlopS4s/s0eN4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996813; c=relaxed/simple;
	bh=xlG7nR5Wpn4toAnFh4yZG5U7bqMO2Ibqli2pgrWdpe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCvVSyBCuxi4gi9GGB2bJKWfBuCSR1yvmoqHiRrTVW2vmtB1rmfUvmEbdStEPg7l+ME5hMtCTJSwS+PuKVJ3zWnO1f0TMZuASk8jgBTNwsBe7BiriYaDhueVYUqLA4QgA1sKcGRJa4iBhshR9hPw5qB0G8iWKJoZocz+M7AY00A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbvDejU9; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b4f323cf89bso117646366b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Oct 2025 01:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996809; x=1760601609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5cEv8KCvxqRx2Vo792Uxij3yHT/Pkk8+e6W56mfmGo=;
        b=SbvDejU9ggXuvwZcyBQN7Wh/w7QFoavPE+9gM8uuiuVmO1ELw5sKW93FFpq0UEpTkq
         Ryj/7rO/SHMvr+NwtFE5QTSf5WS341LygOQn3KW7t0vLGZCQTLjHrjRyobIyOLnCITUf
         tzlzCFocGJ4GpNMGGc8xHvX9bSHUppgKd1qcC+NjyZxY8Z7hp+K3ixktQxfiZtv7ESnw
         xndW9hExYjaGy3CHpa5bkadYCG5PWfhGVNiCZT9uLlc+c8hEjNrRTCQ82+h6MLHDdNu/
         WvQgPk7LktcDwjsfXh7eYvK/3q2818LaXoD+P0Hwqy+j8s9Z8YVRBE6t9qPBrNSb0JHf
         54fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996809; x=1760601609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5cEv8KCvxqRx2Vo792Uxij3yHT/Pkk8+e6W56mfmGo=;
        b=J5SHc/TpKKfEXZDQIg+5w8IqM0kLHFNdTmELKIqyjMRt6H0gQDKKkt0lkFqY0CIWmI
         2X2LFJGW4pzyf7JEY6VKZqrLMgQpBd34qvhSJZ+RcMSaYza/rTPf9+fhXb4hMDvBLwh5
         4tO4P+zAn+skLM/V2Tn3RB/f/3nFivuGjKMEwlMMSo6gem+NeoCCv7MPRvA7y16ChILU
         befIgnXv7q5pF7qJVobhWMEJHvQpftuUyz0g7SmYABwgT/wVdAGFHJ44mUpMWjYOvEy4
         uVU4bl57czjiLywIykmDuNugL2SfR2GtrsGo7MvvRY27EqUegbZzUhvG/D0DbBc8KqYu
         XvdA==
X-Forwarded-Encrypted: i=1; AJvYcCVh6xmMwhTo0KMy2KJ2svpCA1xdUyluTzev/4xsm/6nIMwNHuitTPJGTft49QM3dG74h7XNw7iiCthLnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0M2UZKZQ4GxzQNwG7RL8faMSC5NtONh5NXgaiEgeXHsPYfhBZ
	qwPfJisZTrNni1FChyUYNH+gEt9EElYu4OwsIiu9SoZpP4UA/JuL+vNr
X-Gm-Gg: ASbGncu6c6dGwfRRx3SZ5xd4g/5gBbqXomrmiDCsxzkCN6mjtoRnEeOswAqUxWDLINM
	puruyc0Lt2WtagE0KO2ZEyCSRhG77YFSXCvJW03kMG4i98pOalU4BFEr1+rw5muoPxsFJJ33I1T
	ILZlPScNnh8R+2t9eJCCl1uCk8SzLhmy0CCaNgtZ8hJcho6z1aJ9Ey1+jyLqsx/45kldWHoKpHo
	NI2YS7qX1roXCIcUsgqXtJEVF8nwSIij6BEbaRZqEwwVATrWL+ZhORlm5nWdjZYSFK0QLEmpa0r
	by1cJ554ReAVlaUW3nCjG55gtqMdxCokZf+9rfnm2aDMd3iGDDA+d1E8g3tB/9YKPL9OqY0HSwS
	IHX0tRXzin5tcpYPddw62llfYnDiO37+OxeWPvxpcQvpelwyl95/6/OKRRTcKsZove91fKFQLoN
	OvfmiLiUmSeD6by4C/4So4Vkgt/1RkK79+
X-Google-Smtp-Source: AGHT+IHLM13r5LQMnt/OJInRecUisomAa2MvrC2cG1/52NjvwtuMZLiyrwCa048XZprJyFm6wajB2w==
X-Received: by 2002:a17:907:3daa:b0:b40:5dac:ed3f with SMTP id a640c23a62f3a-b50a9d59a8cmr718516366b.7.1759996806312;
        Thu, 09 Oct 2025 01:00:06 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.01.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:00:05 -0700 (PDT)
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
Subject: [PATCH v7 14/14] fs: make plain ->i_state access fail to compile
Date: Thu,  9 Oct 2025 09:59:28 +0200
Message-ID: <20251009075929.1203950-15-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... to make sure all accesses are properly validated.

Merely renaming the var to __i_state still lets the compiler make the
following suggestion:
error: 'struct inode' has no member named 'i_state'; did you mean '__i_state'?

Unfortunately some people will add the __'s and call it a day.

In order to make it harder to mess up in this way, hide it behind a
struct. The resulting error message should be convincing in terms of
checking what to do:
error: invalid operands to binary & (have 'struct inode_state_flags' and 'int')

Of course people determined to do a plain access can still do it, but
nothing can be done for that case.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 77b6486dcae7..21c73df3ce75 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -785,6 +785,13 @@ enum inode_state_flags_enum {
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
 #define I_DIRTY_ALL (I_DIRTY | I_DIRTY_TIME)
 
+/*
+ * Use inode_state_read() & friends to access.
+ */
+struct inode_state_flags {
+	enum inode_state_flags_enum __state;
+};
+
 /*
  * Keep mostly read-only and often accessed (especially for
  * the RCU path lookup and 'stat' data) fields at the beginning
@@ -843,7 +850,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	enum inode_state_flags_enum i_state;
+	struct inode_state_flags i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -909,19 +916,19 @@ struct inode {
  */
 static inline enum inode_state_flags_enum inode_state_read_once(struct inode *inode)
 {
-	return READ_ONCE(inode->i_state);
+	return READ_ONCE(inode->i_state.__state);
 }
 
 static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
 {
 	lockdep_assert_held(&inode->i_lock);
-	return inode->i_state;
+	return inode->i_state.__state;
 }
 
 static inline void inode_state_set_raw(struct inode *inode,
 				       enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state | flags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state | flags);
 }
 
 static inline void inode_state_set(struct inode *inode,
@@ -934,7 +941,7 @@ static inline void inode_state_set(struct inode *inode,
 static inline void inode_state_clear_raw(struct inode *inode,
 					 enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state & ~flags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state & ~flags);
 }
 
 static inline void inode_state_clear(struct inode *inode,
@@ -947,7 +954,7 @@ static inline void inode_state_clear(struct inode *inode,
 static inline void inode_state_assign_raw(struct inode *inode,
 					  enum inode_state_flags_enum flags)
 {
-	WRITE_ONCE(inode->i_state, flags);
+	WRITE_ONCE(inode->i_state.__state, flags);
 }
 
 static inline void inode_state_assign(struct inode *inode,
@@ -962,7 +969,7 @@ static inline void inode_state_replace_raw(struct inode *inode,
 					   enum inode_state_flags_enum setflags)
 {
 	enum inode_state_flags_enum flags;
-	flags = inode->i_state;
+	flags = inode->i_state.__state;
 	flags &= ~clearflags;
 	flags |= setflags;
 	inode_state_assign_raw(inode, flags);
-- 
2.34.1


