Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38E91DED1E
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 15:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfJUNHM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 09:07:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:37730 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728897AbfJUNHL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 09:07:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 577A1B693;
        Mon, 21 Oct 2019 13:07:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9633ADA8C5; Mon, 21 Oct 2019 15:07:23 +0200 (CEST)
Date:   Mon, 21 Oct 2019 15:07:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Patrik Lundquist <patrik.lundquist@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Lots of btrfs_dump_space_info in kernel log
Message-ID: <20191021130723.GG3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Patrik Lundquist <patrik.lundquist@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAA7pwKNn3BTb1Dxu9mOVoBvk0ftXfcEcFLwXEgiUEkwcwCWOcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA7pwKNn3BTb1Dxu9mOVoBvk0ftXfcEcFLwXEgiUEkwcwCWOcg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 21, 2019 at 12:58:12PM +0200, Patrik Lundquist wrote:
> I'm running Debian Testing with kernel 5.2.17-1. Five disk raid1 with
> at least 393.01GiB unallocated on each disk. No device errors. No
> kernel WARNINGs or ERRORs.
> 
> BTRFS info (device dm-1): enabling auto defrag
> BTRFS info (device dm-1): using free space tree
> BTRFS info (device dm-1): has skinny extents
> 
> Mounted with noauto,noatime,autodefrag,skip_balance,space_cache=v2,enospc_debug.
> 
> First btrfs_dump_space_info() is
> 
> BTRFS info (device dm-1): space_info 4 has 18446744073353838592 free,
> is not full
> BTRFS info (device dm-1): space_info total=10737418240,
> used=9636544512, pinned=0, reserved=27066368, may_use=1429454848,
> readonly=65536
> BTRFS info (device dm-1): global_block_rsv: size 536870912 reserved 536870912
> BTRFS info (device dm-1): trans_block_rsv: size 0 reserved 0
> BTRFS info (device dm-1): chunk_block_rsv: size 0 reserved 0
> BTRFS info (device dm-1): delayed_block_rsv: size 20185088 reserved 20185088
> BTRFS info (device dm-1): delayed_refs_rsv: size 868745216 reserved 868745216
> 
> and current last is
> 
> BTRFS info (device dm-1): space_info 4 has 0 free, is not full
> BTRFS info (device dm-1): space_info total=10737418240,
> used=9664561152, pinned=458752, reserved=2523136, may_use=1069809664,
> readonly=65536
> BTRFS info (device dm-1): global_block_rsv: size 536870912 reserved 536821760
> BTRFS info (device dm-1): trans_block_rsv: size 0 reserved 0
> BTRFS info (device dm-1): chunk_block_rsv: size 0 reserved 0
> BTRFS info (device dm-1): delayed_block_rsv: size 0 reserved 0
> BTRFS info (device dm-1): delayed_refs_rsv: size 556531712 reserved 498647040
> 
> with lots more in between and no other Btrfs kernel printing preceding
> it since mounting.
> 
> It's the first time I'm seeing it but I have always mounted with
> enospc_debug since it always seems too late to add the option when you
> finally need it.
> 
> What does it mean? Should I be worried? What to do? No apparent problems yet.

enospc_debug is known to be noisy, in many cases it prints the state of
the space management structures at some interesting points. It's
possible that the amount of the information dumped changes over time,
there have been updates to the space reservations and related code.

I've checked the message levels of the messages printed under the
option, some of them are 'debug' some of them are 'info'. I would be
possible to make them all 'debug' so they are in the log but you can
filter them out on console.
