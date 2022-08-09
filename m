Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EFC58D847
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 13:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242306AbiHILhU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Aug 2022 07:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242155AbiHILhK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Aug 2022 07:37:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CE1C59
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 04:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660045026;
        bh=3It5Znc0VnX+n5vkbqDYnK8e/zY7pGCb7+g73iibKyg=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=WZ5poUnYreGBICOvg6BCboz3pDbaZ6vnbNSxbaZ74zddwjD21FUccpnzC8YcJDbl6
         bqyn6rMo26AW5BdS1SKingmyWVQERagnVMpOQvhFBWI8QxPR7VGsK3WYYUVNxspRqY
         S00svfs3eiJW1St7FMdSLMne+dkjYA8D+CpbewjQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQe5k-1nzs7Y0NnS-00Ngfi; Tue, 09
 Aug 2022 13:37:06 +0200
Message-ID: <6c15d5db-4e87-dd49-d42a-2fcf08157b25@gmx.com>
Date:   Tue, 9 Aug 2022 19:37:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com
References: <12ad8fa0-a4f6-815d-dcab-1b6efa1c9da8@bluemole.com>
 <ebc960af-2511-457e-88ef-d1ee2d995c7d@www.fastmail.com>
 <60689fac-9a38-9045-262c-7f147d71a3d2@bluemole.com>
 <b817538a-687e-0fee-fa05-a1b0cfe956f3@suse.com>
 <83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Corrupted btrfs (LUKS), seeking advice
In-Reply-To: <83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8AX+sotcB4o3bW7amKDVxBRYnkhYoT8aLK3xQIkp2EpW/SinN20
 /XrmKRe/t/fueFUHMtF57DPSwt38utejJznOLHYymYxgrR7OMXfhY/omoVxAoNI2Deb0Bi5
 bXe7/DhYdy9lY7yftm+2F2qjMfJCqjUROHmbgqeYlFXIjk/PqZQ6+lkJjvoetusrT8q4P4X
 4fqfGI46P27OlzChkXCUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9OsDCTVYa2c=:Uatgc5zP38tHUkrqkYLOg2
 BPhyw65kiDh55VhFQL4Zfgl2zKf/7ChgvbK8nCs4zW/ctMAMUljGp0zxaAd8snFTSLUYX07QP
 XJ4ed8/piQ9zd1oGQPKc6yInewbn1rKKiYw9w1JvG7z5byjvGJxAUlhPhuI6oAkH5Pm3wLsPx
 /gtdhZekilurBzr0h9v9u7ZwQz75r6ztFVCWrVl8U2OUnpMItAE80aC4N18OICK6c7k53kQ4w
 yHhDPsmeMaGvB6JxLMwmbaOCSaWN59oeyU5k4kwooV+dyImdX24/Lw/IUbOgki42+MbwpfIBD
 877vaCIjjOHjfVaL8euhGIZzi2xjxaPHM5aRKWv9dLN296eds3KNvTylc1gy5O/qPUU7bves6
 7yY6PJcMeDnAUDBcnc71ukQs90FzgWWNP27KRIrkw7O/Y6DZcnR8hTQuO4SQealKjBIvYQ2tW
 PquYM6sMxY+OqJQuGTaFHQBqsbnEgGwlP2VBE4SGmgeM0gSGKaSj0OT10F9PoH9fnOgMHemc1
 XA+yNwc3m71MX+Hvn2zYcaZ3KN0Nh+1sz3r8iu7AdSdQzlsQvshA260actsWPo4/r16RjK+ce
 FYzMNsbozodFVgHKj6LZ3KOp7KGDj26HSJ7PyvZyqCpgkojonnKzU9gyEnOSkJTpLODnxqnxX
 drIxXYU6mt4j4YTW9upQdz99apuIPNcWjsIHaCVxu/9sZpmKVtyTEphaSmvK69x8KUJhi+ZVc
 vSJnUj78n9Zo5ULuh1i6KZnnPR6J0nFFtNzT9yiItdwFIq2YL2pMcGqbObGVWE6HO02GnugJs
 JP2uJkvTDvQRQpyX2T3i4IEucek2SIVH1fkZGN40M+jVMrCU/eCb1xTwJCgc4VY+nS/YkaC9a
 iBN8ZRvPe8aX5/KftjnZOgkRwRhCsJtzB9lesfMLHfjCbLk5Ido8BuFoih6E23odj1DkqemBu
 9TzbiOQ5DHruih7NjHrEL4dV8RYCNnqzCC0t7PcWECGCZid9FFKCUUfV7MKPWQQfsDQeA2Cgs
 H24ZAgWBdbs2duRCtxf5eGes/6pb9UToFBdbjUjdMgT33vK3PTnv9n+qSEyfdi0WUYv1YPyD3
 sIsUC352bGC26UcFb+8Pes//J3x2miAwDTJrH4h2JpcQBOyvQpAkFtntw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/9 19:23, Michael Zacherl wrote:
