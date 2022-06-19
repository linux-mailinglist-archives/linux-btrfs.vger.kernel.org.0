Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B117E550ADD
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 15:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbiFSNay (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 09:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbiFSNay (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 09:30:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CA0BC29
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655645450;
        bh=rnGJYuNrhtqwNg4KdS34Ep8DMlQN5cWgx/mO35P2uzc=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=MPX2h7UrHdLZcRCCdz6eCV7qiF2oYQmls55RjVNAoUb6a7a+39DlJoHVpjI0js67O
         pyoaZEhzwpKrtihXgd56/UoPfvKYnLDBV/AtZzQHEDPZE8WpnaTX3gXYke+wyLnkGb
         vAoyqQ9z90rp5jw5GLNKwMnc4CddKLbwJNIjoquQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRmfi-1o90uR3KkE-00THVJ; Sun, 19
 Jun 2022 15:30:50 +0200
Message-ID: <b8579f1c-a277-2a01-2126-77ffcc0ab2d5@gmx.com>
Date:   Sun, 19 Jun 2022 21:30:46 +0800
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <000901d883e0$289d73b0$79d85b10$@perdrix.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+8yC46fB6Y8XwGS0ayLsCXz145/+SbxLmknZhzl+I6BZHZmSGjQ
 l3xxIUv4biapBxJEvx2QjeZEolqr726lVY8MZ3n0e1qUhzzjDRr7LjpxNBS7+59Ny2QX66k
 yJm262Cw2FnAI0TlOiM0YSnW/Jgo9dJqZTuvk5JodLhZmbDPWVt5kMzAwdb/MDX4ytI18d2
 WS5ReXMpjsi3NpvB1mFdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T48SobBc0dM=:YKuLcNOlhd/7jV7ahF8Miw
 zgvhbyklJAgAWY02Ybo8MC6b5N72Vgg98ohCOu7tB8/EJRTNJTIGPfbGeZ4UE9RYQrSt44xrm
 p9sSQDSzm85QOu37g34QW09pTx8y37u+fKNuOtegdAcf2EYUzFBv5Rz1zMecKLjTTgnZ9Zds9
 iPTPSS1gUoLBK8v65fi7f5ucf9PrpSvH83aDiSuotwQIRmPgJBHeIsOMj6akETnXuxD6XknKs
 9DqiHgUbP1c9S0XlhA2iMi42N2RDNGTdTNEuF3U8z0U7bcRImElb6Sq/PwMoaf0osYqVa2iVj
 WZf+zfHzTmFD0N23FvnVFZCeSkTNyMF8Zpe5cFzzDHF3JOq5Pw9w0IxNayXxmVPVj16wgY3GD
 JrBa8QSWRaeVDD/AT7uzV56vhmUPO8fYmgNbzzn6uGSGSyzBQYfIX+844Ynim0+wU8Nfwa8yb
 rQooTMRVqfGJC8f1tg+Vd1gBpwqFhRcTUCzV0FOIASaBZxHQkhkUEu84zf0+1pi54IV74JvWf
 uHwv+afRZcNzY2h00Wo+yHhUDb2H/EGGosct86Hg47pOVrT07s0wMJCjsMseT/j5x+BAemrjh
 ICrKr+YCbEmdZIrbY19xvIZf4D/l2shrmqc5i6NhVXtz/uzcHHEB442zRcun3yMWiKT0+4jzo
 XJ/E61lYoqR180Jr1SVn6DD0ff5pUVokGAnDEWMVHHZRiOF8aw3IAD/O2P7UWn3jT5nPxu7EA
 uk2Ats5Ld/7Qo6dLptW5CK1U8FaWUzSXCBoQSBDrmLY2dPvf66hCgWYp8X4XbU9GxmqYldlUr
 02wI0JabRjJX6MQjRm9i7u7LbcFeJkKRR34WU2Bqv4IfbEch9N1Btv8UbdLgNCHSOSzNnVr4R
 fEOTbsPinLN2Q0ei0Al89XuzwK/pSHZZt3JmddfVjGuq9V0TmT42IJ6xKGhC2dKeCBGWHgR/m
 4LvilH+V6b3oGpfJknNGPCg35Wzko8u+Y+Ys6D6+5psZWy0uzJjF41y8UnN7EOAhsSBLoLJDI
 R0jTPET+x2AVYnfSqj2jX22CW45JlvVfZGIB+TzTWXoSFOXt99B5kKL8n8ODfbPBwl0Gacl0s
 d4gov2XoEzvf4+XWcPswHnIGEwOrsE/qf1gIiYR8C6OECs5r/fOuHrQRw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/19 21:26, David C. Partridge wrote:
> Aha this is much more interesting:
>
> I issued: mount -t btrfs -o ro,rescue=3Dall /dev/sdc1 /mnt
>
> And got this in the system log:
>
> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): flagging fs wi=
th big metadata feature
> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): enabling all o=
f the rescue options
> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): ignoring data =
csums
> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): ignoring bad r=
oots
> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): disabling log =
replay at mount time
> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): disk space cac=
hing is enabled
> Jun 19 13:04:32 archiso kernel: BTRFS info (device sdc1): has skinny ext=
ents
> Jun 19 13:04:32 archiso kernel: BTRFS error (device sdc1: state C): pare=
nt transid verify failed on 12554992156672 wanted 130582 found 127355
> Jun 19 13:04:32 archiso kernel: BTRFS error (device sdc1: state C): pare=
nt transid verify failed on 12554992156672 wanted 130582 found 127355
> Jun 19 13:05:12 archiso systemd[1]: dev-virtio\x2dports-org.qemu.guest_a=
gent.0.device: Job dev-virtio\x2dports-org.qemu.guest_agent.0.device/start=
 timed out.
