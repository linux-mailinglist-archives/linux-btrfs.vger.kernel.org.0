Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC61240C9D
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 20:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgHJSFo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 14:05:44 -0400
Received: from a4-1.smtp-out.eu-west-1.amazonses.com ([54.240.4.1]:48082 "EHLO
        a4-1.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727003AbgHJSFn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 14:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=pqvuhxtqt36lwjpmqkszlz7wxaih4qwj; d=urbackup.org; t=1597082741;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=QmXMcemf8YhAK0vEjh0nl4nZS5c7+Zed/bimef5TwJ0=;
        b=PeZ0LgojI15ojPWWXUhFgOCPOZlXFRyH0ogqowr8Za/hwGQMvT0o7IrfQXF30dZG
        NdLLe4uI3J+Y5Sos+GLHLSjdykj9i1f04c4dGDtaeTEoEPF4n3fcEvDMO9woOf/KOoM
        Wcgpe0ncVnbLe6jpDsd8muS30J27yPNrT826BBrc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1597082741;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=QmXMcemf8YhAK0vEjh0nl4nZS5c7+Zed/bimef5TwJ0=;
        b=QNMLEBKLryrNMPwhv9fHO3VCbK7CSrc4liCSlFuFA/+FWJ/6q/rRygjpI4/5q66N
        kENqkBWLv0LngfjpRGoUKBt56+uq4qu5FvmAKGtLGnzx7mAMNurSIBZnNVyEEC0QaKG
        OHNSFIt14fAO1tHm9LKcYZ8uIF8AmfosOMMU4E5E=
Subject: Re: [PATCH RFC] btrfs: change commit txn to end txn in
 subvol_setflags ioctl
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org
References: <20200804175516.2511704-1-boris@bur.io>
 <86c25213-e961-790e-dc27-8c2a9aa118c1@gmx.com>
 <5c0b0cd7-b04d-7715-8d0e-6466f7e802a5@toxicpanda.com>
 <01020173bed9de46-08b668c9-e188-412b-846c-4ed33ce2fe4f-000000@eu-west-1.amazonses.com>
 <20200807204533.GA429307@devvm842.ftw2.facebook.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <01020173d98ca8c7-69541242-38df-4d7f-adfd-d415f9b688bc-000000@eu-west-1.amazonses.com>
Date:   Mon, 10 Aug 2020 18:05:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200807204533.GA429307@devvm842.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.08.10-54.240.4.1
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07.08.2020 22:45 Boris Burkov wrote:
> On Wed, Aug 05, 2020 at 01:40:16PM +0000, Martin Raiber wrote:
>> On 05.08.2020 01:08 Josef Bacik wrote:
>>> On 8/4/20 6:48 PM, Qu Wenruo wrote:
>>>>
>>>> On 2020/8/5 上午1:55, Boris Burkov wrote:
>>>>> Currently, btrfs_ioctl_subvol_setflags forces a
>>>>> btrfs_commit_transaction
>>>>> while holding subvol_sem. As a result, we have seen workloads where
>>>>> calling `btrfs property set -ts <subvol> ro false` hangs waiting for a
>>>>> legitimately slow commit. This gets even worse if the workload tries to
>>>>> set flags on multiple subvolumes and the ioctls pile up on subvol_sem.
>>>>>
>>>>> Change the commit to a btrfs_end_transaction so that the ioctl can
>>>>> return in a timely fashion and piggy back on a later commit.
>>>>>
>>>>> Signed-off-by: Boris Burkov <boris@bur.io>
>>>>> ---
>>>>>    fs/btrfs/ioctl.c       | 2 +-
>>>>>    fs/btrfs/transaction.c | 4 ++--
>>>>>    2 files changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>>>> index bd3511c5ca81..3ae484768ce7 100644
>>>>> --- a/fs/btrfs/ioctl.c
>>>>> +++ b/fs/btrfs/ioctl.c
>>>>> @@ -1985,7 +1985,7 @@ static noinline int
>>>>> btrfs_ioctl_subvol_setflags(struct file *file,
>>>>>            goto out_reset;
>>>>>        }
>>>>>    -    ret = btrfs_commit_transaction(trans);
>>>>> +    ret = btrfs_end_transaction(trans);
>>>> This means the setflag is not committed to disk, and if a powerloss
>>>> happens before a transaction commit, then the setflag operation just get
>>>> lost.
>>>>
>>>> This means, previously if this ioctl returns, users can expect that the
>>>> flag is always set no matter what, but now there is no guarantee.
>>>>
>>>> Personally I'm not sure if we really want that operation to be committed
>>>> to disk.
>>>> Maybe that transaction commit can be initialized in user space, so for
>>>> multiple setflags, we only commit once, thus saves a lot of time.
>>>>
>>> I'm of the opinion that we shouldn't be committing the transaction
>>> for stuff like this, unless there's a really good reason to.
>>> Especially given we're holding the subvol lock here, we should
>>> just do end_transaction.  Thanks,
>>  From a user perspective I'd appreciate having the option to set it
>> in a non-durable way (I have seen btrfs property sets hanging for a
>> long time as well). But currently my application kind of depends on
>> it being durable. Making it non-durable wouldn't break much and I
>> guess the old behaviour could be emulated by a "btrfs fi sync
>> <subvol>" afterwards, but idk how much other stuff depends on it
>> being durable. Making it consistent with btrfs subvol del with the
>> "-c" switch would be nice and consistent as well (and the -c switch
>> could be done via IOC_SYNC after setting the properties).
> Martin,
>
> Thanks for your perspective, that's helpful. Could you elaborate on how
> your application relies on the durability? I would just like to learn
> more about how this might affect people.
>
> I really like the -c idea, but I fear if people are broadly depending on
> that behavior by default, it wouldn't be enough.

It is a backup software that currently works a bit like this:

1. Add database entry for new backup A with done=0
2. Create btrfs subvol A for backup
3. rsync backup source to A
4. btrfs fi sync A
5. Set subvol A to read-only
6. Set database entry for A to done=1

On startup: Delete all btrfs subvols of backups where done!=1 in the 
database.

Switching 4. and 5. should fix it if changing properties is not durable. 
Otherwise there could be subvols that don't get deleted on startup 
(after crash) and are not read-only. Those would be an annoyance e.g. if 
the backups are further replicated using btrfs end/receive, or if one 
relies on the finished backups being read-only.

Worst case there is someone that leaves 4. out and relies on 5. to sync 
to disk (would that work?).


