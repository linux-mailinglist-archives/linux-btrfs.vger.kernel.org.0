Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F36151F0E6
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 May 2022 21:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiEHT7H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 May 2022 15:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiEHT7E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 May 2022 15:59:04 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E4DBC98
        for <linux-btrfs@vger.kernel.org>; Sun,  8 May 2022 12:55:12 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e194so13289125iof.11
        for <linux-btrfs@vger.kernel.org>; Sun, 08 May 2022 12:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eE72BXyLLF8Sp5syGPkm7f0h7nyZ/czNJlBCVcOMENQ=;
        b=7eDE31n7RkAQg7WkLBoIwLpcnD3uqrSFqqR+gN1ahl6FOri+AZMJ+A9fumsrUq4HKM
         jxdJJPCYSZyMvt8FnVEGhIFs4ZwJpLHtnpXomRJZSOjgwO2fLCvwcyjtlaZXDBDJesHj
         842I3PrfOqsXIdWiN2oXVUGhewPbqwcoWkGwWMNF0h/7X57gtoPxw3XCidzEngKTcTQQ
         1CawUxVdudbpkxmMJ6jNQqxNeWD0zIqIgFf2afU2tLbgpdCDt5Z9zMdcN7IMKZux3wco
         YAN9lilSqNxmEx1cJU9bvLfUuVJS9gm5Lw7UWhhsSU3gFEKA2CqxM4R+OO2v/9HCx8NT
         xTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eE72BXyLLF8Sp5syGPkm7f0h7nyZ/czNJlBCVcOMENQ=;
        b=SyNvPSRK2QYZX9cQUmErceKLVoQi7vbjU/BqzfTRhaRGH4KdF1AK0gpc8ZfQ3GOvrL
         3NEKT9+HD6AqTn4LCMGdA1z3SlUs5xzlY2ROG0EW92lOfbSp1f0RO7VOIE8WJOxZWaiO
         KvBJUAtf7YuLn/SUMDlnrEDB5qaYDAhQoKI8rXB2XtraJyryRb3S8teMQNFruVKvpOiy
         61x4XzfiLgqMPAL6/4xAhxZVT0qiRM5Ip9XYz70alh/JKEe4vtKGOOxR01e+sTmUMd6+
         kY1d60VZTcI4VNvIjxXRigQMvwI0rcA9XLIp+mVePdhTI1pe0v8zVYR5geIz1hjWQPHP
         NhZg==
X-Gm-Message-State: AOAM532X4xe0b06REWAbcIzC8eMy62NOub3Jdg+zYZL36PBRvSy5QC55
        U4HAYfybhhvH8YRrho7OUbH3ewTFURmBO2wBPkSLPX2VKzo=
X-Google-Smtp-Source: ABdhPJysL9iUGPTSkdrvH0OTVFGEjMAIrH/I6QMBwQTHBVNl7C5v1IFHfbe4+i6PI15QnedbMlaPkNG5i0P9yHIW/7Y=
X-Received: by 2002:a02:ccd0:0:b0:32a:e2da:1e1f with SMTP id
 k16-20020a02ccd0000000b0032ae2da1e1fmr5753244jaq.313.1652039711992; Sun, 08
 May 2022 12:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqdegGAkJmdpzqeLJrFNwkfkMMWEdFxkVQnfA0DvdK5_Zg@mail.gmail.com>
 <20220503172425.GA12542@merlins.org> <20220505150821.GB1020265@merlins.org>
 <CAEzrpqfx3_BxSFPOByo5NY43pWOsQbhcCqU1+JqGAQpz+dgo7A@mail.gmail.com>
 <20220506031910.GH12542@merlins.org> <CAEzrpqfHzZrMuWrMERM-m4ASsuJAsijU9tpk_e5OML8dpgMeKg@mail.gmail.com>
 <CAEzrpqdzdimQvXyhpDomvPgDXx5Dn9QCEKQMiXofTFb3WvWUJQ@mail.gmail.com>
 <20220507153921.GG1020265@merlins.org> <CAEzrpqcRT6CqJJPYqW5AH+x0XvUCMd-EMEq-=SwtTL-Fn4pcvQ@mail.gmail.com>
 <20220507193628.GO12542@merlins.org> <20220508194557.GP12542@merlins.org>
In-Reply-To: <20220508194557.GP12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 8 May 2022 15:55:01 -0400
Message-ID: <CAEzrpqej2giQzLDcxsfze=e=uYOyMEh1v25V3R2xP_AEeHUAsw@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 8, 2022 at 3:45 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sat, May 07, 2022 at 12:36:28PM -0700, Marc MERLIN wrote:
> > On Sat, May 07, 2022 at 02:58:38PM -0400, Josef Bacik wrote:
> > > Did any of the previous ones succeed?  I hope so and we just have one
> > > misbehaving thing.  I've pushed more debugging, maybe it's a large
> > > file that has a lot of broken extents, in either case it'll tell us
> > > what's going on so I can narrow down the problem.  Thanks,
> >
> > Ok, the debugging helps, now I can see that it's deleting different
> > blocks for the same filename.
> > Before I couldn't quite tell if it was making progress, but now I see
> > it's deleting new locations.
> > Looks like I have 100s of deletions coming up, thanks for automating
> > this.
> >
> > Will report back, it looks like it may run for a few hours
> >
> > Afer that just do a
> > check --repair
> > or some other command options?
>
> Ok, so I got 33GB of output, so glad the tool is automated and the tool
> died eventually.
> I'll re-run under gdb, at least it did a lot of work.
>
> searching 165298 for bad extents
> processed 108707840 of 108756992 possible bytes, 99%
> Found an extent we don't have a block group for in the file
> inode ref info failed???
> History/Clubbing/20220318_Pure_Markus_Schulz.mp4
> Deleting [76600, 108, 111673344] root 13576824389632 path top 13576824389632 top slot 24 leaf 11821927333888 slot 52
>
> searching 165298 for bad extents
> processed 108707840 of 108756992 possible bytes, 99%
> Found an extent we don't have a block group for in the file
> inode ref info failed???
> History/Clubbing/20220318_Pure_Markus_Schulz.mp4
> Deleting [76600, 108, 228950016] root 13576824406016 path top 13576824406016 top slot 24 leaf 11821927350272 slot 52
>
> searching 165298 for bad extents
> processed 108756992 of 108756992 possible bytes, 100%
> searching 165299 for bad extents
> processed 75792384 of 75792384 possible bytes, 100%
> searching 18446744073709551607 for bad extents
> processed 16384 of 16384 possible bytes, 100%
> Recording extents for root 3
> Floating point exception
>

Oops that's probably a divide by 0 for my fancy pct thing, I fixed it
up and pushed.  Thanks,

Josef
