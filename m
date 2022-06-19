Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2068E550AD9
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 15:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbiFSNVS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 09:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbiFSNVR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 09:21:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7F5E4C
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 06:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655644874;
        bh=5tYmhAGQTZdzNjC1hRzE4VHBi1aTBtWB6zCMde9+4bQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ZJiyLLMhmBL0k+fQZQpMAwjZVcTWl0Y1MG0yXqWV/LPUCITY2hAtAbzZ4NJEciviW
         gfG2FGHqQVcNtvZByKmywzDBwAGDQlS64zrGQU8if0gJ2oH8tfXCS7b4CzdkHUGynt
         pUckNX0rgd4TaiY0byW4A/i5wKxeXbCYoNPCXJqY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DNt-1nzM5k0wft-003bGz; Sun, 19
 Jun 2022 15:21:13 +0200
Message-ID: <0bd434e9-0359-46b9-85b8-1b21ef01a36e@gmx.com>
Date:   Sun, 19 Jun 2022 21:21:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Problems with BTRFS formatted disk
Content-Language: en-US
To:     "David C. Partridge" <david.partridge@perdrix.co.uk>,
        linux-btrfs@vger.kernel.org
References: <001f01d88344$ed8aa1d0$c89fe570$@perdrix.co.uk>
 <603196b9-fa55-f5cc-d9b5-3cf69f19c6ef@gmx.com>
 <000001d8837c$91bc74e0$b5355ea0$@perdrix.co.uk>
 <838a65c7-214b-adc1-2c9e-3923da6575e2@gmx.com>
 <000001d883c7$698edad0$3cac9070$@perdrix.co.uk>
 <e7c18d33-4807-7d6f-53f5-6e3f59b687ef@gmx.com>
 <000401d883cd$cc588fc0$6509af40$@perdrix.co.uk>
 <393cf34a-0ae9-d34c-b2bb-ea74d906dfa5@gmx.com>
 <000201d883db$a22686e0$e67394a0$@perdrix.co.uk>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <000201d883db$a22686e0$e67394a0$@perdrix.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PkkJ0dFagEvnLRZE3Tgrf69dKTIs6Tsj4DD66xu5osNjVeKFc6/
 Q5EWf41uSFI4lDEiNy7dK17vJOsjR1DIqEdXIqW1RgBpWzqO2XhY0RssR8Rg6GCokzTYDf5
 AygmCXoQ1CKIWe7tFidTwi+8yymwtEy08GFr25cdSjbF56bEqYG6sP3XACkp9ut9NL/RIop
 sN9kxtb0ovO8rhE07WCMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lUIAxdYD7t8=:GkKLrMc4+h9E9/rSPxr4my
 DYY0qu3S8J7jDeWx5poBuHnyDGSoHm9IkVrx3NPAA4w3cOezSC3ABz396AfReK8wv1Pil+7/4
 skINtfmuiFL57djiHIOubl+2kSnZCbGqAfGvKsMxMCecNbCD2JYTxyVQli08dS5XFmUqPvLzs
 z+yUuTh/nxrfX/IA3qhNpwN2c0TYRHdi4TTasqxHMhipKwX/U2VTnPZpANqlPuCngOL/wl7jI
 gRuPmugOMyDzR1uR4SMKtCY57wVhEL3BYQLs3VibfKMXAyZpFyj0lQEBbIC7of/9LQHY1c/J/
 iAC+WGexlfKIoP6YgsLPTNMvFYLhfoly1QUmxzq9/qzX+t5FSFh4yZIiRN/9kJh5DuZGYq7n8
 4vNOnOJyn5iwsc4pwxqKGj7y+WY5RFoUmKdQEZLLbhj0mT9osdBOIxQN7PbKAjt77TzY0lSQs
 CddjN/510vLJIlWRKTOuPzolApjxuJwZQrE6tWkyVlgaJQQrpIPS1CQRIiQZkfnkJ52edth0x
 Q1C2HfjtolYjSnmNZMwBAulVssj6hfw5MG9rrK1N+uC7omZYRhqiwUmWkb2Iwsw4ICBvzz5u4
 aYHYjqWz8C7W8ScuP+8Y1p0UGFppQX3U1mRuVb9CQg5N+eioex2yDqsLYkslinlO9MN6IMdgy
 udH27VTVX0RIrpl+Yx5Nq/tXELCC6VHDm1C3lfn38h5WGIB8i+EakuRakymg7/ugain6+wMNi
 UwwDLXCTYdkrJzqrdATLZU7pRWY+GdyUN/z/hpQ0WRSlZ+z+DIiys8wb3lGLVhkpy47V5FitP
 Sc51P70VcwKJlVxInJUtea+I5466jO923rheBulBSyy2APPmMH23W2u4iamTWnki7ICa3GP/w
 53rRxLLVzJsGuhb/leDjzNiO7nb5LMussWm7G6EZ4GoWVVbC+79JePTpCCjT53HMZPfUAHsEo
 Pe2/JOZL2J7yPVJ1XV4vFFTPmiGgwqcvsIMnhU3k3y0VJlC0qSJVNBQ+z1Le6MBGryQiL5Byv
 2QDhFNam5TdqolwXYGBDyAj56CX55ePWI0gLoimJFcdfsD1A66lnype06CVOCuClby3SQrF2O
 TpIIHDh+uUivjxidqre6RnPoEY5LgowOGGqeI+uNLTyOx/IEUstC4GjdA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/19 20:53, David C. Partridge wrote:
