Return-Path: <linux-btrfs+bounces-5889-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DFD912D92
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 20:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574A91F27067
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 18:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE0F17BB1A;
	Fri, 21 Jun 2024 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="zBUJH5Ff"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E825E17B4F5
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996031; cv=none; b=IPrq4jyIMLjfLrWDi2yb7F/HngtWM8XT0tSCb+orTHo0qJap7yG/mEL1IGn4Kz5cf0rhMmJJdkq/t4xXIBBvgKsh/tjhAzNeP21xqR9QuwR/MiJOCGLliTLXdwUOMSzy5DkOmLrMQiaJkKHOBQYU+kPQ5RXb7WJzFT5hH0MhuQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996031; c=relaxed/simple;
	bh=DAs/KHlPlJylDtA3i8QkEZi3lDXyWQNuRt2Ir5amGp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUg5YbXyNo3CUyliUDpyR4VyAeG1NYbjrZdmeN+Hv+3LcAn9LQmIGVlOCN97atn6Ykbwvk4MH7wfzfcqboglQgtTVlGo+sn8jSNqi/GFiw9vevVtSX1MdxaB0V5/M/RbULzHNh7N8iLg8DRcd+ruwSAY2ILdyF0fbqO30/LDDQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=zBUJH5Ff; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-656d8b346d2so1659696a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1718996029; x=1719600829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQjkzlOCZnYIcVoa6qmMPhrJqyQMB6Ts4hOZgl2irr4=;
        b=zBUJH5Ffw9W2LSfxqgU9FPZLOBX217SvQcqjH7WccOAlaqDxklgtxofbjaa22j2Ey7
         nsLIMz0K2ITF9oc8YE7Uj363nORGkfqdQf4GjRtCZjJ0o53QMRn6ep+7pi3kX0/nSqY3
         adqx1t4rNNVfarqQRy6h+h6u5E5xnz66QN2PTQrX0LqnoaFiYjU2CoDJat+0RKE+jEvy
         gkExXYtwIO9JpWuJdvqWCkLK1BNisTGnhJlJ1yg+dszla1uY9u28/BNGA1XgQu9SkU+r
         ENmVBArzCyBgQgCK2Q8tPwftPVTMkJ+WeZ+M4Mj2zizqvsKRaoq6d6NlUZSJDJzhHbOg
         v31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718996029; x=1719600829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQjkzlOCZnYIcVoa6qmMPhrJqyQMB6Ts4hOZgl2irr4=;
        b=Nn4OYtiC0TKf+6XZaAhq3WQ5y2boD28N5vP2MqgubYZSEGUyZ8yeG4p1NSALz4h3R0
         PSZJf16kt12oOSevjyWzFyXmZUluIYZY74l6ocLUE8hxw6XzRL9FRa/ExBAQAUpUYnJy
         e1c23XvaE9z8acbZtWNMJnGo5betjeGDNDfetlCf0jPXGr62a+iFwBqqueAKdHqcNDn7
         P3PkHe/NbXzIX11PET/FNr41d8kyA+yA5UBqSXe/eFZAWcL00qr1ag2fPBhDcu2zkDpf
         aY9/IVi0fb28P2ugncj8nUbLlP1N+hJJjTwSc/VEfjaPDBrb9hTIVdKw6KtBq+rPPhIw
         fJfw==
X-Gm-Message-State: AOJu0YxMXTs5eUxLEV30IFuuRqNi33ZeLx0VK14ah+ZJ+oTvVjSfrBit
	tT3AQOxAfpvuaYSVp7mQxGp+3Bksx85M5WqO4r6ZJaKpUkBR3j2Z0vyzbmzeCZ032UtNWTUtEbI
	5
X-Google-Smtp-Source: AGHT+IG5jMMiuiV9x4jHdJiO8qLOJxejtKkJo+NzeNflWB2PSI5y9RieY5TWxHN7wnc8tGY8SN+Hhg==
X-Received: by 2002:a17:90a:5d81:b0:2c6:f21d:8d8d with SMTP id 98e67ed59e1d1-2c7b5dc76f5mr8338570a91.41.1718996028588;
        Fri, 21 Jun 2024 11:53:48 -0700 (PDT)
Received: from telecaster.thefacebook.com ([2620:10d:c090:500::6:1ec7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e06e7sm3957366a91.21.2024.06.21.11.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:53:47 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 1/8] libbtrfsutil: fix accidentally closing fd passed to subvolume iterator
Date: Fri, 21 Jun 2024 11:53:30 -0700
Message-ID: <85517de7964d1e062789d024a803bcb7ad415b1c.1718995160.git.osandov@fb.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718995160.git.osandov@fb.com>
References: <cover.1718995160.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

For an unprivileged subvolume iterator, append_to_search_stack() closes
cur_fd. On the first call to btrfs_util_subvolume_iterator_next(),
cur_fd is equal to the fd that was passed to
btrfs_util_create_subvolume_iterator_fd(). We're not supposed to close
that. We didn't notice it because it's more common to use it through
btrfs_util_create_subvolume_iterator(), which opens its own fd that
should be closed, and because the fd number is often reused internally
by the subvolume iterator.

pop_search_stack() already has a check to avoid closing the passed fd;
add the same check to append_to_search_stack(). Also add a regression
test.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 libbtrfsutil/python/tests/test_subvolume.py | 18 ++++++++++++++++++
 libbtrfsutil/subvolume.c                    |  3 ++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/libbtrfsutil/python/tests/test_subvolume.py b/libbtrfsutil/python/tests/test_subvolume.py
index 690ff107..1e7df00e 100644
--- a/libbtrfsutil/python/tests/test_subvolume.py
+++ b/libbtrfsutil/python/tests/test_subvolume.py
@@ -561,3 +561,21 @@ class TestSubvolume(BtrfsTestCase):
                 self._test_subvolume_iterator_race()
         finally:
             os.chdir(pwd)
+
+    def test_subvolume_iterator_fd_unprivileged(self):
+        pwd = os.getcwd()
+        try:
+            os.chdir(self.mountpoint)
+            btrfsutil.create_subvolume('subvol')
+            with drop_privs():
+                fd = os.open('.', os.O_RDONLY | os.O_DIRECTORY)
+                try:
+                    with btrfsutil.SubvolumeIterator(fd) as it:
+                        for _ in it:
+                            break
+                finally:
+                    # A bug in SubvolumeIterator previously made it close the
+                    # passed in fd, so this would fail with EBADF.
+                    os.close(fd)
+        finally:
+            os.chdir(pwd)
diff --git a/libbtrfsutil/subvolume.c b/libbtrfsutil/subvolume.c
index 6b2f2671..1f0f2d2b 100644
--- a/libbtrfsutil/subvolume.c
+++ b/libbtrfsutil/subvolume.c
@@ -930,7 +930,8 @@ static enum btrfs_util_error append_to_search_stack(struct btrfs_util_subvolume_
 				return err;
 			}
 
-			close(iter->cur_fd);
+			if (iter->cur_fd != iter->fd)
+				close(iter->cur_fd);
 			iter->cur_fd = fd;
 		}
 	}
-- 
2.45.2


