Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22BF3A4CEC
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2019 02:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfIBAwE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Sep 2019 20:52:04 -0400
Received: from fenrir.routify.me ([155.94.238.126]:43508 "EHLO
        fenrir.routify.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfIBAwE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Sep 2019 20:52:04 -0400
Received: from coach (unknown [50.236.75.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by fenrir.routify.me (Postfix) with ESMTPSA id 4B5C140023;
        Mon,  2 Sep 2019 00:52:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 fenrir.routify.me 4B5C140023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seangreenslade.com;
        s=fenrir-outgoing; t=1567385523;
        bh=3ZjtU+UF6AuUOjQ4lFwLlKuZUqxWLWjKTuZLyhXZwv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jrAAt5g3xvdwShWCDenFzuvu2+jzm+pgznqK056tUVDzZQVOcmlwGvPZzN/ddFLbz
         X93/nws0k1BPmFoDHzyZ5KPSscTX7qWP9pRXV66yymEc37EE1SenF3VEvxoxv2gTIo
         WEmg6pC011EehmtmYKWPLtF71zvMjThxUCLpMHLk=
Date:   Sun, 1 Sep 2019 17:52:01 -0700
From:   Sean Greenslade <sean@seangreenslade.com>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Spare Volume Features
Message-ID: <20190902005201.GA12944@coach>
References: <0b7bfde0-0711-cee3-1ed8-a37b1a62bf5e@megavolts.ch>
 <CD4A10E4-5342-4F72-862A-3A2C3877EC36@seangreenslade.com>
 <20190901032855.GA5604@coach>
 <6590a3f4-891d-2b22-ed43-4d2def43f290@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6590a3f4-891d-2b22-ed43-4d2def43f290@gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 01, 2019 at 11:03:59AM +0300, Andrei Borzenkov wrote:
> 01.09.2019 6:28, Sean Greenslade пишет:
> > 
> > I decided to do a bit of experimentation to test this theory. The
> > primary goal was to see if a filesystem could suffer a failed disk and
> > have that disk removed and rebalanced among the remaining disks without
> > the filesystem losing data or going read-only. Tested on kernel
> > 5.2.5-arch1-1-ARCH, progs: v5.2.1.
> > 
> > I was actually quite impressed. When I ripped one of the block devices
> > out from under btrfs, the kernel started spewing tons of BTRFS errors,
> > but seemed to keep on trucking. I didn't leave it in this state for too
> > long, but I was reading, writing, and syncing the fs without issue.
> > After performing a btrfs device delete <MISSING_DEVID>, the filesystem
> > rebalanced and stopped reporting errors.
> 
> How many devices did filesystem have? What profiles did original
> filesystem use and what profiles were present after deleting device?
> Just to be sure there was no silent downgrade from raid1 to dup or
> single as example.

I did the simplest case: raid1 with 3 disks, dropping 1 disk to end up
with raid1 with 2 disks. I did check and btrfs fi usage reported no dup
or single chunks.

> > Looks like this may be a viable
> > strategy for high-availability filesystems assuming you have adequate
> > monitoring in place to catch the disk failures quickly. I personally
> > wouldn't want to fully automate the disk deletion, but it's certainly
> > possible.
> > 
> 
> This would be valid strategy if we could tell btrfs to reserve enough
> spare space; but even this is not enough, every allocation btrfs does
> must be done so that enough spare space remains to reconstruct every
> other missing chunk.
> 
> Actually I now ask myself - what happens when btrfs sees unusable disk
> sector(s) in some chunk? Will it automatically reconstruct content of
> this chunk somewhere else? If not, what is an option besides full device
> replacement?

As far as I can tell, btrfs has no facility for dealing with medium
errors (besides just reporting the error).  I just re-ran a simple test
with a two-device raid1 with one device deleted after mounting. Btrfs
complains loudly every time writes to the missing disk fail, but doesn't
retry or redirect these writes.  One half of the raid1 block group makes
it to disk, the other gets lost to the void. The chunk that makes it to
disk is still of raid1 type.

Essentially, it seems that btrfs currently had no way of marking a disk
as offline / missing / problematic post-mount. Additionally, and
possibly more troubling, is the fact that a failed chunk write will not
get retried, even if there is another disk that could possibly accept
that write. I think that for my fake-hot-spare proposal to be viable as
a fault resiliancy measure, this failed-chunk-retry logic would need to
be implemented. Otherwise you're living without data redundancy for some
old data and some (or potentially all) new data from the moment the
first medium error occurs until the moment the device delete completes
successfully.

--Sean

