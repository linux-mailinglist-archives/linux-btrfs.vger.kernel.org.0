Return-Path: <linux-btrfs+bounces-16372-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4F8B36E17
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460107C72E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973D435206A;
	Tue, 26 Aug 2025 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="J1abHhTc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57D134A324
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222858; cv=none; b=EDH7C3zCOlZJfFKUESMpHUVoF5Ap7Kg/3U/P9zd+8phPvc9Cfocy9wTN2CXX6W8jtogvY1IGXiU6nOMsrgwqFFGYd2MjI3sZW+w0cFu5XP39hBHF5QkRthmPmFrjxWyEvyUVkRpYt9iIf8bvHKGDspTMeehizaDrL8ESpp/JVoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222858; c=relaxed/simple;
	bh=v4+k47Nq015FWctgvCs9vsg/V/TA5kz2ykNqZmvSZkA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUXMTH5EBzggu7Bem6s9uFG+oeBNb5XsGYSjaU1wagVrREGXVWMolygn2h+MPvupfVmlJFxx+Js0AJAtehavfA3nyRb1frLF+6d+oi1DYIWjqm2luBgpYcFtnzDaCdR0b+obnzHFYZKiOj/gAjbnSOHtQpC7byV1Wzion0nzAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=J1abHhTc; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71ff2b20039so30449507b3.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222856; x=1756827656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DuEK+Kk5sFprszwTHehPZviexNLAjFi3s4jagEjiXI=;
        b=J1abHhTclwAwQu8lYot9DKOf/qKsH15+PFnfdRNUhoNOoj18/RMTkG4rzHRkO3TRgc
         pkPVxOXYql/DSGoIRaOyuI8SHTwF2kajtLGOP7VZHhA3nFFCMo80UcAJrhBtQzMY/mX7
         yXHoK/Kmp1vO0OyCYu3VvZBlSIEmhq6s6yGEIaMAX98eacvCjLc9j+mpWmIjKarcaDPz
         pzS4T0EYzm6SD0WVHSAIp6pxtcrPDL2AHacYY7WEn1Bc67OCZbiOxR110BRAYuuh2mqc
         9JoBiYeKIoLq7/lz8lCNUu2YXmt+uI8qPrTW5qbREQLWLccvYibIFImUV/Twco6fU/bV
         Sv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222856; x=1756827656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DuEK+Kk5sFprszwTHehPZviexNLAjFi3s4jagEjiXI=;
        b=AsVl8GJ657BkaDbOYueEmzzUhPjj6ecMbsP4OZVUNbrskT8do7LV59/H+vmUlpdm2P
         vQLK9I/6QjMJnpEf1cpyLPV/9B3faJR1eAXN97VyY8D2i8HLjJt/nlLA67o1C2kYmBUd
         KOrtcRyuCYpnZQoCt1uJkRuHT0RkheHtXqgeXlSFsWJkyVO0BTDXkzKBD4qSqYhf7sAb
         GK6eeeEh7Ug3EA7Zf+FiDOfiaMnKr/gTWgv09eneykYWs3hsWo5ft6657XZoFS+51Zyg
         psg6sC9D8WQyZQKSufF7VodCOE5C/CR9VAb8nKpIa9V2E/30rpqYkvF45ksEzXJmWtra
         ZgSw==
X-Forwarded-Encrypted: i=1; AJvYcCVy5hx6t4I+BntyRzPqdYOgW2wvCREjWNuqzr3WtXl2bMxTmUpJFLPSybdb5yO372dWb0Qi5Fz3lzJ7sw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/R38k+/KqqpdsxjqGYVQOp8uhXVp+Y/F1xWExg/N8Z6pRgsjA
	4x9XFF3vrQAqL1mi+CmN8C2gIgz8+1Va2B3QjSKB2QNjXcL6q/4Cc5bBr0Gm87CoSS4=
X-Gm-Gg: ASbGncurI06qiADgrI0Lmg56h0qSAnUOJUO3ZT+/fNmiwTctlPAKYXo1GDVKh3OVKyu
	Tnl7XMZfQltaO80A7I6c0bVULa3tzRQj2YN+pxWY87niv+xj86iWVDxjVTa7QJZOP1PXOggXO43
	85Y8iDto28rVSzATlqMRzjrnSb1HhnmSbxzuEBw/EydXb6e9wvv1o5xy7L7aDLjsu3VTuxnGYnz
	7leeru8KqE8IUc2Hr3CR8vH0XEVOeLAfbHxgiiJKSL/cuEizCN4BZF5IydNt5HPIXT7Gu383QAG
	DMXbWKljoWOmL5CmU67JWt4hSE0XPsPNyUO1nLVtW+LLLAssBvRRCLvBW3YLOXs84AVb3LvSM22
	BPw+TYkOqQ8RWHhyz3wsiTSkGBa2FBSQ9ChGw+/uwaGKtER6Y11fn/3SmjK4rnCPfhNMrJg==
X-Google-Smtp-Source: AGHT+IF1MI08diNCyXnNMWWu/+8R5wdOAhVg7UNfF70XcvUlTFYcLCsm4IxLYoWA+0GC1XqTbbEzGA==
X-Received: by 2002:a05:690c:c0b:b0:720:631:e778 with SMTP id 00721157ae682-7200631f13bmr110723557b3.30.1756222855550;
        Tue, 26 Aug 2025 08:40:55 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18821e5sm25322837b3.44.2025.08.26.08.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:40:54 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 05/54] fs: hold an i_obj_count reference in wait_sb_inodes
Date: Tue, 26 Aug 2025 11:39:05 -0400
Message-ID: <94e7ea33eef40e407b2bef6a200c9474472bc778.1756222465.git.josef@toxicpanda.com>
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

In wait_sb_inodes we need to hold a reference for the inode while we're
waiting on writeback to complete, hold a reference on the inode object
during this operation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index b6768ef3daa6..acb229c194ac 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2704,6 +2704,7 @@ static void wait_sb_inodes(struct super_block *sb)
 			continue;
 		}
 		__iget(inode);
+		iobj_get(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 
@@ -2717,6 +2718,7 @@ static void wait_sb_inodes(struct super_block *sb)
 		cond_resched();
 
 		iput(inode);
+		iobj_put(inode);
 
 		rcu_read_lock();
 		spin_lock_irq(&sb->s_inode_wblist_lock);
-- 
2.49.0