> On 8/9/22 01:22, Qu Wenruo wrote:
>> You can try "mount -o ro,rescue=3Dall", which will skip the block group
>> item search, but still there will be other corruptions.
>>
>> I'm more interested in how this happened.
>> The main point here is, the found transid is newer than the on-disk
>> transid, which means metadata COW is not working at all.
>>
>> Are you using unsafe mount options like disabling barriers?
>
> No, this upgraded setup is fairly new and completely stock.
> (and most of that terminology I have to look up anyway)
> Btrfs is new to me and I don't experiment on systems I need for work.
>
> I think what happened is having had mounted the FS twice by accident:
> The former system (Mint 19.3/ext4) has been cloned to a USB-stick which
> I can boot from.
> In one such session I mounted the new btrfs nvme on the old system for
> some data exchange.
> I put the old system to hibernation but forgot to unmount the nvme prior
> to that. :(

Hibernation, I'm not sure about the details, but it looks like there
were some corruption reports related to that.

>
> So when booting up the new system from the nvme it was like having had a
> hard shutdown.

A hard shutdown to btrfs itself should not cause anything wrong, that's
ensured by its mandatory metadata COW.

> So that in itself wouldn't be the problem, I'd think.
> But the other day I again booted from the old system from its
> hibernation with the forgotten nvme mounted.

Oh I got it now, it's not after the hibernation immediately, but the
resume from hibernation, and then some write into the already
out-of-sync fs caused the problem.

> And that was the killer, I'd say, since a lot of metadata has changed on
> that btrfs meanwhile.

Yes, I believe that's the case.

>
> On top of it, btrfs is v4.15.1 on the old system, many things just don't
> exits on this version, AFAICT.
> If that made things worse, I can't say.
>
> On 8/9/22 01:24, Qu Wenruo wrote:
>> Try this mount option "-o ro,rescue=3Dall,rescue=3Dnologreplay".
>
> Oh, I thought "nologgreplay" would be included in "all"?

I checked the code, and the latest code is indeed including that.

But that's weird, if included we should not try to replay the log, thus
that "start tree-log replay" should not occur.

Anyway if rescue=3Dall doesn't work, you may try "btrfs rescue zero-log"
to manually delete that dirty log and then RO mount should still be
possible.

>
>>> Is this FS repairable to a usable state?
>>
>> Definitely no.
>
> Ouch. But meanwhile I can see the damage I did to it.
> I'm currently abroad, so no access to my regular backup infrastructure.
>
> However, since I've to re-install the new system when I'm back:
> There would be enough space on the new ssd for a second partition, which
> I'd like not to go for.
> Or is there an option for additional redundancy within the same btrfs to
> help in case of such a bad mistake (I'd dearly try to avoid anyway, but
> ...)?

I'm not sure if there is anyway to prevent such out-of-sync RW mount
from corrupting the fs.

We can go RAID1 (if you have multiple disks) or DUP (single device,
double copy), but none of them can handle the case you hit.

Personally speaking, I never trust hibernation/suspension, although due
to other ACPI related reasons.
Now I won't even touch hibernation/suspension at all, just to avoid any
removable storage corruption.

Thanks,
Qu

>
> Thanks a lot for your time, Michael.
>
>
