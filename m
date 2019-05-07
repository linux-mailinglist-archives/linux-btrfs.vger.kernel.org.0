Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B02516AE3
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 21:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfEGTJQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 15:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfEGTJQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 May 2019 15:09:16 -0400
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 275B5206A3
        for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2019 19:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557256155;
        bh=9bM2xxjbwBqC+O8qWhgEvoVqNxyF7BAHlEQi4gvuCrs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y+9QidhMrJnUU7zTJV0KqcBz8iJud56fy3z7ado4JiEt32EgQPYPbev2Y3DrhpyBB
         152oRXY825S5xvnmcw6Wf71O8xavUtEZ865ahtB6FcP2AIoncIVMWz3zIckogDe/xA
         zxNnndvrYZPSO6aLv6zo+BAJ9JnZNF7ERJD/O+68=
Received: by mail-vk1-f177.google.com with SMTP id d77so1371657vke.13
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2019 12:09:15 -0700 (PDT)
X-Gm-Message-State: APjAAAXejHbSSMp6NrQr20Tj0vu8qpMqVlk3URAfSeKDPEuf6gjfPdBz
        8DG5bnyokqDraFLaIqsfCvDNgMYoRDelq3By7uA=
X-Google-Smtp-Source: APXvYqzvmsDxVV0y+S/gKHq7Cj6wJpz+mPLHEFUYQU3tdQL3wes6Y+O3GVBguLhHTMP9QuUH4i0nriMeXl4kXnR7rCU=
X-Received: by 2002:a1f:8dcc:: with SMTP id p195mr17543823vkd.31.1557256154306;
 Tue, 07 May 2019 12:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190506154402.20097-1-fdmanana@kernel.org> <20190507174429.vhyk4lqqvnja4zlx@macbook-pro-91.dhcp.thefacebook.com>
In-Reply-To: <20190507174429.vhyk4lqqvnja4zlx@macbook-pro-91.dhcp.thefacebook.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 7 May 2019 20:09:02 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6aHApT3mD4vgKv+iSKjX=nboJpY572w2Pn8LemKA64Cw@mail.gmail.com>
Message-ID: <CAL3q7H6aHApT3mD4vgKv+iSKjX=nboJpY572w2Pn8LemKA64Cw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Btrfs: fix race between ranged fsync and writeback of
 adjacent ranges
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 7, 2019 at 6:44 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Mon, May 06, 2019 at 04:44:02PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When we do a full fsync (the bit BTRFS_INODE_NEEDS_FULL_SYNC is set in the
> > inode) that happens to be ranged, which happens during a msync() or writes
> > for files opened with O_SYNC for example, we can end up with a corrupt log,
> > due to different file extent items representing ranges that overlap with
> > each other, or hit some assertion failures.
> >
> > When doing a ranged fsync we only flush delalloc and wait for ordered
> > exents within that range. If while we are logging items from our inode
> > ordered extents for adjacent ranges complete, we end up in a race that can
> > make us insert the file extent items that overlap with others we logged
> > previously and the assertion failures.
> >
> > For example, if tree-log.c:copy_items() receives a leaf that has the
> > following file extents items, all with a length of 4K and therefore there
> > is an implicit hole in the range 68K to 72K - 1:
> >
> >   (257 EXTENT_ITEM 64K), (257 EXTENT_ITEM 72K), (257 EXTENT_ITEM 76K), ...
> >
> > It copies them to the log tree. However due to the need to detect implicit
> > holes, it may release the path, in order to look at the previous leaf to
> > detect an implicit hole, and then later it will search again in the tree
> > for the first file extent item key, with the goal of locking again the
> > leaf (which might have changed due to concurrent changes to other inodes).
> >
> > However when it locks again the leaf containing the first key, the key
> > corresponding to the extent at offset 72K may not be there anymore since
> > there is an ordered extent for that range that is finishing (that is,
> > somewhere in the middle of btrfs_finish_ordered_io()), and it just
> > removed the file extent item but has not yet replaced it with a new file
> > extent item, so the part of copy_items() that does hole detection will
> > decide that there is a hole in the range starting from 68K to 76K - 1,
> > and therefore insert a file extent item to represent that hole, having
> > a key offset of 68K. After that we now have a log tree with 2 different
> > extent items that have overlapping ranges:
> >
>
> Well this kind of sucks.  I wonder if we should be locking the extent range
> while we're doing this in order to keep this problem from happening.  A fix for
> another day though

The only reason I have not adopted that, is because it would prevent
fsync and readpages() / readpage() from running concurrently (more of
a problem when fsync is full ranged).

Locking the range would avoid any such eventual performance drop on
fsync alone, but it would also allow to drop the inode's dio_sem?
Remember it was giving lockdep warnings before and you moved it to
btrfs_sync_file() from btrfs_log_changed_extents() sometime ago.
However still not enough, as I still get often (random xfstests,
brfs/072 and generic/299 for example) similar lockdep warnings due to
dio_sem:

https://pastebin.com/ar6cLg2Q

Thanks.




>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> Thanks,
>
> Josef
