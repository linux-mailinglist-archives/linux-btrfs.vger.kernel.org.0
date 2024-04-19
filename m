Return-Path: <linux-btrfs+bounces-4449-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BEF8AB4F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0438C1C22291
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A6313CFAC;
	Fri, 19 Apr 2024 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xIPam/Bh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100CB13C3E8
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550650; cv=none; b=pSpHTAq/bGEr0Bk3+1pI2xTzDLiLWh7QwZJNrDEhRDNKBbTkVj3PClk7GnYPSb/U5zF9aNz+rytJXMyvElGLAajU4rurS6c9G8cpR+v3MwYrZA9KVzc/zhYlqtTe/WDh2duSeB9eOENQVo1L6XqJrBdQYeGsVNgP/BhqVRBQovM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550650; c=relaxed/simple;
	bh=kfeMEiRytq3vpjK7OzHldK/rtKP/mp24qM3MnRiQk2o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPjRkjWifDN+790+Mq9RMaC/WPgzAS+FLoHdwU1Gqx5L9GYSugX0NWbu0M4CWWFrOAROPljyLLLHs6Qxxaggs4ew97nVHl15YDveqvQvtNI6VTTqMmB8KdMqR406J4L+SvFjmxaHz5l9HZgibFvIHEgItTNC4W814+cSGju2s7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xIPam/Bh; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6eb7b6f92d4so1362987a34.0
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713550648; x=1714155448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZtEfhFX3Urpiq626sdyXwfakzghak+oAYfCpY+UyvA=;
        b=xIPam/BhNQiEw65nbwm1isaeUsalspaThZpEc8wBt6M1LEuB9ft9A4iv0dZLu0Zf14
         RU4i+u0En9ewf6EZvx+ykyexFP1zXSks5uX4N5Xa7owkUuROBemn2OOu9zF21ccT3Ef3
         TRYC2vGFikZdGvmP2VVSLZ2N6J1drTe/vQ3u9JmA90XIgCwTN1EsN08qh7ipB5Mx2z5Q
         GA8HV6x2QNp3YGGbLFHajc3JpwXeqTL5C+t+f6pD6rHdKGXKJRxYUMWDxSV1oiJYwhDv
         kSA5xs/oHtTBMB8nHw/rZx1+fEOn4LRM984A846O6L+23ZBAvf0r+fkoUzhZpR5XpgON
         EPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550648; x=1714155448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZtEfhFX3Urpiq626sdyXwfakzghak+oAYfCpY+UyvA=;
        b=HwqHE3waC9Za9j2IXdeO0YekGtjfI1pXJRkhpvPZQU3nhJ0JM6J3jGfZt2s1hilA5v
         B2Sf4RbmHMTy/MEIuBIH5HmAYodIrY5MIg1aUkcrOYx2T/NkspQUSDwNoWoSG4lskT4c
         IhP7d1S1QAStADtlgDAAyQ/Q8hSOxCK8B9q9rGNJ9hu/VrvPCGnt3WrxLmDpY16JZgcG
         tfxcSdJ6lfiiH+f5avRbzEQXX1dYTDtnC0eYdSu514OY36Q1E1VBrCERgPw2Qq0/G0qD
         zJHCOTR7yKNhJ9m5IMGxMJw8HunTAssPQQHQZ3pdSYkboUKmA0HP6wCLJJCrsTNEWuIi
         RCcg==
X-Gm-Message-State: AOJu0Yxz28w7hknD2b6QmbtOmwyEsO0Plc7gdZ1p0hwYrxi33zwVN5pz
	R6JxqXtnPwtTzHvbLm67Khrg0Cg58SRRdMNfU8kV69+FwTrU3FIhm1qoMMmcwxW7ZLBd4YXAQ6L
	E
X-Google-Smtp-Source: AGHT+IEN2UkUj4uanHryI7xMz1WbP1qmtrlbiIOS5ypqbF+LY3btMvO3Agv1YksSK1DnxKWUuJ882w==
X-Received: by 2002:a05:6830:d2:b0:6eb:ca3e:e2a1 with SMTP id x18-20020a05683000d200b006ebca3ee2a1mr3094678oto.6.1713550648122;
        Fri, 19 Apr 2024 11:17:28 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id bi39-20020a05620a31a700b0078d66ed5e41sm1787371qkb.131.2024.04.19.11.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:17:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 11/15] btrfs: replace BUG_ON with ASSERT in walk_down_proc
Date: Fri, 19 Apr 2024 14:17:06 -0400
Message-ID: <db0f49495fd0daee4df5a869edea182774890c46.1713550368.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713550368.git.josef@toxicpanda.com>
References: <cover.1713550368.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a couple of areas where we check to make sure the tree block is
locked before looking up or messing with references.  This is old code
so it has this as BUG_ON().  Convert this to ASSERT() for developers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 889e27911f0c..43fe12b073c3 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5393,7 +5393,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	if (wc->lookup_info &&
 	    ((wc->stage == DROP_REFERENCE && wc->refs[level] != 1) ||
 	     (wc->stage == UPDATE_BACKREF && !(wc->flags[level] & flag)))) {
-		BUG_ON(!path->locks[level]);
+		ASSERT(path->locks[level]);
 		ret = btrfs_lookup_extent_info(trans, fs_info,
 					       eb->start, level, 1,
 					       &wc->refs[level],
@@ -5417,7 +5417,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 
 	/* wc->stage == UPDATE_BACKREF */
 	if (!(wc->flags[level] & flag)) {
-		BUG_ON(!path->locks[level]);
+		ASSERT(path->locks[level]);
 		ret = btrfs_inc_ref(trans, root, eb, 1);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
-- 
2.43.0


