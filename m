Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBADF35BC5A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Apr 2021 10:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhDLIlr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Apr 2021 04:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhDLIlq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Apr 2021 04:41:46 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21E3C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Apr 2021 01:41:28 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id g5so2682339vkg.12
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Apr 2021 01:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxsblzGY/Moj1guitHWzeSzZOCdlJMhFNWWWaQwEuJo=;
        b=XGCoMSWW+wZj+hdrK+/8KYl1iQe/pnSnQTUMs7xsuK//myT5UioZP8KqLKeCVgtlDO
         lN3sxYvmnl2vGDi71A4jP0MKyvft1ZXCKgZWizsRsKfutEjPkEJRSghx6SNIbsLmsMxQ
         ooipF+jFhvkoWZkdx/R5W4qghRnKujGhZw8J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxsblzGY/Moj1guitHWzeSzZOCdlJMhFNWWWaQwEuJo=;
        b=h+G9JtBZxdEXz7JAD7Xb391+Yn21a25ouy+hfLuio3NnjvsfA0hI0GUqXRM628K9cP
         9TtQhWaZT/bBYMXfmjouCXqIUXSSJIuedQyYR631QolWwxdmc1g7+4gcD6thfunXPU9A
         iMfPy8DMIdsW5uSu+68BRjx80MJNfurooHw0STZpyGvk+aYt6reTAyvINzTwHOfhzYvK
         U1v9KaX2fGtpCfxndRBOmZpCi+NuOifyMbN0qd78+ktiuB+tUf2uD2O23S8LWR+JJA7H
         +jxVKpHEzirPJqL/8ZRGEAX0Wyf3i+Pz1keJqEJEw34vBqgnPSvbxovze2bvzOJaMSNh
         yHYQ==
X-Gm-Message-State: AOAM533/JZnsAQurN/ITbRDL7N+v7g2lEzhejI/7UmHhLuUxeGeBUiyz
        2qZCL5N+osH90PTBU0gmrJ+Sc3nehmEwdJulwanD9A==
X-Google-Smtp-Source: ABdhPJzc1syTEnEb7glVag1dH9wKgqMVlarRMZ/FQThr/sDML1dKql5XaDvL76a1qpkCdc7K2bWCuoX5tJcp2QmdYBQ=
X-Received: by 2002:a05:6122:33:: with SMTP id q19mr18560654vkd.23.1618216888095;
 Mon, 12 Apr 2021 01:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTp0aXBssEr4ZXGX=DS_+RyGghmoANCKDdxG59QWu8LVA@mail.gmail.com>
 <CAOQ4uxht70nODhNHNwGFMSqDyOKLXOKrY0H6g849os4BQ7cokA@mail.gmail.com>
 <CAJCQCtRGdBzyskifrYLbBGAAm0g7VeC6GeD7xBN-hRqE3GAWYA@mail.gmail.com> <CAOQ4uxhU2KX=jKKL5EZ102z_+6KyVKAOoAzSp2K8i0PMGJUg4A@mail.gmail.com>
In-Reply-To: <CAOQ4uxhU2KX=jKKL5EZ102z_+6KyVKAOoAzSp2K8i0PMGJUg4A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 12 Apr 2021 10:41:17 +0200
Message-ID: <CAJfpegtvUfO1H5YX1SnHUpdEk5e46cucZMyPDVC4qu7ds-38RQ@mail.gmail.com>
Subject: Re: btrfs+overlayfs: upper fs does not support xattr, falling back to
 index=off and metacopy=off.
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000c9167b05bfc27ab1"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--000000000000c9167b05bfc27ab1
Content-Type: text/plain; charset="UTF-8"

