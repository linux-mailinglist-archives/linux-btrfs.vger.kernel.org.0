Return-Path: <linux-btrfs+bounces-9600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 827DA9C7941
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 17:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A42F6B3DC36
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ADA7E792;
	Wed, 13 Nov 2024 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KCtzAYyw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958E7E0E8
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513922; cv=none; b=tUMau45BiAWhiIEmXZc0DklvkYgqJQCbcrDs9uJIPE+OPIgA8JvJ3jt1wr0f8oO4qOUKXGP5lybf0zsnkLuVVgFLpfH42WwHPxUcmZO7Fqm58mJ6MZrZyKHkny++RzDQkrFop1NRDPioEORCN60SRw8MB9DKRDH2guq8BfCibyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513922; c=relaxed/simple;
	bh=Na/grnMDZNedpgQeysiBdj5+/PYqTh2BndPQC5ZI/ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xxxa3cwSSGE23NlOYFHQiWiSyQjPlPCnj83oG78RAe0Z1VAc24Oy+i1ROGv6RfZjjFQ9Z1xHTx+41qmf0YDrYIQjuTFLmrZ40M+iB0TM/4O9zGdSkMlH2J9zMWbB3vzDidihpJM0Zt0GBXzR+owSNj9HUCJaq6JwTqnAmIgBumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KCtzAYyw; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ce3fc4e58bso40532356d6.0
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 08:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731513919; x=1732118719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vcFDogal5NryDPa48hgqdxJVj4yDxQkvbCrhPZCGTxk=;
        b=KCtzAYyw9Ve7WG6Rr23mWNWxNHubNRn5djB2eA3xLnAtzmAquL4is+s+Sa9E4FEjyh
         JnPYRYY7cpZ2XCU+/f+Xc756/cYT+x0ndtUfcXbXnemadCfX8eh9256INSKwSo1K+2VZ
         rXZoGUm5A7oXxf4Qsah61ZVaGRCvh/osMKcCUALnbrKios0Ln9vB8pSoekqKdHxUiDiA
         KN6T+szkn7G4WnldFUmJWG+DpKhJ1DRvdawB+Wi5V7pvWmKR8F3XnemDLgYsIB384uxH
         F5d9rNFXcJB/8DikCy7iicQvK/whMOqETMHtIc9IFrdR3YZ4SKVY/QixSocDtlRpiVU3
         NGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513919; x=1732118719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcFDogal5NryDPa48hgqdxJVj4yDxQkvbCrhPZCGTxk=;
        b=BOdR+i8gBxHcWT1o9+L28ymU1PTucIxp4kSpJzhFbfz+1a9OKBKeJUInieyVwUvv5p
         0GeuU2bFtczkDb7PADYPMlrGboXW4285ribyozLv+coKAnQ8Xw1tuSC7Xsi1fmNuT+Vr
         QnyHivIHC+PE7sTu+qb11DnhaIwzzwiYP7ucJ5r/1eHEKkOmSgovSD0J+iOsFTH+/G1i
         Qsg0MSim1+KZKAf91OXbfJB1RABUoFF/JEJ4Ik7Gu+xkiv+q5+YRtnJdBoN0ugRSj39s
         XuBToP6F3aVtK4a+z6o+FxUu50IDjAWdoKYKNagF4El7jDBAOkB7XfHxFmthoFUujHDh
         AOgg==
X-Gm-Message-State: AOJu0YwOGsv/iWDwdDs7UopkPv8DQhM/xCQKhsi/Vre4mjewQ9PnI7Pn
	NXdpNUcLwUB0VAUCZc22iOKRdzKi3MQgmtSEZltVKSapI8iNzmCzU8gM4/Ct0FQq7rlRvDY9yzD
	Z
X-Google-Smtp-Source: AGHT+IGpr3Pe7mhvy60jSiQoQxLE3e5pAsnbCLZr3nlAa4MV8tpy17afRGHY6BZ3hQO21VrAWk7p3A==
X-Received: by 2002:a05:6214:570f:b0:6d1:7438:7b94 with SMTP id 6a1803df08f44-6d3dd0813b5mr41710106d6.47.1731513918626;
        Wed, 13 Nov 2024 08:05:18 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961ecc7asm85440196d6.43.2024.11.13.08.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 08:05:17 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: stable@vger.kernel.org
Subject: [PATCH] btrfs: fix incorrect comparison for delayed refs
Date: Wed, 13 Nov 2024 11:05:13 -0500
Message-ID: <fc61fb63e534111f5837c204ec341c876637af69.1731513908.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When I reworked delayed ref comparison in cf4f04325b2b ("btrfs: move
->parent and ->ref_root into btrfs_delayed_ref_node"), I made a mistake
and returned -1 for the case where ref1->ref_root was > than
ref2->ref_root.  This is a subtle bug that can result in improper
delayed ref running order, which can result in transaction aborts.

cc: stable@vger.kernel.org
Fixes: cf4f04325b2b ("btrfs: move ->parent and ->ref_root into btrfs_delayed_ref_node")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 4d2ad5b66928..0d878dbbabba 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -299,7 +299,7 @@ static int comp_refs(struct btrfs_delayed_ref_node *ref1,
 		if (ref1->ref_root < ref2->ref_root)
 			return -1;
 		if (ref1->ref_root > ref2->ref_root)
-			return -1;
+			return 1;
 		if (ref1->type == BTRFS_EXTENT_DATA_REF_KEY)
 			ret = comp_data_refs(ref1, ref2);
 	}
-- 
2.43.0


