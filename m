Return-Path: <linux-btrfs+bounces-5295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 677CC8CF617
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 May 2024 23:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082AF1F2137D
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 May 2024 21:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8582513A3E1;
	Sun, 26 May 2024 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="eeZcNRTZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A4D55C1A
	for <linux-btrfs@vger.kernel.org>; Sun, 26 May 2024 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716758501; cv=none; b=HQj4XHyRrEDmozRcxoX1i6skiAgchBd4s8cGvjhmG1R3hHkpZq0cFs3NTRtrjx2H5il9iGb1LoQvtWAwyWw+RyW1YmjvFQ/lZm6nSn1wcFOJGrJmnRqU/v0c5tWfRYBfJkRHFr/57Q3aI1nrN+L871UoCJbU3NjQJswtRRZVVUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716758501; c=relaxed/simple;
	bh=h07742SfbAhVzUh56nb4wWh/jm6ZTEc0nPN1Utkt790=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uE6JpUWkB7NF8rdqdEsMuE/T/wfm3/KlIT5r6aV1eFywPKrllc3XUHRIXkZ9CKUecUUyqyGRXEtcPqIT3YdDhMN6qCKUykb9rbeSuvVGB5XSRPoy6xBCQrmt0XHnMtJOd3Xi6+c8cTpCz8/0DEMihnBWG/NeWT1aP5gotwr+Atc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=eeZcNRTZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-421124a04d6so4405715e9.3
        for <linux-btrfs@vger.kernel.org>; Sun, 26 May 2024 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716758497; x=1717363297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrZS6a+2WmF7PbI/Eek9PooMML2FIBwy4rVSyH7zOdU=;
        b=eeZcNRTZMjJO4YnNQC5LsnYWgEIEkaUK7VRrH2kgUN57tFqpRYGi9DVEihP4of3sIX
         XFLo842CUd6TJFClqdCyoxKP0te2StP2BYj3h/ptB/PiBi9jpAkMBsippgKK0J3pqEJH
         R14zp2THbaJYl+KsKidRXo48qgeBJSPBPU2hqy/3bbtB9NsymtlzzatQfU+XMQB80FWK
         fKwxkoD0LmjeF/WNL4zIpQ5zpgY3svmyFyA4Mtz/1t2NmqyXjVHkFc1PTyPBT6rmZxJD
         i4AnJKVe3Y9UYTMYyxOeYGa0jgZvR3PGL+gswoKY26xIXD/VVS5lI4rh73iRdFUK8Wcf
         10yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716758497; x=1717363297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrZS6a+2WmF7PbI/Eek9PooMML2FIBwy4rVSyH7zOdU=;
        b=jkdp6K/BkqooYhCuYYyHsFXl/Jfw873BG25vy8HO0y5rukGDWuJdaY8E6fCVXrGV9U
         +u9mck2YyvZBM8Bseo2NXqyILvlyyJtZtM9/GV8j1QSGyr5VgGDg3SIo5SPCh3E6S1lD
         zaDPjUhi9dsbE2a2Nk2ivQKaXPQYmo8Lf8vM3P76OGFd6HCyg7kjo/BLTl9gozdCDXmN
         lXG3yZQENuXYJ/dPC5FWLcK1CTv/KzgsEgSmOiawG0IaXCEGKXI0FoW1JVGDBVEThCly
         y6oMpDKndRGNj8UKmnspk9Pn6vYSejv9YoUyfeNmvcU9f58+M8Ztck8DB70oslnH58LY
         1T7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzqcStndTTbi+icku5srQV2VrHCg2lQKtiTrOBYEnglG+rag84cnRm83cGsAhBSgRBbk5ImvlvRCENNUn+zBcczl1ST5OjNMC1t28=
X-Gm-Message-State: AOJu0YxCnIb1CWX58bG3gMartJpo0Ck+7eDcwFGr4YhJ3FSZTqGSBT8m
	1x/5H++gNQgZRHwIrW8G+N5ttVWp4zo86F9mcR5pQhqofInqrW3hQfAW3em/v3g=
X-Google-Smtp-Source: AGHT+IHW4ae7lxNWn2WaLCNzfX0cTLfvfU9RcG3UisSM/eMD5CFFw81oCKu+GmqWICgbek/bKosQUg==
X-Received: by 2002:a05:600c:6a93:b0:41b:f359:2b53 with SMTP id 5b1f17b1804b1-42108a14eaemr57525155e9.37.1716758497510;
        Sun, 26 May 2024 14:21:37 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ccf32sm87534245e9.48.2024.05.26.14.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 14:21:37 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: amir73il@gmail.com,
	bhe@redhat.com,
	clm@fb.com,
	dhowells@redhat.com,
	dsterba@suse.com,
	dyoung@redhat.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kexec@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	miklos@szeredi.hu,
	netfs@lists.linux.dev,
	vgoyal@redhat.com
Subject: [RESEND PATCH 2/4] fscache: Remove duplicate included header
Date: Sun, 26 May 2024 23:21:09 +0200
Message-ID: <20240526212108.1462-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240502212631.110175-2-thorsten.blum@toblux.com>
References: <20240502212631.110175-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/uio.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/netfs/fscache_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 38637e5c9b57..b1722a82c03d 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -9,7 +9,6 @@
 #include <linux/uio.h>
 #include <linux/bvec.h>
 #include <linux/slab.h>
-#include <linux/uio.h>
 #include "internal.h"
 
 /**
-- 
2.45.1


