Return-Path: <linux-btrfs+bounces-14613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB6CAD646D
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 02:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8D617458F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 00:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F47E11CA9;
	Thu, 12 Jun 2025 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M6wzEEnA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7121EB3D
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749687776; cv=none; b=i0FYpIbxRmG1NTWDNKjAsWXVElxaupDzOlpgvgN1Wt7UNoWh+KuHCVuyxgCJrzc0WPamx/DwCirlQs3SyMqpZgyzKcjUQ+p+RBK1QHwmYzWqBv7Q1PmJ1jbpDXI1zYc1FT+O2SMONY56HN7uj7LUV4/ZHCIRzY/PMP7ZsZtujXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749687776; c=relaxed/simple;
	bh=R0lHJUgl9IdY0ThEkJpsSaRIKBC11mHpH7tPgAJJitw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ud/dofhtE+eXNylsUer4xI8NImM/4tdQ06F0lUPJFSxBGud7V4YV0Rl4LsXcsfjwNGu9HjcSi23ypNM0XzSwIkS1RLu4EkO18ZsJ+dXFUtI0BNsuKLwoLjrSC34E1IM9YNpqFJglKjieog0gr2N/7k/z3IjUhZbLIHnFZhn9WDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M6wzEEnA; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso1897395e9.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 17:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749687771; x=1750292571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y1ZCi6QOzzN/4qT4qcIY6G+WRRBr2/w4jmlKG9lb/Lw=;
        b=M6wzEEnAUwjwIWCMbBs5lz2FWSQLFCt/8bLZpBldQ8+nl5isbJX0+3gK9/dY9hACde
         9n3qFhOAwR7tavr1WW5oZN6UtJ/hEznBwTpLX2nXW5wsuVEK0V06ej000ZTxGKCTw5pl
         YaJP+G3FKTYk+ToSRuMaW7D76C7fEOJul/D6DL+kkAIAldd0L93cUlRdlvM6mSIgagU5
         /1nYntVlyHry+O5SI9LcjOtuOGiKaUWiVx8hUv0pbCS9JMq9t32gXcG0BXryD8XD/RY9
         FpHjwI1t9bSDQ1wCHJtdFDmFrToXvd06+aZ4Wb0Os0+pzyGTg3tcuPjiokMuRyXygLRA
         gdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749687771; x=1750292571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1ZCi6QOzzN/4qT4qcIY6G+WRRBr2/w4jmlKG9lb/Lw=;
        b=mc5FSkBPFWypNwU4HQDOF+lrRekK+wAHFcubY2Q3CN+5zW7MdkY88Uw6rWmASRHT9C
         ce5zzaK/O1lkdUN/c7d04ZLjhi3wYd5OA2jDizocWdPVMiWYeQo2vgrIOKo5UT3//MlJ
         9mwJogKAsj97pR0JneEoTohFy242KttHSVAAExvWFXgZ9eJj5/oHyoPuLtAO7U1kfREs
         2DnHmiypTel4nFCxORsj4joKFc4pxIqmEeFKX2Wcpgk5zlfO0zeGAmct+Pdsfd98RG77
         B0VmfBzAcysogL7f0mPvgiJwB9BKwpSbqb4gXLxWbgl5nK53/rT9MNtkiIkyWCIi13nI
         8+7A==
X-Gm-Message-State: AOJu0YyLMfKdeVNWzWfK3bpyYtipwvo7pIsn4NR87wFtUVVDIV6ZeyBG
	Wfjarl2h6wFUj1LTvd6a/tpEVO8EgrzZdReEJAjVRIWJcqMG4P4UuxQlrpDAO6gxKZNAeGpTVeE
	ZP8agf1+a3w==
X-Gm-Gg: ASbGncv8J8CHr7j+BU6pobUKNEZZ8hKZsmKdsEfK64w1q9U8jP+EBiJuqwQrZb2QUWC
	y/RLMn++BSmbOCQZ8Vmi3EPRQ7DP6/ml0ms8SCE4vqAWVYluHTatcJ5e0KF77huGSELbUMiXo3B
	m3DZ7HfRuunVSidy2yVD2T2FDzDtC77LptiKsGda9+Vj3zs1zxGJURUpWUkAVRZBBqxTxQChJVi
	DVwvXJWqA9pbahZb/60/J0TIHnaRLFzy0hR0CN0dRGjD7KnYlbtX0d4LiTGrZfILjtp6TQ9BxfC
	SsKOEFKgF55ptz0pqXQc0LtynDy2dmqxkaJrXYC2pQLZVVgnaXfwBJy9fUkFVgoU2HxnlI9Fum5
	wGXTsEUUMWDNsGIbF9eovNq2hPg==
X-Google-Smtp-Source: AGHT+IHbfUNwiHrBTIwaUj+IdVgLCgNeNaJ/RLu5SArQrhlGHfUM1cAmzrFmG8rfBQBOxvvml7tvTg==
X-Received: by 2002:a05:600c:3f07:b0:450:d00d:588b with SMTP id 5b1f17b1804b1-4532b8ae1eemr17117155e9.9.1749687770962;
        Wed, 11 Jun 2025 17:22:50 -0700 (PDT)
Received: from daedalus.nue.suse.com (115.39.160.45.gramnet.com.br. [45.160.39.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a561b65c2fsm408042f8f.98.2025.06.11.17.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 17:22:50 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: wqu@suse.com,
	dsterba@suse.com,
	anand.jain@oracle.com,
	Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs-progs: restore: Remove stale debug message
Date: Wed, 11 Jun 2025 21:22:44 -0300
Message-ID: <20250612002244.381346-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The message was introduced on 502d2872
("btrfs-progs: restore: add global verbose option"), and it was never
changed. The debug message shows the offset of one  EXTENT_DATA from
the file being restore, but it's only shown when it's not zero.

This field is non zero when the extent was first snapshoted (or a
subvolume was created), and later changed partially, so the extent was
split in the part that remained the same and the one that changed.

It's not useful to have this message being printed without proper
context to the end user. The message itself isn't very useful in
debugging sessions, since it would be necessary more data about a
problematic file/extent. And given that the message is here for
more than 5 years being unnecessary printed, it's better to remove it
since it can annoy the users.

If a problem appears at this point in the code, a more appropriate debug
code could be introduced instead.

Link: https://github.com/kdave/btrfs-progs/issues/920
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 cmds/restore.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/cmds/restore.c b/cmds/restore.c
index 6bc619b3..464a7079 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -391,8 +391,6 @@ static int copy_one_extent(struct btrfs_root *root, int fd,
 		size_left -= offset;
 	}
 
-	pr_verbose(offset ? 1 : 0, "offset is %llu\n", offset);
-
 	inbuf = malloc(size_left);
 	if (!inbuf) {
 		error_msg(ERROR_MSG_MEMORY, NULL);
-- 
2.49.0


