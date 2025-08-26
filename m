Return-Path: <linux-btrfs+bounces-16365-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FB7B35F19
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 14:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD4C3BA766
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 12:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FA03375D9;
	Tue, 26 Aug 2025 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csSTlu0V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9460532143D
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211354; cv=none; b=MJ5dPZx/Zm3h3W/2I/1qdztU11JJeKTXffV7Vknb1cSnen9dBEIUEJ6aZA7vCod+0mBUdwnZ0tnw9EgLVju3gZaxWmkdTQu0Ng2aaUAg+DBdejZJp1gXRW/BIiGqSNbjgayQcCYf3hY1mHpYfYVoiDtttzFMwHxPjydQYVyXj7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211354; c=relaxed/simple;
	bh=078pPOc4+Mrq2GiBTcZLDoZe5iF+QRu+RYWcOLy3N5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=spRH/+iF6yypt+PoeNjh7W0+PT6gw8sN92w5ZpHsO+SNnFIIh9wHpQ7+hiOQwOktCAxI7hxzccvss3hlT68i/Rt+2IIzNreRp+/nInlkcSzRgvQ2fytaDYs0FVIMbaj5Pgh/v4+1Qg4GWYSAhFcLOaRl8hNsrRHBh2Dn1Nh9uTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csSTlu0V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756211351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QDSuqgH2PK79DxalD4iHZQ97YhSiJJlN/fNRNiH/3wE=;
	b=csSTlu0Vnr9I+ch1THOwn7QZzTqV1OPRO6tdUfoCBHA5axlnpulhlbWkqvOcmk3dQ+iVtR
	XX5k50SHZ0z3WyTdzI+miwfimIefUWh5UqnlYvd6ScYM4vc3XmJRWvnD39iG3fo+pTYS8k
	7pO79TTO/H3RMzhL3zex7t9d0jyYxFQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-JQ6FyERaNyGsJV7TJqDF_w-1; Tue, 26 Aug 2025 08:29:09 -0400
X-MC-Unique: JQ6FyERaNyGsJV7TJqDF_w-1
X-Mimecast-MFC-AGG-ID: JQ6FyERaNyGsJV7TJqDF_w_1756211349
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70d9a65c355so89805326d6.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 05:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756211349; x=1756816149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDSuqgH2PK79DxalD4iHZQ97YhSiJJlN/fNRNiH/3wE=;
        b=DDYHNsaJscktZAIP0iYvkkdE9uzjuwYle/32LToRXJZXjsxaIwdSIxuY3GhXTta5c/
         UYzEMXb5K2cnQ8V+VHl0IAfkthAozaiVlZ7sgA+SvC1gID/nwksjbz46mMW0eqMK0Bcb
         A9wcrEPDjrSlB+EqZrML9WltsKFFhMXuAubcFa7dsHuH0r3CPynY5r0EEe/G43AGYIUq
         rJ7ad+EfiuR6cN4pmHKqyFjYxGkQZwdkUxVK31K7bdz7dx+R6M7apLPXMAQque//NBQn
         xeStD170ryKmB8RJbcrdaFkzwIqLsrRh/bcGgPWPzgfR4pNQe2USszNTPEWukG6iBOdS
         tVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFrTa6hO9Q+hwtAKxdYamKLqONDFkwwfn9Qlk4wUHl3uLgG4BMlZcUk0RJPJ4fCcOpbjtAwZH34Y+0kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvdrGUkYOENOqRkRjBZIQODQ9ScwpoMmoVp2IrcaauUVgCFoeT
	TYVXqUDA3ZpAAF/v0IevsbiHBker6goCa2vfuVYxxL7XDAwA5xfpynntVXx+Bf6jFstXddGAvKy
	Q4NMCcNo9eF0Z8Cx0IeIuiEsQihk6PFUYSHNB3Lc1CuXkSIgKZcAA/naOLs8ZpBhM
X-Gm-Gg: ASbGncvVp80F0YEPjjJ3ArWnzcL5eaAPyWJ4gt5hlHkXdzoHeyPlbJiMMt0La77kU4h
	nm6XJ9+nvbS3AKaZYls/ACIUO+Od41eNtE64Bt8f52hpkCRxYJoclHIAFr9Adj3LQD+di4kiKuF
	H7999p14aO2SgKHAvvLSK7/LrkUHUvWFLbC+OjIeSocye7n8BDXAzirxnqwyxp/LBCEan7ytq34
	g1ZhGmtwX1QM2u6EpPAlkcQK7ixxoGquqPPbn4J4R/nfMzeTuEL3rzr+fdKw69c0C+U+G3lEkjb
	VksaGjrVKFOm5K7eS2a37od9rzkGjJLeq0OGxiQ2U3W6ST1L6DvYI4hkZT425BgYJ9T1JQPp8v6
	9C1BmkFJvtg==
X-Received: by 2002:a05:6214:e4c:b0:70b:ca78:4f52 with SMTP id 6a1803df08f44-70dd59c1084mr12463036d6.14.1756211348872;
        Tue, 26 Aug 2025 05:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHohgBlgoi98YMsIeHajcZi5xUzGFlQJCfrBIsLeUqR6BIOUm9qjIn9QZofOTgx7sTd3jOHZg==
X-Received: by 2002:a05:6214:e4c:b0:70b:ca78:4f52 with SMTP id 6a1803df08f44-70dd59c1084mr12462676d6.14.1756211348313;
        Tue, 26 Aug 2025 05:29:08 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72b04a6sm63527046d6.52.2025.08.26.05.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:29:07 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Leo Martins <loemra.dev@gmail.com>,
	linux-btrfs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] btrfs: move ref-verify of btrfs_init_data_ref under CONFIG_BTRFS_DEBUG
Date: Tue, 26 Aug 2025 14:29:01 +0200
Message-ID: <20250826122901.49526-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit dc9025c1a4d8 ("btrfs: move ref-verify under CONFIG_BTRFS_DEBUG")
removes config BTRFS_FS_REF_VERIFY and adds its functionality under config
BTRFS_DEBUG. This change misses a reference to BTRFS_FS_REF_VERIFY in the
btrfs_init_data_ref() function, though.

Replace this reference to BTRFS_FS_REF_VERIFY in the btrfs_init_data_ref()
with BTRFS_DEBUG.

Fixes: dc9025c1a4d8 ("btrfs: move ref-verify under CONFIG_BTRFS_DEBUG")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 fs/btrfs/delayed-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index f91062fc1b0b..6170803d8a1b 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -969,7 +969,7 @@ void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 mod_root,
 void btrfs_init_data_ref(struct btrfs_ref *generic_ref, u64 ino, u64 offset,
 			 u64 mod_root, bool skip_qgroup)
 {
-#ifdef CONFIG_BTRFS_FS_REF_VERIFY
+#ifdef CONFIG_BTRFS_DEBUG
 	/* If @real_root not set, use @root as fallback */
 	generic_ref->real_root = mod_root ?: generic_ref->ref_root;
 #endif
-- 
2.50.1


