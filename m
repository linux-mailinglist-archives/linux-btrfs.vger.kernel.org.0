Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97EEB14BEA6
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 18:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgA1RfP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 12:35:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgA1RfP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 12:35:15 -0500
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F159214AF
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jan 2020 17:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580232914;
        bh=UToUMIpjqtVJ4rpiYPb8bFNarNU08/O4Gq9PzoIGcUg=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=Q9brGYYRIVIrR+u2s+CheUDDVkBZon41crUK65vHob6cy1CWT/8m9uW+LKAQntfON
         /PFUKZLODbVT118M+7gssyESQxXiLvwX0e/uQylzIOcqwRCm2AmV/txdgYYIaLIuLg
         5QaTgUtw75dbEXRO3D1SwFOsTDLM2xqSRA5GMNTo=
Received: by mail-vk1-f175.google.com with SMTP id c8so2678195vkn.9
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jan 2020 09:35:14 -0800 (PST)
X-Gm-Message-State: APjAAAUIIAd4Sq8A1AEr+cpkpz9Kf6PfObjoL61xKwa6QN/jj/U+uepJ
        JDzXWg9JUkAniAhAF+DTHROEXpZ1qQadW29CnPQ=
X-Google-Smtp-Source: APXvYqzh7OOWQA9hihtU423DDQlCj7Zk9tTxMCLqi4yCwxJzpqf2c+runaDoKkuEC6YwQ1Q3iUCbSQja+emf1np2CnM=
X-Received: by 2002:a1f:90d4:: with SMTP id s203mr12083075vkd.65.1580232913229;
 Tue, 28 Jan 2020 09:35:13 -0800 (PST)
MIME-Version: 1.0
References: <20200124115204.4086-1-fdmanana@kernel.org> <20200128162143.GW3929@twin.jikos.cz>
In-Reply-To: <20200128162143.GW3929@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 28 Jan 2020 17:35:01 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4Jn-QDH7Oc7byqqHpPgGVe7xhGpwwQ_XKZhpGHodj0CQ@mail.gmail.com>
Message-ID: <CAL3q7H4Jn-QDH7Oc7byqqHpPgGVe7xhGpwwQ_XKZhpGHodj0CQ@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: send, fix emission of invalid clone operations
 within the same file
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 28, 2020 at 4:22 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Fri, Jan 24, 2020 at 11:52:04AM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When doing an incremental send and a file has extents shared with itself
> > at different file offsets, it's possible for send to emit clone operations
> > that will fail at the destination because the source range goes beyond the
> > file's current size. This happens when the file size has increased in the
> > send snapshot, there is a hole between the shared extents and both shared
> > extents are at file offsets which are greater the file's size in the
> > parent snapshot.
> >
> > Example:
> >
> >   $ mkfs.btrfs -f /dev/sdb
> >   $ mount /dev/sdb /mnt/sdb
> >
> >   $ xfs_io -f -c "pwrite -S 0xf1 0 64K" /mnt/sdb/foobar
> >   $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/base
> >   $ btrfs send -f /tmp/1.snap /mnt/sdb/base
> >
> >   # Create a 320K extent at file offset 512K.
> >   $ xfs_io -c "pwrite -S 0xab 512K 64K" /mnt/sdb/foobar
> >   $ xfs_io -c "pwrite -S 0xcd 576K 64K" /mnt/sdb/foobar
> >   $ xfs_io -c "pwrite -S 0xef 640K 64K" /mnt/sdb/foobar
> >   $ xfs_io -c "pwrite -S 0x64 704K 64K" /mnt/sdb/foobar
> >   $ xfs_io -c "pwrite -S 0x73 768K 64K" /mnt/sdb/foobar
> >
> >   # Clone part of that 320K extent into a lower file offset (192K).
> >   # This file offset is greater than the file's size in the parent
> >   # snapshot (64K). Also the clone range is a bit behind the offset of
> >   # the 320K extent so that we leave a hole between the shared extents.
> >   $ xfs_io -c "reflink /mnt/sdb/foobar 448K 192K 192K" /mnt/sdb/foobar
> >
> >   $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/incr
> >   $ btrfs send -p /mnt/sdb/base -f /tmp/2.snap /mnt/sdb/incr
> >
> >   $ mkfs.btrfs -f /dev/sdc
> >   $ mount /dev/sdc /mnt/sdc
> >
> >   $ btrfs receive -f /tmp/1.snap /mnt/sdc
> >   $ btrfs receive -f /tmp/2.snap /mnt/sdc
> >   ERROR: failed to clone extents to foobar: Invalid argument
> >
> > The problem is that after processing the extent at file offset 192K, send
> > does not issue a write operation full of zeroes for the hole between that
> > extent and the extent starting at file offset 520K (hole range from 384K
> > to 512K), this is because the hole is at an offset larger the size of the
> > file in the parent snapshot (384K > 64K). As a consequence the field
> > 'cur_inode_next_write_offset' of the send context remains with a value of
> > 384K when we start to process the extent at file offset 512K, which is the
> > value set after processing the extent at offset 192K.
> >
> > This screws up the lookup of possible extents to clone because due to an
> > incorrect value of 'cur_inode_next_write_offset' we can now consider
> > extents for cloning, in the same inode, that lie beyond the current size
> > of the file in the receiver of the send stream. Also, when checking if
> > an extent in the same file can be used for cloning, we must also check
> > that not only its start offset doesn't start at or beyond the current eof
> > of the file in the receiver but that the source range doesn't go beyond
> > current eof, that is we must check offset + length does not cross the
> > current eof, as that makes clone operations fail with -EINVAL.
> >
> > So fix this by updating 'cur_inode_next_write_offset' whenever we start
> > processing an extent and checking an extent's offset and length when
> > considering it for cloning operations.
> >
> > A test case for fstests follows soon.
> >
> > Fixes: 11f2069c113e02 ("Btrfs: send, allow clone operations within the same file")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Added to misc-next, with the tested-by tag, thanks.

Hold on a bit, one hunk of the patch besides not being necessary, it
causes problems with fallocated extents beyond i_size and trailing
holes.
I'll run some more tests to confirm the hunk is not needed and see if
Craig can test it too in the meanwhile.

Thanks.
