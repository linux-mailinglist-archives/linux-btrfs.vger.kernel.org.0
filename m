Return-Path: <linux-btrfs+bounces-14266-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFDAAC5DF6
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 02:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF8A9E4EAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 00:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCE7FBF6;
	Wed, 28 May 2025 00:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT7AYDPr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC62ED299
	for <linux-btrfs@vger.kernel.org>; Wed, 28 May 2025 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748390673; cv=none; b=eIb5ucBMYJ0gJLyrNjs5GBCfGRywmDOly0dD81kwl3/wFOmZqe/nZy+IPwG/esjS0yOn+WyDahM61NfO2wQXHjs+Ghl3Q49pBYPDU9WI1o4c46v8iz+ltFYNYY6rcVohd28F7Ug7ytPoEny2ZODhs2wF1ok27WXrbbEoour9qWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748390673; c=relaxed/simple;
	bh=ZcZlBQwCX9EiF+/4RA40zvfXJXVr734gt/ry/UJfYyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWMfBfdk1sAIyo6ytbH4sZaC+uoU9ke11XoeDiNQj4CVBc5uk5+LjIptsV4Ge98Squj38YlCe8OwHxZ8k1uCpM/+zNQ480TwUaXti2JtvThnaTOa3A7W4udL4MTgTwAeWh/IkI+mA1sN7Gw7kqdKQzzdeuiArKjRrvImWsoZLbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gT7AYDPr; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-72c09f8369cso1156920a34.3
        for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 17:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748390670; x=1748995470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zBgl+3plMzHj/d6bI6FCsSi8gzhnxhuua6t2MBv69Y=;
        b=gT7AYDPr1YMCPMuSwQIC7QinPYROmgJNihtp7qF8Yfp8tgNQCDGYzEBqGm3EKZRnVC
         EOq1unkCfu7tZ4cl7edNuXxOIHk11wf/1mb4HHu9lyCEeDkAzEV+BlIHkReyCM+O9Buo
         kjkjd2CWLLjYT0gVXuYN1pKQF1RjRkBM9p/YXPbDZ3msp9VG/iwf9AZQxdPXDSUIpFqE
         2dPmCs8sD6T+/CXaQ+R63kDdNvPlHMFg6mGJXWN6OI/K6u109YV8bWAekP/bCmu+FmAz
         qsYBPC9chZi9LZyqQm/k0oW6X4K+ZRpLQK9lmEW9jfdM7aMYOeHM6xGvyaojANIK2Fka
         EPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748390670; x=1748995470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zBgl+3plMzHj/d6bI6FCsSi8gzhnxhuua6t2MBv69Y=;
        b=Zfr3jV5rZ4uLl1a4XSFkFIlFzQnCQ8fnlc8uGJQHs4bxPyAnAsM6SD+wkb8xzXd8oU
         UzAjTQY92mBw1l0Kh86i4QgliLHUvKLbejEhvwqZiJgbuxV00BN3KnRKtnkNn4XY2Yag
         0M5ye/VvPkLSOgUCVV9Qw/VdzifDAGf9ZqcKLgzy+V+xph9JmfzKnCSh00Gq8BOLMGcw
         k3g4h9uM3xRV5PF0oJKywPXyQ0BmpLb6MdJg0Gbt155qnQgscFwOGA1XE+spaF80d2iI
         P8XS6y0R1hW7pd2maAgPeJIkC9KNNaK1n612o4zGPgH4SWmbuuP7cXNKyPHHiRE3NpDo
         bm4Q==
X-Gm-Message-State: AOJu0YxJFTrtEWoQm60yH/EJ0T+IXDKpIO7oGv7qA6dS8FP26pxnxaIX
	pPsWV2tSZpv3E/OjczPLghxxrHdeoZQa//o37rKXYrgihLmbHFgbs4d2cy6u+WUy
X-Gm-Gg: ASbGncs7T+2E9GWocINrxcorNFJYd1V+5omP1Mo3hUhQr0dPlcmQK/Mcg5oDPCFGirF
	1jTFINmhe433nJEtJQWGvckpZdIWLyMua0xE1Do4d+8Il9SCWVyO3ZoTAkMFdG2XW+sncwWMwsf
	MvUB6WnS0d8uqOTV/bxswvYPJtb/pigXsVzQTjGP4Gexi9c7aM8SJFe3rCf23+eE2FuTZWg8XYe
	vCNNlarCx5vDtdX+YsMnwd9p/qMuY9SjvTBFmm5wnxImzO7eooaBdx+zPdgAK50PQNb/oEh2fhy
	zyTSFOutS5pprN+EGrCk+5tTUe+2xVMjxsD7xICoH6b7kMU=
X-Google-Smtp-Source: AGHT+IGz1Uy1pWCV99pCOSJEShVRAOhCntchvqzq/Yzi688WTsIzpzwkZYAlCHhsMhgZ3WpexLaFwg==
X-Received: by 2002:a05:6830:2a17:b0:72a:1625:ef11 with SMTP id 46e09a7af769-7355d141407mr9620005a34.27.1748390670583;
        Tue, 27 May 2025 17:04:30 -0700 (PDT)
Received: from localhost ([2a03:2880:11ff:41::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-735a1bb8734sm9060a34.32.2025.05.27.17.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 17:04:30 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 2/2] btrfs: warn if leaking delayed_nodes
Date: Tue, 27 May 2025 17:04:22 -0700
Message-ID: <0e2f87577ae683c7771b82c14eb14b2a7772a75c.1748390110.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748390110.git.loemra.dev@gmail.com>
References: <cover.1748390110.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a warning for leaked delayed_nodes when putting a root. We currently do this
for inodes, but not delayed_nodes.

V2 CHANGES:
- no changes

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
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


