Return-Path: <linux-btrfs+bounces-16245-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DD5B306EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5F4B0312C
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1F1392A42;
	Thu, 21 Aug 2025 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VnRff4S1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18853921AB
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807685; cv=none; b=tW08VX/gnUi2zSYGWzLPmE2gCmHvr253QQa4VyfiL2buP4R/0g1w2Cd+7J0bZFCBlNH67Xvm3BNT4Nqv+wW4YTLB+0HUWV+GSyWdYRzXG3DoLYsWGmsrsNsqxMZAlQV6WY8UWAvtQBA3wuPaSRS9mtondVxosnaUmS9GM0ijF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807685; c=relaxed/simple;
	bh=0ZjV+DUCSr2pMjxDPkN/PoOVM2MR73/8MF8nar2aCc0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtzuRb+SJZ8EHSv/eVrp4pG+tBZ/eGIyjrMkUQgw1s+R2oDZWzlEDHOURWObEctbnENPyqpsa7vRo5PvixsB6rSQQhAnss79/a8OOWCzcCLT5eNjF88ZXQhiD0axLPMxBHUoJgDxUnFYmhBFzHDJo6o+meUEK7AL+w846axoEGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VnRff4S1; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d5fe46572so15110747b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807683; x=1756412483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dx0/asqotG4rq6EdmXwwX9N7zT6RzPtjLNznPWUyIY=;
        b=VnRff4S1NyTjF6Wv4trGP6bKHc5cpMxvcVUKD5DYc+jaXv3qa/saOtoI58ljFhapSv
         dgP7kFl5W41+9GNsCT5lIfWcvIwt1VFo+62WBiVA9rrj/jS697XidiOCOePeNJB7ZncK
         oi9LYJj9GshsVaB8j/JMuNYBd4cLHgoEF5vlJNPmmbGjQwuhuCJzJhVAajcRD8tMsdHO
         qWVODynV7sfegkm7F5UnmW9XRXKtfAYgGY8vHtdx2xOsrTOsAAOx6/lePAZbZplAx2iY
         MVAbHQEyBH7PSonMfYnser3L+W3LITLH51jZFabt2BiNonQbKfrygzuozGL5Lh9sD23i
         xFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807683; x=1756412483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dx0/asqotG4rq6EdmXwwX9N7zT6RzPtjLNznPWUyIY=;
        b=TCloCy0RBVDMkH2NGXvGhaZMpir1ADiYeuW0viTszakMoDFI5YX04jBMz5eW5zpS7O
         5nGLGuUIAeg18p2ZBywfi9i2wj4OlR2xcP7l56VwwSNt/nHFYthg08nBh7UzPTlTTdYj
         Kj1Kz/8x1rD4yt2aPDu8KD1vs7eLy3poeMNPqLXH8m6l0t1fkKNUTbl5jg9QBRjLVcT/
         xxeuXvvaroBtxQAVi5YKZlhPuv5+jQOSkwO34iMJVAexzLoh3fMq67WXALuf/JkOUFxa
         T6Re7h7ZsbcVemFEglbgDBsfE40cmRNc/s+IKStS+2fQ7F1Ee9WNWybMCIQChvJAGjRu
         Bj3w==
X-Forwarded-Encrypted: i=1; AJvYcCWWdkx+O+rHVuMgZGRn5MCHgi2iuqHbrRnazpqOwCeynnMpkdJg1/z6Rtmjb0i0eB9dEPe+v61eWO8IIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvmkOYgOiF07pdvBON7v2ApyWcgeyfrO1B/XCr7EsAhXcAbe+9
	4wQTndYIrjxaINxrUtRs8oTuMsf9ykBGGKXJtMzTlTicrdQzCSy2HCW/IcRpNr81uSE=
X-Gm-Gg: ASbGncvZq7YR6LELYE8yvciNf9xX4fzr0RXJHitK6DzZDFTn4sfmJ04PSbskLSXsURK
	dzx8d3j4pa43yyoMmDSfz2Lcf970Kd/tNbaPsAFJNohWc52SEDdmR+nYP1JRvV3QD0kGLUABJ4u
	+lUpMC8XAZ4h6nVCSoRgG/QtejihdSM3vuuWH2O70zAzfpKANtuXOvLiU0UTZ0J48/zPldkUag6
	WMVkGnIXeI+6qnK2eaktqRCEyTwZXpyWuOq8KHQT0gU+ZZUmPfYCAIVab7yD+3RvTTncrMJvy67
	zmInbHqFJ+Uc8THjiUHPDxMTumVff8x7WtLWNdUtIufTIOxFeTCBr++2y+zA7jKpqhaxV4dOwk9
	5bm1EZbvYU5oSccjTen8XVDbWZIJ9UaaU6UDpROgW7icTNRtAikHUBIKqiqVg8cysp87f0A==
X-Google-Smtp-Source: AGHT+IE3MKR1OshrNQhYMfUHpxtul5RNV78jpcHZ1k48ccvq/Xk3W8ycFnx2cvyOFBjMaIDV2N2ulA==
X-Received: by 2002:a05:690c:3345:b0:71f:9a36:d330 with SMTP id 00721157ae682-71fdc8da73emr5864447b3.25.1755807682899;
        Thu, 21 Aug 2025 13:21:22 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fb71c1acfsm13948477b3.71.2025.08.21.13.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:22 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 44/50] ext4: remove reference to I_FREEING in orphan.c
Date: Thu, 21 Aug 2025 16:18:55 -0400
Message-ID: <cd9f2a5d78d6863fa529da33950e5f2f0f26de60.1755806649.git.josef@toxicpanda.com>
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

We can use the i_count refcount to see if this inode is being freed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ext4/orphan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 524d4658fa40..40d3eac7b003 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -107,7 +107,8 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal || is_bad_inode(inode))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode->i_state & I_NEW) &&
+		     refcount_read(&inode->i_count) > 0 &&
 		     !inode_is_locked(inode));
 	/*
 	 * Inode orphaned in orphan file or in orphan list?
@@ -236,7 +237,8 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal && !(sbi->s_mount_state & EXT4_ORPHAN_FS))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode->i_state & I_NEW) &&
+		     refcount_read(&inode->i_count) > 0 &&
 		     !inode_is_locked(inode));
 	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE))
 		return ext4_orphan_file_del(handle, inode);
-- 
2.49.0


