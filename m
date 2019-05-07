Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6B8B16B5D
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 21:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfEGTbd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 15:31:33 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44788 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfEGTbd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 May 2019 15:31:33 -0400
Received: by mail-yw1-f66.google.com with SMTP id j4so14164668ywk.11
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2019 12:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pj1wozSb0a38ewOrhoIHNbikzJm97tMDiZXws2wXYVI=;
        b=t5J2AoKk3Xgxxhp9zjdguH9UcWrMYKhhX1bFuxUCgf+fCZFiak+52oUwgerLBsRCeZ
         tA7+8AoFzk1g+oiWOpAt3jJWmZ1w9FWAXPABxD9w+VnkDaA7K9axjvSSWDszXi5foJ72
         8CwvbQyqKgvKjuy5/0Crx7lgmQcUr6hrv0m7dqrIBaCM3+a0PRRO9BeVTeYFOI/iHKy6
         YsX9gKszO7opRrNpkZqcFGUTJbMGIHyYF1jwwwCz7ObhOo+d93R+awso7EZ5WUxv2msX
         N9zwUD0ewnLMAgT22DHyaBL5T6hdEjZZvaQDCsPzpLOBH76oDw1IvhmbqdvZicu5bXwD
         gB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pj1wozSb0a38ewOrhoIHNbikzJm97tMDiZXws2wXYVI=;
        b=XWqaYQJTKUA2SS8JdX8tjGu4u20WhObSW4+1TmNvzMdVSCPYxAro5iDGvVd/n3VixZ
         ffJw/2OPfdwtjQ6MAH4XICUWoxlons9lWy5ZM7IVHub3NsMsWnqQsgfllUjzRnPyNWgj
         qe/hOc6o4zlG7zGsgyk7eO/RUjS1/XM57eCE6+3TJ7TcmWGQI9zaJE0z/UgdomebmOjf
         i2+cNCdxnCAxi7GdPEe4D0kfUZ6ZqWRLUYZ+CgEv98cNt2ygDO2AwIrrK2O7XeB8Z0e+
         N6hkv95N1TH4SphEkJA1iYu4q7Thz8VxwWsfNpJKMrF4cxLQO0skm3qWxpO8vTxYI4si
         62FA==
X-Gm-Message-State: APjAAAUKOjzT2vDTcT3L1upx8qcbVy9vFU39m/mjUGnUmxqd8oxaLodH
        l0nzcAKndOAz2HSZ81pZRxHokw==
X-Google-Smtp-Source: APXvYqwpk0mNUmLt0GAeYqS6mvWAdgkAF7TEoJwqeiJmfvZEd33FWZoSJnd7wZ9MdJW7SlRsYMpN6Q==
X-Received: by 2002:a0d:fe05:: with SMTP id o5mr20588235ywf.89.1557257491897;
        Tue, 07 May 2019 12:31:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::5c09])
        by smtp.gmail.com with ESMTPSA id 78sm3989861ywr.65.2019.05.07.12.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 12:31:31 -0700 (PDT)
Date:   Tue, 7 May 2019 15:31:29 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] Btrfs: fix race between ranged fsync and writeback
 of adjacent ranges
Message-ID: <20190507193127.vnzdoo2qdbeeghea@macbook-pro-91.dhcp.thefacebook.com>
References: <20190506154402.20097-1-fdmanana@kernel.org>
 <20190507174429.vhyk4lqqvnja4zlx@macbook-pro-91.dhcp.thefacebook.com>
 <CAL3q7H6aHApT3mD4vgKv+iSKjX=nboJpY572w2Pn8LemKA64Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6aHApT3mD4vgKv+iSKjX=nboJpY572w2Pn8LemKA64Cw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 07, 2019 at 08:09:02PM +0100, Filipe Manana wrote:
> On Tue, May 7, 2019 at 6:44 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Mon, May 06, 2019 at 04:44:02PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > When we do a full fsync (the bit BTRFS_INODE_NEEDS_FULL_SYNC is set in the
> > > inode) that happens to be ranged, which happens during a msync() or writes
> > > for files opened with O_SYNC for example, we can end up with a corrupt log,
> > > due to different file extent items representing ranges that overlap with
> > > each other, or hit some assertion failures.
> > >
> > > When doing a ranged fsync we only flush delalloc and wait for ordered
> > > exents within that range. If while we are logging items from our inode
> > > ordered extents for adjacent ranges complete, we end up in a race that can
> > > make us insert the file extent items that overlap with others we logged
> > > previously and the assertion failures.
> > >
> > > For example, if tree-log.c:copy_items() receives a leaf that has the
> > > following file extents items, all with a length of 4K and therefore there
> > > is an implicit hole in the range 68K to 72K - 1:
> > >
> > >   (257 EXTENT_ITEM 64K), (257 EXTENT_ITEM 72K), (257 EXTENT_ITEM 76K), ...
> > >
> > > It copies them to the log tree. However due to the need to detect implicit
> > > holes, it may release the path, in order to look at the previous leaf to
> > > detect an implicit hole, and then later it will search again in the tree
> > > for the first file extent item key, with the goal of locking again the
> > > leaf (which might have changed due to concurrent changes to other inodes).
> > >
> > > However when it locks again the leaf containing the first key, the key
> > > corresponding to the extent at offset 72K may not be there anymore since
> > > there is an ordered extent for that range that is finishing (that is,
> > > somewhere in the middle of btrfs_finish_ordered_io()), and it just
> > > removed the file extent item but has not yet replaced it with a new file
> > > extent item, so the part of copy_items() that does hole detection will
> > > decide that there is a hole in the range starting from 68K to 76K - 1,
> > > and therefore insert a file extent item to represent that hole, having
> > > a key offset of 68K. After that we now have a log tree with 2 different
> > > extent items that have overlapping ranges:
> > >
> >
> > Well this kind of sucks.  I wonder if we should be locking the extent range
> > while we're doing this in order to keep this problem from happening.  A fix for
> > another day though
> 
> The only reason I have not adopted that, is because it would prevent
> fsync and readpages() / readpage() from running concurrently (more of
> a problem when fsync is full ranged).
> 

Hrm good point.  Time to make the extent lock read/write lock!

> Locking the range would avoid any such eventual performance drop on
> fsync alone, but it would also allow to drop the inode's dio_sem?
> Remember it was giving lockdep warnings before and you moved it to
> btrfs_sync_file() from btrfs_log_changed_extents() sometime ago.
> However still not enough, as I still get often (random xfstests,
> brfs/072 and generic/299 for example) similar lockdep warnings due to
> dio_sem:
> 
> https://pastebin.com/ar6cLg2Q

Hmm that's annoying, but not a real problem because we're just destroying a
workqueue that has nothing on it because we raced with somebody else allocating
a new workqueue.  I think the best thing to do is to export sb_init_dio_done_wq
and call it within our direct io before we take all of our locks, that should
shut lockdep up.  That's kind of shitty though, I'll think about it some more.
Thanks,

Josef
