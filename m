Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D9C23CDCC
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Aug 2020 19:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgHERx1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Aug 2020 13:53:27 -0400
Received: from a4-1.smtp-out.eu-west-1.amazonses.com ([54.240.4.1]:35886 "EHLO
        a4-1.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729039AbgHERwL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Aug 2020 13:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=pqvuhxtqt36lwjpmqkszlz7wxaih4qwj; d=urbackup.org; t=1596634816;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=B9kYu9u00ftqYM4m+qc3bqWPk485mxkFgh7hdAPKSXY=;
        b=A3GjRYvbvSWwAdjq3CR3FN/LViG9+0xP1w8lcpgKf65t/nILe90/64n+KjKBIiFt
        PhbZXETKGR8Jg3gY2SBUCWGcB76ANS/kGR5z1Pr4g2lv69qWEVP2kJiThcns9AUn/1i
        wktBVd4q7x08NJr09YS6l5+UpySa7M83nGLKIu10=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1596634816;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=B9kYu9u00ftqYM4m+qc3bqWPk485mxkFgh7hdAPKSXY=;
        b=BDrAJyEgoPSC1L6/fVjLZDDeMRczGc62R65PCmRNciof+ea6nY/49IlO3yBoGULL
        jQY+2kuGkWqvhkVkUNbri7Am57H7y6Bh00Xf4H8gxyU3FILRRFDBkoj5+ikeexw+71V
        ZLBbyrVxxEJvSBDrllvIu6BtO4d+Pnwb7IkCq5G4=
Subject: Re: [PATCH RFC] btrfs: change commit txn to end txn in
 subvol_setflags ioctl
To:     Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Boris Burkov <boris@bur.io>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200804175516.2511704-1-boris@bur.io>
 <86c25213-e961-790e-dc27-8c2a9aa118c1@gmx.com>
 <5c0b0cd7-b04d-7715-8d0e-6466f7e802a5@toxicpanda.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <01020173bed9de46-08b668c9-e188-412b-846c-4ed33ce2fe4f-000000@eu-west-1.amazonses.com>
Date:   Wed, 5 Aug 2020 13:40:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5c0b0cd7-b04d-7715-8d0e-6466f7e802a5@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.08.05-54.240.4.1
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05.08.2020 01:08 Josef Bacik wrote:
> On 8/4/20 6:48 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/8/5 上午1:55, Boris Burkov wrote:
>>> Currently, btrfs_ioctl_subvol_setflags forces a 
>>> btrfs_commit_transaction
>>> while holding subvol_sem. As a result, we have seen workloads where
>>> calling `btrfs property set -ts <subvol> ro false` hangs waiting for a
>>> legitimately slow commit. This gets even worse if the workload tries to
>>> set flags on multiple subvolumes and the ioctls pile up on subvol_sem.
>>>
>>> Change the commit to a btrfs_end_transaction so that the ioctl can
>>> return in a timely fashion and piggy back on a later commit.
>>>
>>> Signed-off-by: Boris Burkov <boris@bur.io>
>>> ---
>>>   fs/btrfs/ioctl.c       | 2 +-
>>>   fs/btrfs/transaction.c | 4 ++--
>>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>> index bd3511c5ca81..3ae484768ce7 100644
>>> --- a/fs/btrfs/ioctl.c
>>> +++ b/fs/btrfs/ioctl.c
>>> @@ -1985,7 +1985,7 @@ static noinline int 
>>> btrfs_ioctl_subvol_setflags(struct file *file,
>>>           goto out_reset;
>>>       }
>>>   -    ret = btrfs_commit_transaction(trans);
>>> +    ret = btrfs_end_transaction(trans);
>>
>> This means the setflag is not committed to disk, and if a powerloss
>> happens before a transaction commit, then the setflag operation just get
>> lost.
>>
>> This means, previously if this ioctl returns, users can expect that the
>> flag is always set no matter what, but now there is no guarantee.
>>
>> Personally I'm not sure if we really want that operation to be committed
>> to disk.
>> Maybe that transaction commit can be initialized in user space, so for
>> multiple setflags, we only commit once, thus saves a lot of time.
>>
>
> I'm of the opinion that we shouldn't be committing the transaction for 
> stuff like this, unless there's a really good reason to. Especially 
> given we're holding the subvol lock here, we should just do 
> end_transaction.  Thanks,
 From a user perspective I'd appreciate having the option to set it in a 
non-durable way (I have seen btrfs property sets hanging for a long time 
as well). But currently my application kind of depends on it being 
durable. Making it non-durable wouldn't break much and I guess the old 
behaviour could be emulated by a "btrfs fi sync <subvol>" afterwards, 
but idk how much other stuff depends on it being durable. Making it 
consistent with btrfs subvol del with the "-c" switch would be nice and 
consistent as well (and the -c switch could be done via IOC_SYNC after 
setting the properties).
