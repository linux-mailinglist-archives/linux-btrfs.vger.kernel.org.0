Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF163FB82A
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 16:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbhH3OYv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 10:24:51 -0400
Received: from ns.bouton.name ([109.74.195.142]:46542 "EHLO mail.bouton.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237470AbhH3OYh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 10:24:37 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Aug 2021 10:24:37 EDT
Received: from [192.168.0.15] (82-65-239-81.subs.proxad.net [82.65.239.81])
        by mail.bouton.name (Postfix) with ESMTP id 29A80B84D;
        Mon, 30 Aug 2021 16:18:33 +0200 (CEST)
Subject: Re: Questions about BTRFS balance and scrub on non-RAID setup
To:     Andrej Friesen <andre.friesen@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CABFqJH6acH=240RxRhVj5Y9geh-QG7vdDWAgFespwu0nk3wgaQ@mail.gmail.com>
From:   Lionel Bouton <lionel-subscription@bouton.name>
Message-ID: <04941c75-3ea5-32de-5978-efe5c5681ee2@bouton.name>
Date:   Mon, 30 Aug 2021 16:18:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABFqJH6acH=240RxRhVj5Y9geh-QG7vdDWAgFespwu0nk3wgaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Le 30/08/2021 à 15:20, Andrej Friesen a écrit :
> {...]
> Use case and context for my questions:
>
> A file system as a service for our customers.
> This will be offered to the customer as a network share via NFS. That
> also means we do not have any control over the usage patterns.
> No idea about how often, how much they write small or big files to
> that file system.
>
> Technically we only create one block device with several terabytes and
> format this with btrfs. The actual block device which we format is
> backed by a ceph cluster.
> So the actual block device is already been on a distributed storage,
> therefore we will not do any raid configuration.
>
> The kernel will be a recent 5.10.
>
> Scrub:
>
> Do I need to regularly scrub?
> If so, what would be a recommendation for my use case?
>
> My conclusion after reading about the scrub. This checks for damaged
> data and will recover the data if this filesystem has another copy of
> that data.
> Since we will run without raid in btrfs this is not needed in my opinion.
> Am I right with my conclusion here?

Partially. Ceph replication/scrub/repair will cover individual disk/OSD
server faults but not faults at the origin of the data being stored.

We provide the same service for a customer. Several years ago the VM
hosting the NFS server for this customer ran on hardware that developed
a fault, the result was silent corruption of the data written by the NFS
server *before* being handed to Ceph for storage (probably memory or CPU
related, we threw the server out of the cluster and never looked back...).
- ceph scrubbing was of no use there because from its point of view the
replicated blocks were all fine.
- we launch btrfs scrub monthly by default and this is how we detected
the corruption.

We make regular rbd snapshots so we could :
- switch the NFS server to an existing read-only replica (that could not
be corrupted by the same fault as it was replicated using simple
file-level content synchronization),
- restart the original NFS server using the last known good snapshot,
- rsync fresh data from the replica to the original server to catch up,
- switch back.

IIRC I've seen posts here about more checks done in the write path to
catch corruption but even if the likelihood of such corruption is lower
with recent kernels, hardware faults happen and software solutions can't
fully cover for them. Being able to catch corruption after the fact
relatively early makes recovery simpler and faster so I would only
disable scrubs on disposable data. Imagine discovering corruption when
you reboot your NFS server and the filesystem refuses to mount...

>
> Balance:
>
> Do I need to regularly balance my filesystem?
> If so, what would be a recommendation for my use case?

Full balance is probably overkill in any situation and can sunk your I/O
bandwidth. With recent kernels it seems there is less need for
balancing. We still use an automatic balancing script that tries to
limit the amount of free space allocated to nearly empty allocation
groups (by using "usage=50+" filters) and cancels the balance if it is
too long (to avoid limiting IO performance for too long, waiting for a
next call to continue) but I'm not sure if it's still worth it. In our
case we have been bitten by out of space situations with old kernels
brought by over-allocation of free space due to temporary large space
usages so we consider it an additional safeguard.

You probably want to use autodefrag or a custom defragmentation solution
too. We weren't satisfied with autodefrag in some situations (were
clearly fragmentation crept in and IO performance suffered until a
manual defrag) and developed our own scheduler for triggering
defragmentation based on file writes and slow full filesystem scans,
using filefrag to estimate the fragmentation cost file by file.

Best regards,

Lionel
