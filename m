Return-Path: <linux-btrfs+bounces-19627-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA24CB3057
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 14:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21F0C304ED9D
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 13:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABD73254BD;
	Wed, 10 Dec 2025 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/0VNokm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E3E2EBBB4
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765373297; cv=none; b=Kj0+hJQFLRGTVpLYzO66DsbtXIrMsVAR4sE/OO9eGDgxT2LpOc7muOQh1l6fge0HjzEitE6su3p+kds5pB0mW5SL2b61AzY+nicwzD/YGVQ23Iz9hqiJtyZFug0gp16ZTTpNNjyyJ/EEZsVzRIRF+B3/goHcYGPWgvXvdUD+yNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765373297; c=relaxed/simple;
	bh=0y96Rg/Sc/DZKTjXrB2SLvbAEQwO5jU1Mj9ZyK0f/uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3TXW9h+O7nmsLsv0bvlRNcwLZlGn5QEHnKdcrfuhGK8VADTm/Yd5an4W3JjHNj2m38mn8B0I6JbskRhoTeBf04UoqnIzxp3RkyMOZHGdNt32nl3f5OduAoLDte+W2Ei7bAJbhY6uKS74Ygr5eRtHo4Wrw1YSiJF9e9lNtSKIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/0VNokm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7f121c00dedso2092608b3a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 05:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765373295; x=1765978095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0EoHRAJjLBPvzSiHbkVQuwxwrsFggD1yN2TuQx/kfs=;
        b=m/0VNokmyc7yF00ImCp0qEuOLjjAXB+9E/yDJP2413iN5aquFAvWL+geNEcn45A5vH
         P8OMpgIF2jHwMaqPEsFbysnMlnRSodC2qZyW9sCsakk2k+9vMp0HR2ki2vihjMAtFPLp
         Fd5BgXiDrl3rtO40hY6JnpKSqDflJxZDi42/CbCRP0dHezhBdOIhLeojrX2seHYd5Zkp
         ekFbtIrIOETvMJbQLUClgWYoIu1yyzf6RbbYpB2oxbwJeHgebdCO5Ss+Hqk2n9QqLSzx
         NAZKj9QU70yrZTXS+a3PzpO/kpVN72BbNSf8ACgGLnp7mDIsfUlGaRA0TGBelz8Eg8wI
         VyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765373295; x=1765978095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0EoHRAJjLBPvzSiHbkVQuwxwrsFggD1yN2TuQx/kfs=;
        b=FSVTx6uBwt4pkETBgYUdnvjudWvXX+xJLUC2Si3LcUDIRVswqC1sxgwM6qRZtVNIUe
         S/89VX0Sl/u55b0K7WEL1eK9Tn3Te4V8uvAeuJLdnmB7w9aGUF6JpcuGNxk57l1RGZkQ
         kBqsZsfC95rBQkEdrd7DK2BEMxb/GFqQhpRy28E6P234pXoqQfhb5r0vam7lM7vKlZpm
         gIo4/NSOkL8kD23MC1JRp6NDQxVU6+xx8sV+lfi2C3BPDNI+vLpV+yFo9fxODbzNb3Rt
         B3sAy34gEqsvNsPhGYSq0YMNa+gwcZDddZcCaGBp2YZdgJu8QGSsILMA6+K1LcxjPhiw
         lB0Q==
X-Gm-Message-State: AOJu0Yz48wMu2n6aYdO0uoYPIQo2+GsZ8hsFVfwJ7yp476mXuI+Q+YEi
	us7CvWMVB9SAyafKb+Z7MKMpEyOwsqJ8IDs/+Vg4S+6cI+lixsMGIyOg
X-Gm-Gg: ASbGnctEGbM0fbtaeJBTOqIG8jESKiD5P/jkw1v2IV9z3cbg7FDchUiXVh6t8QTAf3l
	iwj1WCY34GYhZYtGNv6sX3wT+Ua3aVyA2I38MQnrFpflrOrCVCvIsW6uMmYh3ah+4E1M1TTCA2R
	bk/mtGaHlY76NiHFuexc1T3WKp32O6nVR9gWhJmE0dt/sd1899w0Fvc7jE7nvpWWhViuvQBXdHJ
	EZUN09lOvtysZGpRUnaUFmY49SapVIO6IEBvTNAg/fbmOO7y9Imr9h4RtgKN40vA8MIJF/KC71q
	Bqn7XN1lwLDTnHHAsoS+3YGFZH+lFUfKf7VB9lqgQv0DZe1LqxoQLA74NIrTD0W9oQQSwFqyPLp
	1TF903n8nfpyR/pPn/xq+Lc0/w1f+2b2UugXe/c3HViwt7lLEO01G0ly6fiDonsYQJL5FY/g9Sq
	vBYoBZKVkpphiVICBQBoZrS0bblCzaEUXq8ddsbtITJxDAjOnlfLBAwD9e4Q+yl6yga50=
X-Google-Smtp-Source: AGHT+IH3DAL63v5RtYmyafCCdGI7zA1aGFzW2ktPKp/miOeQXmJX/6zfEPMPaSCoKE/7giEgdyRpzg==
X-Received: by 2002:a05:6a20:7f91:b0:364:144a:d21c with SMTP id adf61e73a8af0-366e0ef01f9mr2401134637.26.1765373295222;
        Wed, 10 Dec 2025 05:28:15 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:ff8a:290f:c19a:6d03])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf748c6bcacsm17435261a12.0.2025.12.10.05.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 05:28:14 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: clm@fb.com,
	dsterba@suse.com,
	miaox@cn.fujitsu.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+eadd98df8bceb15d7fed@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: fix memory leak of fs_devices in degraded seed device path
Date: Wed, 10 Dec 2025 18:58:07 +0530
Message-ID: <20251210132807.3263207-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In open_seed_devices(), when find_fsid() fails and we're in DEGRADED
mode, a new fs_devices is allocated via alloc_fs_devices() but is never
added to the seed_list before returning. This contrasts with the normal
path where fs_devices is properly added via list_add().

If any error occurs later in read_one_dev() or btrfs_read_chunk_tree(),
the cleanup code iterates seed_list to free seed devices, but this
orphaned fs_devices is never found and never freed, causing a memory
leak. Any devices allocated via add_missing_dev() and attached to this
fs_devices are also leaked.

Fix this by adding the newly allocated fs_devices to seed_list in the
degraded path, consistent with the normal path.

Fixes: 5f37583569442 ("Btrfs: move the missing device to its own fs device list")
Reported-by: syzbot+eadd98df8bceb15d7fed@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=eadd98df8bceb15d7fed
Tested-by: syzbot+eadd98df8bceb15d7fed@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ae1742a35e76..13c514684cfb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7128,6 +7128,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 
 		fs_devices->seeding = true;
 		fs_devices->opened = 1;
+		list_add(&fs_devices->seed_list, &fs_info->fs_devices->seed_list);
 		return fs_devices;
 	}
 
-- 
2.43.0


