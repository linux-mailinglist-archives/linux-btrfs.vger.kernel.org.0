Return-Path: <linux-btrfs+bounces-9257-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9659B7548
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2024 08:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015E91F217FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2024 07:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6C514A4D1;
	Thu, 31 Oct 2024 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bMJynEQ6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C86149005
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Oct 2024 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359420; cv=none; b=myw06q1MGRM97/4XQvrS0g+vyErXYWXEtPfQDBpEN8RybElxtPcafA8CQoQ2YAiGuzAneROKdB8OXkW3T1OegTv/h8q/u0EQLhvUE67eoNiomDchc3/hgnb9uQTFQRuiPfzP61GU4Czu1FMwETh63ZPYZU2ooqmxTd1bAJxQ8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359420; c=relaxed/simple;
	bh=FqPgmfMfJrc0+/cAObgO3obnQM+lqVUBgVtHaNhOgZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bV11f5UkiWiWMlUe56QPa0vfVsrLPO3Fqu/v+iv2jK+TtnkXcN8rp4pmHHMPTH/sviVxN5PnR+3X/Ak2H3SiL+yH+Pud7D21ABi+ma0VvEYKpz1UpECiAfkN+FtSv5OUv6YdH4Rlts/NbOnX9qHMUSXYKvVJdYuk1VBLB4Ve2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bMJynEQ6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so482610f8f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Oct 2024 00:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730359417; x=1730964217; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eppF8n4dF35FPRHto6hGatVhKtxOz/uvRu2s9GrmB9M=;
        b=bMJynEQ6rLmB0znzS8KJ+j7VEGON6Ps/6s+fS/KQukclFldG+cDsrWjrPDMvGuXAD7
         aS/wjQKjowm4iLLWRntj3KZPZDlfXun9Udungqvcz2V3KdRsdLihnY9AyW5UWpB+nk6G
         z6Mikp19dkAZAq+colb2xUrExY+ECvKevq53qRtORNyGXVtpOED/PZZjjPxVcxL0EmXC
         eP2gO7KC4RjiNzYPX1e/TAUsto1sZKd5Se5uz45uAhJarIa4Ve/Q/sS52e7FIFUjmxs8
         QmPDrW6biIB/Z1i6M1UQIY19x/sBwol5mV/hKM/mAfkpTxRR8u64UIc5pjC9BnTsVxUk
         cV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730359417; x=1730964217;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eppF8n4dF35FPRHto6hGatVhKtxOz/uvRu2s9GrmB9M=;
        b=uyU+7PdcWktndMNjPmutX60YcQkMm3RnA/Acc2vit1UZwehwCbgv+EmZkZ4GKjhFgA
         cQ/tL3nqY/CaNqgfykLtcLxgHifGofVjRj5/6H2yG50ueUakgLX8eyyPYUI9hawD0PLi
         PxgcXjW/ERJ5C3k3KWlTioLpquQoY4A1gooe/iyndDXmzpMV3ZNhQtxHBL7gEozklY8e
         RMP4mMmUCSEHPNMy8fwJ2rpnomb5nftzepbG/h2EQaU2howyuLJg0c4p6HM9aYJzMQrM
         E7oIHT6VmY5ERB6A7a6ZSPLixa3HA62Pslq10ZJXcAv2kggVMjCudJGTMOQm7RKpx/px
         m7hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWAuuKRjsBlSnlYUf2ohK8SqLaqyIMs6UJuWy+fCRVp0ZV8KRdhYNeJghxbGPXBUTi6R3TB0MzOyFjyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqMLLITIRHYE7aDZ/T0fXJ0DlTWj3GXN1VqGjC0Pfv8jzamsGV
	hoLd3/r9nyh9GvG7EYHIuHKrE/o1Jx0Ytmq9waST6Z51thbiYOGmQ7/jOpVzwTs=
X-Google-Smtp-Source: AGHT+IFNnvWhRF0ypJE2IbRw/0FEvCWw1br2Z/ulxBe7NO7dJpvdXXEpTsTLYVrJ238z2NJVpl5a6Q==
X-Received: by 2002:adf:f887:0:b0:37c:cfdc:19ba with SMTP id ffacd0b85a97d-380611c5005mr16403526f8f.28.1730359416598;
        Thu, 31 Oct 2024 00:23:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d437bsm1214842f8f.30.2024.10.31.00.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 00:23:36 -0700 (PDT)
Date: Thu, 31 Oct 2024 10:23:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Filipe Manana <fdmanana@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] btrfs: fix error code in add_delayed_ref_head()
Message-ID: <8a26ccf8-707e-4004-8077-0d8b56501d83@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

xa_err errors are equivalent to "error_code * 4 + 2".  We want to return
error pointers here so we can't just cast them back and forth.  Use
xa_err() to do the conversion.

Fixes: 6d50990e6be2 ("btrfs: track delayed ref heads in an xarray")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/btrfs/delayed-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 1f97e1e5c66c..012fce255866 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -848,7 +848,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		if (xa_is_err(existing)) {
 			/* Memory was preallocated by the caller. */
 			ASSERT(xa_err(existing) != -ENOMEM);
-			return ERR_CAST(existing);
+			return ERR_PTR(xa_err(existing));
 		} else if (WARN_ON(existing)) {
 			/*
 			 * Shouldn't happen we just did a lookup before under
-- 
2.45.2


