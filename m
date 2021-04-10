Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA9935ABC5
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Apr 2021 10:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhDJIET (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Apr 2021 04:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhDJIES (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Apr 2021 04:04:18 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637D7C061762;
        Sat, 10 Apr 2021 01:04:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id j26so8257615iog.13;
        Sat, 10 Apr 2021 01:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VxKNswRUWDoaEZM/7IuUkqF2jBBfv4LodQn5KOEqZcM=;
        b=EZrWqJZf9P1G71yGalH9Uymqk6WEO7nGPizUP/vm2bjwzH8xurkkTZkTcITU5eNbtA
         5xTA5FsFw0S9ZRKQAVCxyYYJyEj0lH+juQC7F5BWZ9vjuZ+glcVohX1N7FwqsH9D+Rrc
         pKVf8WBSaW50G6rZzXrC4kYTDqGOO0qvOoL/PkfBWj1r5agwb7DTavmA/PBDqBH603h3
         OtYHeTnVvA+0ksdXU8ZFVWLfLA4jibP/fFrhzQYldpa/JX5oL+Ucm6JdKNXr3gyHeyCS
         9GVd7ubL5sAAMakHNjMuDmaoxBFgzzstS8dU8KSOOEYxhw5jqpwyDMXfU2zFzucVvw4M
         r1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxKNswRUWDoaEZM/7IuUkqF2jBBfv4LodQn5KOEqZcM=;
        b=p5wEE2oeRtV8Ki3Dq4qwuPc4AmQNdYHHJsja/KRvnvS3qV7HzGqPvT7xlcbF2ME+mt
         VXC/03hbCRfUnKvwaO+50kTgXOioGtVqVMn/toGLTApWkywcfUnIPHmOBCtZ60v+lh6r
         KbDDblvwuwdt+QCDFE7fhKI7WWDN5TDXnIGvg9JlIYWnHWvSQW8pAq6LcY1XixiQliBL
         tOdo3Ob0fvHSvYHHIzhxMN0bJGQRm50t0OAa5ivxP3ZI2ITfbqz+ah3Xw139TMoiwGXr
         EbMtxCPA2szOKwn7HPcMs3AMeElh6hPIdDrrrubqbfoW7E6j/ikCvj8cKMj4VhgjfzVW
         7c4w==
X-Gm-Message-State: AOAM531Xbn5LrhbRhg4sIUhX+0l8br6XTKrvK4wUjHT2DEbC6gutp8s6
        63jC9z2VD6vrUPDzlxKbyTUgM19EJiuWFiVqoP11Vub8oQY=
X-Google-Smtp-Source: ABdhPJzbB5cR7EQQaRXciC3JeCV1uW1nky2cLr2LdVg4/Otg7EVoYTUHomTIbCJJgV/7XfatvQox/cAjuvuVTM2py98=
X-Received: by 2002:a6b:7a42:: with SMTP id k2mr888764iop.64.1618041842786;
 Sat, 10 Apr 2021 01:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTp0aXBssEr4ZXGX=DS_+RyGghmoANCKDdxG59QWu8LVA@mail.gmail.com>
In-Reply-To: <CAJCQCtTp0aXBssEr4ZXGX=DS_+RyGghmoANCKDdxG59QWu8LVA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 10 Apr 2021 11:03:51 +0300
Message-ID: <CAOQ4uxht70nODhNHNwGFMSqDyOKLXOKrY0H6g849os4BQ7cokA@mail.gmail.com>
Subject: Re: btrfs+overlayfs: upper fs does not support xattr, falling back to
 index=off and metacopy=off.
To:     Chris Murphy <lists@colorremedies.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 10, 2021 at 1:04 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> Hi,
>
> The primary problem is Bolt (Thunderbolt 3) tests that are
> experiencing a regression when run in a container using overlayfs,
> failing at:
>
> Bail out! ERROR:../tests/test-common.c:1413:test_io_dir_is_empty:
> 'empty' should be FALSE
>
> https://gitlab.freedesktop.org/bolt/bolt/-/issues/171#note_872119
>

To summarize, the test case is:
- create empty dir
- open empty dir
- getdents => (".", "..")
- create file at (dirfd, "a",
- lseek to offset 0 on dirfd
- getdents => (".", "..") FAIL to see "a"

It looks like a bug in ovl readdir cache invalidation only there is
not supposed to be any caching of pure upper dir.

Once thing I noticed is that ovl_dentry_version_inc() is inconsistent
with ovl_dir_is_real() - the latter checks whether readdir caching would
be used and the former checks whether invalidating readdir cache is
needed. We need to change ovl_dentry_version_inc() test to:
    if (ovl_test_flag(OVL_WHITEOUTS, dir) || impurity)
Or better yet:
    if (!ovl_dir_is_real() || impurity)

But this still doesn't explain the reported issue.

The OVL_WHITEOUTS inode flag is set in ovl_get_inode() in several
cases including:
    ovl_check_origin_xattr(ofs, upperdentry)

So now we are getting closer to something that sounds related to the
reported issue...

ovl_check_origin_xattr() would return true if
    vfs_getxattr(upperdentry, "trusted.overlay.origin", NULL, 0)
would return 0 instead of -ENODATA for some reason even though that
xattr does not exist.

But we happen to be missing a pr_debug() in  ovl_do_getxattr(), so
it's hard to say what's going on.

Chris,

As the first step, can you try the suggested fix to ovl_dentry_version_inc()
and/or adding the missing pr_debug() and including those prints in
your report?

> I can reproduce this with 5.12.0-0.rc6.184.fc35.x86_64+debug and at
> approximately the same time I see one, sometimes more, kernel
> messages:
>
> [ 6295.379283] overlayfs: upper fs does not support xattr, falling
> back to index=off and metacopy=off.
>

Can you say why there is no xattr support?
Is the overlayfs mount executed without privileges to create trusted.* xattrs?
The answer to that may be the key to understanding the bug.

> But I don't know if that kernel message relates to the bolt test failure.
>
> If I run the test outside of a container, it doesn't fail. If I run
> the test in a podman container using the btrfs driver instead of the
> overlay driver, it doesn't fail. So it seems like this is an overlayfs
> bug, but could be some kind of overlayfs+btrfs interaction.
>

My guess is it has to do with changes related to mounting overlayfs
inside userns, but I couldn't find any immediate suspects.

Do you have any idea since when the regression appeared?
A bisect would have been helpful here.

> Could this be related and just not yet merged?
> https://lore.kernel.org/linux-unionfs/20210309162654.243184-1-amir73il@gmail.com/
>

Not likely.
If you want to be sure do:
echo N > /sys/module/overlay/parameters/xino_auto
Before starting the container.
Above commit only matters for xino_auto = Y.

Thanks,
Amir.
