Return-Path: <linux-btrfs+bounces-16230-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D273B3069E
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A67AA0906
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CF7373FB4;
	Thu, 21 Aug 2025 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="h7StaB7s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F3138E76B
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807661; cv=none; b=kjfJArwGxKGUxKhxDtptiPSeg7NQK9NYdUtzUaVxlK9a9A2cT4px9dR2upV1PSBQ/3rZwiyBPGgRTSQJvR8TX02mMEf1NIw/Gdauo1dTt39t+bSxvBAwCuRnjQYo6GUpGUJvDjhWTYCOIdN8F77MfkPuHUMKTGJyByexju5snqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807661; c=relaxed/simple;
	bh=Ek+K7HnIxIEopRMdqMnNty91y2VWEE+x+hrrKpFJIDU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmGM+censci11sE1XgxsoJMxawgdNEQvAf2k+wbiPCp2RBe5srE5GxvNiCOY1kzXNng8YGAO+R0S7JjWHyE0bdPjAOd3DS3VG+69yzpjSkLORc7OMWbsJzcmlWHfluoI+HGIBfEmmBCJO8MmVE0kWIlbZoarDV6XoMJJmUdyLjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=h7StaB7s; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d608e34b4so12217697b3.3
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807659; x=1756412459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3TpSvoC8LjQ68sRQOMNnuf57RQxDl2e4bAAk/7JVig=;
        b=h7StaB7sFaFR3MU6RpylsNnl22azzxV5oSw08GZHVkgu9uKpQh0EIWf4LakiASWhc2
         Hu7r3GBivna5hNDvTHut+WH27OE47U4mWXOcPqnAPKnL20fzCz6iO+YJjqCsk75gcpXa
         Pi7L2b997iBKTv7FOOE42A1AoPHp5yYEPG8QyzzhzTaTPKl2FBBkH0GMAqu29AqVdedk
         P9Coxx/gi2d9vd23T7qyY0MC79V1fsb1qulU3oJ8hxPpCQJFQeVjjG3emy8hvTa9qdjZ
         ZKanmr9ngpInB40VSv3IaA/ylzofoEy/eAPSvLumk58yiLGwKGzBLUuwFiPk4tRlwivp
         shDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807659; x=1756412459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3TpSvoC8LjQ68sRQOMNnuf57RQxDl2e4bAAk/7JVig=;
        b=Pr7ZK1WDFePDyps1jAtsckrBBBJ9ymRByCloElwbD68+l4n1O2eRuaWHLt/L4Xw2UA
         AF2X1r57UmXvhE4yM3H8MCMDGJzCJYuIpDCj33kWbO+0GF69Nwu7q2PZvFaDryS5sU8x
         Sn49Pt2jk9NIXLaO8JOLcFap+4M/0+mW6vFXi3zwiqUG3CpuS/vN0uCVAa3wo1JrhJOH
         +y/B/luWPFn7wgPWY9iywHeqBQVf9SgLGFOT8Bibg9JoVkOJ3VHC+eIoDKRnKdd9qjGo
         aZBzrpV1YSmbhTCTK7kZ9YrLUnpGC+R2nS734ZgeQVklkTulTvJ88c3T7OaTJivMIZSu
         xvnA==
X-Forwarded-Encrypted: i=1; AJvYcCUV4Wf50SABa1rUKH4GL76wASw7rz04dAPjwpgK2tRAcmL3aEz4eFGj9grDBgCrAdRvRICczDd/CgpB6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2WWl5eTZ5RuC4q9t8/h64mQr9dEVPLwxu2WTejMyCM86rNVXf
	gB42PlfYY6sSTP+MpiYOvWIiEuAWavkkzsQkZQS4bEYQpY4QK36hNQCDy7K7cY4b/GA=
X-Gm-Gg: ASbGncvxnDXpBGEXWrxSlsLwS30VS+PM9P7sEoNgE9j8UtIRgU3EEzrbkZ9XUy01JSe
	qucLkSTh2OT7FKlH0M01FgEvAReywxi5whxkuMJQxM/U9yuXwy4WhLFaAIPMJdd9/hqOMXlyZpP
	yGwqvqdLjIl6f3muD2jreOKrc5AuxW857bguIfdZ3NI1H3XZ62A89DJOyF9DV1ZkuFx0pU7ThsU
	eKZ10LwDTk64HkCQ7Xx/dNpisHyICzo3tW9PIDPYCyn0jav0e471hzpc3HDF0631R76rBCukEmu
	xDjjQrQEeFQ8SkWP8PCmmOQVGZFvN37R0nkc/QrtkXs9UZSCetH3TxR1ugceZ85T6aZhrYhqcPe
	opa2R46j/tZa/373NyN2QHcsLNflXn+NmYJKQ/KZv849w9M1psKa8OkYU/z2prbz9iVmkXg==
X-Google-Smtp-Source: AGHT+IFzSbbZbVyVfwrrT3zpLyFIJoYYtpY7LXxY8rNCJVnHbwi9tGRQ7nXi3Rf3m3iA+CZ22nlXrQ==
X-Received: by 2002:a05:690c:6b0e:b0:71c:bf3:afc1 with SMTP id 00721157ae682-71fdc2ee8e9mr7159417b3.17.1755807659175;
        Thu, 21 Aug 2025 13:20:59 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e058dbasm46453967b3.47.2025.08.21.13.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:58 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 29/50] block: use igrab in sync_bdevs
Date: Thu, 21 Aug 2025 16:18:40 -0400
Message-ID: <6dee286aa8a57a874a66d1e9c7fc835a60393197.1755806649.git.josef@toxicpanda.com>
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

Instead of checking I_WILL_FREE or I_FREEING simply grab a reference to
the inode, as it will only succeed if the inode is live.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/bdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b77ddd12dc06..94ffc0b5a68c 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1265,13 +1265,15 @@ void sync_bdevs(bool wait)
 		struct block_device *bdev;
 
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW) ||
-		    mapping->nrpages == 0) {
+		if (inode->i_state & I_NEW || mapping->nrpages == 0) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
+
 		spin_unlock(&blockdev_superblock->s_inode_list_lock);
 		/*
 		 * We hold a reference to 'inode' so it couldn't have been
-- 
2.49.0


