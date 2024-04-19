Return-Path: <linux-btrfs+bounces-4448-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D07C88AB4F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8622A1F21054
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0A413C3FF;
	Fri, 19 Apr 2024 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FkvnaW1m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC76813C9B7
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550649; cv=none; b=AdWBebi+bFWSyBOHV/d5VKNS/AZshEwpNOMkL3lxNR5tINRHML22o8Gx9dBsW8INzjOxKyLTbTvtnd1JlnDolIKkvN8p4qlia0xrL996FAY3vnTMvk7lAewNygRdcWwcgyi1wsU5WxwXz9pGOXIIQAzGuAuFHh1Sr2cGMtQ6e/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550649; c=relaxed/simple;
	bh=dWUwkeSD2ngjlmK64WCexJYjjB9mGk98X+KUg+2m8To=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEibqt62pjgkDixM203NSM5TYYKPzIwLviFjuPEpJFF9i9Usf0kM48haqXKH5PKpZvGPkVgLQVitGD7+ghLDO/BE0S28dUDLJ6gi19mc91qmnycgvryhdPJZxXciQKQ1STU5ZpV0+Zj6+WafhYvwBxCJiGSBGPhtqf40k7/9GOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=FkvnaW1m; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-69943ef42b2so14783896d6.3
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713550647; x=1714155447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ds4i5mh0AtvV6PFQ7dse4dofkPX0LJnTwJVG6mYTFq8=;
        b=FkvnaW1mOFNOuDUX1QmHvK7gmlO6Ot+z0jfjybSzbZDmYMNZm/0A46z2nlLSlA7nLr
         wqbb1LQHbZGGrFXTP2NKtiIZm0o/IT9XM7XLQOeN02e0H+C8V+hTLcoIvkDZMX4zsJCE
         EngGAP0ekNW5tMA2pDGR4zaJaGUQcw8or68VgFlo7kmzKNuZOxkKfdlCtsR6PvIpXPg7
         5Bl/fAB0bpPR6JnX7TMCQmBtWfDoeMlQ/H/otH+QaFjz4ZKyQ0em02a/fRE2DryaVK+S
         Cm5lH1qR2mMEK8nPT/HkIlnuRhXEw7SsKUYhP9vZMHtjVM6Nl1+htgOgpea9Wk0V/285
         eePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550647; x=1714155447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ds4i5mh0AtvV6PFQ7dse4dofkPX0LJnTwJVG6mYTFq8=;
        b=f77jdrAkcunsAzbsEWgsJQ63jJOzIHpQ21ek01ETMIsAf0U04x1U+MhhVNR3yVY/SN
         TWg11y6/XEqDbatMpMXv1PZESHtkhhTSIFX+4fM/XWqXDDlygcq/j0ezs0qfBiO6wSP3
         kDAD0CV7Pf4EBG4zySIWywQTr1W51KIw6jhxsnVNQUecTYIVatksVsrkw2NJkwLEX1Vv
         jgJ3W3xkyRyx+l/gXpNICMqbiXxqs4sclD0tg2xC0v9AdWjPTnVWaaWUZPmCXdgSQBkK
         71I/iN9HO89P0T7hLIqBcOo7/S/xYH8I/KZNmdPRsnUje0ZplN6dP2dyK6Sw8dvfq/6v
         5J3w==
X-Gm-Message-State: AOJu0YynKF9cqrpPRaZSYz/0J7CZfUVm/Cvw6Fz4NLImZIJOdO4DWitL
	OdSiCukgs6yVJLKmfz8fqA/10v1dOkY03q8F2v+Z46tlvyQ1voD19XtA13eU9nFSi5Z/3PMMDwY
	O
X-Google-Smtp-Source: AGHT+IGQNA9qkE7TtcDC8tUR1jBtNNIlxUfQMdeWJTU4fbZKSABfsuRvA0zdW+oIKCm4BBLR4qajXA==
X-Received: by 2002:ad4:510e:0:b0:6a0:59e6:a3ff with SMTP id g14-20020ad4510e000000b006a059e6a3ffmr3166985qvp.12.1713550646671;
        Fri, 19 Apr 2024 11:17:26 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u10-20020a0cdd0a000000b0069b60baec46sm1708302qvk.146.2024.04.19.11.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:17:26 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 10/15] btrfs: handle errors from ref mods during UPDATE_BACKREF
Date: Fri, 19 Apr 2024 14:17:05 -0400
Message-ID: <cd9c05c8108d66800d5f26626edb5ecbed8ee614.1713550368.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713550368.git.josef@toxicpanda.com>
References: <cover.1713550368.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have blanket BUG_ON(ret) after every one of these reference mod
attempts, which is just incorrect.  If we encounter any errors during
walk_down_tree() we will abort, so abort on any one of these failures.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 61bea83bce19..889e27911f0c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5419,11 +5419,20 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	if (!(wc->flags[level] & flag)) {
 		BUG_ON(!path->locks[level]);
 		ret = btrfs_inc_ref(trans, root, eb, 1);
-		BUG_ON(ret); /* -ENOMEM */
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 		ret = btrfs_dec_ref(trans, root, eb, 0);
-		BUG_ON(ret); /* -ENOMEM */
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 		ret = btrfs_set_disk_extent_flags(trans, eb, flag);
-		BUG_ON(ret); /* -ENOMEM */
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 		wc->flags[level] |= flag;
 	}
 
-- 
2.43.0


