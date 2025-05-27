Return-Path: <linux-btrfs+bounces-14258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F672AC5AAE
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 21:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A347188B886
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 May 2025 19:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9135028850A;
	Tue, 27 May 2025 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvUKRE/Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A30288509
	for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374132; cv=none; b=bhIklkLEpIB9MLI3y8fQApynumaXzNHqZtg+efsgf04vEbT56e2FahtLNEl3q2+RNaE7R09s1sNse+l2Xj9pqR16aSdJVoNMB+DOwMIf+n+tWea5gvJowiNHnwaqdiesCiN4yZTjHvB11456dHAvQc/84IFA8TjkEu+75yB88ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374132; c=relaxed/simple;
	bh=tH7yPNMQS50FkEEJpG1cvDY4SC0bEhHo8RBwmsGagXo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/JAeAqZSXMnSyH7AGlpacyrMD906Gk9chZMMxu/fnvv8FKpsGRo2m+o1vvzvadYa2XlGb5VwLLHBYtGQILAOrDs/aniuQ7RJzeKagHEV2LhyjHkqolHCuPaZmGQy7QCcB9TWYEzsx4WooC3hUO3dhnCtNOzNo/y7fcSBtFOzTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvUKRE/Q; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-72fffa03ac6so2040608a34.3
        for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748374130; x=1748978930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xusGegJM/5Vwsv4JOnG/eTr5fTBHPVPi2h54dd3o4yw=;
        b=EvUKRE/QCUtmFd5m1lY0CXgGYdCfg48WoXKBMxvh0+2+farsy5yhjk0/WHyHCi8SeS
         xCQgBfPe5XSk7GggNb7h1X6aTR3vUckk8/q6enru4oIVjxVjScr/4J6oZg8VOH5++CNm
         JyxA/Mo7BP/W0AQ7vGtLt5hD9lHEGlD9K4dYO7gCD1xCrVUQLBDqkEWqck/8LHvdECG9
         3IIN+vzGKSgj5Hu+zEp/kM5r9UEZstWV49wLl3urOB106vO5CQmli9Pr7HpaSBwjN+Bq
         FBPkZoPN1jghuIBGTfXpQM/SGLUFqkPQVSoc00ftgYIwPhKQo47NiI6c3RJYVAk+Pa1+
         pnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748374130; x=1748978930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xusGegJM/5Vwsv4JOnG/eTr5fTBHPVPi2h54dd3o4yw=;
        b=iKorhLaQTvUgFq+tJnppiwIySRRJSqdKfeBxktkprsPYhfNfiWXzaA72Otk0HJofNr
         bLMU7takAtlsRBsvLoWXcfdtH8+RyW8z3sBR5KR4dM6BTp8oZPUelihQKsUECsgWXFbS
         7ijNhW+rfE38Nm63pJ1Nz9NIRkt3Jowq1j7RhUiz9+JnRciaLdy+Pfja4PNBd4iM+p0M
         ExUVDf8z2cpTPXWCeXtoWdq5juftKIdOAkcaaO3YMZNOufI4lRGFJ8YmqQ1zRFkZhmSe
         Kn8bQ8eJ8en9O0ke5Y+lOaqtsbcPOqQs2eRvZfdURYEEDRhk0tKnss3GZBuimufT4YtN
         b7pw==
X-Gm-Message-State: AOJu0YzS/qKBMiSnhRjgKBLofrzNgTT7dBD8g9aJEkWodUjYeUuhNU1b
	gY6x99sYBSd8TX0L1Uqx8VV3jT6QAYE09u4tkkqheBfzshwj9MJmBx5qOobkeT6H
X-Gm-Gg: ASbGncuXgeMY6/9JH4pPl0mKgzOG3c8rnYeYqlDjF0pE53c2GwHIzq/L/LVB/tRODgG
	nos/0CThNELGm0Gptv6tONHWQSMMFdWS1Jox8tDlCfGj0lYn5HbM9W3SK6zlEkOSFihMymcGhPc
	rlFe9dyBcc8EKq3hLDxloYkBmxGf+Z5r+XH0BaAFnF9oUgO5BFBU5f+2/TAuhf2xGPJ5rBv9Rma
	Bj9MNAfyFcCTTXWUW1J6cw8bNgPF/ecxnT02XUgkd+AU/AU5bkBwUXc81GLhjUcGf24eRu8BH2h
	3vL0i6t/SZw6OU3I8iswbUHGZT8s4YbmdWUqQZ8N2P+YmAYwVe+qMR26hA==
X-Google-Smtp-Source: AGHT+IE9k6KQ3/TP2T1tMtwSh/95zwjR4lVy05Kj9wR1hABkffPq3bQfYFhXBbab3mJrqFI5f7t1PA==
X-Received: by 2002:a05:6830:3809:b0:732:ee7:d11d with SMTP id 46e09a7af769-7355cf37140mr10238338a34.12.1748374130179;
        Tue, 27 May 2025 12:28:50 -0700 (PDT)
Received: from localhost ([2a03:2880:11ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-734f6b3a9besm4479102a34.55.2025.05.27.12.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 12:28:49 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: warn if leaking delayed_nodes
Date: Tue, 27 May 2025 12:28:36 -0700
Message-ID: <023ae97cf64384f4187ff03d54f03830e904df39.1748373059.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748373059.git.loemra.dev@gmail.com>
References: <cover.1748373059.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a warning for leaked delayed_nodes when putting a root. We currently do this
for inodes, but not delayed_nodes.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/disk-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1beb9458f622..3def93016963 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1835,6 +1835,8 @@ void btrfs_put_root(struct btrfs_root *root)
 	if (refcount_dec_and_test(&root->refs)) {
 		if (WARN_ON(!xa_empty(&root->inodes)))
 			xa_destroy(&root->inodes);
+		if (WARN_ON(!xa_empty(&root->delayed_nodes)))
+			xa_destroy(&root->delayed_nodes);
 		WARN_ON(test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state));
 		if (root->anon_dev)
 			free_anon_bdev(root->anon_dev);
-- 
2.47.1


