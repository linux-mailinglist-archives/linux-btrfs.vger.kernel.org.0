Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23F54B0290
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 02:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiBJB4D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 20:56:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiBJBzn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 20:55:43 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DD528CFA
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 17:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644456970;
        bh=KuTPr7q6sCjohXNrKDw46mbo9i0c4ooS8dTrvqNyXm4=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=H2WwZ76zrjZd6u6X21LMe1lqeuaARsxPjJpkGvgFk3JoSbKQRvtn0H2B0iG02myE1
         q9SdyYIvycYyrp8GlJ6xkajMsLy7ugj50POpecTDlNgG3jwrglQNA/vDvHhUbDyHTo
         V9lJzxIN7Vt1mwaHp3khYey0+NDBjgAfqzry+s3g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKbkC-1nabZt18g8-00KzYW; Thu, 10
 Feb 2022 01:54:49 +0100
Message-ID: <672bb775-8771-3b29-5099-a631548cfae8@gmx.com>
Date:   Thu, 10 Feb 2022 08:54:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Chris Murphy <lists@colorremedies.com>,
        Tymoteusz Dolega <tymoteuszdolega@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAHF2GV6U32gmqSjLe=XKgfcZAmLCiH26cJ2OnHGp5x=VAH4OHQ@mail.gmail.com>
 <CAJCQCtQHZKm_mxNTaGWYD8VebMkGeX_12Ugz3f5c0BEiBROZvQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: MySQL corruption on BTRFS
In-Reply-To: <CAJCQCtQHZKm_mxNTaGWYD8VebMkGeX_12Ugz3f5c0BEiBROZvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lkPaW0t0byNKozbfvN1bveZGqfHPT76OMFtR3HVXVJzv/vfoX1/
 NYQrxx5cbZL8eeU15ux4TpwopbMTkWyuq8ejav742pFYriqaDJzkCNcmWT3Uqx9auHSkAl7
 TuX7Vy/XJ4FsSjMQvj54Cc2/nmLTkzF0FkhYPF6qq+Y7RhYS9yTpYzNrLa7blAdDrpDZ7RO
 4DLf81iBMD95lb55Stvzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TLaojV/u+cA=:7BjNknvgJ1jFaZ1yIIoErt
 8hNmkNCU6J4lraWhKsxdtqdOtYOG1rBJx7w88OlSjMfeDTdv918pOZ/GwD4HBC8Zbv2ChNmtG
 Q1WRk8kM7Lwc3rjH4G+mRsk2aMMxdFL/ECby8w2ZWbl1d6bzZBqIoKlWgpPkOPzKIlWlAqn2I
 xAap8S5QLw3K714cVRBrM0S6+9luHvMU8D5Zdi2W7E49yoMYta3gQx9n+027nQLocckRYoUjP
 jXRlRG8loqtUpaJ+vdHV+G9f5FQPndFYpA/PtYyX7dguOuK+26CZ8t6XXFd0KNogHJv2qYzt0
 kLvkZVIodcHW35pYh5NHqimaSbcLv8MwTF7Ll5/E8wAIkG09ouJH481RZLez+9RGLCwaYKrTP
 tyx36NazUbuW5hxM9inBuNY6syN0AINenNUccnuUFRraW4LaHIvFWgUT95nZHHBxdd4CWclHn
 jmkgDRegLHtV3oGWARNvl54P//3Op4GDfAYzWBHYZ1AGrwRk0d1rDdljYVbrnIm3yTl4PcW4A
 0rgCJp+WZwjdc7OW9d8Ydsy0KPiqL8k8+a2W8G7wqia++es3z3UN8oWDZAchk8IgMVnCEXFYK
 RucDqN/QzSnhk11+g0OUzXY95nwV6wYUA67rzp1MKCQly6vwrae19BHw9wCJyD4aVvWMl9j2d
 lEF7tUGZdcgGovd1Zmar4TYLa4NLzbmzzWFfmQv9P8Rh5AwXVh62qbg6tytsEuaEZxd/jVKx4
 ZL0k+Bl4EeEFw38BdbMsyJTFyY22o4zWY0en4yb+FYHjwSrTwgesgkxOy9rN6LZrZnd69Z71d
 yRxkDXGlWmm7EkCKEuJCtIcyOiVtHNySaTz4BIstZ8offansrvKcx2mtb/QPM1JGcfdBGhOMV
 fdeO2UAzDCv60gKzd8MVS9iarNPr6BZfV4LFUngsAsRjQBAjbBxmQO8rqkKjKrOPTMr4NPPU1
 i9/9L2MfgZEm6xqRIHID9/8lLRWKXy2RuGjBSQdmVfVJuYP8xX7+7KfqMhY/1C0In+Uw0JfI7
 myFxh64Q9H2JL4oV8IvxCrIfQr3+xdabnC4ACz+aVLIh4rek/OxIfBXnyRUIaIOA8nvGBNTHW
 10tpvtthLjdpBg=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/10 05:35, Chris Murphy wrote:
