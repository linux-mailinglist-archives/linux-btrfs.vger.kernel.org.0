Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3AA34F2C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2019 19:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfFDRne (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jun 2019 13:43:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46389 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfFDRne (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jun 2019 13:43:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so10748886pgr.13
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Jun 2019 10:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Nqys0QibcHtg7pZ32rgodwTwqGAr7UC9POKBIHDGbzY=;
        b=1ui4gQ4W1auwUk/+ndzImM3BCYwupGPb3ilSgdLwrmoygbu/nIFFyxFqrMsaeAVz4y
         wJjJYZKxGSui2DC/WyQhlZNNhnc0zeF+isFU+V1UBfifKEybUdqejy6T4aRkIoVl/VoF
         dxe2Qy+eMjgZ5kn6rmENzX1BzJTEcnHZLvGvdrf20ZCf448fbQsWzXjNccglkgV17GG5
         2lm4FuVjFEJOngrp47PqRdDL86LPwb19e1uzUbCBxYYNr4H+wSc/e5Q0bbzWtv460/cl
         /tZ32orRUNuNhHXV5KhEGk3gnIxgeYJKiVXscLHOai0Iz4I9iHnv2NdC7ZkjZVkojbtZ
         PlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Nqys0QibcHtg7pZ32rgodwTwqGAr7UC9POKBIHDGbzY=;
        b=T91GLJFpw2Fqsjr1qpv70is9GBUwWmJxtOFYtjX3vh8vKKjc2gJrRThOtyc6d+9II9
         gfKLb65cmS5zzcTpQDmkPDn1onSZDu4xaj49oC6DBMUIcf6V/gddKjJKe87Kk3MpRU4o
         kyoPEkyfl/ju9wqskVJKTI+ZE6yj4oDrM+dB+YMHTuSTy1bS2hSv32C4Zes9VYfc3Zc5
         geCtnWOHSbxZKsLXJTlz56qCo2+iPjgIpndJdv+WBOMdm98PGc+QSmcrPP1Z145ApZ+E
         VmYJVli+diulXs06SADR9BqNntvTMhB+0xb/lSH1HckmSoDJA42SN6HXPy39EzyTAto1
         WqpQ==
X-Gm-Message-State: APjAAAW9GMknvd8GGuzbWcdN1VGhkprH33tTMwJD1kE+ku4CtZ0I29wE
        Jf5hpImfcUn4mMXnVsPQQV23qw==
X-Google-Smtp-Source: APXvYqzmPNoeoXkJ9JmsCzwo6DOw1WRmElO0/3JF5KaIgyuXIKb8bjV4hq8aWW005rWkC4mMf/LXww==
X-Received: by 2002:aa7:8e45:: with SMTP id d5mr30959256pfr.172.1559670212983;
        Tue, 04 Jun 2019 10:43:32 -0700 (PDT)
Received: from localhost ([2620:10d:c090:200::1b10])
        by smtp.gmail.com with ESMTPSA id k2sm17802769pjl.23.2019.06.04.10.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:43:31 -0700 (PDT)
Date:   Tue, 4 Jun 2019 10:43:30 -0700
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: don't end the transaction for delayed refs in
 throttle
Message-ID: <20190604174329.t5iissthayiywyq6@roberthasiphone.dhcp.thefacebook.com>
References: <20190124143143.8838-1-josef@toxicpanda.com>
 <20190212160351.GD2900@twin.jikos.cz>
 <d10925d5-e036-379b-f68f-bf0f8fa1a5b9@gmx.com>
 <20190603173609.lxt6mejdqwryebzj@MacBook-Pro-91.local>
 <cdc66832-34a4-5b3b-2180-cd553e7e9124@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdc66832-34a4-5b3b-2180-cd553e7e9124@gmx.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 04, 2019 at 08:31:23AM +0800, Qu Wenruo wrote:
> 
> 
> On 2019/6/4 上午1:36, Josef Bacik wrote:
> > On Mon, Jun 03, 2019 at 02:53:00PM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2019/2/13 上午12:03, David Sterba wrote:
> >>> On Thu, Jan 24, 2019 at 09:31:43AM -0500, Josef Bacik wrote:
> >>>> Previously callers to btrfs_end_transaction_throttle() would commit the
> >>>> transaction if there wasn't enough delayed refs space.  This happens in
> >>>> relocation, and if the fs is relatively empty we'll run out of delayed
> >>>> refs space basically immediately, so we'll just be stuck in this loop of
> >>>> committing the transaction over and over again.
> >>>>
> >>>> This code existed because we didn't have a good feedback mechanism for
> >>>> running delayed refs, but with the delayed refs rsv we do now.  Delete
> >>>> this throttling code and let the btrfs_start_transaction() in relocation
> >>>> deal with putting pressure on the delayed refs infrastructure.  With
> >>>> this patch we no longer take 5 minutes to balance a metadata only fs.
> >>>>
> >>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >>>
> >>> For the record, this has been merged to 5.0-rc5
> >>>
> >>
> >> Bisecting leads me to this patch for strange balance ENOSPC.
> >>
> >> Can be reproduced by btrfs/156, or the following small script:
> >> ------
> >> #!/bin/bash
> >> dev="/dev/test/test"
> >> mnt="/mnt/btrfs"
> >>
> >> _fail()
> >> {
> >> 	echo "!!! FAILED: $@ !!!"
> >> 	exit 1
> >> }
> >>
> >> do_work()
> >> {
> >> 	umount $dev &> /dev/null
> >> 	umount $mnt &> /dev/null
> >>
> >> 	mkfs.btrfs -b 1G -m single -d single $dev -f > /dev/null
> >>
> >> 	mount $dev $mnt
> >>
> >> 	for i in $(seq -w 0 511); do
> >> 	#	xfs_io -f -c "falloc 0 1m" $mnt/file_$i > /dev/null
> >> 		xfs_io -f -c "pwrite 0 1m" $mnt/inline_$i > /dev/null
> >> 	done
> >> 	sync
> >>
> >> 	btrfs balance start --full $mnt || return 1
> >> 	sync
> >>
> >>
> >> 	btrfs balance start --full $mnt || return 1
> >> 	umount $mnt
> >> }
> >>
> >> failed=0
> >> for i in $(seq -w 0 24); do
> >> 	echo "=== run $i ==="
> >> 	do_work
> >> 	if [ $? -eq 1 ]; then
> >> 		failed=$(($failed + 1))
> >> 	fi
> >> done
> >> if [ $failed -ne 0 ]; then
> >> 	echo "!!! failed $failed/25 !!!"
> >> else
> >> 	echo "=== all passes ==="
> >> fi
> >> ------
> >>
> >> For v4.20, it will fail at the rate around 0/25 ~ 2/25 (very rare).
> >> But at that patch (upstream commit
> >> 302167c50b32e7fccc98994a91d40ddbbab04e52), the failure rate raise to 25/25.
> >>
> >> Any idea for that ENOSPC problem?
> >> As it looks really wired for the 2nd full balance to fail even we have
> >> enough unallocated space.
> >>
> > 
> > I've been running this all morning on kdave's misc-next and not had a single
> > failure.  I ran it a few times on spinning rust and a few times on my nvme
> > drive.  I wouldn't doubt that it's failing for you, but I can't reproduce.  It
> > would be helpful to know where the ENOSPC was coming from so I can think of
> > where the problem might be.  Thanks,
> > 
> > Josef
> > 
> 
> Since v5.2-rc2 has a lot of enospc debug output merged, here is the
> debug info just by enospc_debug:
>

Ah ok, sorry I'm travelling so I can't easily test a patch right now, but change
the btrfs_join_transaction() in btrfs_inc_block_group_ro to
btrfs_start_transaction(root, 0);  This will trigger the delayed ref flushing if
we need it and likely will fix the problem.  There's so much random cruft built
into the relocation enospc stuff that we're likely to keep finding problems like
this, we just need to rework it so it's still tripping over the normal
reservation path.  Thanks,

Josef 
