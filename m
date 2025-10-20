Return-Path: <linux-btrfs+bounces-18057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F95BF1D14
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 16:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785F54029F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 14:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B5C322C99;
	Mon, 20 Oct 2025 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Ka38wHVp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F95313297
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970157; cv=none; b=gkTbVCfpUaaRbJykNejMz19pHA5o6NftX+MAE1qvPyFXEwbvBqucV6E4cejkrpgNmgFsmtkzcx0JF2lXEurlyCut7CRcFrEICRofLtKmcJx/9f4wTEfvultMCjUxC2nxEZS/RwPTxF13aQOmIg89aBgMgIW2ua3zTX8Uq89p7hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970157; c=relaxed/simple;
	bh=JXxQAYlMzHf7CapetiWBiehB9Jp+AeiDGB7Scbh1Zy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ot56tb5Q3tCkENZ1IwlZQnbXK12O2ebd1uCBRsC5O5YINNnmbSmpG7PXK4VruqyFvIFKeAbTMbeQUq+jUJ7146pM8N02r2y1IN8wUkIJBbRqR7aF6TTuCadmd7mS1mTmD5S9bozoWPDHvgrh5oboV8Z2B8q8vxHEWCIx4GcUXLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=Ka38wHVp; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-362acd22c78so37383771fa.2
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1760970154; x=1761574954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l53u/lFYy4UkryOGZpDbVu9TvyPGaOFSDZbxWRdpUJ4=;
        b=Ka38wHVpKtQH0cxPgUGb0imzmq+FIMV1xOn06VDnoS0JlEcWJG9e3yXzuWlRh+5QPf
         05AD2sOIKQ0ha1oLqJOqhQGAtyA3cAvNbe9jlZ496pdYC49DBxER7VdP72K76AwxrY63
         tmTxFfQp7u0D9eo9hwMcpgaUfZmvIeFMOmxcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760970154; x=1761574954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l53u/lFYy4UkryOGZpDbVu9TvyPGaOFSDZbxWRdpUJ4=;
        b=w+VKPj5VEiTRtdzk/O5rHzJy7zRzklpqh4hwkwd7DARGyc34rD+YVf4JjYWr0JGW9a
         JjSYQJ2N7hdfytZPhIYfon7+869n99NktOpuwB63krjSyietcC9Dscf0r7R9alzr46FD
         8CDtOUSWFuLtZA6RqgnnALn7fcu16yxGP4tAL637cBUEsckRLjtl2ztUAO7uGKCUOIj8
         hS1WMtxbp9G5fsE2TLDicUFIgJtXtvjX7Sk0nozplpoj/x0Myy3Kqd2eo2Cv1VzuGKG2
         FtWZaipHiz2MctRcfMb4wHH8gg4bSy+fO0sUIgYKV7U2L9XuLdbLjOB8W7M/c+sucn/+
         B2Qw==
X-Gm-Message-State: AOJu0Yx3uO1JFJ/CNWxEVdsdXdzID56hwQNMJO1NzxQN98hAP70dkKOX
	oxneTVO8qrlnrhnkQeDQmzeueZlNg1RFCE1r/rng5aDLfb3fzjGWQS7YepW94sBAiPk=
X-Gm-Gg: ASbGncttd8BNutFk99ruqTl6FKspHyXesfmXq2BUjJFnuckvlPKXWEKZE9EnrvOPLSW
	gqy0YNpZjZtxfQZIzGj7BfREIMx82ycX1CA465oQDNEh0KaxHI8XP2mkv4ckB6qpJW34CxrtwKt
	SX9rpauXCKlzdnMuTby3JWukAlaYUEi1uqroADAyf3ZuWu3GnZ1BycD13q9G90R0mdN/rtCGdUv
	KyQPhYY42zxIuYexcPEQPpZEsBvXmeXCCSVSXWCHnslAe2W7TBa5VBovuBYSPYXtiGC0BgUPpxG
	sgmiwDouPfvP8q5pMi5yExlNHKCI9x3bUz4kHWaOUS7zx1J5yFFfLhumB1v8pp+XcwKt4SLDkJO
	DLJMnuM3YcTQtNJR7XJVGo7y65+ZZZQgFkevXPNauBumzmMIhMO3Nw4UU/R2nh15ELZW+HzNyz2
	AOKmRQzaxx5MbcBg==
X-Google-Smtp-Source: AGHT+IFTE/qW1dtgMqVJs7zGeEeHleNHdYWfYhUz3cdcHeE5+GjvJKt7zg605bf5VDdT5d0tjB/QKw==
X-Received: by 2002:a05:651c:3617:b0:375:ffc2:1b38 with SMTP id 38308e7fff4ca-37797864f2fmr43425001fa.11.1760970153412;
        Mon, 20 Oct 2025 07:22:33 -0700 (PDT)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a9666274sm21216501fa.52.2025.10.20.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:22:33 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kbuild@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 1/2] Kbuild: enable -fms-extensions
Date: Mon, 20 Oct 2025 16:22:27 +0200
Message-ID: <20251020142228.1819871-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020142228.1819871-1-linux@rasmusvillemoes.dk>
References: <20251020142228.1819871-1-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once in a while, it turns out that enabling -fms-extensions could
allow some slightly prettier code. But every time it has come up, the
code that had to be used instead has been deemed "not too awful" and
not worth introducing another compiler flag for.

That's probably true for each individual case, but then it's somewhat
of a chicken/egg situation.

If we just "bite the bullet" as Linus says and enable it once and for
all, it is available whenever a use case turns up, and no individual
case has to justify it.

A lore.kernel.org search provides these examples:

- https://lore.kernel.org/lkml/200706301813.58435.agruen@suse.de/
- https://lore.kernel.org/lkml/20180419152817.GD25406@bombadil.infradead.org/
- https://lore.kernel.org/lkml/170622208395.21664.2510213291504081000@noble.neil.brown.name/
- https://lore.kernel.org/lkml/87h6475w9q.fsf@prevas.dk/
- https://lore.kernel.org/lkml/CAHk-=wjeZwww6Zswn6F_iZTpUihTSNKYppLqj36iQDDhfntuEw@mail.gmail.com/

Undoubtedly, there are more places in the code where this could also
be used but where -fms-extensions just didn't come up in any
discussion.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index d14824792227..ef6f23ee8e7f 100644
--- a/Makefile
+++ b/Makefile
@@ -1061,6 +1061,15 @@ NOSTDINC_FLAGS += -nostdinc
 # perform bounds checking.
 KBUILD_CFLAGS += $(call cc-option, -fstrict-flex-arrays=3)
 
+# Allow including a tagged struct or union anonymously in another struct/union.
+KBUILD_CFLAGS += -fms-extensions
+
+# For clang, the -fms-extensions flag is apparently not enough to
+# express one's intention to make use of those extensions.
+ifdef CONFIG_CC_IS_CLANG
+KBUILD_CFLAGS += -Wno-microsoft-anon-tag
+endif
+
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+= -fno-strict-overflow
 
-- 
2.51.0


