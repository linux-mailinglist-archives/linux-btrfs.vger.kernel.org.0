Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553D73C7FA4
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 09:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbhGNIA1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 04:00:27 -0400
Received: from mout.gmx.net ([212.227.17.21]:51943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238341AbhGNIA1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 04:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626249454;
        bh=/sVPWwJQjn3qOPhtg2piXjdRX6fFv6BWEKRVijiZpNI=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=WddlL3h6UE+4DDPyduMi2UPKzvOnD51Rk6Wi+q2UkW2GPgkX5BLBuJZtszPXeUBce
         LBszeWNe8iNckBq+MonXckqnROOCZZdZE9HJ3STkP5YdEPdh1RZVuoQgx4fgKUuUKx
         gVtubB1UTvSlpiG9HBq4IErxlru8jMwRRtIbW1Lk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrQEx-1lOUSA2AJ5-00oVeI; Wed, 14
 Jul 2021 09:57:34 +0200
To:     DanglingPointer <danglingpointerexception@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <d0f8f74f-edd3-6591-c6e5-138daf6b25f5@gmail.com>
 <f68a2809-eb46-744f-7045-93eaeb4bb44f@gmx.com>
 <db80b801-9e7d-ce2b-15dd-84b30faf19cd@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Enhancement Idea - Optional PGO+LTO build for btrfs-progs
Message-ID: <2a29adba-8451-7550-a6f1-835be431953b@gmx.com>
Date:   Wed, 14 Jul 2021 15:57:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <db80b801-9e7d-ce2b-15dd-84b30faf19cd@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L0lFKpw8bkK3/muZiHX+jEvleO8mBlDyvZWE7UCoARw0dPM59Dj
 pa52n6M0MC+UBB53vBUEucUogBEyE7oFVuoQMcUhviKwvcp1Yvh6XbRJSBne933IRf0jebz
 8CnfGDKlIih7oA6Lh9UxBkR8ZY1TXU+Z/F7SIpC15Z8Ptor0nhJ50W/nC78SERdmR/dxaLd
 SNgku50Ax2/lglQPpCrMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:16AndmINrj8=:sMGbjaNBNZErjYw2uboNcB
 kT+QerZfyTnPQdylyd11H6YtPsiv3JwitsUZ4UL2KKWxhSHjuUBpQ0zwog8FM3skiraG4DN8n
 ebex0XOsj/szPuDkqvcceXLdimfBpSka7G927GJ6LUlsYJ+cPuW7ctLgmUJFw6KuKISSfXgR2
 +ykQ7CzcxqoGyzjGuoEUdTUAXOPmyI4kQ7wNhxHNGt8kj3WlXk05r8dppqQpXocTh46fLKoFj
 LyWF1rOh7AuAATjR2HHAaBpFnzYbmRZ/oNlkttaAzmbw+KqCpYu6cCp4ZSfe2PiqNnhKOVY+B
 qH7Zsc+DDiDPP2pLpjTqOM6RH0GicxHl4bkn3H6Ujw4Up1QtCYc4OBRZBHdoRFFPBEBifXCPU
 a3dGsx0XdkzpwPzOmb8TA+wbASnduFXaRjxzcB4Pf1/8LEbtPzcpWE0ChTCjugZ8m03UokC2Z
 L4ZwHlVMJNfZ96mRl1TD9yuTzr6okb6VNGgR8WxhBo3XZJ2maK8rtbjankdtWsv/gJveMqdda
 cgfNs4axhYiXnp6RIPoR93Q1fXoiDx0Cti2zKw1tL+I67YdqLenPR6Onr4zyNLDol7k1KX+ZY
 vneNuh1g7m8oQngGnAM7AlFf7Zol4gfmJ0Zv2ff3aHCPsP4ZujaJXkZH8QdV4YAVLZyJEkA3m
 ekOkQu8zzw/lXg8t9TP2xlfwFCBuKpp0b16l1CoyP8oyHUXxt9WB8siIZQ+6lvaApMM5OmCpJ
 wuJdYSqylJ9IzlPQZ7kf66io8grNeC1unHhlJzX2GZZluEzSdgDIdTHjIhrsQEvs3t8mk9Jdn
 Ujz0awr9mn49Jw5EU5bXCwFjL0uAo3N5F55lMMY7uREDJrBHPK1P6Ypw0leSNIqo9JULePzYR
 6+OJjzJ7Nyk1X8sn6kUzah0s5PF28h4t+Nhqz5l2IMYJ4rsyP8/jgT460Rbbj5lKrfn8pMqjI
 5qdd+XZbcf7v2Gf7o7v7f+lJoYOz680n+pdKZFn1dpfg9AsLBUYf2OHq4dWuUJolJsjYSVRwn
 +3cVD6PJcFXO5MapyvZpHpwV8Jcci0+e+fhGkjuVx5B9hoGKNeUoe1slTLO3rFtccsyo9dIrR
 I7jf5NHnNbtMitflUYIUdyqTBgr+SlE2inMoMnWm8P8M74En+tEHamcmw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/14 =E4=B8=8B=E5=8D=883:34, DanglingPointer wrote:
> "Why would you think btrfs-progs is the one needs to optimization?"
>
> Perhaps I should have written more context.=C2=A0 When the data migratio=
n was
> taking a very long time (days); and the pauses due to "btrfs-transacti"
> blocking all IO including nfsd.=C2=A0 We thought, "should we '$ btrfs sc=
rub
> <mount>' to make sure nothing had gone wrong?"
>
> Problem is, scrubbing on the whole RAID5 takes ages!

First thing first, if your system may hit unexpected power loss, or disk
corruption, it's highly recommended not to use btrfs RAID5.

(It's OK if you build btrfs upon soft/hard RAID5).

Btrfs raid5 has its write-hole problem, meaning each power loss/disk
corruption will slightly degrade the robustness of RAID5.

Without enough such small degradation, some corruption will no longer be
repairable.
Scrub is the way to rebuild the robustness, so great you're already
doing that, but I still won't recommend btrfs RAID5 for now, just as the
btrfs(5) man page shows.



Another reason why btrfs RAID5 scrub takes so long is, how we do full fs
scrub.

We initiate scrub for *each* device.

That means, if we have 4 disks, we will scrub all 4 disks separately.

For each device scrub, we need to read all the 4 stripes to also make
sure the parity stripe is also fine.

But in theory, we only need to read such RAID5 stripe once, then all
devices are covered.

So you see we waste quite some disk IO to do some duplicated check.

That's also another reason we recommend RAID1/RAID10.
During scrubbing of each device, we really only need to read from that
device, and only when its data is corrupted, we will try to read the
other copy.

This has no extra IO wasted.

Thanks,
Qu

>=C2=A0 If we did one disk
> of the array only it would at least sample a quarter of the array with a
> quarter chance of detecting if something/anything had gone wrong and
> hopefully won't massively slow down the on-going migration.
>
> We tried it for a while on the single drive and it did indeed have 2x
> the scrubbing throughput but it was still very slow since we're talking
> multi-terrabytes on the single disk!=C2=A0 I believe the ETA forecast wa=
s ~3
> days.
>
> Interestingly scrubbing the whole lot (whole RAID5 array) in one go by
> just scrubbing the mount point is a 4day ETA which we do regularly every
> 3 months.=C2=A0 So even though it is slower on each disk, it finishes th=
e
> whole lot faster than doing one disk at a time sequentially.
>
> Anyways, thanks for informing us on what btrfs-progs does and how 'scrub
> speed' is independent of btrfs-progs and done by the kernel ioctls (on
> the other email thread).
>
> regards,
>
> DP
>
> I thought btrfs scrub was part of btrfs-progs.=C2=A0 Pardon my ignorance=
 if
> it isn't.
>
>
> On 14/7/21 3:00 pm, Qu Wenruo wrote:
>>
>>
>> On 2021/7/14 =E4=B8=8A=E5=8D=8810:51, DanglingPointer wrote:
>>> Recently we have been impacted by some performance issues with the
>>> workstations in my lab with large multi-terabyte arrays in btrfs.=C2=
=A0 I
>>> have detailed this on a separate thread.=C2=A0 It got me thinking howe=
ver,
>>> why not have an optional configure option for btrfs-progs to use PGO
>>> against the entire suite of regression tests?
>>>
>>> Idea is:
>>>
>>> 1. configure with optional "-pgo" or "-fdo" option which will configur=
e
>>> =C2=A0=C2=A0=C2=A0 a relative path from source root where instrumentat=
ion files will go
>>> =C2=A0=C2=A0=C2=A0 (let's start with gcc only for now, so *.gcda files=
 into a folder).
>>> =C2=A0=C2=A0=C2=A0 We then add the instrumentation compiler option
>>> 2. build btrfs-progs
>>> 3. run every single tests available ( make test &&=C2=A0 make test-fsc=
k &&
>>> =C2=A0=C2=A0=C2=A0 make test-convert)
>>> 4. clean-up except for instrumentation files
>>> 5. re-build without the instrumentation flag from point 1; and use the
>>> =C2=A0=C2=A0=C2=A0 instrumentation files for feedback directed optimis=
ation (FDO) (for
>>> =C2=A0=C2=A0=C2=A0 gcc add additional partial-training flag); add LTO.
>>
>> Why would you think btrfs-progs is the one needs to optimization?
>>
>> From your original report, there is nothing btrfs-progs related at all.
>>
>> All your work, from scrub to IO, it's all handled by kernel btrfs modul=
e.
>>
>> Thus optimization of btrfs-progs would bring no impact.
>>
>> Thanks,
>> Qu
>>>
>>> I know btrfs is primarily IO bound and not cpu.=C2=A0 But just thinkin=
g of
>>> squeezing every last efficiency out of whatever is running in the cpu,
>>> cache and memory.
>>>
>>> I suppose people can do the above on their own, but was thinking if it
>>> was provided as a configuration optional option then it would make it
>>> easier for people to do without more hacking.=C2=A0 Just need to add w=
arnings
>>> that it will take a long time, have a coffee.
>>>
>>> The python3 configure process has the process above as an optional
>>> option but caters for gcc and clang (might even cater for icc).
>>>
>>> Anyways, that's my idea for an enhancement above.
>>>
>>> Would like to know your thoughts.=C2=A0 cheers...
>>>