> On Tue, Feb 8, 2022 at 1:07 AM Tymoteusz Dolega
> <tymoteuszdolega@gmail.com> wrote:
>>
>> Hello,
>> I maybe encountered a bug. I'm using NixOS, and after enabling MySQL wi=
th:
>>
>> services.mysql =3D {
>>        enable =3D true;
>>        package =3D pkgs.mariadb;
>>   };
>>
>> it cannot even start, and fails with "code=3Dkilled, status=3D6/ABRT". =
The
>> problem that MySQL reports in journal is about file corruption. I
>> attached all logs at the bottom of this mail.
>> I tried changing database location to different BTRFS SSD, cleanly
>> formatted, and problem persists. After changing database location to
>> EXT4 partition, everything works perfectly. I tried newer MySQL
>> version (from nix-unstable), but still errors show up. Current version
>> is 10.6.5-MariaDB. I tried deleting DB folder to force it to make it
>> again. Scrub is clean, check (--readonly) is clean. I have only 1
>> mount option: "noatime". "mount" reports:
>> (rw,noatime,ssd,space_cache,subvolid=3D5,subvol=3D/).

I'm thinking if mariadb is setting NOCOW for its database files.

If that's the case, and a power loss happens, btrfs can not ensure the
atomicness of the file content.
(this relies on data COW and checksum, while NOCOW disables them all).

>>
>> uname -a
>> Linux desktop-nixos 5.16.4 #1-NixOS SMP PREEMPT Sat Jan 29 09:59:25
>> UTC 2022 x86_64 GNU/Linux
>>
>> btrfs --version
>> btrfs-progs v5.14.1
>>
>> sudo btrfs fi show
>> Label: 'nixos'  uuid: 67b6e734-cd1e-41e3-ab7a-63660e540014
>>          Total devices 1 FS bytes used 95.05GiB
>>          devid    1 size 249.00GiB used 98.03GiB path /dev/nvme0n1p5
>>
>> Label: 'cruc'  uuid: cc51fa3c-57db-42b6-a890-ff5cd7b18f47
>>          Total devices 1 FS bytes used 125.16MiB
>>          devid    1 size 931.51GiB used 2.02GiB path /dev/sdb1
>>
>> btrfs fi df /mnt/cruc
>> Data, single: total=3D1.01GiB, used=3D124.84MiB
>> System, single: total=3D4.00MiB, used=3D16.00KiB
>> Metadata, single: total=3D1.01GiB, used=3D304.00KiB
>> GlobalReserve, single: total=3D3.25MiB, used=3D0.00B
>>
>> dmesg.log  - https://www.dropbox.com/s/ou52m2hdjzmjy6b/dmesg.log?dl=3D0
>> but there is not much there besides you can see I cleanly formatted the=
 drive
>> mysql - https://www.dropbox.com/s/jjthkfu0anh8n2o/mysql.log?dl=3D0
>> log with info about corruption
>> (links hosted on dropbox, you can see them without logging in)
>> I will be happy to answer any needed questions.

Mind to locate the file "ibdata1" and provides the following output of it?

  # lsattr ./ibdata1

If it shows something like this:

  ---------------C------ /mnt/btrfs/file

It means it's a NOCOW file, and btrfs doesn't guarantee the correctness
of its content after power loss.
This is the same behavior of other filesystems, and it's on the database
itself to utilize things like write ahead log to ensure the correctness.

Thanks,
Qu
>
> Does this happen just on starting up mariadb for the first time? I'm
> wondering how to go about reproducing it on Fedora where I have
> mariadb 10.6.5, kernel 5.17-rc3. All I'm doing is systemctl start
> mariadb, and it starts up OK. Other than the kernel I'm wondering
> what's different about them.
>
>
