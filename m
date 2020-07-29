Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B527E2321BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 17:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgG2PmY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 11:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2PmX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 11:42:23 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BA4C061794
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 08:42:23 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k23so24952652iom.10
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GHvdgebLyXeg+KLuP5DHDSyuglRC0frGOwM/QPxOQIU=;
        b=eTSTSfq3Zx+cXKiu0qeEAUk3rW8BLNaAvYdBvfGNpDHJK0daSyjql2pa866r8AOG0a
         +EYhAgPpC6+ODSVhx5XsPyCiylt06yc8PKmUlNgDJd6i9IJngAGyF7Vj4wuO8fgJab07
         dCl7FANliuAJMeEjBkfqmqjWTpAVg7ciHrPywdcOP4P4pRMxw6nq9sRvtV4GBmTgJpLR
         O8GJ2wEa0066s53cQlgq/OgmIFolGjfw06eEKblJrsQpzOUgDME2eplkeXOuCPYqIvwb
         /Nou7I2RUvOkzPPpL3z8fmrzcaOjZvE79kms3TCgABJzRsYRref553iKoLCeH+DLPn/7
         2JLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GHvdgebLyXeg+KLuP5DHDSyuglRC0frGOwM/QPxOQIU=;
        b=p7GTMimORazU9Tssa4+WBeT2xNGDX+gjAKf8H//S27521zz0/nO37bhUk2etFiZPz2
         7eWI46odRH8hhWp+BvYUjl3rwq/Lq667GuIl5nhQQfiJIblYkWPfptWA4m9IfcAOQdhw
         BMKKZQPNqHJD28r0sDAInXoAvY30f+Vy6qzSqSJ5Jk8bCcqrDRbeFCtEHdFdL1P41RuB
         YiB1w4UHMov1FlNeFcqOxYV+a5uOd3WPSNWFd1bIyKGbI6epXY2MdKWcYbgxhRX9Y8TI
         rcwsWtfMN4ZvTx+jcAucCc4iqydu06c7SXMhdKs4yul7QhQ8vHTlOvG+Gjw/0jIiFWxP
         /R5w==
X-Gm-Message-State: AOAM531DkkH/n3g3x/T+IRRBS03RqyY3hOsNh9wWxWa6qi47xggqPwMI
        H1wOudIXY3ce91xU9M1UTsJagAq1Bcf6QsinJ7c=
X-Google-Smtp-Source: ABdhPJyWFAJnSEqANs6F5nAc/UlZlyRESXqyhneRCuYKBIqgG9d1q/wzPsKN9Xbv4VrSYVmWd+JEBeg/9W+ZGlZ1lfI=
X-Received: by 2002:a5d:8b4f:: with SMTP id c15mr34326506iot.197.1596037341390;
 Wed, 29 Jul 2020 08:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200727142805.4896-1-josef@toxicpanda.com> <20200728144346.GW3703@twin.jikos.cz>
In-Reply-To: <20200728144346.GW3703@twin.jikos.cz>
From:   =?UTF-8?Q?Sebastian_D=C3=B6ring?= <moralapostel@gmail.com>
Date:   Wed, 29 Jul 2020 17:42:09 +0200
Message-ID: <CADkZQam9aJgNYy6bUXREYtS_fv1TLqyHbmkvs+aX9087AM62+g@mail.gmail.com>
Subject: Re: [PATCH][v3] btrfs: only search for left_info if there is no right_info
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For reasons unrelated to btrfs I've been trying linux-next-20200728 today.

This patch causes Kernel Oops and call trace (with
try_merge_free_space on top of stack) on my system. Because of
immediate system lock-up I can't provide a dmesg log and there's
nothing in /var/log (probably because it immediately goes read-only),
but removing this patch and rebuilding the kernel fixed my issues. I'm
happy to help if you need more info in order to reproduce.

Am Di., 28. Juli 2020 um 16:47 Uhr schrieb David Sterba <dsterba@suse.cz>:
>
> On Mon, Jul 27, 2020 at 10:28:05AM -0400, Josef Bacik wrote:
> > In try_to_merge_free_space we attempt to find entries to the left and
> > right of the entry we are adding to see if they can be merged.  We
> > search for an entry past our current info (saved into right_info), and
> > then if right_info exists and it has a rb_prev() we save the rb_prev()
> > into left_info.
> >
> > However there's a slight problem in the case that we have a right_info,
> > but no entry previous to that entry.  At that point we will search for
> > an entry just before the info we're attempting to insert.  This will
> > simply find right_info again, and assign it to left_info, making them
> > both the same pointer.
> >
> > Now if right_info _can_ be merged with the range we're inserting, we'll
> > add it to the info and free right_info.  However further down we'll
> > access left_info, which was right_info, and thus get a UAF.
> >
> > Fix this by only searching for the left entry if we don't find a right
> > entry at all.
> >
> > The CVE referenced had a specially crafted file system that could
> > trigger this UAF.  However with the tree checker improvements we no
> > longer trigger the conditions for the UAF.  But the original conditions
> > still apply, hence this fix.
> >
> > Reference: CVE-2019-19448
> > Fixes: 963030817060 ("Btrfs: use hybrid extents+bitmap rb tree for free space")
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> > v2->v3:
> > - Updated the changelog.
>
> Added to misc-next, thanks.
