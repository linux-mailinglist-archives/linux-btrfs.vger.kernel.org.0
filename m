Return-Path: <linux-btrfs+bounces-12421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8E8A68BA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 12:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EC04640D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 11:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDD9255E4E;
	Wed, 19 Mar 2025 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="aUBE+dtp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C93254AFE
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383457; cv=none; b=SpUvFu7SziELBZq4VJ7Ml9K+ZeN23zRxyMBna3Fjox/BOWmaqPtAG51GsVJwiM1nb3l6yyO8ACE8SwHiOjyiJqkliqr99MyuURpUOXXme+cKuJe31/3uJrJLC7wRyKxKtPBe9PS5OU8nHJmc/wG/FzAIHTFE2Ay5sKyidOG+a9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383457; c=relaxed/simple;
	bh=vKkl9RE5EwEBFLtLPUlfSUx26PfPlZrX+Blb5dbT/C0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ig5f9d6DJ3CVbwlMj+0fahNV2NEUynurbvS1sMcDO8BWtt5s/76tPwUqMDIDDZO8MBMhbUh8Y4bYzKjuFFdCDTUB0HWlafTZTONkBzFWKeJx5gAI9TyXpADZNXKOhRrYQf1J3VkV1Yqq40E5ACsabASszI8jmh4409kkKov2v2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=aUBE+dtp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224171d6826so37308875ad.3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 04:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742383455; x=1742988255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZvnuJrKt9TGuvAge2fzG7AvTvxdXtsSJqic522bGGA=;
        b=aUBE+dtpGvUlRQwt4d8VdA5uptO68I5pFyPKrCfXoY6NbDN70a0Op9CjuMrWhOtUN6
         inEY1+976vbuLP3lM1XPKSr7jtVopyungZJ86CQKyM3o+OmGuYMMCGWYe9qMnFAR3OBb
         MSda/TSodFJzqsC+8m3KvrJodWq2tKHA94Cbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742383455; x=1742988255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZvnuJrKt9TGuvAge2fzG7AvTvxdXtsSJqic522bGGA=;
        b=TxigzsMHEfDYGioRetoUCCmByXqzmlOBkf5Fv9fYotc/+ZFsvmtzFsB7w1LydN+Usd
         wxk9xlk6BpfJ8w5Wm8w9E1NvqyexLlKkbaiwROZUIWojaX7Lwv3aQKbgzCLtJzrwjLyt
         SBzGNdeOkoq0vkD++kAwqDMq9VoJn20TH48PrRFlw8pHclWD9zQuyX5+IK1hAearPQPS
         ij+LPFcoNw4C1em435E1gQEVRt7iw02H7CS9M5YJHfH7v60sKyFDsv2hK5M5IKh4PUye
         JY2n6dPMG7nIf/jcoMej+xfvTH7oY1SR04G1rCMyjyiIxnt3z3fypIIeA2ShF1rQewpn
         LfZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2nYb62WXjlYoeStpqNeSMNCXPV5grysS8XZxupZOZGl6dCWf4G6YG6fm1uIKjheNn7j694DKMt3RwLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd4dDrQ9YnpU+R/MfL9adLhjs9AS1o1JOxkAUFYL8ywtaqRGJe
	esr2L4shSU/cfmscSJ+RqeXFVuYzcVdXhcPOm6GP339W34F0HlkMLw8R7er2Meu4uG+fbHXi2MR
	1
X-Gm-Gg: ASbGnctF8oP6Z/EgZ128qWUvuD+yX9bZ1NFKYcJvrIXADVuGiJZoVR1ks9twXvKj65z
	Na7nGZxm4l/wTRlWtlCyLbQ7FamR1f2nzONRNnxdhVE5AHBv3iMM9Sf2OccH1InClMPYS/d1Tkm
	eMIFRjMnIOQy9uI3CT2U+IOtUl9RDdiBDMRXbGO+VYv41rsc45g9G0TNyALyoUE/+YvLlwImE4o
	Fs8p63uFpyoByAYcAHnc4ffgcTzEkSrKTzTvBvqEsH+dVuB7+AgneitFrRm4B04DbDfp/QF3Qo7
	xgQO2ExPnD/yf7crQl7V4CkGKYK8B3Kj6dsDoPBNlXrNF95P5clYka9JqXzgFOpgDG1A/xAx8K+
	HD+PqC//ja4quMlU=
X-Google-Smtp-Source: AGHT+IHhLaPon9yGAlr+vvdISzeAeLbAmh8UYYNWjbtERsSGvsF20JUu0H7aaQVQFG458JsbhtpC6Q==
X-Received: by 2002:a17:902:eb81:b0:224:1781:a947 with SMTP id d9443c01a7336-226499280d0mr43847995ad.21.1742383454604;
        Wed, 19 Mar 2025 04:24:14 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6d5dsm111605955ad.153.2025.03.19.04.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:24:14 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Mark Harmstone <maharmstone@meta.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH 1/1] btrfs: ioctl: don't free iov when -EAGAIN in uring encoded read
Date: Wed, 19 Mar 2025 11:24:01 +0000
Message-ID: <20250319112401.22316-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a bug on encoded_read. In btrfs_uring_encoded_read(),
btrfs_encoded_read could return -EAGAIN when receiving requests concurrently.
And data->iov goes to out_free and it freed and return -EAGAIN. io-uring
subsystem would call it again and it doesn't reset data. And data->iov
freed and iov_iter reference it. iov_iter would be used in
btrfs_uring_read_finished() and could be raise memory bug.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 fs/btrfs/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c44e6ce6e5f5..b556db9e7cc4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4924,6 +4924,9 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 
 	ret = btrfs_encoded_read(&kiocb, &data->iter, &data->args, &cached_state,
 				 &disk_bytenr, &disk_io_size);
+
+	if (ret == -EAGAIN)
+		goto out_acct;
 	if (ret < 0 && ret != -EIOCBQUEUED)
 		goto out_free;
 
-- 
2.43.0


