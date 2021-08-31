Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C563FC7D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 15:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhHaNHA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 09:07:00 -0400
Received: from ns.bouton.name ([109.74.195.142]:57538 "EHLO mail.bouton.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232667AbhHaNHA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 09:07:00 -0400
Received: from [192.168.0.15] (82-65-239-81.subs.proxad.net [82.65.239.81])
        by mail.bouton.name (Postfix) with ESMTP id E9A51B84D;
        Tue, 31 Aug 2021 15:06:03 +0200 (CEST)
Subject: Re: Questions about BTRFS balance and scrub on non-RAID setup
To:     Andrej Friesen <andre.friesen@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CABFqJH6acH=240RxRhVj5Y9geh-QG7vdDWAgFespwu0nk3wgaQ@mail.gmail.com>
 <04941c75-3ea5-32de-5978-efe5c5681ee2@bouton.name>
 <d765bf95-0463-59bd-022a-39a0c2d8a241@gmail.com>
From:   Lionel Bouton <lionel-subscription@bouton.name>
Message-ID: <24cfdf07-b48b-bb70-7db1-d0c39dc6fc46@bouton.name>
Date:   Tue, 31 Aug 2021 15:06:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d765bf95-0463-59bd-022a-39a0c2d8a241@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Le 31/08/2021 à 10:17, Andrej Friesen a écrit :
> Hi,
>
> thanks for the useful information Lionel.
> That already helped a lot!

My pleasure.

>
> [...]
> In order to solve the file system full "problem" we wanted to create a
> large block device and use a quota of lets say 80 % of that for the
> data subvolume.
> We could also make the block device double the size of the subvolume
> and quota we offer because it is thin provisioned from the ceph side
> we do not lose any storage.

We've never used quotas with btrfs. There's a long history of
difficulties with them that I didn't follow closely. My impression is
that the situation is improving but IIRC I've seen somewhat recent
messages on this list advising them to be disabled at least temporarily
to get out of trouble (something like them slowing down balances). I'd
advise documenting yourself on these difficulties before using quotas.

We over-provision by creating comparatively large RBD volumes allowing
for future growth, create a smaller filesystem and don't limit storage
space based on Unix users so we don't need quotas. We bill the customer
based on actual space usage, monitor the filesystem space used and
resize it when needed (the goal is avoiding reaching 70% used) keeping
the customer in the loop when doing so to better evaluate their needs
and prevent unwanted surprises at billing time.

> We have tested discard/trim with btrfs and ceph and everything worked
> fine :-)

We don't use it often but never had a problem with it.

>
> Is there any metric we could/should measure in order to see if a
> balance would give us some benefit in some way?

You can have a pretty good idea directly with the "btrfs fi usage" output.

In case you are interested I developed this to keep filesystems from
being filled with mostly empty allocation groups :
https://github.com/jtek/ceph-utils/blob/master/btrfs-auto-rebalance.rb

By default it launches balances with increasing usage= values when it
detects relatively large amounts of allocated free space (relatively is
configurable in the script). It tries to handle some corner cases too
(like almost full filesystems where naive balances fail). Some
complexities could probably be removed as they deal with problems that
don't seem to appear anymore (at least not with regular uses of the script).

You can launch it with "-a" (for analyze) to get a "waste" percent
(amount of free space that is in allocation groups and could
theoretically be freed) for all your btrfs filesystems. It parses btrfs
fi usage and it doesn't need root just for analyzing although you'll get
warnings (and it probably won't work properly on multi-device filesystems).

>
> Did you only do the balance for the file system full problem?
>

Yes initially it was only to avoid this problem and we kept it as a
safeguard.

Doing it regularly seems to help speeding up shrinking filesystems and
limiting the IO load when doing so. When you shrink a filesystem it has
to move allocation groups to the beginning of the block device and I
believe this move is one side-effect of balance. Only allocation groups
matching your balance filters will move but my understanding and limited
experience is that they mostly move towards the beginning of the block
device. Spreading balances over long periods of time in advance is less
impactful than waiting until the last moment to move large amounts of
data when you need to shrink the filesystem.

I guess there might be some minor or even negligible performance
benefits too in some cases (less allocation groups probably means less
time spent on them for some operations) and on HDDs there was an
incentive to keep all allocation groups nice and tidy to avoid large
seek times.

>
> I saw a recommendation to run this balance daily:
>
> `btrfs balance start -dusage=50 -dlimit=2 -musage=50 -mlimit=4`
>
> Source:
> https://github.com/netdata/netdata/issues/3203#issuecomment-356026930
>
> Is that a valid recommendation still today?
> If so, why is the FAQ not having such information available?

This is probably heavily dependent on your use case and why there isn't
a single solution. Balance is usually very IO intensive and can block
other operations for long periods of time. This seems the reason for the
limit filters of the recommendation you cited above. And this is the
reason for the tuning parameters (MAX_TIME and MAX_FS_TIME) I put in the
btrfs-auto-rebalance.rb script (instead of limiting the number of
operations it limits the time spent doing them).
Depending on the device IO behavior we had to lower MAX_FS_TIME to 20
minutes and on some occasions even less to avoid disturbing clients too
much on some systems and could raise it on others with faster storage
devices or less client load.

The problem exists in a more limited way with defragmentation too : it
seems these operations bypass the IO scheduler priorities and will
happily delay other IO (ionice didn't have any measurable effect with
all IO schedulers supporting IO priorities we tried).

> I am happy to put something in the wiki, if needed.
>
>
> Defragmentation:
>
>> You probably want to use autodefrag or a custom defragmentation solution
>> too. We weren't satisfied with autodefrag in some situations (were
>> clearly fragmentation crept in and IO performance suffered until a
>> manual defrag) and developed our own scheduler for triggering
>> defragmentation based on file writes and slow full filesystem scans,
>
>
> The ceph cluster only uses SSDs therefore I guess we do not suffer
> from fragmentation problem as with HDDs. As far as I understood SSDs.
>

Depending on your SSDs and the rest of your cluster hardware they can
still become the limiting factor if you force small IOs on them which
fragmentation will do. In your case, even with SSD Ceph has a minimum
"seek" time (the RTT for an IO request is almost always above 1ms). This
is compounded by the fact that even if the Ceph client sees a delay for
its request, the SSD behind has bandwidth left for other clients (or
even the same client if it is doing multiple IO requests) so the cluster
as a whole is often fine and performance doesn't plummet.
So fragmentation doesn't bite you nearly as hard on SSD and even with
added Ceph latencies I don't expect an SSD-based RBD volume to be
crushed by fragmentation. I would keep an eye on the IO wait times of
the NFS server (this can become worse very slowly so we keep an history
of at least a whole year) and be ready to defragment but I wouldn't
worry too much about it. An alert raised when the average recent wait
times (say over a week) jumps by an order of magnitude compared to the
average over the year is a good start.

AFAIK you can deal with the problem easily if it arises simply by
defragmenting manually the most used files and mount -o
remount,autodefrag <yourfs>. With HDDs the performance can become so bad
that your clients are blocked just when you look at your cluster the
wrong way so correcting fragmentation problems becomes a frustrating
experience. I simply wouldn't use BTRFS on devices with significant seek
times (in the ~10ms range like most HDDs) without some form of
defragmentation solution.

Best regards,

Lionel
