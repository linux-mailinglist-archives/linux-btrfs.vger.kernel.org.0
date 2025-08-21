Return-Path: <linux-btrfs+bounces-16203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEDBB30630
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7034C1D214D2
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2297837059C;
	Thu, 21 Aug 2025 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ifMkrRm7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB5350D79
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807623; cv=none; b=QcgaGKurijd84SYt8U5mLSPovVEXwV49qLMsbFjOshrXheBUYqGnHDfMNc53WKFZ7/FHZNUyn0A0HFPNL07XnNH56dxU5XnkxjIDJRuUHlf7U+XYzHKX2PbyeLj7HGB9JG3oApCI5Ujx8T1XbQajuAcdwjUdmptyPzROzG8r7yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807623; c=relaxed/simple;
	bh=aMn/6ao90XzzaC4s0c7CDFRUmP2ZTM6xnRau/8BGgmM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVvuR5OiqUPzKINnEAkj40651c4mA9e0MbMpLVS2fSi/TgRyr39Xyc/QxGbI3DVE5dBCFz9Blz+arSyjHORj69q5sNUDQlsgI2uc/vnGJOXjhQtj88edzAGkmxQVZ14ZqGx5MXr/bq8qXxuc1FCeUleculYG//xOoN/Q1khIg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ifMkrRm7; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d60501806so12163417b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807620; x=1756412420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLN4UbEHNtGwPYNoqmeGrAHZvRznKShz2RgBNkDqb/A=;
        b=ifMkrRm7ay32qJZgOfIEyjhwpWOScgUbN9sWTuHTBsvcij8ymIcrx+ONEZeZ0IBn22
         TIG4gT552lSvTEOfdc+23VuK1CnpMb7w24kAPoRJAAlzCPO2fvkkTG0gp3xPyRWx4dAc
         re/lAV9JBg2TrweT+tevjQRsJizGAS6anJxRQ1QN4Kl6Jfqr3quDpGPo3r5hodCNZRLR
         plhTPrivgk70/GRWVmX6c8V0Sz5dioG9oGQs29DVt+vVs09UXpovNCxZb3b0juF0iYLG
         BMuJPKxZqi3a77vvxecvjU2YKKzRElCisRqMuoVmvwOMVoTtZDfq6x5ivJwWaiFuQ+yW
         nrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807620; x=1756412420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLN4UbEHNtGwPYNoqmeGrAHZvRznKShz2RgBNkDqb/A=;
        b=BI0vbAK68XaMBX1zELUcD4SxlID58ZjL8CdIHI0JPbUxr1B3DuKrSeUg9ch5QqXqRv
         PESAHT0jiSTJHh8s/KfrYoZZAbrKZ450Esr44HJm8ejsOYM+DjgbaBgmc/oscH2VFf/f
         SY27lQtGpK88EGjt12AoquAgCmJL8rrmYfmT5a+M0k5a36aYAYdsAvleMeOpw8YYCMiL
         i/K94Fwk9FuIcQlwwGl2G1KSKLZWJ0Aqbi2AIPP1n/jzZyLkse07RYGGRZMPWzkfAfgm
         5tW7D1pc43mB82ddE8q3lDPG/gQf32iuaFdKXuApWYvWKnG88PfPqYEiHBxXaMDDz43s
         G7Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXrCotki/lvPKLLIQ1g+alVa0SRKYIN8YYoqPZ7Fg3OGkRTibh8/qWfh1MfNfvrxeDKMUMIkCCCwfnZPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVVcSherT7h5NjkG+I19HySLaXj7QJIdeYpsOJ5K9qD4xDjUd1
	8etFVGTLR1LLK35C8N1Kw9cd5SV74RLo+aVMlbB9fhxXDH+iAJEDWZVwb4CsnilA4AE=
X-Gm-Gg: ASbGncvLTTi744OSqRiyA5XfVa41XXpxtfBbPU7+E/3oD/UJ67qAp7UEiq5EAIQisr2
	Tmjn4TETNA3VGg16cmySNlUXf+ARfKypiK6grSG2f8IfxCWTWle+KxotI+OTQ6umcA0woM5ADOq
	lWDoc7gAmOIAsR4+rUi2HAFZKlRZhx+E87yAqgOykO+oB9fQgyBUIP4xUS4wrQ61jRjXm9RBfTN
	H9cOFPLVTHRZreB9hMRk3sc0yzfZA6jjgRazEK2cMDOqUjmmD5ozhADr30wySdrDTzhM5RniwaU
	rp9B/u2HXGAIrhx804QBow3V68suJi7g40DF5LH0u3US9jUPbsVg1uZWsKUyLOxOXR7DymtzecG
	BBu5eKNRa8Lvsvmqy6EKBmECzOYpTKdy6GPPXT4eBifqek+W2++O5jtMiSiTCMKgHBmdfzA==
X-Google-Smtp-Source: AGHT+IGb0qgYBLWVZIch3EbtVHWOhrkqQCA2jAcmKvem4xmtzmk5uwLi8F7ETWvIrlxUB1p8XxL6IA==
X-Received: by 2002:a05:690c:6711:b0:71c:1673:7bb6 with SMTP id 00721157ae682-71fdc326e68mr7121847b3.23.1755807620154;
        Thu, 21 Aug 2025 13:20:20 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e0be8b0sm45782287b3.66.2025.08.21.13.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:19 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 03/50] fs: hold an i_obj_count reference in wait_sb_inodes
Date: Thu, 21 Aug 2025 16:18:14 -0400
Message-ID: <e8edf6189d036e2222ed2094cf625d3cf06e0111.1755806649.git.josef@toxicpanda.com>
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

In wait_sb_inodes we need to hold a reference for the inode while we're
waiting on writeback to complete, hold a reference on the inode object
during this operation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a6cc3d305b84..001773e6e95c 100644
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


