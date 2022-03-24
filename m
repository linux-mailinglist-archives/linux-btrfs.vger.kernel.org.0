Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7834E64B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 15:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbiCXOIz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 10:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiCXOIz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 10:08:55 -0400
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6027AC04D
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 07:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.com;
        s=dbd5af2cbaf7; t=1648130840;
        bh=U2Vfd7d5XwUTMhQQejT9f463EncrgSBUI/sZ7r2Mi3M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=0EtwZrmGd+J038+OIGMJ3ysS4YLB9K2Pkw3d0RccLFcgQbIMhDEEyptRjtqnc37Wh
         PhxDvx+xp9TIvQxmrKQnqwvH1hwMq2ZcgyjtozuDL9d4xb0fqqa5TQbA5AFJED155/
         AilE5a4E/p6E17G0/Oj5wKyE4+Cxh/60KYQICoSo=
X-UI-Sender-Class: 214d933f-fd2f-45c7-a636-f5d79ae31a79
Received: from [88.156.136.188] ([88.156.136.188]) by web-mail.mail.com
 (3c-app-mailcom-lxa01.server.lan [10.76.45.2]) (via HTTP); Thu, 24 Mar 2022
 15:07:20 +0100
MIME-Version: 1.0
Message-ID: <trinity-08eddd3b-de79-4a7b-8cd1-2f2ead6f7513-1648130840007@3c-app-mailcom-lxa01>
From:   Joseph Spagnol <joseph.spagnol@programmer.net>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: failed to read block groups: Input/output error; bad tree block
 - bytenr mismatch;
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 24 Mar 2022 15:07:20 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <9d942b5b-f52b-b3bc-954f-710abc9ce556@gmx.com>
References: <trinity-58cb51fa-9b3e-4fd0-9ff7-29da0dd13e14-1647953588232@3c-app-mailcom-lxa08>
 <f1159186-c73d-5102-549d-8e343f1bca0d@gmx.com>
 <trinity-56388cba-8de1-43e3-8e32-a8f8b6d0d246-1647969466534@3c-app-mailcom-lxa08>
 <9d942b5b-f52b-b3bc-954f-710abc9ce556@gmx.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:rMWXvkz7cZosyszLFjaYp1ppCgEe+1dfqzvAI3t1rACBVjjn1K2hxk15TE8G9GXi/9i4g
 uvSKCo4J9KmwoPUMEW26zuW9eTf3R9VaV8GHa4CFMq6LBKFqdWI5l/Yd2FKOFBuaSKXj+sB8SF2c
 F7MCWLoVeMJF8rql/H+xUjG07R+uZLaPJkGJOI47JQBKVtJySVgNBjwX6GLdWovmbjtzE7Geb8iU
 iWkjYRAV3QBcNfvnDXLE+QyJ6g7J6kCvf+Vxv7d50oS7889wgBCVouUg/ofRhIwNmwAKiINs7vCk
 M4=
X-UI-Out-Filterresults: notjunk:1;V03:K0:J7MCvDpEgJ0=:7THt0rC3x7Y2a06ymLGfPO
 fu28EMLlEPEdczw3J+VNWO+jV6p9D1c9o8tFFh2B5b/T7ONwh73zkJyZtx6uV4VLcSWc4xLzz
 ldnWjTJRyVDM4wSv8gqQcv6flCGRW1sdtanRyGSxL18sOqBMaptTGfQtyXxL9Meh6dVNjLRq/
 GPaSvuFYcVirNXNr5Wa29/5iRGXs49kCjW1RZcdukRtEGzuMK9To94t6RtSfb8wk4prVN3Xet
 jPt8UmC8bBVNRuoaFuvaCid1P9NFG5cwzbj8ac0vLM7JdcMyKLtUv+YqvAXnd0rpoaVzAbAbX
 CfrXzONYDJBKBIeOj7nTdlrw13PAdpnTg7CAMzx+E5PQIpuhEV5UqnYevbPL34NwT1Q6Y2+7R
 WPj6+iZ6Cr5Tb8+tAFOZC5xy/TZTaUGvF4V6x5Qk8yFrQDStR6y5KhCp/ga1VHkkzxDOwL9P3
 dMsXsAL8IAZJOsEQXE2aE+v2cjFBhH9ZHJxQJbxTupkYpmb3dOANI+95A2k5lAT9JgTESOfGl
 2EIJbpthDMVsWdHqE0mlhsRtKRNEdfO0ppAIEoiDPNp2K66WpQpPs6bXICuUJ2y3mqUy2VTX7
 FFwGz1gUbB5VpRjcZdTzrINJAYwVzFrqwVV3hNh1m80EnbU3JNcyRqDUakx1EoKvqVYGoqFqb
 i1mQ/cXQTwnHe59lpYybw11+TEPLJe6p+nnFCUiIYMgXRs0kC2NlkPHPWgluXPIU58dRwU6s7
 gYcR+GkrmcwOLzGgARJAB+INrCUkRiimAoOt4bC6j1T+VHtiydXbcavNknhrl90lDqZQYJ/MR
 Dj+7WL+Tq7m8jfkhbNp3xAK9Oc19Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello again,

