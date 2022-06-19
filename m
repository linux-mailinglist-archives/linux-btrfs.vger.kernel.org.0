Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FBD550B21
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 16:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiFSOQB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 19 Jun 2022 10:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiFSOQA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 10:16:00 -0400
Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998E9BC00
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 07:15:57 -0700 (PDT)
Received: from APOLLO ([212.159.61.44])
        by smtp with ESMTPA
        id 2viUoae25Pl3K2viVoQ9o9; Sun, 19 Jun 2022 15:15:56 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Uo9wis8B c=1 sm=1 tr=0 ts=62af2f9c
 a=AGp1duJPimIJhwGXxSk9fg==:117 a=AGp1duJPimIJhwGXxSk9fg==:17
 a=IkcTkHD0fZMA:10 a=7YfXLusrAAAA:8 a=P1kZ4gAsAAAA:8 a=VwQbUJbxAAAA:8
 a=fxJcL_dCAAAA:8 a=cM3NDQbc_4el9DafbmYA:9 a=QEXdDO2ut3YA:10
 a=SLz71HocmBbuEhFRYD3r:22 a=fn9vMg-Z9CMH7MoVPInU:22 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: perdrix52@:2500
From:   "David C. Partridge" <david.partridge@perdrix.co.uk>
To:     "'Qu Wenruo'" <quwenruo.btrfs@gmx.com>,
        <linux-btrfs@vger.kernel.org>
References: <001f01d88344$ed8aa1d0$c89fe570$@perdrix.co.uk> <603196b9-fa55-f5cc-d9b5-3cf69f19c6ef@gmx.com> <000001d8837c$91bc74e0$b5355ea0$@perdrix.co.uk> <838a65c7-214b-adc1-2c9e-3923da6575e2@gmx.com> <000001d883c7$698edad0$3cac9070$@perdrix.co.uk> <e7c18d33-4807-7d6f-53f5-6e3f59b687ef@gmx.com> <000401d883cd$cc588fc0$6509af40$@perdrix.co.uk> <393cf34a-0ae9-d34c-b2bb-ea74d906dfa5@gmx.com> <000201d883db$a22686e0$e67394a0$@perdrix.co.uk> <000901d883e0$289d73b0$79d85b10$@perdrix.co.uk> <b8579f1c-a277-2a01-2126-77ffcc0ab2d5@gmx.com>
In-Reply-To: <b8579f1c-a277-2a01-2126-77ffcc0ab2d5@gmx.com>
Subject: RE: Problems with BTRFS formatted disk
Date:   Sun, 19 Jun 2022 15:15:54 +0100
Message-ID: <000c01d883e7$1757e570$4607b050$@perdrix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE6G7yNOJVUJ6Zum7z6uCsu/gieNwG3iWv+Afjb+GUCCjux4wI0aTcjAwQd14sByWWhmwIjQYotAgDDGGgCPmdhdAFAo2axrfCYP8A=
Content-Language: en-gb
X-CMAE-Envelope: MS4xfH+d+EtH56XhRJVa+IDw1b5MAi/+MBXqeMBVpo1/GKqK9aZvZ2LiPMZIjgV3Iy0GS32YSyYFwxbeP4pYlzjk+34IEIR75iLENcA3tEjF525FbAaEATp1
 gbyAK6q9El5yGxGsmrUMtdAizueodl6bA/kovoMJgxuhGg6uA0MBgnkkTADVV043Z0Ex/SSYOvXF2uV8Q4M29+kg7KtUL1bD5B8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I can't "grab what I can" as I don't have enough TB to copy the data I want to save ☹

Does it make any sense to try:

 mount -o remount,rw /mnt
 btrfs subvolume delete /mnt/@
 btrfs subvolume delete /mnt/@_daily.20220525_00:11:01
 btrfs subvolume delete /mnt/@_daily.20220526_00:11:01
 btrfs subvolume delete /mnt/@_hourly.20220526_06:00:01
 btrfs subvolume delete /mnt/@_hourly.20220526_09:00:01
 btrfs subvolume delete /mnt/@_hourly.20220526_12:00:01

 mv /mnt/@_daily.20220524_00:11:01 /mnt/@

or is that doomed to total failure?

The disks behind the raid card are all Western Digital WD4001FYYG SAS drives

David


-----Original Message-----
From: Qu Wenruo <quwenruo.btrfs@gmx.com> 
Sent: 19 June 2022 14:31
To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vger.kernel.org
Subject: Re: Problems with BTRFS formatted disk



