Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DF35A9F78
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 20:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiIAS5h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiIAS5g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 14:57:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23F472B75
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 11:57:35 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so3636195pjc.3
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Sep 2022 11:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=B/DBgwgk0Zemweo2VIrGiGYhMmOp0fpa1NWWuHRX6lo=;
        b=m1uhGqKuIItslMoWf55iaTNckaV+dWBybBhO4Gy1tCp8l7jprCagAqprLvK/Zwo6Q+
         p+EWkOLUrYZlj0kWi+Nnz/d2XGlbWR+mQ4MCCITwv6CbZpbZn4DBd1ErXLW8/PhIzptw
         9n2hEBPZPmxug6e8JasvByt6QdnbCWKiJcQGfVKa+JA7JLyvrM2LYs7cRZ2wXn/akXxW
         hKbCh6aL5alg5ClrFsQEe5WpPbRum8yFIrFUMhyA2AVdMr2ssaMTx21BQSRSjvRGS0lC
         KOmfLc5Cq/ZgdJr7MtCqqh+15naZKcODNa/8ufhk3qTv0Hl1EdxC1YAEXebWgeOQmEq8
         Jd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=B/DBgwgk0Zemweo2VIrGiGYhMmOp0fpa1NWWuHRX6lo=;
        b=FOvAN7lXl/d/Rdj/fatvC8N6Ykir/OxPwZjsfX7Lyp+Q3NrfkqFGJ8kVo+hHfvrJiN
         C3unV6K4zx/B4CHbqxtPXy0Gal5eUQ0kxuHfdGjZ0+CgFeOVkIOia+E6qpv4RozDnzNf
         vlKpSMh9Dy2U1K96Bj6ShSydLTCWn6hPasuvoYGx1FxzbgRrVCW2YBtPEp/GEcbhZ+yK
         /XxOvUOWIXT4oKU4oEPZ80XwojK1MF2MteTTBpqPPJoq93l59ysQ/60OcNyKgC+vh/vv
         reVdVaYXRDNS7JSpryXLS3h2mOsCUO7SXtTJd7f5fvJg3zBScsQwTVJBSjjcenDKL1vy
         iS4w==
X-Gm-Message-State: ACgBeo2O9jYIxuIytOnIdjcLto9QcWsvudytiTCEo2zb8UK64lkdyGnT
        D1sVFHKzsHBVVoeCDkP9GoE1+WS4onZoEw==
X-Google-Smtp-Source: AA6agR6TjLsGkMIgacym6uCT7aSuvDc2+mVWVz+8qGmFE5lBO417D/GCD7W3e5VzjwSbplLkU8im+g==
X-Received: by 2002:a17:903:1c8:b0:171:2ed3:6780 with SMTP id e8-20020a17090301c800b001712ed36780mr32738037plh.30.1662058655111;
        Thu, 01 Sep 2022 11:57:35 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:500::594d])
        by smtp.gmail.com with ESMTPSA id a22-20020aa794b6000000b00517c84fd24asm14098658pfl.172.2022.09.01.11.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 11:57:34 -0700 (PDT)
Date:   Thu, 1 Sep 2022 11:57:32 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     Christoph Anton Mitterer <calestyo@scientia.org>,
        Linux BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: fix space cache corruption and potential
 double allocations
Message-ID: <YxEAnNIQEfySgtDn@relinquished.localdomain>
References: <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
 <CAK-xaQZYDBuL2DMeOiZDubujSmZTcNJfkgqa03Q+24=nhCmynw@mail.gmail.com>
 <dbc8b0ee60b174f1b2c17a7469918a32a381c51b.camel@scientia.org>
 <Yv2A+Du6J7BWWWih@relinquished.localdomain>
 <b5d37d4d059e220313341d2804cbf1daf2956563.camel@scientia.org>
 <Yv2IIwNQBb3ivK7D@relinquished.localdomain>
 <467e49af8348d085e21079e8969bedbe379b3145.camel@scientia.org>
 <751cc484a56fc0bbe3838929feae3c214c297001.camel@scientia.org>
 <YxD3iM29bDpnxeNg@relinquished.localdomain>
 <a4de8453-780f-3483-724f-a97a692fe3e5@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4de8453-780f-3483-724f-a97a692fe3e5@applied-asynchrony.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 08:52:44PM +0200, Holger Hoffstätte wrote:
> On 2022-09-01 20:18, Omar Sandoval wrote:
> > On Thu, Sep 01, 2022 at 06:59:05PM +0200, Christoph Anton Mitterer wrote:
> > > Hey.
> > > 
> > > Now that the first stable kernel with the fix is out,... is there going
> > > to be any more information on how people can asses the impact of this
> > > issue on their data integrity?
> > > 
> > > I had asked some questions below, but I guess for me, personally, it
> > > would also be okay to just recreate the potentially affected
> > > filesystems from backups, if it cannot be determined for sure whether
> > > any corruptions have happened (especially in both data or metadata).
> > > 
> > > 
> > > Also anything expectations on when the announced tool for this might
> > > become available?
> > > 
> > > Thanks,
> > > Chris.
> > 
> > The tool is here for now:
> > https://github.com/osandov/osandov-linux/blob/master/scripts/btrfs_check_space_cache.c
> > 
> > Please try it out with:
> > 
> > git clone https://github.com/osandov/osandov-linux.git
> > cd osandov-linux/scripts
> > make btrfs_check_space_cache
> > sudo ./btrfs_check_space_cache $MOUNTED_FILESYSTEM_PATH
> > 
> > It'll print out a diagnosis and some advice. Please let me know what
> > output it gives you and any suggestions you have.
> > 
> 
> Thank you! Got two warnings though, with both gcc-12 and clang-14:
> 
> gcc $(echo $CFLAGS) -Wall btrfs_check_space_cache.c -o btrfs_check_space_cache
> btrfs_check_space_cache.c: In function 'check_free_space_tree':
> btrfs_check_space_cache.c:346:58: warning: taking address of packed member of 'struct btrfs_free_space_info' may result in an unaligned pointer value [-Waddress-of-packed-member]
>   346 |                         expected_extent_count = get_le32(&info->extent_count);
>       |                                                          ^~~~~~~~~~~~~~~~~~~
> btrfs_check_space_cache.c:347:45: warning: taking address of packed member of 'struct btrfs_free_space_info' may result in an unaligned pointer value [-Waddress-of-packed-member]
>   347 |                         bitmaps = (get_le32(&info->flags)
>       |                                             ^~~~~~~~~~~~
> 
> I know this will work on Intel but don't remember what might happen on other arches.

The warning is bogus; get_le32() handles unaligned pointer values. FWIW,
the Makefile I provided passes -Wno-address-of-packed-member.

> Anyway it seems to work fine:
> 
> --snip--
> $./btrfs_check_space_cache /mnt/backup
> Space cache checker 1.0
> retries = 2, freeze = 0
> Running on Linux 5.19.6 #1 SMP PREEMPT_DYNAMIC Mon Aug 29 13:34:50 CEST 2022 x86_64
> Free space tree is enabled
> 
> No corruption detected :)
> 
> You should install a kernel with the fix as soon as possible and avoid
> rebooting until then.
> 
> Once you are running a kernel with the fix:
> 
> 1. Run this program again.
> 2. Run btrfs scrub.
> --snip--
> 
> cheers
> Holger

Thanks for testing! Something like 0.01% of our machines running with
the free space tree hit the bug, and that was with a very specific
trigger, so I'll be surprised if many people hit it in practice.
