Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E636950CDF2
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Apr 2022 00:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbiDWWf1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Apr 2022 18:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiDWWf0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Apr 2022 18:35:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6349F1B13DC
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Apr 2022 15:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650753142;
        bh=IdQvWgWatICxv9FKqpVmKqQaOp1bLa7FaJBCjuJw2gQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ge8mbyQyj/YyDB3oPFxqdRxSVi3R2d82Chb9IdNswroN29/jwfbIyHUwD14Xin7Dk
         zpDWgZcDpkBs+GlOkzcnKUjnuKrem8OLMnH1pQ5MgIOOMEO24lBglXIIiFgYs1/bB8
         RDn7KFVF6s2nDTUv0YcVtb+xSPDTefkh2Tsor3Nc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTzf6-1nIR9Q0Hbe-00R466; Sun, 24
 Apr 2022 00:32:22 +0200
Message-ID: <5d790179-f9be-a7e2-5bfa-da6b956800f5@gmx.com>
Date:   Sun, 24 Apr 2022 06:32:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: btrfs check fail
Content-Language: en-US
To:     Jat <btrfs@jat.fastmail.com>, linux-btrfs@vger.kernel.org
References: <a41c8f80-78de-49d3-a34f-2cd4109d20a0@beta.fastmail.com>
 <fe391705-79d2-a365-27ca-fc52b260fcbf@gmx.com>
 <a03acb5f-02dc-491b-b44d-62a59246c4f7@beta.fastmail.com>
 <e6e90f1f-4e6c-496f-8f0b-69ec93a1513a@beta.fastmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <e6e90f1f-4e6c-496f-8f0b-69ec93a1513a@beta.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WhxdUCrZn04ulF1iPs/qas/zjA2VwqTC/H+J+rmU7VlnXGRZVbd
 t9A6cZa7eRhUaiLzK3Go5iql+8hf9sNVvpqUwJ6tbsVZ11B9GQbgPI0ULytLo5/ZngKd+C6
 Co8xgLtsBoWv4bVf1rTUdY4pZn5hU7aK/a3vRXC9t6WgJWRKflLIJdbA0QEiRKlFmM9FA9w
 xgFHMzw7a9297fHORssOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qCm7g9u+dJo=:E0RPKnYGSdmuQykZ6PbXPW
 gvdBOv6ZOK/YjwmMssMIxgF7NO8I0levLgDXXPBh+y0Ok8uCubNcki2PnAnqZSSk5P6RCXl9l
 zestFuFtvS/0CKAOlUXT9eqhcC9QIWI2eZ/t/46BadnUdQHtVpnasw5ASQlVVJxy9RUDDcSOC
 3ECs9xxdIiJR3MHXocB1H6LX9XnhWaVRTM1VN6Xt0j6ZPYuavy99KcO1WAwZPaAT+1tXE9jDp
 /0ZZHzxx3qePlGQ76GutBy6rpdPcZVar9IjMXFDz2Q/ueZBkOEhW/+1ln4TOTLW3p/aeKKXcJ
 lpNZZbmOBY3d4nQ1rT3ZOn0BkDdCM7E/gxaj/G/vBaanPAE5mSzdpDJgQK1yIl7MGxaP9mUI+
 zpoDHm3Xoky4NseUwoMmMMpMUdIaqQujb7L+PFOwO0HOQ9BvWW+MaWNV+ggLtwAOgu17oO1Yq
 AgzrqgE3QnxSq1buHcKe0IzGJBJaOO5rbmpEjtvCHMh5EZhEYIl41NLUUsECMRiIpJvSKPRTW
 7KdNBQAgr7FeeJvPL8XWIZ5undAimX/6vvapW0rYT3g55hBnljT8V91FVYfmfD7wBPmNHTSBg
 xjVp0vYChB8k4LeZP+I9EkOrHpNklmhlHzCznZdHIhfhmMa0pY1EXZmyPVgLSkcnQ7OXc4QJw
 xzSsyptJMEzBMm8EvZwwimO6sOOKWGE5HZilFGGt41DGslJVfJhNTWQ+Gv0kryfc+/loVMCAl
 m7ILrmavNvZRhGkSiIMiVj79Vree3mTORBz84gDqHBIu9Ndhef/nNUNMfK/cBeNU6DFizGedE
 8YLKGxlUDT9TxSDsO3MjYL35/tiCQYacQkoUhBj3DdZfKD6Ivavd6FkpDUJQGNilS9UkaVJNL
 tf9AHBDUxDp7YCSfpTg/h7SC5slAP108ct/v5YZWL7UdnAWoV8kG6reGHG+/gaEQpJbvE9sXN
 3WRr4NBp216BVehAP5tUFFPQit9cBP/68ZePK8C83Ohz9rThtVF1NK1QrTJeLDWEam/TTHR5A
 dGHFBNVr3ZFUh2IoMkdLKjMqEvjPCob3iqwtWfygd2ZpKhi0AWyThfB8c6cK98lTPCFxl/LXa
 E3PdeQOHo7nybI=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/24 06:25, Jat wrote:
