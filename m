Return-Path: <linux-btrfs+bounces-19277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEA3C7EEAA
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 04:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA073A56C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 03:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE83B28489B;
	Mon, 24 Nov 2025 03:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axz/F2it"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB9E280312
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 03:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763956429; cv=none; b=CefwDsC9Sbw5mV0etqtUGi21Bo0xNowVvpPUcj477Vra+m8PBZw/jmoWIsAItBnq0oyDeV9QBBzRoDioX4HTvkC6J7nsNi5+nQrEWu4QdSXCve10e4GC8CDPUc+KO3GGABLV+FGHD6G+FmCKdEj8rmJdOb99o1YT8NDAWBqs9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763956429; c=relaxed/simple;
	bh=vJfXb6qtRi2OR3kDeJrajCccGeXQkDBapmD51q2SxVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ca0IwzJg52N5hriP/khcL64lan4LJWKK99zQOV1+4M4XwQ+tG4hNjfZsH/6QbzDjvF82u+KBCWS/dIRa9qZBOgx6ETdAK6DFqL/5KbdnXSmsObOZCcT4fjVDw6Lka26Buo9ynV8GKbmO15cq2FpD+9eOdwVqcZscj/srm0SnlNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axz/F2it; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-297dfb8a52dso3092345ad.0
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Nov 2025 19:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763956426; x=1764561226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z6+ti4fyqalzGJljpxfUbg3OaiTUy55HXMBtf3iQN5I=;
        b=axz/F2itPb6OjOB/sTocL/NTNI9RFv4Ckj/2sY32yN4tC29HebTWz0qc0sL7GBcw62
         DwPjYX8xSuzUkCJV2u4bqsDGoSz+Ps3epC5d1WhQDTI/tw+8HGKBBl1W9P14Y2bFt/M2
         ewwVtZ9QeC3DsEPR8xGRVkZTAq50RFIYG459KnXj1dPyK99xd/yH0Ee7aLmbldhPi47d
         r0EXLKKrfVneYWQFqzTKw1cHPA80thDNrpTtxBYEzNyQZzxyNr8xD5zot0sQX4u5HoAi
         P2XzsasTOZm+vimmZ8K3bBrzXlOeXGmu9UmFKJpF3fTZrwHOxOkgasQUmcVKIwRvwjVV
         xloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763956426; x=1764561226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6+ti4fyqalzGJljpxfUbg3OaiTUy55HXMBtf3iQN5I=;
        b=P+3XDMHEeyo87mp5glwrZmABu6rm9gd1XzIfBlA/U7zuwNMaZt7lHkLJ/cyxZPt1n0
         4rdvuvVSFuBqRccVACqBSPcuVNlJe8N6vGC312Avn2b6qe7jyWkFtWuNKguVgY5Kl2ZH
         J6T638xnS4ifZtvs49XbU/ws8V1bQwShZ0ptnC+Oz+/5eNF3CDhuv0kRmNHvnzd55qei
         Vpkk66Znl0DN+Tb11JGpR1DiIRBVEWMt7S7XmYXWlKCXkvzNrMN1yyThi/LAZhXt0ZdS
         YWJuR3NURh9Ckper0rJOfVn7j13+gilM3ANzLZJsWGEReWqNA7jl34bEsQ/wVmENXent
         bjXQ==
X-Gm-Message-State: AOJu0YwYYx6Bjt98jMuTcrzLrQW8SOOyeYj5gHYDPbCcFfe8z2iTXzm9
	Kx8DQGXPGwmMMK5YXaRLQy/gBGs5106pNUShNihS7VjcO1EJ7aSNu6sS8VsG7jmKiXc5Og==
X-Gm-Gg: ASbGncvd3OMNbIcDQ5XCcTEwVFlba2ERG1X2sZdo2obCJwRHJIjjekSFaVl5w2JkTJf
	ZZok+g/qe+oJtMd+Va4MzKVasm7bwuNhj0bjy44Max+BGowPqK154f6AF/fDSBzfeS5sSWhagWw
	yKl7K2cb72c2qw4gHHvk3TEjHZGMF4PPf79x3GZA1RZahwBwjWFP0w8gbAcN31Pp0Ktg1UxxunT
	9yI3e2Q8xljf3augIkNEKrPIvVhn+MlrYpicAhdiJX55w11Te/3RDUCuPa35IgrgRrvqKi/IEjA
	s6iHwc3LPg+MI/9DV0KuW44C9HOlCNxRSS2LRLhVK0tsDRWl7jRg4IonRcRFuYNWtU0SEWKFmIA
	XKTo5uDqtFxFVeoJ+a/6T2pVJIgx2ka9TaxID8IUi5RyollJjbrkx8RTNAohXFUZpkhXWWy3Gta
	g2tyTIkUSLUJgu28b7c30WjQ8/hnPJcQ4=
X-Google-Smtp-Source: AGHT+IF7Zy4eEbIMPxJuEzTrPVG2YXP2BW4MnPFLnYCz3z2gSBY54uUa5n8XCdeaIhNG6tm+xpwSvA==
X-Received: by 2002:a17:902:f78d:b0:297:e604:598 with SMTP id d9443c01a7336-29b7022ca54mr59680585ad.4.1763956425678;
        Sun, 23 Nov 2025 19:53:45 -0800 (PST)
Received: from SaltyKitkat ([45.144.167.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25dee4sm121145715ad.61.2025.11.23.19.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 19:53:45 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH] btrfs: update comment for visit_node_for_delete()
Date: Mon, 24 Nov 2025 11:53:05 +0800
Message-ID: <20251124035328.12253-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the obsolete @refs parameter from the comment so the argument list
matches the current function signature after commit f8c4d59de23c9
("btrfs: drop unused parameter refs from visit_node_for_delete()").

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/extent-tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5e045eab9df7..8119d89f8659 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5274,7 +5274,6 @@ struct walk_control {
  * @root:	the root we are currently deleting
  * @wc:		the walk control for this deletion
  * @eb:		the parent eb that we're currently visiting
- * @refs:	the number of refs for wc->level - 1
  * @flags:	the flags for wc->level - 1
  * @slot:	the slot in the eb that we're currently checking
  *
-- 
2.51.2


