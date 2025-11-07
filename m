Return-Path: <linux-btrfs+bounces-18801-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7D3C404BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 07 Nov 2025 15:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433E3189E006
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Nov 2025 14:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E0A32ABF6;
	Fri,  7 Nov 2025 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To2POnNR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0336329C41
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Nov 2025 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525327; cv=none; b=rQF3ttHlrZkVWZjR1dX7ITqFx3w9q/2REejDnuDSoFxkSlGkp/CmuIHZICI9XDTtEedKxDNzwaCe9B86dx+ZFPZZ17QuCdFX/3mf0zI3es8pVMk5FAPxQjXPUDhwOfdGuJ9kyk+uZgB8et5lLpnOJ2fKk25BXHbdiIfLmCx/sQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525327; c=relaxed/simple;
	bh=wS2imuQ9BmkOhIkqMvqqB5gl66Z+pbAiZyZ4vNX0hTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAgIg/7z8hzHhWmZBWAPtVyisiEs2x6BywDAF1X1LZU3sn1rzjtvc35ajkC5asK/gjURJ6/24TJzbeNXeSsBwiHeT7QFNqrwQeOzAjAzex6bZQy0UeeLuId9ikHBVCZH9DQhEiPQfcuutSHWid4W1aDxYmMgh/zc5pQm7HsONCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To2POnNR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7200568b13so144678366b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Nov 2025 06:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762525324; x=1763130124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALuLKFw+mr0eVU5vuPj8LnIxQt3AfWAYuS4LghXi6Bg=;
        b=To2POnNRLv1Z3RMuB327G2Bf9yjQ9YNRisL8V7Ov15aKZICI4Ofq0UP/LIsjXK3XcJ
         VM/LwdnxjyCrL9PnHBrxhsZCG+NPykzg0l0pv5mRfhqC4hWrY5m+Ozha1bnoZfy6+iYy
         l11vn2RvuaI5l0OjlNCmjYC2kJUYPQzX49GitXv5ByPDkv57UpscjjzZEbRaW9uWdpv+
         mZdwjpZyiDA7wRjBTnWpbImi0ZQl+ClMQo8gZfEUJwOETqt2ZIYoZ3Atbr3xsPzg11Sj
         6Sh9e9DRaAWTOuIlOxUa4w5h6K+nKUNG3PSqzYyCRRclZ8b3LfN9EDfyBN3NIdY6GF7j
         mAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525324; x=1763130124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ALuLKFw+mr0eVU5vuPj8LnIxQt3AfWAYuS4LghXi6Bg=;
        b=Jtz36r1VLGjEVGzqtx71w5/MBc7877jlAWDeLZPZm2lE0jVC+IdYtdZnmL0HCfgUts
         cY2/z3bFCRrOlPpKRa40F2hnAYsqXMi4r9oOBErTxGqk6noRSDJujdl5k0xZmMyM5VrA
         3xk37CNbVujZu4h+sTmFRXjaCrkoYssuFzEqgM57xzF+X6Qk6S9B8DXAUOmUFn7EDLnV
         5imjMDivvPCGr0afOiVps1Z179YDVWfypRRYn8A09CLmsmfqyBkyefqmoZjU5tMTZCLp
         rROIRfMYol56apQG3sH7vrgMPtlTsZUbhErGaiUV4GsJX5kt5ra7QNUI8Q3BIafaSiXh
         dFOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlLCp15bxANNmLftS+6ivmOWO3hqdSwYf/YMUXvZCmig/ZPghTyAhgM7QdZeBOX3MMpJTjZnt3+Im7zQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyP4DLewWfBYgpeBOC9wxZMgTSxW1Z/66zIjp/VnnN+f1EwpfTl
	fQSfEfpX/lgrgFP54KtdrRxPuPITKf6XlMPW292B1L9JXlb69eAbgoiE
X-Gm-Gg: ASbGncv4sFaDirGuDdHTbAlINwjtQLIsV/980prgSY1uTrxdlPCxZB7mOYctN9DKICO
	/KNxN7I7AImEImL6djmJj7Z3HpLwkrAomxRZX2d8ZnlAyp+6A/brFjzKip/DnzQiXBrmCVBrEem
	C3KzSFnXtMKKnbUA/y3sx5qVsLAzNY7WcgEu3sRwEugDACJINyi2zIRQSBTFHcGUbiXMYJh3ELo
	7cQs9CMH4Q2+MxopJSEQfmUvFyoEwBHb4HOUW8bU/10xvZWXmhCombIsyhYfHShZM9uKXYFNgm/
	crIbI8tA54Q45aj0TXLZahuC4JQFxgMIZMh7gtyYfQB2agH3HK1RCvnfT7817Mvcq4smghTzG1D
	oKYMqV8hK0dH1dHycgnrZGkGUSuSfL9Hfsz7WRlVPw9XR66uhO1pGulF3hqjXsPSrWrF2HBgUyy
	0PvLVUa/b6iUqmwhKyrNZC4s3xKrigKuKMrPLM6I+u8F+DCLFi
X-Google-Smtp-Source: AGHT+IFYK2b9ojdXtTAd4PTW5XlFiit6Z3g1OoNfduNaJTNxwuPOLhjJOAV1QVecyGCifhAj28KZcw==
X-Received: by 2002:a17:907:3fa5:b0:b3f:a960:e057 with SMTP id a640c23a62f3a-b72c090e626mr342966366b.31.1762525323963;
        Fri, 07 Nov 2025 06:22:03 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e563sm253322766b.41.2025.11.07.06.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:22:03 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 3/3] fs: retire now stale MAY_WRITE predicts in inode_permission()
Date: Fri,  7 Nov 2025 15:21:49 +0100
Message-ID: <20251107142149.989998-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107142149.989998-1-mjguzik@gmail.com>
References: <20251107142149.989998-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The primary non-MAY_WRITE consumer now uses lookup_inode_permission_may_exec().

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 6b2a5a5478e7..2a112b2c0951 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -546,7 +546,7 @@ static inline int do_inode_permission(struct mnt_idmap *idmap,
  */
 static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
 {
-	if (unlikely(mask & MAY_WRITE)) {
+	if (mask & MAY_WRITE) {
 		umode_t mode = inode->i_mode;
 
 		/* Nobody gets write access to a read-only fs. */
@@ -577,7 +577,7 @@ int inode_permission(struct mnt_idmap *idmap,
 	if (unlikely(retval))
 		return retval;
 
-	if (unlikely(mask & MAY_WRITE)) {
+	if (mask & MAY_WRITE) {
 		/*
 		 * Nobody gets write access to an immutable file.
 		 */
-- 
2.48.1


