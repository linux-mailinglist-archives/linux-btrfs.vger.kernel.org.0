Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC586550D55
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 23:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiFSVl0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 17:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbiFSVke (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 17:40:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20805AE70
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 14:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655674830;
        bh=2Qhuqp0Lcu9+pEv6ah4XJ3nE0gNX+x2CFZeydeRJN+w=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=iIsmX/09oSSyhGNTAC9QSxknUBwwkl+Bc7jaoBQArvxTNVHXDKMMaoYRmbRfP2CxX
         +H0G2JCE7eKZHu6lAYyMqLgsFMCv8v560teEON8AWMyyh4abS4pRKKUV2+Rtc4QLOB
         UBXbVLH9fmeZS2fsx9SYP4o14FB+3v1AQAwUMJfw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McpJg-1nT9bj1H9O-00Zyn1; Sun, 19
 Jun 2022 23:40:30 +0200
Message-ID: <aedc9eb7-20f4-49a5-f8c6-9a55353bc25f@gmx.com>
Date:   Mon, 20 Jun 2022 05:40:26 +0800
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
 <000901d883e0$289d73b0$79d85b10$@perdrix.co.uk>
 <b8579f1c-a277-2a01-2126-77ffcc0ab2d5@gmx.com>
 <000c01d883e7$1757e570$4607b050$@perdrix.co.uk>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <000c01d883e7$1757e570$4607b050$@perdrix.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FVShGo72gPZ0B6TWXf4noPAPMJeTRCJcwQul1OfnQIoUzUuymR3
 j0NcwhyZy2upiKJtk+w2Gz4j0/ooiUNZEy/+jZ57dwEk+YyzpWu6Q0YjUsmcC7wRVZh/w6B
 5htd7VeR6JPr9gABw1lQ4QqnqzkXExroS/P3+RWB+3kBmwVFGTfPZCFsT6FeC6k6PXd82+J
 xKqnJAcU6ssZPBylb5SKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EfkDUOvpPPc=:YXDsVbcaFjjLLGBwW2cszy
 uc0xG0iCIOLuV9HM2zs0/IZnyxV6K+2kAUP0gXxck/rC4fXL+E5VRP8moRZorBGH4Q0a/xVbt
 ThChWtiownMMTCI3UZbZuOn0kug6RFPjhNISOaZr9KytYYyx6hJcIEHvLs3yeVkwc5KHZ+0mV
 JZComJTDswwMd/RxBOAxS8WWpJHZH9dJounxPd0k6vOZCm10pnlhdsVdgNL/vHvwuypY8CK1I
 4XCHIWZaMUBu8FaR4QH2TpSbIfXqcM7BxWkYQj0hEevSWj75NpQusWm75oc6Z4/q8EeF+pl05
 wcfTpfhIduoNfiTvDug7K4XdoZEcJoyGgCvOOMtmTPRWYU6pW9MBlkAsAaRTsYvA13Pvn77JW
 RbhERh4h8H7QTIut+95ymsk45CXtGe4R/UqodkfWTiZ0kljQzZBHE4MQn1H87xXplZeriKj/3
 5Vw/UkhzFG+RJHn0zaEKpZO4J2+8p6l5aDoI5U17BkgcT0Rs/q9eIVyskzAYQiYfc8RHBzTQS
 X8CqzJrZhBMEj+zoHwCKsI26aMdeQxlQtEzk8up/THriOj/ho9+DYJrKpMHWoKXlmZwP9TN7A
 XaJX/OvZZWIiqyCzt2AYOpgLYERYocYyixP+EzAVR4kVJ4gKUyoyczOkDZwSD1rbDPSDy2bQB
 4/HLrBDTNeVd30VK+y3lwjImCrrn1jbFhFv25Ket9Pjy/NAsdZ9Tg47mU4hJyawBvVi1Ecrvg
 pGrciPB0fQPdvJlCwPEVgsgWnF2zlKPrqpZ1KhLdzHug04XD3k//IuLtNWl8omg1fMSr6Gpu4
 d/QkvSCvPTWEAwEipr46tM37wys9g98T4xh/6kExStRTD6Cz7cfnw6wiwKtaleEUPFgfz2oO5
 I5cAXHBr/e+8Jsj+JEKQvI5gj+AHVRUReRKwkuiMigH/gcA2g1V6fIhmWRcB5TtmYujGON0zP
 6xOzLDKeog4i9fqewPTaKQacyDUhxsJf8xAlr8DChuZrjQVl88a44PpYlI6PSzfk4wiuRJLMq
 u8j9m3JPJzqXZIE9Og1tIBRzniiiC2xKOTldbUl6HrJsjPRSm9kdoOcHFMHqAUwB/W5oWtjru
 ibhCAp+MFDLKTqPGRNF7hsuLbcQPUC/mdxypTbnQH40w+mNNZzy2EEaEw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/19 22:15, David C. Partridge wrote:
> I can't "grab what I can" as I don't have enough TB to copy the data I w=
ant to save =E2=98=B9
>
> Does it make any sense to try:
>
>   mount -o remount,rw /mnt

Nope, remount RW will be completely rejected for rescue=3Dall case.

>   btrfs subvolume delete /mnt/@
>   btrfs subvolume delete /mnt/@_daily.20220525_00:11:01
>   btrfs subvolume delete /mnt/@_daily.20220526_00:11:01
>   btrfs subvolume delete /mnt/@_hourly.20220526_06:00:01
>   btrfs subvolume delete /mnt/@_hourly.20220526_09:00:01
>   btrfs subvolume delete /mnt/@_hourly.20220526_12:00:01

Deleting them won't help, the transid mismatch is affecting too many
parts of the fs.

>
>   mv /mnt/@_daily.20220524_00:11:01 /mnt/@
>
> or is that doomed to total failure?

Mostly yes. Thus the only thing can do is really data salvage.

Thanks,
Qu

>
> The disks behind the raid card are all Western Digital WD4001FYYG SAS dr=
ives
>
> David
>
>
> -----Original Message-----
> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Sent: 19 June 2022 14:31
> To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vger=
.kernel.org
> Subject: Re: Problems with BTRFS formatted disk
>
>
>
> On 2022/6/19 21:26, David C. Partridge wrote:
>> Aha this is much more interesting:
>>
>> I issued: mount -t btrfs -o ro,rescue=3Dall /dev/sdc1 /mnt
>>
>> And got this in the system log:
>>
>> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): flagging fs w=
ith big metadata feature
>> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): enabling all =
of the rescue options
>> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): ignoring data=
 csums
>> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): ignoring bad =
roots
>> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): disabling log=
 replay at mount time
>> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): disk space ca=
ching is enabled
>> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): has skinny ex=
tents
>> Jun 19 13:04:32 archiso kernel: BTRFS error (device sdc1: state C): par=
ent transid verify failed on 12554992156672 wanted 130582 found 127355
>> Jun 19 13:04:32 archiso kernel: BTRFS error (device sdc1: state C): par=
ent transid verify failed on 12554992156672 wanted 130582 found 127355
>> Jun 19 13:05:12 archiso systemd[1]: dev-virtio\x2dports-org.qemu.guest_=
agent.0.device: Job dev-virtio\x2dports-org.qemu.guest_agent.0.device/star=
t timed out.
>> Jun 19 13:05:12 archiso systemd[1]: Timed out waiting for device /dev/v=
irtio-ports/org.qemu.guest_agent.0.
>> Jun 19 13:05:12 archiso systemd[1]: Dependency failed for QEMU Guest Ag=
ent.
>> Jun 19 13:05:12 archiso systemd[1]: qemu-guest-agent.service: Job qemu-=
guest-agent.service/start failed with result 'dependency'.
>> Jun 19 13:05:12 archiso systemd[1]: dev-virtio\x2dports-org.qemu.guest_=
agent.0.device: Job dev-virtio\x2dports-org.qemu.guest_agent.0.device/star=
t failed with result 'timeout'.
>> Jun 19 13:05:12 archiso systemd[1]: Reached target Multi-User System.
>> Jun 19 13:05:12 archiso systemd[1]: Reached target Graphical Interface.
>> Jun 19 13:05:12 archiso systemd[1]: Startup finished in 1min 4.847s (fi=
rmware) + 4.837s (loader) + 9.433s (kernel) + 1min 31.546s (userspace) =3D=
 2min 50.664s.
