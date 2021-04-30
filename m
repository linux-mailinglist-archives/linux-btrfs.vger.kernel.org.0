Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E8636F394
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 03:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhD3B1i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 21:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhD3B1e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 21:27:34 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D4FC06138B;
        Thu, 29 Apr 2021 18:26:43 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id m11so4211262pfc.11;
        Thu, 29 Apr 2021 18:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tjglHgCdOo9aNmUJ+U7eL0Rhds1mEanZ0rRyCnAz6WU=;
        b=pj5P1pc1D/l2b4G37TELLspq5umpYDb7fJAakA5nU9s2OKvky8Gr2sOFZBsmSZcVzn
         0dapmB3JMg75SErVUxSLYE3xSIWfTGQIWmLLfoweixXhjLGXckATDL3tG5ujCt3mp3wO
         Kfk1VRKOmWkCqMqo2p9IfYiz25m9eSi5rdqKPTPluwhJcDkvHVhBLtmTtwdxUwtBLhRT
         nNhz7eco5j0Sa+zXo9BPUAFFH1X0ZEHWo0icezreb17kzhPxQ8tXaqpD2EViZAAtx4DW
         NBMKUKqg4YQiG7O3BE3OxzU+hTJvt58VO+KU0Rp9D/6CtWI7vCs1j/v3cM10D4HmUduI
         c9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tjglHgCdOo9aNmUJ+U7eL0Rhds1mEanZ0rRyCnAz6WU=;
        b=fadz1KwbYtJ7AepB8PTe+La7SF2lWIexfjXGE3uDPpbrBxMgCtbr2Q2nujF1lzKahg
         F7PNY0d/fts4NMTOFgvZfv/8+X+ISnu3qj0m6EAzYo4vzMU5JBkB0RHOpWe7inZyaeoi
         EXCO9NLi7LCpnPtvAkKbK8KxVhVp+PTxZMjujB0RzjitgEK2cE+T3+8+GmhBxNTtNtzY
         1Xr2YFnfgZiPNZ2oxsGwhjaUy3ZyXFnUPZnErx+lKhZzGNBDLZsnG7sIr0JlrfCBxO0g
         wD6E3nIA2kLM0kjyZ/u85KKHGXiAipU46O6q7X/Ey33LXcW5Wa4HqOJqpSAkIk7czI94
         x+sw==
X-Gm-Message-State: AOAM532NXYPgFXjI0ng6u0AZa5esNoBj7FliioNZLtvOg+r/qAVZikzY
        yS+JJIVq9zmBFsAZsBlYemI=
X-Google-Smtp-Source: ABdhPJySKjyTMc6tGPbKhCO1pK7lKmK7mC+K3AwnlUS/dsZ1CseFwgiVdGcS+MV9xytaOCrYZFANbg==
X-Received: by 2002:a63:a16:: with SMTP id 22mr2310271pgk.345.1619746002964;
        Thu, 29 Apr 2021 18:26:42 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id b186sm311004pfb.27.2021.04.29.18.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 18:26:42 -0700 (PDT)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Sterba <dsterba@suse.cz>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Felix Handte <felixh@fb.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v11 4/4] MAINTAINERS: Add maintainer entry for zstd
Date:   Thu, 29 Apr 2021 18:31:57 -0700
Message-Id: <20210430013157.747152-5-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430013157.747152-1-nickrterrell@gmail.com>
References: <20210430013157.747152-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

Adds a maintainer entry for zstd listing myself as the maintainer for
all zstd code, pointing to the upstream issues tracker for bugs, and
listing my linux repo as the tree.

Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9450e052f1b1..7025c67248f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19912,6 +19912,18 @@ F:	Documentation/vm/zsmalloc.rst
 F:	include/linux/zsmalloc.h
 F:	mm/zsmalloc.c
 
+ZSTD
+M:	Nick Terrell <terrelln@fb.com>
+S:	Maintained
+B:	https://github.com/facebook/zstd/issues
+T:	git git://github.com/terrelln/linux.git
+F:	include/linux/zstd*
+F:	lib/zstd/
+F:	lib/decompress_unzstd.c
+F:	crypto/zstd.c
+N:	zstd
+K:	zstd
+
 ZSWAP COMPRESSED SWAP CACHING
 M:	Seth Jennings <sjenning@redhat.com>
 M:	Dan Streetman <ddstreet@ieee.org>
-- 
2.31.1

