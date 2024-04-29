Return-Path: <linux-btrfs+bounces-4614-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 049558B59F5
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C7D1C215C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E50757E7;
	Mon, 29 Apr 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ATFcTBQV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833E975809
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397411; cv=none; b=FIfoI0JDwE3iw7nbHZ0dDFwkhU2BbCl0Yl1jh13/j3zfNOeEYUihUOasktYKvOf0RdeQBT9O+cxUFbqgYkyyrNQ+gk4Ec/tuFQ5566ZNpZzX6IzXLqnJmfHB96lDwMGtBCb1qPXsb8gPm2mV5eAexmDaDlQzvSknEaMlYMFtiBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397411; c=relaxed/simple;
	bh=N6k4QAy6YmgIzuBv3UbjkAqckRemx80XpARWAF3yddU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgDz6OVSBbyKuAvrgZBZnSo0bybx1mlJkIkjNqmItrX31S2W18GYBs+LZ9VTu42Y1IxnvYLG+IOGwI44vX+sLqjoxtdsjeAdMyhdsL9tG7ifKFkhq35cTVhfpFXncbIR1D+nKqFwnyE6VaXXYZtM3O1YH2BZBalQR1Ay2ilMi+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ATFcTBQV; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78ebc7e1586so567917185a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714397409; x=1715002209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4o4E/zlvhEvAwve3wuYe7HKWbPGiYm3aR3FSwzZ5Rb0=;
        b=ATFcTBQV6A+m6R3mUSW+Wc7A7SV1wVImdQy4+3mv1sHr7IQkg/EOrtQPVVDA1JKraa
         s0TF8pw8RtP45BIWItP4d9pT7KdacK4TelHHYMm9B2a0Or7flcWIaG+J781cbOD4I0g9
         pzUbOUSxgP/Q3gQopqqEWV0KA8+gH804L4MX+xtCy2bxgvP2pFZGSFJ1aQ5VbyQIUgqh
         +ndJ4h9FE79kbWNEiyULB0vcNpP3ZDuupQBxvv/nHpU9ouHC6oImwWJ3peWWIZ1dKXHV
         kKw/rlK7lZnpJqc2uUM8Qu3EYlBYp1Oz0XsK9p3gJ4qFS/usQw9ZtE024nIsI8yDtuI+
         e2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397409; x=1715002209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4o4E/zlvhEvAwve3wuYe7HKWbPGiYm3aR3FSwzZ5Rb0=;
        b=ox6E66B5RyHrOusdO/maZigPxFb9gyutDrazzrp94BIq2xpWU+9vJSF4wxphBs5t/v
         KUPfDnI1mFRSfuzQSqu9MjoKoFpDWuh7nRe7MAqYGiCZsKQn74PXb8coZj1JSKWwOkOY
         RiGbCZWk389dFME1mihKqBkq0HWAa4/uvym6boi23d8Lm0SF1nOZd3rMlUFt1fEPAcKy
         I7YR1a14NCOMWec62ibKAEJB+Pj38HgsKaj/UWBo6JmwaHtDGqY2GCWNyhXxCkFPEAij
         n38iu4nb1qqh4zGeW0Jld01edxfQOt8ZlDhW7m13KWLjA+hxfMZ0zw8bv9xzi6VlO/b8
         ZWCA==
X-Gm-Message-State: AOJu0Yxb30496tpCPmiNJGsKabYWwP2SqgaappPEFKyVsZhtLK7cXNHR
	HQ4dtVGkyLQ+2rKPTloAGYy2TTITx6GAoIv/Y2mGw+jSOQTM+3b6Tk/7lHy0CGgCrvjZN/2qTBP
	L
X-Google-Smtp-Source: AGHT+IFPByAiDudjt6/LJ7KAmcJ0eLctoR455NvIoTO+JmQF0IPNhWinQ5Et2iONokCdcauStfKv+w==
X-Received: by 2002:a0c:cd8e:0:b0:69d:b424:92e6 with SMTP id v14-20020a0ccd8e000000b0069db42492e6mr12551611qvm.14.1714397409256;
        Mon, 29 Apr 2024 06:30:09 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g2-20020a0cf082000000b0069c5d4b95d8sm10349406qvk.73.2024.04.29.06.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:30:09 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 11/15] btrfs: replace BUG_ON with ASSERT in walk_down_proc
Date: Mon, 29 Apr 2024 09:29:46 -0400
Message-ID: <507988a161d16ddceaaaf8d22a1556c181eb302c.1714397223.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714397222.git.josef@toxicpanda.com>
References: <cover.1714397222.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a couple of areas where we check to make sure the tree block is
locked before looking up or messing with references.  This is old code
so it has this as BUG_ON().  Convert this to ASSERT() for developers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0dc333331219..c75a5b3ddb8f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5392,7 +5392,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	if (wc->lookup_info &&
 	    ((wc->stage == DROP_REFERENCE && wc->refs[level] != 1) ||
 	     (wc->stage == UPDATE_BACKREF && !(wc->flags[level] & flag)))) {
-		BUG_ON(!path->locks[level]);
+		ASSERT(path->locks[level]);
 		ret = btrfs_lookup_extent_info(trans, fs_info,
 					       eb->start, level, 1,
 					       &wc->refs[level],
@@ -5416,7 +5416,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 
 	/* wc->stage == UPDATE_BACKREF */
 	if (!(wc->flags[level] & flag)) {
-		BUG_ON(!path->locks[level]);
+		ASSERT(path->locks[level]);
 		ret = btrfs_inc_ref(trans, root, eb, 1);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
-- 
2.43.0


