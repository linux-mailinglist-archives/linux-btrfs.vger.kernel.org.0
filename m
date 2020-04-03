Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1F519DBE4
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 18:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404574AbgDCQl2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 12:41:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:39690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbgDCQl2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Apr 2020 12:41:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE907AA7C;
        Fri,  3 Apr 2020 16:41:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 19F9ADA727; Fri,  3 Apr 2020 18:40:51 +0200 (CEST)
Date:   Fri, 3 Apr 2020 18:40:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 13/15] btrfs: simplify direct I/O read repair
Message-ID: <20200403164050.GH5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
 <38cea444fa3f88ca514d161bd979d004c254e969.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38cea444fa3f88ca514d161bd979d004c254e969.1583789410.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 09, 2020 at 02:32:39PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Direct I/O read repair is an over-complicated mess. There is major code
> duplication between __btrfs_subio_endio_read() (checks checksums and
> handles I/O errors for files with checksums),
> __btrfs_correct_data_nocsum() (handles I/O errors for files without
> checksums), btrfs_retry_endio() (checks checksums and handles I/O errors
> for retries of files with checksums), and btrfs_retry_endio_nocsum()
> (handles I/O errors for retries of files without checksum). If it sounds
> like these should be one function, that's because they should.
> 
> After the previous commit getting rid of orig_bio, we can reuse the same
> endio callback for repair I/O and the original I/O, we just need to
> track the file offset and original iterator in the repair bio. We can
> also unify the handling of files with and without checksums and replace
> the atrocity that was probably the inspiration for "Go To Statement
> Considered Harmful" with normal loops. We also no longer have to wait
> for each repair I/O to complete one by one.

This patch looks like a revert of 8b110e393c5a ("Btrfs: implement repair
function when direct read fails"), that probably added the extra layer
you're removing.

So instead of the funny remarks, I'd rather see some analysis that the
issues in the original patch are not coming back.  Quoting from the
changelog:

- When we find the data is not right, we try to read the data from the other
  mirror.
- When the io on the mirror ends, we will insert the endio work into the
  dedicated btrfs workqueue, not common read endio workqueue, because the
  original endio work is still blocked in the btrfs endio workqueue, if we
  insert the endio work of the io on the mirror into that workqueue, deadlock
  would happen.
- After we get right data, we write it back to the corrupted mirror.
- And if the data on the new mirror is still corrupted, we will try next
  mirror until we read right data or all the mirrors are traversed.
- After the above work, we set the uptodate flag according to the result.

It's not too detailed either, but what immediatelly looks suspicious is
the extra workqueue that was added to avoid deadlocks. That is now going
to be removed. This seems like a high level change even for such an old
code (2014) so that its effects are not affected by some other changes
in the dio code.