>> Jun 19 13:05:38 archiso kernel: BTRFS info (device sda2): flagging fs w=
ith big metadata feature
>> Jun 19 13:05:38 archiso kernel: BTRFS info (device sda2): disk space ca=
ching is enabled
>> Jun 19 13:05:38 archiso kernel: BTRFS info (device sda2): has skinny ex=
tents
>> Jun 19 13:05:38 archiso kernel: BTRFS info (device sda2): enabling ssd =
optimizations
>>
>> ll /mnt got me this:
>>
>> Jun 19 13:08:13 archiso kernel: verify_parent_transid: 4 callbacks supp=
ressed
>> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): par=
ent transid verify failed on 576192512 wanted 129948 found 122929
>> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): par=
ent transid verify failed on 576192512 wanted 129948 found 122929
>> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): par=
ent transid verify failed on 576192512 wanted 129948 found 122929
>> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): par=
ent transid verify failed on 576192512 wanted 129948 found 122929
>> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): par=
ent transid verify failed on 576192512 wanted 129948 found 122929
>> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): par=
ent transid verify failed on 576192512 wanted 129948 found 122929
>> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): par=
ent transid verify failed on 576192512 wanted 129948 found 122929
>> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): par=
ent transid verify failed on 576192512 wanted 129948 found 122929
>> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): par=
ent transid verify failed on 576192512 wanted 129948 found 122929
>> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): par=
ent transid verify failed on 576192512 wanted 129948 found 122929
>
> This is definitely not just *some* metadata didn't reach disk, but
> *tons* of metadata didn't reach disk.
>
> All expected transid > found transid.
>
> Almost certain the RAID card is doing something incorrectly related to
> FLUSH.
>
>>
>> ls: cannot access '/mnt/@': Input/output error
>> ls: cannot access '/mnt/@_daily.20220525_00:11:01': Input/output error
>> ls: cannot access '/mnt/@_daily.20220526_00:11:01': Input/output error
>> ls: cannot access '/mnt/@_hourly.20220526_06:00:01': Input/output error
>> ls: cannot access '/mnt/@_hourly.20220526_09:00:01': Input/output error
>> ls: cannot access '/mnt/@_hourly.20220526_12:00:01': Input/output error
>> total 0
>> d????????? ? ?    ?      ?            ? @
>> drwxrwxr-x 1 root 1000 204 May 15 16:27 @_daily.20220523_00:11:01
>> drwxrwxr-x 1 root 1000 204 May 15 16:27 @_daily.20220524_00:11:01
>> d????????? ? ?    ?      ?            ? @_daily.20220525_00:11:01
>> d????????? ? ?    ?      ?            ? @_daily.20220526_00:11:01
>> d????????? ? ?    ?      ?            ? @_hourly.20220526_06:00:01
>> d????????? ? ?    ?      ?            ? @_hourly.20220526_09:00:01
>> d????????? ? ?    ?      ?            ? @_hourly.20220526_12:00:01
>> drwxrwxr-x 1 root 1000 184 Dec 16  2021 @_weekly.20220424_00:12:01
>> drwxrwxr-x 1 root 1000 184 Dec 16  2021 @_weekly.20220508_00:12:01
>> drwxrwxr-x 1 root 1000 184 Dec 16  2021 @_weekly.20220515_00:12:01
>> drwxrwxr-x 1 root 1000 204 May 15 16:27 @_weekly.20220522_00:12:01
>>
>> So it appears that there may be recoverable sub-volumes there ...
>>
>> So if I can remount it rw after having mounted it ro,rescue=3Dall I sho=
uld be able to delete the broken subvolumes and rename one of the @daily o=
r @weekly ones that appear OK?
>
> Nope, rescue=3Dall is really just let you to grab what you can, the fs h=
as
> so many transid mismatch, is definitely no way to save.
>
> And I strongly recommend to do more testing on that RAID5 card later
> (for power loss tests).
> That card doesn't sound cheap at all, and if such card doesn't do FLUSH
> correctly, the vendor really deserve tons of blame.
>
> Or it can be the HDDs? Mind to provide the model too?
>
> Thanks,
> Qu
>
>>
>> Or can I manipulate the subvolumes even if it is mounted ro?
>>
>> Your guidance will be most welcome
>>
>> D.
>>
>> -----Original Message-----
>> From: David C. Partridge <david.partridge@perdrix.co.uk>
>> Sent: 19 June 2022 13:54
>> To: 'Qu Wenruo' <quwenruo.btrfs@gmx.com>; linux-btrfs@vger.kernel.org
>> Subject: RE: Problems with BTRFS formatted disk
>>
>> Here's what the 2022.06.01 version of Archlinux had to say in the log w=
hen I issued:
>>
>> mount -t btrfs -o rescue=3Dall /dev/sdc1 /mnt
>>
>> Jun 19 12:43:01 archiso kernel: BTRFS info (device sdc1): flagging fs w=
ith big metadata feature
>> Jun 19 12:43:01 archiso kernel: BTRFS info (device sdc1): enabling all =
of the rescue options
>> Jun 19 12:43:01 archiso kernel: BTRFS info (device sdc1): ignoring data=
 csums
