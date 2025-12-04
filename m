Return-Path: <linux-btrfs+bounces-19531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F1CCA56F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 22:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 980ED3178E18
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 21:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A62B32B9A0;
	Thu,  4 Dec 2025 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fm6embI1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C3932ABFD
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764882661; cv=none; b=dHBACUuVrmswLiQT+5rBVPkaEGmaTVNKlmD60Her7T24go8ibLV+q+oM2PtfDtzkp1ST/PnGzXodTLDrJSUnEH6lq28YMQZqkdl9zN/YpuplgEzCmprH3orTRXLoSrCBRKGloYRRq9xIIzb2vCpr8dFcVOflISMg/fAyZWK8AQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764882661; c=relaxed/simple;
	bh=w3fsxewpQDLfXHQ4U2m1BD9H/RVSNts68FOUpu4tU7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+ZFQjKAZMpZgaxw/l8uu3gVU3m1y4Eo7eE9o8D0HO8XTx05kzk0zfkGIvKpqUee5qgxDV6+MKs9rBXNoi0dlynWuRNJxSUwf2KJimfm8Fu/G0ySCDpFfWF50btp/TYcIfg3RCjLFey78yB8XbcQL3kVE6dXBY2eEIxI27IHqIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fm6embI1; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso2781644a12.0
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Dec 2025 13:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764882658; x=1765487458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eprH5ppmLX3mc74864RpHa6sZY3l7+Jd7hL26GBKWpo=;
        b=fm6embI1MTnNcUt4b01kFXqCFj8x7lYEDOywmJw1UoM4ln8ONfrS41psaeI+MgaUDa
         dx0h7aEDnVEh5pagigSCuxGD10WqtDhsh83+oJAWk53FF7XIRerb9tx+JPta2wIMDrts
         wW//pepRm/3ue0kTm1S9ikFZ0XlbF8UOODPmIMxznypQiFbQ5OHPyhb4JKqMBBq3SQX9
         RcFp5lffYC7Vwl+dtaObWVF4oYArL9Qr6Q6Ezv0YsALlrIfuOee73Q3uBKHg1eryK7s3
         XX1uu/YTgux6SCf5ke11TY30c1OU7t9AAlvmcxkA09IMxLHyh4+sywnwCjhjcY+LtOwZ
         pX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764882658; x=1765487458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eprH5ppmLX3mc74864RpHa6sZY3l7+Jd7hL26GBKWpo=;
        b=BZ4JA+qUK5BGXxqXPy42cCC3xdTazayNgN16m989XObmdlT1qVFstXQQijmogZ1opA
         eslGoJjlxp4InaQwKMV70TcT1Y0T8pJvBg+uamQHPMv0EwqCeUlt21CCjCxI7mHFPwrx
         /KfBL6oLglO4VVxYMv4fbzjiGllk+tmlAWgoYk98eCDINKsQdpmYKkhfryr2ry4qCO7j
         Wxzl/TgKmvD7UsZtITDMDPkVT3puZ37aG8p3t2/k8FzMEma4SO2uAScIPIdcx6Xm1pG1
         CB2eTxTby9+A78m7oeJEztihMEdEqWRMJHgx+7WIuk/BO/1yB60AC5io/THZ847tqx2i
         LTWQ==
X-Gm-Message-State: AOJu0Ywu6i7g9vRO8wBLkEzbYxCn2EqTICs4v2PckvHrUED0XRNN8SHY
	gJM9e99b7dpg3XSMpfoY+t83bY5YWBvGxiP0CvQ9DLm/a2OY0/3iJrF8HLQ1cMiiVfs=
X-Gm-Gg: ASbGncv2X06EIJboEgkvcmlzYJ9JUkMWNmVorRSSXdAzyzMy10Ndk+8E+1moULfTRIh
	Z7HrdyhiDvpY1uISACOarkuF3bv/GSvINUhM/ugTuLHjKyZBpywVuH0E+n38fzgS6dlVssmvRLj
	hCzhKJq81VkxJC6ZeslRwtva1Jl8okntI0EJYz85RDbozVOgGFrwIVr1bGq+/XJQpoTaPQc24YH
	gDEgvOKNujmTKUmzja9RGw87JI4U+Op2jhSMwGHrx1LZCiZPTaDeSgti3TM8CZPZzZy5n3/TdrB
	Ig+H9b/Pu3bRtYZSpbgdn3WakWyKJqIylfe0JHjZ4Z68f0kV/mv+xT6hTtTMm2a5cNlAY3Obq43
	8fWDYEfP+ZQSAaPjkJx9dbmTyXaArLQZpZFz0xbKWas0/gaheSKK9Wt7Dp8EVwtdD/IzWJx5JHH
	r8YHJ4+NvWypBhKzHn5q1kIK9BCtFmjC1aafUiRf8XhyMZ3AYFrA==
X-Google-Smtp-Source: AGHT+IGc66idt8JicKNR4ASpYKwcPBT7B7V1xyFwPjccrBV0T7qHsz7RhYJ/3ncWmVy4NaDDTRu4iw==
X-Received: by 2002:a05:6402:40ce:b0:647:62ba:123b with SMTP id 4fb4d7f45d1cf-647a6a23982mr4411205a12.9.1764882658250;
        Thu, 04 Dec 2025 13:10:58 -0800 (PST)
Received: from geekom-a8 (net-93-66-99-25.cust.vodafonedsl.it. [93.66.99.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b2ec319csm2106940a12.3.2025.12.04.13.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 13:10:58 -0800 (PST)
From: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
Subject: [PATCH v2] btrfs: remove dead assignment in prepare_one_folio()
Date: Thu,  4 Dec 2025 22:09:59 +0100
Message-ID: <20251204210959.9672-1-mpellizzer.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In prepare_one_folio(), ret is initialized to 0 at declaration,
and in an error path we assign ret = 0 before jumping to the
again label to retry the operation. However, ret is immediately
overwritten by ret = set_folio_extent_mapped(folio) after the
again label.

Both assignments are never observed by any code path,
therefore they can be safely removed.

No functional change.

Signed-off-by: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
---
v2: Remove also the initial ret = 0 assignment for consistency

 fs/btrfs/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7a501e73d880..9e2c2f2cd03f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -859,7 +859,7 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
 	fgf_t fgp_flags = (nowait ? FGP_WRITEBEGIN | FGP_NOWAIT : FGP_WRITEBEGIN) |
 			  fgf_set_order(write_bytes);
 	struct folio *folio;
-	int ret = 0;
+	int ret;
 
 again:
 	folio = __filemap_get_folio(inode->i_mapping, index, fgp_flags, mask);
@@ -877,7 +877,6 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
 		/* The folio is already unlocked. */
 		folio_put(folio);
 		if (!nowait && ret == -EAGAIN) {
-			ret = 0;
 			goto again;
 		}
 		return ret;
-- 
2.51.0


