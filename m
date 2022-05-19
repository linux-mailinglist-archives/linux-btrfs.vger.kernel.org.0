Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12C352D1C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 13:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiESLuc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 07:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiESLub (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 07:50:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F062B82C9
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 04:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652961027;
        bh=3pwnfxzKRSDqpJuJXJVEWoYwycBlXq4o94AbW5LHoLM=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=NwGJHaURykl1U+OkZs/yDfS1OFBoQEv0vT18LJk6DiXSw7z2rXygAhBN/VfzNnYzw
         kX8SDk3iiIwUS7yAvZGfLEvHNzqrlcKZ/p/K2qWbQYQF1xSdRAVUlMQI7Gt6FUvRkJ
         mrzL1+Nmnmrf2y7irxUqxaz+JnyLo4yQrCOaYGTk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MK3W0-1o9rFU495K-00LUfA; Thu, 19
 May 2022 13:50:27 +0200
Message-ID: <1ab9f2f0-f22c-f768-bcf4-5c48e8aa651a@gmx.com>
Date:   Thu, 19 May 2022 19:50:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: can't boot into filesystem
Content-Language: en-US
To:     arnaud gaboury <arnaud.gaboury@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAK1hC9sdifM=m3iH7YVh6Cd1ZKHaW69B+6Hz9=aO_r1fh3D7Tg@mail.gmail.com>
 <5679bb8d-d0af-187b-1bd0-fd8ccc85a867@gmx.com>
 <8da3130c-94a7-3af2-1ad4-1ffa9bae6518@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <8da3130c-94a7-3af2-1ad4-1ffa9bae6518@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kngOEoglw5JVYpmUwMzA8y1rGCquHTFY7ADe9iVug6Pu1/qhg/8
 KJH3s44M+M5ODCAlPnbsrfJ5Nsn8BNfVrxWfOz2bTkn89ZtPSBEewAQVcQSSWHJKZ/gZaei
 MXOIljXVMe5cZW/dgrClBGmS1RW73f5O5RoqHbrLiZEVIUvZAQ8TmSnExsa5y4ZeRhCQWcN
 d4Y5iQVGfJVfiYJ7LHoYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YJRpaCkgI7I=:AyhssgjqrHbvttmVfvisTa
 sNnYPqmS/MIrGUon8VC5EutOkdsCiiuNyDdLcBZHLspKBXvam+gNIWpelsChVeRm9CoNSIwDI
 8ZnSC1fY2ba2YmD08OCJNjmlvIgqupkahFcr58pWAIASbHcP8zIJaQf8nEP8x0fR/vh+nPwKt
 x/coXFXqXK2Ob2nWGVcgNufhTw1Z1bw2qChV8P+QkDx+5KUn7Us5fZowu22ISuuZXr2gn4v7E
 3ISNT/3sO3IO65HYdoFWprlzsK/PKK3H95gf5KikKg+XW4civFZkRbXtAqjcX6bl41Xxp27y6
 3JOSRE55EYoVVdQYYGEl4NeLjXxDSNt1wV6zCyvRebjSOUUiP2/tCbmOL4leUVdbgRqA7KtT0
 fE+odpPBOCKK3jPk16Ts5horxhEkciPie0ahgXV0k+PVHaP2tVSmuZxcnAUSqdz101+/ZuSMv
 lwWnnFpM6zPqX4xX5tqQkUh399d5/iBIpZ/yT3kgWK7OCacvL8xwhn0ghveubVKjuuHqCAhK3
 kcbV1wP3cHZrS96SQXCsRxhp3dQZZ1l64RqDlLQcqvKlIWIf4YqZlDPvTGCwtlFM5OKgOVQ5B
 xlrEsen62kezIvcV1+nEqnnkWV3WO8y/HzkoPzS1QgCZCW4PRkTuHHLd5ITuuHFUTN+52exV1
 qT1eF7kqz3zQc3Od778mo27fg8IZd5McZXrjYLLL7HHFf6lB7N+LId+SXkLZK0Yfoe1NAt3ea
 BmjCyJZiY00SlIWpY3b5pXmrbtcgXtxt6XbBDWy0G1PUrfSmC5DST08S3V8URlExVZPrEboeA
 d1hmJVI6CDIvYmtBU+xGqe/lNJKT4AcBoNE9KKLDN1LNzOB9F/k1tWPF+rOqjmu1oWp4LEVky
 JqgaUNTGEm9CoC9bEpPlZCgAjU7WZvhweaKjI0B4W9BlnaP7p7ckLwZaCko0LeTf/Q3cp494j
 NBdbM+9bs787J+z//9Tf/7M/FW+tm89bvWjBPBZpSb8EpzNPR3ev/5ODKKo/8Udy3U5W9G0Ui
 Mm29Q5zhz/ESoX6QoqtIfkrZFflAudpntMTdRptfR/zSziCavUCdMtZ8iQUHSepQSoiK3yzR5
 1oYCWuJDp0SGw0TAFumUYooTzyvCswxzj9BhVjuPmVQOfwWeCKBOQ+X7w==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/19 19:44, arnaud gaboury wrote:
>
> On 5/19/22 13:36, Qu Wenruo wrote:
>>
>>
>> On 2022/5/19 17:58, arnaud gaboury wrote:
>>> My OS has been freshly installed on a btrfs filesystem. I am quite new
>>> to btrfs, especially when mounting specific partitions. After a change
>>> in my fstab, I couldn't boot into the filesystem. Booting from a
>>> rescue CD, I changed the fstab back to its original. Unfortunately I
>>> still can't boot.
>>> Here is part of the error message I have:
>>> devid 2 uuid XXYYY is missing
>>> failed to read chunk tree: -2
>>
>> This is the reason, your fs is across multiple-device (like using RAID1
>> profiles).
>>
>> And on boot, you initramfs doesn't call 'btrfs dev scan' to let btrfs
>> scan all devices and assemble the full device list.
>>
>> Thus it can only detect one disk of your multi-device btrfs, and failed
>> to mount.
>>
>> That's why your rescue CD can mount the fs.
>>
>> You may want to check the manual of distro to make sure the initramfs i=
s
>> doing proper preparation work for btrfs (mostly just scan the devices).
>>
>> For example of Archlinux:
>>
>> https://wiki.archlinux.org/title/mkinitcpio
>
>
> I am effectively on arch linux and the btrfs hook is on my
> mkinitcpio.conf file.
>
> Now is there any solution to mount and add to my filesystem the external
> device?

External device you mean? Then I guess it's the problem of the drivers.

Your initramfs may only have the driver for the internal devices,
without the proper driver for your external devices.

Thus it's not missing "btrfs dev scan", but really at initramfs it
doesn't see the external one at all.

You need to add all the drivers if mkinitcpio doesn't properly detect
all the drivers needed.

Thanks,
Qu
>
>> You need "btrfs" hook, which is doing exactly I mentioned, run "btrfs
>> dev scan".
>>
>> Thanks,
>> Qu
>>>
>>> part of my fstab:
>>> LABEL=3Dmagnolia=C2=A0=C2=A0 / btrfs=C2=A0 rw,noatime.....,subvol=3D@
>>> LABEL=3Dmagnolia=C2=A0 /btrbk_pool=C2=A0 btrfs=C2=A0 noatime,....,subv=
olid=3D5
>>> LABEL=3Dmagnolia=C2=A0=C2=A0 /home=C2=A0=C2=A0 btrfs .....,subvol=3D/@=
home
>>> ......
>>>
>>>
>>>
>>> I am now back to rescue CD. I can mount my filesystem with no error:
>>> # mount -t btrfs /dev/sdb2 /mnt
>>> # ls -al /mnt/
>>> @
>>> btrbk_snapshots
>>> @home
>>> home
>>>
>>> I can see my filesystem when I ls the @ directory.
>>> What can I do to boot my filesystem which is perfectly reproduced in
>>> the @ subvolume? Shall I simply cp the whole filesystem stored in @ to
>>> the root of /mnt=C2=A0 when my device sdb2 is mounted?
>>> Sorry for the lack of formatting and info, but I can't use the browser
>>> from the rescue CD so I am writing from another computer.
