Return-Path: <linux-btrfs+bounces-16242-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E84DEB306ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314BF1D26130
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08831392182;
	Thu, 21 Aug 2025 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0EALgZJc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF10D391951
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807681; cv=none; b=kO5Q6VKaiPj1xA7cYYKkjWPFluu3R2QRlaidF6ZYgYO7KQBtPm+ReU3vYQi3adO9psA7DeInmiBSl18dGAzJ2hf99veJUCEIKopivs0qtmTHXUyqse5RjKnGmAoWQptcsq+x5FlxvDpjvcTwe5SNbQootimwZN3qc92EPFvNuq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807681; c=relaxed/simple;
	bh=BVFzQz5MM2vwh8WuHoPp+aDwxtfF8jTQaeq36xEpnFM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsRNe3gutNmxaBGwN/CdGV/i5VVjOS2hf8hKpg9Uj/JF2fFhhvHgyeacYuSryGyg5LvzgekZDjNiaSwWvJ1KSDBDxceMWeZNkg1bicAD4+Za2R2v5N3ZCfegE50yEDxhUEL2LUJy/l/f22VE0P7rcBZWPJShxX1DSeo+TSbHWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0EALgZJc; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e934b5476a0so1437985276.3
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807679; x=1756412479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJwH/2/AGfycifeN3K6mTcfvLjDiixS7hIcYHA0w3vE=;
        b=0EALgZJcGmEUK0G5O4pBhDWjcwtTiKu+ML1PFtFlnWJLRWnwJbMhtD7NKzAGLKSRyI
         2i2/21mj1G9SYs9Z52Gl/A03sJnpqd2vBA454oH5a0eECCXsjdVFRaveguTqQPLgXAIU
         As14Ad4hYniOV7Q/TitFvLF3BntzNRuAPcAjvWFHPffde6td9E82QvN/Z/F+LBuMDnz8
         KFq6dLUDp0aHPE1Qn1w2K0Gb12INRu2JLYIwaYgTYR0173ITncGGhgZefOjLFgsDoiT5
         pbnfUwmw7IN4vbBg4GJ6hd1qYtTfHIVcrnPRCqFGccfNWl9yM/741WuqSNMz3/IexkdE
         hcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807679; x=1756412479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJwH/2/AGfycifeN3K6mTcfvLjDiixS7hIcYHA0w3vE=;
        b=Cb7AKJzjx01n9Zfir26zFhVyRGQIC8WiFc+4kV+lTi6CJYrPYDhBnja9JDOhwTn/L9
         D6jKXdB7mRAStShxhBdpwNngK+RCokgV7KPEYb2nmLKE2K8oltztR5Uaz7AXxUoCUM1Y
         /9kx/EzHq/uSWYsiqoM8g6rCdWw3pLotrrpC3wcc1opgY/9NTITyWVEjAMFmnRVd+erx
         BIWPoYB1zEY4UtcFtxAzEplojMYDMSHwCh9pbFu5RkPeqx/IHAdEwp6t16bg10oPtgpK
         MSp6vvSugGY8A07GmjWPweAHp/Dw7wuR+C0R16PBnvtkcTAGk36xIit/kp97t6WtGo1O
         FkXw==
X-Forwarded-Encrypted: i=1; AJvYcCUaCm64rdjxyXmpDxQOtRNHKAkLtCxKRravigyrf2E0MGNi4XpS7Qrysw8nV6dlgP8DCPoXafB+rx7pFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2/tYKKEgUWVOWwZb8oVHB0LpzSi0WRdWoHZ/o0AtBrUUhEFDI
	tgq4QIAjA8rebMrZ4EzqRumV+Ql8Bm/Gq9VjYwkllrmMt4/5gFTbMXzaR8zftvvLxrI=
X-Gm-Gg: ASbGncv47kfiyOCBGh1/7hYDU6Zd1z7MQg50/G2uLQYL/1K3ebbL6GaJpCclF67rHcG
	4c8Id8fOjexdRGX1r8fICYiBiWZyx9j5dZTx0jWsaU4EkskhcVAxCHlJWICNyZBfXvj50P4B3tN
	Oo/I2Mo8ISUTXbWF+XN5CCrHXUDvxPWInlcT6hACX+wJVfEuNj2PYNt183UKRzmRzrFohZZmes4
	SKQF2/dKq1xuYJnmmpmnIMM3LbfKwUnf9h5R6y2dSAqS4qxi29CWd33yXdQRYqlqXJbKkCTApYH
	MCyjE0B+UjyYeQhrhGI6T6baf0ba1h24HBh+Lb43Y9UTSvmYTsPlDq5Qh/w1QAdfZ+eMI8xvrDi
	ToH+6IiPua9fUNjuI9Y4XXD84YG+uPmDJPyT3g5UuTAS8dgiUMcTBdl8gyoEZFP4sPksOHg==
X-Google-Smtp-Source: AGHT+IFLh1NRGdke0rPvIun6BwDM+j5CUgCx0MIDgv4txaYGE9873VFVFQQgPIyDR56MDTrNJvGMzQ==
X-Received: by 2002:a05:690c:305:b0:719:3e4f:60f7 with SMTP id 00721157ae682-71fdc3e8edamr6284457b3.26.1755807678549;
        Thu, 21 Aug 2025 13:21:18 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fb82b39ebsm13478727b3.42.2025.08.21.13.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:17 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 41/50] fs: change inode_is_dirtytime_only to use refcount
Date: Thu, 21 Aug 2025 16:18:52 -0400
Message-ID: <b4913e1e9613eea90c47c2ec2d8de244e1478668.1755806649.git.josef@toxicpanda.com>
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

We don't need the I_WILL_FREE|I_FREEING check, we can use the refcount
to see if the inode is valid.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b731224708be..9d9acbea6433 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2644,8 +2644,8 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
  */
 static inline bool inode_is_dirtytime_only(struct inode *inode)
 {
-	return (inode->i_state & (I_DIRTY_TIME | I_NEW |
-				  I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
+	return (inode->i_state & (I_DIRTY_TIME | I_NEW)) == I_DIRTY_TIME &&
+	       refcount_read(&inode->i_count);
 }
 
 extern void inc_nlink(struct inode *inode);
-- 
2.49.0