> # uname -r
> 5=2E16=2E11-1-default
> # mount -t btrfs -o rescue=3Dall,ro /dev/sda4 /mnt/
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda4, mis=
sing codepage or helper program, or other error=2E

> Dmesg please=2E
Here is the dmesg

[21560=2E215563] BTRFS info (device sda3): flagging fs with big metadata f=
eature
[21560=2E215570] BTRFS info (device sda3): disk space caching is enabled
[21560=2E215572] BTRFS info (device sda3): has skinny extents
[21560=2E218654] BTRFS info (device sda3): bdev /dev/sda3 errs: wr 0, rd 0=
, flush 0, corrupt 3181, gen 0
[21560=2E229756] BTRFS info (device sda3): enabling ssd optimizations
[87063=2E535960] BTRFS info (device nvme0n1p4): qgroup scan completed (inc=
onsistency flag cleared)
[161387=2E456900] BTRFS info (device sda4): flagging fs with big metadata =
feature
[161387=2E456905] BTRFS info (device sda4): disk space caching is enabled
[161387=2E456906] BTRFS info (device sda4): has skinny extents
[161387=2E458569] BTRFS error (device sda4): bad tree block start, want 23=
235280896 have 0
[161387=2E458584] BTRFS warning (device sda4): couldn't read tree root
[161387=2E458847] BTRFS error (device sda4): open_ctree failed
[161620=2E891324] BTRFS info (device sda4): flagging fs with big metadata =
feature
[161620=2E891336] BTRFS info (device sda4): enabling all of the rescue opt=
ions
[161620=2E891338] BTRFS info (device sda4): ignoring data csums
[161620=2E891340] BTRFS info (device sda4): ignoring bad roots
[161620=2E891342] BTRFS info (device sda4): disabling log replay at mount =
time
[161620=2E891345] BTRFS info (device sda4): disk space caching is enabled
[161620=2E891347] BTRFS info (device sda4): has skinny extents
[161620=2E893575] BTRFS error (device sda4): bad tree block start, want 23=
235280896 have 0
[161620=2E893599] BTRFS warning (device sda4): couldn't read tree root
[161620=2E894212] BTRFS error (device sda4): open_ctree failed

> Am not sure this can help but this btrfs partition become like this afte=
r a sudden system freeze=2E

> Without dmesg of that incident, pretty hard to say=2E
I'm not sure I am able to retrieve this, but I will try=2E

> Did you changed the partition size without using btrfs device resize?
On the following boot I had a disk check and it asked for a resize and I e=
xecuted it but it was not on the failed partition which at that moment I ha=
d no clue it was failed=2E

Thanks
Joseph

Sent:=C2=A0Wednesday, March 23, 2022 at 12:39 AM
From:=C2=A0"Qu Wenruo" <quwenruo=2Ebtrfs@gmx=2Ecom>
To:=C2=A0"Joseph Spagnol" <joseph=2Espagnol@programmer=2Enet>
Cc:=C2=A0linux-btrfs@vger=2Ekernel=2Eorg
Subject:=C2=A0Re: failed to read block groups: Input/output error; bad tre=
e block - bytenr mismatch;

On 2022/3/23 01:17, Joseph Spagnol wrote:
> Hello, thanks for the quick response=2E
> unfortunately the ro mount from a more recent kernel does not work as we=
ll
>
> # uname -r
> 5=2E16=2E11-1-default
> # mount -t btrfs -o rescue=3Dall,ro /dev/sda4 /mnt/
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda4, mis=
sing codepage or helper program, or other error=2E

Dmesg please=2E

But I guess there are more errors on the critical trees, thus it failed=2E

>
> Am not sure this can help but this btrfs partition become like this afte=
r a sudden system freeze=2E

Without dmesg of that incident, pretty hard to say=2E

>
> Is there a possibility to check an fix the partition size?
> I believe it could be an issue with the actual size of the partition/par=
titions=2E

Not sure what you mean here=2E

Did you changed the partition size without using btrfs device resize?

Thanks,
Qu

