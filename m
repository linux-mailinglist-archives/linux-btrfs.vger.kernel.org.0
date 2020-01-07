Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77242132B49
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 17:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgAGQpl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 11:45:41 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44594 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGQpl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jan 2020 11:45:41 -0500
Received: by mail-vk1-f195.google.com with SMTP id y184so125492vkc.11
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jan 2020 08:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=UOO8bNxvo8Qs6sMaJ5DGrVZjT3LnExVqReu+tNjqv1I=;
        b=Kwe9AAhKgEFI/oejkyyegJzbU25SD0eZiZ8LidjdB6nBOMriECQFsODTBmZ/ls1Mcb
         yKxh/CSt3+fdV6Q5GdxOfpXQLn3VZkLBITvGcDssma6mF5wrN+/9rS2Gh90eNB1bIRLW
         33yZcu2n55qeVlPZO/IDWfXpzFYj/tqvchiaUG+/RXJFxEqhmf2X1TyGLzkqshZXM4Zg
         APUp6rknqQikG4sXy2O0OeASRK70Cz/FvJov9D3lGy+a/YvxXfwHjnuqqbAfDOavyLHo
         L3Ou3+maALgau57C/absd1sx5sAAdxeAbBAZzkrGHg/Uuddn2/CysQlKvcbvaxhUhOmE
         qc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=UOO8bNxvo8Qs6sMaJ5DGrVZjT3LnExVqReu+tNjqv1I=;
        b=PZDhhPbcwJ/w6WHrsXOMHUPHgNt6tSyJYhdM4/mgTfi0+7XMdCE+1N8jbuBRRhaDD/
         r2SO8pFA0CzAa1o84Fpf/7tPowKlEP3wPwF2D4/zDePQK39gL1GX4RICaldJh+e9kRN7
         EBj00ZZx+wsxQ/uSJtZO3j9TSDUqw8C3LxiHnVezN7FjWapMzGj15IJdbzWQ87QV85La
         mH9NTQ5OxNeDFJkcgvVEBt1L4tCBr1t4fO9zcxpg4IoFbv4kPCYBN0evF7Rw5wf7x3vg
         V2lOfWhTIxzY41f6L2MlfjnNjSoOpmho+fswEAQVtDmci4EjApetQFxeg24NqIYiI2ZB
         lZeg==
X-Gm-Message-State: APjAAAXJcnvBriAQvjQgx3Ft/cm8bsvswGa9erJI7w3+zMqc9hvxgzui
        uXd9uISKu5PAyYfN97D1Pi1rccGUfzZD+lJVtvu9YQ==
X-Google-Smtp-Source: APXvYqzCfnTuurDkMWeHNgRp/RCf9yUUsSXNOF6M5x3vxUoWvYs5ZFmYVWFCdNBrtXSV4S9naebZSXCCFw4NDzF++pU=
X-Received: by 2002:a1f:f283:: with SMTP id q125mr34717vkh.69.1578415539839;
 Tue, 07 Jan 2020 08:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20191230213118.7532-1-josef@toxicpanda.com> <20191230213118.7532-3-josef@toxicpanda.com>
 <20200106172234.GN3929@twin.jikos.cz> <a9b6d5cb-b3a4-8088-c6cc-236ef555cf44@toxicpanda.com>
 <20200107161749.GA3929@twin.jikos.cz>
In-Reply-To: <20200107161749.GA3929@twin.jikos.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 7 Jan 2020 16:45:28 +0000
Message-ID: <CAL3q7H7oS_9vy9SAAhmscjvxzb4XMUwNcQq8aRWvZqApBF2rrw@mail.gmail.com>
Subject: Re: [PATCH 2/5] btrfs: introduce the inode->file_extent_tree
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 7, 2020 at 4:18 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Jan 06, 2020 at 02:29:01PM -0500, Josef Bacik wrote:
> > On 1/6/20 12:22 PM, David Sterba wrote:
> > > On Mon, Dec 30, 2019 at 04:31:15PM -0500, Josef Bacik wrote:
> > >> @@ -60,6 +60,11 @@ struct btrfs_inode {
> > >>     */
> > >>    struct extent_io_tree io_failure_tree;
> > >>
> > >> +  /* keeps track of where we have extent items mapped in order to m=
ake
> > >> +   * sure our i_size adjustments are accurate.
> > >> +   */
> > >> +  struct extent_io_tree file_extent_tree;
> > >
> > > This is not exactly lightweight and cut to the minimum needed, the si=
ze
> > > is 40 bytes and contains struct members that are unused. At least the
> > > file extents tree seems to be in use unlike that io_failure_tree wast=
ing
> > > the bytes almost 100% of time.
> > >
> >
> > I'm not in love with it either, but I don't want to invent some lighter=
 weight
> > range thingy that I'm going to end up messing up in other ways.
>
> Yeah, the extent_io_tree is now being used for generic range tree, some
> cleanups could remove the members that were added for the first specific
> use (like the dirty_bytes, or track_updates). For correctness of NOHOLES
> the inode size increase shouldn't be a blocker but needs to be addressed
> later.

Hum?
This isn't about the NO_HOLES case, it's about unordered i_size update
which can often lead to missing extent items for a file - when using
NO_HOLES fsck simply doesn't report any issue, but when not using it,
it does report about missing extents.

>
> > Don't take this series yet, there's still something fishy going on that=
 I have
> > to figure out.  Thanks,
>
> Ok.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
