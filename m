Return-Path: <linux-btrfs+bounces-8502-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B0D98F2FA
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 17:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C34E1C21F76
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7305D1AB503;
	Thu,  3 Oct 2024 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BsDiO23c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C06E1A76B5
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970205; cv=none; b=c6xq4QawCP7HCaf5fBWcE5b8RF69V5M4+vTgC6LUeswcsMP4SBsUg8Md4KYJyez00V+L2iANQV84hiXQmASKl4RaOaiW331Vt48qXzRlCIT2XJX4peLXl8i2SyNueFdVfOJW0YAY9o8+9rTdTpgIXkMMRYAMfhjRI7Igysu25ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970205; c=relaxed/simple;
	bh=rZ0K1S06D0ZkgY3M86y+HVET91qr6B7cqJeFgH75ZiU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9jS9NSLfFWrAeRrMjs5MoVkprX94iM9SY7W5cC/YKrWfCXofmAVfR6/aYs/EYBMoFWaUWyjuFILip7vGapUmj4zB0SZ/lYJYC08MEBa1eC5MPOHX8YStklYgyNQh2I1UVyuS8gYX+St5epMn8LmFFbG+ZfKfmfbcthMVlKopZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=BsDiO23c; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a99e8d5df1so112410385a.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727970203; x=1728575003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgO8EnbrLbNOXx/ZvzWXsMt6+6Or5rDE5/d/2+5E+7M=;
        b=BsDiO23cTvymTkaguef7ibue5/Us1ndOl75ZzaF9PWCIuKpn6s6p7lxXrNxACikrkd
         1VbCZLPBsb3ozxbbaklcUE7OR+XF/vtPdP/AjopSwpE1p+KBxCXGQJAqHsA4mJvjnMR/
         CX5dQPwrZWcfQdaSCAFllAgrVYAGnF1xSwC8dRLtXDmt0KhjaK+Qxo/8/BaVsqONPaIU
         JaHOTvXpMl9H8A8xPYHnIUZdl8Npzr8kCI4cm7gJEzwhgp4Prlk2J0kOfjDNnw2FzpZF
         QWRE4YrnJJJQlRDaddT+ihNZnaLR5myiVjzCuSEXn1+NV0A2E/KiP/kBVShfb4oBye0S
         xTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970203; x=1728575003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgO8EnbrLbNOXx/ZvzWXsMt6+6Or5rDE5/d/2+5E+7M=;
        b=YEAz5utImpCL4JW3NtZ79FvqJ9o2VUGmaJPWpPyn0EBI8uL/vV7S9kQ+nk1KUMaMJ8
         ZlAVhWguDLtGUIkBTw6Qqo7Zzv1jwrNiUgWLVx7PeMYjQUiTB6F/jqCvrDl+qUTVKt9c
         OinEvXVV5OGU/32SlWwlG2/65SG2/tUaJBIVN9cRFX6Yly2vvLgE1dshnw2baW7F5lFY
         efn0Z3U/x9CSSjJCvpmjRANwhqmV7osKI1XQC249/AjLEuXnArzJICqMAc0Ocwl8I8NP
         3guJ9PldZf//dWv5toViNee9Ozla8bJbJrBl5fiqOXElk2yNqUT7Tb7ptVjrI7JDngnL
         BUmg==
X-Gm-Message-State: AOJu0YwMzWKYANl3WgxkEg/47HSxCJRtNLD1pd/jM/H94aH1QYsv4Yo0
	M1iaXpO4ZdDDUbxWsn6z5B2ZMgVvP2CHOcym7MnXVZibpwAqlktfguBP2x5xJjxMYP/c3BHG8eL
	C
X-Google-Smtp-Source: AGHT+IGdpb/Mcd/vUJKJQkPPtMGHs7p45L+IOanobE3WOqEpZpI4bcKftbN9H2yEVq83JAkY8FAH0w==
X-Received: by 2002:a05:620a:1a0d:b0:7a9:c129:5da7 with SMTP id af79cd13be357-7ae626d2df9mr1006563785a.29.1727970202965;
        Thu, 03 Oct 2024 08:43:22 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b29e1e3sm60544285a.16.2024.10.03.08.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:43:22 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 03/10] btrfs: add a comment for new_bytenr in bacref_cache_node
Date: Thu,  3 Oct 2024 11:43:05 -0400
Message-ID: <822af146718551c3f2ba248ba9df9092ba022160.1727970063.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727970062.git.josef@toxicpanda.com>
References: <cover.1727970062.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a comment for this field so we know what it is used for.  Previously
we used it to update the backref cache, so people may mistakenly think
it is useless, but in fact exists to make sure the backref cache makes
sense.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index a810253d7b8a..754c71bdc9ce 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -318,6 +318,12 @@ struct btrfs_backref_node {
 		u64 bytenr;
 	}; /* Use rb_simple_node for search/insert */
 
+	/*
+	 * This is a sanity check, whenever we cow a block we will update
+	 * new_bytenr with it's current location, and we will check this in
+	 * various places to validate that the cache makes sense, it shouldn't
+	 * be used for anything else.
+	 */
 	u64 new_bytenr;
 	/* Objectid of tree block owner, can be not uptodate */
 	u64 owner;
-- 
2.43.0


