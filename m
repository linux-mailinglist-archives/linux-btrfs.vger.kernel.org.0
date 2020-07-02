Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A6B212423
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGBNIC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgGBNIC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 09:08:02 -0400
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F57F20899
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 13:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593695281;
        bh=MERmQ8H7Z84VvH+lOZ7nGwsfLWAnDacyCqFSMJb34Dc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RwdmmA9ALiqi5d24yN45cBMoYug/eyN0HYQiC0DHGswUsWSVZKb0FzpD6Bd/kCv72
         Y/zieJX+Jqwner30AAfBmNDUrVhS9JAYokNF0SgZiynI4CVza2ypSKjzaCyEz9KCpL
         jSfbICpaJnQ0edXlyMB7sCOtjIHCnMVle7fo2xXI=
Received: by mail-vk1-f174.google.com with SMTP id c11so1211952vkn.11
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:08:01 -0700 (PDT)
X-Gm-Message-State: AOAM530eFpriO8iQd5aXeT1kP+wlgNSOKJ1oBWKK/CHx5TPijJp1o0t9
        Ejr4zAhzbkGK/63hNFW+/2lUpqcVXe7QXGnnrBw=
X-Google-Smtp-Source: ABdhPJwKKXp6nDXrCHWF85IYiUaZ2vCUTIMnKc6fWfdiOSNeBugxT6iXLIZdw4MR8Y/SxkjsSiHKuKxLbaWWbZKsVWY=
X-Received: by 2002:a1f:9e8a:: with SMTP id h132mr22562782vke.14.1593695280521;
 Thu, 02 Jul 2020 06:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200702113240.171572-1-fdmanana@kernel.org> <ae10a30c-636b-65d7-5da0-f9a5d0c8fab1@toxicpanda.com>
In-Reply-To: <ae10a30c-636b-65d7-5da0-f9a5d0c8fab1@toxicpanda.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 2 Jul 2020 14:07:49 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5YApfUwOT2DiYH4q7NbX=-X+ypgrdXXzhYrVAXT__WAQ@mail.gmail.com>
Message-ID: <CAL3q7H5YApfUwOT2DiYH4q7NbX=-X+ypgrdXXzhYrVAXT__WAQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] btrfs: remove no longer needed use of log_writers for
 the log root tree
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 2, 2020 at 2:04 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 7/2/20 7:32 AM, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When syncing the log, we used to update the log root tree without holding
> > neither the log_mutex of the subvolume root nor the log_mutex of log root
> > tree.
> >
> > We used to have two critical sections delimited by the log_mutex of the
> > log root tree, so in the first one we incremented the log_writers of the
> > log root tree and on the second one we decremented it and waited for the
> > log_writers counter to go down to zero. This was because the update of
> > the log root tree happened between the two critical sections.
> >
> > The use of two critical sections allowed a little bit more of parallelism
> > and required the use of the log_writers counter, necessary to make sure
> > we didn't miss any log root tree update when we have multiple tasks trying
> > to sync the log in parallel.
> >
> > However after commit 06989c799f0481 ("Btrfs: fix race updating log root
> > item during fsync") the log root tree update was moved into a critical
> > section delimited by the subvolume's log_mutex. Later another commit
> > moved the log tree update from that critical section into the second
> > critical section delimited by the log_mutex of the log root tree. Both
> > commits addressed different bugs.
> >
> > The end result is that the first critical section delimited by the
> > log_mutex of the log root tree became pointless, since there's nothing
> > done between it and the second critical section, we just have an unlock
> > of the log_mutex followed by a lock operation. This means we can merge
> > both critical sections, as the first one does almost nothing now, and we
> > can stop using the log_writers counter of the log root tree, which was
> > incremented in the first critical section and decremented in the second
> > criticial section, used to make sure no one in the second critical section
> > started writeback of the log root tree before some other task updated it.
> >
> > So just remove the mutex_unlock() followed by mutex_lock() of the log root
> > tree, as well as the use of the log_writers counter for the log root tree.
> >
> > This patch is part of a series that has the following patches:
> >
> > 1/4 btrfs: only commit the delayed inode when doing a full fsync
> > 2/4 btrfs: only commit delayed items at fsync if we are logging a directory
> > 3/4 btrfs: stop incremening log_batch for the log root tree when syncing log
> > 4/4 btrfs: remove no longer needed use of log_writers for the log root tree
> >
> > After the entire patchset applied I saw about 12% decrease on max latency
> > reported by dbench. The test was done on a qemu vm, with 8 cores, 16Gb of
> > ram, using kvm and using a raw NVMe device directly (no intermediary fs on
> > the host). The test was invoked like the following:
> >
> >    mkfs.btrfs -f /dev/sdk
> >    mount -o ssd -o nospace_cache /dev/sdk /mnt/sdk
> >    dbench -D /mnt/sdk -t 300 8
> >    umount /mnt/dsk
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Lol oops, did I leave it like that?

Well, before you moved the log root tree update, I moved it first.
So back then I didn't notice it or left it for later and then forgot.
And later you missed it too, so we're even ;)

>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> Thanks,
>
> Josef
