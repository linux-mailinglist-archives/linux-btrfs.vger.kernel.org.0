Return-Path: <linux-btrfs+bounces-16417-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66345B36ED1
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9DF1BC1164
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86FF374261;
	Tue, 26 Aug 2025 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="CcXmBDoi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD2F374265
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222925; cv=none; b=C7xof9rG9ufguqs7TL8zc3rxmUrEVQ+ZMXJd2PHwkkbP0e6mTtFI9F+J+P7FF2EQzWXkVlK33Pd2u6UX4DZ4U+NGD/1sZ5m05JtgdY/w/ac2ZO0/FI7RfFELbNkg8epxfAICbee+ms1V9eE5kcxQWDzk84HmkjX7Oan03Wi2EOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222925; c=relaxed/simple;
	bh=K7JnBj/EGzyS1OdbBFrvkh4RZsBpYi+IyFwAgh+Lb+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sh3jWAEGSgS1n1WSNklIy9nKIJdwGaxnuMq79zldEpbIJ10y5MElKVMrkZFRs0L2OIHfMSMTJTonzxVMahf1xdxWTUaJYZ55deNzaeyhGe9ZRLRBulSUfRshfe5kdruvQJA2z2Q4T0CEVkadPgRQCsDf5aSrCr/7pWjdiP8ZXMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=CcXmBDoi; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e96e45e47daso349565276.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222922; x=1756827722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXIzcijPr4pONzroTEWGlRY1GomK1Uf0HH+VMUMLr6k=;
        b=CcXmBDoiH7UHwsRT60LSrV7SmnGq9uE88meV7SsSNmbGtSiB0MaDV0cz7q/u4sTW3Z
         p1nhA1FYvdd068iSgfZ8hHeMRYbsxtC4YPMwMv6pH5nYjx00Cu8JdDmqCF0Esa/ngR48
         e1qZRYwUBc4t//MSjfW9+RKVB1nMOcsDzNR5jIAe0iHgoH8MVAivUGYpr284edYy+6Xz
         Yl7oj2ONs0ldfR/rfuoryj0eRbsV8IztfW6KjoMasPBSsDLTOJEu2bbV0dVye3MOTH8A
         azX78hj5p7p/kD7w0ILKWjjtukVP102afjtCQYN5XITRQIXWjO1W9yMZpXmA8XFvwyJa
         R6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222922; x=1756827722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXIzcijPr4pONzroTEWGlRY1GomK1Uf0HH+VMUMLr6k=;
        b=cjph3QmxDIPMTruz95WIrKFBMqFAZb4Jc6UMfdSbXQ7wc6zp2Ae0r8KVabqkVpFBhh
         +2boVvCwFfyP1F5Ex+TELEGL6m0NjVzR3msTt5urTENsJBgsU8hiKmk7OQvKE6AJ3mKi
         P7ij0NcCRavMSch0Z2K9nx4WDJ99eTKneTWzr0xOSVuXrnhsnDBII17/Ejv1FNHiGhyN
         HiEYH6Ugl6gvZ2b+tXStYSyepYQXyAYVdeUf9ZEngr53tyPFObMwxK1STjhYW5uvJqoe
         hTZL0QI48TEs4gvDjX2EFf/yBKjeC2osypfccCRCGB3q8/H+hfCjX7+7DpVsEe1aIefW
         Hptg==
X-Forwarded-Encrypted: i=1; AJvYcCXr3+YCFnFNGU296/mdSKQHASkNcAYq1ZfJZcYOBGDQZHwTXo17oNDo0BVDzxz1Fl9Ts9pv/1B5b3qhTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBpspjpUzaLZP4YF3XF8kHAGAI4kibCk3KC/JAXqEJT8qD8HKg
	Psnx674Eg0vDjWeVTYHQm8r0rgRam42Kldj/dvdsGKQpjAwu67frxQXEEqRb0Yao3GE=
X-Gm-Gg: ASbGncsbkIW7KerBGG6SB0pghK5PwtQtQe4R9RijqX3qcSaI5LVPmiA0bHDRDyJHiGL
	NRB4apxdDevL2p6qaGuqF2W6pPSRq+z0Tt2qxUDmAaJw7NxXvQWwfRZnidf7Q5tQPvxN8X9nyZn
	BlrOEdSheUxjfELyf1kGwFF8NYpdyzSYSl58VfSK8QAM1Z9IQ8XUJQZwBQwV5TgVqQhjuPpQ+CW
	VqriphSD4iw1Lov11s3K2luN7VdkfbYOv+P5uhaXGsnHkRyqbPVhO4e0LGVEmYO+P9q2wPGHm3T
	PE2zpbP/SzUqIdkllr0QVsdR0puA74bdK6iGCISVHDR1vxYxmWOEixngcInnBPiBSGvI5kI8Rz0
	+AtI/SoStWpOJv9QhO2SKY9KAB4Bi907qsVizDakskm/PXxJdbZ2K8eknL/Q=
X-Google-Smtp-Source: AGHT+IHBtsQWSCLpB7xIpgRX+GYPCXlwVtPiwWdiW8tSSeLPJz1VzFydiCu6poBucgjFzua/Cytgwg==
X-Received: by 2002:a05:6902:72a:b0:e95:3406:76d2 with SMTP id 3f1490d57ef6-e953406787dmr12450703276.0.1756222922220;
        Tue, 26 Aug 2025 08:42:02 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96e9fa5d42sm190473276.18.2025.08.26.08.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:42:01 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 50/54] ocfs2: do not set I_WILL_FREE
Date: Tue, 26 Aug 2025 11:39:50 -0400
Message-ID: <edbfcfda0154042de084183b9670db0e7242eab0.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a subtle behavior change. Before this change ocfs2 would keep
this inode from being discovered and used while it was doing this
because of I_WILL_FREE being set. However now we call ->drop_inode()
before we drop the last i_count refcount, so we could potentially race
here with somebody else and grab a reference to this inode.

This isn't bad, the inode is still live and concurrent accesses will be
safe. But we could potentially end up writing this inode multiple times
if there are concurrent accesses while we're trying to drop the inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ocfs2/inode.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 14bf440ea4df..d3c79d9a9635 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1306,13 +1306,9 @@ int ocfs2_drop_inode(struct inode *inode)
 	trace_ocfs2_drop_inode((unsigned long long)oi->ip_blkno,
 				inode->i_nlink, oi->ip_flags);
 
-	assert_spin_locked(&inode->i_lock);
-	inode->i_state |= I_WILL_FREE;
 	spin_unlock(&inode->i_lock);
 	write_inode_now(inode, 1);
 	spin_lock(&inode->i_lock);
-	WARN_ON(inode->i_state & I_NEW);
-	inode->i_state &= ~I_WILL_FREE;
 
 	return 1;
 }
-- 
2.49.0


