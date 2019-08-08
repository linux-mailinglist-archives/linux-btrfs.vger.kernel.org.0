Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B54D85F10
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2019 11:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbfHHJz3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 8 Aug 2019 05:55:29 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51293 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbfHHJz2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Aug 2019 05:55:28 -0400
X-Originating-IP: 37.165.145.3
Received: from [10.137.0.38] (unknown [37.165.145.3])
        (Authenticated sender: swami@petaramesh.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 3363D20002;
        Thu,  8 Aug 2019 09:55:23 +0000 (UTC)
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>
Cc:     Lionel Bouton <lionel-subscription@bouton.name>,
        linux-btrfs@vger.kernel.org
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <f8b08aec-2c43-9545-906e-7e41953d9ed4@bouton.name>
 <02f206eb-0c36-6ba7-94ce-f50fa3061271@bouton.name>
 <6fb5af6c-d7b8-951b-f213-e2b9b536ae6a@petaramesh.org>
 <d8c571e4-718e-1241-66ab-176d091d6b48@bouton.name>
 <f8dfd578-95ac-1711-e382-7304bf800fb2@petaramesh.org>
 <c4885e92-937c-8fc7-625a-3bfc372e3bf5@oracle.com>
 <0bba3536-391b-42ea-1030-bd4598f39140@petaramesh.org>
 <a199a382-3ea4-e061-e5fc-dc8c2cc66e73@gmx.com>
 <e73421f5-444b-2daa-4c28-45f3b5db007c@petaramesh.org>
 <e952ed13-07d4-426e-e872-60d8b4506619@gmx.com>
 <BD134906-E79B-49D4-80C4-954D574CCC68@oracle.com>
 <54d0f80f-a7b8-8b10-f142-c9b60c9f0d7c@petaramesh.org>
 <69c47874-6608-2509-c059-659c4a1b6782@gmx.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Openpgp: preference=signencrypt
Autocrypt: addr=swami@petaramesh.org; keydata=
 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
 BtUAN08OPA==
Message-ID: <22973d72-5709-c705-1c8d-1b438df1cc49@petaramesh.org>
Date:   Thu, 8 Aug 2019 11:55:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <69c47874-6608-2509-c059-659c4a1b6782@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: fr-FR
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

On 8/8/19 10:46 AM, Qu Wenruo wrote:
> Follow up questions about the corruption.
>
> Is there enough free space (not only unallocated, but allocated bg) for
> metadata?
>
> As further digging into the case, it looks like btrfs is even harder to
> get corrupted for tree blocks.
>
> If we have enough metadata free space, we will try to allocate tree
> blocks at bytenr sequence, without reusing old bytenr until there is not
> enough space or hit the end of the block group.
>
> This means, even we have something wrong implementing barrier, we still
> won't write new data to old tree blocks (even several trans ago).


It's kind of hard for me to say if the 2 filesystems that got corrupt
lacked allocated metadata space at any time, and now both filesystems
have been reformatted, so I cannot tell.

What I can be 100% sure is that I never got any “No space left on
device” ENOSPC on any of them.

*BUT* the SSD on which the machine runs may have run close to full as I
had copied a bunch of ISOs on it shortly before upgrading packages - and
kernel.

However the upgrade went seemingly good and I didn't see no ENOSPC at
any time.


On the external HD that went corrupt as well, I'm pretty sure it
happened as follows :

- I started a full backup onto it in an emergency ;

- I asked myself « Will I have enough space » and checked with “df”.

- There were still several dozens of GBs free but not enough for a full
system backup. I cannot tell if these had been allocated or not in the past.

- Noticing that I would miss HD space (but far before it actually
happened) I deleted a high number of snapshots from the HD.

- I thus assume that the deletion of snapshots would have freed a good
amount of data AND metadata space.

So the situation of the external HD was that a full backup was in
progress and a vast number of snapshots have been deleted meanwhile.

After that the FS got corrupt at some point.


For the internal SSD, it looks like the kernel upgrade went good and the
machine rebooted OK, then midnight came and with it probably the cron
task that performs “snapper” timeline snapshots deletion.


Then the machine was turned off and rebooted next day, and by that time
the FS was corrupt.


So I strongly suspect the issue has something to do with snapshots
deletion, but I cannot tell more.


It may be worth noticing that the machine has been running a lot since I
reverted back to kernel 5.1 and reformatted the filesystems, and that no
corruption has occurred since, even though I performed quite a lot of
backups on the external HD after it has been reformatted.

Everything is in the exact same setup as before, except for the kernel.

So I would definitely exclude an hardware problem on the machine : it's
now running fine as it ever did.

I plan to retry upgrading to Arch kernel 5.2 in the coming weeks after
having performed a full disk binary clone in case it happens again.

(However I've seen that Arch has released 3-4 kernel 5.2 package updates
since, so it won't be the exact same kernel by the time I test again).

I will be on vacation until August, 20, so I cannot perform this test
before I'm back.

But I'll be glad to help if I can and thank you very much for your help
with this issue.

Best regards.

ॐ

-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E


