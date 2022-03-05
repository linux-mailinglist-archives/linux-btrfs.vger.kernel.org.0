Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADE74CE462
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Mar 2022 12:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiCELH5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Mar 2022 06:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiCELH4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 06:07:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A4B49F29
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 03:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646478419;
        bh=hoKLksgSTiPchHtsnoeWCE39xcT+oQsmU7rqB+N5m3g=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=e4p9r+WG2GKE9C0os8ZpM+FlkFucQT6EP+p2lIQZZRrgvp3bbD1VwWCP2SUXKh+5c
         tRftuUMmdrVSUBuhVQZ1tOpd7YXf/N2OQLNeLf4KjtnF/NxsBZSOtbDVD3rZfw8p5K
         SXqohvxbj+5DpEyu3ZD2nXm+bypsMT32lpgQpJVw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXXuB-1ng7Qb3JHj-00Z1uM; Sat, 05
 Mar 2022 12:06:59 +0100
Message-ID: <529999ae-6681-eefc-f4ab-8c3473c0a482@gmx.com>
Date:   Sat, 5 Mar 2022 19:06:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Is this error fixable or do I need to rebuild the drive?
Content-Language: en-US
To:     Jan Kanis <jan.code@jankanis.nl>
Cc:     Remi Gauvin <remi@georgianit.com>, linux-btrfs@vger.kernel.org
References: <CAAzDdeysSbH-j-9rBGs3HBv2vyETbVyNoCjfDOKrka1OAkn1_g@mail.gmail.com>
 <2e9ee21e-65aa-9fb5-1d1c-1d6dea93eb12@gmx.com>
 <d3ad10fc-0e4a-a8b3-28d7-bc1957bf03ca@georgianit.com>
 <7c16b26a-e477-d6fd-d3bb-2ed7d086b1f0@gmx.com>
 <CAAzDdeyLz42V1tVJE1YK5jX2OpLG4Ghw4XYO0-pEcSR0yrkwGg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAAzDdeyLz42V1tVJE1YK5jX2OpLG4Ghw4XYO0-pEcSR0yrkwGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sxEfXV4Ewq6VoEaN/ZlXgAKx/wxCcXUc/NO5LywDsz8VhAeso3M
 nhkFrvpdLLmc59X8wVHSitQdiUlWEm4ipMspADraWOmp+QJ9EW6BXTR8EyYDPFKSEVk6TPW
 HbIB/fYO/sWnTFAe5ONlPg479HE7cED3LNycT+O5bjjZ5sFR6bikHvii7Bh985BVJSwTyz3
 wZQXquh1mh+q4TwFM+A5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nTHChSHNQto=:t0lW48t8JI/m/33yqpMKFS
 g0uNfuICnRxYj/sMirYW1Vex8JUmy/wZYQPPCaRHuo1GWHni4G2BLUvcJlVX6X52dCiIoyApq
 O0yCtTBq9LwHnOpyW6W+Q/0C4TT2xYcUA7al3lq2xdKGQ2evsXqj2fBx+J9ZCcgQIy/ZXb62f
 ugn32WMiCAW4nPcu10JuDLLHuzFDG5Svjp06BuqxKF3VFDVY1t9vPSia04oZNER/PfZiPmS7Q
 R2+WjM3P0E+NrSEp6bISmnEtm0sehPutNJxMRNx/g4j68yGz/dUQxhzZJgxnHKyYJohVXdwDZ
 8dvx+Rtj1CKkO0hJbYf3kPfTU0B+Kyd4+hvQnA2hDpTLGQTwVbp7u7ZdRDq75OCLqZjZ8eCSo
 n+tgC4TIiwrSj/oHrlPgr4dT6Eiy/kLerG4Zpw72wu7AmUaA6rNW5A0tRfVUImp0abOCyuk5m
 54MQgm9uRIxdAaVwel0gOwBV7QuMQha9AKk3PdCEMGMd4gtscmjHEIocWsOBVGFctHg7xy1JR
 9OJVK+20MzHlx961/iL5h8o4cm+ahi5Re3O0u7hUQJ7raKaVOhOnnUCGwms4T/X4jrTqnmcPH
 Tm7Nd0NUMdrIqxTc0Ea/QCHwSFc+rypkmgWReE9n9fycemCN/DQovmnOi9qOggFv8RWMgxPF1
 kG6jDIGd+0Ce46bDkBSL7vvbWnEM8NU0Bu2rToJy2a+c6Tk9wgY/RCBHXAQ461TfiaTXJm20s
 v+p9Vrps2Zrkj3yNOfrDTTFi1u49KRkUqk8vtOyOp0z16ts1zQzm+9A1Iiqryg5Z1WriuWnES
 DyYAd8lLUggUDJzmAJKfKb1gtazoajosf6V3euavCzhKWFCuPtVbEeZ0wxFJ/nSyvemCMpG/U
 yWmOvxAUu2QAVcaY6WFDyGbS7297EdXM1jozyWZFjFROZl0ErJstaY9/H1X4WrFEtJR/j62OA
 HKSSHfQxznHFYyk3tW+Ra1Ig0NE6avB2YPRLLrxX/hLDVQ+pMh/laRqLvgtWt6mN/zq3sBK1i
 XMpAy9NpdNuR9iTFndVGJ4CGoeY3BsagGssgmT0r+vhShFJbClchOorjdofYZLF/7+YB5p/WJ
 X2+1yuvodOSjsQ=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/5 18:33, Jan Kanis wrote:
