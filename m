Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4EA72D735
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 03:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjFMB6j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 21:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjFMB6i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 21:58:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26877122
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 18:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686621510; x=1687226310; i=quwenruo.btrfs@gmx.com;
 bh=d3wG+TtJfJ7UFNn2sA/7g7Qg89LX65Qia58ro+XNHTU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=GEHzI7sva1esozqQalFZzQv92cL4BSFcJOgxYBtEBPYmorMKQnTVz3DQ5JKjDaY1zrjQ10k
 t01dLtXqlMRf1UufW49K/hWvx6wDJTbIQ0eHUWaotAPakApz4EyKjrURFYuTlJ9Cvi7ZkdQ95
 HGgYjZIq0FGGcHhtxkPnBi94aNFX+tozvL6tMjTsCLVrRm8Azj7jsspfHmRmM7qfxzY8BIXTC
 50IyBi2AOLN1cH2e8X1khXOMt22JFJJmFHMhb4v3G1Ef+noDLxYbNBBBad23jsOXAtfTFRv4F
 n1vMd3KER/RMUNzx9loGApVbveWJFFSahxhxXUQppVJ1xUXkKnUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeR1-1qcqd41OL5-00VjpG; Tue, 13
 Jun 2023 03:58:29 +0200
Message-ID: <16ab1898-1714-a927-b8df-4a20eb39b8cd@gmx.com>
Date:   Tue, 13 Jun 2023 09:58:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Out of space loop: skip_balance not working
Content-Language: en-US
To:     Stefan N <stefannnau@gmail.com>, Paul Jones <paul@pauljones.id.au>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CA+W5K0r4Lv4fPf+mWWf-ppgsjyz+wOKdBRgBR6UnQafwL7HPtg@mail.gmail.com>
 <1ee0e330-1226-7abf-44bc-033decbe43e0@gmx.com>
 <CA+W5K0ow+95pWnzam8N6=c5Ff61ZeHyv7_yDK0LG6ujU48=yBA@mail.gmail.com>
 <40ecba88-9de2-7315-4ac5-e3eb892aac39@gmx.com>
 <CA+W5K0qLN3SaqQ242Jerp_fiyBw407e2h_BEA9rQ45HU-TfaZA@mail.gmail.com>
 <SYCPR01MB46856D101B81641A6CE21FB99E55A@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <CA+W5K0oKO2Vxu3D2jOLET1RrM=wOxTEH2a_uH1w44H2x9kT2tQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CA+W5K0oKO2Vxu3D2jOLET1RrM=wOxTEH2a_uH1w44H2x9kT2tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QG8CjFwd5FUKhgjjRIvUJ6eSSGEdKseYXiuf/n2qROPzjoNju+O
 YgNU8khWYMoqNwSIOIJ0e0v94T45y3MoamGKESKkMUpumWocVcfLTt7rwS9PAMA/dXAhxAz
 n1+4AN+iNc5Qb7JYB9BLWA4IMPCYygBaFowviGmbfmSNoggnwp0znkVx7kwm20piisETbCL
 oe24H/X7hr+6i9QEIw0YQ==
UI-OutboundReport: notjunk:1;M01:P0:TeoCAJaxgOg=;RcuaNpxD+VLIoqjSUHUnKDncXb4
 mK8dnOLZLBQRKMf2E48fFsXwxzz7C8D0Qb/d9+ZxjJMveAsM1PqwcZ3M2mosjxVcroksOM6bP
 kNkI/Rhq8wjfdC76I6w7WEZZV0/P4vPMzYabGknAzarnR5VHCYWbAGQXJsnfvQxAGICrkMWX4
 H5COsKr88O4wpVBPDKmTS4UBm6Q4762WJUs5SSaHBhebSY4qcGaXTSjUQotj7qKVz3BaOWeM9
 LzxUHulzxEwPASyHRpiC2L4wuE6TrCSo3z9SuoB6eVRvFD5NIPcxtpyVs25vGLZbWEzzxbrOs
 zi8Ya1s/H4Pkb7ujIFEuiNAKJhTZx6NozAF/oi+ccnAxZ7MY+DsIDPjfuCfcJ1dBMGTeLKg7R
 ylNm45o+oyOh1Z1zNSJSNjDDm+5okNA3+xfDxngrQn3RowyGeRbWTWzTEGSVr78PlOlpnW0xi
 XoQ0a1TFClkVYR3IzOFtqba6vnSJv1ZMfMHwhehFvfQvBmeMhtm7VARj5tTLF8KZNqKYNKriu
 64FfEI7IYGlBiO+e6FpLOxKREzft+YTXSdreK/E7IQ53pdYPwgrKK55ofB6AKcw5ujZljMaKn
 FwyiFxQpD5GlpqITXvOlTvDr6kjHvak4skM+6E4Yf9o1k8WdcgghPNqtVXb6EIkbF0vEMl4x2
 gTybdboqSnyKEW3YbfvNtZtfSVT4boVftkc0no06cqjOUn5tUabASKNOgFEw6mQ1lM7hedV3y
 dCZq81UJKJ1ag5LOA58dknaGJJw/i+lwH56k1RWOuqWmPObHTHO9/OgXE7BXJ0NOARqnAFlYj
 bLsWOVspAh6gG6eVBHv9kS5+qSG7aHx9w4YbgDpbO2pfse7Z2ttTCqSLUE9XMPGo/NkOu4pY1
 qPmeKchk04h8+ouYiD74/7QkPPoGYAz5AFUDy1Y+e/osvi97Lvp4PzqVAQykl78uTdymy/YGQ
 7AmvtG4pOwsPqA4jiNo+pSxpI/M=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/13 09:54, Stefan N wrote:
