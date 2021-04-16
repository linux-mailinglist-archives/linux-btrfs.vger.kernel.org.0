Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B79361DDB
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 12:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240946AbhDPKTm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 06:19:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:52146 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238871AbhDPKTl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 06:19:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A77B2AFE8;
        Fri, 16 Apr 2021 10:19:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 163CDDA790; Fri, 16 Apr 2021 12:16:58 +0200 (CEST)
Date:   Fri, 16 Apr 2021 12:16:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     =?iso-8859-1?Q?Niccol=F2?= Belli <darkbasic@linuxsystems.it>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: Dead fs on 2 Fedora systems: block=57084067840 write time tree
 block corruption detected
Message-ID: <20210416101657.GX7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        =?iso-8859-1?Q?Niccol=F2?= Belli <darkbasic@linuxsystems.it>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <d97168fe4c9e7560fb6229fb4f971bfd@linuxsystems.it>
 <CAJCQCtQ_B6b2vrntaXLO5bWdi_1X7p09F84S1pbpEVXX9_g_1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtQ_B6b2vrntaXLO5bWdi_1X7p09F84S1pbpEVXX9_g_1w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 15, 2021 at 11:06:32AM -0600, Chris Murphy wrote:
> First computer/file system:
> 
> (from the photo):
> 
> [   136.259984] BTRFS critical (device nvme0n1p8): corrupt leaf: root=257
> block=31259951104 slot=9 ino=3244515, name hash mismatch with key, have
> 0x00000000F22F547D expect 0x0000000092294C62
> 
> This is not obviously a bit flip. I'm not sure what's going on here.

Not a bitflip in the hash itself, but it's produced by hashing a file
name, and if that had a bitflip then the hashes would differ. We've seen
a that already, there could be traces of the bogus filename in logs.

> Second computer/file system:
> 
> [30177.298027] BTRFS critical (device nvme0n1p8): corrupt leaf: root=791
> block=57084067840 slot=64 ino=1537855, name hash mismatch with key, have
> 0x00000000a461adfd expect 0x00000000a461adf5

Yes that's a bitflip in the hash,

bin(0x00000000a461adfd^0x00000000a461adf5) = 0b1000
