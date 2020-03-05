Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B728617A4AE
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 12:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgCEL6F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 06:58:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbgCEL6F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 06:58:05 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B6B420848
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2020 11:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583409484;
        bh=NLj51ys3qUQ1LHw4kKpA3ON4nItNllbIAr8k6twLMnk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jPk10u8XFtNZgDm35i7JuCjFlUpKNhySxNgFz9r7I3BIQr69riGCGRP7JO0gPMjip
         EAaFCy1KJMaREjJ0ueE8KTQm5bjLz5a5S3VOzGJxflFR4awxNlEz16HbVX24Pv/87J
         Nrw6prgBLDp5DM/AD7vHUhwauiBv/1Gni1pjOaWk=
Received: by mail-vs1-f47.google.com with SMTP id y204so3370225vsy.1
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Mar 2020 03:58:04 -0800 (PST)
X-Gm-Message-State: ANhLgQ0KN+ebjVT0pYH0WH5tANllCyL2u1mlOyLMfCrfduC/U+45VFFK
        OrwE/zCKd47BzhLeK/PV/8bqpbL8Fdp1hu+UPNs=
X-Google-Smtp-Source: ADFU+vtN9ESqwMVlCcOKAS0TO+xynnbU+Ub7yPafrBwSUTRuK7RHEz3l1pwCKc4JF1AZYJEcgpn4uNgF9Pxv3tXk8WQ=
X-Received: by 2002:a05:6102:2268:: with SMTP id v8mr4823983vsd.90.1583409483631;
 Thu, 05 Mar 2020 03:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20200224171327.3655282-1-fdmanana@kernel.org> <5e044000-09e8-ade1-69a6-44cfc59fdc48@toxicpanda.com>
In-Reply-To: <5e044000-09e8-ade1-69a6-44cfc59fdc48@toxicpanda.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 5 Mar 2020 11:57:52 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7twdkw1LphkCWexABjT=WGxKHQvq7hsq+99VF5KJE3Uw@mail.gmail.com>
Message-ID: <CAL3q7H7twdkw1LphkCWexABjT=WGxKHQvq7hsq+99VF5KJE3Uw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Btrfs: implement full reflink support for inline extents
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 3, 2020 at 9:19 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 2/24/20 12:13 PM, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > There are a few cases where we don't allow cloning an inline extent into
> > the destination inode, returning -EOPNOTSUPP to user space. This was done
> > to prevent several types of file corruption and because it's not very
> > straightforward to deal with these cases, as they can't rely on simply
> > copying the inline extent between leaves. Such cases require copying the
> > inline extent's data into the respective page of the destination inode.
> >
> > Not supporting these cases makes it harder and more cumbersome to write
> > applications/libraries that work on any filesystem with reflink support,
> > since all these cases for which btrfs fails with -EOPNOTSUPP work just
> > fine on xfs for example. These unsupported cases are also not documented
> > anywhere and explaining which exact cases fail require a bit of too
> > technical understanding of btrfs's internal (inline extents and when and
> > where can they exist in a file), so it's not really user friendly.
> >
> > Also some test cases from fstests that use fsx, such as generic/522 for
> > example, can sporadically fail because they trigger one of these cases,
> > and fsx expects all operations to succeed.
> >
> > This change adds supports for cloning all these cases by copying the
> > inline extent's data into the respective page of the destination inode.
> >
> > With this change test case btrfs/112 from fstests fails because it
> > expects some clone operations to fail, so it will be updated. Also a
> > new test case that exercises all these previously unsupported cases
> > will be added to fstests.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

So this actually isn't safe.

It can bring back the race that leads to file extent items with
overlapping ranges. Not because of the hole detection part but because
of the part where we copy extent items from the fs/subvolume tree into
the log tree using btrfs_search_forward(), as we copy all extent
items, including the ones outside the fsync range - so we could race
in the same way as we did during hole detection with ordered extent
completion for ordered extents outside the range.

I'll have to rework this a bit.

thanks

>
> Thanks,
>
> Josef