> Here's what the 2022.06.01 version of Archlinux had to say in the log wh=
en I issued:
>
> mount -t btrfs -o rescue=3Dall /dev/sdc1 /mnt
>
> Jun 19 12:43:01 archiso kernel: BTRFS info (device sdc1): flagging fs wi=
th big metadata feature
> Jun 19 12:43:01 archiso kernel: BTRFS info (device sdc1): enabling all o=
f the rescue options
> Jun 19 12:43:01 archiso kernel: BTRFS info (device sdc1): ignoring data =
csums
> Jun 19 12:43:01 archiso kernel: BTRFS info (device sdc1): ignoring bad r=
oots
> Jun 19 12:43:01 archiso kernel: BTRFS info (device sdc1): disabling log =
replay at mount time
> Jun 19 12:43:01 archiso kernel: BTRFS error (device sdc1): nologreplay m=
ust be used with ro mount option
> Jun 19 12:43:01 archiso kernel: BTRFS error (device sdc1): open_ctree fa=
iled
>
> Did I need to say:
>
> mount -t btrfs -o ro,rescue=3Dall /dev/sdc1 /mnt

Yep.

Thanks,
Qu
>
> D.
>
> -----Original Message-----
> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Sent: 19 June 2022 12:51
> To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vger=
.kernel.org
> Subject: Re: Problems with BTRFS formatted disk
>
>
>
> On 2022/6/19 19:14, David C. Partridge wrote:
>> LUbuntu 22.04 was definitely 5.15 kernel, what alternative distro do yo=
u propose I use?
>
> I have no idea why 22.04 doesn't work here.
>
> The upstream commit is 2b29726c473b ("btrfs: rescue: allow ibadroots to
> skip bad extent tree when reading block group items"), which is already
> in v5.15 kernels.
>
> I double checked the current code base, as long as it's error reading
> the block group items and rescue=3Dall (implies ibadroots), it should go
> fill_dummy_bgs().
>
> For the alternative distros, OpenSUSE tumbleweed, Archlinux, etc. As
> they are definitely upstream and v5.15+.
>
> For example, Archlinux 2022.06.01, it goes with 5.18 kernel:
>
> $ file arch/boot/x86_64/vmlinuz-linux
> arch/boot/x86_64/vmlinuz-linux: Linux kernel x86 boot executable
> bzImage, version 5.18.1-arch1-1 (linux@archlinux) #1 SMP PREEMPT_DYNAMIC
> Mon, 30 May 2022 17:53:11 +0000, RO-rootFS, swap_dev 0XA, Normal VGA
>
> If that still doesn't work, let me creating a similar fs with some block
> groups items corrupted to see why it doesn't work.
>
> Thanks,
> Qu
>>
>> -----Original Message-----
>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>> Sent: 19 June 2022 11:41
>> To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vge=
r.kernel.org
>> Subject: Re: Problems with BTRFS formatted disk
>>
>>
>>
>> On 2022/6/19 18:29, David C. Partridge wrote:
>>> Booted from live USB 22.04 LUbuntu.
>>
>> Ubuntu kernel version doesn't seem to be that consistent even for its
>> LTS releases:
>>
>> https://ubuntu.com/about/release-cycle#ubuntu-kernel-release-cycle
>>
>> Please use something rolling released distro/branch instead.
>>
>> Thanks,
>> Qu
>>>
>>> root@lubuntu:/home/lubuntu# mount -t btrfs -o rescue=3Dall /dev/sdc1 /=
mnt
>>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdc1, m=
issing codepage or helper program, or other error.
>>> root@lubuntu:/home/lubuntu#
>>>
>>> Content of system journal
>>>
>>> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): flagging fs =
with big metadata feature
>>> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): disk space c=
aching is enabled
>>> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): has skinny e=
xtents
>>> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): parent tran=
sid verify failed on 12554992156672 wanted 130582 found 127355
>>> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): parent tran=
sid verify failed on 12554992156672 wanted 130582 found 127355
>>> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): failed to r=
ead block groups: -5
>>> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): open_ctree =
failed
>>>
>>> David
>>>
>>> -----Original Message-----
>>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>>> Sent: 19 June 2022 03:02
>>> To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vg=
er.kernel.org
>>> Subject: Re: Problems with BTRFS formatted disk
>>>
>>>>> You can try rescue=3Dall mount option, which has the extra handling =
on
>>>>> corrupted extent tree.
>>>>
>>>>> Although you have to use kernels newer than v5.15 (including v5.15) =
to
>>>>> benefit from the change.
>>>>
>>>> Unfortunately:
>>>> amonra@charon:~$ uname -a
>>>> Linux charon 5.4.0-113-generic #127-Ubuntu SMP Wed May 18 14:30:56 UT=
C 2022 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> Any special reason that you can not even use a liveUSB to boot a newer
>>> kernel to do the salvage?
>>>
>>>
>>> Thanks,
>>> Qu
>>>
>>
>
