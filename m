Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE4850CE03
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Apr 2022 01:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiDWXKF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Apr 2022 19:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiDWXKF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Apr 2022 19:10:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F185E1C94F4
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Apr 2022 16:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650755223;
        bh=BORKhmU+3bTZSA67mMEmhbSctPXP6VsICdjaJ4fqWLw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=gN7qMxUxWLzWgO0VDY3HIN6UL9vADBGE8Cb23uq3JGpO882wqNLc7LMdNqOy44vcA
         v1q4hvvWQ3d9TvTgF8lqVHea1NJ6GD9lowIwIqB9IP0Dzse29+h6NQZuooMhwPgAb4
         jaOmT1GsuuEbLJQl642gVeQ7h5iLJh/cpCCHIkwA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6UZl-1npIj93Ve5-006t4B; Sun, 24
 Apr 2022 01:07:03 +0200
Message-ID: <21dd5ba9-8dc0-7792-d5f4-4cd1ea91d75e@gmx.com>
Date:   Sun, 24 Apr 2022 07:07:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: 'btrfs rescue' command (recommended by btrfs check) fails on old
 BTRFS RAID1 on (currently) openSUSE Leap 15.3
Content-Language: en-US
To:     Johannes Kastl <kastl@b1-systems.de>, linux-btrfs@vger.kernel.org
References: <17981e45-a182-60ce-5a02-31616609410a@b1-systems.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <17981e45-a182-60ce-5a02-31616609410a@b1-systems.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uTGQEJihG9hHmJxQ/IfBD9fQcotSt6vJR0Szcn0/qPxS2jwTXwo
 ymfiDpwBuaX4NRd09kv3hmb0EF2KzgBeOQbDNwJHy6DeOjO5m9fS7yZPw1X9Av4MK7mY2zs
 OIUUsHu9iDXs41lbqevvJSplPiAOk3rtWrD8oaa7ltmaIXpUFU6oxwfqmFmqOZvRVHTvGl5
 dAkFdtKn1XyzUyagqMlyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6DRiXf+jBT8=:/jMMrzEqHtCU5n2+4BQI+Q
 lBXaHTBnFT90A8bPm/1U2w3VJdZb4tBSHD2QLeGWjOiIr9EdmK9qbzY/kxFiBDDckK3RsGCTb
 8Jz1ddf5PzCf57cSinhLm1ikLS/42iADCd+wz8eJ1xVM8ojwtaPaPxqyGVFGJPOwCr61sFzir
 Wijk/+/poEleCzIDN/5mA9MD3PMcqskpAf+ae65+orNtHTUVHEThrCfKhOZGY1CqQFVQ6syQo
 EflLCsStpikhxvedG7JyUxrVsb6v71VYA3VKpq4lRDeteTHR+fg5LZwTRuKEBWxRWO8VLAxk2
 KN6Nx0+i0vl/AHB9bDhjbZ/LVcrZ0b3JmvBAITnloQtDsob2W3uFhvTU6dTaFYiRfQht3Vb5F
 zmK3Vw9H6OB7+FLRPD2MzfoHx0LA6pgdJm93EnOI3g174lC7Ybrwrv3zrEuchRptWSBGHJTlt
 o9Olp+H7nKPjKzdtPdKblAT/AOu5VbxnFumx+hMQUYpT+m1/w7LXDVI2clbBpKYs4EnR6cZqf
 6NIdp+54zm1ty7SRHcmL37ZYa49I/qTh4Q6p7qq5ZU0DEUnqZ9UgVmmd5ZUwr8+kTVbPhWeBZ
 Gxd+akzysmrMf0+Vp2dBcZLdpRz6jngTGYVPJFWBmrQ3GsjApY3irGeA09X8IExoSrnbo50tX
 7eQ7tXfVCAh4kmATJ0MCwP7ZN9qeAj+NW4u/3nAi044vgEmjV5n0vzSUwRqmgsV8V41tpNlOz
 TmKSxpqlwXoyzACa1tioj6dwNlu/WBybQQw5F2TtWh2dzdHgJItq9qNYOk4EeTMb4V+STgzX3
 ucE3MwSHPgGPNEK3fOi7bkPMscOmvNYhLd2biAWEpmigXmzoApXlMXwS0Bc62ldTeV96brtNe
 MOv6Qf68A6JjtZz0fTVAEC0t8o1OlPqjZl0n/db58x5YxvWIQxPpaeYymjXzig/b8TZJIlBbP
 mP1ceSS4c3xpQH19nmlWoRlIjg0buJR4j2ReF5Gwu+J+jqRg28Ecf2d8FceIeeBBdTZWfiRQQ
 8r+JFBQRygLRlQElvt/kqhn4x/55cw55QKA7VUFVZH6hrKqwK6x967xowqbj4JSTIbkdrs/ng
 /xS2ja8HxI1oPQ=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/24 02:39, Johannes Kastl wrote:
> Good evening,
>
> I need your advice on how to continue with one of my BTRFS RAID1 setups.
>
> The machine and the BTRFS RAID1 were built/created in 2014, as far as I
> can say. It was built using openSUSE Leap, I think 13.X or similar. The
> machine was then constantly upgraded and is now running openSUSE Leap
> 15.3 with a 5.3.18 kernel (detailed infos below).
>
> As one of the HDDs started reporting SMART errors, I just dd'ed each of
> the 4TB disks onto new 8TB disks (and fixed the GPT backup). I did not
> resize the filesystem, so it is still 3.6 TiB like on the old HDDs.
> To make sure that the filesystem was working, I issued a btrfsck against
> each of the devices.

No need to run btrfs check on each device.

