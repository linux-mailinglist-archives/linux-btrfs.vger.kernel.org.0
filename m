Return-Path: <linux-btrfs+bounces-4447-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6428AB4F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F151F21099
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D3413C3FA;
	Fri, 19 Apr 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="U1sY1Xx1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94713C3E8
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550647; cv=none; b=ZmjI9JLlpxtl6S0mS/Sy1gFoTzfbT0u4iI2DYoZ2k6o8LwQLVg9p2nRQNaETvVm+Je0EjYd77JFTJvVxrRppEc8JMZW7MUC8S67gIKD3iRGrHge2XSq21i1dZoSW4rF/jELZdMCKKD8T+OJmMqh5trLpND8TQlQOtME77m60iCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550647; c=relaxed/simple;
	bh=dyM6Q7FuZh2qz7JtsaFVML21R+zbmgVnIudXatb4pM8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZj5XmEA6vjFxofAZQtiR2FAtu8oJn7UhL0Dvmrrj67clmRTJFRhdefEiZwvxwC3iSbiRKR0q8dYYA0bdomnlmAZKNspSuFq1pznY9nTRwALEnDaLGQwmIo+tRClEIwgI0RY2nNDeS6kcq6ZnaeJLocov8g/0SDiy/MFfeA8/vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=U1sY1Xx1; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78f0628da1eso144958085a.3
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713550645; x=1714155445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QewteRjjwSIaiFQHtMZ+y+ny01dS+MURSIocHi0q58M=;
        b=U1sY1Xx1MRhYriHnRJwD5Ar5jqWJGHZr5WkGEnkvn6RUrfOHAL7iS+VTG/Q0XC/p/d
         xRrzkOL99ab14tvT1Ti1JbCx4HG9w6JqYT81ze/8UUdl5mnBu3lkPeNw922f3Np5FoMK
         XmPCfZ1ThVuA13/xmNliLMFK0bvFrPBV44QIxgjInKDxk8fHeR4feYsR4vp/VVU7Dl4c
         Er2f7V9uLBSxSx0bzmnSH0rlIWepGV0ehf8KVbr+WoCulh6jZWHi8Df5/Vl8ilG7C+M3
         0+8eAQBffgoQSpKQ3f/mkpY8dkVENgtalmMwce2tyhnDF9k94Ul6B8go3h7DiLBJLWAC
         4pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550645; x=1714155445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QewteRjjwSIaiFQHtMZ+y+ny01dS+MURSIocHi0q58M=;
        b=p8x8BE0fPgFou9KjlIym9KCd52A+dYKKolDko3PK6zc5ULYMCGJxQK67WZfImjoqMo
         JYkBLVY7hCn81ppotaBy5+T2PoW6CK2Z+SQPzzRNG59RNgIGNwT4xDtKaLT51XDYlVJB
         oOnvCyONWtsPiJXPd7Ymkd1NmIqy3aUIIpMPs9LycTcFhbpH2D7OfzCRrvr7hWlLf5V0
         0zDRgy0ul5/z3fFgUKkzbF4H0z0/9lgbsscrMadN1bVjm11geqtV8P9eZdmJQMpwA2DF
         kMHVdF/mqRKowj0cFbQBJlYGBeodJo3KsoL+n4p6uA0TJUnh6y2uvnwKn322jYdLGdGb
         ykBA==
X-Gm-Message-State: AOJu0YyR6FBy13wagPmpS52cXrK9feLtS5CTd/ld1wsE2VbWTv278QuX
	O/imU7KlmP+JevJTuVqn4+Zl5FxS1NLD2GsRLAIj05ehYLYAGdg1c8tuwXTxBeCMZ4WI1VYqZZF
	b
X-Google-Smtp-Source: AGHT+IE1re+avLkgguPRpPYJAk9xai8qkh2Msq7WCGlFJIlDWEkmme5GhihICFBQrk3E+K3kgZTBug==
X-Received: by 2002:a0c:f548:0:b0:6a0:5ba9:140b with SMTP id p8-20020a0cf548000000b006a05ba9140bmr3045314qvm.9.1713550645549;
        Fri, 19 Apr 2024 11:17:25 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h20-20020a0cedb4000000b0069b1ed91846sm1416846qvr.143.2024.04.19.11.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:17:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 09/15] btrfs: don't BUG_ON ENOMEM in walk_down_proc
Date: Fri, 19 Apr 2024 14:17:04 -0400
Message-ID: <1d39470100d7101a6fbac12de8fcf8de519ef7cb.1713550368.git.josef@toxicpanda.com>
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

We handle errors here properly, ENOMEM isn't fatal, return the error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 17dabedda997..61bea83bce19 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5399,7 +5399,6 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 					       &wc->refs[level],
 					       &wc->flags[level],
 					       NULL);
-		BUG_ON(ret == -ENOMEM);
 		if (ret)
 			return ret;
 		BUG_ON(wc->refs[level] == 0);
-- 
2.43.0


