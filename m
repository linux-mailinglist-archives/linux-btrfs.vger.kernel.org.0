Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E180A5AE33B
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 10:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbiIFIm0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 04:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiIFIll (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 04:41:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7291786FE
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 01:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662453475;
        bh=qXFwMwCqBcEbanCHy+UatwA2OPSaYMKCW1TYlKzuDeY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=CIDUUwi+GWcWhP98HSShzuZ2Go03ppsH/lL/qMBGhgKqLNMl18fecZoftnsaE/2Ze
         x2UcacIOGsk6FGvelK9TzDfkYS2WZIHnV2rtZPhlaS3ftUFXYm1hPEs6qW0g2+zHk2
         2xwuhIsyk2qJ4wD+s2cU+lHhm16yndlS3bzyeRJE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCbEf-1odUZ71Ezj-009fjV; Tue, 06
 Sep 2022 10:37:54 +0200
Message-ID: <1b00d889-bf4b-a092-38c0-fb6c6aa09fdf@gmx.com>
Date:   Tue, 6 Sep 2022 16:37:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: some help for improvement in btrfs
Content-Language: en-US
To:     hmsjwzb <hmsjwzb@zoho.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <fb056073-5bd6-6143-9699-4a5af1bd496d@zoho.com>
 <655f97cc-64e6-9f57-5394-58f9c3b83a6f@gmx.com>
 <40b209eb-9048-da0c-e776-5e143ab38571@zoho.com>
 <72a78cc0-4524-47e7-803c-7d094b8713ee@gmx.com>
 <00984321-3006-764d-c29e-1304f89652ae@zoho.com>
 <18300547-1811-e9da-252e-f9476dca078c@gmx.com>
 <4691b710-3d71-bd26-d00a-66cc398f57c5@zoho.com>
 <7553372e-1485-63ae-d3f1-e9e0a318b2f6@gmx.com>
 <9c295a8c-5167-116e-4fae-d548f1deb3b2@zoho.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <9c295a8c-5167-116e-4fae-d548f1deb3b2@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A5HfiK6+AJ8X5KWhohq+BIVOHNw3KQvuDfuX4zIovANo1fuEGoD
 sJoFHQbWKKjLwxmhfAkUbp2+URGc43+4uXYlRBNqgZtNVmPMAIDjg92qGliDmFQ913nzTmN
 iBAScEdkly6zmVBSdnoq0WdJU7unCKeSz9tk+M8QQ6J97Kl0purdxqq+t5/L5JRhO9YHG5N
 AmhEByZpERsUhlDxbMI2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R1lQsVrXDu0=:rmbxhbWSaAXp2N2UTK1LQV
 VxncKYL5uWvH+mSVXG152G7gVwgvEe1kNuR2oco3yoOumUoyZbSrsuu1if+B0a3z9QBbvUwJq
 PxZ7kfxtasyRkDlcb5Mmmr1pY09SjDzyLmnC5z2lBEm995UFX2ogznE08ZjJh4d0Hm/PsC/cX
 MSuWFWmnuqbqkSGULYD6vMrP25Ku9UXPMqvjUI2Kbwg6YTR7jtT4vGT2WDNNdXxMEfEqxzFc6
 cxBGw5ffFrD4qsn3VSihi+PbEnASiKVB9DyKIrbj8k64/4APeM6LOl0dkJLIzJJI3D8MkF/CT
 ykZLJCsar5YtIrvWbbVG60NrkqeJ0TD3UguY2ljzChO2/CYZw+A8rhPXppVBWmjcofHQXeyfu
 Yo3dqw6T2JG2E16N9h/a3Ifw4UilmWH91k2RrAn68Z732ZxbwoYWlDDmUeLL+/llZAsjv05FJ
 MUx+ZfuqBFBRyQ8as9mVCQS6zRtCtVZlFS315hCkczrKWW+bagmQ7c5bvVaA2Mp6NxSQ6VB4i
 BzmZz3oCYe0J8eKdlDilYYEyAolxA5lhwjhs88ZAMp1+2Fxkz6t8CWC6MF4Hi9zgRRT6O+Yus
 7g4sXSTxw29cWl8Ll5q40gwVrgtmJdOXWkiBkFPvuUNj0oxGbIB3vKozSJQfdcD61BciNfVxE
 hDCxd2S2rGtHDkz6ioEVhWRqq+cqamfkXW75b5AMORXtrhB6to5WA66QGY2JjAFcV4ak4se81
 qmSXitMhrTurIehm4k19v2fEvjuDLR/c9vJMygoKSdTdfxTxF8Ypz5lF8EgyOyy6be34wtcuk
 CHDEVs4I+s6HAH9FKUu/QTx773VZiLtuHz1ZMJh48WrNMk5KVrgJy+UCHadjmpmdGaMW6n1XD
 FmFDqIZUIUw0SF1zTvPknUl52KdcMVR8Lt5fQoCsrqNi2mrwFguF67npLzqH/dt4oaS0CXVVv
 mGTXUn86oqb+rJoVdBgYYhrlvOg5Ject+zKbLXGtuzQX9kTapeM0KuEOj/drSIV0qk+LxDyyy
 yU2h8EBQoIjCEUZTOPeMVD1+AEWjTUYmZW6+sPd1B6/oTyB7HC+XLdq53CGXsMcOEAjU7YtQA
 f1TZI/yGS+JfHnycBC54DoI4hcN7XUrsRW9UWWeX0bTHtj7qIGuYVi4mu3Yx2dNuIHFkmUSwk
 Iex292gwovrHb0u94OKVVXMpY4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/6 16:02, hmsjwzb wrote:
> Hi Qu,
>
> Thank you for providing this interesting case. I use qemu and gdb to deb=
ug this case and summarize as follows.
>
> [test case]
>
> mkfs.btrfs -f -m raid5 -d raid5 -b 1G /dev/vda /dev/vdb /dev/vdc
>
> mount /dev/vda /mnt
>
> xfs_io -f -c "pwrite -S 0xee 0 64k" /mnt/file1
>
> sync
>
> 	After the above command, the device look like this.
>             	119865344
> 	vda |     |     stripe 0:Data for file1            |      |
>             	98893824
> 	vdb |     |     stripe 1:redundant Data for parity |      |

Note, that is not redundant data, but some unused space, it can be garbage=
.

But still, we need this unused space to calculate the parity anyway.

>             	98893824
> 	vdc |     |     stripe 2:parity                    |      |
>
> 	We can see that stripe 1 is not used by btrfs filesystem.
>
> umount /dev/vda
>
> xfs_io -f -c "pwrite -S 0xff 119865344 64k" /dev/vda
>
>             	119865344
> 	vda |     |     stripe 0:Data for file1(Corrupted) |      |
>             	98893824
> 	vdb |     |     stripe 1:redundant Data for parity |      |
>             	98893824
> 	vdc |     |     stripe 2:parity                    |      |
>
> 	This command erase the data for file1 in stripe 0. I think it simulate =
the
> 	data loss in hardware.

Yep, that's correct.

>
> mount /dev/vda /mnt
>
> 	If we issue a read request for file1 now, the data for file1 can be rec=
overed
> 	by raid5 mechanism.
>
> xfs_io -f -c "pwrite -S 0xee 0 64k" -c sync /mnt/file2
>
>             	119865344
> 	vda |     |     stripe 0:Data for file1(Corrupted)               |     =
 |
>             	98893824
> 	vdb |     |     stripe 1:Data for file2                          |     =
 |
>             	98893824
> 	vdc |     |     stripe 2:parity(Recomputed with Corrupted data)  |     =
 |
>
> 	After the above command, the stripe 1 in vdb is used for file2. The par=
ity data
> 	is recomputed with corrupted data in vda and data of file2. So the Data=
 for file1
> 	is forever lost.

Exactly, that's the destructive RMW idea.

>
> cat /mnt/file1 > /dev/null
>
> 	This command will read the corrupted data in stripe 0. And the btrfs cs=
um will find
> 	out the csum mismatch and print warnings.
>
> umount /mnt
>
> [some fix proposal]
>
> 	1. Can we do parity check before every write operation? If the parity c=
heck fails,
>             we just recover the data first and then do the write operati=
on. We can do this
> 	   check before raid56_rmw_stripe.

That's the idea to fix the destructive RMW, aka when doing sub-stripe
write, we need to:

1. Collected needed data to do the recovery
    For data, it should be all csum inside the full stripe.
    For metadata, although the csum is inlined, we still need to find out
    which range has metadata, and this can be a little tricky.

2. Read out all data and stripe, including the range we're writing into
    Currently we skip the range we're going to write, but since we may
    need to do a recovery, we need the full stripe anyway.

3. Do full stripe verification before doing RMW.
    That's the core recovery, thankfully we should have very similiar
    code existing already.

>
> [question]
> 	I have noticed this patch.
>
> 		[PATCH PoC 0/9] btrfs: scrub: introduce a new family of ioctl, scrub_f=
s
> 		Hi Qu,
> 			Is some part of this patch aim to solve this problem?

Nope, that's just to improve scrub for RAID56, nothing related to this
destructive RMW thing at all.

Thanks,
Qu
>
> Thanks,
> Flint
>
>
> On 8/16/22 01:38, Qu Wenruo wrote:
>>
>>
>> On 2022/8/16 10:47, hmsjwzb wrote:
>>> Hi Qu,
>>>
>>> Sorry for interrupt you so many times.
>>>
>>> As for
>>>  =C2=A0=C2=A0=C2=A0=C2=A0scrub level checks at RAID56 substripe write =
time.
>>>
>>> Is this feature available in latest linux-next branch?
>>
>> Nope, no one is working on that, thus no patches at all.
>>
>>> Or may I need to get patches from mail list.
>>> What is the core function of this feature ?
>>
>> The following small script would explain it pretty well:
>>
>>  =C2=A0 mkfs.btrfs -f -m raid5 -d raid5 -b 1G $dev1 $dev2 $dev3
>>  =C2=A0 mount $dev1 $mnt
>>
>>  =C2=A0 xfs_io -f -c "pwrite -S 0xee 0 64K" $mnt/file1
>>  =C2=A0 sync
>>  =C2=A0 umount $mnt
>>
>>  =C2=A0 # Currupt data stripe 1 of full stripe of above 64K write
>>  =C2=A0 xfs_io -f -c "pwrite -S 0xff 119865344 64K" $dev1
>>
>>  =C2=A0 mount $dev1 $mnt
>>
>>  =C2=A0 # Do a new write into data stripe 2,
>>  =C2=A0 # We will trigger a RMW, which will use on-disk (corrupted) dat=
a to
>>  =C2=A0 # generate new P/Q.
>>  =C2=A0 xfs_io -f -c "pwrite -S 0xee 0 64K" -c sync $mnt/file2
>>
>>  =C2=A0 # Now we can no longer read file1, as its data is corrupted, an=
d
>>  =C2=A0 # above write generated new P/Q using corrupted data stripe 1,
>>  =C2=A0 # preventing us to recover the data stripe 1.
>>  =C2=A0 cat $mnt/file1 > /dev/null
>>  =C2=A0 umount $mnt
>>
>> Above script is the best way to demonstrate the "destructive RMW".
>> Although this is not btrfs specific (other RAID56 is also affected),
>> it's definitely a real problem.
>>
>> There are several different directions to solve it:
>>
>> - A way to add CSUM for P/Q stripes
>>  =C2=A0 In theory this should be the easiest way implementation wise.
>>  =C2=A0 We can easily know if a P/Q stripe is correct, then before doin=
g
>>  =C2=A0 RMW, we verify the result of P/Q.
>>  =C2=A0 If the result doesn't match, we know some data stripe(s) are
>>  =C2=A0 corrupted, then rebuild the data first before write.
>>
>>  =C2=A0 Unfortunately, this needs a on-disk format.
>>
>> - Full stripe verification before writes
>>  =C2=A0 This means, before we submit sub-stripe writes, we use some scr=
ub like
>>  =C2=A0 method to verify all data stripes first.
>>  =C2=A0 Then we can do recovery if needed, then do writes.
>>
>>  =C2=A0 Unfortunately, scrub-like checks has quite some limitations.
>>  =C2=A0 Regular scrub only works on RO block groups, thus extent tree a=
nd csum
>>  =C2=A0 tree are consistent.
>>  =C2=A0 But for RAID56 writes, we have no such luxury, I'm not 100% sur=
e if
>>  =C2=A0 this can even pass stress tests.
>>
>> Thanks,
>> Qu
>>
>>>
>>> I think I may use qemu and gdb to get basic understanding about this f=
eature.
>>>
>>> Thanks,
>>> Flint
>>>
>>> On 8/15/22 04:54, Qu Wenruo wrote:
>>>> scrub level checks at RAID56 substripe write time.
