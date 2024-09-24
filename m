Return-Path: <linux-btrfs+bounces-8209-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FB9984F0D
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 01:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82731F243CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 23:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A41189507;
	Tue, 24 Sep 2024 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBGEvuQj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CED146D78
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727221401; cv=none; b=jGgu9+AfX2q6DB/qLzIl6F4FObfDzEcRhUre/qyUSUz0IK7y2TIXXqOuXPMvfurdoKeC/HiqVnpgcM5YKmPR5648gbRgxbr0PJDnU6jJ/Y/55bGPOf/82eMvaqmq9hTXRZlfrKe8XVOxYhzHGiPTvcaVmOHxZpumYl9EMQ8nMYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727221401; c=relaxed/simple;
	bh=UOdKjoJ8G/P/34lTE3hG+Ao8kDIWabtoYjT7neyb0Sw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OzsLMxCpcTWNdMU0UUOVWomIKBG5cab5G+djOES7q0J1pKHoFFWklG9E6Fdi9KQQXckgAgQFiU10I4DsLl7+fQpQVVERP4pCsRyMY0qHl8MqwWGO0aHZGfqnl6fHPvylBz0liDSGIwD/ohwpXbBv8t2Uk9p0zob2yw4jCMAzcuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBGEvuQj; arc=none smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-5e1b6e8720dso3391738eaf.0
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 16:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727221399; x=1727826199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nu2paQ1eJKManWqXeIMgW1itzc8vRQa0qs4LumNxTpQ=;
        b=GBGEvuQjM/Q90U5gf2tpWtApevGNdltM+AkqPuNltgXfkWEls5ZHvyFVOEo9xGSOz0
         e7TSCxYa7tc2La7DK+qCGRkZ3hJHuKpRASLRZKrrknWVBwybXbNpnz43Nc4CluzDirS2
         4jg/86Hlse03HesxMUYLBERAp4AsVzHY3DL9Eksism+8+DbVGCzcUnigeXUbf3mkUD+N
         QagGcb+Bb/i3RWUrzw6GA7OBsT4kWjQzIBsfIW2QKljIzzBwLlw6m7AZRnx/hLgvLR7p
         OqYpVlaTGG5tvvSGu9DiOrLC0nrot16tStqIzglS0qWB6Ixx0GqIgzXmM6ZD0udDOinz
         y34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727221399; x=1727826199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nu2paQ1eJKManWqXeIMgW1itzc8vRQa0qs4LumNxTpQ=;
        b=rrc/W2uBo4J+CMzvEBcMwZpgN0Dh4xhbr1aWo62ucUXLZBq/B6W9bbNrXNi2oQnF9k
         Je/u8U6hFTZQxtLnSi/r4xK+f6Fs6E98yGWO+59/6xT691Bk9PwOLEGNZdqhLxqYa17f
         QFVA3KutKvbzrMsYgjUF5WmPsa8HT9GM4c4xZWvzzJwCRkezr+620TkwdNsq3oA0wroS
         LDzQ1QeKne5F9/3qV8cFCtDE3TDj7uVVz9vuwY+uItWFae9NABIbleynV2GJAIrz3Niv
         HRJ5n6ZH6j96s0Wn+WqxpwHAhMmLtDr4TLvBRkZoKQoQTMAdC+pqw8Hki81BJ7R6KwP0
         O+Pw==
X-Gm-Message-State: AOJu0YzL5VnFFMCQNRUegmlgWbdF8Pm3CG7wTLuA94zZJ6lVKIgwaSUg
	oq5AuXLuUd81N6cz8+ju+sKNFUFirlURikAfnTAbjm+B09RbMipExW1y61Y+
X-Google-Smtp-Source: AGHT+IGgwjnsVAsFi5kxwjIi4jywKtmhwCFtJC3ZDE3wPofNHgB2YsIsONMwBGw6/GPwRiXELHTKAw==
X-Received: by 2002:a05:6870:3329:b0:277:d932:deb1 with SMTP id 586e51a60fabf-286e13c1841mr1001632fac.18.1727221398777;
        Tue, 24 Sep 2024 16:43:18 -0700 (PDT)
Received: from localhost (fwdproxy-eag-112.fbsv.net. [2a03:2880:3ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-283afabfcffsm938613fac.58.2024.09.24.16.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 16:43:17 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: disable rate limiting when debug enabled
Date: Tue, 24 Sep 2024 16:42:29 -0700
Message-ID: <a0c406abae81f2824ed822ef7f5e85650d8424b1.1727219806.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable ratelimiting for btrfs_printk when CONFIG_BTRFS_DEBUG is
enabled. This allows for more verbose output which is often needed by
functions like btrfs_dump_space_info().

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/messages.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index 77752eec125d9..363fd28c02688 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -239,7 +239,8 @@ void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	if (__ratelimit(ratelimit)) {
+	/* Do not ratelimit if CONFIG_BTRFS_DEBUG is enabled. */
+	if (IS_ENABLED(CONFIG_BTRFS_DEBUG) || __ratelimit(ratelimit)) {
 		if (fs_info) {
 			char statestr[STATE_STRING_BUF_LEN];
 
-- 
2.43.5


