Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8475F31C8EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 11:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhBPKiQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 05:38:16 -0500
Received: from ns.bouton.name ([109.74.195.142]:34054 "EHLO mail.bouton.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhBPKiP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 05:38:15 -0500
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2021 05:38:14 EST
Received: from [192.168.0.39] (82-65-239-81.subs.proxad.net [82.65.239.81])
        by mail.bouton.name (Postfix) with ESMTP id 75301B84D;
        Tue, 16 Feb 2021 11:28:58 +0100 (CET)
Subject: Re: performance recommendations
To:     "Pal, Laszlo" <vlad@vlad.hu>, Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAFTxqD_-OiGjA3EEycKwKGteYPmA6OjPhMxce8f1w8Ly=wd2pg@mail.gmail.com>
 <e70bbe98-f6dc-9eaa-8506-cd356a1c2ed8@suse.com>
 <CAFTxqD9E2egJ22MorzXPAHaNDKg5QoEBK=Cd4ChOdT6Odiy6Rg@mail.gmail.com>
From:   Lionel Bouton <lionel-subscription@bouton.name>
Message-ID: <0fbd4108-153f-ab89-b7d9-1c56c23c6f60@bouton.name>
Date:   Tue, 16 Feb 2021 11:28:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAFTxqD9E2egJ22MorzXPAHaNDKg5QoEBK=Cd4ChOdT6Odiy6Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Le 16/02/2021 à 09:54, Pal, Laszlo a écrit :
> [...]
> So, as far as I see the action plan is the following
> - enable v2 space_cache. is this safe/stable enough?
> - run defrag on old data, I suppose it will run weeks, but I'm ok with
> it if the server can run smoothly during this process
> - compress=zstd is the recommended mount option? is this performing
> better than the default?
> - I'm also thinking to -after defrag- compress my logs with
> traditional gzip compression and turn off on-the-fly compress (is this
> a huge performance gain?)
>
> [...]
>
> 3.10.0-1160.6.1.el7.x86_64 #1 SMP Tue Nov 17 13:59:11 UTC 2020 x86_64
> x86_64 x86_64 GNU/Linux
>

As Nikolay pointed out, this is a vendor kernel based on a very (more
than 7 years) old kernel version and this can create problems.
For reference, see
https://btrfs.wiki.kernel.org/index.php/Changelog#By_feature

- v2 space_cache appeared in 4.3.
- compress=zstd appeared in 4.14.

So for the 2 questions related to those, you'll have to ask the
distribution if they back-ported them (I doubt it, usually only bugfixes
are backported).

I wouldn't be comfortable using a 3.10 based kernel with BTRFS. For
example there was at least one compress=lzo bug (race condition?) that
corrupted data on occasions that was fixed (from memory) in either a
late 3.x kernel or a 4.x kernel. The stability and performance on such a
base will not compare well with the current state of BTRFS.

If you really want to go ahead with this kernel and BTRFS I would at
least avoid compression with it and as you suggested in your last point
compress at the application level.

Note that compression will make fragmentation worse. BTRFS uses small
individually compressed extents (probably because there isn't any other
decent way to minimize the costs of seeking into a file). The more
extents you have the more opportunity for fragmentation exist.

For defragmentation, I use something I coded to replace autodefrag which
was not usable in my use cases :
https://github.com/jtek/ceph-utils/blob/master/btrfs-defrag-scheduler.rb
The complexity is worth it for me because it allows good performance on
filesystem where I need BTRFS (either for checksums or snapshots). For a
log server I wouldn't consider it but you already bit the BTRFS bullet
so it might help depending on the details (it could be adapted to handle
a transition to a more sane state for example).
Initially it was fine-tuned to handle Ceph OSDs and latter on adapted to
very large BTRFS volumes backing NFS servers, backup servers (see the
README in the same repository) or even some of our PostgreSQL replicas.
The initialization on an existing filesystem needs special (undocumented
unfortunately) care though. By default the first pass goes very fast to
get an estimation of the number of files and this can create a very
large I/O load. If you decide to test it, I can provide directions (or
update the documentation). For a pure log server it is overkill (you
could simply defragment files on file rotation).


To sum up : if I were in your position I would probably choose between
these alternatives :
- switch to ext4 (maybe the easiest unless the migration is impractical),
- defragment old files that aren't written to anymore and schedule
defragmentation when log files are archived (maybe using logrotate),
- use my defragmentation scheduler as a last resort (might be a solution
if you store other data than logs in the filesystem too).

In all cases I would avoid BTRFS compression and compress on log
rotation. You'll get better performance and compression this way.

If you can update the kernel, use space_cache=v2, it is stable on recent
kernels (I don't even remember it being buggy even with the earlier
kernels).

Best regards,

Lionel
