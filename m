Return-Path: <linux-btrfs+bounces-19686-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C2307CB7E68
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 06:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01C9D300749C
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 05:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0B530E0C2;
	Fri, 12 Dec 2025 05:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcbJuKl1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B002C0F8E
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 05:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516232; cv=none; b=No3TSs5M2le/X4cxJ4zpNkvXjg+2zYwHZgdPG+xHlG+cFkVvLalfCW+b/bCxhMMgu842H6oHdahZHjzva9TqJfN8KgKTaE9WWxkF+cwbSKJBzThZDrhoW+tcPYcBcn61A5uxQkV4GDUGmsQxVgCbIS+OSQ9z+dhPCfs67jr4xwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516232; c=relaxed/simple;
	bh=+QbwIsGFtOAOxHyhnigtpeW/T/EoCdL7z4QQ5yiyFDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G98Jgbso0QOobU/0M/91zIi6sS/mO7dRYDmd4eUx5DFikhxaRbTMHjghf//DChtrV7lUOKFVUxbHtIT5Xs5rkrueEWvuDg79uldvawAA6RihT1V5ZfJR3S6A7ZOX94PcTg952oyX1Sgo0tnu8kVN/gvJCHK8rlxvXFyaI34EDEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcbJuKl1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47774d3536dso7498105e9.0
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 21:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765516228; x=1766121028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VWfjokNPzh7X1rJCqlHp/9EQRiD7vxDjpu9aO4qTPro=;
        b=WcbJuKl1i2EwVKYKkubE8Cxc4BIyA5fFhuhAld6agFn+I5T0YZgAuege4ZLVVZ51O2
         AAGA+VfA+l1poLNEmlzSW3/Akg32Z5Tbd6MdqUaComKSoVQqFFICShspL3Uf88BuZsv1
         Z+xasV/k9MxI9MH1nIuZd4aq9teDFk8oLvejW/+S+bZBgonxpN0JdlvNE0rpca+DtT65
         1lGHihL3KjCn3NJaA7nZmbMPaOcpyJbrpfN/8DfgHtEP3OEcLtWtmGJuLa8BNCM6KQtS
         KzRUgelMbKvYDB+adTvxNOQoNNAXNRojp1xYRKsRj0kGDzDIZsjWmKz95q4XAFfFFUEM
         5LTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516228; x=1766121028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWfjokNPzh7X1rJCqlHp/9EQRiD7vxDjpu9aO4qTPro=;
        b=FXaThmttxL+LbMhpv8WNsAmGfqxfbmEajm/X6Pb+6akX3bsEVEfKdLeeuyeHTsI7G/
         U1UoT+MYLwNd9jDwFohXDyyJjif5SLqVEV+2YYin2oHO2CFm8aqFt8kqJ+l1xCRvzMYg
         /M0kyX2amAXaCHRR33yjmIasLbALtD3O1JfUSGjgdhrLoszCc4Px+UVAywi8yCuNdlMu
         evEJkt6l9pkjjR330KaJYHHZjfCjj+eG/0/LycU0CHuxbf5hW+np03YPPJVcHWcanxqO
         ZFEV65CI2Sh32yLLMnmPR/faKv1wbn50uvC4ZM1julJ5P3FwJhllYVJ+BIF/grBSAXMs
         BU9Q==
X-Gm-Message-State: AOJu0YwlQ2ZLxp9N5xX5bHnuj/FSZv8K62SF/VDwxdHMNtuQW/vs4sqj
	s6I+V/cgNXaG1LTmUlZn+/Rh3AnmOpEtNZ0wIEp2ec8xQmtPC9Y9qh4N
X-Gm-Gg: AY/fxX7mlOGD7MNlabUCzwo23ttmipy2B1C/aop5fpLPM7bQ59kyN5FkipCxZTvrFvP
	NJKc/Tz990bsxgxuXDt0E2TYv/i0gLmcOZqUmWH09jdc5VTW4bHzikNBA07i4P9hxKzDFfDHxVK
	UaCF/BPCUUQv819iiXJhyac75mUbygmsX9NxxpE+4ybOshVWQIQdZcO3KSZRPhi0zFZEZA0GZBA
	P5B7v1+p9O3NUUOlOCgBGPWnHnYLmQnmkjOHeusepU7X79pstk3cf1+wJwSBMHUiNm0EHkerwMp
	kp4TvMewXXkZAFwWufo/QGQOsxEs5sBccOS38RyVr0tf5TxjV18egfv67nOh9wsMtksLD00DhTK
	bkXi3t5tj0x41XFmmfI4dD0gRj83fpzlSPuEYNWjapPGzvIQMof6CYw5YS8P7tA0d7YnalqBBtC
	UZFEH7VjCejA==
X-Google-Smtp-Source: AGHT+IHlUosVpVBsrD5MQlJlQvz8K7YPFuKolIoKU1rZZCQg3XJJTrvY3nYKnXnpQ1Is//tZSc4lRQ==
X-Received: by 2002:a05:600c:6290:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-47a8f1c1e65mr7984275e9.10.1765516228099;
        Thu, 11 Dec 2025 21:10:28 -0800 (PST)
Received: from eray-kasa.. ([2a02:4e0:2d18:46e:3ea5:404b:a2c:3af8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f74b17bsm12292445e9.2.2025.12.11.21.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:10:27 -0800 (PST)
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	syzbot+2f8aa76e6acc9fce6638@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: fix qgroup extent_changeset leak in page_mkwrite
Date: Fri, 12 Dec 2025 08:09:48 +0300
Message-ID: <20251212050947.148242-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a memory leak originating from ulist_prealloc()
called from qgroup_reserve_data() in the btrfs_page_mkwrite()
path. When btrfs_check_data_free_space() succeeds and
btrfs_delalloc_reserve_metadata() later fails, we free the data
reservation via btrfs_free_reserved_data_space(), but we never
free the extent_changeset pointed to by data_reserved.

Add the missing extent_changeset_free(data_reserved) in this
error path, matching the other exit paths in btrfs_page_mkwrite()
and the failure handling in btrfs_check_data_free_space().

Reported-by: syzbot+2f8aa76e6acc9fce6638@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2f8aa76e6acc9fce6638
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
---
 fs/btrfs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7a501e73d880..4b05e72249e2 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1910,6 +1910,8 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		if (!only_release_metadata)
 			btrfs_free_reserved_data_space(inode, data_reserved,
 						       page_start, reserved_space);
+		extent_changeset_free(data_reserved);
+		data_reserved = NULL;
 		goto out_noreserve;
 	}
 
-- 
2.43.0


