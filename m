Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A8D6D73F4
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 07:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbjDEFt4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 01:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbjDEFtt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 01:49:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B3F5254;
        Tue,  4 Apr 2023 22:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PGw5UIqvDhDkNQgNkGUxScJJw9bBMO7Ehoy7OU8UD30=; b=DdNURE14+VtGgRdramlRA30wGc
        U7/0vK92LR+RMv+QQX2zfiP/6pJK3HH/jO+Ikne3s+ZwzytF/uxHW4cZhfiWaPYd43Wd+66NyI1HB
        yv6IngcmcAYXUOvgh04ryWy06vMMa4W3N3mvlu/l+4s9TVQrJ9coQ9itT3eZTl3qyp46Q0FI/+5Vx
        99TRcBG0eV3iH7xIpvsjhYlnXMX04ZFwd7n3t4hHmh6P+LaRzaIpv4fmgUD5Bl9MDv8CsOrwlSUkQ
        APWRATob000f0yIYSi/k0n5Bm3pVjUP4YYsPz81AxYqPj+9h9oeCTBW1+uk7SMxZMhai8B3Acq9Ha
        L/mpyoaw==;
Received: from [2001:4bb8:191:a744:c06e:b99:9fd8:3e0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjw1B-003Qlq-2a;
        Wed, 05 Apr 2023 05:49:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH 2/2] libcrc32c: remove crc32c_impl
Date:   Wed,  5 Apr 2023 07:49:05 +0200
Message-Id: <20230405054905.94678-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405054905.94678-1-hch@lst.de>
References: <20230405054905.94678-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was only ever used by btrfs, and the btrfs users just went away.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/crc32c.h | 1 -
 lib/libcrc32c.c        | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/crc32c.h b/include/linux/crc32c.h
index bd21af828ff6fd..357ae4611a4539 100644
--- a/include/linux/crc32c.h
+++ b/include/linux/crc32c.h
@@ -5,7 +5,6 @@
 #include <linux/types.h>
 
 extern u32 crc32c(u32 crc, const void *address, unsigned int length);
-extern const char *crc32c_impl(void);
 
 /* This macro exists for backwards-compatibility. */
 #define crc32c_le crc32c
diff --git a/lib/libcrc32c.c b/lib/libcrc32c.c
index 5ca0d815a95df6..649e687413a0c1 100644
--- a/lib/libcrc32c.c
+++ b/lib/libcrc32c.c
@@ -65,12 +65,6 @@ static void __exit libcrc32c_mod_fini(void)
 	crypto_free_shash(tfm);
 }
 
-const char *crc32c_impl(void)
-{
-	return crypto_shash_driver_name(tfm);
-}
-EXPORT_SYMBOL(crc32c_impl);
-
 module_init(libcrc32c_mod_init);
 module_exit(libcrc32c_mod_fini);
 
-- 
2.39.2

