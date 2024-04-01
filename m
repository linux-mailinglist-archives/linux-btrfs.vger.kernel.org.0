Return-Path: <linux-btrfs+bounces-3808-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3910B89395A
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 11:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C7E1F212DE
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 09:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E291078F;
	Mon,  1 Apr 2024 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnbhTGZf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B524EDDB6
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Apr 2024 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711963440; cv=none; b=mX28Ik30xcUdpx/K/aB/HBGH4g1xU19LVKoscPovVre9fD7gXubs4vAiWiTykwIYlbg3MHr37Ru/FXp+Ot32YMu4KFb7hVzabORIXJkRcOCAZ0+N2AeJcRlO4VEhswmD+crudhnGwHxyfhusi5rFLVcPxEc88MHJUjQzMjXp7Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711963440; c=relaxed/simple;
	bh=PjRWAg7uqoafUbiwghaMCrnh1rcFFFag+Z1GMCb0VYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vgp0yT3Nph7i0DXCCFY7wPi5sVPW35uWEubJnusJDLJvks1KoLC6MaWQ2L+dGvSkAA03gKmLKYtdc4OQgjYsPpWscnk1srNbqwz8Lna9MUM6RL4e+XrYN13jz3HiwFJgyi6LqbC7AJm5g6VJc1yvLd1gOqGyjV/tO6GKY4DOK2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnbhTGZf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0025ef1efso24472865ad.1
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Apr 2024 02:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711963437; x=1712568237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W7SAFIveKlhF3HwpynAW5nBu8/ha8CP2RpJFPzVGxYc=;
        b=EnbhTGZfxyhVXwy2s0/sylGnURdR6Y/YgpjIygY3fNlm2W1SvZPYKuNp1N6+uQLdgz
         bQjyervNr81ykPjquAvZx327HTL+NkS0QiZQb5c7apvQ9op+zQ43H0o40wILSTnXcCj5
         JrNGlCsRYqNxOvOleVay8u3GCaNdf8SbKVuSi4DyQXTpZ6kHc+5HYtyDGJLXqp3a8BN8
         Bp/mmTTPRyENYnikWu3nXu8/PeFG0jqBwm7CIZn7EvV1jQKx2+y/pLsWoaPZybOQ6/zU
         xDgPHjrBqNMkWdQp9ok0i+Gw17YS8si3TkS7pEe9XMmWLa9K5LpJDY5HYLnheRM683Xq
         3X4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711963437; x=1712568237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7SAFIveKlhF3HwpynAW5nBu8/ha8CP2RpJFPzVGxYc=;
        b=hobSYjsDOvaIqhJkgJo2yyuJ9Cr3tnMrCZ13YsGZX/Jb4GKuyQSh1brhl8K0RW/AGC
         hw3eakCLlX4/drZrWDm2F0bC/CGcxh8dylrBnZDf2ZscAVllevJpv+/FzcXLrZlRuUkO
         S/BePXgvEK04Y6vELtrFRv2q08AUNscWc/khWo/FrrTrTmGzaNkjvYcRxFsFPB1XObfv
         lcOItcaHD/LY0LvOsYLU0kJMCDDuMA/FPLzTK12hXV1XX2BmKLdtjiKIrxa2mbM+RL1a
         7jjcroHobRKXFUXvlTQw6ZDhCFCOHS6kkOIkheN4sz4Op7acYoAwoVBh3z89gpsR3QWO
         6R2Q==
X-Gm-Message-State: AOJu0YxGLIVBMGqtpigDg0cZMBRJv18l9v7DqOL8kLKLjHSWIm8jPtA/
	og8tEP1RkGEq2lb0DpDrC1B/p8MYARR/3cJFtFFJ+0OMSUC/ITCDFB2l+lsN
X-Google-Smtp-Source: AGHT+IEbI8q78FBojqJ1gBXeKhthYp7beJu2W47FADDIkGLJVlXDxVceecfvcpPkabAt2WaARB01tw==
X-Received: by 2002:a17:902:ce8c:b0:1e2:59d4:77e3 with SMTP id f12-20020a170902ce8c00b001e259d477e3mr1579019plg.11.1711963437010;
        Mon, 01 Apr 2024 02:23:57 -0700 (PDT)
Received: from dw-tp.in.ibm.com ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id kn4-20020a170903078400b001e25f4ce6dasm8444plb.95.2024.04.01.02.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 02:23:56 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.cz>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC] btrfs: Remove the experimental warning for sectorsize < pagesize
Date: Mon,  1 Apr 2024 14:53:46 +0530
Message-ID: <cc79c6ab354931b61a2dbd3900e253877b78913f.1711959592.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for sector size < pagesize in btrfs was added a while back
and btrfsprogs has been defaulted to 4k sector size by default.
This also means that btrfs has stabilized sectorsize < pagesize path,
so let's remove the experimental warning and make it a info message.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---

So, I see portability was one of the main reason for the switching default
sectorsize to 4k [1] and also sectorsize < pagesize is considered to be stable 
enough for the switch.

Given, that btrfsprogs v6.7 has already defaulted to 4k sectorsize, can we get
rid of this "experimental" warning msg causing confusion among people of 
whether their data is at risk? 

Or do we still consider this experimental and in what way?
Also do we have any unsupported btrfs features remaining with, 
sectorsize < pagesize ?

[1]: https://lore.kernel.org/linux-btrfs/20231116160235.2708131-1-neal@gompa.dev/

 fs/btrfs/disk-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index bececdd63b4d..e4eff84e1d83 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3350,8 +3350,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (sectorsize < PAGE_SIZE) {
 		struct btrfs_subpage_info *subpage_info;

-		btrfs_warn(fs_info,
-		"read-write for sector size %u with page size %lu is experimental",
+		btrfs_info(fs_info,
+		"read-write for sector size %u with page size %lu is being utilized",
 			   sectorsize, PAGE_SIZE);
 		subpage_info = kzalloc(sizeof(*subpage_info), GFP_KERNEL);
 		if (!subpage_info) {
--
2.39.2


