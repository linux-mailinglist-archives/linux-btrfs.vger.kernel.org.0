Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E7E32EFC1
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Mar 2021 17:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhCEQMt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Mar 2021 11:12:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:50342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhCEQMk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Mar 2021 11:12:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7BCDEACBF;
        Fri,  5 Mar 2021 16:12:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0C2EBDA79B; Fri,  5 Mar 2021 17:10:43 +0100 (CET)
Date:   Fri, 5 Mar 2021 17:10:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     dsterba@suse.cz, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: Fix checksum output for "checksum verify
 failed"
Message-ID: <20210305161042.GY7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210227200702.11977-1-davispuh@gmail.com>
 <20210302141701.GI7604@twin.jikos.cz>
 <CAOE4rSxzMUQurSp6GqHYeW8=JoMR5atvfP_Ot-Jn0maP-i8U+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOE4rSxzMUQurSp6GqHYeW8=JoMR5atvfP_Ot-Jn0maP-i8U+Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 03, 2021 at 09:39:09PM +0200, Dāvis Mosāns wrote:
> otrd., 2021. g. 2. marts, plkst. 16:18 — lietotājs David Sterba
> (<dsterba@suse.cz>) rakstīja:
> > So the direction says if it's big endian or little endian, right, so for
> > xxhash it's bigendian but the crc32c above it's little.
> 
> The problem is that both crc and xxhash uses native CPU endianess -
> they're 32-bit and 64-bit numbers. But sha256 and blake2 always uses
> big endian when displayed.
> So here I implemented this difference.

That would be right if we really used just the integer types to show the
number, but with the additional algorithms the checksum is a byte
buffer.

> > In kernel the format is 0x%*phN, which translates to 'hexadecimal with
> > variable length', so all the work is hidden inside printk. But still
> > there are no changes in the 'direction'.
> 
> I wasn't aware of such format specifier, but unfortunately here in
> btrfs-progs printk is just alias to fprintf which doesn't support this
> format. So not sure if there's any better way to implement this.

Potentially we could add own printf format
(https://www.gnu.org/software/libc/manual/html_node/Customizing-Printf.html)
but it's not part of standard libc API.

> > I haven't actually checked if the printed format matches what kernel
> > does but would think that there should be no direction adjustment
> > needed.
> 
> I looked at kernel's implementation and it always outputs in big
> endian and that's why there's no such direction.
> 
> kernel output:
> > checksum verify failed on 21057101103104 wanted 0x753cdd5f found 0x9c0ba035 level 0
> 
> this patch's output:
> > checksum verify failed on 21057101103104 wanted 5FDD3C75 found 35A00B9C
> 
> As you can see for crc32c they're reversed. This isn't really big
> problem but it can be confusing as most tools output crc as number
> which converted to hex won't match kernel's output.
> Not sure if we should stick to how kernel is outputting for sake of
> consistency or if this would be better...

I think the consistency needs to be preserved, it's too confusing when
the same filesystem would get two different checksums reported. Reporting
the bytes in hex "as they're stored in order", which corresponds to the
big-endian ordering.
