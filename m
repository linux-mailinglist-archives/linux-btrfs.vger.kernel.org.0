Return-Path: <linux-btrfs+bounces-7698-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E73A966A67
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 22:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28F91C22353
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 20:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B689C1BF7E1;
	Fri, 30 Aug 2024 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOnGB24c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0F0EEC3
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049531; cv=none; b=KyrZ1WK+i+h5jocZjaCTjLixX+PfcyBMx2NKajLjFgK6KqAMs8bBI0g+YSp/iEruuEfOBl23QhUyB/UjRfVDkXXPPAr+DZwE2XKfRBsN1AOd8vAmeLhOa2rnZyXZzhOfE0Osy9RkwOSgA6pu+rhG12YtftK5T0yHB28WRmSD/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049531; c=relaxed/simple;
	bh=T7xvmciFAoaT7S+jUHCPAiOSTqvDDC0bhZ+S9vKmENI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gN2yFVYEaAjy8ZwyX+sQV6f9w+NQTrG7pFg97cQ4KhQGsYV8TcY+pE9EzCjeAuCfc3O2Jo+6nv8jN2kdm+b/fvLjwdEH9NlUkKu40Z26SAG4Uq2KJecPEyhwCf07U2kT9KSX0J60nBQ4JkSgQnYEmYRciP0iEZdoTGQ9Qx5tnco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOnGB24c; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-70f6a7c4dcdso566526a34.1
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725049529; x=1725654329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qUBTX9FFgJ/8xqgu8kBEkYyF5Pd3SY38Y6MXNs7gMkw=;
        b=DOnGB24cTr+i5S0qnwEMgWe546/tyvhZGp7CyZu/KyDA7az2aGCg5lOC6GxI4wBEze
         sq7dZS7TU6qNLCJp8rinJZR8LZcicZC9PK5gAQ5uvSfMJ1QGVS88CIbTrjrAVM2MbXAl
         nktV7iXO27ILGsM+TEA0CG9vf6IovPpVDBymooY8MFYf8JUtJWyPIHl5ak0SYIo0Ouei
         BbWfrHKVj0qZhbQw1MHUqFccyHzh4jynvtP5vFmWLFqtMA5CLbnc2nRMQYdncM3qD7fZ
         hVbG/dsKwnU554gV/LXf4zfazkSUxWxb3dUIWfJVkwYdXE/bCiBP/2PFr09tovwwgiFa
         Dj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725049529; x=1725654329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUBTX9FFgJ/8xqgu8kBEkYyF5Pd3SY38Y6MXNs7gMkw=;
        b=msX7Uw7bL2CjRx1r8wK5eUJz3BmbF7fHQYedr8yPPk/7wcZ6K82c3MK9R8LSOadMJD
         mkzOnzq/w2HWoitFqvFYVHgqVYGmpMFLPQx3RRguh9vIpEaRZJPEqDF65lAceKEtDSje
         JNW+XXObX5Bw3WV3nNtn/b/v5P9uFJewvyMbHYEUl1h4ARhGaOtdUU4+uUV+ruESGEBT
         Mh1OoTDhBAEsTDWxSavyqIpS6X5/rnoZ3rJmbHPsSJDVSNo99LEnjex60TrdS8pAF+IF
         DvLwz9ryafSBST+V0V4MNN+Oa5zFJ4UTm2IBXiwljZJDboplMlDb+MXg/UrmxhQ1325X
         y5Aw==
X-Gm-Message-State: AOJu0YztpkVcKNHbVNZXNV/ckWeIn8tIrgqa2mdoXK20Ow2N2KHjjDjD
	v5TeOunSxQBadSuI8clJB+tMZHrC8w43OVwwZNhPDzEfBtROmUszZ092ZeFr
X-Google-Smtp-Source: AGHT+IFFz3GHhKR6uao81ihC9NVkLXbjOGgGME8sBfaUtyJKQ14qGl9cREMxqmCksXvTvUN6dvf0+g==
X-Received: by 2002:a05:6830:6110:b0:709:42dc:a024 with SMTP id 46e09a7af769-70f5c38f52fmr8773798a34.15.1725049529325;
        Fri, 30 Aug 2024 13:25:29 -0700 (PDT)
Received: from localhost (fwdproxy-eag-006.fbsv.net. [2a03:2880:3ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f67143118sm622640a34.1.2024.08.30.13.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 13:25:28 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v4 0/2] btrfs: iget_path cleanup
Date: Fri, 30 Aug 2024 13:24:53 -0700
Message-ID: <cover.1724970046.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates from v3:
Previously I allocated a path in btrfs_iget and called btrfs_iget_path
with it. However, Josef pointed out that there is a case in
btrfs_iget_path where the inode was found in cache and no path
allocation was necessary. In this patch series I no longer call
btrfs_iget_path from btrfs_iget, instead I duplicated the code from
btrfs_iget_path with a path allocation.

This patch series is a cleanup of btrfs_iget_path and btrfs_iget. It
moves some cleanup and error handling from btrfs_iget_path into
read_locked_inode. In addition it also removes a conditional path
allocation that occurs in read_locked_inode, instead reworking
btrfs_iget to allocate and free the path.

Leo Martins (2):
  btrfs: push btrfs_iget_path cleanup into btrfs_read_locked_inode
  btrfs:

 fs/btrfs/inode.c | 143 +++++++++++++++++++++++++++--------------------
 1 file changed, 81 insertions(+), 62 deletions(-)

-- 
2.43.5