>
> Sent:=C2=A0Tuesday, March 22, 2022 at 2:05 PM
> From:=C2=A0"Qu Wenruo" <quwenruo=2Ebtrfs@gmx=2Ecom>
> To:=C2=A0"Joseph Spagnol" <joseph=2Espagnol@programmer=2Enet>, linux-btr=
fs@vger=2Ekernel=2Eorg
> Subject:=C2=A0Re: failed to read block groups: Input/output error; bad t=
ree block - bytenr mismatch;
>
> On 2022/3/22 20:53, Joseph Spagnol wrote:
>> Hello, recently one of my btrfs partitions has become unavailable and a=
m not able to mount it=2E
>>
>> # mount -t btrfs /dev/sda4 /mnt/
>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda4, mi=
ssing codepage or helper program, or other error=2E
>>
>> # btrfs-find-root /dev/sda4
>> Couldn't read tree root
>> Superblock thinks the generation is 432440
>> Superblock thinks the level is 1
>> Well block 23235313664(gen: 432440 level: 0) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23231447040(gen: 432439 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23229202432(gen: 432438 level: 0) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23192911872(gen: 432431 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23177084928(gen: 432430 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23149035520(gen: 432429 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23124443136(gen: 432427 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23113547776(gen: 432426 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23080730624(gen: 432425 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23048241152(gen: 432424 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> Well block 23013031936(gen: 432422 level: 1) seems good, but generation=
/level doesn't match, want gen: 432440 level: 1
>> =2E=2E=2E=2E=2E=2E=2E
>>
>> # btrfsck -b -p /dev/sda4
>> Opening filesystem to check=2E=2E=2E
>> checksum verify failed on 23234035712 wanted 0x00000000 found 0x0810faf=
8
>> checksum verify failed on 23234035712 wanted 0x00000000 found 0x0810faf=
8
>> bad tree block 23234035712, bytenr mismatch, want=3D23234035712, have=
=3D0
>
> Some range is completely wiped out=2E
> And that wiped out range is in extent tree=2E
>
>
> There are several two theories for it:
>
> - Some discard related bug
> It can be the firmware of disk, or btrfs itself=2E
> Some range got wiped out even we're still needing it=2E
>
> - Some missing writes
> The write should reach disk but didn't=2E
> This means the barrier is not working=2E
> In that case, disk firmware may be the problem=2E
>
>
>> ERROR: failed to read block groups: Input/output error
>> ERROR: cannot open file system
>>
>> Here are some more details;
>> # uname -a
>> Linux msi-b17-manjaro 5=2E4=2E184-1-MANJARO #1 SMP PREEMPT Fri Mar 11 1=
3:59:07 UTC 2022 x86_64 GNU/Linux
>> # btrfs --version
>> btrfs-progs v5=2E16=2E2
>> # btrfs fi show
>> Label: 'OLDDATA' uuid: 9bc104b4-c889-477f-aae1-4d865cdc0372
>> Total devices 1 FS bytes used 34=2E20GiB
>> devid 1 size 50=2E00GiB used 37=2E52GiB path /dev/sda3
>> Label: 'OPENSUSE' uuid: c3632d30-a117-43ef-8993-88f1933f6676
>> Total devices 1 FS bytes used 24=2E60GiB
>> devid 1 size 150=2E00GiB used 31=2E05GiB path /dev/nvme0n1p4
>> Label: 'DATA' uuid: 4ce61b29-8c8d-4c04-b715-96f0dda809a4
>> Total devices 1 FS bytes used 118=2E67GiB
>> devid 1 size 200=2E00GiB used 122=2E02GiB path /dev/sda4
>> # btrfs fi df /dev/sda4
>> ERROR: not a directory: /dev/sda4
>> # btrfs fi df /data/
>> ERROR: not a btrfs filesystem: /data/
>> ## dmesg=2Elog ##
>> [65500=2E890756] BTRFS info (device sda4): flagging fs with big metadat=
a feature
>> [65500=2E890766] BTRFS warning (device sda4): 'recovery' is deprecated,=
 use 'usebackuproot' instead
>> [65500=2E890768] BTRFS info (device sda4): trying to use backup root at=
 mount time
>> [65500=2E890771] BTRFS info (device sda4): disabling disk space caching
>> [65500=2E890773] BTRFS info (device sda4): force clearing of disk cache
>> [65500=2E890775] BTRFS info (device sda4): has skinny extents
>> [65500=2E893556] BTRFS error (device sda4): bad tree block start, want =
23235280896 have 0
>> [65500=2E893593] BTRFS warning (device sda4): failed to read tree root
>> [65500=2E893852] BTRFS error (device sda4): bad tree block start, want =
23235280896 have 0
>> [65500=2E893856] BTRFS warning (device sda4): failed to read tree root
>> [65500=2E908097] BTRFS error (device sda4): bad tree block start, want =
23234035712 have 0
>> [65500=2E908111] BTRFS error (device sda4): failed to read block groups=
: -5
>> [65500=2E963167] BTRFS error (device sda4): open_ctree failed
>>
>> P=2ES=2E I must say that I get the same results when I try to mount the=
 partition from another linux system OpenSuse tumbleweed
>
> There are already at least two tree blocks got wiped=2E
>
> I won't be surprised if there are more=2E
>
> For now, only data salvage can be even attempted=2E
>
> Using newer enough kernel (like from openSUSE tumbleweed), then mount
> with -o rescue=3Dall,ro to see if it can be mounted=2E
>
> That's more or less the same as btrfs-restore, but more convenient to
> copy things out=2E
>
> Thanks,
> Qu
>>
>> Is there any way I could rebuild the tree?
>>
>> Thanks in advance
>> Joseph
>>
>>