On Sat, Apr 10, 2021 at 7:55 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sat, Apr 10, 2021 at 8:36 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > I can reproduce the bolt testcase problem in a podman container, with
> > overlay driver, using ext4, xfs, and btrfs. So I think I can drop
> > linux-btrfs@ from this thread.
> >
> > Also I can reproduce the title of this thread simply by 'podman system
> > reset' and see the kernel messages before doing the actual reset. I
> > have a strace here of what it's doing:
> >
> > https://drive.google.com/file/d/1L9lEm5n4-d9qemgCq3ijqoBstM-PP1By/view?usp=sharing
> >
>
> I'm confused. The error in the title of the page is from overlayfs mount().
> I see no mount in the strace.
> I feel that I am missing some info.
> Can you provide the overlayfs mount arguments
> and more information about the underlying layers?
>
> > It may be something intentional. The failing testcase,
> > :../tests/test-common.c:1413:test_io_dir_is_empty also has more
> > instances of this line, but I don't know they are related. So I'll
> > keep looking into that.
> >
> >
> > On Sat, Apr 10, 2021 at 2:04 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > As the first step, can you try the suggested fix to ovl_dentry_version_inc()
> > > and/or adding the missing pr_debug() and including those prints in
> > > your report?
> >
> > I'll work with bolt upstream and try to further narrow down when it is
> > and isn't happening.
> >
> > > > I can reproduce this with 5.12.0-0.rc6.184.fc35.x86_64+debug and at
> > > > approximately the same time I see one, sometimes more, kernel
> > > > messages:
> > > >
> > > > [ 6295.379283] overlayfs: upper fs does not support xattr, falling
> > > > back to index=off and metacopy=off.
> > > >
> > >
> > > Can you say why there is no xattr support?
> >
> > I'm not sure. It could be podman specific or fuse-overlayfs related.
>
> Not sure how fuse-overlayfs is related.
> This is a message from overlayfs kernel driver.
>
> > Maybe something is using /tmp in one case and not another for some
> > reason?
> >
> > > Is the overlayfs mount executed without privileges to create trusted.* xattrs?
> > > The answer to that may be the key to understanding the bug.
> >
> > Yep. I think tmpfs supports xattr but not user xattr? And this example
> > is rootless podman, so it's all unprivileged.
> >
>
> OK, so unprivileged overlayfs mount support was added in v5.11
> and it requires opt-in with mount option "userxattr", which could
> explain the problem if tmpfs is used as upper layer.
>
> Do you know if that is the case?
> I sounds to me like it may not be a kernel regression per-se,
> but a regression in the container runtime that started to use
> a new kernel feature?
> Need more context to understand.
>
> Perhaps the solution will be to add user xattr support to tmpfs..

Attached patch.   Tested at some earlier time, since I also bumped
into this issue.

Thanks,
Miklos

--000000000000c9167b05bfc27ab1
Content-Type: text/x-patch; charset="US-ASCII"; name="tmpfs-allow-user-xattr.patch"
Content-Disposition: attachment; filename="tmpfs-allow-user-xattr.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_knecioh20>
X-Attachment-Id: f_knecioh20

ZGlmZiAtLWdpdCBhL21tL3NobWVtLmMgYi9tbS9zaG1lbS5jCmluZGV4IGQ3MjJlYjgzMDMxNy4u
YWZlNTkwODZiM2Y2IDEwMDY0NAotLS0gYS9tbS9zaG1lbS5jCisrKyBiL21tL3NobWVtLmMKQEAg
LTMyNTAsNiArMzI1MCwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHhhdHRyX2hhbmRsZXIgc2ht
ZW1fdHJ1c3RlZF94YXR0cl9oYW5kbGVyID0gewogCS5zZXQgPSBzaG1lbV94YXR0cl9oYW5kbGVy
X3NldCwKIH07CiAKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgeGF0dHJfaGFuZGxlciBzaG1lbV91c2Vy
X3hhdHRyX2hhbmRsZXIgPSB7CisJLnByZWZpeCA9IFhBVFRSX1VTRVJfUFJFRklYLAorCS5nZXQg
PSBzaG1lbV94YXR0cl9oYW5kbGVyX2dldCwKKwkuc2V0ID0gc2htZW1feGF0dHJfaGFuZGxlcl9z
ZXQsCit9OworCiBzdGF0aWMgY29uc3Qgc3RydWN0IHhhdHRyX2hhbmRsZXIgKnNobWVtX3hhdHRy
X2hhbmRsZXJzW10gPSB7CiAjaWZkZWYgQ09ORklHX1RNUEZTX1BPU0lYX0FDTAogCSZwb3NpeF9h
Y2xfYWNjZXNzX3hhdHRyX2hhbmRsZXIsCkBAIC0zMjU3LDYgKzMyNjMsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHhhdHRyX2hhbmRsZXIgKnNobWVtX3hhdHRyX2hhbmRsZXJzW10gPSB7CiAjZW5k
aWYKIAkmc2htZW1fc2VjdXJpdHlfeGF0dHJfaGFuZGxlciwKIAkmc2htZW1fdHJ1c3RlZF94YXR0
cl9oYW5kbGVyLAorCSZzaG1lbV91c2VyX3hhdHRyX2hhbmRsZXIsCiAJTlVMTAogfTsKIAo=
--000000000000c9167b05bfc27ab1--