> Hi Paul,
>
> Thanks for the suggestion, I've had similar success in the past, but
> unfortunately not this time.
>
> I'm guessing this is because the metadata is full rather than the data.
>
> If I do `mount && btrfs dev add` as a single command on a small loop
> device it still doesn't perform in time before it turns to read only.

This is because btrfs_init_new_device() would commit transaction.

In your particular case, since you're running RAID1C4 you need to add 4
devices in one transaction.

I can easily craft a patch to avoid commit transaction, but still you'll
need to add at least 4 disks, and then sync to see if things would work.

Furthermore this means you need a liveCD with full kernel compiling
environment.

If you want to go this path, I can send you the patch when you've
prepared the needed environment.

Thanks,
Qu

> The same goes if I try to rm, truncate, btrfs fi sync or btrfs
> balance.
>
> - Stefan
>
> On Tue, 13 Jun 2023 at 10:59, Paul Jones <paul@pauljones.id.au> wrote:
>>
>>
>>> -----Original Message-----
>>> From: Stefan N <stefannnau@gmail.com>
>>> Sent: Monday, June 12, 2023 11:03 PM
>>> To: Qu Wenruo <quwenruo.btrfs@gmx.com>
>>> Cc: linux-btrfs@vger.kernel.org
>>> Subject: Re: Out of space loop: skip_balance not working
>>>
>>> On Mon, 12 Jun 2023 at 20:16, Qu Wenruo <quwenruo.btrfs@gmx.com>
>>> wrote:
>>>>> I've tried using the latest ubuntu livecd which has btrfs-progs v6.2
>>>>> on kernel 6.20.0-20
>>>>
>>>> I guess you mean 6.2?
>>>
>>> Sorry yes kernel 6.2.0-20 (Ubuntu)
>>>
>>>> In v6.2 kernel Josef introduced a new mechanism called
>>> FLUSH_EMERGENCY
>>>> to try our best to squish out any extra metadata space.
>>>>
>>>> If that doesn't work, I'm running out of ideas.
>>>
>>> How do I go about forcing this to engage? Currently the array never st=
ays in
>>> write mode long enough to do anything, so I'd need to trigger somethin=
g
>>> immediately after mount to have a chance that it syncs before it goes =
into
>>> read only mode.
>>>
>>>>> BTRFS info (device sdi: state A): space_info total=3D83530612736,
>>>>> used=3D82789154816, pinned=3D245710848, reserved=3D495747072,
>>>>> may_use=3D130809856, readonly=3D0 zone_unusable=3D0
>>>>
>>>> The big concern here is, we have hundreds of MiBs for
>>>> pinned/reserved/may_use.
>>>>
>>>> Which looks too large.
>>>>
>>>> My concern is either free space tree or extent tree updates are takin=
g
>>>> too much space.
>>>>
>>>> Have you tried to cancel the balance and sync? That doesn't work eith=
er?
>>>
>>> The balance cancels ok, and there's no sync running except the auto UU=
ID
>>> tree check on mount.
>>>
>>>> Considering you have quite some data space left, you may want to
>>>> migrate to space cache v1.
>>>> Unlike v2 cache, v1 cache only takes data space, thus may squish out
>>>> some precious metadata space.
>>>
>>>  From the 'disk space caching is enabled' in the log it must still be =
using space
>>> cache v1, and forcing it as a flag doesn't appear to change anything.
>>>
>>> With many remount cycles, the best I've been able to achieve has been =
to rm
>>> some small files, but they never synced and were back in btrfs on remo=
unt.
>>>
>>> I'm running out of ideas, and given the size I really don't want to ha=
ve to
>>> replace/rebuild if I can help it!
>>>
>>> Any other ideas would be greatly appreciated
>>
>>
>> When I've had similar issues in the past I've managed to create some sp=
ace by adding a usb drive (or two) to the filesystem, which then gives eno=
ugh of a buffer to remove some files, and when btrfs will let you remove t=
he extra drive you know everything is back under control.
>>
>> Paul.