>> Jun 19 12:43:01 archiso kernel: BTRFS info (device sdc1): ignoring bad =
roots
>> Jun 19 12:43:01 archiso kernel: BTRFS info (device sdc1): disabling log=
 replay at mount time
>> Jun 19 12:43:01 archiso kernel: BTRFS error (device sdc1): nologreplay =
must be used with ro mount option
>> Jun 19 12:43:01 archiso kernel: BTRFS error (device sdc1): open_ctree f=
ailed
>>
>> Did I need to say:
>>
>> mount -t btrfs -o ro,rescue=3Dall /dev/sdc1 /mnt
>>
>> D.
>>
>> -----Original Message-----
>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>> Sent: 19 June 2022 12:51
>> To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vge=
r.kernel.org
>> Subject: Re: Problems with BTRFS formatted disk
>>
>>
>>
>> On 2022/6/19 19:14, David C. Partridge wrote:
>>> LUbuntu 22.04 was definitely 5.15 kernel, what alternative distro do y=
ou propose I use?
>>
>> I have no idea why 22.04 doesn't work here.
>>
>> The upstream commit is 2b29726c473b ("btrfs: rescue: allow ibadroots to
>> skip bad extent tree when reading block group items"), which is already
>> in v5.15 kernels.
>>
>> I double checked the current code base, as long as it's error reading
>> the block group items and rescue=3Dall (implies ibadroots), it should g=
o
>> fill_dummy_bgs().
>>
>> For the alternative distros, OpenSUSE tumbleweed, Archlinux, etc. As
>> they are definitely upstream and v5.15+.
>>
>> For example, Archlinux 2022.06.01, it goes with 5.18 kernel:
>>
>> $ file arch/boot/x86_64/vmlinuz-linux
>> arch/boot/x86_64/vmlinuz-linux: Linux kernel x86 boot executable
>> bzImage, version 5.18.1-arch1-1 (linux@archlinux) #1 SMP PREEMPT_DYNAMI=
C
>> Mon, 30 May 2022 17:53:11 +0000, RO-rootFS, swap_dev 0XA, Normal VGA
>>
>> If that still doesn't work, let me creating a similar fs with some bloc=
k
>> groups items corrupted to see why it doesn't work.
>>
>> Thanks,
>> Qu
>>>
>>> -----Original Message-----
>>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>>> Sent: 19 June 2022 11:41
>>> To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vg=
er.kernel.org
>>> Subject: Re: Problems with BTRFS formatted disk
>>>
>>>
>>>
>>> On 2022/6/19 18:29, David C. Partridge wrote:
>>>> Booted from live USB 22.04 LUbuntu.
>>>
>>> Ubuntu kernel version doesn't seem to be that consistent even for its
>>> LTS releases:
>>>
>>> https://ubuntu.com/about/release-cycle#ubuntu-kernel-release-cycle
>>>
>>> Please use something rolling released distro/branch instead.
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> root@lubuntu:/home/lubuntu# mount -t btrfs -o rescue=3Dall /dev/sdc1 =
/mnt
>>>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdc1, =
missing codepage or helper program, or other error.
>>>> root@lubuntu:/home/lubuntu#
>>>>
>>>> Content of system journal
>>>>
>>>> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): flagging fs=
 with big metadata feature
>>>> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): disk space =
caching is enabled
>>>> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): has skinny =
extents
>>>> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): parent tra=
nsid verify failed on 12554992156672 wanted 130582 found 127355
>>>> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): parent tra=
nsid verify failed on 12554992156672 wanted 130582 found 127355
>>>> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): failed to =
read block groups: -5
>>>> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): open_ctree=
 failed
>>>>
>>>> David
>>>>
>>>> -----Original Message-----
>>>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>>>> Sent: 19 June 2022 03:02
>>>> To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@v=
ger.kernel.org
>>>> Subject: Re: Problems with BTRFS formatted disk
>>>>
>>>>>> You can try rescue=3Dall mount option, which has the extra handling=
 on
>>>>>> corrupted extent tree.
>>>>>
>>>>>> Although you have to use kernels newer than v5.15 (including v5.15)=
 to
>>>>>> benefit from the change.
>>>>>
>>>>> Unfortunately:
>>>>> amonra@charon:~$ uname -a
>>>>> Linux charon 5.4.0-113-generic #127-Ubuntu SMP Wed May 18 14:30:56 U=
TC 2022 x86_64 x86_64 x86_64 GNU/Linux
>>>>
>>>> Any special reason that you can not even use a liveUSB to boot a newe=
r
>>>> kernel to do the salvage?
>>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>
>>
>