> Okay, I got it resolved, btrfs check passed and partition moved & resize=
d successfully.
> Solution was to move the files to a different filesystem and back.

That's one solution that will always work.

The other way is to use "cp --reflink=3Dnever".
My bad, I forgot cp will try to use reflink to skip IO, thus in btrfs it
will not really do the proper IO.

Thanks,
Qu
>
> Thanks again!
> Jat
>
> ----- Original message -----
> From: Jat <btrfs@jat.fastmail.com>
> To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
> Subject: Re: btrfs check fail
> Date: Saturday, April 23, 2022 10:40 AM
>
> Thanks very much, Qu!
> I attempted your advise, but was only partially successful.
>
>> Recommended to go v2 cache.
> Done, no problem.
>
>> just go copy the files to other locations and remove the old file
> This is where I had trouble.
> I tried on just one file to start:
> /mnt/@_190127freshinstall/var/log/journal/b0eb202aa367415fb973e99ecd5488=
9e/user-1000.journal
>
> I made a copy, deleted the original, and then renamed back to original:
> cp user-1000.journal user-1000.journal.temp2
> rm user-1000.journal
> mv user-1000.journal.temp2 user-1000.journal
>
> But afterward I got the same error, just different inode:
> Pre: root 267 inode 249749 errors 1040, bad file extent, some csum missi=
ng
> Post: root 267 inode 249772 errors 1040, bad file extent, some csum miss=
ing
>
> What have I done wrong?
>
> Thanks again for your help!
>
> Regards,
> Jat
>
>
> ----- Original message -----
> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
> To: Jat <btrfs@jat.fastmail.com>, linux-btrfs@vger.kernel.org
> Subject: Re: btrfs check fail
> Date: Friday, April 22, 2022 9:53 PM
>
>
>
> On 2022/4/23 11:56, Jat wrote:
>> Hello,
>> I am trying to resize a partition offline, but it fails the check.
>> The output of running btrfs check manually is below, can you please adv=
ise me how to resolve the issues?
>>
>> Here is the output from btrfs check:
>> sudo btrfs check /dev/sda7
>> Opening filesystem to check...
>> Checking filesystem on /dev/sda7
>> UUID: 4599055f-785a-4843-9f59-5b04e84fea1a
>> [1/7] checking root items
>> [2/7] checking extents
>> [3/7] checking free space cache
>> cache and super generation don't match, space cache will be invalidated
>
> Recommended to go v2 cache.
>
> You can just mount it with space_cache=3Dv2.
>
>> [4/7] checking fs roots
>> root 267 inode 249749 errors 1040, bad file extent, some csum missing
>> root 268 inode 466 errors 1040, bad file extent, some csum missing
>> root 308 inode 249749 errors 1040, bad file extent, some csum missing
>> root 313 inode 466 errors 1040, bad file extent, some csum missing
>
> Please run "btrfs check --mode=3Dlowmem" to provide a more readable outp=
ut.
>
> There are several different reasons to cause the "bad file extent".
>
>   From inline extents for non-zero offset, to compressed file extents fo=
r
> NODATASUM inodes.
>
> The later case can explain all your problems in one go, and can be
> caused by older kernels.
>
> If that's the case, you can just go copy the files to other locations
> and remove the old file, and call it a day.
>
> Thanks,
> Qu
>
>> ERROR: errors found in fs roots
>> found 103264391173 bytes used, error(s) found
>> total csum bytes: 93365076
>> total tree bytes: 2113994752
>> total fs tree bytes: 1825112064
>> total extent tree bytes: 144097280
>> btree space waste bytes: 432782214
>> file data blocks allocated: 352758886400
>>    referenced 178094907392
>>
>>
>> Here is the requested info from Live boot environment for offline parti=
tion sizing & btrfs check...
>> uname -a
>> Linux manjaro 5.15.32-1-MANJARO #1 SMP PREEMPT Mon Mar 28 09:16:36 UTC =
2022 x86_64 GNU/Linux
>>
>> dmesg > dmesg.log
>> [Sorry, didn't capture this after running the check in live boot enviro=
nment. Will capture as needed next time along with recommendation]
>>
>>
>> Here is the requested info from within mounted environment...
>> uname -a
>> Linux manjaro-desktop 5.17.1-3-MANJARO #1 SMP PREEMPT Thu Mar 31 12:27:=
24 UTC 2022 x86_64 GNU/Linux
>>
>> btrfs --version
>> btrfs-progs v5.16.2
>>
>> sudo btrfs fi show
>> Label: 'manjaro-kde'  uuid: 4599055f-785a-4843-9f59-5b04e84fea1a
>>           Total devices 1 FS bytes used 96.19GiB
>>           devid    1 size 226.34GiB used 226.34GiB path /dev/sda7
>>
>> btrfs fi df /
>> Data, single: total=3D220.33GiB, used=3D94.92GiB
>> System, single: total=3D4.00MiB, used=3D48.00KiB
>> Metadata, single: total=3D6.01GiB, used=3D1.97GiB
>> GlobalReserve, single: total=3D275.20MiB, used=3D0.00B
>>
>>
>> Thank you,
>> Jat
