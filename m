Return-Path: <linux-btrfs+bounces-12179-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50C7A5BA94
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 09:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C268189657E
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 08:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8591E8F6C;
	Tue, 11 Mar 2025 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfGDqRrD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B9C1E32DB
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680816; cv=none; b=GGUp0MrCUs0XUSWzgxl/hpTmKuzS67CU728v4tcWNmlBjj/mxhpPXJX5PPmckQbybWS0iAn5Nat+QzDSNmf6Jc9fEbx9y53hhysowKojxjOawoHFr0Wc1/vXQ+5ZcW2Gy403oNR106EE+xJXIgB3A+4b/1t1lTIdsBH/OCB+ykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680816; c=relaxed/simple;
	bh=daqW0VKi0K98mu0yWDPqAJ87b+Oj2un/jb4H1ajcJ8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNODRFqF+bnRGMzzdjrnZpY+8ePZ/aBl2/i0+UElPhMe1hIvbbDabNXERAn0XgW9UmizPZ22Hhka3j0zq8mTLiNpHSph5x0oCI0gcIELOPh33aQW+/UXWOmnC0AGR/MavD7pYz6eb6CEBbtz1Jj+WJ55s3sVysUD8Y2thHtvayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfGDqRrD; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2241c95619eso10455975ad.0
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 01:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741680814; x=1742285614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sd8PipucDVa12HFWCqZo5TLn+S4WKtBHXzWDZ3CsLaw=;
        b=bfGDqRrDdOY2tbLssugzDjEqeRu26CP0FtIPSvG6Gzv4jP2MrnrErV2DI9cPCPynrX
         evRdgKmmMjihcTuzraMKfRKXZUEcnFLKgmomvs5U/TYv5ORHBew7v+3OwBs+Lzxd7+cC
         55qAXDH9W2CTKq1y1SZA7QxmauhugoPccilLoKE3193d+tZ/zve28KVxt2LTEQ6MsAXg
         9KPSPYfXZdC6MuVv3ZgdGtL4+gF2MK33x3dH8Tl8jRgQBggZQ1xZ2VPMdwkzuOOuNejP
         ZEE3Pq6ME3264h7jvsVJjYjoYnV5aJiBSm7V8/2I8qeboBrAR4r0UevewXziOk5bSEVb
         I/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741680814; x=1742285614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sd8PipucDVa12HFWCqZo5TLn+S4WKtBHXzWDZ3CsLaw=;
        b=qU58KmzV8aPp37z73SLoY/uRJb8ILT4fnm6Voiy32fGfQ6AC2cO6nM2+SBhD9wES4C
         BE9ZkFZkkQmtBfpvPBxlYDivxrtuPajX1rCceVqGAqWisvn34nCel7e0w5xN8IWa4YsB
         GSaxdyHuxCSuTogAigXMhG9u1tqYw17842z/UJw9LCTxEq3Vabpg7irjeq13lCLfHcln
         tWX8aAH3jLo4ntmFzJKC1ZCnrcAbQ1YpQZIFAyZ63tRhBGCY6Zbv16IpR12Qa9CHneah
         SOS5bIzFLxrAgdmQsoM6V6zKZCA8Z2uPPNY6ubLvYEM0cELfMbAcCs+wWIL4BAI6HJH/
         S/iQ==
X-Gm-Message-State: AOJu0YywruDAob/28bRG5tvndv8bGSPY7X6o4++fMcmTwa3mtemkg4el
	uI7w6BuXPgdmF25KAKShbkoKN79Wk2A0o7oR8FBGyYoLu/9+9H1afipKRkMe5x/XgA==
X-Gm-Gg: ASbGncu1rzTSlE+XovARBm3xnPbvlZkj7OqqzR02VQVUPmwOuxyRRziIM3bQf8NJO6a
	pXUqEHkXTxIqmsoBGc0jrkdAMNpUp4pndAtxA71Gmf+oD7PIry2+s0vV0JwDZG2fOfgtBoWOyvG
	Vxo/4Dkga/Wq/TTVUFyl9dLbt21n/tLIou1X9W74JNYDQypOgdrjYg9vQScOipFKxhoW4rmi/0w
	XVF1w5vXnzHJwe2fNzVGLbfxi+9dDLlq2OuWUXKXFtMYABllRrnG+77tAgVWnVAMyPsZc7BUqLS
	0/WfUm+gPw3pM5J5TggMGKGBIRM60axQgJ4mj11895d3VGlVsmv55jC+iQ==
X-Google-Smtp-Source: AGHT+IEmpABZzJimA5cCvxqsXxa2NyskrNDQhFdXTTMho8nZ4fP01XDyVs/axdLSebVVkQh1ajh/mA==
X-Received: by 2002:a17:902:ec8d:b0:220:dae5:34b5 with SMTP id d9443c01a7336-2259327fd08mr13289615ad.7.1741680814368;
        Tue, 11 Mar 2025 01:13:34 -0700 (PDT)
Received: from SaltyKitkat.. ([198.176.54.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa5cdbsm91203635ad.230.2025.03.11.01.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:13:34 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.cz>,
	Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 0/3] btrfs: random code cleanup
Date: Tue, 11 Mar 2025 16:13:11 +0800
Message-ID: <20250311081317.13860-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches are not intended to change any behavior of current code.
Just trying to make the codes easier to read, and, maybe, perform better.
I'm working on btrfs_search_forward(), trying to improve it and fix some
misbehaviors. And I'll send some patches that will change the behavior of
the code later.

I'm new to the maillist, trying to read the implements, and improve it from
my perspective.
If you have any feedback or questions, please let me know :)

--
Changelog
v2:
- Improve the commit messages advised by David Sterba
- Fix some code style issues advised by David Sterba

Sun YangKai (3):
  btrfs: simplify the return value handling in search_ioctl()
  btrfs: remove the unnecessary local variable in btrfs_search_forward()
  btrfs: avoid redundant slot assignment in btrfs_search_forward()

 fs/btrfs/ctree.c | 15 ++++++---------
 fs/btrfs/ioctl.c | 15 +++++++--------
 2 files changed, 13 insertions(+), 17 deletions(-)

-- 
2.48.1


