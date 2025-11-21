Return-Path: <linux-btrfs+bounces-19248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D34D6C7A6E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 16:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C50D6386C45
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 15:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98040350A0B;
	Fri, 21 Nov 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="OXmo0B46"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E284834F487
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763737176; cv=none; b=ATQUczDsSfizU8e9XPS0uffoJNtyk1QO1GQubl87TbYAiRLialLzrk01f2yHdKGpkYo0UdSq/tjES5mSk4ManqkBo6jYWcFRwSB2avBwtpDBhqQdVtQWaa41EfRO8OF9Q7wxLyDXYSVTKBc6CSaYTKKH2/XtA0/Gt8g/dh2MtpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763737176; c=relaxed/simple;
	bh=ajsBWU2IzUadh0vAEphs0j80/wZHSdlM/Lguu5OfOTo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnBClvX1gBI6GBTq31CqUdAtsDi5X3orI28Frj4NefWomF5SJqFePz0Fv6s2pOX+Plz0OjEzpttoT+pqua+sN6KeD4eIuYvX4xKhod5n1IakXYDLabXsPMKbqCCQW6WkLPNs5p3DOHg7ZYZQbcWjz0kc/d2gF9i3CwOlexYioCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=OXmo0B46; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b3016c311bso253287085a.1
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 06:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1763737173; x=1764341973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uo/3a+N9FgZngrUGo0qp/jW5L7tgGqa+G1BsKok1mgo=;
        b=OXmo0B46y7vnEyS9gak8HutcqcyNOWq8KpbmIFQk+LhC2MVUbixw/Xq1MS+5DEVh29
         xOROmPURcPoFY6xy076Df41sTe1HZcyMeERtQbXQh4CBLrqOKi312u9Alyvp0jeMWJV1
         4xixj0s6Lu2zrK58UPKcyA0F9GMAr2LxwMVk4D9/cIax6mCNaLKHouJmv8NpEzUvwL49
         p0lMJhm8dKmvz1cW6+qZuA8lNdJTohCAH9RPLIL7wHM994yk87rMU//OWs6HAjTHXyoP
         FSs5P9NEHI7tX8v79ZtzJTDovzMohERBENuzBjfAzeeqTCB0pvXGd34XBtXm6cL9i4aR
         nzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763737173; x=1764341973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uo/3a+N9FgZngrUGo0qp/jW5L7tgGqa+G1BsKok1mgo=;
        b=rKdYdYfyTIvSOb2M0t0onAcFS7MtBBMiEDYfb7Orw64Zg/gQ2dFb9JKgLEVc1AiPHU
         SBWNpPv33mSkkTppi5fIKabmy3K+j9Nq19D+Nk6pbopO4epXI2bYfyaLMwaJEeFoHPQj
         NG06wTor8nHTwnEyPH2Vd/DSXfivauVbri4gLpMAEewjTKF1Yyg2CZ1Z753KeA6PyEF7
         niUFzMsmrQRThxZVpL5QX2xMLXbti+fwHS01+yALAF2SUWqbhuNZT4CklGeARxXsjsP3
         HbqhbT/+rbuMDMftYHe7aXpmHS1RGY6gflGmuF+C/Sd9vARMJH5HGEiWLSRxGoeghW6u
         Ir9Q==
X-Gm-Message-State: AOJu0Yzj4XxGJpxnAxK9ul1Foxd6JdzEqeYpoA/FDfCXu3h/2+Ha3WC4
	PtTK0kvaJH8eU+GfC5T9pfTtbhJpxMl4M3F8ecLZb4Yq693TitRRphSr2So+mZLYYPYbzjF9C2U
	hTfcOyrDyWA==
X-Gm-Gg: ASbGncuUjyG29LVr6FfYWNNZ/KrpCuSU7AewEGrJgouooT/J0hHJ/wBMh+M0VIkDreK
	RANQ/txDP1FqllhHtVSREj4smh3XRSNJw0m07fI17DbpKHpZ3aMvZkNHtyrMux7KqcPbGxkDyyo
	YGoAnQG/gO1/iNhzSi+R6IXqRmnAHUBOlyM9c0/TvbhdiKsjQiGRA8sUDPewUd8AR66T9ASgd6R
	4UYoUUt/pureTFKHww8V0vkEgRf/wSQm56kSzLvYQyy7LOb7+evszj3U+HkaDMxbdKxq/5KK7j0
	ciNItV920nR6gUF2G998qeVRionFKLjA1/u8IgiyyILyl4yh5ctdsayM8QhtU8534iF8mpZron6
	feiw785Z+zqNnEWt4rK7GuJQbrVeYDzs7HtnRXgV23wYpOMJ2o3Y1tl1vCQVYo8EDynx2ihkPIW
	fxCnKD1PF1yQUi55mYACctAqE=
X-Google-Smtp-Source: AGHT+IEwGAD2bbPdUgtFmGhSVQ6lufMq/Y/++OVuOHvZP5SEVOyEQrLLOtxiGDTk5atQZcKsytx7ng==
X-Received: by 2002:a05:620a:2902:b0:8b1:1585:2252 with SMTP id af79cd13be357-8b33d203af5mr296445985a.1.1763737173351;
        Fri, 21 Nov 2025 06:59:33 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:f528:9f2f:44c:2c84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295f2f6dsm379887185a.54.2025.11.21.06.59.32
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:59:32 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: remove useless smp_mb in start_transaction
Date: Fri, 21 Nov 2025 09:59:22 -0500
Message-ID: <47165cb8ed8a4a576e83a0ab13813ebe2de808bf.1763736921.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1763736921.git.josef@toxicpanda.com>
References: <cover.1763736921.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trans->state is protected by a spin_lock() and there's no mb when we set
it, simply the spin_unlock(). The correct pairing with that is
smp_load_acquire(), so replace the smp_mb with the appropriate helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 863e145a3c26..be2f1b88a0c1 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -737,8 +737,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	INIT_LIST_HEAD(&h->new_bgs);
 	btrfs_init_metadata_block_rsv(fs_info, &h->delayed_rsv, BTRFS_BLOCK_RSV_DELOPS);
 
-	smp_mb();
-	if (cur_trans->state >= TRANS_STATE_COMMIT_START &&
+	if (smp_load_acquire(&cur_trans->state) >= TRANS_STATE_COMMIT_START &&
 	    may_wait_transaction(fs_info, type)) {
 		current->journal_info = h;
 		btrfs_commit_transaction(h);
-- 
2.51.1