> I wrote about 40 GB of data to the filesystem before noticing that one
> device had failed, but that data is now no longer needed so I don't
> care a lot if I might have a corrupted block in there. The filesystem
> is used mainly for backups and storage of large files, there's no
> operating system automatically updating things on that drive, so I'm
> quite sure of what changes are on there.
>
> What surprises me is that I'm getting checksum failures at all now. I
> scrubbed both devices independently when I had taken one of them out
> of the system, and both passed without errors. The checksum failures
> only started happening when I added the out of date device back into
> the array. Does btrfs assume that both devices are in sync in such a
> case, and thus that a checksum from device 1 is also valid for the
> equivalent block on device 2?

This is the split-brain case.

Each device has their own versions of metadata.
They all pass checksum check, at their own generation.

But when mixed, btrfs will use the latest one as root, thus older
metadata will be considered as corrupted.
So is the older data.

That's why independent scrub makes no sense for such split brain case.


Thanks,
Qu

>
> The statistics:
> The chance of one block matching its checksum by chance is 2**-32. 40
> GB is 1 million blocks. The chance of not having any spurious checksum
> matches is then (1-2**-32)**1e6, which is 0.999767. That's not as high
> as I was expecting but still a very good chance.
>
>> not to mention your data may not be that random.
> I think there are many cases where the data is pretty random, which is
> when it is compressed. The data on this drive is largely media files
> or other compressed files, which are pretty random. The only case I
> can think of where you would have large amounts of uncompressed data
> on your disk is if you're running a database on it.
>
> I'll see what happens with a scrub.
>
> Thanks for the help, Jan
>
>
> On Sat, 5 Mar 2022 at 07:47, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2022/3/5 11:11, Remi Gauvin wrote:
>>> On 2022-03-04 6:39 p.m., Qu Wenruo wrote:
>>>
>>>>    So by now I'm thinking that btrfs
>>>>> apparently does not fix this error by itself. What's happening here,
>>>>> and why isn't btrfs fixing it, it has two copies of everything?
>>>>> What's the best way to fix it manually? Rebalance the data? scrub it=
?
>>>>
>>>> Scrub it would be the correct thing to do.
>>>>
>>>
>>> Correct me if I'm wrong, the statistical math is a little above my hea=
d.
>>>
>>> Since the failed drive was disconnected for some time while the
>>> filesystem was read write, there is potentially hundreds of thousands =
of
>>> sectors with incorrect data.
>>
>> Mostly correct.
>>
>>>   That will not only make scrub slow, but
>>> due to CRC collision, has a 'significant' chance of leaving some data =
on
>>> the failed drive corrupt.
>>
>> I doubt, 2^32 is not a small number, not to mention your data may not b=
e
>>    that random.
>>
>> Thus I'm not that concerned about hash conflicts.
>>
>>>
>>> If I understand this correctly, the safest way to fix this filesystem
>>> without unnecessary chance of corrupt data is to do a dev replace of t=
he
>>> failed drive to a hot spare with the -r switch, so it is only reading
>>> from the drive with the most consistent data.  This strategy requires =
a
>>> 3rd drive, at least temporarily.
>>
>> That also would be a solution.
>>
>> And better, you don't need to bother a third device, just wipe the
>> out-of-data device, and replace missing device with that new one.
>>
>> But please note that, if your good device has any data corruption, ther=
e
>> is no chance to recover that data using the out-of-date device.
>>
>> Thus I prefer a scrub, as it still has a chance (maybe low) to recover.
>>
>> But if you have already scrub the good device, mounted degradely withou=
t
>> the bad one, and no corruption reported, then you are fine to go ahead
>> with replace.
>>
>> Thanks,
>> Qu
>>
>>>
>>> So, if /dev/sda1 is the drive that was always good, and /dev/sdb1 is t=
he
>>> drive that had taken a vacation....
>>>
>>> And /dev/sdc1 is a new hot spare
>>>
>>> btrfs replace start -r /dev/sdb1 /dev/sdc1
>>>
>>> (On some kernel versions you might have to reboot for the replace
>>> operation to finish.  But once /dev/sdb1 is completely removed, if you
>>> wanted to use it again, you could
>>>
>>> btrfs replace start /dev/sdc1 /dev/sdb1
>>>
