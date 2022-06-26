Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934E755B16E
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jun 2022 13:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiFZLMi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jun 2022 07:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbiFZLMh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jun 2022 07:12:37 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5050F14083;
        Sun, 26 Jun 2022 04:12:36 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id fi2so13400509ejb.9;
        Sun, 26 Jun 2022 04:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N6dLqEiFUVhyOT2Oi0mYoUX+LKu3KUGpm3OoFD9jDr0=;
        b=Mns7/HuyuOY0O3axXDwhuxxoPT/0mdwpJNfNwMtaYzNw8EghJHoA9yzFw/9Jawvag/
         RZkuW+aa/LQsebnv4W7qZk3Upnbzm2XmqCQFfetU87NnrbFY4un0XT6JREDDxrg+puzO
         voDQty7jHi7ceCus+JQZth4msSPY3rfkOlO51Ud2+ShE3iHNHhVqPMB3lYCDzZPjZuXi
         BXc9MtCzfMU1T9NsKO/tBSGSqhsd0lZzXj3rvXVueVOIOZJWh1mdnCCMqdEwhtUSkdiI
         ZGb1QCMgiSR/XBFFzBcPlN9JqbLk5kltO9E70TuOCOwLdoJ68hsQaCL4BcdCTOP243Oz
         ABMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N6dLqEiFUVhyOT2Oi0mYoUX+LKu3KUGpm3OoFD9jDr0=;
        b=DxlsEtX8DwBBzFhn6dugWoqsfeECxzlq02b7B2OTB9WSdC+wXt1BdPDMyEgjsLjvjo
         lt9xJP48JU+uCRQLReCaOBc4I6sdzbsYxsq441pAih1XY8PPIwb7kIXwXUlmhvBSeCZ+
         9FHOgo+EwWc3/5lgn8qZQPWBdpXQhb/awouw1vN8vYD+iGN+gLIncCg2kI11FryEEuaD
         vpYBydfZ3oJTfNLvPbUm8uQtkWzKGZ8hTrt2xo9bUEl1GDYzN2Fntf7rMDLH82lSZ2UQ
         2IKfvfQOIZrDbbcabwY1G+bCsC6f7g9qlREWoVLC4zsSHkU14BShj5OVKWo8A3prqvYa
         yimQ==
X-Gm-Message-State: AJIora86OffYMVigVLxtyMKPaMg2Aye8J4Jljpn0VYLp6nE9NQtblHE3
        CImKgTNS4k/8UOwJRQdFFXk=
X-Google-Smtp-Source: AGRyM1suGq/KD5mpzsSiyHVWqJ4zUnqnfvcAFvTBvWC3Wic6LaqR4l3n9LQSP9Zj2ho1z5/UnTWvbw==
X-Received: by 2002:a17:907:1b28:b0:6fe:fc41:35ce with SMTP id mp40-20020a1709071b2800b006fefc4135cemr7875894ejc.153.1656241954751;
        Sun, 26 Jun 2022 04:12:34 -0700 (PDT)
Received: from opensuse.localnet (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id i3-20020a170906444300b006feec47dae7sm3713749ejp.149.2022.06.26.04.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 04:12:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>
Cc:     Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] btrfs: Convert zlib_compress_pages() to use kmap_local_page()
Date:   Sun, 26 Jun 2022 13:12:31 +0200
Message-ID: <2656130.mvXUDI8C0e@opensuse>
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
> >> With kmap_local_page(), the mapping is per thread, CPU local and not 
> >> globally visible.
> >>
> >> Therefore, use kmap_local_page() / kunmap_local() in
> >> zlib_compress_pages() because in this function the mappings are per 
> >> thread and are not visible in other contexts.
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
> >> Wenruo".
> >> https://lore.kernel.org/linux-btrfs/
d0bfc791b5509df7b9ad44e41ada197d1b3149b3.1655519730.git.wqu@suse.com/
> >>
> > 
> > I've seen that Qu sent a v2 of the above patch. However David thinks 
> > that it is better not to map pages allocated in zlib.c for output 
> > (out_page) since they cannot come from highmem because of 
> > "alloc_page(GFP_NOFS);".
> > 
> > @David:
> > 
> > I suppose that, since it builds _only_ on top of the refactor submitted 
> > by
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

Thanks Qu,

I have already made a patch to zlib_compress_pages() in accordance to what 
David asked for, but I cannot compile and test it. 

With last week update of Tumbleweed, openSUSE dropped GCC-10 for x86_32, so 
we've been left only with GCC-7. With GCC-7 I cannot any longer build 
5.19.rc3 because it fails somewhere in drm/i915 (where code has not changed 
since April 2022).

I suppose it's just a mistake which they will fix within few days. 

I'm pretty sure that my patch works properly, however I'm not comfortable 
to submit it with no successful build and tests.

Again thanks,

Fabio



