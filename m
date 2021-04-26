Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1838A36BC46
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Apr 2021 01:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbhDZXnK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 19:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237660AbhDZXnD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 19:43:03 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8851BC061760;
        Mon, 26 Apr 2021 16:42:21 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y62so7455610pfg.4;
        Mon, 26 Apr 2021 16:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VsQsmCAgJgJxoXWPONlyxJ9BGgILIRFdOhQAUEyo7tY=;
        b=Xzd+Bu439mdjn8yl2z798jxgjLJIueP7r/oNdhZWpnH7fkdXHfiqEWPC3ud2fhIG3N
         m0pkmEQiW1/MvVuNoZ/x++oXDuSSksOQO7p/hcRVEOJW2jOvXylXl0VkVX9ER5HyDNH5
         vZ2UZS/griXQEZZ07FhXubjld5Y2CYmr7E2LEraJAYw/aAHTe2fbbANUnQhbNKnyZAzR
         MSlYgq7wSLauROJmYGgt3dEQXoKqbQfr/CnqFwNw/SFx4JAOyIX/tPl/Z90pDJkMbKwI
         1OP+FAnrRZR47uMu3B1J1CqCeL/1He7tP4S7cQOmus4c4Lvf/PlT31RhD6MHy/C4WpW7
         e6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VsQsmCAgJgJxoXWPONlyxJ9BGgILIRFdOhQAUEyo7tY=;
        b=gZm5HGft/G+HCfW4cuJ7NusCFG9tq/rFe+Jj3uGxCAF8M6q6OreWtx3qZBhbucJ3c2
         55njVbqP/qO2cKs1Byow8K9Jzp5grVsuAYi1JYwnKuhxoB29+Laii1k+CmlsvRJTb5Xf
         WpuZ6vALh5/ErTh6OgI6VtMhevfTjC8fdEzoSndFssYU26Cp9sPOGqlz/1Sruc3bHHJQ
         ETjwX0096HNbm7YHq3o+3MPIZXQVy4k5VRIk6TWGaY6dMvc7bpnVnN+NmTpKFnViS7sn
         Jcolm6b0WIpFtCXD6+ClM4apIU8msJRZo6eKbhs06/kJ9gf1nipsBYd5EbI1u1RMGrxU
         x2/A==
X-Gm-Message-State: AOAM532kbL9RaLzTMmpBwNr93fLtMG5Asp8ZVl0KnXW4gb5zs2IB8iQp
        nfidnoXt03ar/2JaZ8hBFo0=
X-Google-Smtp-Source: ABdhPJygKGT7O/9kbsuo/ZEUwwEeZWZQv28qIldIprW6wlA3FY+XBIy2K9MxMTsdBqcdBIFAHcpJZQ==
X-Received: by 2002:a65:43c9:: with SMTP id n9mr19035367pgp.19.1619480541011;
        Mon, 26 Apr 2021 16:42:21 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id m7sm640828pfc.218.2021.04.26.16.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 16:42:20 -0700 (PDT)
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
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v10 4/4] MAINTAINERS: Add maintainer entry for zstd
Date:   Mon, 26 Apr 2021 16:46:21 -0700
Message-Id: <20210426234621.870684-5-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426234621.870684-1-nickrterrell@gmail.com>
References: <20210426234621.870684-1-nickrterrell@gmail.com>
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
index fb2a3633b719..eb67c13ec36a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19890,6 +19890,18 @@ F:	Documentation/vm/zsmalloc.rst
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