On 2022/6/19 21:26, David C. Partridge wrote:
> Aha this is much more interesting:
>
> I issued: mount -t btrfs -o ro,rescue=all /dev/sdc1 /mnt
>
> And got this in the system log:
>
> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): flagging fs with big metadata feature
> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): enabling all of the rescue options
> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): ignoring data csums
> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): ignoring bad roots
> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): disabling log replay at mount time
> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): disk space caching is enabled
> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): has skinny extents
> Jun 19 13:04:32 archiso kernel: BTRFS error (device sdc1: state C): parent transid verify failed on 12554992156672 wanted 130582 found 127355
> Jun 19 13:04:32 archiso kernel: BTRFS error (device sdc1: state C): parent transid verify failed on 12554992156672 wanted 130582 found 127355
> Jun 19 13:05:12 archiso systemd[1]: dev-virtio\x2dports-org.qemu.guest_agent.0.device: Job dev-virtio\x2dports-org.qemu.guest_agent.0.device/start timed out.
> Jun 19 13:05:12 archiso systemd[1]: Timed out waiting for device /dev/virtio-ports/org.qemu.guest_agent.0.
> Jun 19 13:05:12 archiso systemd[1]: Dependency failed for QEMU Guest Agent.
> Jun 19 13:05:12 archiso systemd[1]: qemu-guest-agent.service: Job qemu-guest-agent.service/start failed with result 'dependency'.
> Jun 19 13:05:12 archiso systemd[1]: dev-virtio\x2dports-org.qemu.guest_agent.0.device: Job dev-virtio\x2dports-org.qemu.guest_agent.0.device/start failed with result 'timeout'.
> Jun 19 13:05:12 archiso systemd[1]: Reached target Multi-User System.
> Jun 19 13:05:12 archiso systemd[1]: Reached target Graphical Interface.
> Jun 19 13:05:12 archiso systemd[1]: Startup finished in 1min 4.847s (firmware) + 4.837s (loader) + 9.433s (kernel) + 1min 31.546s (userspace) = 2min 50.664s.
> Jun 19 13:05:38 archiso kernel: BTRFS info (device sda2): flagging fs with big metadata feature
> Jun 19 13:05:38 archiso kernel: BTRFS info (device sda2): disk space caching is enabled
> Jun 19 13:05:38 archiso kernel: BTRFS info (device sda2): has skinny extents
> Jun 19 13:05:38 archiso kernel: BTRFS info (device sda2): enabling ssd optimizations
>
> ll /mnt got me this:
>
> Jun 19 13:08:13 archiso kernel: verify_parent_transid: 4 callbacks suppressed
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): parent transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): parent transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): parent transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): parent transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): parent transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): parent transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): parent transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): parent transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): parent transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): parent transid verify failed on 576192512 wanted 129948 found 122929

This is definitely not just *some* metadata didn't reach disk, but
*tons* of metadata didn't reach disk.

All expected transid > found transid.

Almost certain the RAID card is doing something incorrectly related to
FLUSH.

>
> ls: cannot access '/mnt/@': Input/output error
> ls: cannot access '/mnt/@_daily.20220525_00:11:01': Input/output error
> ls: cannot access '/mnt/@_daily.20220526_00:11:01': Input/output error
> ls: cannot access '/mnt/@_hourly.20220526_06:00:01': Input/output error
> ls: cannot access '/mnt/@_hourly.20220526_09:00:01': Input/output error
> ls: cannot access '/mnt/@_hourly.20220526_12:00:01': Input/output error
> total 0
> d????????? ? ?    ?      ?            ? @
> drwxrwxr-x 1 root 1000 204 May 15 16:27 @_daily.20220523_00:11:01
> drwxrwxr-x 1 root 1000 204 May 15 16:27 @_daily.20220524_00:11:01
> d????????? ? ?    ?      ?            ? @_daily.20220525_00:11:01
> d????????? ? ?    ?      ?            ? @_daily.20220526_00:11:01
> d????????? ? ?    ?      ?            ? @_hourly.20220526_06:00:01
> d????????? ? ?    ?      ?            ? @_hourly.20220526_09:00:01
> d????????? ? ?    ?      ?            ? @_hourly.20220526_12:00:01
> drwxrwxr-x 1 root 1000 184 Dec 16  2021 @_weekly.20220424_00:12:01
> drwxrwxr-x 1 root 1000 184 Dec 16  2021 @_weekly.20220508_00:12:01
> drwxrwxr-x 1 root 1000 184 Dec 16  2021 @_weekly.20220515_00:12:01
> drwxrwxr-x 1 root 1000 204 May 15 16:27 @_weekly.20220522_00:12:01
>
> So it appears that there may be recoverable sub-volumes there ...
>
> So if I can remount it rw after having mounted it ro,rescue=all I should be able to delete the broken subvolumes and rename one of the @daily or @weekly ones that appear OK?

