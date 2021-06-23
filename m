Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E143B213F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 21:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFWTgB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 15:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWTgB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 15:36:01 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7785AC06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 12:33:43 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g21so1440119pfc.11
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 12:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7uvlXT9n9h2vcjoz9EQ0AwVuk/OLyzz6PrQlBgV/oJY=;
        b=Z78y3Jajvx4zdAHzMgNOM8z0BlLblDUbtKS7wooNtEE4FNmteQKFuh5vRZ9gK/Djzd
         N/9cDrT0+Wi+v/2sKxd1qu4Mh15n2GgUbj1kuXK4ECov9ifXJEGnC7XBujUdnH2gX1+F
         abrzlF8FELSWdUA7xjMSOA2qsNPSquQUN5NLAC3K+8xpJQrSxDpeqTdHSpa5FuO3gKCu
         AG2nEL1yer2O+SkDGGLIKAyIlfgQCUPJ/1Po2OVEz25IUGIVeKKRxQfu3bbf20hvJ7Es
         uKeLQUIV4fydkXLozVif+AZmDtTAmP3emvQSqoAEltzXlJm3hrcPI97wIl34xJ9sB1+N
         d0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7uvlXT9n9h2vcjoz9EQ0AwVuk/OLyzz6PrQlBgV/oJY=;
        b=rCDL97EZtDPHLODqPqBHu6oMij1y5a0BcWlz/MMWri/pLeSc491GOIyt8QstgwjVUY
         wwPvbsminfpdiLYOwm4Po6o4KAGPUZiQJ6tGhMD3nm1IqKw6SHvKYKkSscyiOY7zMrN3
         Ws3VrEf0ba7j61u89O1+/pUVoUasUS1dzjWmtF0euvb5ZKy4iJ9O4tD1o//BgiDPTAXO
         KCyCDmfBE1NfIu5i7JSMWcgRs160LiToPVjDeqCraMibtLl9uQ8HCw39o89K7ATsWUdd
         Fi5AkwWERT+1KE+gNlOzTjeqOSh8ukt27NtAo9hWyNdyreyU0CpMm7nyzkIBKROYuSVY
         6DKQ==
X-Gm-Message-State: AOAM533sM7VflZsE/8nI+jawyrHReDdQoxzinHdFOrvsc2ka3B3FClwW
        5hNA8sZz/ba5XkOwNmSQ8KK72w==
X-Google-Smtp-Source: ABdhPJyv797gApXvHSje2rYbEqcUk75OZvVQFumwcVG+dEiF2kMAoHpw6Ch6ECe4Q8K65NLE8mumWQ==
X-Received: by 2002:a63:2011:: with SMTP id g17mr979795pgg.195.1624476822679;
        Wed, 23 Jun 2021 12:33:42 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:e167])
        by smtp.gmail.com with ESMTPSA id o3sm656727pfd.41.2021.06.23.12.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 12:33:41 -0700 (PDT)
Date:   Wed, 23 Jun 2021 12:33:40 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YNOMlLZWdaNlEJtZ@relinquished.localdomain>
References: <YM0Zu3XopJTGMIO5@relinquished.localdomain>
 <YM0fFnMFSFpUb63U@zeniv-ca.linux.org.uk>
 <YM09qaP3qATwoLTJ@relinquished.localdomain>
 <YNDem7R6Yh4Wy9po@relinquished.localdomain>
 <CAHk-=wh+-otnW30V7BUuBLF7Dg0mYaBTpdkH90Ov=zwLQorkQw@mail.gmail.com>
 <YND6jOrku2JDgqjt@relinquished.localdomain>
 <YND8p7ioQRfoWTOU@relinquished.localdomain>
 <20210622220639.GH2419729@dread.disaster.area>
 <YNN0P4KWH+Uj7dTE@relinquished.localdomain>
 <CAHk-=wjptRD=dzst-=O0D_X2q0kU2ijdTEjrg0=vvtqdjJ_x8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjptRD=dzst-=O0D_X2q0kU2ijdTEjrg0=vvtqdjJ_x8g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 23, 2021 at 11:28:15AM -0700, Linus Torvalds wrote:
> On Wed, Jun 23, 2021 at 10:49 AM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > Al, Linus, what do you think? Is there a path forward for this series as
> > is?
> 
> So the "read from user space in order to write" is a no-go for me. It
> completely violates what a "read()" system call should do. It also
> entirely violates what an iovec can and should do.
> 
> And honestly, if Al hates the "first iov entry" model, I'm not sure I
> want to merge that version - I personally find it fine, but Al is
> effectively the iov-iter maintainer.
> 
> I do worry a bit about the "first iov entry" simply because it might
> work for "writev2()" when given virtual user space addresses - but I
> think it's conceptually broken for things like direct-IO which might
> do things by physical address, and what is a contiguous user space
> virtual address is not necessarily a contiguous physical address.
> 
> Yes, the filesystem can - and does - hide that path by basically not
> doing direct-IO on the first entry at all, and just treat is very
> specially in the front end of the IO access, but that only reinforces
> the whole "this is not at all like read/write".
> 
> Similar issues might crop up in other situations, ie splice etc, where
> it's not at all obvious that the iov_iter boundaries would be
> maintained as it moves through the system.
> 
> So while I personally find the "first iov entry" model fairly
> reasonable, I think Dave is being disingenuous when he says that it
> looks like a normal read/write. It very much does not. The above is
> quite fundamental.
> 
> >  I'd be happy to have this functionality merged in any form, but I do
> > think that this approach with preadv2/pwritev2 using iov_len is decent
> > relative to the alternatives.
> 
> As mentioned, I find it acceptable. I'm completely unimpressed with
> Dave's argument, but ioctl's aren't perfect either, so weak or not,
> that argument being bogus doesn't necessarily mean that the iovec
> entry model is wrong.
> 
> That said, thinking about exactly the fact that I don't think a
> translation from iovec to anything else can be truly valid, I find the
> iter_is_iovec() case to be the only obviously valid one.
> 
> Which gets me back to: how can any of the non-iovec alternatives ever
> be valid? You did mention having missed ITER_XARRAY, but my question
> is more fundamental than that. How could a non-iter_is_iovec ever be
> valid? There are no possible interfaces that can generate such a thing
> sanely.

I only implemented the bvec and kvec cases for completeness, since
copy_struct_from_iter() would appear to be a generic helper. At least
for RWF_ENCODED, a bvec seems pretty bogus, but it doesn't seem too
far-flung to imagine an in-kernel user of RWF_ENCODED that uses a kvec.

One other option that we haven't considered is ditching the
copy_struct_from_user() semantics and going the simpler route of adding
some reserved space to the end of struct encoded_iov:

struct encoded_iov {
	__aligned_u64 len;
	__aligned_u64 unencoded_len;
	__aligned_u64 unencoded_offset;
	__u32 compression;
	__u32 encryption;
	__u8 reserved[32];
};

Then we can do an unconditional copy_from_user_full(sizeof(struct
encoded_iov)) and check the reserved space in the typical fashion.

(And in the unlikely case that we use up all of that space with
extensions, I suppose we could have an RWF_ENCODED2 with a matching
struct encoded_iov2.)
