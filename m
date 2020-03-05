Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40DA17A874
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 16:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgCEPEM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 10:04:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgCEPEM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 10:04:12 -0500
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37E8720801
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2020 15:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583420651;
        bh=oH1uxtotVLSrZbBw0GolzY9RrcpRylkHRq6w9EJH0lI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=swBpPJJjTWS5BjN8u99DEN6smeeZg3We86Q6R75psANP5BKgFvXCoLgbLUlqjbOIz
         lF+3ga4kvWGDMxRJjbL9i6xk2c0imBxCJaxwWKay7TkEUjyorJFpGMRDeVhM9Mv1Ts
         t0oqYIKsxs5Nlpuf3bHQxm7JSZMoavTRubmL429Q=
Received: by mail-ua1-f41.google.com with SMTP id c4so2123139uaq.2
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Mar 2020 07:04:11 -0800 (PST)
X-Gm-Message-State: ANhLgQ2Zd6oTg4qxGRh0Y0BdECredFHqrVmUOK/zrp7woU8oFfInMuAQ
        H1yobgZNX6G8IAN0hweT6T2XWc1UzgO+5YKZcL0=
X-Google-Smtp-Source: ADFU+vtTpxA1+2gXX3l+w958fXWNniqrpylkd5YoIR294+T17zHUjEcz3QYTUWsLg6CEsZfj6/sO8DJeebnhPWrhp20=
X-Received: by 2002:ab0:2247:: with SMTP id z7mr4890352uan.123.1583420650183;
 Thu, 05 Mar 2020 07:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20200304103404.5571-1-fdmanana@kernel.org> <31fce27a-510f-3f63-a029-2722c6e20b05@toxicpanda.com>
In-Reply-To: <31fce27a-510f-3f63-a029-2722c6e20b05@toxicpanda.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 5 Mar 2020 15:03:58 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4nYzxswJuDFNVZYDTLmjqKGW2eDTsUs6hBqx56kQumKg@mail.gmail.com>
Message-ID: <CAL3q7H4nYzxswJuDFNVZYDTLmjqKGW2eDTsUs6hBqx56kQumKg@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: make ranged full fsyncs more efficient
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 4, 2020 at 6:55 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 3/4/20 5:34 AM, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Commit 0c713cbab6200b ("Btrfs: fix race between ranged fsync and writeback
> > of adjacent ranges") fixed a bug where we could end up with file extent
> > items in a log tree that represent file ranges that overlap due to a race
> > between the hole detection of a ranged full fsync and writeback for a
> > different file range.
> >
> > The problem was solved by forcing any ranged full fsync to become a
> > non-ranged full fsync - setting the range start to 0 and the end offset to
> > LLONG_MAX. This was a simple solution because the code that detected and
> > marked holes was very complex, it used to be done at copy_items() and
> > implied several searches on the fs/subvolume tree. The drawback of that
> > solution was that we started to flush delalloc for the entire file and
> > wait for all the ordered extents to complete for ranged full fsyncs
> > (including ordered extents covering ranges completely outside the given
> > range). Fortunatelly ranged full fsyncs are not the most common case.
> >
> > However a later fix for detecting and marking holes was made by commit
> > 0e56315ca147b3 ("Btrfs: fix missing hole after hole punching and fsync
> > when using NO_HOLES") and it simplified a lot the detection of holes,
> > and now copy_items() no longer does it and we do it in a much more simple
> > way at btrfs_log_holes(). This makes it now possible to simply make the
> > code that detects holes to operate only on the initial range and no longer
> > need to operate on the whole file, while also avoiding the need to flush
> > delalloc for the entire file and wait for ordered extents that cover
> > ranges that don't overlap the given range.
> >
> > So this change just does that, making any ranged full fsync to actually
> > operate only on the given range and not the whole file.
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

>
> Thanks,
>
> Josef
