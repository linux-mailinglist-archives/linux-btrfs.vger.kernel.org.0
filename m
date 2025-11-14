Return-Path: <linux-btrfs+bounces-18985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5396DC5BC82
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 08:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2337342B2A
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 07:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265882F290A;
	Fri, 14 Nov 2025 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5EYHrbZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219E2D8DA3
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763105227; cv=none; b=nF7jzFUSp+U9vgGllrMABcVhe1w6pt/SeonqZppuwbOoMzez6hapC0YhDoe06Ym5Jp1JGRt5kQnwZIkChrne97HKRJSIKM7pryHz8Wj7jxLl/OYl3EAo2qCeH+a4I9B55csGeBnL8kLcyO2I4k2OvWT+TASEs+MRmlOlhwff8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763105227; c=relaxed/simple;
	bh=2iFMAWSCUUzEp9CIub6IF31swrV9uRb5LxZVuXkFhgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sk8woutXZDCfHK1iGxudQeKAPvL0V7mcKOiFsXYh1XckPOVmeZi5NXARqKg4UcTdxOYJ0GS8G2cEY8EIoNBQzvcWbGORGcLJjkdi8Df1aXs/f3qopfWerL7hpEudr3FsoDmmwgQ/+Lfgn45aMRLBDKCIk3Xg61jL/nHhnwRpfOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5EYHrbZ; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-29800ac4ef3so3784715ad.1
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 23:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763105225; x=1763710025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wEFDV9roTse8sDLwDb5vJcFHt2LOb8aCXymAeFrKNAI=;
        b=F5EYHrbZgbLz8AGMoM8CRYGNR7skJhofvIAExPMe5ADi7wbCWjx808MaKMJYnDkD2x
         id73tZXk84f3U4J6fqANFOA1PSglf02TZMGElmFDcdaXid/C8nPH4O+lqMg+6Y8njle7
         P/w8c7oKPeEd+EZFgRQ71GimvKLY3plV41ACF9urFys9DiwU6qHjv8BGXEOR30hP20+y
         GeTxgm8lub2LS+14XNue5TbhHLDxMivyEfR+FLfZARrI+Y1kGQPmFDSRf7PIrL1S2Jua
         zzZEuh6Y4cNmiT3fLPvuus9DP1ANojMMkm0ZlxeK/LZH0rAGIBkkRMRKZzf3hDwyZT/v
         Y21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763105225; x=1763710025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEFDV9roTse8sDLwDb5vJcFHt2LOb8aCXymAeFrKNAI=;
        b=kM0b+QDKoMlPxxEbxqospfb3z+jXcdaGRgA4h7yTNCcAZ0x+mL+NJTH6dlrwy12Yz7
         8Bv9ZK6TC3QGhEgmP3ufOT1joSdMKlBhBL7cjVX4Q1pjnOdIDBPzkn4pdZdAij9Um5kJ
         bhiJM5w/+9LEt64emajx6NhhujcqOmPrWm5XKNGfEMu9/x9IYLOqqtZSChSucy8EJa4W
         jmsW4JMWnfG01pGtfGaDQx8vgWzSEGuRlpB7jZl9xXQ31+KwGk5z8RBlT81Nsr+U342l
         ACEzgCvektBd5K+aK2qfnsDJZ+632e8c6eRF2biiIx+hzsGwnoNGOkV14Le5MWdJdMqj
         L+Sg==
X-Gm-Message-State: AOJu0Yz034ubkoOWW+LQkt0aJKBBiKGLDeDJ2UdvfIZeJe427MYwQCha
	MZGGCjgtFaw1dfh/2186ggt147343eTiXPKGH0eWpf2olFWi6fo5hwaDqPvQvOgrGlBfew==
X-Gm-Gg: ASbGncsYQ0Afs+yM5PunVwT7UOkTeCMYnVpeYhRRg22hQLuOgAsnYigMm3uU2Nv7Ap7
	nObr9DNg6zr5G62anIFb6M9vIBkM0ll7zl8s2ers5I94cz1ZG0FrSagvBEiofkz+QBgMiDOrnMQ
	lS8CjVDPnq35oHGgwp7qTUaJKE3vQsnGj3tYXQyv3hMZFJvbzYkgK2DZnldChCEgpRX8a5SiJ4C
	/X2kd4bJG8MFBw7LRZOnZf5kKTYGRVrl1pgIF0MqL8MT8ovfuT8xV/wAcOKwqYAuAwBogSFZMfJ
	mGzXgreN8I/KX3pDiEM11+o8LIah2xd5guyOwMZii80XxSK7KfbpDQjqt6N7dNY4DezwopD8zB9
	AtoTpsAIV+l7nfDgdk8NDRLXG+8ELRAYufrirEldgc5OIATcek6IdUMLF4U7kykB6mQ27kvzgTY
	cVlsioWJfJeKWePBcBsW1vMo39fpsEZ0KNgjSNL8isgcGmxcA=
X-Google-Smtp-Source: AGHT+IFoHOIV1j19QhX5Zce7V7bhps8Mx9nhGU96MSqjQlGYDDobMd3SSezKgrivogj5zByboYDcug==
X-Received: by 2002:a17:902:e746:b0:290:af0d:9381 with SMTP id d9443c01a7336-2986a73c8bbmr12578475ad.7.1763105225293;
        Thu, 13 Nov 2025 23:27:05 -0800 (PST)
Received: from SaltyKitkat (160.16.142.119.v6.sakura.ne.jp. [2001:e42:102:1707:160:16:142:119])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36f42eb0esm3947084a12.13.2025.11.13.23.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 23:27:05 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 0/4] btrfs: some code cleanups in ctree.c
Date: Fri, 14 Nov 2025 15:24:44 +0800
Message-ID: <20251114072532.13205-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change. Details in change logs.

*** BLURB HERE ***

Sun YangKai (4):
  btrfs: extract root promotion logic into promote_child_to_root()
  btrfs: optimize balance_level() path reference handling
  btrfs: simplify leaf traversal after path release in
    btrfs_next_old_leaf()
  btrfs: remove redundant level reset in btrfs_del_items()

 fs/btrfs/ctree.c | 164 +++++++++++++++++++++++++----------------------
 1 file changed, 88 insertions(+), 76 deletions(-)

-- 
2.51.0


