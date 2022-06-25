Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C9155AB0C
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jun 2022 16:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiFYOlM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jun 2022 10:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiFYOlL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jun 2022 10:41:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C553A1A3;
        Sat, 25 Jun 2022 07:41:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id cw10so10304645ejb.3;
        Sat, 25 Jun 2022 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1HzW1IrxtxLnfOkRiTY/Z3Afa6/8aaGWZ9dIAJbG2Nk=;
        b=R3+UDhDCGX4rc58cacrJwlaS7YBXY12lSKcE40nLJhiTgo2O2pWvKnmBBVnAeHaHB+
         mrO8Tu9kGNcKiO05FclIWt1NPKIdqgZ+m+CU/fWj+3WGIogre1ZFn/fsrGyc//2f2bKs
         U7YbsxS+p+punYMSmrZkq4Cq02FxbKah6YuARjfTx0fn95Sd3hd+/+PWssrstaZmYE+M
         hylGJV5UufUDg7h2w4/QKQtgbX7AIcjUV62GkPyb3MJxfh0uPnLdVMeMaGyYnp0RdTyU
         MsbJBhVLNNsrUokQ/K6Tp2rQufqBIDZJcHczB2wqxE88L7St/zc2ZjzV4F1H63UU5NkT
         YzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1HzW1IrxtxLnfOkRiTY/Z3Afa6/8aaGWZ9dIAJbG2Nk=;
        b=NBvACxsDp62GH/uuo6BrhgtZMKi2QHRF+QPg8gQria7Ikc6Dl+qaNg8qWGmbi0SOd5
         QKwhnyo8lPS7XshAB3ZAI4HwjXQJHRBBNYcih8AdvGRQ3YtkrmmDIAWdXGcOSCiCq3Jy
         BVvcOP0qOo1dzUvUV4PzS1KVRWn2DvH007IV8wzOz9UoRYZnS1YTXU8jMWoSpW1GaxuN
         EHS0d7JiJ0/ANf2TXHvtb/XyvIDv9zTOZJxk8z2GFSTbHOQqDMRJE4998lgQTuvnicLa
         QOMSRXk/R3mxqLuGavR5U9xWtZUVjTUYzDtStHhV38BIvXhqqZA9th09N9w20fhzknFU
         Ae5w==
X-Gm-Message-State: AJIora8oMmTSsdtp75xVkpNgU5/9IQ3lmJ/O4X++uqe4PEZigWKt+tlD
        KBvWZeBc/3Bs0c1ZaDPw9Yc=
X-Google-Smtp-Source: AGRyM1vCGcLpPTTUrdXyFGNwK+QTNn9TSbEcT1j8rWJnoLHXAOTR9tld7lqxnxZ7Bm/8j9D7VzWafA==
X-Received: by 2002:a17:906:2bda:b0:726:3b59:3ea9 with SMTP id n26-20020a1709062bda00b007263b593ea9mr4094197ejg.43.1656168068221;
        Sat, 25 Jun 2022 07:41:08 -0700 (PDT)
Received: from opensuse.localnet (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090669c400b006fe9f9d0938sm2731821ejs.175.2022.06.25.07.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 07:41:06 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] btrfs: Convert zlib_compress_pages() to use kmap_local_page()
Date:   Sat, 25 Jun 2022 16:41:04 +0200
Message-ID: <3110135.5fSG56mABF@opensuse>
In-Reply-To: <20220618092752.25153-1-fmdefrancesco@gmail.com>
References: <20220618092752.25153-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On sabato 18 giugno 2022 11:27:52 CEST Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page(). With
> kmap_local_page(), the mapping is per thread, CPU local and not globally
> visible.
> 
> Therefore, use kmap_local_page() / kunmap_local() in 
zlib_compress_pages()
> because in this function the mappings are per thread and are not visible
> in other contexts.
> 
> Tested with xfstests on QEMU + KVM 32-bit VM with 4GB of RAM and
> HIGHMEM64G enabled. This patch passes 26/26 tests of group "compress".
> 
> Cc: Qu Wenruo <wqu@suse.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> This patch builds only on top of
> "[PATCH] btrfs: zlib: refactor how we prepare the input buffer" by Qu 
Wenruo".
> https://lore.kernel.org/linux-btrfs/
d0bfc791b5509df7b9ad44e41ada197d1b3149b3.1655519730.git.wqu@suse.com/
> 

I've seen that Qu sent a v2 of the above patch. However David thinks that 
it is better not to map pages allocated in zlib.c for output (out_page) 
since they cannot come from highmem because of "alloc_page(GFP_NOFS);".

@David:

I suppose that, since it builds _only_ on top of the refactor submitted by 
Qu, I'll have to wait and see what you decide. 

If you don't want kmap_local_page() and prefer using page_address() on 
"out_page", please drop this patch and let me know, so that I can send a 
new patch which will be in accordance to your preference.

Thanks,

Fabio


