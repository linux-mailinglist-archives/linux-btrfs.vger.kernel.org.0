Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4BA35AF53
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Apr 2021 19:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhDJRgj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Apr 2021 13:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbhDJRgi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Apr 2021 13:36:38 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15805C06138B
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Apr 2021 10:36:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x7so8678708wrw.10
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Apr 2021 10:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jhm4jac+LlkZkHJhaVWxMaO7C1pE7y6tVLm9Nc9lhFY=;
        b=gpnAiUHxqYfHsGJmiaPN7S4EzPbpEkoE6BevcViiKvluGcXRLtV1i7TxfUcEDSHQvK
         RNQ+DIXkiOF6tbvznS1jvC50VNW3qK9MbgvJkXSNPZkAohTpG0aQB737lKsQI+GPjtDL
         Vva0lRco526X/4f8a6pTyxTMXUS5VB/C+Ik1aS2dN2Ud0r39KO9dKtrPrt35n+/vJVDL
         lUI0TN9+cC9sxe8Yv+n00oPp+Ew7e8nObbSVgL+Jwim7eTw/Q2p+C4gB4n6vNlfCNzzt
         n0tbgypSD+I8OFb4k8eDbUs/1hwK4/+Qfmy4ROzMtbpEuanW+J3zj0D8l05Id7fyHe/0
         iYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jhm4jac+LlkZkHJhaVWxMaO7C1pE7y6tVLm9Nc9lhFY=;
        b=WHL1JZN9PCF1GC1FYjQkAHCM8CZIVfGF3RZdu3KcvWuLe0sATyCpLyuhihBgC0ggcD
         5lUjAulrvLjEJZkv8rzbGbG+XG2ZydInD5hOkHD4MAxByXqMYITqPo3v13uuVNywPuTx
         sBvuvCPqZgfL+K95iWKjAmpiXzfB/vswuBupCALpLZ/eOVU0b5SIlYmMP91nkUbNfSPP
         DKUz8pfqTXVL8LsFf2dpznzMJ1imbscaMHmDXGWdzPFJp2f7R+WejFNLXljgB371gtfs
         7rr+Ihc9LFvqk2JmNZCr9J3AkCmne5Kb1j8oI/N2k8uwzkAet31ijvAi3UXllznw3P0/
         /kpw==
X-Gm-Message-State: AOAM5319byG1Yl1AfnR9e5C1Ui+uUYA6fM8W8kT3C8eofDXoTC29pxIP
        E5X+JeaoYO+MD8My94GPd3LNWr3IE3loJbd8zhRCvOd0TCxcTqKN
X-Google-Smtp-Source: ABdhPJyp/VO1W1jqT56vtB3cYwFUtcBwHEY+Np+VvxWBpIwHCtHx/mWPDNS2xqmJXcqvZitj+G9Hidug3UREygl1Ijg=
X-Received: by 2002:adf:d84d:: with SMTP id k13mr23357716wrl.65.1618076180517;
 Sat, 10 Apr 2021 10:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTp0aXBssEr4ZXGX=DS_+RyGghmoANCKDdxG59QWu8LVA@mail.gmail.com>
 <CAOQ4uxht70nODhNHNwGFMSqDyOKLXOKrY0H6g849os4BQ7cokA@mail.gmail.com>
In-Reply-To: <CAOQ4uxht70nODhNHNwGFMSqDyOKLXOKrY0H6g849os4BQ7cokA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 10 Apr 2021 11:36:04 -0600
Message-ID: <CAJCQCtRGdBzyskifrYLbBGAAm0g7VeC6GeD7xBN-hRqE3GAWYA@mail.gmail.com>
Subject: Re: btrfs+overlayfs: upper fs does not support xattr, falling back to
 index=off and metacopy=off.
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I can reproduce the bolt testcase problem in a podman container, with
overlay driver, using ext4, xfs, and btrfs. So I think I can drop
linux-btrfs@ from this thread.

Also I can reproduce the title of this thread simply by 'podman system
reset' and see the kernel messages before doing the actual reset. I
have a strace here of what it's doing:

https://drive.google.com/file/d/1L9lEm5n4-d9qemgCq3ijqoBstM-PP1By/view?usp=sharing

It may be something intentional. The failing testcase,
:../tests/test-common.c:1413:test_io_dir_is_empty also has more
instances of this line, but I don't know they are related. So I'll
keep looking into that.


On Sat, Apr 10, 2021 at 2:04 AM Amir Goldstein <amir73il@gmail.com> wrote:

> As the first step, can you try the suggested fix to ovl_dentry_version_inc()
> and/or adding the missing pr_debug() and including those prints in
> your report?

I'll work with bolt upstream and try to further narrow down when it is
and isn't happening.

> > I can reproduce this with 5.12.0-0.rc6.184.fc35.x86_64+debug and at
> > approximately the same time I see one, sometimes more, kernel
> > messages:
> >
> > [ 6295.379283] overlayfs: upper fs does not support xattr, falling
> > back to index=off and metacopy=off.
> >
>
> Can you say why there is no xattr support?

I'm not sure. It could be podman specific or fuse-overlayfs related.
Maybe something is using /tmp in one case and not another for some
reason?

> Is the overlayfs mount executed without privileges to create trusted.* xattrs?
> The answer to that may be the key to understanding the bug.

Yep. I think tmpfs supports xattr but not user xattr? And this example
is rootless podman, so it's all unprivileged.


> My guess is it has to do with changes related to mounting overlayfs
> inside userns, but I couldn't find any immediate suspects.
>
> Do you have any idea since when the regression appeared?
> A bisect would have been helpful here.

Yep. All good ideas. Thanks for the fast reply. I'll report back once
this has been narrowed down futher.


-- 
Chris Murphy
