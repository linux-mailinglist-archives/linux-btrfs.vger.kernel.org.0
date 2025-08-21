Return-Path: <linux-btrfs+bounces-16235-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A498B306BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C2DB013DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2A238F1DB;
	Thu, 21 Aug 2025 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XT3KipCB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B139094F
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807671; cv=none; b=q5zRzgJ+UzNjNIFwVGg8sLXgyCuW+aqHjRrnBuaFM9CoL4yYTtztsHAAEtk5Dq/YSaujYAMYFT6v2bldrKoG9fjDsj8oP5nSFfxICV1IkPTAhb1vQ7RkPhKA1x48/UAwCjRiT4rJt8alvpYNNw9k0DyolrSBTL22TbBgZXu4Jks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807671; c=relaxed/simple;
	bh=wctmqEmUpM1KjsZSQp5EFVFe+I/02AT+kFbU82cRaBw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkPFHFd3PiGV1aY4c35984py4x3F16OLuQZ741UTrx6/Rb13/1/Ron5E3AJ06/V4Ih5dpB6HKWxmqhT0mI7qQSSfLfwUGPdJhLl7hK6VKmFKqBNpm8ap+g1j9FddZG+OxQhmY068+BziiJGidzO+Ip2MqE0j+/3b21n7nVmOcls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XT3KipCB; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e94f5dbf726so1328297276.3
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807668; x=1756412468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmjKaUwpj2DkmXlSJQoP2X7HjPrWpM7VXZkID8fwcAw=;
        b=XT3KipCB2jm6p152EyvrmRuqDRnjVcKIqaBwalMD7j2PyAoVdhlZtb1eZJwVf5A+WO
         PdAyXmiyjm6CzYXR7EUWG42Rm4JE/qM9YWEF0tXQVbP3kBHV98IKnpHgY+TmBU9VpZnf
         fwdbfVwt6AX8etvG9yApD/zYDVUlCGdoO7JXxrHNcRUj6j26i+59jzlCWy+Lsm/DphYY
         x0C3+0JtTbVRjLse7D60UFjkG6k4HGxQjxWzlADS/rfRCtLvh7G/pnQeSZo87xSCuTFo
         UfmmjmLop4AhyXmKAT7yp7/hGz7TZqxvJzZMEYo5T7t+ZTVRtGLGR1JykPAeJW7gvb4J
         qXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807668; x=1756412468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmjKaUwpj2DkmXlSJQoP2X7HjPrWpM7VXZkID8fwcAw=;
        b=sXJIy08H2E53uauy1kqRTUdA3QH4KVXCqNySEOfmXEo8mmlJT0CTLsQU0O2e0M0kfm
         ATvHmQnwcigwnCW7nCSfkaQNE3pGp9Wf2OQeqvpI9u6ZhGevOk4tIb3ZM/rEIdwukY2m
         vZL4bL27JjHa6Nho05t5adhhAeU+A7PRNtwX4hGFH8h7OrmUrMkREjttXVc7qTiB3LDN
         62LQTKCeQta6DmmrKVSPYRuDMdOiZZ8rWLHsYooF7EFeIIY7So1EfB9LzqQvQuD1JeKI
         9Os4yofFb109UmYH5wuuXJSj0Hy3rnLz5v8rMt0HVArkPh+PcrnsBjcxHWt1kkPp5Agc
         jo5w==
X-Forwarded-Encrypted: i=1; AJvYcCX5BcrJ6JIj49kuh0JnPaoV8IjT7/WQWBeF7E9F4PQAeBOHOPWlDBf+eX60qOXqRRS/ljxQs8DULqu9vA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7QW9KSviX2J146Tl7z8zPKV/PVKuUxapk16GvJoLW4u/Q1Cdt
	h63aNxmPYd/ctMhof7zQpkRCzNCBZdGbQdfB8K8wE06jsP3tkzqqhNA3npMyr3VbmBs=
X-Gm-Gg: ASbGnctpit1j28crCgOIsoRrT1vhueW4YT6+RDlcZ3tdJzsjJI0shQtvdsDMSX5kzhj
	YsDbE6yHmj4T+/TinUJLYiCAFjzA3iR/TQC/g4hzwCymvtTjQyPIubG9i9wc0Z2L+YUB/aGWUmT
	YiTG/4e11GktfE9EZ6K/eq9xLR1FbqIiy2MHU9VUZbcGZ9ZrbxUXKNseRfVNsfl0X/JE1VMn86e
	B4H6ixtjAjpTenlA/ImOj1hgalwpg4azduw7GNDVow+ZdPmac3SICL0Wo17lBc7wztOUfI5ExRI
	eDH7nqoWVg8KkIx5pPbACrACMqxRSh5N/a9E8yCZGSJCSZ+0gGciCxHTya80yWI05wDtmY799ZC
	VG2PRZTTeKyYEhKeNzCGuBHKXrvq/ZjEUsZJmsoh4t+V5/FD6AyhKCiU2NyY=
X-Google-Smtp-Source: AGHT+IH/T0dsDptJxPlJ9vX/O/NjsuJx3EIZW8Vubo/2lIk8PPtNqr+h2Z1PZdabpWGsbTrFvzNw7g==
X-Received: by 2002:a05:6902:6c02:b0:e94:e1e5:377d with SMTP id 3f1490d57ef6-e951c2da511mr1105376276.51.1755807667754;
        Thu, 21 Aug 2025 13:21:07 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94e3942c33sm3133839276.28.2025.08.21.13.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 34/50] ext4: stop checking I_WILL_FREE|IFREEING in ext4_check_map_extents_env
Date: Thu, 21 Aug 2025 16:18:45 -0400
Message-ID: <0350442f4267245bb0104506c95c05a1cc42e96b.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead check the refcount to see if the inode is alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..7674c1f614b1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -425,7 +425,7 @@ void ext4_check_map_extents_env(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) ||
 	    IS_NOQUOTA(inode) || IS_VERITY(inode) ||
 	    is_special_ino(inode->i_sb, inode->i_ino) ||
-	    (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) ||
+	    ((inode->i_state & I_NEW) || !refcount_read(&inode->i_count)) ||
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
 	    ext4_verity_in_progress(inode))
 		return;
-- 
2.49.0


