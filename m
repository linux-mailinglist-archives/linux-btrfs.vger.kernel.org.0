Return-Path: <linux-btrfs+bounces-21324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O5yFuovgml5QQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21324-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 18:27:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A20DCC5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 18:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FE0A301CB1D
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 17:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E05325496;
	Tue,  3 Feb 2026 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ3+KAN1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5932D130C
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139470; cv=none; b=CGoEo/Jat0q4kT9rcLbqnHt/5eL7Eq3+bVWb0cfZ41pmNEnImXcXP50aj2LccSXm5yROqHXJmNsLAWipEi6jkzmrOSKoyPX6bp2IhKsbseIcKs0MgtYzYZm26Fb5Lqp1F/bF4LNKrAif/PEdT2svLa7x00U1MYHZt70tddQ866I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139470; c=relaxed/simple;
	bh=kbyVj4lwhApgmqGuF6dylK4z1Fx4XpeR+OlUZ2PLW74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dml6dNCROANtQtgbwEheFlnU5GAoRJYZBPDs9CskYJj4KXfloODYWczFEESsMmF7ZGo/BIws6pwM8FhE24qkNwIFklfONAkbNsf8xTBZta8S55QPY6Od2esES9Tu2XvWjYbq7vfdv0RbRomho3atvBC8Tn1KHh68O2SDuIInwmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZ3+KAN1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81c72659e6bso5176394b3a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 09:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770139469; x=1770744269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/clOlONdUzzZ9F3OiJkkdaeVsbNNXE/fWddlZBfOB8=;
        b=WZ3+KAN1ZukpGxiUn2o1XQ+sJuWFMJzDBONGuHZn3Qicbo4EEp8bMshcaDrvMq/c2S
         IvskHC0Yo2pMDg6Qm4sTXgfrLmG0tCLnWolYn6sRSS0CYml9tA74uLGK3iKNGYd+Fuzs
         VMUcoX1bLmaaN4VhXbi2X4kwPtKBDP6BbjM1QU0pvsgaCkVb6MT9vUw1rcLYHv+eH65k
         vMW+OwlfLFP8UrbSGiMj64E2BNrRQ7xmuTVXW67mC1QfPB5QYrfY/7G37Y9gQ7K1eF+U
         n1DFyB+Sqk0lIHdHrxWIfdH44j9zT+DGOYpFrwUwtDtFj62kLEnUFye7pL9ayFGE9xmJ
         dQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770139469; x=1770744269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G/clOlONdUzzZ9F3OiJkkdaeVsbNNXE/fWddlZBfOB8=;
        b=eeAHs6M6oY2vR+nS8yoKSbBa5w/6DIzsieOqzaI+BK3K4xS460srVvFfKR6DPeAoPr
         +qkJNTfNXs+xT000DLkL/xjNAa1yaIlCA0Y6RbZZLkUmKv7WuhuuGEJ/TMLixLLuTTWz
         Fi4wch9da2Jn63mSgan++/LO/prnN89JfBjnx91QBso3ecsFH5kOPrqZYA+RklPxWSyW
         atbO/0A1J1Ggl1IgwYjcF16SeNNhYmMHo9BCWq0uxTmxaY8MvBtZrFJykdYepxT+0Z3w
         FXs4mB4HU739Vq0/Rglagrnyv8F9rR5wDkyVIdjJldSEQGSjcBcQyWtCOP7a+Di1Q8fP
         pY5Q==
X-Gm-Message-State: AOJu0YySnGyH2Q1NJnsSKPm/r99Vy6cSXygPcunCBMDXhxgiBSLEyg1I
	ajJzh22RN+rMvVQIXvyGKuVATiTM2puoc9R8N6kwMbup9pGtN0jVSC6bzRpdRg==
X-Gm-Gg: AZuq6aKto3Mb13bYyawkthbCLIPSKN5Ai/8FNVU5AjtuU45yKGLXAoCZyg1KR3nW6eI
	3Lo/yoGtjlghm4B91nCHLrqKawgKee9M5Azo3GiR+9zuORwsBJ5J9ss9Lt9ztnnXfAkGPQGdGsu
	CsvOXkapZ5cQS+4QmdBEOV7ExZKRbilKJpyYPkyZ5aO1csliHX2LLSjd3S/RPHizk6eefrMxfBW
	q+hcmtGcjx8Z398Nc8O9AIK+xCZqGpBed9LyMiL1PaOJ+m6iQdDmIXyPnKm4LeURY6x5GHxQZuA
	8zJ0QAQywPJyqKz8m92KMt98qHkIF7E6TqczZED3UY+r2YNJVpNXoPphKUubvBWGDspKZml+uMZ
	/2sjNGiV/3Wa9p+32GzFMgln0yc+ZEBjw6/kZ8YLAKNMJiP4QA2uVC1dxNwICeafnL2nyRqCf5K
	XWMdNQvOJr
X-Received: by 2002:a05:6a21:6f09:b0:38b:e9eb:b12c with SMTP id adf61e73a8af0-39372106aacmr170625637.31.1770139468639;
        Tue, 03 Feb 2026 09:24:28 -0800 (PST)
Received: from archlinux ([45.119.31.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a9f70fesm17099299a12.25.2026.02.03.09.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:24:28 -0800 (PST)
From: Adarsh Das <adarshdas950@gmail.com>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adarsh Das <adarshdas950@gmail.com>
Subject: [PATCH 2/2] btrfs: replace BUG() with error handling in __btrfs_balance()
Date: Tue,  3 Feb 2026 22:53:57 +0530
Message-ID: <20260203172357.65383-3-adarshdas950@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260203172357.65383-1-adarshdas950@gmail.com>
References: <20260203172357.65383-1-adarshdas950@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21324-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adarshdas950@gmail.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 72A20DCC5B
X-Rspamd-Action: no action

We search with offset (u64)-1 which should never match exactly.
Previously this was handled with BUG(). Now logs an error
and return -EUCLEAN.

Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
---
 fs/btrfs/volumes.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8a08412f3529..0e1cc0c4ce68 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4112,8 +4112,14 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
 		 * this shouldn't happen, it means the last relocate
 		 * failed
 		 */
-		if (ret == 0)
-			BUG(); /* FIXME break ? */
+		if (unlikely(ret == 0)) {
+			btrfs_err(fs_info,
+				  "unexpected exact match in chunk tree search, offset 0x%llx",
+				  key.offset);
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
+			ret = -EUCLEAN;
+			goto error;
+		}
 
 		ret = btrfs_previous_item(chunk_root, path, 0,
 					  BTRFS_CHUNK_ITEM_KEY);
-- 
2.53.0