Nope, rescue=all is really just let you to grab what you can, the fs has
so many transid mismatch, is definitely no way to save.

And I strongly recommend to do more testing on that RAID5 card later
(for power loss tests).
That card doesn't sound cheap at all, and if such card doesn't do FLUSH
correctly, the vendor really deserve tons of blame.

Or it can be the HDDs? Mind to provide the model too?

Thanks,
Qu

>
> Or can I manipulate the subvolumes even if it is mounted ro?
>
> Your guidance will be most welcome
>
> D.
>
> -----Original Message-----
> From: David C. Partridge <david.partridge@perdrix.co.uk>
> Sent: 19 June 2022 13:54
> To: 'Qu Wenruo' <quwenruo.btrfs@gmx.com>; linux-btrfs@vger.kernel.org
> Subject: RE: Problems with BTRFS formatted disk
>
> Here's what the 2022.06.01 version of Archlinux had to say in the log when I issued:
>
> mount -t btrfs -o rescue=all /dev/sdc1 /mnt
>
> Jun 19 12:43:01 archiso kernel: BTRFS info (device sdc1): flagging fs with big metadata feature
> Jun 19 12:43:01 archiso kernel: BTRFS info (device sdc1): enabling all of the rescue options
> Jun 19 12:43:01 archiso kernel: BTRFS info (device sdc1): ignoring data csums
> Jun 19 12:43:01 archiso kernel: BTRFS info (device sdc1): ignoring bad roots
> Jun 19 12:43:01 archiso kernel: BTRFS info (device sdc1): disabling log replay at mount time
> Jun 19 12:43:01 archiso kernel: BTRFS error (device sdc1): nologreplay must be used with ro mount option
> Jun 19 12:43:01 archiso kernel: BTRFS error (device sdc1): open_ctree failed
>
> Did I need to say:
>
> mount -t btrfs -o ro,rescue=all /dev/sdc1 /mnt
>
> D.
>
> -----Original Message-----
> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Sent: 19 June 2022 12:51
> To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vger.kernel.org
> Subject: Re: Problems with BTRFS formatted disk
>
>
>
> On 2022/6/19 19:14, David C. Partridge wrote:
>> LUbuntu 22.04 was definitely 5.15 kernel, what alternative distro do you propose I use?
>
> I have no idea why 22.04 doesn't work here.
>
> The upstream commit is 2b29726c473b ("btrfs: rescue: allow ibadroots to
> skip bad extent tree when reading block group items"), which is already
> in v5.15 kernels.
>
> I double checked the current code base, as long as it's error reading
> the block group items and rescue=all (implies ibadroots), it should go
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
>> To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vger.kernel.org
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
>>> root@lubuntu:/home/lubuntu# mount -t btrfs -o rescue=all /dev/sdc1 /mnt
>>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdc1, missing codepage or helper program, or other error.
>>> root@lubuntu:/home/lubuntu#
>>>
>>> Content of system journal
>>>
>>> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): flagging fs with big metadata feature
>>> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): disk space caching is enabled
>>> Jun 19 10:08:03 lubuntu kernel: BTRFS info (device sdc1): has skinny extents
>>> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): parent transid verify failed on 12554992156672 wanted 130582 found 127355
>>> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): parent transid verify failed on 12554992156672 wanted 130582 found 127355
>>> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): failed to read block groups: -5
>>> Jun 19 10:08:03 lubuntu kernel: BTRFS error (device sdc1): open_ctree failed
>>>
>>> David
>>>
>>> -----Original Message-----
>>> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
>>> Sent: 19 June 2022 03:02
>>> To: David C. Partridge <david.partridge@perdrix.co.uk>; linux-btrfs@vger.kernel.org
>>> Subject: Re: Problems with BTRFS formatted disk
>>>
>>>>> You can try rescue=all mount option, which has the extra handling on
>>>>> corrupted extent tree.
>>>>
>>>>> Although you have to use kernels newer than v5.15 (including v5.15) to
>>>>> benefit from the change.
>>>>
>>>> Unfortunately:
>>>> amonra@charon:~$ uname -a
>>>> Linux charon 5.4.0-113-generic #127-Ubuntu SMP Wed May 18 14:30:56 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
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

