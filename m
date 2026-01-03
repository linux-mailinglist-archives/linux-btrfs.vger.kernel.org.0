Return-Path: <linux-btrfs+bounces-20088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C446CEFF4C
	for <lists+linux-btrfs@lfdr.de>; Sat, 03 Jan 2026 14:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A99C130319AF
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Jan 2026 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8A82FDC40;
	Sat,  3 Jan 2026 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXwGiLWb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300015A86D
	for <linux-btrfs@vger.kernel.org>; Sat,  3 Jan 2026 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445600; cv=none; b=K7woiIh6sXkfnTOT04hxxGEwz6rTacP0QvRZBm40evPNcvmJz5gKZVs4p/UQvAf//4nyRsmCwOg1NauLr1/7Y/EWQBuDx+CCZiEQi+yWLmKx8v2lhE7EDn5kg195eAtMDfCo4vJe0RkqR//pKjYKxlcVOy7wv28C7N0t9uk0Uls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445600; c=relaxed/simple;
	bh=gZGGU6totVBpRa3wnChWnte8xddWj2ZjcTVVO4chvjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzYyxbX4M5nM6TQzq3t8gaPithCL5pBaDIcju/nELIMu+gQ8Cbe+qXDBlb3mEkdaJM8HAhGnRoLGgLquveuSPfcDfV/sz6+QOuKyHsinmvekuMbDvTyy/QNwMYu/NX5B6hMkkaqgRLpZIMWbQyo4isW6PV0Ew1rkA6lFLqhYNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXwGiLWb; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-6469e4b0ff6so732979d50.2
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Jan 2026 05:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767445598; x=1768050398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ks8I25rnKslHH04fY1M+ZXq1nHXAjo8NHScaa3ywaOs=;
        b=HXwGiLWbKAvIBvg4lKBvDlkvrcNO24MjiipcoC7DFc/BwYEYvw+29x0Kis35Z4t/Q3
         /+OpZCB96TVmdqlIIG2du41RIlAFJa8P5OMY95DF5bEvsjFa+jcEomDcLkIBCqT08EfI
         LFqua5n01VFjICGop/eGHWrVsH61Zp5b9SMTKpsnCS4Znhjh/mkE04mkaOra/oD5BdtF
         gUpfSsT46PPR+9VDtuSqtkDX8u1/Zt6qWn3Pr4fLNKRgTh8f2s7qNWPdEvv3mBVy3R50
         2ldM8A/LH/juMqFmNS4IVwJt8nX69P/rNdGdLcn/AK8nmjcRXqQ6r1wv1uiuj7A1MHk/
         iYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767445598; x=1768050398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ks8I25rnKslHH04fY1M+ZXq1nHXAjo8NHScaa3ywaOs=;
        b=CeK/7ONp9cpBeXagerTXlPa8ZcmkO2C6LPLmJJVB7Noftg8zxKsBQQWUepi84t27LN
         6sRSJKj6Fq2qTB+Xis6+SMaQAVz6bPpdciU8OIyUTawjNbSBwsHPUnG8IeLT4mzjasG4
         Y8ZNO0M0CXYFjvNvI6eWJYD2BoAxtXPLcp1t5iHLZZ5uOwCu8+raQjYQwEo2TbR+skHc
         QFcz9c4w1kO8I3VDVvyiq5ne404PuZZHg3n/MhAkihvnwXR3oQ7eO0GKwFCTs0dADcqi
         Dv5BkbYXOFDHiasXureCJjRGR+K3yiNBN7OZUdIAAXayEJ/G9RkdEJpNSVnAhW1lnIHM
         rRaw==
X-Gm-Message-State: AOJu0Yw9NYuHRAVYHSu1TRf4JBukBSVzUeEXVpS3zGcGI+vA1+0YWUd5
	2Kp9WyGk9dk7EawqYBHQKtIlYmEGEbFzce6y75opoT1WSLzVu7oLybyTOuwJNJtD1Nz/vA==
X-Gm-Gg: AY/fxX7gSjyY+Heknk/1uwPx6lI7fj4bSwNyN3e4PBhu3T5uTwswUoI1t5YBcwAbvua
	5yfVkG9w5vERNmWH6VIc78BWQwsAneqtIi3+9gTlnReiHAz6n5w8oPVq5r4pm8m1hO8+8bX24GH
	KcAy62ukqrarLicPMTSMxYnmQ0Tp9BPq2kMzxnKbVK+iK0A95zflFVMk0OLzJNGp/JCjglA2wVa
	SJzvA0zucUWPYujxZhsuGz9VFerbLBunqC3nk1DN8YtVxwC0mLrys0dcidTaLrVz5w5OYw3JFqv
	myFvaGyib1w4J4yCIF6dafVKay+y2XxLc6Jjwp1cRfT9U4hQMJCXKYM91fUItlUuKBPE81Xynez
	c/g4n4hE5D1hp8s+DR2xXvHCk22nTe1bkh75PYWjZyGauVXI+oqZREeaUnufkEhVrwO8JV9CRYA
	rxcAVYpSFlwEVKo4JC594=
X-Google-Smtp-Source: AGHT+IFemYzFlE5Ti3n/XvmH9QkLhib+Iik9PumBMxytoJ3i3PQaY886Dbc3jSxpfhO+erHyRJuYmg==
X-Received: by 2002:a05:690e:4009:b0:63f:b410:e8d with SMTP id 956f58d0204a3-6466a8f5d8fmr27867287d50.6.1767445598001;
        Sat, 03 Jan 2026 05:06:38 -0800 (PST)
Received: from SaltyKitkat ([193.123.86.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ffebd2690sm112554957b3.15.2026.01.03.05.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 05:06:37 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 3/7] btrfs: clarify reclaim sweep control flow
Date: Sat,  3 Jan 2026 20:19:50 +0800
Message-ID: <20260103122504.10924-5-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260103122504.10924-2-sunk67188@gmail.com>
References: <20260103122504.10924-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the try_again flag with will_reclaim and adjust the
to better reflect the intent of the logic. This makes the reclaim
decision easier to follow without changing behavior.

Also prepare for the next patch.

No functional change.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/space-info.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 29dffbd9aadd..3ccb365549ff 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -2083,7 +2083,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
 {
 	struct btrfs_block_group *bg;
 	int thresh_pct;
-	bool try_again = true;
+	bool will_reclaim = false;
 	bool urgent;
 
 	spin_lock(&space_info->lock);
@@ -2101,7 +2101,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
 		spin_lock(&bg->lock);
 		thresh = mult_perc(bg->length, thresh_pct);
 		if (bg->used < thresh && bg->reclaim_mark) {
-			try_again = false;
+			will_reclaim = true;
 			reclaim = true;
 		}
 		bg->reclaim_mark++;
@@ -2118,7 +2118,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
 	 * If we have any staler groups, we don't touch the fresher ones, but if we
 	 * really need a block group, do take a fresh one.
 	 */
-	if (try_again && urgent) {
+	if (!will_reclaim && urgent) {
 		urgent = false;
 		goto again;
 	}
@@ -2129,7 +2129,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
 	 * Temporary pause periodic reclaim until reclaim make some progress.
 	 * This can prevent periodic reclaim keep happening but make no progress.
 	 */
-	if (!try_again) {
+	if (will_reclaim) {
 		spin_lock(&space_info->lock);
 		btrfs_pause_periodic_reclaim(space_info);
 		spin_unlock(&space_info->lock);
-- 
2.51.2