> Jun 19 13:05:12 archiso systemd[1]: Timed out waiting for device /dev/vi=
rtio-ports/org.qemu.guest_agent.0.
> Jun 19 13:05:12 archiso systemd[1]: Dependency failed for QEMU Guest Age=
nt.
> Jun 19 13:05:12 archiso systemd[1]: qemu-guest-agent.service: Job qemu-g=
uest-agent.service/start failed with result 'dependency'.
> Jun 19 13:05:12 archiso systemd[1]: dev-virtio\x2dports-org.qemu.guest_a=
gent.0.device: Job dev-virtio\x2dports-org.qemu.guest_agent.0.device/start=
 failed with result 'timeout'.
> Jun 19 13:05:12 archiso systemd[1]: Reached target Multi-User System.
> Jun 19 13:05:12 archiso systemd[1]: Reached target Graphical Interface.
> Jun 19 13:05:12 archiso systemd[1]: Startup finished in 1min 4.847s (fir=
mware) + 4.837s (loader) + 9.433s (kernel) + 1min 31.546s (userspace) =3D =
2min 50.664s.
> Jun 19 13:05:38 archiso kernel: BTRFS info (device sda2): flagging fs wi=
th big metadata feature
> Jun 19 13:05:38 archiso kernel: BTRFS info (device sda2): disk space cac=
hing is enabled
> Jun 19 13:05:38 archiso kernel: BTRFS info (device sda2): has skinny ext=
ents
> Jun 19 13:05:38 archiso kernel: BTRFS info (device sda2): enabling ssd o=
ptimizations
>
> ll /mnt got me this:
>
> Jun 19 13:08:13 archiso kernel: verify_parent_transid: 4 callbacks suppr=
essed
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): pare=
nt transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): pare=
nt transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): pare=
nt transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): pare=
nt transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): pare=
nt transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): pare=
nt transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): pare=
nt transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): pare=
nt transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): pare=
nt transid verify failed on 576192512 wanted 129948 found 122929
> Jun 19 13:08:13 archiso kernel: BTRFS error (device sdc1: state C): pare=
nt transid verify failed on 576192512 wanted 129948 found 122929

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
> So if I can remount it rw after having mounted it ro,rescue=3Dall I shou=
ld be able to delete the broken subvolumes and rename one of the @daily or=
 @weekly ones that appear OK?

Nope, rescue=3Dall is really just let you to grab what you can, the fs has
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
