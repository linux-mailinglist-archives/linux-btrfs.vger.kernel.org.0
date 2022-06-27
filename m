Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B267555D5E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbiF0Qlz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 12:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiF0Qly (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 12:41:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5541B1AF12;
        Mon, 27 Jun 2022 09:41:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c65so13889406edf.4;
        Mon, 27 Jun 2022 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0mC8mzi/jaarU/OrNOaKnZVQdlUEInFcBOCed7XUxr0=;
        b=kbzo+PsiRkcM5dTT8fdX4WV4iENEoUxCYW2CddFPjpZxqal+fgJbjhFHpWPbj5omAL
         ZGHjCYpSQtbpZTlBaCpcALvPpBUzRtCKDg/slee24P2ymqbVNNdrNzl7bSYHfcw3jwZF
         HRJKJ/4KEAqLz2Y6PMwhxqIKdB4XVW4+MbzCsZi3IrLYRHQaRCHsSaB/ExUaCZokrWqq
         Rud7hCoJcdKbdJ6d8gL2YYKAtMj+kf+48V+3Ky2KQ4PnYVGsSaeL2sVCXPTg2KE5VD9F
         ogPB+Izbyk/1++n5gNtrOFat64BN+8Vj0FlV02MonZ3OlpcRQeAW9NOq2cl5OLowZHI1
         UAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0mC8mzi/jaarU/OrNOaKnZVQdlUEInFcBOCed7XUxr0=;
        b=FmNWIgN8KX7frAj0mXF+VqIE++hfEDqZKVIqLq1HfcKvot6Wl6KOC1+n2n5oYJ+Ml/
         HRp7tq62AHhhJ0KimaseB7u5kcoZ0XqAHVWBIHE4z7J8z6LWDaVTsLs/beV9oFXdliLl
         YF+C7UC5WI0JM1GIOsk8kbtOsdqnzhFb9SOjfNpUQrBoY3evajeDswabbDrZCYYCCqX3
         hSup3YJ8ANGbKxnDPAfFDQQ7ElC7gcCz86S+8w4AFAaqyWjQxqBv88H8oPn5qVQ6/9zP
         iHiaXU7LrVwDE8JBF786rwKPm+jZ5WTSkqgTiOB8ikSHJ1Z2bmAp2FQ6Vbh1b+A0fVI8
         dFPg==
X-Gm-Message-State: AJIora9elyoHft7vvXvilBEkl6jnL3pVxHctdxcLbXfWwNw7QKm9rppJ
        5QV707tiT96oN7jK+XNEbTQzN6b/2k4=
X-Google-Smtp-Source: AGRyM1vEzZ/XR429uHlquc6xpUF0+si7tXW+adD1gD8/rRQdnTARQsRh3rSv5hZvswYb13F/xjENzQ==
X-Received: by 2002:a05:6402:4496:b0:435:d605:6ff8 with SMTP id er22-20020a056402449600b00435d6056ff8mr17607761edb.357.1656348111910;
        Mon, 27 Jun 2022 09:41:51 -0700 (PDT)
Received: from opensuse.localnet (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id d2-20020aa7d682000000b0042dddaa8af3sm7773265edr.37.2022.06.27.09.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:41:50 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] btrfs: Convert zlib_compress_pages() to use kmap_local_page()
Date:   Mon, 27 Jun 2022 18:41:49 +0200
Message-ID: <4412617.LvFx2qVVIh@opensuse>
In-Reply-To: <f65fd4fb-675a-3f9e-accb-77db9ad7d551@suse.com>
References: <20220618092752.25153-1-fmdefrancesco@gmail.com> <3110135.5fSG56mABF@opensuse> <f65fd4fb-675a-3f9e-accb-77db9ad7d551@suse.com>
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

On domenica 26 giugno 2022 01:03:55 CEST Qu Wenruo wrote:
> 
> On 2022/6/25 22:41, Fabio M. De Francesco wrote:
> > On sabato 18 giugno 2022 11:27:52 CEST Fabio M. De Francesco wrote:
> >> The use of kmap() is being deprecated in favor of kmap_local_page(). 
With
> >> kmap_local_page(), the mapping is per thread, CPU local and not 
globally
> >> visible.
> >>
> >> Therefore, use kmap_local_page() / kunmap_local() in
> > zlib_compress_pages()
> >> because in this function the mappings are per thread and are not 
visible
> >> in other contexts.
> >>
> >> Tested with xfstests on QEMU + KVM 32-bit VM with 4GB of RAM and
> >> HIGHMEM64G enabled. This patch passes 26/26 tests of group "compress".
> >>
> >> Cc: Qu Wenruo <wqu@suse.com>
> >> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> >> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> >> ---
> >>
> >> This patch builds only on top of
> >> "[PATCH] btrfs: zlib: refactor how we prepare the input buffer" by Qu
> > Wenruo".
> >> https://lore.kernel.org/linux-btrfs/
> > d0bfc791b5509df7b9ad44e41ada197d1b3149b3.1655519730.git.wqu@suse.com/
> >>
> > 
> > I've seen that Qu sent a v2 of the above patch. However David thinks 
that
> > it is better not to map pages allocated in zlib.c for output (out_page)
> > since they cannot come from highmem because of "alloc_page(GFP_NOFS);".
> > 
> > @David:
> > 
> > I suppose that, since it builds _only_ on top of the refactor submitted 
by
> > Qu, I'll have to wait and see what you decide.
> > 
> > If you don't want kmap_local_page() and prefer using page_address() on
> > "out_page", please drop this patch and let me know, so that I can send 
a
> > new patch which will be in accordance to your preference.
> 
> And that would also make the convert much easier for kmap_local_page() 
> of input pages.
> 
> I'll hold the refactor patch after all the kmap code is converted.
> 
> Thanks,
> Qu

Thanks for holding the refactor patch for the time I needed.

Now zlib.c is converted to kmap_local_page() and tested:
https://lore.kernel.org/lkml/20220627163305.24116-1-fmdefrancesco@gmail.com/

Again thanks,

Fabio



