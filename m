Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441382A9465
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 11:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgKFKcS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 05:32:18 -0500
Received: from smtp.radex.nl ([178.250.146.7]:59236 "EHLO radex-web.radex.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbgKFKcR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 05:32:17 -0500
Received: from [192.168.1.158] (cust-178-250-146-69.breedbanddelft.nl [178.250.146.69])
        by radex-web.radex.nl (Postfix) with ESMTPS id E149D2406A;
        Fri,  6 Nov 2020 11:32:14 +0100 (CET)
Subject: Re: Fwd: Read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <5346c4af-c73e-84b3-ec4f-8f169c0a732a@gmx.com>
 <CAJheHN0NmgVoGF+AsnUNQkQnEJ46JCmpg4o5nwAkqi+VoGMjfw@mail.gmail.com>
 <e04680b4-f4c0-254f-24ba-f2053e4ad8b3@gmx.com>
 <CAJheHN0THhKcqKY3cGtJqUGaub=E0tuCmi6wuNeCGBxyAHmecQ@mail.gmail.com>
 <e2c8eaaf-6adb-374f-4005-a1edcbcb8f79@gmx.com>
 <CAJheHN1U4j1KsD96oFuCVwP+6RVP6V6oAZP-aGOTtfm7tDL3BA@mail.gmail.com>
 <CAJheHN3pTj-6dOQZVKqA_r38F+WVNrjVO6-Z_hFeq96uTNK5zw@mail.gmail.com>
 <1f26ff53-f7c7-c497-b69f-8a3e5d8ce959@gmx.com>
 <b7383762-4a86-fdb9-12f3-89470808f4e6@gmail.com>
 <0d6a0602-897a-b170-f1a2-007cff1f23fb@gmx.com>
 <134e61b5-ecf7-bc1a-e16b-c95b14876e6e@gmail.com>
 <5b757c2b-6dbf-cbec-6c66-e4b14897f53c@gmx.com>
 <838490cf-fc40-0008-88bb-eeede1e8d873@gmail.com>
 <50e0ef4d-061e-d02d-9dbf-61f83dfa7b3e@suse.com>
 <117797ff-c28b-c755-da17-fb7ce3169f0f@gmail.com>
 <51578ec7-f2e5-a09a-520e-f0577300d5ce@gmx.com>
 <d8d1f615-bc9f-90c2-d851-9497348af284@gmx.com>
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <20a1d23a-11ab-a21f-351b-611e544f6a88@gmail.com>
Date:   Fri, 6 Nov 2020 11:32:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <d8d1f615-bc9f-90c2-d851-9497348af284@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Op 06-11-2020 om 11:27 schreef Qu Wenruo:
>>> BTRFS critical (device sda2): corrupt leaf: root=294 block=1169152675840
>>> slot=1 ino=915987, invalid inode generation: has 18446744073709551492
>>> expect [0, 5852829]
>>> BTRFS error (device sda2): block=1169152675840 read time tree block
>>> corruption detected
>>>
>>> So how do I repair this? Am I doing something wrong?
>> Please provide the following dump:
>> btrfs ins dump-tree -b 1169152675840 /dev/sda2
>>
>> Feel free to remove the filenames in the dump.
>>
>> And 'btrfs check /dev/sda2' output after the repair.
>>
>> As a workaround, you can use older kernel (v5.2 at most) to temporary
>> ignore the problem.
>>
>> Thanks,
>> Qu
>>
>>>>>> THanks,
>>>>>> Qu
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>
>>>>>>>>> Linux = 5.6.0-1032-oem
> Wait, it's just v5.6??

I did repair with Kubuntu groovy live usb.

That has 5.8 kernel + 5.7 btrfs-progs.

> Then that means, the error message can be wrong. Both transid and inode
> generation error could be output as "inode generation error".
>
> And to repair inode transid, the repair ability is not yet merged into
> upstream btrfs-progs.
>
> You can use the out-of-tree branch to repair it:
> https://github.com/adam900710/btrfs-progs/tree/inode_transid
>
> I'm afraid you have to build the btrfs-progs in liveUSB environment to
> repair it...
>
> I need to re-push the branch to make it into upstream.
>
> Thanks,
> Qu
>
