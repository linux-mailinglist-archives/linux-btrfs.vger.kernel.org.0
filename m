Return-Path: <linux-btrfs+bounces-7838-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CDD96C891
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 22:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70B91C25A36
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 20:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A753B1E8B96;
	Wed,  4 Sep 2024 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Kxe1sZSB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708221E975E
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2024 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481784; cv=none; b=kYylxEJ0B96uBECqmjQQx+rHy2mq/YBk1g4K/wDD8Y+uBKNvzAKqGsTgejI1hcbxQvWPY+0KItsSFsRrg8Bn/cfKpCsLdpchrBd6uQMdIzjQZHWPw6EJwD5jMbYWeft1l1YOefAyqrfgxwHZ2nFSQZs/hCi1mwnANek9YWa4hSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481784; c=relaxed/simple;
	bh=mlpkxER5ZXbhWxBFWH/+nNlNrq7abJQvDN93xPwV0N0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQVbrF5T2aNTdMWS5luOtJiip17KaGtcl2Cuuyrv8sK7lda/iy84rbBWW1Mdicp3g8qzqlxBb5l4TsgaaqtjTy+cqBDkPh6i87UCdcOMXliVvzQHr9TXkJ9lLOD6nyFYu/psPdTdwBoQOeazqr5A/Ad292dQQoFg3qQ+g21Jc+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Kxe1sZSB; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c352bcb569so154066d6.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2024 13:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481782; x=1726086582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2g5nWsdtLhh4I3qKZ9kVR48Zxv3ldXz3E9kfB37E8o=;
        b=Kxe1sZSBe9bkdYZJnRALn/HAAAEZMTeKx5eO5AvTJ1D3YwSVfn+q5BILaNQW8ER2gI
         mRsqj+KUHJ9z66im7l1ciGFzt9X9oXD3q4FjbbQeStUTGAd6/HYPBSW8vY3KM3CkbRJG
         Hqfe5P+PTSnrLsdQJr1+s9qkv/NAD7V7PMQtg3S94IcnTfuviqT7TkqwJTke7gTzi0K9
         ggVWsakCpTAaB6upon39dRx8Qqe245H8JgVEmnUuvRcNqde+hkeUQXMJUvWslK2tB1UV
         SnFSr76ju62cmfyRuo5JBgN0ZxMAN/PxBuPJeqtog6yIzIehwqBwFtxPE+Z4TEVlM9op
         3pRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481782; x=1726086582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2g5nWsdtLhh4I3qKZ9kVR48Zxv3ldXz3E9kfB37E8o=;
        b=Y1KA4aI2iZxPniYnX85nTh/w4MeTkmI7dBMiuDLR3MWApM58EvA9M3iLjLI37NIXLX
         tvVJtSR5kjDPavWv9+yOEw9+A+lTgdrCFK3wuf18rUtt3sETMVy1YAtVTNZo6pa7jOlI
         DycRYQpJcIE1j/dJt+AcUer+kGHbQVJuLRTmlG6HPtnE8PTOXoZl3g41dSip03FTNCqL
         dFNe+7I4YE85c6OlbcLncPQN5qYl2nI9VFwdRkgkJf4hHmIQdcmrXqEGHSxY8J01jnUW
         f1B/mbR3VQR0AO5SGVKqdaDBt4ZKXUm2hznL1NawuKu7k4G18jdtqINuHd3B2o976YDQ
         uyWw==
X-Forwarded-Encrypted: i=1; AJvYcCWKc6hstiAp5SDKb0M8lFgyC+EY+9cHqBO7spk9OORqdJblfa9XpCdpCKYSmEHgl6cPs/H+4cfIFAUluw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWOR2/tqPZm/7u848R4Pgk2L9T3R6fQ71BXpJgLun15QCWhDTc
	Bsl0TNrL3AOv+sJUaOenaGho7suymFg+J64u6qjn4nbEt0/GMM4Sxgty2bxzKDk=
X-Google-Smtp-Source: AGHT+IGcGqc27V/yp+/MPiFXZlq6o8dH/S56y18i5ffiw87nR/uugOanZlUMV6j8hRmZXaYyxJ0xkA==
X-Received: by 2002:a05:6214:4a09:b0:6c3:5ebb:9524 with SMTP id 6a1803df08f44-6c35ebb9733mr193501086d6.48.1725481782473;
        Wed, 04 Sep 2024 13:29:42 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c520419ecfsm1552666d6.126.2024.09.04.13.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:42 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 17/18] btrfs: disable defrag on pre-content watched files
Date: Wed,  4 Sep 2024 16:28:07 -0400
Message-ID: <367fe83ae53839b1e88dc00b5b420035496d28ff.1725481503.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725481503.git.josef@toxicpanda.com>
References: <cover.1725481503.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We queue up inodes to be defrag'ed asynchronously, which means we do not
have their original file for readahead.  This means that the code to
skip readahead on pre-content watched files will not run, and we could
potentially read in empty pages.

Handle this corner case by disabling defrag on files that are currently
being watched for pre-content events.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e0a664b8a46a..529f7416814f 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2640,6 +2640,15 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 			goto out;
 		}
 
+		/*
+		 * Don't allow defrag on pre-content watched files, as it could
+		 * populate the page cache with 0's via readahead.
+		 */
+		if (fsnotify_file_has_pre_content_watches(file)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		if (argp) {
 			if (copy_from_user(&range, argp, sizeof(range))) {
 				ret = -EFAULT;
-- 
2.43.0


