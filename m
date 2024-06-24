Return-Path: <linux-btrfs+bounces-5909-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6449140C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 05:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F90A1C21E29
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 03:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CDC8BF0;
	Mon, 24 Jun 2024 03:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muXNjzfI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3578D515;
	Mon, 24 Jun 2024 03:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719198450; cv=none; b=QJA0QfVCbN2qSeN7JCia07UNvFA+o9O0Dy2zuhjbsxaBmiVa/j5EcaBs46DMjdOUFkRL6pI/iOHkoCVgzyAuGvbO4nLv7PVBXyh6KfZvU3OfH73EeOd5168+EXOwjpq54P4vzQs9530Dc5cPEhBQMUIZRER67SP45Q3KGIoQMgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719198450; c=relaxed/simple;
	bh=yJOIut0szfEzOnJOmqfOvO5sdb+iCam29V3jupcmOas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=thlzHa1CCWzCDIptMDBePW8f3KogXjqe15qFM8aO1i31EuoeNSaKByCEUXz5Zlqo6t0zoyhZw3EZJ1KyyxHIVFu/b8HBpabz+YZd2acdYzV1vP4csf6+EcIGHBjCwCFsjrJkjE25EvuUooWDE2PaWRKdr1DIL1leFX537a35s3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muXNjzfI; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70666aceb5bso1155630b3a.1;
        Sun, 23 Jun 2024 20:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719198448; x=1719803248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t2Ev2SnpvIc9PeMEYJ75DMX+rnT35qAdjQGrKk69Hf0=;
        b=muXNjzfIMd7SLL9gJYAXHb9qs/5h4K7w0x4v6F2xbrb3pSfWz8GeqdPLUfSiNIq7CQ
         O1AgZn2uF/kWO1ho+4gV8yegiQYIm6taj1pH0o8CtpeounhtWWFI3YCManGP5iWX7lxG
         CjmT84aBt2C0XEw9TfXszSNwOQxpiAI5YF/gnOykdS63MyUZmxl6eAfKjafyd/GhH7cA
         NwfSWxOayjDdbVK+Zgrti1hO6AjFO1kzvCS+PCQm4CC2gfTk3OtTWFvixbzN+XZGM4xm
         ksnGDwvuQqs73kxf53mZ8IEk1urPHla1sxkZhebSjK/tuUUVs/kagxFYK2mW1fQMCsJa
         gxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719198448; x=1719803248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2Ev2SnpvIc9PeMEYJ75DMX+rnT35qAdjQGrKk69Hf0=;
        b=RQn06oKH9Vv66tOS/VLLQsxRs22IuwadkyhDFb2olz7wxyQXNf5NsnPQEHrB999Zi8
         xPtSQ+LIwSyyq/XBuUtJ+IkqRbavpPDtkxQUGWr+thWpLaLHSDXshjsA/YL298PASOyo
         FuTLUSgKAVuiSnfMrHxY9qXGKSKV0Zyd8Lxudsvgk8VlnG3tNEqve55yA8X6f3/vh87Y
         yYfu+K4uOKVN+LqI1PK+N5q9dUmhYY6yFCSvv7+N3Zo73gs9fd+a/ricNeQmmiWj/5xt
         N+piH/Z7IOseUrpuelMpzS/Vf+e/DcKRe2xUVN3FKPnNQSsAfbkwSI1rUSJGckKqkoSL
         q0QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmLsdTEKTjNwlBk+rpb7DM1kPWCFCqlM1EXCYQZCrT3ut4t4lff1zOpbLOIzMUuy7NmHq5ftgsevgK/s4KG0QS25bnb+9c5IbH9UIwId8MY3NawPMovIQ7Seu3f0Pru4CO/tRBP7wZOX4=
X-Gm-Message-State: AOJu0YzmbMsKtM4PO7CgLOdMiQ8aP3ZgA+vapGESmZ+pgjQx7KT1TAFq
	gRVmdOt64dJiDaHmdUtqDwaCP7IsqBpJEaJribH8bARR1WnJz2wv
X-Google-Smtp-Source: AGHT+IGf1J9QbqM9KO5sJmtk53ZgT/H0K+Zsy4i9oBx7wjlAXwnsjFARyzYLWQPIvNoQGJDqHk8+zg==
X-Received: by 2002:a05:6a20:6a9a:b0:1af:e3f1:9af7 with SMTP id adf61e73a8af0-1bcf7efdc24mr3286980637.36.1719198447927;
        Sun, 23 Jun 2024 20:07:27 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e5af9ddesm7570599a91.38.2024.06.23.20.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 20:07:27 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: clm@fb.com,
	dsterba@suse.com,
	josef@toxicpanda.com
Cc: syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com,
	fdmanana@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] btrfs: qgroup: fix slab-out-of-bounds in btrfs_qgroup_inherit
Date: Mon, 24 Jun 2024 12:07:20 +0900
Message-Id: <20240624030720.137753-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a value exists in inherit->num_ref_copies or inherit->num_excl_copies,
an out-of-bounds vulnerability occurs.

Therefore, you need to add code to check the presence or absence of 
that value.

Regards.
Jeongjun Park.

Reported-by: syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com
Fixes: 3f5e2d3b3877 ("Btrfs: fix missing check in the btrfs_qgroup_inherit()")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/btrfs/qgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/qgroup.c b /fs/btrfs/qgroup.c
index fc2a7ea26354..23beac746637 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3270,6 +3270,10 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	}
 
 	if (inherit) {
+		if (inherit->num_ref_copies > 0 || inherit->num_excl_copies > 0) {
+			ret = -EINVAL;
+			goto out;
+		}
 		i_qgroups = (u64 *)(inherit + 1);
 		nums = inherit->num_qgroups + 2 * inherit->num_ref_copies +
 		       2 * inherit->num_excl_copies;
--

