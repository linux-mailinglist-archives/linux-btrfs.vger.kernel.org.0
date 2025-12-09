Return-Path: <linux-btrfs+bounces-19592-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FE1CAED1C
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 04:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C9EC302AE02
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 03:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C875F30101A;
	Tue,  9 Dec 2025 03:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOt6Pr4h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92262253EE
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 03:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765251485; cv=none; b=htdy7PuJBpyQS6+0o2++RI0znAtPFZpU01Zf3CSzKR6f3WgPcAV4XVzpe3YTRD1NsO7AlNounDCsOhgUVaAkDomQFagffrJEeIxJzGxnFDUGMNC+YWD6TfaFOftMu1BhFPZblfKejVUsC3xgPFL1+u9huJMhyvUs1aUoAnrfaqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765251485; c=relaxed/simple;
	bh=VaAYZHvvfpbMb8OfBXvulLEmbIGaXIBJjXKjzfKzMco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZ6ap/aGxQnp+QImSDfN5wcUwnowQoC9O+f+mEaEaZ2GOqfnpymje/sBlsQ04Y7ofESu4uYg0Mk7kHZg5ZW7hMX904q6GF0xGkRtkNsA+8DoamZ6A4TiTSjyQqBmxVw+pQIdUJ/6DSQU5Xf3UmvvCSb3x0qLti1Pgk/2Zx2t71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOt6Pr4h; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-be9ab2335beso107073a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Dec 2025 19:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765251482; x=1765856282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OiqU/pK81ad7+w/vQEMY0EJJdoqSmprGQQgxAo5DdU4=;
        b=aOt6Pr4hl2KKvbkM1a2Xk7cRODXKydo0VcXfDu7WSZPJ48GD33lMSc2xwo0yROQKET
         NIPnjfb046f/YmvGfeWm7m7bAtzEeist9P/FBV69N4sbizlxmdakc7q6WV3jvLkuZSTd
         /zV6eUb3HrOAhQSW5ehR/IFCZizUGVxtCX8wOOWs69nKvMqjHGZFnKuAOAgIt/rP0jpr
         uEg5UHvTD1uCmgbtlEUEdNFizAiVVrKl0QMcgEvsfIAOQuP69717OOUY6l2GyH++JWiS
         LJ23aGLjiMWal7s+mfWs+BBU8W3nf9zdZEtNA+1NpWZvZfMBq/0BYaiC9ENGuQ+xv8w/
         BHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765251482; x=1765856282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiqU/pK81ad7+w/vQEMY0EJJdoqSmprGQQgxAo5DdU4=;
        b=TJ//D8kQJkHo/YjTZSHRuYUZSyW6BN8qGiVmuWZjAc+cS/z6UsyfgnR6hw/oM9mt0v
         4OfvEP1vDiX9j8eIURFOTlc3t23xUM/pTZ5bDmRMP87bdsp/NSXZ7AwYSJvsFAeeg8Mh
         2LLrfPdP5/mEcWKq2GKrVpFnv+ONnhuZs5Zn2DNSYbPfMnKNMopKl3MAzIjmLpMzdxdF
         GD5Ksfc2dWASAhlwp6YEFmbC7ZhEsJpqNWvFJTYuam4CH1Zi0vOiNJ3T1CNTf1AUogCQ
         fmOGgWy3JsrOy/m2+zoybiJfncfo9hGGflbr7mPxcUn2KlVYJ3aE3liAGsse8oifPMcv
         hxmg==
X-Gm-Message-State: AOJu0YxSOUZYTpe0RWxhnHalJ/6RcEtvhL/xTD7CWp7ZU7cDYwztH3NW
	8jv0fysmDnQhT+yWQI9qcEOayF5I1GuXmc8p5Bpac0odidXfg+hCCh6ai1fMdo7FDM2PuQ==
X-Gm-Gg: ASbGncuR5ASphlhuEczq12AE/ya3mQ5mMMDC/2aK+k0VVUj17Mxa4c08fsjdpePctx3
	HmNl1I6Nn8W9SZq8DGyOV0MDFyw32tw1he7HIjPhAdgOuXcOo5Q8/aohdVuPaZrE3lYQ1ETLJxZ
	lpLPmSweDg1yXgvmkfbBFA00AZ2R49excnN/sbd8Fp2FlU8ywkTuEWk3l7WuFp8EwngdxU7iq8l
	mr/vYmsgH++NZHx4tga6EM//zf0zx7/xLWCnkav3Cxqn7zluFGMIC6diNlAE3G0I7qDp3uAFiap
	XLSSgSuwT/PxH1V7dXsqazuO/BtbO0k7+QSxbXw9UbLx+oboE0UnFV4I4bkz9waRVJTkUOtaNyv
	EbG69wcNElLgb+UV1cfFQa21w1E3svdD0GvKnZE+6yv4xgbf70ZEpUUUsOyDaag6Pdm+eTSt8F7
	W7B3VI5tIPxbUpWAfPvy4j
X-Google-Smtp-Source: AGHT+IGdrBZRs8gvNLpMsxbCDYF5gjI+2GDTqi6rtsGHajLuZD7l4zQy3fJFqbFxvHTWrwKj7jrRuA==
X-Received: by 2002:a05:6a00:84e:b0:7e1:afd9:9a66 with SMTP id d2e1a72fcca58-7e8bfb3c5b8mr6721689b3a.2.1765251481928;
        Mon, 08 Dec 2025 19:38:01 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7edac47617dsm3923900b3a.42.2025.12.08.19.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 19:38:01 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 0/4] btrfs: some cleanups for two ctree functions
Date: Tue,  9 Dec 2025 11:27:17 +0800
Message-ID: <20251209033747.31010-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first three patches is cleanups for btrfs_search_slot_for_read().
There're only two callers that set @return_any to 1 and both of them
is unnecessary. So @return_any and related logic could be removed.

The last patch is cleanup for btrfs_prev_leaf(). Callers expect a
valid p->slots[0] to read the item's key. So make sure btrfs_prev_leaf()
return a valid p->slots[0] and remove related checks in callers.

Sun YangKai (4):
  btrfs: don't set @return_any for btrfs_search_slot_for_read in
    btrfs_read_qgroup_config
  btrfs: don't set return_any @return_any for btrfs_search_slot_for_read
    in get_last_extent()
  btrfs: cleanup btrfs_search_slot_for_read()
  btrfs: ctree: cleanup btrfs_prev_leaf()

 fs/btrfs/ctree.c           | 141 ++++++-------------------------------
 fs/btrfs/ctree.h           |   3 +-
 fs/btrfs/free-space-tree.c |   2 +-
 fs/btrfs/qgroup.c          |  10 +--
 fs/btrfs/send.c            |  22 +++---
 5 files changed, 40 insertions(+), 138 deletions(-)

-- 
2.51.2


