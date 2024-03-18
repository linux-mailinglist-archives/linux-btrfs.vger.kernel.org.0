Return-Path: <linux-btrfs+bounces-3356-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D910A87EA7B
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 14:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948F6282B8C
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 13:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0908D4EB49;
	Mon, 18 Mar 2024 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5TC5Ti+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997261FB5;
	Mon, 18 Mar 2024 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710770313; cv=none; b=ZdAd/lujRntp6MheGivVDpWjjgD3ydI4+MSlITcGVJpaooC+VuU16E84GAmMx2w4p7bD1Mxc7s7wT3El6TiOwNDDTpeCxYjAeE7E3IusaiKr503D/Mu0z1sRioDM6mRBa/rGv+g05TxoPLvOMRv/2pAD9qHmLZoI13f4PnPxqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710770313; c=relaxed/simple;
	bh=eB04OzSDrJFDMctU4Yo/iuNMA5Z11xezlqp2LkCz0r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTaoC/y/MnKakZb6BHXfrkD3YwisAr3+lMImGdPhQttNFMtysjQeAvC9bi/4glWan9az7uvImE2CWpZLqfkhH4GpU8HMTvb/IPZ5uVaveT8lyUJhvZ0bCFArSFwcRIjMi8hcZ8qU7i3fCWGwVAwNiyk/9m4ZaY2h8YViZsGZsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5TC5Ti+; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-609ed7ca444so39234847b3.1;
        Mon, 18 Mar 2024 06:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710770310; x=1711375110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZStTB8xWLWeRyPf5uT+m6Noea+dBMOeNlRQSdVaAxIQ=;
        b=O5TC5Ti+NPDwmY5WKxOqcwp3X87RhDcc9bDLRrjCPCAIZPO4UWFwXrO9AukmaN9pFa
         O2iSpDcln5YcZwVarNDm5wFUQmGPt2cL256nwcBHROFyJbfClF0AT5JJDKrdRnmM8awN
         xQy2ll9/wjegU9C6vQV/I9tHN89muClNpr3/2H/uC4FLKQwVB/MZIrK8z+j8mohuFuTP
         MLmbFnxehveDmjeqd1HWK/xQRZSNAORLdGrTiEo/89pQCriFH1N+5BkugR9P0ZSagGNz
         dzVXbog557jKEfQ7fR+7jgNImhFwg+U2MyNtEFpXPvV2mNfAPTGLVLxm/Vr3g5BcAiut
         lNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710770310; x=1711375110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZStTB8xWLWeRyPf5uT+m6Noea+dBMOeNlRQSdVaAxIQ=;
        b=k/HrJtnW9ZXJg/KzKBz8ULnEWHrdZr/JEc2iJ3vrK55R52mCkdESAR3EI9YOSoXCjI
         A04sWzOh7u3L5iXoMePDzORJTDpP0v1sYBdYcbY1678sEd7DlCKFXxsUPw7QeOTYWUk2
         HrwKPIp5yobg3z4AOW0UXuORP0eH1TP76yWHb13F7OHiTz1zXxYC8lpP7pIviSmCzqTM
         CfgfrkNkQTjrbD/REdsdU3w3guygQEh2i7WoNA5t5uQRqw08pE7EBZ5b166vGbIePRQJ
         SEbVZCNyp9bdUnuaJqBEixgxauCQupnGozKtN2kQDafy/oCll/Ei/IJH8iB2LxtLSSb7
         AsbA==
X-Forwarded-Encrypted: i=1; AJvYcCVYwc2GPBcgItCWTmYiOuo/VGflFG/VVZ+evvGsEpMA073Pf+rCrswd25kF48AhF6KgNtaVvdyaD6+XOdLGxMk7MnTc6ot0a1jVo3rc
X-Gm-Message-State: AOJu0YxlFgYpP0ZcX1prIfiKYx+0vU1IKIV3iafrgSZilEWy7g4/pN6C
	QbIJ2HC+odWQgvHxsVQ7p/smkmYW50VrceF+B0WO0dUIXn2jxz5qqv8cg7gUwko=
X-Google-Smtp-Source: AGHT+IG5WAsd+Gw6up0vXetZbU01irGGgHkrT63t7bn2e3+IJ2qRDkfYSk1MKtWOFrzKyhKH1vWNTw==
X-Received: by 2002:a81:9306:0:b0:609:fb70:2a96 with SMTP id k6-20020a819306000000b00609fb702a96mr12270162ywg.20.1710770310360;
        Mon, 18 Mar 2024 06:58:30 -0700 (PDT)
Received: from tachyon.tail92c87.ts.net ([192.159.180.233])
        by smtp.gmail.com with ESMTPSA id fb19-20020a05622a481300b004309cf16815sm1284968qtb.39.2024.03.18.06.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 06:58:30 -0700 (PDT)
Sender: Tavian Barnes <tavianator@gmail.com>
From: Tavian Barnes <tavianator@tavianator.com>
To: linux-btrfs@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Tavian Barnes <tavianator@tavianator.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] btrfs: WARN if EXTENT_BUFFER_UPTODATE is set while reading
Date: Mon, 18 Mar 2024 09:56:54 -0400
Message-ID: <d4a055317bdb8ecbd7e6d9bdb5ebb074fa93f7f8.1710769876.git.tavianator@tavianator.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710769876.git.tavianator@tavianator.com>
References: <cover.1710769876.git.tavianator@tavianator.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We recently tracked down a race condition that triggered a read for an
extent buffer with EXTENT_BUFFER_UPTODATE already set.  While this read
was in progress, other concurrent readers would see the UPTODATE bit and
return early as if the read was already complete, making accesses to the
extent buffer conflict with the read operation that was overwriting it.

Add a WARN_ON() to end_bbio_meta_read() for this situation to make
similar races easier to spot in the future.

Signed-off-by: Tavian Barnes <tavianator@tavianator.com>
---
 fs/btrfs/extent_io.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 46173dcfde4f..0024ea20bfc4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4285,6 +4285,13 @@ static void end_bbio_meta_read(struct btrfs_bio *bbio)
 	struct folio_iter fi;
 	u32 bio_offset = 0;
 
+	/*
+	 * If the extent buffer is marked UPTODATE before the read operation
+	 * completes, other calls to read_extent_buffer_pages() will return
+	 * early without waiting for the read to finish, causing data races.
+	 */
+	WARN_ON(test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags));
+
 	eb->read_mirror = bbio->mirror_num;
 
 	if (uptodate &&
-- 
2.44.0