Btrfs check will assemble the array automatically (just like kernel),
and check the fs on all involved devices.
Thus no need to run the same check on all devices.

>
> The output of the check is below. The TL;DR was that I should run 'btrfs
> rescue fix-device-size' to fix a "minor" issue.
>
> Unfortunately, running this command fails:
>
>> root dumbo:/root # btrfs rescue fix-device-size /dev/sdc1
>> Unable to find block group for 0
>> Unable to find block group for 0
>> Unable to find block group for 0

This is an unique error message, which can only be triggered when
btrfs-progs failed to find a block group with enough free space.

>> btrfs unable to find ref byte nr 2959295381504 parent 0 root 3=C2=A0 ow=
ner
>> 1 offset 0
>> transaction.c:168: btrfs_commit_transaction: BUG_ON `ret` triggered,
>> value -5

So at least no damage done to the good and innocent (but a little old) fs.
>> btrfs(+0x51f99)[0x55aeeae12f99]
>> btrfs(btrfs_commit_transaction+0x193)[0x55aeeae13573]
>> btrfs(btrfs_fix_device_size+0x123)[0x55aeeadfe2a3]
>> btrfs(btrfs_fix_device_and_super_size+0x6b)[0x55aeeadfe56b]
>> btrfs(+0x6ceee)[0x55aeeae2deee]
>> btrfs(main+0x8e)[0x55aeeade008e]
>> /lib64/libc.so.6(__libc_start_main+0xef)[0x7f907fc0d2bd]
>> btrfs(_start+0x2a)[0x55aeeade028a]
>> Aborted (core dumped)
>> root dumbo:/root #
>
> So, my question is what I should do:
>
> Do I need to run another command to fix this issue?

Not really.

But if you want to really remove the warning, please update btrfs-progs
first, to the latest stable version (v5.16.2), and try again.

The involved progs, v4.19 is a little old, and IIRC we had some ENOSPC
related fixed in progs, thus if above problem a bug caused false ENOSPC,
it should be fixed now.

> Can I safely ignore the issue?

You can ignore it for now.
It's not a big deal and kernel can handle it without problem.

> Should I copy all of the data to another disk, and create a new BTRFS
> RAID1 from scratch? (Which of course I would like to avoid, if possible.=
..)

Definitely no.

Thanks,
Qu
>
> Maybe someone can advise me on how to proceed. I am grateful for all of
> the input I get.
>
> If there is other information I should give, please feel free to reach
> out to me.
>
> Kind Regards
> Johannes
>
> #######################################################################
> btrfs check output:
>
>> root dumbo:/root # btrfs check -p /dev/sdc1 ;btrfs check -p /dev/sdd1
>> Opening filesystem to check...
>> Checking filesystem on /dev/sdc1
>> UUID: 50651b41-bf33-47e7-8a08-afbc71ba0bf8
>> [1/7] checking root items=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (0:03:09 elapsed,
>> 9467877 items checked)
>> WARNING: unaligned total_bytes detected for devid 2, have
>> 4000785964544 should be aligned to 4096
>> WARNING: this is OK for older kernel, but may cause kernel warning for
>> newer kernels
>> WARNING: this can be fixed by 'btrfs rescue fix-device-size'
>> [2/7] checking extents=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (0:38:38 elapsed,
>> 6910485 items checked)
>> WARNING: minor unaligned/mismatch device size detected
>> WARNING: recommended to use 'btrfs rescue fix-device-size' to fix it
>> [3/7] checking free space cache=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0:02:26 elapsed, 3730
>> items checked)
>> [4/7] checking fs roots=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (6:43:40 elapsed,
>> 6614818 items checked)
>> [5/7] checking csums (without verifying data)=C2=A0 (0:10:36 elapsed,
>> 1419101 items checked)
>> [6/7] checking root refs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (0:00:00 elapsed, 4
>> items checked)
>> [7/7] checking quota groups skipped (not enabled on this FS)
>> found 3308275023872 bytes used, no error found
>> total csum bytes: 3119386928
>> total tree bytes: 113221238784
>> total fs tree bytes: 108770082816
>> total extent tree bytes: 971456512
>> btree space waste bytes: 15308811797
>> file data blocks allocated: 3195053785088
>> =C2=A0referenced 3195047018496
>
> #######################################################################
>
> Machine and filesystem details
>
>> $ uname -a
>> Linux dumbo 5.3.18-150300.59.60-default #1 SMP Fri Mar 18 18:37:08 UTC
>> 2022 (79e1683) x86_64 x86_64 x86_64 GNU/Linux
>>
>> # btrfs --version
>> btrfs-progs v4.19.1
>>
>> # btrfs fi show
>> Label: 'DUMBO_BACKUP_4TB'=C2=A0 uuid: 50651b41-bf33-47e7-8a08-afbc71ba0=
bf8
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 2 FS bytes use=
d 3.08TiB
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 si=
ze 3.64TiB used 3.64TiB path /dev/sdd1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 si=
ze 3.64TiB used 3.63TiB path /dev/sdc1
>>
>> # btrfs fi df /mnt/DUMBO_BACKUP_4TB/
>> Data, RAID1: total=3D3.36TiB, used=3D2.97TiB
>> Data, DUP: total=3D13.50MiB, used=3D2.81MiB
>> Data, single: total=3D1.00GiB, used=3D0.00B
>> System, RAID1: total=3D32.00MiB, used=3D560.00KiB
>> System, single: total=3D32.00MiB, used=3D0.00B
>> Metadata, RAID1: total=3D284.94GiB, used=3D108.05GiB
>> Metadata, DUP: total=3D512.00MiB, used=3D64.00KiB
>> Metadata, single: total=3D1.00GiB, used=3D0.00B
>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
