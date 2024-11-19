Return-Path: <linux-btrfs+bounces-9754-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A369D1D73
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 02:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3ED1F221A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 01:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F225D12BF24;
	Tue, 19 Nov 2024 01:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="EYHWUzx0";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="AOE5eYX3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DDF8C0B
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 01:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731980627; cv=none; b=DEDFw0ucl+Ja1Ad9CwgEXDr/EEx7Zg0RLSNs2nOfbIML+O51MViKdAuQoTzTZZYagYu9tLcmoqwjboIw/3lugsQAv2/wgalGFt8CiXk+DePOS+6a491ut3R+INQHLnBwOAnmZ2KOm61tWCNYQZN25FtiWyU1ZtolTrTg5+lLlFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731980627; c=relaxed/simple;
	bh=CKJrvopa6ozLYeKw33jSVd4A5UnSuCl1grm29yT76z4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HHt3tgppFLR96aKuKhkeULGFE9Hm4t6c3Pw1F5B6A1bcsVQQ9Lg2JF8ZiVsIfFEN+Q+3KlzL8VDkXiiOXD4hj3gc1SLjA5KeKBneORZkhT87cQ9ZNwIpundZQTa5N/pv/0souXdJWGFxKo935w2eppJHcwuqmbpXvc9MHx0DMPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=EYHWUzx0; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=AOE5eYX3; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1731980625;
	bh=CKJrvopa6ozLYeKw33jSVd4A5UnSuCl1grm29yT76z4=;
	h=From:To:Cc:Subject:Date:From;
	b=EYHWUzx0t4R/uaNOreg9gJpZ5d4CR4xtNr2NXZoOsWgXVRXBL/wCQKMl4g92v0Ym8
	 ox4Lpike0YHy7PDPYR0cyKkv8SGWV3XBuyK4qzZ7yPP9XmhVjnxhvo+mewoFNKkftb
	 bhIUz8cQ4i/GemsrgfMVJ5WYmUa9rlE6ajfudNXL2+L5Nw0WMMPXyeLXplKoMScqVc
	 fxB/SsQnSrtfIP1p2sTGbLTNtNrjhYb2doxI2xQf6e32BcyTMTdgM1ot4bQNb+BvOD
	 0eplnW+MuNFEEXj2URu4uQFJC80uBItwS05wIhK/6dG1M27sTktQnxZqoxri7Nv2rI
	 iwOpAW2NYjtvw==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 38986105
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 10:43:45 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=AOE5eYX3;
	dkim-atps=neutral
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id DA5373BC
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 10:43:44 +0900 (JST)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21205195adeso19254435ad.2
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2024 17:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1731980624; x=1732585424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6jAkMu+ET95IMimeGZDWYrcMncnCAOMJmk+LzAD+nk=;
        b=AOE5eYX3uErirOuz5Cz//CI6pvQnp+x1NPKkm6b+6gS8eDB8HZbu1+pPUVqyJi3XyN
         0s98Cj2l3XoIODHmOuGfwe7wo7c7M7PCPJp3Pr5lMVVcS7Ihlr6n7frwqns41Zj3mWpr
         b5kucBNg0gwQMZqG9h5wzGTJAVAeiZwxdjX9CNImouqx5bP0eGK2V5fYEm7wrAVVQm+m
         y5DBiPR7jp41AgEL7BdpMpPvnMqyXPh814AbC5CnO8mEI/AZTsBFOc5YlJIAy2VW237m
         Lu4LuBqkrVeWQFohKJk7OvUpVBnuJBckReVM++0WN6UNidrYy4gRG7lFbhT6Xr3D849i
         gP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731980624; x=1732585424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6jAkMu+ET95IMimeGZDWYrcMncnCAOMJmk+LzAD+nk=;
        b=sb8+FHsePdcj0gUk8HPze1jSU9iO1lqqzMl8iURHKqb+9ZZ0TLgMErX1YRi1+8kagQ
         kf5TV4S4BrdE/QVwBkjD/FuJtpEOyHlvLKB4qAavw46xzPgX8eApuK+ECSFkzEXCobJN
         t/TKLwrsR71qYWjCwkLbv8UtnwKqoviArRogVGWknx9+pRA3byWek94C2wAPQvE2lwDH
         80cO7/mVd13QpHnBuxrd8ekVAG4OHMO8DOykx687HJkxYl70laX/43Vo0TFKPhBtvyj1
         oEmTG+2Wc8DtJcGgxeZDdPDN/TTJozyN1wAYvL1m/nANtQaLKhnpFzXpYo/zyQV72GxB
         F7SQ==
X-Gm-Message-State: AOJu0YwCTn1ajE4KHXqu+uj/Tu5DBepXtpERg+e1BgaxJi3MYJwz+c9G
	EYrnctvPChgJi55vD1H9q2uGXX7WwwA/4jxVkG0/DyFsK3bzV4zJnu5FqFK6iZioKNzO9i5KaJJ
	ymNOejiEfNv1HcgC/kEQq/rUO4MabBaF/IMZnCPFpa+u3DoRC4Z87bcGk2i8exNfoI3V9dA==
X-Received: by 2002:a17:903:1c7:b0:211:f119:2f92 with SMTP id d9443c01a7336-211f11930dfmr107332455ad.51.1731980623908;
        Mon, 18 Nov 2024 17:43:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR291RwCMUQwNiHsDHHqQ4F1wYAF6rO3JytmDlU5sQyWG/ikwOh5JYx09icoLrx5M8NF1KKQ==
X-Received: by 2002:a17:903:1c7:b0:211:f119:2f92 with SMTP id d9443c01a7336-211f11930dfmr107332325ad.51.1731980623598;
        Mon, 18 Nov 2024 17:43:43 -0800 (PST)
Received: from localhost (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc30a9sm63271655ad.47.2024.11.18.17.43.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2024 17:43:43 -0800 (PST)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: linux-btrfs@vger.kernel.org,
	wqu@suse.com
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH] btrfs-progs: utils: ask_user: flush stdout after prompt
Date: Tue, 19 Nov 2024 10:43:39 +0900
Message-Id: <20241119014339.3640843-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when stdio is line buffered printf will not flush anything (on musl?),
leaving the program hanging without displaying any prompt and weird
dialogs such as the following:
```
alpine:~# btrfstune -S 0 /dev/mmcblk1p1
WARNING: this is dangerous, clearing the seeding flag may cause the derived device not to be mountable!
y
WARNING: seeding flag is not set on /dev/mmcblk1p1
We are going to clear the seeding flag, are you sure? [y/N]: alpine:~#
```

forcing flush makes the prompt display properly

Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---

I don't think this behaviour is musl-specific, but it seems odd this was
never reported before.. perhaps glibc flushes on fgets?
Anyway, it's easy to fix and there is probably no downside so here's a patch.

I've tested it works as expected, e.g. prompt is now properly displayed
before waiting for input.

 common/utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/utils.c b/common/utils.c
index 3ca7cff396fe..9515abd47af8 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -416,6 +416,7 @@ int ask_user(const char *question)
 	char *answer;

 	printf("%s [y/N]: ", question);
+	fflush(stdout);

 	return fgets(buf, sizeof(buf) - 1, stdin) &&
 	       (answer = strtok_r(buf, " \t\n\r", &saveptr)) &&
--
2.39.5



