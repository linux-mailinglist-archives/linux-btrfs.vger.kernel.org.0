Return-Path: <linux-btrfs+bounces-10193-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751659EB4B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 16:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DBD1672F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 15:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441361BBBC4;
	Tue, 10 Dec 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMlDuz1B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D851BAEDC
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733844259; cv=none; b=K8fyrVxGz3UwGVU25Uphm3hl5fW88yFDZ9PcUmuoxwdd+5I9Km4G/M8HF9lP605GFK0OPbMpMLcVf6QcpAOblyoN8HnqYevwffH8+Y0vbbgrl516gfyoNrGLnYt0Pv2ogYTglz7ZomJeZiz4pchPXs9Ijgp6R/FMFPr6Ni/n0Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733844259; c=relaxed/simple;
	bh=EZOyRTye/qtazesR/0M9QoLyIGzIEIDNmWRBw0mqwAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=peWzJBNKt8H2rOwbv3vlcmxxZzhKgbY5NgrSLCDUpPyLVnNbyCKjl290oW6CCjzzLA7EDzagIKUQl+Tjk/ZJ02jF33jn0hacgDR8l80N0Lx38V4Tj/V2GdRWUHAyrW7BsXuR44d9eMAV4E+e7LiT4gXt6HTdTAdxX1qNmKbAtSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMlDuz1B; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso2327577a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 07:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733844256; x=1734449056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UwO5gmRDzYGGKXk6c/aHBuO4NNqSNrWRiqrrCXjTO6I=;
        b=NMlDuz1BW2XgT6mcsQ5HChBYWYw+1/xK9bWr6NqbZdbMKM8ezMIU/6XQBIV48EXfqe
         +z1qhZq4MS/HMGK4ugd+4eiOsXxGk9aHqNta2aYHVlL2aKDgkpy5C8bsVbf7ReIGzgPJ
         34MygAtjuOI0Jd5DXusW647AM0eRkEWa3DgytSiVCaRSMH8FJeRBw9AQRo2cV3qZCOF6
         32mG+w1iOY3N0bJ4SQMN2NoyQKjG3Mj3IAWOVSdOR0wZ9BDk2hqV4u3iVNUGw+1Q5RUN
         NLzTQ/+j7pMr63c1x1GUDA+/PXGCsb1jEAurdg9dZ3EfcKBbXBucgjViNr2I/W0ihZ4Q
         IVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733844256; x=1734449056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwO5gmRDzYGGKXk6c/aHBuO4NNqSNrWRiqrrCXjTO6I=;
        b=AC8JNDzTQChPdhoTjBOG1CIxWikSoddH0yG3vk0zQCZWpeF6QaJ1ziLH8T9CbHK7hg
         Lc9TE07w9SL4QYH6C3hllcGsDIgC0j5WbgRhbb6T9To7oD3PxzWx0dLBgRdeKc/GI6NY
         G7Y+dlK1VlzU4CN5hA/dt1QUy9cdOHBdLVWBIb3/CNTDYl+twCWqVJZUvTv3GqMZSuu4
         m+7xG7YL41s0cXQl+jxWm4hdRHLRRUFdEmQsDRdsU355TWNCiXOKwaoELWYS+faezNSs
         BsACUm/0yBciIO77IIA38BizlbQ4jM3u/GSzkxMkta+kcyS9JLXcES2qGA8HTIt1J8yJ
         i2tQ==
X-Gm-Message-State: AOJu0YwV5j6gK5HtsNn92+wj/wdBGw/c3DPVu4H5n14xHv3gMAQGUrFc
	nJonov6tOByDodeNPvk8MDN4sr/V5Ifx3sGJzM9w529B1Gi/mz8DmgIBifift0c=
X-Gm-Gg: ASbGnctZyWO1VpPzs4lnb6UpMiFJRxTpzY0k4KphLTPMxqGmkrmWU6Vk0arWZbAC+3p
	WNwkmXzEHIbLUgJeYH9BzI0bZ1swATZZJBFqcd9pODgdybNA+JmWdhsPiKC1CxlSlx5JmIzZP0S
	IeNvPIy1uTsB60KCkMRIJjBimH1U1v8cX/dWUtbyBCU5Nz/Fyu8H8IniPzfbMiDpkY/pAbJ7df2
	ieYD02RWpUD1Xe4hF6c5svJp4N4GjEvLFbWlY4W1rF4605O7Zw4WgS6avs=
X-Google-Smtp-Source: AGHT+IHbRLfoDlpsqfQdoOdtUstA3UlBit6lhooZABoHVC/E2fyA14pxZVUC4M/62rlOeq31LLi3XA==
X-Received: by 2002:a05:6a20:258e:b0:1e1:af9e:2779 with SMTP id adf61e73a8af0-1e1b1ac1bd5mr8361960637.22.1733844256448;
        Tue, 10 Dec 2024 07:24:16 -0800 (PST)
Received: from localhost ([38.207.141.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725eeeaf87csm3677099b3a.35.2024.12.10.07.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 07:24:16 -0800 (PST)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com,
	josef@toxicpanda.com,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] btrfs-progs: Initialize del_slot to eliminate compilation warnings.
Date: Tue, 10 Dec 2024 23:24:11 +0800
Message-Id: <20241210152411.183742-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When compiling btrfs-progs with gcc 12.2.0, there is a warning
that a variable may be used uninitialized.

In function ‘reset_balance’,
    inlined from ‘reinit_extent_tree’ at check/main.c:9625:8,
    inlined from ‘cmd_check’ at check/main.c:10712:10:
check/main.c:9444:23: warning: ‘del_slot’ may be used uninitialized [-Wmaybe-uninitialized]
 9444 |                 ret = btrfs_del_items(trans, root, &path, del_slot, del_nr);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
check/main.c: In function ‘cmd_check’:
check/main.c:9375:13: note: ‘del_slot’ was declared here
 9375 |         int del_slot, del_nr = 0;
      |             ^~~~~~~~

Initialize it to 0 to eliminate this warning.

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 check/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index 6290c6d4..6e58af92 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9372,7 +9372,7 @@ static int reset_balance(struct btrfs_trans_handle *trans)
 	struct btrfs_path path = { 0 };
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
-	int del_slot, del_nr = 0;
+	int del_slot = 0, del_nr = 0;
 	int ret;
 	int found = 0;
 
-- 
2.39.2


