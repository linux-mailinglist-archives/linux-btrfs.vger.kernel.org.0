Return-Path: <linux-btrfs+bounces-16244-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47B1B306EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB08B726E58
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7653921BF;
	Thu, 21 Aug 2025 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="mHgOvNMB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765DD39218E
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807683; cv=none; b=ER5iG7Br3WEgBxuXiw/b2nssIIord8mOsyIF0KWbJvZcoiNOWM+CY3eFJ9m6y3QtWMPVKqUap1bEMZS0D3Ab4C6nZIQwTsdkgOLNMJr3uGDNZv/yvYt10Un0gdTMFE93FTPvKn4oFQmGcMvIFDRrWm0ooHDWPKIwTbJL9P/feec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807683; c=relaxed/simple;
	bh=dcsAxEHT5Jq2nRSpkM5+vx6RORRZ4KO+wi+OUDbhG0Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2aQx5LVDbWnN6CPMPplKDBlSAVPdlXqTFqwbBCc8O0vLOOJlEqB5eMgwdH2meEzBu5zfvRoE3TqTxYYe4fd8C+GSSPyZb01qgi78OEdsUeJQvZ77o9neKDybPrKsD7h9w1gcC3yg8IsiDbWzwPRYVWeh5FQHcw+077bonscj30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=mHgOvNMB; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71e6f84b77eso12796037b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807681; x=1756412481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AHd+4Vz7kPVwWP6qqpZo346lGeZ1ejCBP7K3x1LyEEE=;
        b=mHgOvNMBzYdTWyof322s66jOucc2q08/MzV/xZ6yIs68LuEQFsPDQiKpgqruUbkZVZ
         QJLfgykxXhhEo7I5B70Qd/tJbXqZFpoqO7VYZEDp6/EcYsuRR73OTOK0EXx7qqrfcOkJ
         0lDLZNuvSklFEAkeYMR0KAI3xpEShNzf+uNRLP+J6b/cTnn7NE5jeQWcghM/02+jNR2K
         RvfJH4vOJlZn7E4OfDJmJvvctBKIzcD5AimKMQdJvO6VqjqVgtpLbVr+5Bvx4abTDvPQ
         k7I3dkzfPrcJTSyxLEeA8Y8IWZN9kE4yqly0AxznwrI2MH5zHV+wgurMMKRXk8QSMtma
         FwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807681; x=1756412481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHd+4Vz7kPVwWP6qqpZo346lGeZ1ejCBP7K3x1LyEEE=;
        b=s2ylHc9jG/z8N6ueVe2fEeS9daHbW5i2Nw1YIrMMngrkLURliofMtmcz5Suf7Uxhee
         AHdscmFfNreEB6Y7J1QzPMwvdyyHpa/ue5v3puiY2cBBdqqQmjwYWypeNwnmXwbryV+9
         ioTvu/IHPNzk6DSc+A2FsekvHIzeYPhDdpoOdfqSFP1EUZdBOaGwv25e3bVcdAyuk5XA
         maCrJf65U1cUJ0og/jldHk25vd2k4r9IXE+toPOJyNQ8Aetdwx/nHMBERTUzYnTZAJoa
         XiVlNV5kwWt/6fkXwMmy3gS7cSpwqawYWx1DE9smOcfamSj/tv0NAAHwFlXERJLxNUHJ
         5I6A==
X-Forwarded-Encrypted: i=1; AJvYcCW2bItFVFx2LGrs79BOHOHwFXf+us1fcehs7fJsdaSwkb5RgP0Gi6hYEvy8YMFN2n03mcNxG+lLElleQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoWzm/8c9J6jVFlHWcL1wLcaWSPlu66nX6b0ScKDmRIGA3O3MU
	wkkrPWjvGFmUXQpO7v59+Ffqes876GMJmAYY8W7zhDuouoaNv9oKkTZQYQVSKVtk/Vc=
X-Gm-Gg: ASbGnct6b8X9ALpfbkLRwSz7tz5n64h+Wz+tJCDNXTs8PE2TTIcggI5oUNF6Xo9s4nZ
	zihiMkviCVl7xoWvOXJ5SCP9tU+A1S6vCMWKI8hgPKGLaget1ADg1ClkwL+BqgrRSHPDDHtVKGC
	m7ViZBdU7rXwpfOwIvCR6oBFjIWJv9kfDPFGSGPua8f2faH5D75n0fWnnZ9qAZY7tUXHLCBqenU
	2xvRGcylsxOzlEtvUKv1EqYCdrTz7meJ432HntpVVxIXTeclEikzbUVfEJRBJ9hTkGet4IAI61s
	gqcY2IFeHryfhxJZSKBfh/MiCELw+2B6OYg9QPhuSn3jQRkjCA9m85Q0TqWLPltWIazZQtxJHLF
	vemFGnyN5O0mn43NwcPRXRBWQUU5VffBXGoXdfQAHNEbCRwzxN9RYB205ONsx7zs8QElKbQ==
X-Google-Smtp-Source: AGHT+IEzo0QXY9VIuY4baShzyB2YhjsCyUBZU5mUEwfUAhGbJD1bAOOlVU8KN48xmuT/FokHR6oSiw==
X-Received: by 2002:a05:690c:9a11:b0:71a:a9c:30de with SMTP id 00721157ae682-71fdc418f92mr7089417b3.41.1755807681418;
        Thu, 21 Aug 2025 13:21:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71f96ec62cfsm24521717b3.22.2025.08.21.13.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 43/50] ext4: remove reference to I_FREEING in inode.c
Date: Thu, 21 Aug 2025 16:18:54 -0400
Message-ID: <ed4673380176f640f0d33201387999207dc1426a.1755806649.git.josef@toxicpanda.com>
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

Instead of checking I_FREEING, simply check the i_count reference to see
if this inode is going away.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ext4/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7674c1f614b1..3950e19cf862 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -199,8 +199,8 @@ void ext4_evict_inode(struct inode *inode)
 	 * For inodes with journalled data, transaction commit could have
 	 * dirtied the inode. And for inodes with dioread_nolock, unwritten
 	 * extents converting worker could merge extents and also have dirtied
-	 * the inode. Flush worker is ignoring it because of I_FREEING flag but
-	 * we still need to remove the inode from the writeback lists.
+	 * the inode. Flush worker is ignoring it because the of the 0 i_count
+	 * but we still need to remove the inode from the writeback lists.
 	 */
 	if (!list_empty_careful(&inode->i_io_list))
 		inode_io_list_del(inode);
@@ -4581,7 +4581,7 @@ int ext4_truncate(struct inode *inode)
 	 * or it's a completely new inode. In those cases we might not
 	 * have i_rwsem locked because it's not necessary.
 	 */
-	if (!(inode->i_state & (I_NEW|I_FREEING)))
+	if (!(inode->i_state & I_NEW) && refcount_read(&inode->i_count) > 0)
 		WARN_ON(!inode_is_locked(inode));
 	trace_ext4_truncate_enter(inode);
 
-- 
2.49.0


