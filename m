Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742E7340249
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 10:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhCRJng (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Mar 2021 05:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229810AbhCRJnO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Mar 2021 05:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616060593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vR/zt2s7jmFTmNYSYREs6HOTCms/TVsSgO4RcvUd91E=;
        b=eHmlWUwi8h2lFL7esIjK3qjocSw0tvKmAf2U8XF9kdvxRfTcu17gpz2epE5X12URja35Ml
        9rOvHkoJFGqrueJc8VhpZHZFfIZO5fKan0Zj7+RLJD9iyJamB4Wu/o1Jgokue4C+Trzmoa
        Ux4sE1G8swpNM6+4c79pbj7StKNXCuU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-Q8-eGq3lOZOIIFnWqnV89w-1; Thu, 18 Mar 2021 05:43:09 -0400
X-MC-Unique: Q8-eGq3lOZOIIFnWqnV89w-1
Received: by mail-yb1-f197.google.com with SMTP id j4so47667792ybt.23
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Mar 2021 02:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vR/zt2s7jmFTmNYSYREs6HOTCms/TVsSgO4RcvUd91E=;
        b=a4gdYeBl0tpPRThAne3HQdUHjhnS6Fq7yamDLqxpmg6f8kcexxlw+MCTR6ojDmKRX7
         QIpDB3XiF0JoeRq9AeQRK8n0A/4kpVK9ed8lokPyOhYfwvWdz6fJ5mZTAt2OclexCWxr
         d0TTh8i3PUDrRClPoUvf0Z7Oa5J5b4GtT5rFicl1Q1uOEUGwzBA4F5dQX0JjdnM4yGXW
         3VuY7Ap7UajiyfmlC/nx7w5SQ2g8D65eXKG6R/Imp74cLyCrmadUQjdtubw1XInzVkSr
         IoWCBwLGsxAfZoB5XKMrpuzGHwlUJjDdNRT5StvkohuhzqYNV5gtQcy9hCRtEf8ylcEA
         u4GQ==
X-Gm-Message-State: AOAM533uWnMHiQrg/hRTv8gvrpOJ+MtRLSB49R95ukbwR9aTgmMEa+SS
        jjqCK+6C9hqvcQuLt5M3xC3sjCRZQYNmb0F4k7wAPRovmgvIHokLYKjiFUaaN0Im6xrQqMjX4Vj
        y1SQqRsADtaL+B7uwFD5aO0iSLjMqAHsOgml9CS8=
X-Received: by 2002:a5b:4a:: with SMTP id e10mr10655647ybp.436.1616060589340;
        Thu, 18 Mar 2021 02:43:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7teWrEEwVymwJ1Z9H+EJZJa3vqMjyeSJinwGp6eJiV+YryR1PGYF1CfUr33dHWjIUEYwiFVCq1qKIL0SqkwE=
X-Received: by 2002:a5b:4a:: with SMTP id e10mr10655630ybp.436.1616060589138;
 Thu, 18 Mar 2021 02:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210316144823.2188946-1-omosnace@redhat.com> <CAHC9VhRoTjimpKrrQ5f04SE7AOcGv6p5iBgSnoSRgtiUP47rRg@mail.gmail.com>
 <YFEAD9UClhwxErgj@zeniv-ca.linux.org.uk>
In-Reply-To: <YFEAD9UClhwxErgj@zeniv-ca.linux.org.uk>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 18 Mar 2021 10:42:57 +0100
Message-ID: <CAFqZXNukusUPp+kO7vxPZBt5ehkpH6EUZ5e8XwUq9adOQHdMkQ@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: fix fsconfig(2) LSM mount option handling for btrfs
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Paul Moore <paul@paul-moore.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 16, 2021 at 8:25 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, Mar 16, 2021 at 02:21:45PM -0400, Paul Moore wrote:
> > On Tue, Mar 16, 2021 at 10:48 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > When SELinux security options are passed to btrfs via fsconfig(2) rather
> > > than via mount(2), the operation aborts with an error. What happens is
> > > roughly this sequence:
> > >
> > > 1. vfs_parse_fs_param() eats away the LSM options and parses them into
> > >    fc->security.
> > > 2. legacy_get_tree() finds nothing in ctx->legacy_data, passes this
> > >    nothing to btrfs.
> > > [here btrfs calls another layer of vfs_kern_mount(), but let's ignore
> > >  that for simplicity]
>
> Let's not.  This is where the root of the problem actually lies.  Take a look
> at that sucker:
>
>         struct fs_context *fc;
>         struct vfsmount *mnt;
>         int ret = 0;
>
>         if (!type)
>                 return ERR_PTR(-EINVAL);
>
>         fc = fs_context_for_mount(type, flags);
>         if (IS_ERR(fc))
>                 return ERR_CAST(fc);
>
>         if (name)
>                 ret = vfs_parse_fs_string(fc, "source",
>                                           name, strlen(name));
>         if (!ret)
>                 ret = parse_monolithic_mount_data(fc, data);
>         if (!ret)
>                 mnt = fc_mount(fc);
>         else
>                 mnt = ERR_PTR(ret);
>
>         put_fs_context(fc);
>         return mnt;
>
> That's where the problem comes - you've lost the original context's ->security.
> Note that there's such thing as security_fs_context_dup(), so you can bloody
> well either
>         * provide a variant of vfs_kern_mount() that would take 'base' fc to
> pick security options from or
>         * do all options parsing on btrfs fc and then do fs_context_for_mount +
> security_fs_context_dup + copy (parsed) options to whatever private data you
> use for btrfs_root context + fc_mount + put_fs_context yourself.
>
> My preference would be the latter, but I have *not* looked at btrfs mount options
> handling in any details.

Ack, I'll look into that. I didn't dare to try to touch btrfs mount
handling (if it was straightforward, someone would've already done it,
right? :), but it sounds like converting just this one
vfs_kern_mount() could be relatively easy, would fix the bug, and
would be an incremental improvement.

>
> > VFS folks, can we get a verdict/feedback on this patch?  The v1 draft
> > of this patch was posted almost four months ago with no serious
> > comments/feedback.  It's a bit ugly, but it does appear to work and at
> > the very least SELinux needs this to handle btrfs properly, other LSMs
> > may need this too.
>
> It's more than a bit ugly; it perpetuates the use of FS_BINARY_MOUNTDATA,
> and the semantics it gets is quite counterintuitive at that.

Fair enough.

Thank you for the feedback and hints!

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

