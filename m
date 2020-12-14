Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075222D964A
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 11:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgLNK2g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 05:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgLNK2g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 05:28:36 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05865C0613CF
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 02:27:55 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id a12so28845302lfl.6
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 02:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=VtwrkEvEyoVUJQtc8WJ5pwr6E6DNxvvDGVqcbAKsBhI=;
        b=adtKBCspnhccyDGvvi0YbQfInWYQwCQ9QK7j5AjnypZWNTcuMNCNjmg0vX4KiX/mvK
         UtkHXvwfacNQi6HZKhnEeE1HxbeB1XyyAaGKCbcTh3wJQmDpeDzSVG3PrVN+CVVdGzQq
         5SyImD2HY3cmV2+QTSQuTnCaNFmhozV9r/QLkVh5ur33b226b1+UJsz2xpq1lhYSWy0I
         khfvcwWahLVP8QEL7b6r7xuyXEqVFu76iZbaSNRbEsdlpEDOEmdNnQttm2GeeQFwjXlf
         SfEtkyYmNt1dSs9uTapuHd22QqnHm7/4DBG/jAsbgG5LcG0cIG5zmlKX41I8qYO/mc+T
         Ctbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=VtwrkEvEyoVUJQtc8WJ5pwr6E6DNxvvDGVqcbAKsBhI=;
        b=mYfnBTbiDo5ox5UD+8NWo6Cs7nze9/FvEZG/VXv0ypNYN3VkIoWDC+QgZj/XJYRwFj
         tE8ZDHt6olh5oP69LDpkgupml00XTf8la+whFJJoKQj3eP38Vzts1l6uWm80bnXYYyF1
         oec1nKuE7+1ilr8bFTKapdzEOZWbROh87NxQV1tcEUWTwkki9LvjQFzf6sUZs/+undav
         hX6TGQ1UZ6uWtOXvVNlEUpInOHEkpLgV74SbqHYIf3qR2MRF01iOPQObRyVtm8aeIlAu
         E2zZntUSSiovjko8hXgyZc8tzzV8gk7yi+vzGuADyEIwUHxv/jYnABSU58SgYqMj8mw5
         OVNw==
X-Gm-Message-State: AOAM533cInN7G33VwDb572cHYM0yskLRWeyghvieTXfj7Ddr0H5s7K4e
        iZhhbU2XY+ohU3iXgmoPnSSAvqE1iid0+tdFzwW5o3qao9mZlQ==
X-Google-Smtp-Source: ABdhPJz58O0JHHDeKmqPlfyioar8S4LzDpldMHLu8LOPg5+JepaJsJBxEon2y8gUhx6e6pMcshJEjxe5txLj+m/Z5Fk=
X-Received: by 2002:a2e:918f:: with SMTP id f15mr2370475ljg.82.1607941674428;
 Mon, 14 Dec 2020 02:27:54 -0800 (PST)
MIME-Version: 1.0
References: <CAMaziXsqG-z029cCTd1BBn6HTm2EDLxsSocSOVs1s5RoK_Q0aQ@mail.gmail.com>
 <CAJCQCtT+sfHjhKn4a+GdT5ktxzuRooxffuoK5M5T8mMbM6o4Bw@mail.gmail.com>
 <CAMaziXtPXvKS=FETe1pU7YecY8Tsxdf5k1Auretd0bFn6mLOag@mail.gmail.com>
 <CAJCQCtTHiN7dFMeHQh7hhFze9BDcY=042XQ-0ENh3DzMxsQ1pQ@mail.gmail.com> <CAMaziXsy4-_5RpN4cxviLX+infRL7-4NmvCEWz_QDA-spfLmXg@mail.gmail.com>
In-Reply-To: <CAMaziXsy4-_5RpN4cxviLX+infRL7-4NmvCEWz_QDA-spfLmXg@mail.gmail.com>
From:   Sreyan Chakravarty <sreyan32@gmail.com>
Date:   Mon, 14 Dec 2020 15:57:42 +0530
Message-ID: <CAMaziXtXAivsV=8XuPr6Vtbz2n_=_z=fmuOYgwex8-mbNaVSyA@mail.gmail.com>
Subject: Re: btrfs swapfile - Not enough swap space for hibernation.
To:     Community support for Fedora users 
        <users@lists.fedoraproject.org>,
        Chris Murphy <lists@colorremedies.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 14, 2020 at 2:57 PM Sreyan Chakravarty <sreyan32@gmail.com> wrote:
>
> On Sun, Dec 13, 2020 at 3:23 AM Chris Murphy <lists@colorremedies.com> wrote:
> > You are in adventure land. So you're going on an adventure. If you
> > want it to just work, use a swap partition.
>
> To be clear my problem is not with swap files per se.
>
> It's a SELinux error. I was asking for help on how to configure
> SELinux so it does not stop systemd-logind from accessing the
> /var/swap directory.
>
> It has nothing to do with swaps.
>
> FYI, I have used swaps in BTRFS with successful hibernation, but it
> fell apart when I restored snapshots.
>
> So I am not sure why you say a separate helper service will be required.
>

Done.

Changing to the "etc_runtime_t" solved problems.

But I am not sure if the permissions are not too permissive or not.

I have opened a discussion for that in Github:
https://github.com/fedora-selinux/selinux-policy/issues/508

-- 
Regards,
Sreyan Chakravarty
