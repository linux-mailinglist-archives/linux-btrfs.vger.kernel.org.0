Return-Path: <linux-btrfs+bounces-14146-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29A8ABEA70
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 05:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682D616D921
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 03:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1730722DF8C;
	Wed, 21 May 2025 03:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrGqI+Lv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA13222D783
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 03:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747798075; cv=none; b=EwMgxnk4N0VgKkxBy809fKdqQT4dytruKsV6kUpiuCF5rGSkZK2iTrAcRjGECuIsdrJP4F13f9wyqpsYTvJCICvGrO6ONKevQaEjS4iOe5f4p4FvTvHfeZQ5YCpUeB6g5xpaaftZJqqzxVa45TFQgaSsOjCnaCIMzPgnBUui4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747798075; c=relaxed/simple;
	bh=8rs68pRh9n06c1RemFhjooN883hnQgBOgdlpNP5SuiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEbhaK3Z29HsY+0Kq9l2+GkobfbGGVicC6GEYAn2cwiS18TG+cKhlRiTp1Uo4vJ6EEb+faL5W0050uavx5jX1zR3tgqz9pS8iYUTX3/3iznqIOL2GFE3/KNkFLfULbWT1I3VyxPE0jaWZDjA4oUqZsUM6V+dnkZ0tfXsw4KpkCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrGqI+Lv; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c46611b6so4445703b3a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 20:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747798073; x=1748402873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31jdKbv99U6dPt8XYw+tSqa1xl2lMCAqetEyylo9yJE=;
        b=IrGqI+LviBdls1cbgtDM5Ii+8GJwr8lrvSPL6V6Ily1Cb38g8tydmt6g0qfmrZ3BzR
         1IjSajaNo7GOaiZ1yDvw+qodjuv+vPy8WT/ycgTYVPk3bAhNma9sIqa3UEXRqogRexKW
         LGy6puhbWbMqSk4wpqQjmUDGDNxdP4EGhuQWlAgXkH/cY/NK06QQm+f6zCXav6lIt8Mh
         zQZBz7SVsh1CCgy5hyVvsnV+YFEdZgTQob+OtLgXUAIxqxJVqmlK353erNxhDoh2ACuD
         BKHr0oHpViLmV19uN3KiOmkg9KvJxrFpmpSkOpsClVx/0lHVyNnZScpqeCc2Gpvq+CkM
         L/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747798073; x=1748402873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31jdKbv99U6dPt8XYw+tSqa1xl2lMCAqetEyylo9yJE=;
        b=QMjypEy7CVso/b28D9V2QUptDQ4kKRh9LvqOS8chQX5rtqBbm172zfhYIh2tnJp/LS
         LlHyLhW9RhyxB6vtf679n7fHJUjM8ZLnZHy8lFpnJ7ddMPHy1lUQtjfOTrld1IRLYW6G
         +/3Gl4YMo5WjCb3PFknODYNRDNVkKtcG9hed2o8S1tpKq6L1vzATjAHxvEuLW/A6Vrr+
         2yVN7QNYl9eBABykQuzvVhGu4b8VJ7pg1fghBR5SvIE+YhJK/6Fy2LJIYTSUSJ1A9hnK
         uRu6ou+Ymg4wAksNRCX1/smpeQPgdQAbNhgJcoXMekxUiZSAUOL2tjOz/8Rco9b/D6XD
         mlMg==
X-Forwarded-Encrypted: i=1; AJvYcCUxUPpa47S6E7ZuZ26pz2uNkYS+vgWoSBR8nw4ZmpYBMnK1PWXy2smrUAoik5+Ums8mSX00K9bHiQF5Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCUhXxniwIrLwe4GhPYa54AIHN2PcPQ2dttVXCVeyZAxZa1GUx
	2Ef1VcRGkRkvBErqCca0VmIZ/vqKzf/ID0W8RgXIry4LqDlyPxiQxrnI
X-Gm-Gg: ASbGncujEvO8qVxfc6fQ9IpZKFUATbNnkpQ6+pjrIlLv85rxr891NK9vVjI/3fY+jrL
	+fxAijqLbwwRbNrmoeDuI/RnlFtzt1Rs3NEkaZV7Gk1EMOA117h30Rw6rKtJ2GbfGsHYHabe0L4
	n5oRDe+DFQMaOLDzqGBq+rk4/1YWyjCGQp6hZLz3SRKg4SbYMItN+lgqNf1Lb4BbQYlsoecnDhk
	J8W0uBmgWVpWTmwBOEZs+9Ep0pLLfzwATl19Cb9/xgXKPYUJcjiHTctS2pf8+EOWlDqIQuiimC4
	yFaxtZond6VSfp8u+EWbbieFaHmwfTsI51E/mdeintJEHQO7+dsqs3yyVstdAWupCkZ5xPhegO8
	RQSv4u2z6
X-Google-Smtp-Source: AGHT+IHEYkOmG0stBrmyiEVEX0wFtChBEvYPRK1DCGCb/1a7hwulpcFSt3BZY3lVElr1YgpiuWFADQ==
X-Received: by 2002:a05:6a00:4fc2:b0:73e:598:7e5b with SMTP id d2e1a72fcca58-742acc906ccmr24182414b3a.1.1747798073118;
        Tue, 20 May 2025 20:27:53 -0700 (PDT)
Received: from koga-vm2.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98770c2sm8677379b3a.150.2025.05.20.20.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 20:27:52 -0700 (PDT)
From: sawara04.o@gmail.com
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: Raise nobarrier log level to warn
Date: Wed, 21 May 2025 12:27:10 +0900
Message-ID: <20250521032713.7552-2-sawara04.o@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521032713.7552-1-sawara04.o@gmail.com>
References: <20250521032713.7552-1-sawara04.o@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyoji Ogasawara <sawara04.o@gmail.com>

The nobarrier option disables barriers, improving performance at the cost
of potential data loss during crashes or power failures especially on devices
without reliable write-back caching.
To better reflect this risk, the log level has been raised to warn.

Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
---
 fs/btrfs/super.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7310e2fa8526..012b63a07ab1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -407,10 +407,12 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		}
 		break;
 	case Opt_barrier:
-		if (result.negated)
+		if (result.negated) {
 			btrfs_set_opt(ctx->mount_opt, NOBARRIER);
-		else
+			btrfs_warn(NULL, "turning off barriers, use with care");
+		} else {
 			btrfs_clear_opt(ctx->mount_opt, NOBARRIER);
+		}
 		break;
 	case Opt_thread_pool:
 		if (result.uint_32 == 0) {
@@ -1439,7 +1441,6 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
 	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
 	btrfs_info_if_set(info, old, SSD, "enabling ssd optimizations");
 	btrfs_info_if_set(info, old, SSD_SPREAD, "using spread ssd allocation scheme");
-	btrfs_info_if_set(info, old, NOBARRIER, "turning off barriers");
 	btrfs_info_if_set(info, old, NOTREELOG, "disabling tree log");
 	btrfs_info_if_set(info, old, NOLOGREPLAY, "disabling log replay at mount time");
 	btrfs_info_if_set(info, old, FLUSHONCOMMIT, "turning on flush-on-commit");
-- 
2.49.0


