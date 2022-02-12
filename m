Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AFD4B342F
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Feb 2022 11:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiBLKRP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Feb 2022 05:17:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbiBLKRO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Feb 2022 05:17:14 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E8B2611C
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Feb 2022 02:17:10 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w20so6588159plq.12
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Feb 2022 02:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tOdniQ8B2cbwxCGOA8TU393kbFHy4HBNMpam7J7Gm7Q=;
        b=kg94rXiLtQ1vfrudx5IGj4ONakFDrJOxTQRhYw/rh8hSyMEDPW4cei2Zf8Y/2y3Tt7
         tk7uwheEpuBRyhOiV9iPU5Nm15tjQPmndUQx9TUBOicR0tNvIcPguD+5pzFq8xm1C09Y
         oNT7gmihoBeslwyYrtzwRKxKV7P+D977h8Caly4cOjLp0tj/MJCVv++HU/YO2zZmvxJH
         zUa5yyIGQok49CKk82LyFJnuX3QLBlE6OPAl+OIPnN81RHwqyKh0tdYRWusSVwfAFSDV
         uizPU1GCaG2JUBbOZkYotwhAi5DyNUBkCjltIe0H4KvsIvYl3ZiM3BFdt20rq1c9jgfo
         apuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tOdniQ8B2cbwxCGOA8TU393kbFHy4HBNMpam7J7Gm7Q=;
        b=MXNwJAOIDcUQUfWeUjutTU47T4CEiyQdU8ekYxJHc2dEWJaYjCnQK2Fq9L8Jws2hQ/
         MxoWI4CrWWuFI5IGJWxw1UD13XG6wlN1jPEX2viJwyrOiQm0gJgy8/BK9rO4ohjHnK85
         UULNr/ZPnWuUF+g62FytgBAjTGl8YX6TyEMDC+8qBSOJ+ZvGpWjvqbo7WWPqcEgTOBRx
         DJFU97zwRYboWOL3FFBUjlK1FqypoGNw1lqSzvsiRkZnCx8OGvxui6kpIjNDjJhQVAoX
         k6KGWk32Xl/c8e4y678D7WKsuMWLg5ceygjdoHLP3JYA/Gt6w7ZQREQ+ibPpXDoudd/D
         5tNw==
X-Gm-Message-State: AOAM5311EZol71VQZfkDZXQlJtK/kmat27NfuuGj0IEnUfKg9yyFPYY5
        s4sgZKYXZMW8JNhbhI/Aykj9LpSNWJI=
X-Google-Smtp-Source: ABdhPJx3gAsJopDMvUD3oa+SZCWoCmUDmOkNvzxpkkiZGSlsxwcMCPe5BZHk+UOxaxN4scQo9D174Q==
X-Received: by 2002:a17:90a:ad81:: with SMTP id s1mr4593783pjq.194.1644661030016;
        Sat, 12 Feb 2022 02:17:10 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id y41sm30980734pfa.213.2022.02.12.02.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 02:17:09 -0800 (PST)
Date:   Sat, 12 Feb 2022 10:17:05 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: Remove outdated TODO comments
Message-ID: <20220212101705.GB1181@realwakka>
References: <20220211134829.4790-1-realwakka@gmail.com>
 <402c8a70-7589-4a29-6c1c-28e0b75e0716@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402c8a70-7589-4a29-6c1c-28e0b75e0716@gmx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 12, 2022 at 08:13:29AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/2/11 21:48, Sidong Yang wrote:
> > These comments are too old and outdated. It seems that it doesn't help.
> > So we can remove those.
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >   fs/btrfs/qgroup.c | 11 -----------
> >   1 file changed, 11 deletions(-)
> > 
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index bfd45d52b1f5..db527c277901 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -25,17 +25,6 @@
> >   #include "sysfs.h"
> >   #include "tree-mod-log.h"
> > 
> > -/* TODO XXX FIXME
> > - *  - subvol delete -> delete when ref goes to 0? delete limits also?
> 
> This is still under concern AFAIK.
> 
> Currently if we delete a subvolume, its qgroup number will changed to 0
> but not removed.

This issue is in btrfs-progs github issue list (#366). It has detailed
description in there. So, I think it's okay to delete this.

Thanks,
Sidong
> 
> Thanks,
> Qu
> 
> > - *  - reorganize keys
> > - *  - compressed
> > - *  - sync
> > - *  - limit
> > - *  - caches for ulists
> > - *  - performance benchmarks
> > - *  - check all ioctl parameters
> > - */
> > -
> >   /*
> >    * Helpers to access qgroup reservation
> >    *
