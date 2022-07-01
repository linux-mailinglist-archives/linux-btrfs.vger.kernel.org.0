Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E1256281E
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Jul 2022 03:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiGAB0N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jun 2022 21:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGAB0M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jun 2022 21:26:12 -0400
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49C4F5A44F
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 18:26:11 -0700 (PDT)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id C4DC52045D
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Jul 2022 10:26:10 +0900 (JST)
Received: by mail-pl1-f200.google.com with SMTP id jg5-20020a17090326c500b0016a020648bcso522730plb.19
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 18:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Oxb9aGmH2iV0cVSLgHDgspflZNiJSJIZXSB9f563UQ=;
        b=2+BdgixOU5LqPlTLL+KWvsYY4NkZ0C6yZB66ZO5UTFRjWI+eYocZXwJMFu+Hga2WKu
         v6A8WbdgoeeOV5W/kH0sa9ePaCocZ0l1Nh7u7mi3lr9R9MPHJk8ML5G8GERMwG4fkZvg
         Gdii3kaWk1tuDdtFVO5ykkEJkECzrsrchHbmO7Tlg6fk6jCwMNeVy+MG+kg7d/vqJmzZ
         fDbiDD8Vv83ZSRc8QhgFVjMmZVnSmfN87hUFhP8TPyNuACb/ylqu9WK07NI0aXufQcfn
         UdjkF4TsfJBm9O4pQVPpUsoJQq8808lpy119E56nZkZNrjfDZgu+MkkaE1nwConuCzJv
         oGZw==
X-Gm-Message-State: AJIora89FqcRXYfuUvhrQkrauQDpnwyoNUZk7xu+2ORCKAwrYyIpkA5M
        pot6p215+FmvE4E90H/nke+/jmbfHwT8IZYqMWMZXV8HZs9E1k5CkalDX8xbPZ3g8LwI8Tp7t6B
        6lettzoa0+W9fOB6yuHpg6G4i
X-Received: by 2002:a17:90b:4b81:b0:1ec:adbe:3b0b with SMTP id lr1-20020a17090b4b8100b001ecadbe3b0bmr13705624pjb.147.1656638769928;
        Thu, 30 Jun 2022 18:26:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ts0xSkra/pF6l/Qh5n5RPpmkJj4eOvZStQqR/cvlLlU2gD/1nwWMrUczmQi4I1j+snNGVOvQ==
X-Received: by 2002:a17:90b:4b81:b0:1ec:adbe:3b0b with SMTP id lr1-20020a17090b4b8100b001ecadbe3b0bmr13705604pjb.147.1656638769707;
        Thu, 30 Jun 2022 18:26:09 -0700 (PDT)
Received: from pc-zest.atmarktech (145.82.198.104.bc.googleusercontent.com. [104.198.82.145])
        by smtp.gmail.com with ESMTPSA id jh2-20020a170903328200b00161478027f5sm14158667plb.150.2022.06.30.18.26.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2022 18:26:09 -0700 (PDT)
Received: from martinet by pc-zest.atmarktech with local (Exim 4.95)
        (envelope-from <martinet@pc-zest>)
        id 1o75Q8-0000zm-5R;
        Fri, 01 Jul 2022 10:26:08 +0900
Date:   Fri, 1 Jul 2022 10:25:58 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Nikolay Borisov <nborisov@suse.com>, Jens Axboe <axboe@kernel.dk>,
        io-uring@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: read corruption with qemu master io_uring engine / linux master
 / btrfs(?)
Message-ID: <Yr5NJnyKoWqAHsad@atmark-techno.com>
References: <YrueYDXqppHZzOsy@atmark-techno.com>
 <Yrvfqh0eqN0J5T6V@atmark-techno.com>
 <20220629153710.GA379981@falcondesktop>
 <YrzxHbWCR6zhIAcx@atmark-techno.com>
 <Yr1XNe9V3UY/MkDz@atmark-techno.com>
 <20220630104536.GA434846@falcondesktop>
 <Yr2ItqlxeII0sReD@atmark-techno.com>
 <20220630125124.GA446657@falcondesktop>
 <Yr2gQh5GaVmTEDW2@atmark-techno.com>
 <20220630151038.GA459423@falcondesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220630151038.GA459423@falcondesktop>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe Manana wrote on Thu, Jun 30, 2022 at 04:10:38PM +0100:
> This may prevent the short reads (not tested yet):
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 7a54f964ff37..42fb56ed0021 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7684,7 +7684,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
>         if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags) ||
>             em->block_start == EXTENT_MAP_INLINE) {
>                 free_extent_map(em);
> -               ret = -ENOTBLK;
> +               ret = (flags & IOMAP_NOWAIT) ? -EAGAIN : -ENOTBLK;
>                 goto unlock_err;
>         }
>  
> Can you give it a try?

This appears to do the trick!
I've also removed the first patch and still cannot see any short reads,
so this would be enough on its own for my case.

-- 
Dominique
