Return-Path: <linux-btrfs+bounces-4683-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69878BA24F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 23:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBE4285EAF
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 21:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355561C6891;
	Thu,  2 May 2024 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="kkmavty5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B4B1C6606
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 21:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685224; cv=none; b=fHCf3YzzDalBWJfRMelyHiAfyUraxqnLxYLCMBLzHZu9wLjzhh4GRt5xhtaGULVEigBI4abXdVUC/+0CA8GsHa7zC1GeD6llMTJQamCZI+hYXAQOG1CFyfw8kvJuWaiqnrXlVzGw32OXHN+ECowmNNtHavNO3D1rJ1WdFIc3z1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685224; c=relaxed/simple;
	bh=FTwV9FJr3GNOMfmr7/ZF3Ka+WKG890demF0+p3F69iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atlzw004gzKJElr4npCPdwH1fuY7aFoIwBZSqpNRHlTI/B9T0V1dAVbtsiXPVJRGqH+O0cG8DSniyJPukSMt1r0zkALfgMmz0OyTDWI9X8WF2IEXykIXvTLkgBsO/mKlJutA9tcCclcTCEA+NiMwPM78VpA0z/TmmPaEekdGEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=kkmavty5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51a7d4466bso975012866b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 02 May 2024 14:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1714685221; x=1715290021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfhcsvhSsmt38RwfQsVzDR+KRnJI3LFvmZGFu2ShhZs=;
        b=kkmavty5nGOunby5dTAUBjBmExMvpvQO4XVCP4/OV1BfUzjsUn/QGM+At3mvrtDXKh
         x/xWdsYVCCg1AcXzjmHufFna9l/aknjTkKlY9Fh2FaxZPalhei7HzRZGw1TBpdNu9Xct
         wI4CUwXFjSY2Kug57qb1ioNvOTz0kUextcIcaorUWTKrlpbrl8rkRHfaXLcbXXSI4xPP
         QEwP5DN1hcx5/l05UX86zg4YeNNUV6QLz/TTjUDAOvEKGZwYbEpbwog+ANQhNp4JiNyz
         yWbM4WLSq5G9YXtWCx33DG/H0W8TvtBdrho19YMb2nLyY0GymD8RjaWo0Ks3g21gznQO
         msEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685221; x=1715290021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfhcsvhSsmt38RwfQsVzDR+KRnJI3LFvmZGFu2ShhZs=;
        b=L0AA+kbDqjFnnzZS+xjj2ou0rJ5DjmrcoFSLs4F/EMteCXSNUPLtH7/gk77frOGx+a
         O2uBA3JKk6LID4fLw3wTHMOLKDTzVX7gIpPSXptZZp/pf+0cO0h+lgfMCDI3QiMLjtxt
         AbCz36ICmpuxn7DlYc/PHLV1zhb3uneYAx1nDzuz4z2ChZxJp0PDrrItg+DBONCWFx4x
         hBG9f5DG7qjfPlO2Y3TjcT+Vq8qW1lAPMpwIF0SNKIx2vsOnGOB+RALyl13HsT+2Vo7p
         GomHq6k45dsNUn1ddyQxZ3BnU6lt5JrXsVLr7fljY+bIztKBdYGbsMJ4UAYh7oaJ4ZOW
         N8Zg==
X-Gm-Message-State: AOJu0YyJSDcthWwdrxp4Ag0ZKDUC5VUnKqfvlNfLWYZqgoidNlzT4Du6
	K/l5Aiw4+OQ78aDuN5URGNDhr1bMEtibfr5W8aXLld9Pk0oZIB5MsfsVvYb32sc=
X-Google-Smtp-Source: AGHT+IHsnl7RJpj3ymJ81i/nNwARVNtUdevH3erTDDDAwNmlYmS3UuIDG1Pd4ArMQB2iLnX4wSe1VA==
X-Received: by 2002:a17:906:fcb3:b0:a55:5ba7:288a with SMTP id qw19-20020a170906fcb300b00a555ba7288amr430875ejb.33.1714685221271;
        Thu, 02 May 2024 14:27:01 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b00a5981fbcb31sm354886ejc.6.2024.05.02.14.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:27:00 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	kexec@lists.infradead.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH 3/4] overlayfs: Remove duplicate included header
Date: Thu,  2 May 2024 23:26:30 +0200
Message-ID: <20240502212631.110175-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502212631.110175-1-thorsten.blum@toblux.com>
References: <20240502212631.110175-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/posix_acl.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/overlayfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index c63b31a460be..35fd3e3e1778 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 #include <linux/cred.h>
 #include <linux/xattr.h>
-#include <linux/posix_acl.h>
 #include <linux/ratelimit.h>
 #include <linux/fiemap.h>
 #include <linux/fileattr.h>
-- 
2.44.0


