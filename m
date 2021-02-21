Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48861320C22
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Feb 2021 18:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhBURpa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Feb 2021 12:45:30 -0500
Received: from ns2.wdyn.eu ([5.252.227.236]:37856 "EHLO ns2.wdyn.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhBURp1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Feb 2021 12:45:27 -0500
Subject: Re: Unexpected "ERROR: clone: did not find source subvol" on btrfs
 receive
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1613929513;
        bh=X8rFm9w3qfaebdqWur/e59rUEdtrBvTNkPlrvNxHj6U=;
        h=Subject:From:To:References:Date:In-Reply-To;
        b=H8hYmPIbTjib4PmXf6Om+eA2T4DaPmFZhfxMXKMGG2rrtSsyLzttc+fx3/3WC/nUs
         SP8bOkGS9cS9c0MetcSV5cm7ksmKFmFKOkkQRx4L+kFy08cWOcCNUN0mYBRl2xpQU7
         qnav++B8gCiRzFrRqYlQxTbQMz7AATqBOZri4A4Q=
From:   Alexander Wetzel <alexander@wetzel-home.de>
To:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
References: <41b096e1-5345-ae9c-810b-685499813183@wetzel-home.de>
 <0fcbd697-11c5-0b32-7e08-80cf8d355271@gmail.com>
 <0d8ff769-59b3-9bbe-d958-9879e6f34719@wetzel-home.de>
 <a2e5da8e-4267-4ef4-b259-18fa98aac263@wetzel-home.de>
Message-ID: <325a62bf-8686-229c-d581-f102f0fc3f1f@wetzel-home.de>
Date:   Sun, 21 Feb 2021 18:44:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <a2e5da8e-4267-4ef4-b259-18fa98aac263@wetzel-home.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 21.02.21 um 12:57 schrieb Alexander Wetzel:
>> While compiling I also switched to 
>> https://github.com/kdave/btrfs-progs.git. Same problem.
>>
>> I then tracked the error down up to btrfs_uuid_tree_lookup_any():
>>
>> nr_items is zero after the call
>> ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &search_arg);
>> (ret is also zero)
>>
>> So looks like this is a filesystem issue?
> 
> I've now "reused" the ret < 0 output in btrfs_uuid_tree_lookup_any() and 
> added nt_items to it, too.
> 
> Then I get:
> 
> # /home/alex/src/b2/btrfs-progs/btrfs  receive -f test2 .
> At snapshot 2021-02-20-TEMP
> ioctl(BTRFS_IOC_TREE_SEARCH, uuid, key 483c17093f551dd3, UUID_KEY, 
> 896d0cfd51ec5cb6, nr_items=0) ret=0, error: No such file or directory
> ioctl(BTRFS_IOC_TREE_SEARCH, uuid, key 483c17093f551dd3, UUID_KEY, 
> 896d0cfd51ec5cb6, nr_items=0) ret=0, error: No such file or directory
> ERROR: clone: did not find source subvol si=0, 
> uuid=d31d553f-0917-3c48-b65c-ec51fd0c6d89
> 


In common/send-stream.c read_and_process_cmd() the very first time we 
try to use BTRFS_SEND_C_CLONE it triggers the problem on my setup.

Dumping the variables of the problematic call here I get:
   path=var/lib/mysql/nextcloud/oc_activity.ibd
   offset=745472
   len=303104
   uuid=d31d553f-0917-3c48-b65c-ec51fd0c6d89
   clone_ctransid=195056
   clone_path=var/lib/mysql/nextcloud/oc_activity.ibd
   clone_offset=745472

Guessing around I assume this is an instruction to clone 303104 Bytes at 
offset 745472 for var/lib/mysql/nextcloud/oc_activity.ibd from the 
parent subvol uuid d31d553f-0917-3c48-b65c-ec51fd0c6d89 at generation 
195056.

So I suspect now my problem is, that my RO snapshot hs somehow
Generation != (Gen at creation).
A RO snapshot should not be able to get to a newer generation, correct?

Or maybe that btrfs send is using "Gen at creation" instead of 
"Generation"... but don't think so.


# btrfs sub show 2021-02-14/
2021-02-14
         Name:                   2021-02-14
         UUID:                   d31d553f-0917-3c48-b65c-ec51fd0c6d89
         Parent UUID:            a2ff485b-9f8f-2543-ad03-dc7c917e143b
         Received UUID:          -
         Creation time:          2021-02-14 21:46:26 +0100
         Subvolume ID:           358
         Generation:             208977	<---
         Gen at creation:        195056
         Parent ID:              5
         Top level ID:           5
         Flags:                  readonly
         Snapshot(s):
                                 2021-02-20-TEMP

Now I somehow got another test ro snapshot to a new generation:
# btrfs sub snap -r active/ t1
Create a readonly snapshot of 'active/' in './t1'
# btrfs sub show t1
t1
         Name:                   t1
         UUID:                   70e6a915-e03a-fb48-869e-98ab8bad2ad4
         Parent UUID:            a2ff485b-9f8f-2543-ad03-dc7c917e143b
         Received UUID:          -
         Creation time:          2021-02-21 18:02:32 +0100
         Subvolume ID:           411
         Generation:             209009
         Gen at creation:        209009
         Parent ID:              5
         Top level ID:           5
         Flags:                  readonly
         Snapshot(s):


Playing around a bit I found out that renaming a subvol can - but not 
always - advances the generation:

# btrfs sub snap -r active/ t1
Create a readonly snapshot of 'active/' in './t1'
# btrfs sub show t1
t1
         Name:                   t1
         UUID:                   83d278b0-1782-3a4a-8293-c6df2e67acd4
         Parent UUID:            a2ff485b-9f8f-2543-ad03-dc7c917e143b
         Received UUID:          -
         Creation time:          2021-02-21 18:34:40 +0100
         Subvolume ID:           414
         Generation:             209069
         Gen at creation:        209069
         Parent ID:              5
         Top level ID:           5
         Flags:                  readonly
         Snapshot(s):
# mv t1 x1
# btrfs sub show x1
x1
         Name:                   x1
         UUID:                   83d278b0-1782-3a4a-8293-c6df2e67acd4
         Parent UUID:            a2ff485b-9f8f-2543-ad03-dc7c917e143b
         Received UUID:          -
         Creation time:          2021-02-21 18:34:40 +0100
         Subvolume ID:           414
         Generation:             209070
         Gen at creation:        209069
         Parent ID:              5
         Top level ID:           5
         Flags:                  readonly
         Snapshot(s):

But that is not always working. Creating/renaming/deleting snapshots I 
can trigger it from time to time but so far I don't see a pattern.

But then I just got that:
# btrfs sub snap -r active/ q1
Create a readonly snapshot of 'active/' in './q1'
# btrfs sub show q1
q1
         Name:                   q1
         UUID:                   53a3833c-9caa-b944-80d1-8d592c68ff74
         Parent UUID:            a2ff485b-9f8f-2543-ad03-dc7c917e143b
         Received UUID:          -
         Creation time:          2021-02-21 18:40:20 +0100
         Subvolume ID:           416
         Generation:             209084
         Gen at creation:        209083
         Parent ID:              5
         Top level ID:           5
         Flags:                  readonly
         Snapshot(s):
root@mail:/mnt/backup/backupdev#

No rename necessary and the generations also differ...

But I guess I'm at then end of what I can find out without a much better 
understanding of btrfs internals...

I hope someone here can shed more light on that,

Alexander
