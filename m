Return-Path: <linux-btrfs+bounces-19678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ACECB77C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 01:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C992A3028593
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 00:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FD9246BB9;
	Fri, 12 Dec 2025 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZVbLxQU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7D854774
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765500754; cv=none; b=MQIkpMYACpjJOQcnixCNGIzoUH4kM9i5HQYp7zfH30FhuMFkuVluTC25aMWGUMdh7yLVFJ6CJCW2yB2Ur2/6BNCCVqfWM1PsT+mncM5sKAHVGQbvmLYuRkWzfR9HUfhSr5forA0nz/MOtqeh/euahz7e3jAqFebwM+hi6dr7OTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765500754; c=relaxed/simple;
	bh=J4ELztX1+1Bn4VhjL+ba3qYZW9szCle+z/JOvLWRu80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Im0AQWbJiyQJsjKxkmzenhS0DcSVr3uLTtHD3iZ8NdWmFHsJZ3WMCYcnxZUUaiZDNM79Ef0akARyBfYggpO7ywT0FfIrRUlO5fDl5JiCgNDSMpGDs2Jq8US1ssrfEtvWmWJU95iYpW9u8jlxclMlTxaEORoI9eBitRLWL9OPIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZVbLxQU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-298287a26c3so8599215ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 16:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765500752; x=1766105552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ooohlPAjf/xTF7J/ARjfz6I2zejWmwOZ4ZiSMO3CRwg=;
        b=fZVbLxQUfc4tSzcoA9o9fcu/kEPeF1Y+vxq2wQs9H50EXA5J3xqp/mVegIMXywkMHB
         GbVIFEKYVtigvaVtJ6/cd+zNZkxtkWunb8Ay++qom2nZDWEe1aCv22cszonFuLL1u/xK
         QjK5f45PNiYCRO2PCFov01kXVCU1ChCfG1QQ93exlYBMT2/RhD8G3xeoRL/iqghpX65h
         +C+51sYSGmMbuur3F3md9+Z0l+4qQqeN11uEYtzD2ReVBXQBBqlyWRbkJo2SQCCSJBQV
         LtdTUllczDU3JMR2IuaM+5obTBt6dpI+j6jw00oM7MW6vBIMoiePUcn9Gxb+oTME+dlP
         NgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765500752; x=1766105552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooohlPAjf/xTF7J/ARjfz6I2zejWmwOZ4ZiSMO3CRwg=;
        b=Vmmf4rR4+ezMMq706uxmedrDoWU+JI+lb1e9cGLaYk/WUmudIf7UOHNTfUhrf5smDl
         Hb4c3oIHYG2wpo4uDXI6yOf8DgnOfxcHYb6s/9eoVBkqa99eJBzKDWUk1j3vrnrnepAv
         Iw0pJrjSnkhlRC3Wimr/wmjsNQZYapZqoXakYbiFcHaSGxeVyZtasVEITf4cgC8+kMfD
         sMdEQtlGIbIUa+VdPBPpmbX3sORUhMzqbLhjGZ9XbdiMulL0F8cNhB/JmQGrhszwHfeC
         7IAcUxZTNWIfn25D3i7ASqe2eF84OABlByq6H/6nrtPfQRO8JQoDrWZiWUS+04p/QfZ/
         a5dA==
X-Forwarded-Encrypted: i=1; AJvYcCW02UrEdLgJ+YhTDOhsu8WETVpy2zsKMAqbCAIyPgYsglzUEZMN0P1UJCk/ZuetafFNhf33J7HvjcLP0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMr9vC7K7QqZBHzVzZZvzTt4Bi3bSoNE0XAselBiX/npxB83mx
	JIuJtliN5W3zh3oHzyLNc/KBQTADMoCy3gNCQCUfihZKXibqOAFDdiFL
X-Gm-Gg: AY/fxX4cVzfIcRw9ULUJqCt2EVuxngJ17Y4b4CaK2B8g2hJfmwiA6+VFSx3neU2E6Qz
	oPqxAQN7j8Mu4in/ns+KqwvGWWgscLbshiZ5yAzRI2KRBoG2lpMUPSvxcmebxoxIsSz0x8uJh3j
	RzTUY4FvXFnUs1Ya0aq0Te0N6/bSJ0lBNIk9l41t6W/cnaXNpswwJn9rrtwqeLneNomkmdRHBMP
	7nuz7y6dkx8duR/LiUkJazfhdcUsB9Achhoz1q9k+wcijKuDz/3P8ZkTLXwyzHPvheToEO6xxD5
	tAKTZaRLhmDm8Gm+peVMlJFIe9eo3ufGGXVxX9mr57dg38ByNWPwT/MtoJslvjQdQpoLOAT7cs7
	tHLCAHvac5AfpgvRDYSYqENtg1wWmDFS4ioWZKBliO5/xpvJZ/LSObdUWSnazihXO1al+h+4dDa
	McMfLpj/S14UgNcLMuFS7TrZc3SsneSerlOQvIFQJMZ7JRmGSrtgzfpCJIVPGzKTeVH54=
X-Google-Smtp-Source: AGHT+IHJp/TkQFSvV3OJIJ/jWJYXIwHK410bR8I+yfx0MgpdbZNrz228EVrGpnYhhdhCWUEUpfY1eA==
X-Received: by 2002:a17:903:2b03:b0:296:5e6b:e1c8 with SMTP id d9443c01a7336-29f23b50d42mr4022485ad.13.1765500751976;
        Thu, 11 Dec 2025 16:52:31 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:8924:b5f2:ed79:957e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea043d21sm35206505ad.81.2025.12.11.16.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 16:52:31 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: wqu@suse.com,
	fdmanana@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+803e4cb8245b52928347@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: qgroup: fix memory leak when add_qgroup_item() fails
Date: Fri, 12 Dec 2025 06:22:24 +0530
Message-ID: <20251212005224.3565337-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If add_qgroup_item() fails, we jump to the out label without freeing the
preallocated qgroup structure. This causes a memory leak and triggers
the ASSERT(prealloc == NULL) assertion.

Fix this by freeing prealloc and setting it to NULL before jumping to
the out label when add_qgroup_item() fails.

Reported-by: syzbot+803e4cb8245b52928347@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=803e4cb8245b52928347
Fixes: 8d54518b5e52 ("btrfs: qgroup: pre-allocate btrfs_qgroup to reduce GFP_ATOMIC usage")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/btrfs/qgroup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9e2b53e90dcb..4dbf6d2d2aaa 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1671,8 +1671,11 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	}
 
 	ret = add_qgroup_item(trans, quota_root, qgroupid);
-	if (ret)
+	if (ret) {
+		kfree(prealloc);
+		prealloc = NULL;
 		goto out;
+	}
 
 	spin_lock(&fs_info->qgroup_lock);
 	qgroup = add_qgroup_rb(fs_info, prealloc, qgroupid);
-- 
2.43.0


