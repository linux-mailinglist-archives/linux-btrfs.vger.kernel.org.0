Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4327134B9B1
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Mar 2021 22:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhC0Vsf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 27 Mar 2021 17:48:35 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:52614 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhC0VsS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Mar 2021 17:48:18 -0400
Received: from localhost (kaktus.kanapka.ml [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id B4B19A0401C;
        Sat, 27 Mar 2021 22:48:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1616881690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0SDVFh4IivwpMZhwg29PF9BCGg9OFyVJ9dY0fRESwI=;
        b=BL+GUFCBXmgH15fMcWEI5fZPb3RtVIZpbw7ravQoctDAuyGRUPeBO/3bYVJlwH0iCzWlfE
        RnFV/7gSbFNp7IOm1fk1imqr3RP7JpwOMZAvooCrFStqhusNUrghw99i00sKgtt5L8jLjY
        AeUWNsKKkPDhk2r5p1tVwsa7sLk1b4Q=
Date:   Sat, 27 Mar 2021 22:48:10 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     kernel test robot <lkp@intel.com>
Cc:     Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kbuild-all@lists.01.org, linux-crypto@vger.kernel.org,
        linux-btrfs@vger.kernel.org, squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Chris Mason <chris.mason@fusionio.com>,
        Petr Malat <oss@malat.biz>
Subject: Re: [PATCH v8 1/3] lib: zstd: Add kernel-specific API
Message-ID: <20210327214810.ldijpbr2tnkh2gce@spock.localdomain>
References: <20210326191859.1542272-2-nickrterrell@gmail.com>
 <202103271719.VoxPHugN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103271719.VoxPHugN-lkp@intel.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello.

On Sat, Mar 27, 2021 at 05:48:01PM +0800, kernel test robot wrote:
> >> ERROR: modpost: "ZSTD_maxCLevel" [fs/f2fs/f2fs.ko] undefined!

Since f2fs can be built as a module, the following correction seems to
be needed:

```
diff --git a/lib/zstd/compress/zstd_compress.c b/lib/zstd/compress/zstd_compress.c
index 9c998052a0e5..584c92c51169 100644
--- a/lib/zstd/compress/zstd_compress.c
+++ b/lib/zstd/compress/zstd_compress.c
@@ -4860,6 +4860,7 @@ size_t ZSTD_endStream(ZSTD_CStream* zcs, ZSTD_outBuffer* output)
 
 #define ZSTD_MAX_CLEVEL     22
 int ZSTD_maxCLevel(void) { return ZSTD_MAX_CLEVEL; }
+EXPORT_SYMBOL(ZSTD_maxCLevel);
 int ZSTD_minCLevel(void) { return (int)-ZSTD_TARGETLENGTH_MAX; }
 
 static const ZSTD_compressionParameters ZSTD_defaultCParameters[4][ZSTD_MAX_CLEVEL+1] = {
```

Not sure if the same should be done for `ZSTD_minCLevel()` since I don't
see it being used anywhere else.

-- 
  Oleksandr Natalenko (post-factum)
